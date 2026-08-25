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

<%@page import="com.humanresource.setup.hrsetup.allowances.ClsAllowancesDAO"%>
<% ClsAllowancesDAO showDAO = new ClsAllowancesDAO(); %>  

<script type="text/javascript">
	$(document).ready(function () {    
	    document.getElementById("formdet").innerText="Allowance(ALC)";
		document.getElementById("formdetail").value="Allowance";
		document.getElementById("formdetailcode").value="ALC";
		window.parent.formCode.value="ALC";
		window.parent.formName.value="Allowance";
		
	    $("#allowancedate").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
	    
	    $('#accountSearchwindow').jqxWindow({ width: '60%', height: '62%',  maxHeight: '75%' ,maxWidth: '60%' , title: 'Account Search' ,position: { x: 150, y: 60 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		$('#accountSearchwindow').jqxWindow('close');
		   
		$('#acno').dblclick(function(){
		    	
		if($('#mode').val()!= "view") {
			  	 $('#accountSearchwindow').jqxWindow('open');
			  	  accountSearchContent('accountsDetailsSearch.jsp');
		    	 }
		  });   
		   
            var alcdata='<%=showDAO.searchAllowance()%>';
             
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
                          	{name : 'code', type: 'String'  },
     						{name : 'allowance', type: 'String'  },
                          	{name : 'date', type: 'date'  },
                          	{name : 'acno', type: 'String'  },
                         	{name : 'accname', type: 'String'  },
                          	{name : 'remarks', type: 'String'  },
                         	{name : 'accdocno', type: 'String'  },
                          	
                 ],
               		localdata: alcdata,

               	 pager: function (pagenum, pagesize, oldpagenum) {
                     // callback called when a page or page size is changed.
                 }
                                         
             };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            	$("#allowancegrid").jqxGrid(
                    {
                    	width: '100%',
                        height: 375,
                        source: dataAdapter,
                        selectionmode: 'singlerow',
             			editable: false,
             			columnsresize: true,
             			showfilterrow: true,
                        filterable: true,
                        
                        columns: [
									{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '7%' },
									{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '7%',cellsformat:'dd.MM.yyyy' },
									{ text: 'Allowance Code',columntype: 'textbox', filtertype: 'input', datafield: 'code', width: '8%' },
									{ text: 'Allowance Name',columntype: 'textbox', filtertype: 'input', datafield: 'allowance', width: '15%' },
									{ text: 'Account',columntype: 'textbox', filtertype: 'input', datafield: 'acno', width: '10%' },
									{ text: 'Account Name',columntype: 'textbox', filtertype: 'input', datafield: 'accname', width: '25%' },
									{ text: 'Remarks',columntype: 'textbox', filtertype: 'input', datafield: 'remarks', width: '28%' },
									{ text: 'Account Doc No',columntype: 'textbox', filtertype: 'input', datafield: 'accdocno', width: '10%' ,hidden: true},
            					]
                    });
            	
         $('#allowancegrid').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#allowancegrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("allowancecode").value = $("#allowancegrid").jqxGrid('getcellvalue', rowindex1, "code");
                document.getElementById("allowance").value = $("#allowancegrid").jqxGrid('getcellvalue', rowindex1, "allowance");
                $("#allowancedate").jqxDateTimeInput('val', $("#allowancegrid").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("remarks").value = $("#allowancegrid").jqxGrid('getcellvalue', rowindex1, "remarks");
                document.getElementById("acno").value = $("#allowancegrid").jqxGrid('getcellvalue', rowindex1, "acno");
                document.getElementById("accname").value = $("#allowancegrid").jqxGrid('getcellvalue', rowindex1, "accname");
                document.getElementById("accdocno").value = $("#allowancegrid").jqxGrid('getcellvalue', rowindex1, "accdocno");
                
            });   
        });

	function funSearchLoad(){
		 changeContent('allowancessearch.jsp'); 
	 }
 
     function accountSearchContent(url) {
        
          $.get(url).done(function (data) {
          	$('#accountSearchwindow').jqxWindow('setContent', data);
  	      }); 
      	}
  	  
	function funReadOnly() {
		$('#frmallowance input').attr('readonly', true);
		$('#allowancedate').jqxDateTimeInput({ disabled: true});
	}
	
	function funRemoveReadOnly() {
		$('#frmallowance input').attr('readonly', false);
		$('#docno').attr('readonly', true);
		$('#acno').attr('readonly', true);
		$('#accname').attr('readonly', true);
		$('#allowancedate').jqxDateTimeInput({ disabled: false});
		
		if ($("#mode").val() == "A") {
			 $('#allowancedate').val(new Date());
		}
	}
 
	function setValues() {
		if($('#datehidden').val()){
			$("#allowancedate").jqxDateTimeInput('val', $('#datehidden').val());
		}
		
		if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
		}
		
		 //document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	}
	
	function getaccountdetails(event){
	 	 var x= event.keyCode;
	   	
	     if($('#mode').val()!="view") {
	 	 if(x==114){
	 	  	$('#accountSearchwindow').jqxWindow('open');
	 	 	accountSearchContent('accountsDetailsSearch.jsp');    
	 	 }
	 	 else{}
	 		}
	 	 }
 
	     function funNotify(){
	        	if(document.getElementById("allowance").value=="")
        		{
        		document.getElementById("errormsg").innerText=" Enter Allowance";
        		document.getElementById("allowance").focus();
        		return 0;
        		}
	        	
	        	
	        	if(document.getElementById("acno").value=="")
        		{
        		document.getElementById("errormsg").innerText=" Search Account";
        		document.getElementById("acno").focus();
        		return 0;
        		}
	    		return 1;
		} 
	     
	     function funFocus(){
	    		$('#allowancedate').jqxDateTimeInput('focus');
	     }
	  
</script>   
 
</head>
<body onLoad="setValues();" > 

<form id="frmallowance" action="saveAllowance" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/>
 
<fieldset><legend>Allowance Details</legend>
<table width="100%">
		<tr><td width="7%"  align="right">Date</td>  
		<td width="12%" align="left"><div id="allowancedate" name="allowancedate" value='<s:property value="allowancedate"/>'> </div></td>
	  	<td width="9%" align="right">Allowance</td>
	  	<td width="14%"><input type="text" name="allowancecode" id="allowancecode" style="width:100%;" placeholder="Allowance Code" value='<s:property value="allowancecode"/>'></td>
        <td  width="5%" align="right">Name</td>
        <td  width="31%"><input type="text" name="allowance" id="allowance" style="width:99%;" placeholder="Allowance Name" value='<s:property value="allowance"/>'></td>
		<td width="8%" align="right">Doc No</td>
		<td width="14%"><input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly tabindex="-1"></td>
	</tr> 
	<tr><td align="right">Account</td> 
		<td  colspan="7" ><input type="text" name="acno" id="acno" readonly   placeholder="Press F3 To Search"  onKeyDown="getaccountdetails(event);"  value='<s:property value="acno"/>' > 
		&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="accname" id="accname" style="width:61%;" readonly value='<s:property value="accname"/>' ></td></tr>
	<tr><td align="right">Remarks</td>
		<td colspan="7"><input type="text" name="remarks" id="remarks"  style="width:76%;" placeholder="Remarks" value='<s:property value="remarks"/>' ></td></tr>
</table>
	 
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/> 
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/> 
<input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/> 
<input type="hidden" name="accdocno" id="accdocno"       value='<s:property value="accdocno"/>' >
	
</fieldset> 
</form>

<table width="100%">
    <tr><td><div id="allowancegrid"></div></td></tr>
</table><br/>
		 
  <div id="accountSearchwindow">
	   <div ></div>
	</div>	

</body>
</html>