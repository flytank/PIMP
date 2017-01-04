package core.support;

import java.util.List;

/**

 */
public class JqGridPageView<E> {

	/** list data * */
	private List<E> rows;
	/** total page * */
	private long total = 1;
	/** count per page * */
	private int maxResults = 12;
	/** current page * */
	private int currentPage = 0;
	/** total record qty * */
	private long records;

	public JqGridPageView() {

	}

	public JqGridPageView(int maxResults, int currentPage) {
		this.maxResults = maxResults;
		this.currentPage = currentPage;
	}

	public void setQueryResult(QueryResult<E> qr) {
		setRows(qr.getResultList());
		setRecords(qr.getTotalCount());
	}

	public long getRecords() {
		return records;
	}

	public void setRecords(long records) {
		this.records = records;
		setTotal(this.records % this.maxResults == 0 ? this.records / this.maxResults
				: this.records / this.maxResults + 1);
	}

	public List<E> getRows() {
		return rows;
	}

	public void setRows(List<E> rows) {
		this.rows = rows;
	}

	public long getTotal() {
		return total;
	}

	public void setTotal(long total) {
		this.total = total;
	}

	public int getMaxResults() {
		return maxResults;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public int getFirstResult() {
		return (this.currentPage - 1) * this.maxResults;
	}

	public void setMaxResults(int maxResults) {
		this.maxResults = maxResults;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

}
