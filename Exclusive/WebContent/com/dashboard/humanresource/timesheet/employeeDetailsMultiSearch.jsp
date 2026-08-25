 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

<style type="text/css">
#search {
    background-color: #E0ECF8;
}
</style>

	<script type="text/javascript">
	$(document).ready(function () {}); 

 	function loadFillSearch() {

 		var employeeName=document.getElementById("txtfillpartyname").value;
 		var empId=document.getElementById("txtfillpartyid").value;
 		var contactNo=document.getElementById("txtfillcontactno").value;
 		
		getdata(employeeName,empId,contactNo);
	}
	function getdata(employeeName,empId,contactNo){
		 $("#refreshdiv").load('employeeDetailsMultiSearchGrid.jsp?employeename='+employeeName.replace(/ /g, "%20")+'&empid='+empId+'&contactno='+contactNo);
		}
	
	function loadSearchSelect(){
		
		var rows = $("#employeeDetailsMultiSearch").jqxGrid('getrows');
		
		var selectedrows=$("#employeeDetailsMultiSearch").jqxGrid('selectedrowindexes');
		selectedrows = selectedrows.sort(function(a,b){return a - b});
		
		var i=0;var j=0;var k=0;var tempcodeno="",tempdocno="";
	    for (i = 0; i < rows.length; i++) {
				if(selectedrows[j]==i){
					
					if(k==0){
						tempcodeno=rows[i].codeno;
						tempdocno=rows[i].doc_no;
					}
					else{
						tempcodeno=tempcodeno+","+rows[i].codeno;
						tempdocno=tempdocno+","+rows[i].doc_no;
					}
					tempcodeno1=tempcodeno;
					tempdocno1=tempdocno;
				k++;	
				j++; 
			  }
            }
	    $('#txtselectedempids').val(tempcodeno1);
	    $('#txtselectedempdocnos').val(tempdocno1);
	    
	    $('#employeeDetailsWindow').jqxWindow('close'); 
	}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td align="right" style="font-size:9px;">Name</td>
    <td colspan="2"><input type="text" name="txtfillpartyname" id="txtfillpartyname" style="width:100%;height:20px;" value='<s:property value="txtfillpartyname"/>'></td>
    <td width="49%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadFillSearch();">&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="button" name="btnsearchselectok" id="btnsearchselectok" class="myButton" value="OK"  onclick="loadSearchSelect();"></td>
  </tr>
  <tr>
  <td width="7%" align="right" style="font-size:9px;">ID#</td>
    <td width="26%"><input type="text" name="txtfillpartyid" id="txtfillpartyid" style="width:70%;height:20px;" value='<s:property value="txtfillpartyid"/>'></td>
    <td width="18%" align="right" style="font-size:9px;">Contact No.</td>
    <td width="49%"><input type="text" name="txtfillcontactno" id="txtfillcontactno" style="width:50%;height:20px;" value='<s:property value="txtfillcontactno"/>'></td>   
  </tr>
  <tr>
    <td colspan="5"><div id="refreshdiv"><jsp:include page="employeeDetailsMultiSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>