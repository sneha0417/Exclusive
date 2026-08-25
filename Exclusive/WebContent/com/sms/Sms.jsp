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
	
	
	  $('#addressWindow').jqxWindow({width: '40%', height: '52%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Address Book',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
	   $('#addressWindow').jqxWindow('close');
	   
	   $('#ccaddressWindow').jqxWindow({width: '50%', height: '68%',  maxHeight: '70%' ,maxWidth: '71%' , title: 'Address Book',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
	   $('#ccaddressWindow').jqxWindow('close');
	
	getSmsservDet();
		
	
});


  function getAddressBook(event){
	//alert("getUname");
    var x= event.keyCode;
    if(x==114){
	     addressBookContent('addressbook.jsp');
    }
    else{
     }
    }
    
function addressBookContent(url) {
	//alert("unameSearchContent");
	  $('#addressWindow').jqxWindow('open');
	  $('#addressWindow').jqxWindow('bringToFront'); 
		 $.get(url).done(function (data) {
			 //alert(data);
		$('#addressWindow').jqxWindow('setContent', data);
	}); 
	} 
	
function getccAddressBook(event){
	//alert("getccAddressBook");
    var x= event.keyCode;
    if(x==114){
    	ccaddressBookContent('ccaddressGrid.jsp?type=0');
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
    	bccaddressBookContent('ccaddressGrid.jsp?type=1');
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
 

function getSmsservDet()
{
	//alert("ghjjhgfvghjhvgh");
var x=new XMLHttpRequest();
var items,smtphost,smtpport,signature;
x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
        items= x.responseText;
        items=items.split('####');
        smtphost=items[0];
        smtpport=items[1];
        signature=items[2];
        	$("#host").val(smtphost); 	
        	$("#port").val(smtpport);
        	$("#signature").val(signature);
        	
        }
	else
		{
		}
}
x.open("GET","<%=contextPath%>/com/sms/getSmsservDet.jsp",true);
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
<form id="frmSendSms" action="doSendSms" method="post" autocomplete="off" >

<div  class='hidden-scrollbar'>
<div  id='search'>
<fieldset>
<table width="99%">
<tr>
    <td colspan="3" align="center" style="font-size: 18px; font-family: Verdana;"><b> SMS</b></br></br><!-- </br></td> -->
  </tr>

  <tr>
    <td width="6%" rowspan="4"><button class="emailsend" type="button" id="btnSendSms" title="Send Sms" onclick="return sendsms();">
							<img alt="Send SMS" src="<%=contextPath%>/icons/smssend_new.jpg">
						</button><center><b></b></center></td>
    <td width="22%">
      <b>Mobile Number:</b>
    <td width="72%"><input type="text" id="recipient" name="recipient" style="width:80%;height:20px;" placeholder="Mobile Number with country code" value='<s:property value="recipient"/>' onkeydown="getAddressBook(event);"/></td>
    
   </tr>
  <!-- <a href="mailto:gwsupport@gatewayerp.com" style="color:#0053cf;">contact</a> -->
  <tr>
    <td colspan="2"><textarea id="message" style="height:90px;width:100%;font: 10px Tahoma;resize:none" placeholder="Type your message here" name="message"><s:property value="message"></s:property></textarea></td>
  </tr>
</table>
</br></br>
</fieldset>
<input type="hidden"  id="host" name="host"  value='<s:property value="host"/>'/>
<input type="hidden"  id="port" name="port"  value='<s:property value="port"/>'/>
<input type="hidden"  id="signature" name="signature"  value='<s:property value="signature"/>'/>
<input type="hidden" id="filename" name="filename"  value='<s:property value="filename"/>'/>
  <div id="addressWindow"><div></div><div></div>
				</div>
				<div id="ccaddressWindow"><div></div><div></div>
				</div> 
</div>
</form>	
</div>
</body>
</html>

