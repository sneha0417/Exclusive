<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <link rel="stylesheet" type="text/css" href="<%=contextPath%>/css/body.css">
<script>
$(document).ready(function () {   
	
	test();
	
}); 


function test()
{
	var d = new Date,
    dformat = [''+' on '+d.getDate(),
               d.getMonth()+1,
               d.getFullYear()].join('-')+' at '+
              [d.getHours(),
               d.getMinutes(),
               d.getSeconds()].join(':');

	 document.getElementById("lblfooter").innerText=""+dformat;
	}
</script>
               
   <style type="text/css">
   

    @media screen {
        div.divFooter {
            display: none;
        }
    }
    @media print {
        div.divFooter {
            /*position: fixed;*/
            bottom: 0;
            font-size: 8px;
        
        }
        
    #content {
   	 display: table;
} 

#pageFooter {
    display: table-footer-group;
}

#pageFooter:after {
      counter-increment: page;
      counter-reset: pages 1;
      content: "Page " counter(page) " / " counter(pages);
}
        
    }
    
    
 </style>
</head>
<body  bgcolor="white" onload="test();">
<div id="mainBG" class="homeContent" data-type="background">

 <div style="background-color:white;">

  
 <div class="divFooter">
 
<table width="135%">
 <tr>
     <td colspan="3" align="center"><fieldset><font style="color: #D8D8D8;font-size: 11px;">System Generated Document Signature & Stamp Not Required.</font></fieldset></td>
  </tr>
  <tr>
  <td width="47%" style="color: #D8D8D8;" align="left"><i>Printed by <%=session.getAttribute("USERNAME")%> 
  <label id="lblfooter"></label></i></td>
  
  <td width="43%" style="color: #FAFAFA;" align="left">Powered by GATEWAY ERP</td>
  
 <td width="10%" style="color: #D8D8D8;">
    <div id="content"> 
  <div id="pageFooter"></div>
   </div>  
  </td>
  </tr>
</table>

</div> 


</div>
</div>
</body>
</html>
