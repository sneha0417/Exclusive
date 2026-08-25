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

</script>
</head>
<body onload="" bgcolor="white">
<div id="mainBG" class="homeContent" data-type="background">
<%-- <jsp:include page="../../../../../header.jsp"></jsp:include> --%> <br/> 
<form>
 <div style="background-color:white;">
<%-- <table width="100%" class="normaltable"  border="1">
  <tr>
    <td width="18%" rowspan="6"><img src="<%=contextPath%>/icons/complogo.jpg" width="100" height="91"  alt=""/></td>
    <td width="57%" rowspan="2">&nbsp;</td>
    <td width="25%"><font size="3"><label id="lblcompname" name="lblcompname" ><s:property value="lblcompname"/></label></font></td>
  </tr>
  <tr>
    <td><b><label id="lblcompaddress" name="lblcompaddress"><s:property value="lblcompaddress"/></label></b></td>
  </tr>
  <tr>
    <td rowspan="2"  align="center"><b><font size="5"><label id="lblprintname" name="lblprintname"><s:property value="lblprintname"/></label></font></b></td>
    <td align="left"><b>Tel :</b>&nbsp;<label id="lblcomptel" name="lblcomptel"><s:property value="lblcomptel"/></label></td>
  </tr>
  <tr>
    <td align="left"><b>Fax :</b>&nbsp;<label name="lblcompfax" id="lblcompfax" ><s:property value="lblcompfax"/></label></td>
  </tr>
  <tr>
    <td rowspan="2" align="center"><b><font size="2"><label id="lblprintname1" name="lblprintname1"><s:property value="lblprintname1"/></label></font></b></td>
    <td align="left"><b>Branch :</b>&nbsp;<label id="lblbranch" name="lblbranch" ><s:property value="lblbranch"/></label></td>
  </tr>
  <tr>
    <td align="left"><b>Location :</b>&nbsp;<label id="lbllocation" name="lbllocation" ><s:property value="lbllocation"/></label></td>
  </tr>
  <tr>
    <td colspan="3"><hr noshade size=1 width="100%"></td>
  </tr>
   <tr>
    <td colspan="3"></td></tr></table> --%>
    
    <div style="background-color:white;">
  

    
  <%--   <table width="100%" class="normaltable"  >
  <tr>
    <td  width="60%" colspan="2"><img src="<%=contextPath%>/icons/complogo.jpg" width="200" height="50"  alt=""/>
    ______________________________________________________________________ </td>
    <td width="40%" align="right"><b><font size="5" 	Style="color:#8b8878;font-family:Helvetica; font-weight: 750;letter-spacing: 4px;" ><label   id="lblprintname" name="lblprintname"><s:property value="lblprintname"/></label></font></b>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
    </tr>
    </table>
    
        
     <table width="100%"  >
     <tr>
     <td width="10%"><font size="2.5">&nbsp;&nbsp;<label id="lblcompname" name="lblcompname" ><s:property value="lblcompname"/></label></font> </td>
     <td width="20%">
     <b><label id="lblcompaddress" name="lblcompaddress"><s:property value="lblcompaddress"/></label></b></td> 
     <td width="20%"><label id="lblcompemail" name="lblcompemail"><s:property value="lblcompemail"/></label>ADASD<br>
     Tel/Fax<label id="lblcomptel" name="lblcomptel"><s:property value="lblcomptel"/></label>
     </td>
     
     <td width="30%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;DATE <label id="lbldate" name="lbldate"><s:property value="lbldate"/></label>
     <br>  <br>
     INVOICE NUMBER <label id="lbldate" name="lbldate"><s:property value="lbldate"/></label>
      </td>
     
  
  
    </tr>
 
  
   
    </table> --%>
    
   <table width="100%"  border="1" >
  <tr >
    <td colspan="1"><img src="<%=contextPath%>/icons/complogo.jpg" width="150" height="50"  alt=""/>
    <font style="color:#73C7FA;">_____________________</font></td>
    <td><h1><b>Tax Invoice</b></h1></td>
    <td colspan="2" align="center"><b><font size="5" Style="color:#8b8878;font-family:Helvetica; font-weight: 750;letter-spacing: 4px;"><label id="lblprintname" name="lblprintname"><s:property value="lblprintname"/></label></font></b></td>
  </tr>
  <tr>
    <td colspan="2" width="11%" align="left"><font size="2.5" style="color:#73C7FA;">&nbsp;&nbsp;<b><label id="lblcompname" name="lblcompname" ><s:property value="lblcompname"/></label></b></font> </td>
   
   </tr>
   <tr> <td width="27%" rowspan="2"><b>&nbsp;&nbsp;&nbsp;<label id="lblcompaddress" style="color:#8b8878;" name="lblcompaddress"><s:property value="lblcompaddress"/></label></b></td>
    </tr>
    <tr>
    <td width="36%" align="center">&nbsp;&nbsp;<label id="l"  style="color:#8b8878;" name="l"><s:property value="l"/></label></td>
    <%-- <td width="15%" align="right"><b>DATE :</b></td>
    <td width="11%">&nbsp;<label id="lbldate" name="lbldate"><s:property value="lbldate"/></label></td> --%>
  </tr>
  <tr>
  <td style="color:#8b8878;" align="left">&nbsp;&nbsp;&nbsp;Tel/Fax :&nbsp;<label id="lblcomptel" name="lblcomptel"><s:property value="lblcomptel"/></label></td>
  </tr>
  <tr>
    <td width="36%" align="left">&nbsp;&nbsp;&nbsp;<label id="lblcompemail"  style="color:#8b8878;" name="lblcompemail"><s:property value="lblcompemail"/></label></td>
    <%-- <td width="15%" align="right"><b>DATE :</b></td>
    <td width="11%">&nbsp;<label id="lbldate" name="lbldate"><s:property value="lbldate"/></label></td> --%>
  </tr>
<tr>
  <td style="color:#8b8878;" align="left">&nbsp;&nbsp;&nbsp;TRN :&nbsp;<label id="lbltrno" name="lbltrno"><s:property value="lbltrno"/></label></td>
  </tr>
  <tr>
  <td colspan="5"><hr noshade size=1 width="100%"></td>
 
  
  </tr>
</table>
    
    </div>

</form>
</div>

</body>
</html>
 