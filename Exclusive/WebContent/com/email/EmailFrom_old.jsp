<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();
System.out.println("==contextPath==contextPath=="+contextPath);%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
<%-- <jsp:include page="../../includes.jsp"></jsp:include> --%>

<style>
.branch {
	color: black;
	background-color: #E0ECF8;
	width: 100%;
	font-family: Tahoma;
	font-size: 10px;
}
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
</style>

<script>

$(document).ready(function() {
	
	getMailservDet();
	
	/* $('#btnsendemail').click(function(e) {
	 
		alert("alert"+$("#recipient").val());
		alert("CC"+$("#CC").val());
		alert("BCC"+$("#BCC").val());
		alert("FILE"+$("#file").val());
		
	     $.ajax({
	     url: 'doSendEmail.action?recipient='+$("#recipient").val()+'&CC='+$("#CC").val()+'&BCC='+$("#BCC").val()+'&subject='+$("#subject").val()+'&message='+$("#message").val()+'&file='+$("#file").val(),
	     //type: "post",
	     fileElementId:'file',
	     cache: false,
	     success: function() {
	     //$("#message").html(data).slideDown('slow');
	     }
	     });
	     }); */
	
	
	     $('#btnsendemail').click(function(e) {
	    	 
	    	  $.ajaxFileUpload  
	    	  (  
	    	      {  
	    	    	  url: 'doSendEmail.action?recipient='+$("#recipient").val()+'&CC='+$("#CC").val()+'&BCC='+$("#BCC").val()+'&subject='+$("#subject").val()+'&message='+$("#message").val(),  
	    	          secureuri:false,//false  
	    	          fileElementId:'file',//id  <input type="file" id="file" name="file" />  
	    	          dataType: 'json',// json  
	    	          success: function (data, status)  //  
	    	          {  
	    	            
	    	             if(status=='success'){
	    	             
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
	    	 
	    	 
	    	 
	     });
	
	
});


function getMailservDet()
{
	//alert("ghjjhgfvghjhvgh");
var x=new XMLHttpRequest();
var items,smtphost,smtpport;
x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
        items= x.responseText;
        items=items.split('####');
        smtphost=items[0];
        smtpport=items[1];
        	$("#host").val(smtphost); 	
        	$("#port").val(smtpport);
       
        }
	else
		{
		}
}
x.open("GET","<%=contextPath%>/com/email/getMailservDet.jsp",true);
x.send();
}


</script>


</head><!-- autocomplete="off",onload="getMailservDet();" -->
<body >
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmSendEmail" action="doSendEmail" method="post" >

<div  id='search'>

<fieldset>
<table width="100%">
  <tr>
    <td colspan="2" align="center"><b>E-mail Service</b></br></td>
  </tr>
  <tr>
    <td width="22%" align="right"><label class="branch">Recipient Address</label></td>
    <td width="78%"><input type="text" id="recipient" name="recipient" style="width:64%;height:25px;" value='<s:property value="recipient"/>'/></td>
  </tr>
  <tr>
    <td align="right"><label class="branch">CC</label></td>
    <td><input type="text" id="CC" name="CC" style="width:64%;height:25px;" value='<s:property value="CC"/>'/></td>
  </tr>
  <tr>
    <td align="right"><label class="branch">BCC</label></td>
    <td><input type="text" id="BCC" name="BCC" style="width:64%;height:25px;" value='<s:property value="BCC"/>'/></td>
  </tr>
  <tr>
    <td align="right"><label class="branch">Subject</label></td>
    <td><input type="text" id="subject" name="subject" style="width:64%;height:25px;" value='<s:property value="subject"/>'/></td>
  </tr>
  <tr>
    <td align="right"><label class="branch">Message</label></td>
    <td><textarea id="message" style="height:130px;width:64%;font: 10px Tahoma;resize:none" name="message"><s:property value="message" ></s:property></textarea></td>
  </tr>
  <tr>
    <td align="right"><label class="branch">Attach File</label></td>
    <td><input type="file" id="file" name="file" /></td>
  </tr>
  <tr>
    <td colspan="2" align="center"><input type="button" name="btnsendemail" id="btnsendemail" class="myButton" value="Send E-mail"></td>
    <input type="hidden"  id="host" name="host"  value='<s:property value="host"/>'/>
<input type="hidden"  id="port" name="port"  value='<s:property value="port"/>'/>
<input type="hidden" id="filename" name="filename"  value='<s:property value="filename"/>'/>
    
  </tr>
</table></fieldset>

</div>
</form>	
</div>
</body>
</html>

