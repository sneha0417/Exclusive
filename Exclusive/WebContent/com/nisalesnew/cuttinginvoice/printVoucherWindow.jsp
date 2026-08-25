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
	

 	function printlogo() {

 		
 	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
 	  
 	   var url=document.URL;

     var reurl=url.split("saveinvs1");
     
    // $("#docno").prop("disabled", false);                
     

 var brhid=<%=session.getAttribute("BRANCHID").toString()%>
    	 var dtype=$('#formdetailcode').val();

    	 var win= window.open(reurl[0]+"printcutinv1?docno="+document.getElementById("masterdoc_no").value+"&dtype="+dtype+"&brhid="+brhid+"&type=yes"+"&logo=1","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");    	        	 
    	 win.focus();
 	   } 
 	  
 	   else {
 	    	      $.messager.alert('Message','Select a Document....!','warning');
 	    	      return false;
 	    	     }
 		$('#printWindow').jqxWindow('close');
 	}

 	function printnologo(){
 		
 		
 	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
 	  
 	   var url=document.URL;

     var reurl=url.split("saveinvs1");
     
    // $("#docno").prop("disabled", false);                
     

 var brhid=<%=session.getAttribute("BRANCHID").toString()%>
    	 var dtype=$('#formdetailcode').val();

    	 var win= window.open(reurl[0]+"printcutinv1?docno="+document.getElementById("masterdoc_no").value+"&dtype="+dtype+"&brhid="+brhid+"&type=yes"+"&logo=0","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");    
    	 win.focus();
 	   } 
 	  
 	   else {
 	    	      $.messager.alert('Message','Select a Document....!','warning');
 	    	      return false;
 	    	     }
 		$('#printWindow').jqxWindow('close');
 	}
 	

</script>

<body>
<div id=search>
<br/>
<table width="100%">
<tr><td colspan="2" align="center"><h2>Choose the print type</h2></td></tr>
  <tr>
    <td align="center"><input type="button" name="btninv" id="btninv" class="myButton" value="With Logo"  onclick="printlogo();"></td>
    <td align="center"><input type="button" name="btnfoc" id="btnfoc" class="myButton" value="With Out Logo"  onclick="printnologo();"></td>
    
  </tr>
</table>
&nbsp;
  </div>
</body>
</html>