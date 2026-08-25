<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<% String contextPath=request.getContextPath();%>
<% String userid=request.getParameter("userid");%>
<% String branchid=request.getParameter("branchid");

%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i)</title>

  <%-- <jsp:include page="../../includes.jsp"></jsp:include> --%>
  <script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>

<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
.cp {
  font-family: Tahoma;
 font-size: 15px;
}
</style>
<script type="text/javascript">
$(document).ready(function () { 
	checkUserpasswrd();
	  $('#rpassword').on('keyup', function () {
		  $('#message1').html('');
  	    if ($(this).val() == $('#npassword').val()) {
  	    	//alert("in");
  	        $('#message1').html('Matching').css('color', 'green');
  	    } else $('#message1').html('Not Matching').css('color', 'red');
  	});
	   
	  $('#cpassword').on('keyup', function () {
		  $('#message').html('');
		  	    if ($(this).val() == $('#hidcpassword').val()) {
		  	    	//alert("in");
		  	        $('#message').html('Matching').css('color', 'green');
		  	    } else $('#message').html('Not Matching').css('color', 'red');
		  	});
			        
	  
	  });



$(function(){
    $('#frmpasschange').validate({
             rules: {
            	 cpassword:{
                	 required:true
                 },
                 rpassword:{
                	 required:true
                 },
               
                 npassword:{
                	 required:true
	                 },
	            
            
             },
             messages: {
            	 cpassword:{
            		 required:" *required"
                 },
                 rpassword:{
                	 required:"*required"
                 },
              
                 npassword:{
                	  required:" *required"
                  },
                
             }
    });
    });


function checkUserpasswrd() {
	
	  var userid='<%=userid%>';
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();
			var cpasswrd=items;
				 				 		
		 			document.getElementById("hidcpassword").value=cpasswrd;
		 			document.getElementById("userid").value='<%=userid%>';
		 }
	       else
		  {
	    	   
		  }
			
			
		
	}
	x.open("GET", "<%=contextPath%>/com/common/checkUserPasswrd.jsp?userid="+userid, true);
	x.send();
}

function validate(){
	
	if($('#cpassword').val()==""){
		$('#message').html('Required*').css('color', 'red');
		return 0;
	}
	
	if($('#npassword').val()==""){
		$('#message2').html('Required*').css('color', 'red');
		return 0;
	}
	
	if($('#rpassword').val()==""){
		$('#message1').html('Required*').css('color', 'red');
		return 0;
	}
	
	if($('#hidcpassword').val()!= $('#cpassword').val()){
		$('#message').html('Your password is not correct').css('color', 'red');
		return 0;
	}
	
	if($('#rpassword').val()!= $('#npassword').val()){
		$('#message1').html('Your password is not matching').css('color', 'red');
		return 0;
	}
	
	if($('#cpassword').val()== $('#rpassword').val()){
		$('#message1').html('Old password and New passowrd cant be same').css('color', 'red');
		return 0;
	}
	save();
	
}

function ChangePass(){
	validate();
	
}
function save()  
{  
 	//alert($("#rpassword").val());
    $.ajaxFileUpload  
    (  
        {  
            url:'passChange.action?userid='+$("#userid").val()+'&password='+$("#rpassword").val() ,
            secureuri:false,//false  
            fileElementId:'file',//id  <input type="file" id="file" name="file" />  
            dataType: 'String',// json  
            success: function (data, status)  //  
            {  
                
               if(status=='success'){
    
                   $.messager.show({title:'Message',msg:'Password Change Succesfully',showType:'show',
                      style:{left:27,right:'',top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                  }); 
                   
               		$.messager.confirm('Confirm', 'Please LogOut and Login Again', function(result){
               			if (result){
               				location.href='logout';
               			 }
               			else{
               				resetdata();
               			}
               		   });
             
                   
                }
               
 
                if(typeof(data.error) != 'undefined')  
                {  
                    if(data.error != '')  
                    {  
                        //$.messager.alert('Message',data.error);
                        $.messager.show({title:'Message',msg: data.error,showType:'show',
                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                        }); 
                    }else  
                    {  
                        //$.messager.alert('Message',data.message);
                        $.messager.show({title:'Message',msg: data.message,showType:'show',
	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
	                        }); 
                    }  
                }  
            },  
            error: function (data, status, e)//  
            {  
                //alert(e);  
                $.messager.alert('Message',e);
            }  
        }  
    )  
    return false;  
}
function resetdata(){
	$("#rpassword").val()=="";
	$("#npassword").val()=="";
	$("#cpassword").val()=="";
}
</script>
</head>
<body>
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmpasschange" action="passchange" method="post" autocomplete="off" >

<div  id='search'>
<fieldset>
<table width="100%">
  <tr>
    <%-- <td width="95%" height="40" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="<%=contextPath+"/"%>icons/techsupport.png" style="width: 30%; height:55px;"></td> --%>
   <td width="95%" height="80" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Change Password</b></td>
  </tr>
  <tr>
    <td colspan="2">
<table width="100%" >
  <tr>
    <td width="40%" align="center"><label class="cp">Current Password&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</label></td>
    <td width="60%" colspan="2" align="left"><input type="password" name="cpassword" id="cpassword">
    <span STYLE="font-weight: bold;font-size: 9px;" id='message'></span>
    <input type="hidden"  id="hidcpassword">
    <input type="hidden"  id="userid"></td>
  </tr>
  <tr>
    <td width="40%" align="center"><label class="cp">New Password&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</label></td>
    <td width="60%" colspan="2" align="left"><input type="password" name="npassword" id="npassword">
    <span STYLE="font-weight: bold;font-size: 9px;" id='message2'></span>
    <input type="hidden"  id="hidcpassword">
    <input type="hidden"  id="userid"></td>
  </tr>
  <tr>
    <td width="40%" align="center"><label class="cp">Retype Password&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</label></td>
    <td width="60%" colspan="2"  align="left"><input type="password" name="rpassword" id="rpassword">
    <span STYLE="font-weight: bold;font-size: 9px;" id='message1'></span>
    <input type="hidden"  id="hidcpassword">
    <input type="hidden"  id="userid"></td>
  </tr>
</table>
 </td>
  </tr>
  <tr>
    <td colspan="2" align="center"><button class="myButton" type="button" id="btnSave" name="btnSave" onClick="ChangePass()">Save</button></td>
  </tr>
</table>
</fieldset>
</div>
</form>	
</div>
</body>
</html>