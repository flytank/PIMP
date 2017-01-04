package core.web;

import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

/**

 */
public class AntiSQLFilter implements Filter {

	private static final String INIT_PARAM_LOGGING = "logging";
	private static final String INIT_PARAM_BEHAVIOR = "behavior";
	private static final String INIT_PARAM_FORWARDTO = "forwardTo";

	private static final String BEHAVIOR_PROTECT = "protect";
	private static final String BEHAVIOR_THROW = "throw";
	private static final String BEHAVIOR_FORWARD = "forward";

	private static String[] keyWords = { "exec", "select", "update", "delete", "insert", "alter", "drop", "create",
			"shutdown" };
	// private static String[] keyWords = { ";", "\"", "\'", "/*", "*/", "--",
	// "exec", "select", "update", "delete",
	// "insert", "alter", "drop", "create", "shutdown" };

	private static long attempts = 0;

	private FilterConfig filterConfig;

	public void init(FilterConfig filterConfig) throws ServletException {
		this.filterConfig = filterConfig;
	}

	public void doFilter(ServletRequest req, ServletResponse resp, FilterChain filterChain)
			throws IOException, ServletException {

		HttpServletRequest originalRequest = (HttpServletRequest) req;

		if (isUnsafe(originalRequest.getParameterMap()) && originalRequest.getRequestURI().indexOf("sql") == -1) {
			String pLogging = filterConfig.getInitParameter(INIT_PARAM_LOGGING);
			if (pLogging != null && pLogging.equalsIgnoreCase("true")) {
				StringBuffer sb = new StringBuffer();
				sb.append("\nPossible SQL injection attempt #" + (++attempts) + " at " + new java.util.Date());
				sb.append("\nRemote Address: " + originalRequest.getRemoteAddr());
				sb.append("\nRemote User: " + originalRequest.getRemoteUser());
				sb.append("\nSession Id: " + originalRequest.getRequestedSessionId());
				sb.append("\nURI: " + originalRequest.getContextPath() + originalRequest.getRequestURI());
				sb.append("\nParameters via " + originalRequest.getMethod());
				Map paramMap = originalRequest.getParameterMap();
				for (Iterator iter = paramMap.keySet().iterator(); iter.hasNext();) {
					String paramName = (String) iter.next();
					String[] paramValues = originalRequest.getParameterValues(paramName);
					sb.append("\n\t" + paramName + " = ");
					for (int j = 0; j < paramValues.length; j++) {
						sb.append(paramValues[j]);
						if (j < paramValues.length - 1) {
							sb.append(" , ");
						}
					}
				}
				filterConfig.getServletContext().log(sb.toString());
			}

			String behavior = filterConfig.getInitParameter(INIT_PARAM_BEHAVIOR);
			String forwardTo = filterConfig.getInitParameter(INIT_PARAM_FORWARDTO);
			if (behavior == null || behavior.equalsIgnoreCase(BEHAVIOR_PROTECT)) {
				HttpServletRequest wrapper = new AntiSQLRequest(originalRequest);
				filterChain.doFilter(wrapper, resp);
			} else if (behavior.equalsIgnoreCase(BEHAVIOR_FORWARD) && forwardTo != null) {
				req.getRequestDispatcher(forwardTo).forward(req, resp);
			} else {
				throw new ServletException("SQL Injection Attempt");
			}
		} else {
			filterChain.doFilter(req, resp);
		}

	}

	public void destroy() {
	}

	static boolean isUnsafe(Map parameterMap) {
		Map newMap = new HashMap();
		Iterator iter = parameterMap.keySet().iterator();
		while (iter.hasNext()) {
			String key = (String) iter.next();
			String[] param = (String[]) parameterMap.get(key);
			for (int i = 0; i < param.length; i++) {
				if (isUnsafe(param[i]))
					return true;
			}
		}
		return false;
	}

	static boolean isUnsafe(String value) {
		String lowerCase = value.toLowerCase();
		for (int i = 0; i < keyWords.length; i++) {
			if (lowerCase.indexOf(keyWords[i]) >= 0) {
				return true;
			}
		}
		return false;
	}

	static Map getSafeParameterMap(Map parameterMap) {
		Map newMap = new HashMap();
		Iterator iter = parameterMap.keySet().iterator();
		while (iter.hasNext()) {
			String key = (String) iter.next();
			String[] oldValues = (String[]) parameterMap.get(key);
			String[] newValues = new String[oldValues.length];
			for (int i = 0; i < oldValues.length; i++) {
				newValues[i] = getSafeValue(oldValues[i]);
			}
			newMap.put(key, newValues);
		}
		return Collections.unmodifiableMap(newMap);
	}

	static String getSafeValue(String oldValue) {
		StringBuffer sb = new StringBuffer(oldValue);
		String lowerCase = oldValue.toLowerCase();
		for (int i = 0; i < keyWords.length; i++) {
			int x = -1;
			while ((x = lowerCase.indexOf(keyWords[i])) >= 0) {
				if (keyWords[i].length() == 1) {
					sb.replace(x, x + 1, " ");
					lowerCase = sb.toString().toLowerCase();
					continue;
				}
				sb.deleteCharAt(x + 1);
				lowerCase = sb.toString().toLowerCase();
			}
		}
		return sb.toString();
	}

}
