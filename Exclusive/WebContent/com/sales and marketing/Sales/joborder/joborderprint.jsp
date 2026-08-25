<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
 .hidden-scrollbar {
  overflow: auto;
  height: 800px;
} 
 fieldSet {
  -webkit-border-radius: 8px;
  -moz-border-radius: 8px;
  border-radius: 8px;
  border: 1px solid rgb(139,136,120);

 }
 .tablereceipt {
    border: 1px solid black;
    border-collapse: collapse;
}
 
 hr { 
   border-top: 1px solid #e1e2df  ;
    
    }

</style> 
  <%-- <style type="text/css">
    @media screen {
        div.divFooter {
            display: none;
        }
    }
    @media print {
        div.divFooter {
            position: fixed;
            bottom: 0;
        }
    }
 </style>  --%>
 
 
 <script type="text/javascript">

function hidedata()
{

	var first=document.getElementById("firstarray").value;
	var sec=document.getElementById("secarray").value;

	if(parseInt(first)==1) 
		{
		   $("#firstdiv").prop("hidden", false);
		}
	else
		{
		$("#firstdiv").prop("hidden", true);
		}
	
	if(parseInt(sec)==2)
	{
		  $("#secdiv").prop("hidden", false);
	}
	else
		{
		 $("#secdiv").prop("hidden", true);
		} 
	
	
	}
 
 

</script>
</head>
<body style="font-size:10px;"  bgcolor="white" onload="hidedata()">
<div id="mainBG" class="homeContent" data-type="background">
<form id="fmnq" action="priInvoices" autocomplete="off" target="_blank">
<%-- <jsp:include page="../../../../../header.jsp"></jsp:include> --%> <br/> 

 <div style="background-color:white;">
<table width="100%">
  <tr>

  <td><jsp:include page="../../../common/printHeader.jsp"></jsp:include></td>
    
  </tr>
</table>
<fieldset>
<!-- <table width="100%">
<tr>
<td width="60%">


 -->
  
<table width="100%"  > 
  <tr> 
  <td  align="right" width="10%">Customer</td> 
    <td  align="left"   width="70%" colspan="3">: <label id="custname" name="custname"><s:property value="custname"/></label> 
    &nbsp; <label id="custaddress" name="custaddress"><s:property value="custaddress"/></label>
    </td> 
    
     
       
    <td   align="left" width="20%">&nbsp;Doc No : <label id="lbldoc" name="lbldoc"><s:property value="lbldoc"/></label></td>
    </tr><tr>
           <td  align="right"  width="10%">Reg No</td>
    <td  align="left"   width="30%">: <label id="lblregno" name="lblregno"><s:property value="lblregno"/></label></td> 
    
       <td   align="right" width="8%">YOM</td>
    <td   align="left" colspan="3" width="40%">: <label id="lblyom" name="lblyom"><s:property value="lblyom"/></label></td>
  
      </tr><tr>
        <td align="right" >Brand</td>
    <td  align="left">: <label id="lblbrand" name="lblbrand"><s:property value="lblbrand"/></label></td> 
     <td align="right" >Model</td> 
     
      
    <td   align="left"  colspan="3">: <label id="lblmodel" name="lblmodel"><s:property value="lblmodel"/></label></td> 
    </tr><tr>
     <td    align="right"  >Sub Model</td>
     <td  align="left"  >: <label name="lblsubmodel" id="lblsubmodel" ><s:property value="lblsubmodel"/></label></td>
     
   
    <td   align="right">Engine Size</td>
    <td   align="left"  colspan="3">: <label id="lblesize" name="lblesize"><s:property value="lblesize"/></label></td>
     </tr><tr>
    <td   align="right" >Bed Size</td>
    <td   align="left">: <label id="lblbsize" name="lblbsize"><s:property value="lblbsize"/></label></td>
  
  
    <td   align="right">Cabin Size</td>
    <td   align="left"  colspan="3">: <label id="lblcsize" name="lblcsize"><s:property value="lblcsize"/></label></td>
  
  
  
    </tr>
    
 
  </table>

</fieldset>
<br> 


 <fieldset>        
<table style="border-collapse: collapse;" width="100%"  >

 <tr height="25" style="background-color: #D8D8D8;border-collapse: collapse;">
    <td align="left" style="border-collapse: collapse;" width="5%"><b>Sl No</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Product</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Product Name</b></td>
        <td align="left" style="border-collapse: collapse;"  ><b>Brand</b></td>
    <td align="left" style="border-collapse: collapse;"  width="6%"><b>Unit</b></td>
     <td align="left" style="border-collapse: collapse;" width="6%" ><b>Qty</b></td>
          <td align="left" style="border-collapse: collapse;"   width="6%" ><b>Fixing</b></td>
 
 
  </tr>

<s:iterator var="stat" value='#request.details' >
<tr>   
<%int i=0; %>
    <s:iterator status="arr" value="#stat.split('::')" var="des">   
    <%
    if(i>4){%>
    
  <td  align="left" >
  <s:property value="#des"/>
  </td>
  <%} else if(i==4){ %>
    
  <td  align="left" >
  <s:property value="#des"/>
  </td>
   
  
   <%} else{ %>
    
  <td  align="left" >
  <s:property value="#des"/>
  </td>
  <% } i++;  %>
 </s:iterator>
</tr>
</s:iterator>
 
</table>
 </fieldset> 
 <div id="firstdiv">
 </div>

 
<jsp:include page="../../../common/printFooter.jsp"></jsp:include> 
 
<input type="hidden" name="firstarray" id="firstarray" value='<s:property value="firstarray"/>'>
<input type="hidden" name="secarray" id="secarray"  value='<s:property value="secarray"/>'>
 
</div>
</form>
</div>
</body>
</html>
