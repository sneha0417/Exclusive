<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
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

<%@page import="com.humanresource.setup.hrsetup.payrollcategory.ClsPayrollcategoryDAO"%>
<% ClsPayrollcategoryDAO showDAO = new ClsPayrollcategoryDAO();%> 

<script type="text/javascript">
	$(document).ready(function () {    
	    document.getElementById("formdet").innerText="Payroll Category(PCT)";
		document.getElementById("formdetail").value="Payroll Category";
		document.getElementById("formdetailcode").value="PCT";
		window.parent.formCode.value="PCT";
		window.parent.formName.value="Payroll Category";
	    
		$("#parrolldate").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
 
		var catdata='<%=showDAO.searchcategory()%>';
         
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'category', type: 'String'  },
                          	{name : 'date', type: 'date'  },
                          	{name : 'remarks', type: 'String'  },
                        	{name : 'timesheet', type: 'Int'  },
                 ],
                 localdata: catdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
    
            $("#categorygrid").jqxGrid(
                    {
                    	width: "100%",
                        source: dataAdapter,
                        showfilterrow: true,
                        filterable: true,
                        selectionmode: 'singlerow',
                        
                        columns: [
		        					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
		        					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '12%',cellsformat:'dd.MM.yyyy' },
		        					{ text: 'Category',columntype: 'textbox', filtertype: 'input', datafield: 'category', width: '38%' },
		        					{ text: 'Remarks',columntype: 'textbox', filtertype: 'input', datafield: 'remarks', width: '40%' },
		        					{ text: 'timesheet',filtertype: 'number', datafield: 'timesheet', width: '10%',hidden:true },
        	              ]
                    });

            $('#categorygrid').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
 
                document.getElementById("docno").value= $('#categorygrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("category").value = $("#categorygrid").jqxGrid('getcellvalue', rowindex1, "category");
                $("#parrolldate").jqxDateTimeInput('val', $("#categorygrid").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("remarks").value = $("#categorygrid").jqxGrid('getcellvalue', rowindex1, "remarks");
                
                $('#timesheet').attr('disabled', false);
                
                var timesheet=$("#categorygrid").jqxGrid('getcellvalue', rowindex1, "timesheet");
	            if(parseInt(timesheet)==1) {
	            	 document.getElementById("timesheet").checked = true;
	       		     document.getElementById("timesheet").value=1;
	            	} else {
	           	     document.getElementById("timesheet").checked = false;
	       		     document.getElementById("timesheet").value=0;
	            	}
	            
	            if ($("#mode").val() == "view") {
	            	$('#timesheet').attr('disabled', true);
	            }

	            /// parrolldate category
            });  
        });

	function funSearchLoad(){
		 changeContent('payrollcategorysearch.jsp'); 
	 }
 
	function funReadOnly() {
		$('#frmpayrollcategory input').attr('readonly', true);
		$('#timesheet').attr('disabled', true);
		$('#parrolldate').jqxDateTimeInput({ disabled: true});
		 
		/* 	$('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
	}
	
	function funRemoveReadOnly() {
		$('#frmpayrollcategory input').attr('readonly', false);
		$('#timesheet').attr('disabled', false);
		$('#parrolldate').jqxDateTimeInput({ disabled: false});
		$('#docno').attr('readonly', true);
		
		if ($("#mode").val() == "A") {
			 $('#parrolldate').val(new Date());
		}
	}
 
	function setValues() {
		if($('#datehidden').val()){
			$("#parrolldate").jqxDateTimeInput('val', $('#datehidden').val());
		}
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }

		 //document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		var hidtimesheet=$('#hidtimesheet').val();
		if(parseInt(hidtimesheet)==1) {
       	 	document.getElementById("timesheet").checked = true;
  		    document.getElementById("timesheet").value=1;
       	} else {
      	    document.getElementById("timesheet").checked = false;
  		    document.getElementById("timesheet").value=0;
       	}
	}
 
	     function funNotify(){
	        	if(document.getElementById("category").value=="") {
        			document.getElementById("errormsg").innerText=" Enter Category";
        			document.getElementById("category").focus();
        			return 0;
        		}
	    		return 1;
		} 

	     function funFocus(){
	    	 $('#parrolldate').jqxDateTimeInput('focus');
	     }
	  
</script>   
 
</head>
<body onLoad="setValues();" >

<form id="frmpayrollcategory" action="savePayrollcategory" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/>
 
<fieldset><legend>Payroll Category Details</legend> 
<table width="100%"  >
	<tr><td width="10%" align="right">Date</td> 
	<td width="15%" align="left"><div id="parrolldate" name="parrolldate" value='<s:property value="parrolldate"/>'> </div></td>
	<td width="12%" align="right">Category</td>
	<td width="34%"><input type="text" name="category" id="category" style="width:99%;" placeholder="Category" value='<s:property value="category"/>'></td>
	<td width="9%" >&nbsp;&nbsp;<input type="checkbox" id="timesheet"  name="timesheet" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)" >&nbsp;Time Sheet </td>
	<td width="10%"  align="right">Doc No</td>
	<td width="10%"><input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly="readonly" tabindex="-1"></td></tr> 
	<tr><td align="right">Remarks</td>
	<td colspan="4"><input type="text" name="remarks" id="remarks" style="width:86.2%;" placeholder="Remarks" value='<s:property value="remarks"/>' ></td></tr>
</table>
	 
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/> 
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/> 
<input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/> 
<input type="hidden" id="hidtimesheet" name="hidtimesheet" value='<s:property value="hidtimesheet"/>'/> 
	
</fieldset> 
</form>
		 
<table width="100%">
    <tr><td><div id="categorygrid"></div></td></tr>
</table><br/>	

</body>
</html>