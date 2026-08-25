<%@page import="com.controlcentre.masters.salesmanmaster.salesagent.ClsSalesAgentDAO" %>
<%ClsSalesAgentDAO csad=new ClsSalesAgentDAO(); %>

<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<script type="text/javascript">
  
	  $(document).ready(function () {     
			 
		  $('#accountWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		  $('#accountWindow').jqxWindow('close');
	
		  $("#salesagentdate").jqxDateTimeInput({width : '125px',height : '15px',formatString : "dd.MM.yyyy"});
	      		
		  $('#txtaccno').dblclick(function(){
			  	    $('#accountWindow').jqxWindow('open');
				    var url=document.URL;
				    var reurl=url.split("com/");
					  	 accountSearchContent(reurl[0]+'com/search/accountsearch/accountsSearchAP.jsp?dtype='+document.getElementById("formdetailcode").value);
	      		 }); 
		  
		  document.getElementById("formdet").innerText="Sales Agent(SLA)";
   		  document.getElementById("formdetail").value="Sales Agent";
   		  document.getElementById("formdetailcode").value="SLA";
   		  window.parent.formCode.value="SLA";
		  window.parent.formName.value="Sales Agent";
   		var data='<%=csad.searchDetails()%>';
   		 var source =
         {
             datatype: "json",
             datafields: [
                       	{name : 'doc_no' , type: 'int' },
  						{name : 'name', type: 'String'  },
                       	{name : 'mail', type: 'String'  },
                       	{name : 'acno',type:'string'},
                       	{name : 'description',type:'String'},
                       	{name : 'mobile',type:'string'},
                       	{name : 'code',type:'string'},
                       	{name : 'date',type:'date'},
                       	{name : 'acdoc',type:'String'},
                       	{name : 'active',type:'String'},
                       	{name : 'hidactive',type:'String'}
              ],
              localdata: data,
             
             
             pager: function (pagenum, pagesize, oldpagenum) {
                 // callback called when a page or page size is changed.
             }
         };
         
         var dataAdapter = new $.jqx.dataAdapter(source,
         		 {
             		loadError: function (xhr, status, error) {
	                   // alert(error);    
	                    }
		            }		
         ); 
         $("#jqxSalesagentSearch1").jqxGrid(
                 {
                 	width: '100%',
                 	height:310,
                     source: dataAdapter,
                     showfilterrow: true,
                     filterable: true,
                     selectionmode: 'singlerow',
                     sortable: true,
                     altrows:true,
                     //Add row method
                     columns: [
     					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '7%' },
     					{ text: 'Code',datafield: 'code', width: '10%',hidden:true },
     					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '7%',cellsformat:'dd.MM.yyyy' },
     					{ text: 'Name', datafield: 'name', width: '20%' },
     					{ text: 'Account',columntype: 'textbox', filtertype: 'input', datafield: 'description' },
     					{ text: 'Account No',columntype: 'textbox', filtertype: 'input', datafield: 'acno', width: '50%' ,hidden:true},
     					{ text: 'Email',columntype: 'textbox', filtertype: 'input', datafield: 'mail', width: '15%' },
     					{ text: 'Mobile',columntype: 'textbox', filtertype: 'input', datafield: 'mobile', width: '15%' },
     					{ text: 'Ac Doc',columntype: 'textbox', filtertype: 'input', datafield: 'acdoc', width: '15%',hidden:true },
						{ text: 'Status',columntype: 'textbox', filtertype: 'input', datafield: 'active', width: '10%' },
						{ text: 'hidactive',columntype: 'textbox', filtertype: 'input', datafield: 'hidactive', width: '10%',hidden:true },

     	              ]
                 });

         $('#jqxSalesagentSearch1').on('rowdoubleclick', function (event) 
         		{ 
		            	var rowindex1=event.args.rowindex;
		                document.getElementById("docno").value= $('#jqxSalesagentSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
		                document.getElementById("code").value = $("#jqxSalesagentSearch1").jqxGrid('getcellvalue', rowindex1, "code");
		                document.getElementById("name").value = $("#jqxSalesagentSearch1").jqxGrid('getcellvalue', rowindex1, "name");
		                document.getElementById("mail").value = $("#jqxSalesagentSearch1").jqxGrid('getcellvalue', rowindex1, "mail");
		                document.getElementById("mobile").value = $("#jqxSalesagentSearch1").jqxGrid('getcellvalue', rowindex1, "mobile");
		                $("#salesagentdate").jqxDateTimeInput('val', $("#jqxSalesagentSearch1").jqxGrid('getcellvalue', rowindex1, "date")); 
		                document.getElementById("txtaccno").value = $("#jqxSalesagentSearch1").jqxGrid('getcellvalue', rowindex1, "acno");
		                document.getElementById("txtaccname").value = $("#jqxSalesagentSearch1").jqxGrid('getcellvalue', rowindex1, "description");
		                document.getElementById("hidacno").value = $("#jqxSalesagentSearch1").jqxGrid('getcellvalue', rowindex1, "acdoc");
						document.getElementById("cmbactivestatus").value = $("#jqxSalesagentSearch1").jqxGrid('getcellvalue', rowindex1, "hidactive");
         		 }); 
	 });
	 
	 function getCode(saltype){
		  var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				 	var items= x.responseText;
				 	$("#code").val(items.trim());
				}
		     }
		      x.open("GET", "getCode.jsp?saltype="+saltype,true);
		     x.send();
		    
	}
		
	 function getAcc(event){
		 var x= event.keyCode;
		 if(x==114){
		  $('#accountWindow').jqxWindow('open');
		    var url=document.URL;
		     var reurl=url.split("com/");
			  	  accountSearchContent(reurl[0]+'com/search/accountsearch/accountsSearchAP.jsp?dtype='+document.getElementById("formdetailcode").value);
		 }
		 else{}
		 }
	
	 function accountSearchContent(url) {
			 $.get(url).done(function (data) {
			$('#accountWindow').jqxWindow('setContent', data);
		}); 
		}
	
	function funSearchLoad(){
		changeContent('salesAgentSearch.jsp'); 
	 }
	 
	function funReadOnly(){
	     $('#frmSalesAgent input').attr('readonly', true );
		 $('#salesagentdate').jqxDateTimeInput({ disabled: true}); 
		 $('#cmbactivestatus').attr('disabled', true);		
	}
	
	function funRemoveReadOnly(){
		$('#frmSalesAgent input').attr('readonly', false );
		$('#salesagentdate').jqxDateTimeInput({ disabled: false});
		$('#cmbactivestatus').attr('disabled', false);
		$('#docno').attr('readonly', true);
		$('#txtaccno').attr('readonly', true);
		$('#txtaccname').attr('readonly', true);
		
		if($("#mode").val()=='A'){
			getCode(document.getElementById("formdetailcode").value);
		}
	}
	
	function setValues() {
		if($('#hidsalesagentdate').val()){
			$("#salesagentdate").jqxDateTimeInput('val', $('#hidsalesagentdate').val());
	    }
		
		if($('#hidactivestatus').val()){
			$("#cmbactivestatus").val($('#hidactivestatus').val());
	    }
		
		if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
		}
	
	}
	
	function funFocus(){
	     document.getElementById("code").focus();
	}
	
	$(function(){
	    $('#frmSalesAgent').validate({
	             rules: {
	             code: {required:true,maxlength:10},
	             name:{required:true,maxlength:40},
	             txtaccname:{required:true},
	             mobile:{required:true,digits:true,minlength:12,maxlength:12},
	             mail:{email:true}
	             },
	             messages: {
	              code:{required:" *",maxlength:"Max 10 Chars."},
	              name:{required:" *",maxlength:"Max 40 Chars."},
	              txtaccname:{required:" *"},
	              mobile:{required:" *",digits:"Digits only.",minlength:"Min 12 Chars.",maxlength:'Max 12 Chars.'},
	              mail:{email:"Not a valid Email."}
	             }
	    });});
	    
	function funNotify(){
		if(document.getElementById("txtaccno").value==''){
			document.getElementById("errormsg").innerText="Account is Mandatory.";
			return false;
		}
		document.getElementById("errormsg").innerText="";
		return 1;
	}
	function funExcelBtn(){
	   	 $("#jqxSalesagentSearch1").jqxGrid('exportdata', 'xls', 'Sales Agents');
	   }
</script>
</head>
<body onLoad="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmSalesAgent" action="saveActionSalesAgent" autocomplete="off" >
<jsp:include page="../../../../header.jsp" /><br/> 

<fieldset>
<legend>Sales Agent Details</legend>
<table width="100%">
  <tr>
    <td width="5%" align="right">Date</td>
    <td width="16%"><div id="salesagentdate" name="salesagentdate" value='<s:property value="salesagentdate"/>'></div></td>
    <td colspan="3" align="right">Doc No.</td>
    <td width="15%"><input type="text" id="docno" name="docno" value='<s:property value="docno"/>' readonly tabindex="-1"></td>
  </tr>
  <tr>
    <td align="right">Code</td>
    <td><input type="text" id="code" name="code" placeholder="Code" value='<s:property value="code"/>' ></td>
    <td width="11%" align="right">Name</td>
    <td width="33%"><input type="text" name="name" id="name" placeholder="Code Name" value='<s:property value="name"/>' style="width:80%;" ></td>
    <td width="5%" align="right">Email</td>
    <td colspan="3"><input type="email" name="mail" id="mail" style="width:100%;" placeholder="someone@example.com" value='<s:property value="mail"/>'></td>
  </tr>
  <tr>
    <td align="right">Account</td>
    <td><input type="text" name="txtaccno" id="txtaccno" value='<s:property value="txtaccno"/>' onKeyDown="getAcc(event);" readonly placeholder="Press F3 to Search"></td>
    <td colspan="2"><input type="text" name="txtaccname" id="txtaccname" value='<s:property value="txtaccname"/>'  style="width:85.1%;" readonly></td>
    <td align="right">Mobile</td>
    <td><input type="text" name="mobile" id="mobile" value='<s:property value="mobile"/>'></td>
    <td align="right">Status</td>
    <td><select name="cmbactivestatus" id="cmbactivestatus" value='<s:property value="cmbactivestatus"/>' style="width:100%;">
      <option value="A">Active</option>
      <option value="I">Inactive</option>
    </select></td>
  </tr>
</table>
</fieldset>

<input type="hidden" name="hidactivestatus" id="hidactivestatus" value='<s:property value="hidactivestatus"/>'>
<input type="hidden" name="hidsalesagentdate" id="hidsalesagentdate" value='<s:property value="hidsalesagentdate"/>'>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'> 
<input type="hidden" name="hidacno" id="hidacno" value='<s:property value="hidacno"/>'> 
</form>
<div id="accountWindow">
	<div >
	</div>
	</div>
<div id="jqxSalesagentSearch1"></div>	
</div>

</body>
</html>

