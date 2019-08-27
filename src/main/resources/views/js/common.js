function getRootPath()   
    {   
     var pathName = window.location.pathname.substring(1);   
     var webName = pathName == '' ? '' : pathName.substring(0, pathName.indexOf('/'));   
     return window.location.protocol + '//' + window.location.host + '/'+ webName + '/';   
    }   
function isEmpty(value){
		return(value=='' || value==undefined || value==null ||value==0);
	}
	//提示弹窗
	function alertModalMessage(message){
		$('#dialogModal').modal('show');
		$('#message').html(message);
	};

	function dismiss(){
		$('.modal').modal('hide');
		$(".inputArea").val(null);
		hide(".alert-icon");
		
    };
	// 显示id的元素
	function show(id){
    	$(id).css("display","inline");
    }
	// 隐藏id的元素
    function hide(id){
    	$(id).css("display","none");
    }
    function keyPress() {    
        var keyCode = event.keyCode;    
        if ((keyCode >= 48 && keyCode <= 57))    
       {    
            event.returnValue = true;    
        } else {    
              event.returnValue = false;    
       }    
    }  