// 自定义页面的提示信息.在引用该方法的页面必须引用jquery.gritter.js
function promptInfo (text, name, time, speed) {
	if (text == "") {
		return;
	}
	var classname = "";
	if (name == "") {
		return;
	} else {
		var arr = name.split(",");
		for (var int = 0; int < arr.length; int++) {
			var arrEle = arr[int];
			classname += " gritter-" + arrEle;
		}
		classname = classname.substring(1,classname.length);
	}
	if (!time) {
		time = 1000;
	}
	if (!speed) {
		speed = 1000;
	}
	$.gritter.add({
        title: "系统信息",
        text: text,
        time: time,
		speed: speed,
        class_name: classname
    });
}

function operateMsg(response, text) {
	if (response.responseText) {
		$.gritter.add({
	        title: "系统信息",
	        text: text + "成功",
	        time: 1000,
			speed: 1000,
	        class_name: "gritter-success gritter-center"
	    });
	} else {
		$.gritter.add({
	        title: "系统信息",
	        text: text + "失败",
	        time: 1000,
			speed: 1000,
	        class_name: "gritter-error gritter-center"
	    });
	}
	return [true, ""];
}