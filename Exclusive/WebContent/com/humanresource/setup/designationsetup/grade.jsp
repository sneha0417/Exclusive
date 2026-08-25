<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath(); %>
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

<%@page import="com.humanresource.setup.designationsetup.ClsdesignationsetupDAO"%>
<% ClsdesignationsetupDAO showDAO = new ClsdesignationsetupDAO(); %>

<script type="text/javascript">

	$(document).ready(function () {    
	    document.getElementById("formdet").innerText="Grade(GRD)";
		document.getElementById("formdetail").value="Grade";
		document.getElementById("formdetailcode").value="GRD";
		window.parent.formCode.value="GRD";
		window.parent.formName.value="Grade";
		$('#btnSearch').attr('disabled', true);
		$("#grddate").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
		var graddata='<%=showDAO.search1()%>';
		var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'grade', type: 'String'  },
                          	{name : 'date', type: 'date'  } ,
                 ],
               localdata: graddata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
		
            var dataAdapter = new $.jqx.dataAdapter(source);
    
            $("#grdgrid").jqxGrid(
                    {
                    	width: "100%",
                        source: dataAdapter,
                        showfilterrow: true,
                        filterable: true,
                        selectionmode: 'singlerow',
                        
                        columns: [
		        					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
		        					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '12%',cellsformat:'dd.MM.yyyy' },
		        					{ text: 'Grade',columntype: 'textbox', filtertype: 'input', datafield: 'grade'   }
                    ]		
        	              
                    });
            
           $('#grdgrid').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
        		if ($("#mode").val() != "A") {   
                document.getElementById("docno").value= $('#grdgrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("grade").value = $("#grdgrid").jqxGrid('getcellvalue', rowindex1, "grade");
                $("#grddate").jqxDateTimeInput('val', $("#grdgrid").jqxGrid('getcellvalue', rowindex1, "date"));
                
        		}
            });   
        });

	function funSearchLoad(){
		//  vchangeContent('gradesearch.jsp'); 
	 }
 
 
	function funReadOnly() {
		$('#frmgrd input').attr('readonly', true);
		$('#grddate').jqxDateTimeInput({ disabled: true});
	}

	function funRemoveReadOnly() {
		$('#frmgrd input').attr('readonly', false);
		$('#grddate').jqxDateTimeInput({ disabled: false});
		$('#docno').attr('readonly', true);
		
		if ($("#mode").val() == "A") {
			 $('#grddate').val(new Date());
		   }
	}
 
	function setValues() {
		
		if($('#datehidden').val()){
			$("#grddate").jqxDateTimeInput('val', $('#datehidden').val());
		}
		
		if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
		}
		
		 //document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	}
	     function funNotify(){
	        	
	        	if(document.getElementById("grade").value=="") {
	        		document.getElementById("errormsg").innerText=" Enter grade";
	        		document.getElementById("grade").focus();
	        		return 0;
	        	}
	        	
	        	$('#grddate').jqxDateTimeInput({ disabled: false});
	        	
	    		return 1;
		} 

	     function funFocus(){
	    	 $('#grddate').jqxDateTimeInput('focus');
	     }
	  
</script>  
 
</head>
<body onLoad="setValues();" >

<form id="frmgrd" action="saveGrd" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/>
 
<fieldset><legend>Grade   </legend> 
<table width="100%">
	<tr><td width="10%"  align="right">Date</td> 
	<td width="15%" align="left"><div id="grddate" name="grddate" value='<s:property value="grddate"/>'></div></td>
  	<td width="12%" align="right">Grade  </td>
  	<td width="34%"><input type="text" name="grade" id="grade" style="width:100%;" placeholder="Grade" value='<s:property value="grade"/>'></td>
	<td width="10%" align="right">Doc No</td>
	<td width="10%"><input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly="readonly" tabindex="-1"></td>
	<td  width="9%" >&nbsp;</td></tr> 
	 
</table> 
	 
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/> 
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/> 
<input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/> 
	
</fieldset> 
</form>

<table width="100%">
    <tr><td><div id="grdgrid"></div></td></tr>
</table><br/>
		
</body>
</html>