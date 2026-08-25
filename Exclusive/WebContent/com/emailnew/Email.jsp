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
<script src="../../js/ckeditor/ckeditor.js"></script>   
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
<%  
String trno=request.getParameter("trno")==null?"0":request.getParameter("trno");
String msgss=request.getParameter("msg")==null?"":request.getParameter("msg");
String sub=request.getParameter("subject")==null?"":request.getParameter("subject");
String client=request.getParameter("client")==null?"":request.getParameter("client");
String cldocno=request.getParameter("cldocno")==null?"0":request.getParameter("cldocno");
String docno=request.getParameter("docno")==null?"0":request.getParameter("docno");       
String brchid=request.getParameter("brchid")==null?"0":request.getParameter("brchid");
String userid=request.getParameter("userid")==null?"0":request.getParameter("userid");         
String formcode=request.getParameter("formcode")==null?"NA":request.getParameter("formcode");
String formcodess=request.getParameter("dtype")==null?"NA":request.getParameter("dtype");  
String mailid=request.getParameter("recipient");  
String code=request.getParameter("code"); 
String CC=request.getParameter("cc")==null?"":request.getParameter("cc");
%>

<script>    
var msgs='<%=msgss%>';
var client='<%=client%>';
var cldocno='<%=cldocno%>';   
var mailid='<%=mailid%>';
var docno='<%=docno%>';
var brchid='<%=brchid%>';
var dtypes='<%=formcodess%>';   
var formcode="";
var code="";
var cc='<%=CC%>';

$(document).ready(function() {
	   CKEDITOR.instances['message'].setData(msgs);     
	   $('#ccaddressWindow').jqxWindow({width: '68%', height: '50%',  maxHeight: '80%' ,maxWidth: '71%' , title: 'Address Book',position: { x: 150, y: 87 } , theme: 'energyblue', showCloseButton: true});
	   $('#ccaddressWindow').jqxWindow('close');
	   
	   $('#dtypeinfowindow').jqxWindow({ width: '20%', height: '35%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Doc type Search' , position: { x: 150, y:87 }, keyboardCloseKey: 27});
	   $('#dtypeinfowindow').jqxWindow('close'); 
	   
		   formcode='<%=formcode%>';
		   code='<%=code%>';
		   
	       getMailservDet(); 
	       
});          
  function getAddressBook(event){
	//alert("getUname");
    var x= event.keyCode;
    if(x==114){
	     addressBookContent('emailMainSearch.jsp?value='+0+'&cldocno='+cldocno);    
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
    	ccaddressBookContent('emailMainSearch.jsp?value='+1+'&cldocno='+cldocno);
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
    	bccaddressBookContent('emailMainSearch.jsp?value='+2+'&cldocno='+cldocno);
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
        	
        	//alert("formcode="+formcode);
        	if((!(formcode==""))&&(!(formcode=="NA")))
        		{
        document.getElementById("recipient").value ='<%=mailid%>';
        document.getElementById("subject").value ='<%=sub%>';
        document.getElementById("CC").value =email;
        document.getElementById("CC").value =document.getElementById("CC").value +";"+'<%=CC%>';
        	//searchmsg(formcode)	;
        		}
        }
	else
		{
		}
}
x.open("GET","<%=contextPath%>/com/emailnew/getMailservDet.jsp",true);
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
	funUrlss();   
	//alert("in send");
	 document.getElementById("userid").value ='<%=userid%>';
	 document.getElementById("brchid").value ='<%=brchid%>';  
	 document.getElementById("formcode").value ='<%=formcodess%>';
	 document.getElementById("reformcode").value ='<%=formcode%>';         
	 document.getElementById("docno").value ='<%=docno%>'; 
	 document.getElementById("trno").value ='<%=trno%>';    
	var withoutencodedata=CKEDITOR.instances.message.document.getBody().getHtml();
	var textdata=encodeURIComponent(withoutencodedata);  
	document.getElementById("txtmsg").value=withoutencodedata;
	document.getElementById("mode").value="SEND";                 
    document.getElementById("frmSendEmail").submit();
}

function searchmsg(formcode)
{
var x=new XMLHttpRequest();
var msg,subject;
x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
        items= x.responseText;
        items=items.split('****');
        msg=items[0];
        subject=items[1];
	    var sum2 = msg.toString().replace(/\###/g, ' \n');    
		  //  var sum2 = values.toString().replace(/\./g, '\n');
        	$("#subject").val(subject); 	
        	$("#message").val(sum2);
        /* 	$("#signature").val(signature);
        	$("#userName").val(email);
        	$("#password").val(pass); */
        	//sendmail();
        }
	else
		{
		}                     
}
x.open("POST","<%=contextPath%>/com/common/msgEmail.jsp?formcode="+formcode+'&code='+code,true);
x.send();
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
function reload(){
	 //alert(docno+"==="+dtypes+"==="+brchid);    
	 $("#attachs").load("Attachgridmaster.jsp?docno="+docno+"&formc="+dtypes+"&brchid="+brchid);  
}
function  funUrlss(){
	var rows = $("#jqxAttach").jqxGrid('getrows');    
	var selectedrows=$("#jqxAttach").jqxGrid('selectedrowindexes');
	selectedrows = selectedrows.sort(function(a,b){return a - b});          
            var i=0;var temptrno="",temptrno1="";                               
		    var j=0;
		    for (i = 0; i < rows.length; i++) {    
			  
					if(selectedrows[j]==i){     
						if(i==0){          
							var url= $('#jqxAttach').jqxGrid('getcellvalue', i, "path").replace( /;/g, "/");
	                        temptrno=url;
						}    
						else{                         
							var url= $('#jqxAttach').jqxGrid('getcellvalue', i, "path").replace( /;/g, "/");  
						    temptrno=temptrno+","+url;
						}
						temptrno1=temptrno+",";
				     j++;          
				  }
		        }
		    $('#texturl').val(temptrno1);
		   }
     function setValues(){    
			   if($("#msg").val()=="E-Mail Send Successfully" || $("#msg").val()=="E-Mail Sending failed"){
					 $.messager.alert('Message',$('#msg').val());      
					  setTimeout(function() {
						 window.close();
						 }, 4000);    
			      }
			   
		   }  
</script>

</head>
<body onload="reload();setValues();">          
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmSendEmail" action="SendEmailNew" method="post" autocomplete="off" >

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
    <td width="84%"><input type="text" id="recipient" name="recipient" style="width:84%;height:15px;" placeholder="Press F3 for Address Book" value='<s:property value="recipient"/>' onkeydown="getAddressBook(event);"/></td>
    
<%--     <td width="4%"><button type="button" class="icon" id="btnAttach" title="Attachment" >
							<img alt="Attachment" src="<%=contextPath%>/icons/attachment_new.png">
						</button></td>          
						<td align="right"><input type="file" id="file" name="file" /></td> --%>
  </tr>
  <tr>
    <td><b>Cc:</b></td>
    <td><input type="text" id="CC" name="CC" style="width:84%;height:15px;" value='<s:property value="CC"/>' placeholder="Press F3 for Address Book" onkeydown="getccAddressBook(event);"/></td>
    <%-- <td><button class="icon" id="btnSignature" title="Signature">
							<img alt="Signature" src="<%=contextPath%>/icons/signature_new.png">
						</button></td> --%>          
						 <td width="15%" align="center"><input type="checkbox" hidden="true" id="chck_sign" name="chck_sign" onchange="funcsign();" ></td>        
						<!-- <td align="left"><b>Signature</b></td> -->   
  </tr>  
  <tr> 
    <td><b>Bcc:</b></td>
    <td colspan="2"><input type="text" id="BCC" name="BCC" style="width:84%;height:15px;" placeholder="Press F3 for Address Book" value='<s:property value="BCC"/>' onkeydown="getbccAddressBook(event);"/></td>
  </tr>
  <tr>
    <td><b>Subject:</b></td>
    <td colspan="2"><input type="text" id="subject" name="subject" style="width:84%;height:15px;" value='<s:property value="subject"/>'/></td>
  </tr>   
  <tr>       
    <td colspan="4"><textarea id="message"  style="height:100px;width:135%;font: 10px Tahoma;resize:none" name="message"><s:property value="message"></s:property></textarea></td>
  </tr>
</table>
<table width="100%"  >
  <tr>
   <td width="100%" ><div id="attachs">  <jsp:include page="Attachgridmaster.jsp"></jsp:include></div></td>
  </tr></table>  
</fieldset>  
<input type="hidden"  id="trno" name="trno"  value='<s:property value="trno"/>'/>                  
<input type="hidden"  id="docno" name="docno"  value='<s:property value="docno"/>'/>
<input type="hidden"  id="userid" name="userid"  value='<s:property value="userid"/>'/>
<input type="hidden"  id="brchid" name="brchid"  value='<s:property value="brchid"/>'/>
<input type="hidden"  id="formcode" name="formcode"  value='<s:property value="formcode"/>'/>
<input type="hidden"  id="reformcode" name="reformcode"  value='<s:property value="reformcode"/>'/>
<input type="hidden"  id="msg" name="msg"  value='<s:property value="msg"/>'/>  
<input type="hidden"  id="mode" name="mode"  value='<s:property value="mode"/>'/>          
<input type="hidden"  id="txtmsg" name="txtmsg"  value='<s:property value="txtmsg"/>'/>
<input type="hidden"  id="texturl" name="texturl"  value='<s:property value="texturl"/>'/>   
<input type="hidden"  id="host" name="host"  value='<s:property value="host"/>'/>
<input type="hidden"  id="port" name="port"  value='<s:property value="port"/>'/>
<input type="hidden"  id="userName" name="userName"  value='<s:property value="userName"/>'/>
<input type="hidden"  id="password" name="password"  value='<s:property value="password"/>'/>
<input type="hidden"  id="signature" name="signature"  value='<s:property value="signature"/>'/>
<input type="hidden"  id="filename" name="filename"  value='<s:property value="filename"/>'/>
				<div id="ccaddressWindow"><div></div><div></div>          
				</div> 
				<div id="dtypeinfowindow"><div></div><div></div></div>
</form>	  
</div>
<script>
 CKEDITOR.replace( 'message' );
</script>
</body>
</html>

