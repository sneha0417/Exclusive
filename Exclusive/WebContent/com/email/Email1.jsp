<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();
System.out.println("=contextPath==="+contextPath);%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>

  <jsp:include page="../../includes.jsp"></jsp:include>
  <script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>

<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}

.icon {
	width: 2.5em;
	height: 2em;
	border: none;
	background-color: #E0ECF8;
}
.emailsend {
	width: 4.5em;
	height: 3em;
	border: none;
	background-color: #E0ECF8;
}
</style>

<script>

$(document).ready(function() {
	
	
	  $('#addressWindow').jqxWindow({width: '70%', height: '70%',  maxHeight: '70%' ,maxWidth: '71%' , title: 'Address Book',position: { x: 150, y:87 } , theme: 'energyblue', showCloseButton: true});
	   $('#addressWindow').jqxWindow('close');
	   
	   $('#ccaddressWindow').jqxWindow({width: '68%', height: '70%',  maxHeight: '80%' ,maxWidth: '71%' , title: 'Address Book',position: { x: 150, y: 87 } , theme: 'energyblue', showCloseButton: true});
	   $('#ccaddressWindow').jqxWindow('close');
	   
	    $('#dtypeinfowindow').jqxWindow({ width: '20%', height: '35%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Doc type Search' , position: { x: 150, y:87 }, keyboardCloseKey: 27});
		  $('#dtypeinfowindow').jqxWindow('close'); 
	
	getMailservDet();
		
	
});


  function getAddressBook(event){
	//alert("getUname");
    var x= event.keyCode;
    if(x==114){
	     addressBookContent('emailMainSearch.jsp?value=0');
    }
    else{
     }
    }
    
function addressBookContent(url) {
	//alert("unameSearchContent");
	  $('#ccaddressWindow').jqxWindow('open');
	  $('#ccaddressWindow').jqxWindow('bringToFront'); 
		 $.get(url).done(function (data) {
			 //alert(data);
		$('#ccaddressWindow').jqxWindow('setContent', data);
	}); 
	} 
	
function getccAddressBook(event){
	//alert("getccAddressBook");
    var x= event.keyCode;
    if(x==114){
    	ccaddressBookContent('emailMainSearch.jsp?value=1');
    }
    else{
     }
    }
    
 function ccaddressBookContent(url) {
	//alert("ccaddressBookContent");
	  $('#ccaddressWindow').jqxWindow('open');
	  $('#ccaddressWindow').jqxWindow('bringToFront'); 
		 $.get(url).done(function (data) {
			 //alert(data);
		$('#ccaddressWindow').jqxWindow('setContent', data);
	}); 
	}

function getbccAddressBook(event){
	//alert("getccAddressBook");
    var x= event.keyCode;
    if(x==114){
    	bccaddressBookContent('emailMainSearch.jsp?value=2');
    }
    else{
     }
    }
    
function bccaddressBookContent(url) {
	//alert("ccaddressBookContent");
	  $('#ccaddressWindow').jqxWindow('open');
	  $('#ccaddressWindow').jqxWindow('bringToFront'); 
		 $.get(url).done(function (data) {
			 //alert(data);
		$('#ccaddressWindow').jqxWindow('setContent', data);
	}); 
	} 
 

function getMailservDet()
{
	//alert("ghjjhgfvghjhvgh");
var x=new XMLHttpRequest();
var items,smtphost,smtpport,signature,email,pass;
x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
        items= x.responseText;
        items=items.split('####');
        smtphost=items[0];
        smtpport=items[1];
        signature=items[2];
        email=items[3];
        pass=items[4];
        	$("#host").val(smtphost); 	
        	$("#port").val(smtpport);
        	$("#signature").val(signature);
        	$("#userName").val(email);
        	$("#password").val(pass);
        	
        	
        }
	else
		{
		}
}
x.open("GET","<%=contextPath%>/com/email/getMailservDet.jsp",true);
x.send();
}

function funcsign(){
	
	if((document.getElementById("chck_sign").checked)){
		//alert("I will get back to you soon\nThanks and Regards\nSaurav Kumar");
		var txtarea=document.getElementById("message").value;
		var sign=document.getElementById("signature").value;
		//alert("===sign===="+sign);
		 /* var linebreak = document.createElement("br");
		 linebreak=linebreak+linebreak; */
		/* txtarea.appendChild(linebreak);
		txtarea.appendChild(sign);  */
		$("#chck_sign").attr("disabled", true);
		document.getElementById("message").value=txtarea+"\n\n\n"+sign;
		
	}
	if(!(document.getElementById("chck_sign").checked)){
		
		var txtarea=document.getElementById("message").value;
		var sign="";
		//alert("===sign===="+sign);
		 var linebreak = document.createElement("br");
		/* txtarea.appendChild(linebreak);
		txtarea.appendChild(sign);  */
		document.getElementById("message").value=txtarea+"\n"+sign;
		
	}
	
}

function send(){
	
	$.ajaxFileUpload
	  (  
	      {  
	    	  url: 'doSendEmail.action?recipient='+$("#recipient").val()+'&CC='+$("#CC").val()+'&BCC='+$("#BCC").val()+'&subject='+$("#subject").val()+'&message='+$("#message").val()+'&host='+$("#host").val()+'&port='+$("#port").val(),  
	          secureuri:false,//false  
	          fileElementId:'file',//id  <input type="file" id="file" name="file" />  
	          dataType: 'json',// json  
	          success: function (data, status)  //  
	          {  
	            
	             if(status=='success'){
	            	 $.messager.alert('Message',"E-Mail Send Successfully");
	            	 document.getElementById("message").value="";
	            	 document.getElementById("subject").value="";
	            	 document.getElementById("CC").value="";
	            	 document.getElementById("BCC").value="";
	            	 document.getElementById("recipient").value="";
	            	 document.getElementById("chck_sign").checked = false;
	            	 $("#chck_sign").attr("disabled", false);
	              }
	             if(status=='error'){
	            	 $.messager.alert('Message',"E-Mail Sending failed");
	             }
	             
	              $("#testImg").attr("src",data.message);
	              if(typeof(data.error) != 'undefined')  
	              {  
	                  if(data.error != '')  
	                  {  
	                      alert(data.error);  
	                  }else  
	                  {  
	                      alert(data.message);  
	                  }  
	              }  
	          },  
	          error: function (data, status, e)//  
	          {  
	              alert(e);  
	          }  
	      }  
	  ) 
	  return false;
}

function sendmail(){
	
	var subject=document.getElementById("subject").value;
	var msg=document.getElementById("message").value;
	var uname=document.getElementById("userName").value;
	var password=document.getElementById("password").value;
	var port=document.getElementById("port").value;
	var host=document.getElementById("host").value;
	
	if(uname==""|| password=="" || port=="" || host==""){
		
		$.messager.alert('Failed',"Please configure your email properties from user master!!");
		
		return 0;
	} 
	
	
	 if(subject==""){
		$.messager.confirm('Confirm', 'Send E-Mail with out subject?', function(r){
			if (r){
			  
			 
	/* if(msg==""){
		$.messager.confirm('Confirm', 'Send E-Mail with out message?', function(r){
			if (r){
			  
				send();
	  
			}
		   });
	}
	else{
		send();
	} */
	
	send();
			 }
			
		   });
	}
	else{
		send();
	} 
	 
	 

	
}

</script>

</head>
<body>
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmSendEmail" action="doSendEmail" method="post" autocomplete="off" >

<div  class='hidden-scrollbar'>
<div  id='search'>
<fieldset>
<table width="100%">
<tr>
    <td colspan="4" align="center" style="font-size: 18px; font-family: Verdana;"><b>E-mail Service</b></br></br><!-- </br></td> -->
  </tr>

  <tr>
    <td width="7%" rowspan="4"><button class="emailsend" type="button" id="btnSendEmail" title="Send Email" onclick="return sendmail();">
							<img alt="Send Email" src="<%=contextPath%>/icons/emailsend_new.png">
						</button><center><b>Send</b></center></td></br></br>
    <td width="5%"><b>To:</b></td>
    <td width="84%"><input type="text" id="recipient" name="recipient" style="width:84%;height:20px;" placeholder="Press F3 for Address Book" value='<s:property value="recipient"/>' onkeydown="getAddressBook(event);"/></td>
    
    <td width="4%"><button type="button" class="icon" id="btnAttach" title="Attachment" >
							<img alt="Attachment" src="<%=contextPath%>/icons/attachment_new.png">
						</button></td>
						<td align="right"><input type="file" id="file" name="file" /></td>
  </tr>
  <tr>
    <td><b>Cc:</b></td>
    <td><input type="text" id="CC" name="CC" style="width:84%;height:20px;" value='<s:property value="CC"/>' placeholder="Press F3 for Address Book" onkeydown="getccAddressBook(event);"/></td>
    <%-- <td><button class="icon" id="btnSignature" title="Signature">
							<img alt="Signature" src="<%=contextPath%>/icons/signature_new.png">
						</button></td> --%>
						<td width="15%" align="center"><input type="checkbox" id="chck_sign" name="chck_sign" onchange="funcsign();" ></td>
						<td align="left"><b>Signature</b></td>
  </tr>
  <tr>
    <td><b>Bcc:</b></td>
    <td colspan="2"><input type="text" id="BCC" name="BCC" style="width:78%;height:20px;" placeholder="Press F3 for Address Book" value='<s:property value="BCC"/>' onkeydown="getbccAddressBook(event);"/></td>
  </tr>
  <tr>
    <td><b>Subject:</b></td>
    <td colspan="2"><input type="text" id="subject" name="subject" style="width:78%;height:20px;" value='<s:property value="subject"/>'/></td>
  </tr>
  <tr>
    <td colspan="4"><textarea id="message" style="height:290px;width:138%;font: 10px Tahoma;resize:none" name="message"><s:property value="message"></s:property></textarea></td>
  </tr>
</table>
</br></br>
</fieldset>
<input type="hidden"  id="host" name="host"  value='<s:property value="host"/>'/>
<input type="hidden"  id="port" name="port"  value='<s:property value="port"/>'/>
<input type="hidden"  id="userName" name="userName"  value='<s:property value="userName"/>'/>
<input type="hidden"  id="password" name="password"  value='<s:property value="password"/>'/>
<input type="hidden"  id="signature" name="signature"  value='<s:property value="signature"/>'/>
<input type="hidden" id="filename" name="filename"  value='<s:property value="filename"/>'/>
  <div id="addressWindow"><div></div><div></div>
				</div>
  			
				<div id="ccaddressWindow"><div></div><div></div>
				</div> 
				<div id="dtypeinfowindow"><div></div><div></div></div>
</div>
</form>	
</div>
</body>
</html>

