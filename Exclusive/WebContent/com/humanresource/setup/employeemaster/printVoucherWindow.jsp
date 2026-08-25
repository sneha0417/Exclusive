 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

<script type="text/javascript">
function employmentletter(){
	 if (($("#mode").val() == "view") && $("#docno").val()!="") {
		  
		   var url=document.URL;
		   //alert(url);
  	   var reurl=url.split("saveEmployeeMaster");
  	   var brhid=<%=session.getAttribute("BRANCHID").toString()%>
    	   var dtype=$('#formdetailcode').val();
  	   
	   var win= window.open(reurl[0]+"employeeletter?docno="+document.getElementById("docno").value+"&dtype="+dtype+"&brhid="+brhid,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");    
	     
	   win.focus(); 
	   }else {
  	      $.messager.alert('Message','Select a Document....!','warning');
  	      return false;
  	     } 
	    	     
	}
function applicationform() {
	 if (($("#mode").val() == "view") && $("#docno").val()!="") {
		  
		   var url=document.URL;
		   //alert(url);
  	   var reurl=url.split("saveEmployeeMaster");
  	   var brhid=<%=session.getAttribute("BRANCHID").toString()%>
    	   var dtype=$('#formdetailcode').val();
  	   
        var win= window.open(reurl[0]+"applicationform?docno="+document.getElementById("docno").value+"&dtype="+dtype+"&brhid="+brhid,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");    
	       win.focus(); 
	   }else {
  	      $.messager.alert('Message','Select a Document....!','warning');
  	      return false;
  	     } 
	    	     
	}
function personaldata() {
	 if (($("#mode").val() == "view") && $("#docno").val()!="") {
		  
		   var url=document.URL;
		   //alert(url);
  	   var reurl=url.split("saveEmployeeMaster");
  	   var brhid=<%=session.getAttribute("BRANCHID").toString()%>
    	   var dtype=$('#formdetailcode').val();
	   
		   var win= window.open(reurl[0]+"personaldata?docno="+document.getElementById("docno").value+"&dtype="+dtype+"&brhid="+brhid,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");    
	       win.focus(); 
	   }else {
  	      $.messager.alert('Message','Select a Document....!','warning');
  	      return false;
  	     } 
	    	     
	}
	
function checklist() {
	 if (($("#mode").val() == "view") && $("#docno").val()!="") {
		  
		   var url=document.URL;
		   //alert(url);
  	   var reurl=url.split("saveEmployeeMaster");
  	   var brhid=<%=session.getAttribute("BRANCHID").toString()%>
    	   var dtype=$('#formdetailcode').val();
  	   
           var win= window.open(reurl[0]+"checklist?docno="+document.getElementById("docno").value+"&dtype="+dtype+"&brhid="+brhid,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");    
	       win.focus(); 
	   }else {
  	      $.messager.alert('Message','Select a Document....!','warning');
  	      return false;
  	     } 
	    	     
	}
function confidentialagreement() {
	 if (($("#mode").val() == "view") && $("#docno").val()!="") {
		  
		   var url=document.URL;
		   //alert(url);
  	   var reurl=url.split("saveEmployeeMaster");
  	   var brhid=<%=session.getAttribute("BRANCHID").toString()%>
    	   var dtype=$('#formdetailcode').val();
 	   
		   var win= window.open(reurl[0]+"confidentialagreement?docno="+document.getElementById("docno").value+"&dtype="+dtype+"&brhid="+brhid,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");    
	       win.focus(); 
	   }else {
  	      $.messager.alert('Message','Select a Document....!','warning');
  	      return false;
  	     } 
	    	     
	}
function joiningletter() {
	 if (($("#mode").val() == "view") && $("#docno").val()!="") {
		  
		   var url=document.URL;
		   //alert(url);
  	   var reurl=url.split("saveEmployeeMaster");
  	   var brhid=<%=session.getAttribute("BRANCHID").toString()%>
    	   var dtype=$('#formdetailcode').val();
 	   
		   var win= window.open(reurl[0]+"joiningletter?docno="+document.getElementById("docno").value+"&dtype="+dtype+"&brhid="+brhid,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");    
	       win.focus(); 
	   }else {
  	      $.messager.alert('Message','Select a Document....!','warning');
  	      return false;
  	     } 
	    	     
	}
function performanceeval() {
	 if (($("#mode").val() == "view") && $("#docno").val()!="") {
		  
		   var url=document.URL;
		   //alert(url);
  	   var reurl=url.split("saveEmployeeMaster");
  	   var brhid=<%=session.getAttribute("BRANCHID").toString()%>
    	   var dtype=$('#formdetailcode').val();
 	   
		   var win= window.open(reurl[0]+"perfevalreport?docno="+document.getElementById("docno").value+"&dtype="+dtype+"&brhid="+brhid,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");    
	       win.focus(); 
	   }else {
  	      $.messager.alert('Message','Select a Document....!','warning');
  	      return false;
  	     } 
	    	     
	}
 	

</script>

<body>
<div id=search>
<br/>
<table width="100%">
<tr><td colspan="2" align="center"><h2>Choose the print type</h2></td></tr>
  <tr>
    <td align="center"><input type="button" name="btninv" id="btninv" class="myButton" value="Employment Letter"  onclick="employmentletter();"></td>
    <td align="center"><input type="button" name="btnfoc" id="btnfoc" class="myButton" value="Job Application Form"  onclick="applicationform();"></td>
    <td align="center"><input type="button" name="btnfoc" id="btnfoc" class="myButton" value="Personal Data"  onclick="personaldata();"></td>
    
  </tr><tr>
    <td align="center"><input type="button" name="btninv" id="btninv" class="myButton" value="New Employee Checklist"  onclick="checklist();"></td>
    <td align="center"><input type="button" name="btnfoc" id="btnfoc" class="myButton" value="Confidential Agreement"  onclick="confidentialagreement();"></td>
    <td align="center"><input type="button" name="btnfoc" id="btnfoc" class="myButton" value="Joining Letter"  onclick="joiningletter();"></td>
    <td align="center"><input type="button" name="btnfoc" id="btnfoc" class="myButton" value="Performance Evaluation Form"  onclick="performanceeval();"></td>
  </tr>
  
</table>
&nbsp;
  </div>
</body>
</html>