<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../includes.jsp"></jsp:include>
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">

<style type="text/css">

.box{
 /*  margin: 100px auto; */
  width: 100%;
  height: 20px;
}

.container-1 input#search{
	  width: 100%;
	  height: 30px;
	  background: #2b303b;
	  border: none;
	  font-size: 10pt;
	  float: left;
	  color: #262626;
	  padding-left: 45px; 
	  -webkit-border-radius: 5px;
	  -moz-border-radius: 5px;
	  border-radius: 5px;
   
      -webkit-transition: background .55s ease;
      -moz-transition: background .55s ease;
      -ms-transition: background .55s ease;
      -o-transition: background .55s ease;
      transition: background .55s ease;
}

.container-1 input#search:hover, .container-1 input#search:focus, .container-1 input#search:active{
    outline:none;
    background: #ffffff;
  }
  
  .container-1 input#search::-webkit-input-placeholder {
   color: #65737e;
}
 
.container-1 input#search:-moz-placeholder { /* Firefox 18- */
   color: #65737e;  
}
 
.container-1 input#search::-moz-placeholder {  /* Firefox 19+ */
   color: #65737e;  
}
 
.container-1 input#search:-ms-input-placeholder {  
   color: #65737e;  
}


.container-1 .icon{
  position: absolute;
  top: 0%;
  margin-left: 17px;
  margin-top: 17px;
  z-index: 1;
  color: #4f5b66;
}

</style>
<script> 
$(document).ready(function() {
	
	   
	    $('#userinfowindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'User Search' , position: { x: 100, y:87 }, keyboardCloseKey: 27});
		  $('#userinfowindow').jqxWindow('close'); 
	
		  getMsgCount();
		
	
});


function getuser(event){
  	
	 var x= event.keyCode;
	    if(x==114){
	  $('#userinfowindow').jqxWindow('open');
	  $('#userinfowindow').jqxWindow('bringToFront'); 
 // $('#accountWindow').jqxWindow('focus');
        userSearchContent('usersearch.jsp'); 
     	 }
else{
	
}
}
function userSearchContent(url) {
	 
	 $.get(url).done(function (data) {
			 
	$('#userinfowindow').jqxWindow('setContent', data);

            	}); 
  	} 
  	
  	

function sendMsg(){
	
	var user=document.getElementById("txtuser").value;
	var usertoid=document.getElementById("usertoid").value;
	var msg=document.getElementById("txtmsgenter").value;
	
	
	if(user==""){
		document.getElementById("errormsg").innerText="Select a User to chat";
		return 0;
	}
	
	if(msg==""){
		document.getElementById("errormsg").innerText="Enter Message..";
		return 0;
	}
	
	//alert(date);
	  var x = new XMLHttpRequest();
	  x.onreadystatechange = function() {
	   if (x.readyState == 4 && x.status == 200) {
	    var item=x.responseText.trim();
	    
	    if(item>0)
    	{
    	//document.getElementById("errormsg").innerText="Added Successfully";
    	getMsgHistory();
    	document.getElementById("txtmsgenter").value="";
    	
			return  true;
    	}
    
    else
	 {
	
	$.messager.alert('Message',"Failed");
	return  false;
	 }
	    
	   } else {
	   }
	  }
	  x.open("GET","msginsert.jsp?usertoid="+usertoid+"&msg="+msg, true);
	  x.send();  
	 }
	 
	 
function sendMsgenter(event){
	
	var user=document.getElementById("txtuser").value;
	var usertoid=document.getElementById("usertoid").value;
	var msg=document.getElementById("txtmsgenter").value;
	var x= event.keyCode;
    if(x==13){
	
	if(user==""){
		document.getElementById("errormsg").innerText="Select a User to chat";
		return 0;
	}
	
	if(msg==""){
		document.getElementById("errormsg").innerText="Enter Message..";
		return 0;
	}
	
	//alert(date);
	  var x = new XMLHttpRequest();
	  x.onreadystatechange = function() {
	   if (x.readyState == 4 && x.status == 200) {
	    var item=x.responseText.trim();
	    
	    if(item>0)
    	{
    	//document.getElementById("errormsg").innerText="Added Successfully";
    	getMsgHistory();
    	document.getElementById("txtmsgenter").value="";
    	
			return  true;
    	}
    
    else
	 {
	
	$.messager.alert('Message',"Failed");
	return  false;
	 }
	    
	   } else {
	   }
	  }
	  x.open("GET","msginsert.jsp?usertoid="+usertoid+"&msg="+msg, true);
	  x.send();  
	 }
}
  	

function getMsgHistory()
{
	var usertoid=document.getElementById("usertoid").value;
	
	if(usertoid==""){
		return 0;
	}
	
	var x=new XMLHttpRequest();
	
	x.onreadystatechange=function(){
		
		if (x.readyState==4 && x.status==200)
			{
			
				items= x.responseText;
			
				//alert("==items==="+items.trim().length);
				
				if(items.trim().length>0){
					
					document.getElementById('txtmsgsended').style.fontWeight = "bold";
				    $("#msghis").load(document.getElementById("txtmsgsended").value=items);
				}
				 else{
					//$("#msghis").load(document.getElementById("txtmsgsended").value="");
					 document.getElementById("txtmsgsended").value="";
				} 
					
				
				
			    
			}
		else
			{
			}
	}
	x.open("GET","getMsgHistory.jsp?usertoid="+usertoid,true);
	x.send();
}

function getMsgCount()
{
	
	
	var x=new XMLHttpRequest();
	var msgcnt;
	var user;
	x.onreadystatechange=function(){
		
		if (x.readyState==4 && x.status==200)
			{
			
				items= x.responseText;
			
				items=items.split('####');
				user=items[0];
				msgcnt=items[1];
					if(msgcnt>0){
						
						$.messager.show({title:'Message',msg:'You have '+msgcnt+' new messages from '+user+'',showType:'show',
		                    style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
		                });
						
						
					}
				
			    
			}
		else
			{
			}
	}
	x.open("GET","getMsgCount.jsp",true);
	x.send();
}

window.setInterval(function(){
	
	getMsgHistory();
    }, 500); 

</script>

<body>
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmChat" action="saveChat" method="post" autocomplete="off">

<div  class='hidden-scrollbar'>

<table width="100%">
</br></br>
  <tr>
    <td height="25" colspan="2">
    <%-- <div class="box"><div class="container-1"><span class="icon"><i class="fa fa-search"></i></span>
      <input type="search" id="search" placeholder="Search..." />
    </div>
   </div> --%>
    <input type="text" id="txtuser" name="txtuser" style="width:100%;height:20px;" placeholder="User Search" onkeydown="getuser(event);" readonly="true" value='<s:property value="txtuser"/>' /></td>
  </tr>
 <div id="msghis"> <tr>
    <td colspan="2"><textarea id="txtmsgsended" style="height:350px;width:100%;font: 10px Tahoma;resize:none"  name="txtmsgsended" readonly="readonly"><s:property value="txtmsgsended" ></s:property></textarea></td>
  </tr></div>
  <tr>
    <td width="80%"><textarea id="txtmsgenter" style="height:60px;width:100%;font: 10px Tahoma;resize:none" onkeydown="sendMsgenter(event);" placeholder="Enter message..." name="txtmsgenter"><s:property value="txtmsgenter" ></s:property></textarea></td>
    <!-- <tr><td width="20%" align="center"><button class="myButton" type="button" id="btnSend" name="btnSend" onClick="sendMsg()">Send</button></td></tr> -->
  </tr>
</table>

</div>
 <input type="hidden" id="usertoid" name="usertoid"  value='<s:property value="usertoid"/>'/></td>
<div id="userinfowindow"><div></div><div></div></div>
</form>
</div>
</body>
</html>