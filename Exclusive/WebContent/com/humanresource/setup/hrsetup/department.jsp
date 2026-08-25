<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<%
String contextPath=request.getContextPath();
%>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
form label.error {
color:red;
  font-weight:bold;

}
</style>

<%@page import="com.humanresource.setup.hrsetup.department.ClsDepartmentDAO"%>
<% ClsDepartmentDAO showDAO = new ClsDepartmentDAO(); %>  

<script type="text/javascript">

	$(document).ready(function () {    
	    document.getElementById("formdet").innerText="Department(DEP)";
		document.getElementById("formdetail").value="Department";
		document.getElementById("formdetailcode").value="DEP";
		window.parent.formCode.value="DEP";
		window.parent.formName.value="Department";
		
	    $("#deptdate").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
           
	    var deptdata='<%=showDAO.searchDepartment()%>';
    
	    var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'department', type: 'String'  },
                          	{name : 'date', type: 'date'  },
                          	{name : 'remarks', type: 'String'  }
                 ],
               	 localdata: deptdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
	    
	        var dataAdapter = new $.jqx.dataAdapter(source);
    
            $("#departmentgrid").jqxGrid(
                  {
                  	width: "100%",
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlerow',
                        
                    columns: [
	        					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
	        					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '12%',cellsformat:'dd.MM.yyyy' },
	        					{ text: 'Department',columntype: 'textbox', filtertype: 'input', datafield: 'department', width: '38%' },
	        					{ text: 'Remarks',columntype: 'textbox', filtertype: 'input', datafield: 'remarks', width: '40%' },
        	              ]
                    });
            
             $('#departmentgrid').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                
                document.getElementById("docno").value= $('#departmentgrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("department").value = $("#departmentgrid").jqxGrid('getcellvalue', rowindex1, "department");
                $("#deptdate").jqxDateTimeInput('val', $("#departmentgrid").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("remarks").value = $("#departmentgrid").jqxGrid('getcellvalue', rowindex1, "remarks");
            });   
        });

	function funSearchLoad(){
		 changeContent('departmentsearch.jsp'); 
	 }
 
	function funReadOnly() {
		$('#frmdepartment input').attr('readonly', true);
		$('#deptdate').jqxDateTimeInput({ disabled: true});
	}
	
	function funRemoveReadOnly() {
		$('#frmdepartment input').attr('readonly', false);
		$('#docno').attr('readonly', true);
		$('#deptdate').jqxDateTimeInput({ disabled: false});

		if ($("#mode").val() == "A") {
			 $('#deptdate').val(new Date());
		}
	}
	
	function setValues() {
	
		if($('#datehidden').val()){
			$("#deptdate").jqxDateTimeInput('val', $('#datehidden').val());
		}
		
		if($('#msg').val()!=""){
			  $.messager.alert('Message',$('#msg').val());
		}
	}
 
	     function funNotify(){
	        	if(document.getElementById("department").value=="") {
	        		
	        		document.getElementById("errormsg").innerText=" Enter Department";
	        		document.getElementById("department").focus();
	        		return 0;
	        	}
	    		return 1;
		}
	     
	     function funFocus(){
	    	 $('#deptdate').jqxDateTimeInput('focus');
	     }
	  
</script>   
 
</head>
<body onLoad="setValues();" >

<form id="frmdepartment" action="saveDepartment" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/>
 
<fieldset><legend>Department Details</legend> 
<table width="100%">
	<tr><td  width="10%" align="right">Date</td>
	<td  width="15%" align="left"><div id="deptdate" name="deptdate" value='<s:property value="deptdate"/>'> </div></td>
  	<td   width="12%" align="right">Department</td>
  	<td width="34%"><input type="text" name="department" id="department" style="width:100%;" placeholder="Department" value='<s:property value="department"/>'></td>
	<td  width="10%" align="right">Doc No</td>
	<td  width="10%"><input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly="readonly" tabindex="-1"></td>
	<td  width="9%" >&nbsp;</td></tr> 
	<tr><td align="right">Remarks</td>
	<td colspan="4"><input type="text" name="remarks" id="remarks"  style="width:85.8%;" placeholder="Remarks" value='<s:property value="remarks"/>' ></td></tr>
</table>
	 
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/> 
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/> 
<input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/> 

</fieldset> 
</form>

<table width="100%">
    <tr><td><div id="departmentgrid"></div></td></tr>
</table><br/>

</body>
</html>