 
 
 
 
  <%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
 <%@ page pageEncoding="utf-8" %>
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
.special div {
    border: 0px solid #f00;
    margin: -2px;
}

.first {border-bottom:1px solid #FFF;}


#my_table{
        position:absolute; 
        z-index: 1;top:770px; 
          
}
#my_table1{
       font-size: 14px;
          
}
#maintab
{font-size: 14px;
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
	
	
	var trd=document.getElementById("thirdarray").value;

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
	
	
	if(parseInt(trd)==3) 
	{
	   $("#trddiv").prop("hidden", false);
	}
else
	{
	$("#trddiv").prop("hidden", true);
	}
	
	}
 
 

</script>
</head>
<body style="font-size:3;"  bgcolor="white" onload="hidedata()">
<div id="mainBG" class="homeContent" data-type="background">
<form id="fmnq" action="priInvoices" autocomplete="off" target="_blank">
<%-- <jsp:include page="../../../../../header.jsp"></jsp:include> --%> <br/> 

 <div style="background-color:white;">
 
<%--   <table width="100%">
  <tr>

  <td><jsp:include page="../../../common/printMainHeader.jsp"></jsp:include></td>
    
  </tr>
</table>  --%>
 <br><br> <br><br><br><br>
 
 
 
  
 <table width="100%" id="maintab"  >
 <tr><td>&nbsp;</td></tr>
 <tr><td>&nbsp;</td></tr>
 <tr><td>&nbsp;</td></tr>
 <tr><td>&nbsp;</td></tr>
 <tr><td>&nbsp;</td></tr>
  <tr>
  <td width="30%" align="right">  
    <%-- <b> <font size="4"><label id="lblprintnameakamal" name="lblprintnameakamal"><s:property value="lblprintnameakamal"/></label></font><b> --%>
    </td>
  </tr>
  <tr>
   
  <td width="40%"   align="left" style="vertical-align: top;display: table-cell;padding: 0px">
 
<!--   <table width="100%"    > -->
 <br/>

    &nbsp;&nbsp;&nbsp;&nbsp;<label id="lblvendoeaccName" name="lblvendoeaccName"><s:property value="lblvendoeaccName"/></label>   <br>
   &nbsp; &nbsp;&nbsp;&nbsp;<label id="lblclientaddress" name="lblclientaddress"><s:property value="lblclientaddress"/></label>   <br>
     &nbsp;&nbsp;&nbsp;&nbsp;<label id="lblclientcity" name="lblclientcity"><s:property value="lblclientcity"/></label>   <br>
      &nbsp; &nbsp;&nbsp;&nbsp;<label id="lblclientcountry" name="lblclientcountry"><s:property value="lblclientcountry"/></label>  <br>
   &nbsp;&nbsp;&nbsp;&nbsp;<label id="lblclientmob" name="lblclientmob"><s:property value="lblclientmob"/></label>   <!-- </td></tr> -->
 
<!--   <tr><td width="1%">&nbsp;</td> </tr> <tr><td width="1%">&nbsp;</td> </tr> <tr><td width="1%">&nbsp;</td> </tr>  <tr><td width="1%">&nbsp;</td> </tr>
    <tr><td width="1%">&nbsp;</td> </tr> -->
<!--   </table>  -->
  
    </td>
    
    
    <td width="30%">  
 
  <table  width="100%">
 

  <tr> <td align="right" width="68%"><label id="lblakmaldates" name="lblakmaldates"><s:property value="lblakmaldates"/></label>  </td>
  <td align="center" width="72%"><label id="lblinvno" name="lblinvno"><s:property value="lblinvno"/></label>  </td> </tr>
  

  <tr>  <td width="28%"  align="right"> </td>  <td width="72%">&nbsp;&nbsp;<label id="lbllpono" name="lbllpono"><s:property value="lbllpono"/></label>  </td>    </tr>
  <tr>  <td width="28%"  align="right"> </td> <td width="72%">&nbsp;&nbsp;<label id="lbldono" name="lbldono"><s:property value="lbldono"/></label>  </td>  </tr>
  <tr>  <td width="100%"  align="right" colspan="2">&nbsp; </td>  </tr>
  </table> 
     
    
    </td>
    
    
    
  </table>



<br>  
<table>
<tr><td>&nbsp;
</td>
</tr>
</table>
<div id="firstdiv">

<table  style="border-collapse: collapse;" width="98%"  id="my_table1" >

   <tr height="20%" style=" border-collapse: collapse;">
 
    <!-- <td align="left" style="border-collapse: collapse;"width="6%" ><b> </b></td> -->
    <td align="left" style="border-collapse: collapse;" width="10%"><b> </b></td>
 
     <td align="left" style="border-collapse: collapse;" width="40%"><b> </b></td>
    <td align="right" style="border-collapse: collapse;" width="8%"><b> </b></td>
    <td align="right" style="border-collapse: collapse;" width="8%"><b> </b></td>

     <td align="right" style="border-collapse: collapse;" width="10%"><b> </b></td>
   
 
  </tr>  

<s:iterator var="stat" value='#request.details1' >
<tr>   
<%int i=0; %>
    <s:iterator status="arr" value="#stat.split('::')" var="des">   
        <%
    if(i==0 ){%>
    
  <td  align="center"   >
  <s:property value="#des"/>
  </td>
  <%} else if(i>3){ %>
    
    
    
  <td  align="center"   >
  <s:property value="#des"/>
  </td>
  <%} else if(i<3){ %>
    
  <td  align="left"   >
  <s:property value="#des"/>
  </td>
   
  
   <%} else{ %>
    
  <td  align="left"    >
  <s:property value="#des"/>
  </td>
  <% } i++;  %>
 </s:iterator>
</tr>
</s:iterator>
 
 
</table>
 
 </div>


 
 <table width="98%"   id="my_table"  style="position:absolute;margin-top:-15px;">
  <tr>
    <td width="65%" align="left"> <i><b><font size="1.5" >&nbsp;&nbsp;&nbsp;Amount in words</font></b></i> </td>
    <td width="20%"  align="center"> <font size="1.5px" >Total</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
    <td width="15%" rowspan="4">
    <table width="100%" style="border-collapse: collapse;" width="100%"   >
      <tr>
        <td align="center"><font size="1.5px" ><label id="lbltotal"><s:property value="lbltotal"/></label></font>  </td>
      </tr>
       <tr>
        <td    align="center"><font size="1.5px" > <label id="lbldiscount"><s:property value="lbldiscount"/>0.00</label></font>  </td>
      </tr>
       <tr>
        <td height="23"  align="center"> <font size="1.5px" ><label id="lbltotal"><s:property value="lbltotal"/></label></font>  </td>
      </tr>  
        <tr>
        <td height="23"  align="center"> <font size="1.5px" ><label id="lbltotaltax"><s:property value="lbltotaltax"/></label></font>  </td>
      </tr> 
    <%--   <tr>
        <td   align="right">  <label id="lblordervalue"><s:property value="lblordervalue"/></label></td>
      </tr>   --%>
    </table></td>
  </tr>
     <tr>
   <td  rowspan="2">&nbsp;<font > <b>&nbsp;&nbsp;AED: <label id="lblamountinwordsakmal"><s:property value="lblamountinwordsakmal"/></label></b></font></td>
    <td align="center"><font size="1.5px" >Discount</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
   
  </tr>
  <tr>
  
    <td align="center" ><font >Net Total</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
   
  </tr>
  <tr>
  <td></td>
    <td align="center" ><font >Tax Amount</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
   
  </tr>
  <tr><td>
  </td>
  <td align="center" ><font ></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  <td height="23"  align="center"> <font size="1.5px" ><label id="lbltotaltaxamount"><s:property value="lbltotaltaxamount"/></label></font>  </td>
  </tr>
<!--   <tr>
    <td >&nbsp;</td>
    <td height="23" align="right"><b><font size="1px" >Total</font></b>&nbsp;</td>
  </tr> -->
</table>
 
 
 
 
 
 
<input type="hidden" name="firstarray" id="firstarray" value='<s:property value="firstarray"/>'>
<input type="hidden" name="secarray" id="secarray"  value='<s:property value="secarray"/>'>


<input type="hidden" name="thirdarray" id="thirdarray"  value='<s:property value="thirdarray"/>'>
 
</div>
</form>
</div>
</body>
</html>
 