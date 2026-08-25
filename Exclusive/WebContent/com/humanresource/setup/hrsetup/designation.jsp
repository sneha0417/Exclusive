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

<%@page import="com.humanresource.setup.hrsetup.designation.ClsDesignationDAO"%>
<% ClsDesignationDAO showDAO = new ClsDesignationDAO(); %>   

<script type="text/javascript">

	$(document).ready(function () {    
	    document.getElementById("formdet").innerText="Designation(DES)";
		document.getElementById("formdetail").value="Designation";
		document.getElementById("formdetailcode").value="DES";
		window.parent.formCode.value="DES";
		window.parent.formName.value="Designation";

		$("#desigdate").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
	    
		var desigdata='<%=showDAO.searchDesignation()%>';

		var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'designation', type: 'String'  },
                          	{name : 'date', type: 'date'  },
                          	
                          	{name : 'remarks', type: 'String'  }
                 ],
               localdata: desigdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
		
            var dataAdapter = new $.jqx.dataAdapter(source);
    
            $("#designationgrid").jqxGrid(
                    {
                    	width: "100%",
                        source: dataAdapter,
                        showfilterrow: true,
                        filterable: true,
                        selectionmode: 'singlerow',
                        
                        columns: [
		        					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
		        					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '12%',cellsformat:'dd.MM.yyyy' },
		        					{ text: 'Designation',columntype: 'textbox', filtertype: 'input', datafield: 'designation', width: '38%' },
		        					{ text: 'Remarks',columntype: 'textbox', filtertype: 'input', datafield: 'remarks', width: '40%' },
        	              ]
                    });
            
           $('#designationgrid').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                
                document.getElementById("docno").value= $('#designationgrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("designation").value = $("#designationgrid").jqxGrid('getcellvalue', rowindex1, "designation");
                $("#desigdate").jqxDateTimeInput('val', $("#designationgrid").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("remarks").value = $("#designationgrid").jqxGrid('getcellvalue', rowindex1, "remarks");
              
            });   
        });

	function funSearchLoad(){
		 changeContent('designationsearch.jsp'); 
	 }
 
 
	function funReadOnly() {
		$('#frmdesignation input').attr('readonly', true);
		$('#desigdate').jqxDateTimeInput({ disabled: true});
	}

	function funRemoveReadOnly() {
		$('#frmdesignation input').attr('readonly', false);
		$('#desigdate').jqxDateTimeInput({ disabled: false});
		$('#docno').attr('readonly', true);
		
		if ($("#mode").val() == "A") {
			 $('#desigdate').val(new Date());
		   }
	}
 
	function setValues() {
		
		if($('#datehidden').val()){
			$("#desigdate").jqxDateTimeInput('val', $('#datehidden').val());
		}
		
		if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
		}
		
		 //document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	}
	     function funNotify(){
	        	
	        	if(document.getElementById("designation").value=="") {
	        		document.getElementById("errormsg").innerText=" Enter Designation";
	        		document.getElementById("designation").focus();
	        		return 0;
	        	}
	        	
	    		return 1;
		} 

	     function funFocus(){
	    	 $('#desigdate').jqxDateTimeInput('focus');
	     }
	  
</script>  
 <style>
.hidden-scrollbar {  
    height:500px;
    overflow-x: hidden;
    
} 
</style>  
</head>
<body onLoad="setValues();" >

<form id="frmdesignation" action="saveDesignation" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/>
 <div class='hidden-scrollbar'>
<fieldset><legend>Designation Details</legend> 
<table width="100%">
	<tr><td width="10%"  align="right">Date</td>
	<td width="15%" align="left"><div id="desigdate" name="desigdate" value='<s:property value="desigdate"/>'></div></td>
  	<td width="12%" align="right">Designation</td>
  	<td width="34%"><input type="text" name="designation" id="designation" style="width:100%;" placeholder="Designation" value='<s:property value="designation"/>'></td>
	<td width="10%" align="right">Doc No</td>
	<td width="10%"><input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly="readonly" tabindex="-1"></td>
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
    <tr><td><div id="designationgrid"></div></td></tr>
</table><br/>
	</div>	
</body>
</html>