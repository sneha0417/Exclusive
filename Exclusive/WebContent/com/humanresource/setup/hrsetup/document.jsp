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
 
<%@page import="com.humanresource.setup.hrsetup.document.ClsDocumentDAO"%>
<% ClsDocumentDAO showDAO = new ClsDocumentDAO(); %>
   
<script type="text/javascript">
	$(document).ready(function () {    
	    document.getElementById("formdet").innerText="Document(DOC)";
		document.getElementById("formdetail").value="Document";
		document.getElementById("formdetailcode").value="DOC";
		window.parent.formCode.value="DOC";
		window.parent.formName.value="Document";
	    
		$("#documentdate").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
 
		    var docdata='<%=showDAO.searchDocument()%>';
         
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'document', type: 'String'  },
                          	{name : 'date', type: 'date'  },
                          	{name : 'remarks', type: 'String'  }
                 ],
               localdata: docdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
    
            $("#documentgrid").jqxGrid(
                    {
                    	width: "100%",
                        source: dataAdapter,
                        showfilterrow: true,
                        filterable: true,
                        selectionmode: 'singlerow',
                        
                        columns: [
		        					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
		        					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '12%',cellsformat:'dd.MM.yyyy' },
		        					{ text: 'Document',columntype: 'textbox', filtertype: 'input', datafield: 'document', width: '38%' },
		        					{ text: 'Remarks',columntype: 'textbox', filtertype: 'input', datafield: 'remarks', width: '40%' },
        	              ]
                    });
            
          $('#documentgrid').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#documentgrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("document").value = $("#documentgrid").jqxGrid('getcellvalue', rowindex1, "document");
                $("#documentdate").jqxDateTimeInput('val', $("#documentgrid").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("remarks").value = $("#documentgrid").jqxGrid('getcellvalue', rowindex1, "remarks");
            });  
        });

	function funSearchLoad(){
		 changeContent('documentsearch.jsp'); 
	 }
 
	function funReadOnly() {
		$('#frmdocument input').attr('readonly', true);
		$('#documentdate').jqxDateTimeInput({ disabled: true});
		 
		/* 	$('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
	}
	
	function funRemoveReadOnly() {
		$('#frmdocument input').attr('readonly', false);
		$('#documentdate').jqxDateTimeInput({ disabled: false});
		$('#docno').attr('readonly', true);
		
		if ($("#mode").val() == "A") {
			 $('#documentdate').val(new Date());
		   }
	}
 
	function setValues() {
		if($('#datehidden').val()){
			$("#documentdate").jqxDateTimeInput('val', $('#datehidden').val());
		}
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		 //document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	}
 
	     function funNotify(){
	        	if(document.getElementById("document").value=="") {
	        		document.getElementById("errormsg").innerText=" Enter Document";
	        		document.getElementById("document").focus();
	        		return 0;
        		}
	    		return 1;
		} 
	     
	     function funFocus(){
	    	 $('#documentdate').jqxDateTimeInput('focus');  
	     }
	  
</script>   
 
</head>
<body onLoad="setValues();" > 
<form id="frmdocument" action="saveDocument" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/>
 
<fieldset><legend>Document Details</legend> 
<table width="100%">
	<tr><td width="10%" align="right">Date</td> 
	<td width="15%" align="left"><div id="documentdate" name="documentdate" value='<s:property value="documentdate"/>'></div></td>
	<td width="12%" align="right">Document</td>
	<td width="34%"><input type="text" name="document" id="document" style="width:100%;" placeholder="Document" value='<s:property value="document"/>'></td>
    <td width="10%" align="right">Doc No</td>
	<td width="10%"><input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly="readonly" tabindex="-1"></td>
	<td  width="9%">&nbsp;</td>
	</tr> 
	<tr><td align="right">Remarks</td>
	<td colspan="4"><input type="text" name="remarks" id="remarks" style="width:85.8%;" placeholder="Remarks" value='<s:property value="remarks"/>' ></td></tr>
</table>
	 
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/> 
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/> 
<input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/> 

</fieldset> 
</form>
		 
<table width="100%">
    <tr><td><div id="documentgrid"></div></td></tr>
</table><br/>	

</body>
</html>