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
	    document.getElementById("formdet").innerText="Qualification(QLF)";
		document.getElementById("formdetail").value="Qualification";
		document.getElementById("formdetailcode").value="DQLFOC";
		window.parent.formCode.value="QLF";
		window.parent.formName.value="Qualification";
		$('#btnSearch').attr('disabled', true);
		$("#qlfdate").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
 
		    var docdata='<%=showDAO.search2()%>';
         
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'qualification', type: 'String'  },
                          	{name : 'date', type: 'date'  },
                          	 
                 ],
               localdata: docdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
    
            $("#qualificationgrid").jqxGrid(
                    {
                    	width: "100%",
                        source: dataAdapter,
                        showfilterrow: true,
                        filterable: true,
                        selectionmode: 'singlerow',
                        
                        columns: [
		        					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
		        					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '12%',cellsformat:'dd.MM.yyyy' },
		        					{ text: 'Qualification',columntype: 'textbox', filtertype: 'input', datafield: 'qualification'   }
        	              ]
                    });
            
          $('#qualificationgrid').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
            	if ($("#mode").val() != "A") {   
                document.getElementById("docno").value= $('#qualificationgrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("qualification").value = $("#qualificationgrid").jqxGrid('getcellvalue', rowindex1, "qualification");
                $("#qlfdate").jqxDateTimeInput('val', $("#qualificationgrid").jqxGrid('getcellvalue', rowindex1, "date"));
            	}
     
            });  
        });

	function funSearchLoad(){
		//  changeContent('documentsearch.jsp'); 
	 }
 
	function funReadOnly() {
		
		
		

		
		$('#frmqlf input').attr('readonly', true);
		$('#qlfdate').jqxDateTimeInput({ disabled: true});
		 
		
	}
	
	function funRemoveReadOnly() {
		$('#frmqlf input').attr('readonly', false);
		$('#qlfdate').jqxDateTimeInput({ disabled: false});
		$('#docno').attr('readonly', true);
		
		if ($("#mode").val() == "A") {
			 $('#qlfdate').val(new Date());
		   }
	}
 
	function setValues() {
		if($('#datehidden').val()){
			$("#qlfdate").jqxDateTimeInput('val', $('#datehidden').val());
		}
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		 //document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	}
 
	     function funNotify(){
	        	if(document.getElementById("qualification").value=="") {
	        		document.getElementById("errormsg").innerText=" Enter  Qualification";
	        		document.getElementById("qualification").focus();
	        		return 0;
        		}
	        	$('#qlfdate').jqxDateTimeInput({ disabled: false});
	    		return 1;
		} 
	     
	     function funFocus(){
	    	 $('#qlfdate').jqxDateTimeInput('focus');  
	     }
	  
</script>   
 
</head>
<body onLoad="setValues();" > 
<form id="frmqlf" action="saveqlf" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/>
 
<fieldset><legend>Qualification</legend> 
<table width="100%">
	<tr><td width="10%" align="right">Date</td> 
	<td width="15%" align="left"><div id="qlfdate" name="qlfdate" value='<s:property value="qlfdate"/>'></div></td>
	<td width="12%" align="right">Qualification</td>
	<td width="34%"><input type="text" name="qualification" id="qualification" style="width:100%;" placeholder="Qualification" value='<s:property value="qualification"/>'></td>
    <td width="10%" align="right">Doc No</td>
	<td width="10%"><input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly="readonly" tabindex="-1"></td>
	<td  width="9%">&nbsp;</td>
	</tr> 
	 
</table>
	 
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/> 
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/> 
<input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/> 

</fieldset> 
</form>
		 
<table width="100%">
    <tr><td><div id="qualificationgrid"></div></td></tr>
</table><br/>	

</body>
</html>