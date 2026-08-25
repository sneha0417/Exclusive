 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
</style>
	<script type="text/javascript">

	$(document).ready(function () { 
	    
		   /* Date */ 	
		   
		     
		   
/* 		 
		 document.getElementById("masterdocnos").value=document.getElementById("docno").value;
		 document.getElementById("ven").value=document.getElementById("puraccid").value;
		 document.getElementById("venname").value=document.getElementById("puraccname").value; */
		   
		    var indexval1 = document.getElementById("masterdoc_no").value;  
		   
		  //  alert(indexval1);
		   
  		 var reftypeval = document.getElementById("reftypeval").value;  
	  		 var reqmasterdocno = document.getElementById("reqmasterdocno").value;  
	  		 
	  		 $("#showdara").load("showgriddata.jsp?purdoc="+indexval1+"&reftype="+reftypeval+"&reqmasterdocno="+reqmasterdocno);
		   
	    
	});   
	
	
	
 
    
    $("#print").click(function () {
        var gridContent = $("#showdata").jqxGrid('exportdata', 'html');
        var newWindow = window.open('', '', 'height=1500,width=1700,resizable=yes,scrollbars=yes,toolbar=yes,menubar=yes,location=yes'),
        document = newWindow.document.open(),
        pageContent =
            '<!DOCTYPE html>\n' +
            '<html>\n' +
            '<head>\n' +
            '<title>Print</title>\n' +
            '</head>\n' +
            '<body>\n' + gridContent + '\n</body>\n</html>';
        document.write(pageContent);
        document.close();
        newWindow.print();
    });
 
	
 
  
 

	</script>
<body bgcolor="#E0ECF8">
<div id=search>
 <table width="100%">
 <tr> <td width="80%">&nbsp;</td>
 <td width="20%">
<!--   <input type="button" onclick="printDiv('print-content')" value="print"/> -->
   
                <input type="button"  class="myButton" value="Print" id='print' />
             
 </td>
 </table>

      <br>
   
  
   
   
 
 <form>
<!--   <table width="100%">
 <tr> <td width="10%">&nbsp;</td> 
 <td width="80%">
 
    Vendor &nbsp;<input type="text"  id="ven"  >&nbsp;&nbsp;<input type="text"  id="venname" >  &nbsp;&nbsp;&nbsp;&nbsp;<input type="text"  id="masterdocnos" > 
             
 </td>
 </table>
  -->
 
    <div id="showdara" ><jsp:include page="showgriddata.jsp"></jsp:include></div>  
<!--   <input type="button" onclick="printDiv('print-content')" value="print a div!"/> -->
</form>
 
   <br>
   <br>
   <br>
   
   
   
   
   
   
   
   
   
   

                  
  </div>
</body>
</html>