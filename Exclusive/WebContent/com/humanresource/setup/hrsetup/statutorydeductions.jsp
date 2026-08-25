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
<%@page import="com.humanresource.setup.hrsetup.statutorydeductions.ClsStatutorydeductionsDAO"%>
<% ClsStatutorydeductionsDAO showDAO = new ClsStatutorydeductionsDAO(); %>  
<script type="text/javascript">
	$(document).ready(function () {    
		document.getElementById("formdet").innerText="Statutory Deductions(STD)";
		document.getElementById("formdetail").value="Statutory Deductions";
		document.getElementById("formdetailcode").value="STD";
		window.parent.formCode.value="STD";
		window.parent.formName.value="Statutory Deductions";
	   
		$("#statudate").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
	    
	    $('#accountSearchwindow').jqxWindow({ width: '60%', height: '62%',  maxHeight: '75%' ,maxWidth: '60%' , title: 'Account Search' ,position: { x: 150, y: 60 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		$('#accountSearchwindow').jqxWindow('close');
		   
		   $('#acno').dblclick(function(){
		    	if($('#mode').val()!= "view") {
			  	    $('#accountSearchwindow').jqxWindow('open');
			  	    accountSearchContent('accountsDetailsSearch.jsp?');
		    	}
		  });   
		   
      		var alcdata='<%=showDAO.searchstatu()%>';
             
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
                          	{name : 'date', type: 'date'  },
                          	{name : 'satudeduction', type: 'String'  },
                          	{name : 'acno', type: 'String'  },
                         	{name : 'accname', type: 'String'  },
                          	{name : 'remarks', type: 'String'  },
                         	{name : 'accdocno', type: 'String'  },
                        	{name : 'chktype', type: 'String'  },
                         	
                 ],
                  localdata: alcdata,
                 
                pager: function (pagenum, pagesize, oldpagenum) {
                    
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
    
            $("#deductiongrid").jqxGrid(
                    {
                    	width: "100%",
                    	height:375,
                        source: dataAdapter,
                        showfilterrow: true,
                        filterable: true,
                        selectionmode: 'singlerow',
                        
                        columns: [
        					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '7%' },
        					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '7%',cellsformat:'dd.MM.yyyy' },
        					{ text: 'Statutory Deductions',columntype: 'textbox', filtertype: 'input', datafield: 'satudeduction', width: '20%' },
        					{ text: 'Account',columntype: 'textbox', filtertype: 'input', datafield: 'acno', width: '10%' },
        					{ text: 'Account Name',columntype: 'textbox', filtertype: 'input', datafield: 'accname', width: '26%' },
        					{ text: 'Remarks',columntype: 'textbox', filtertype: 'input', datafield: 'remarks', width: '30%' },
        					{ text: 'accdocno',columntype: 'textbox', filtertype: 'input', datafield: 'accdocno', width: '10%' ,hidden: true},
        					{ text: 'chktype',columntype: 'textbox', filtertype: 'input', datafield: 'chktype', width: '10%' ,hidden: true},
        	              ]
                    });

            $('#deductiongrid').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                
                document.getElementById("docno").value= $('#deductiongrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("satudeduction").value = $("#deductiongrid").jqxGrid('getcellvalue', rowindex1, "satudeduction");
                $("#statudate").jqxDateTimeInput('val', $("#deductiongrid").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("remarks").value = $("#deductiongrid").jqxGrid('getcellvalue', rowindex1, "remarks");
                document.getElementById("acno").value = $("#deductiongrid").jqxGrid('getcellvalue', rowindex1, "acno");
                document.getElementById("accname").value = $("#deductiongrid").jqxGrid('getcellvalue', rowindex1, "accname");
                document.getElementById("accdocno").value = $("#deductiongrid").jqxGrid('getcellvalue', rowindex1, "accdocno");
            	$('#frmstatudeduction select').attr('disabled', false);
                document.getElementById("type").value = $("#deductiongrid").jqxGrid('getcellvalue', rowindex1, "chktype");
                
                if ($("#mode").val() == "view") {
	            	$('#frmstatudeduction select').attr('disabled', true);
                }
            });   
        });
	
	function funSearchLoad(){
		 changeContent('statutorydeductionsearch.jsp'); 
	 }
	 
     function accountSearchContent(url) {
            $.get(url).done(function (data) {
            $('#accountSearchwindow').jqxWindow('setContent', data);
  		}); 
     }
  	  
	function funReadOnly() {
		$('#frmstatudeduction input').attr('readonly', true);
		$('#frmstatudeduction select').attr('disabled', true);
		$('#statudate').jqxDateTimeInput({ disabled: true});
	}
	
	function funRemoveReadOnly() {
		$('#frmstatudeduction input').attr('readonly', false);
		$('#frmstatudeduction select').attr('disabled', false);
		$('#docno').attr('readonly', true);
		$('#acno').attr('readonly', true);
		$('#accname').attr('readonly', true);
		$('#statudate').jqxDateTimeInput({ disabled: false});

		if ($("#mode").val() == "A") {
			 $('#statudate').val(new Date());
		   }
	}
 
	function setValues() {
		
		if($('#datehidden').val()){
			$("#statudate").jqxDateTimeInput('val', $('#datehidden').val());
		}
		
		if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
		}
		 
		 if($('#hidtype').val()=="1") {
			 $('#type').val("1");
		 } else {
			 $('#type').val("0");
		 }
		 
		 //document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	}
	
	function getaccountdetails(event){
	 	 var x= event.keyCode;
	 	 if($('#mode').val()!="view") {
	 	 if(x==114){
	 	  	$('#accountSearchwindow').jqxWindow('open');
	 	    accountSearchContent('accountsDetailsSearch.jsp?');    }
	 	 else{}
	 		}
	 	 }
	     
	     function funNotify(){
	         	if(document.getElementById("satudeduction").value=="") {
		       		document.getElementById("errormsg").innerText=" Enter Statutory Deductions	";
		       		document.getElementById("satudeduction").focus();
		       		return 0;
        		}
	        	
	        	if(document.getElementById("acno").value=="") {
	        		document.getElementById("errormsg").innerText=" Search Account";
	        		document.getElementById("acno").focus();
	        		return 0;
        		}
	    		return 1;
		} 
	     
	    function funFocus(){
	    	 $('#statudate').jqxDateTimeInput('focus');
	    }
	  
</script>   
 
</head>
<body onLoad="setValues();" > 

<form id="frmstatudeduction" action="savestatuDeduction" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/>
 
<fieldset><legend>Statutory Deductions Details</legend>
<table width="100%" >
	<tr><td width="10%" align="right">Date</td> 
		<td width="15%" align="left"><div id="statudate" name="statudate" value='<s:property value="statudate"/>'> </div></td>
	  	<td width="12%" align="right">Statutory Deductions</td>
	  	<td width="34%"><input type="text" name="satudeduction" id="satudeduction" style="width:100%;" placeholder="Statutory Deductions" value='<s:property value="satudeduction"/>'></td>
		<td width="10%" align="right">Doc No</td>
		<td width="10%"><input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly="readonly" tabindex="-1"></td>
		<td  width="9%" >&nbsp;</td>
	</tr> 
	<tr><td align="right">Account</td>
		<td  colspan="4" ><input type="text" name="acno" id="acno" readonly="readonly"   placeholder="Press F3 To Search"  onKeyDown="getaccountdetails(event);"   value='<s:property value="acno"/>' > 
		&nbsp;<input type="text" name="accname" id="accname" style="width:50%;" readonly="readonly" value='<s:property value="accname"/>' >&nbsp;&nbsp;Type&nbsp;
		<select name="type" id="type"  style="width:12%;"   value='<s:property value="type"/>'  >
		    <option value="0">Amount</option><option value="1">Percentage</option></select></td></tr>
	<tr><td align="right">Remarks</td>
		<td colspan="4"><input type="text" name="remarks" id="remarks"  style="width:85.8%;" placeholder="Remarks" value='<s:property value="remarks"/>' ></td></tr>
</table>
	 
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/> 
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/> 
<input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/> 
<input type="hidden" name="accdocno" id="accdocno" value='<s:property value="accdocno"/>' >
<input type="hidden" name="hidtype" id="hidtype" value='<s:property value="hidtype"/>' >
	
</fieldset> 
</form>

<table width="100%">
    <tr><td><div id="deductiongrid"></div></td></tr>
</table><br/>
		 
<div id="accountSearchwindow">
	   <div></div>
</div>	

</body>
</html>