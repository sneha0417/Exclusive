<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();
System.out.println("session  value"+session.getMaxInactiveInterval());%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../includes.jsp"></jsp:include>


<script type="text/javascript">

$(document).ready(function() {
	
	   
/*     $('#userinfowindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'User Search' , position: { x: 100, y:87 }, keyboardCloseKey: 27});
	  $('#userinfowindow').jqxWindow('close'); 
 */
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

//var user=document.getElementById("txtuser").value;
var usertoid=document.getElementById("usertoid").value;
var msg=document.getElementById("txtmsgenter").value;


if(usertoid==""){
	$.messager.alert('Message',"Select a User to Text");
	return 0;
}

if(msg==""){
	$.messager.alert('Message',"type message to send");
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
<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
</style>

</head>
<body >
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmChat" action="saveChat" method="post" autocomplete="off">

<div  class='hidden-scrollbar'>
<fieldset>
<table width="100%">

<tr>
    <td colspan="3" align="center" style="font-size: 18px; font-family: Verdana;"><b>GATEWAY MESSENGER</b></br></br><!-- </br></td> -->
  </tr>
<tr>
<td width="20%">
  <div id="UserGrid"><jsp:include page="usersearch.jsp"></jsp:include></div>
</td>
<td width="70%">
<table width="100%">

<div id="msghis"><tr><td><textarea id="txtmsgsended" style="height:300px;width:100%;font: 10px Tahoma;resize:none"  name="txtmsgsended" readonly="readonly"><s:property value="txtmsgsended" ></s:property></textarea></td></tr></div>
 <tr>
    <td width="80%"><textarea id="txtmsgenter" style="height:80px;width:100%;font: 10px Tahoma;resize:none"  placeholder="Enter message..." name="txtmsgenter"><s:property value="txtmsgenter" ></s:property></textarea></td>
     <tr><td width="20%" align="center"><button class="myButton" type="button" id="btnSend" name="btnSend" onClick="sendMsg()">Send</button></td></tr><!-- onkeydown="sendMsgenter(event);" -->
  </tr>
</table>
</td></tr>
<input type="hidden" id="usertoid" name="usertoid"  value='<s:property value="usertoid"/>'/></td>
<tr>
 <td colspan="3">
  
</td> 
</tr>
</table>
</fieldset>

</div>
</form>
	
</div>
</body>
</html>
