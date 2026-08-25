<%@page import="com.controlcentre.masters.salesmanmaster.salesman.ClsSalesmanDAO" %>
<%ClsSalesmanDAO csd=new ClsSalesmanDAO(); %>
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
	 $("#salesmandate").jqxDateTimeInput({width : '125px',height : '15px',formatString : "dd.MM.yyyy"});
	
	 $('#accountWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#accountWindow').jqxWindow('close');
	 document.getElementById("formdet").innerText="Sales Man(SLM)";
		document.getElementById("formdetail").value="Sales Man";
		document.getElementById("formdetailcode").value="SLM";
		window.parent.formCode.value="SLM";
		window.parent.formName.value="Sales Man";
      		 $('#txtaccno').dblclick(function(){
		  	    $('#accountWindow').jqxWindow('open');
			    var url=document.URL;
			    var reurl=url.split("com/");
				  accountSearchContent(reurl[0]+'com/search/accountsearch/accountsEmployee.jsp?dtype='+document.getElementById("formdetailcode").value);
      		 }); 
      		
    		var data='<%=csd.searchDetails()%>';
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
                           	{name :'date',type:'date'},
                           	{name : 'acdoc',type:'String'},
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
             $("#jqxSalesmanSearch1").jqxGrid(
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
         					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
         					{ text: 'Code',datafield: 'code', width: '10%',hidden:true },
         					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
         					{ text: 'Name', datafield: 'name', width: '20%' },
         					{ text: 'Account',columntype: 'textbox', filtertype: 'input', datafield: 'description', width: '30%' },
         					{ text: 'Account No',columntype: 'textbox', filtertype: 'input', datafield: 'acno', width: '50%' ,hidden:true},
         					{ text: 'Email',columntype: 'textbox', filtertype: 'input', datafield: 'mail', width: '15%' },
         					{ text: 'Mobile',columntype: 'textbox', filtertype: 'input', datafield: 'mobile', width: '15%' },
         					{ text: 'Ac Doc',columntype: 'textbox', filtertype: 'input', datafield: 'acdoc', width: '15%',hidden:true },

         	              ]
                     });

             $('#jqxSalesmanSearch1').on('rowdoubleclick', function (event) 
             		{ 
   		            	var rowindex1=event.args.rowindex;
   		                document.getElementById("docno").value= $('#jqxSalesmanSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
   		                document.getElementById("salesmanid").value = $("#jqxSalesmanSearch1").jqxGrid('getcellvalue', rowindex1, "code");
   		                document.getElementById("salesmanname").value = $("#jqxSalesmanSearch1").jqxGrid('getcellvalue', rowindex1, "name");
   		                document.getElementById("salesmanmail").value = $("#jqxSalesmanSearch1").jqxGrid('getcellvalue', rowindex1, "mail");
   		                document.getElementById("telephone").value = $("#jqxSalesmanSearch1").jqxGrid('getcellvalue', rowindex1, "mobile");
   		                $("#salesmandate").jqxDateTimeInput('val', $("#jqxSalesmanSearch1").jqxGrid('getcellvalue', rowindex1, "date")); 
   		                document.getElementById("txtaccno").value = $("#jqxSalesmanSearch1").jqxGrid('getcellvalue', rowindex1, "acno");
   		                document.getElementById("txtaccname").value = $("#jqxSalesmanSearch1").jqxGrid('getcellvalue', rowindex1, "description");
   		                document.getElementById("hidacno").value = $("#jqxSalesmanSearch1").jqxGrid('getcellvalue', rowindex1, "acdoc");
             		 }); 
  });
		 
	 function getAcc(event){
		 var x= event.keyCode;
		 if(x==114){
		  $('#accountWindow').jqxWindow('open');
		    var url=document.URL;
		     var reurl=url.split("com/");
			  	  accountSearchContent(reurl[0]+'com/search/accountsearch/accountsEmployee.jsp?dtype='+document.getElementById("formdetailcode").value);
		 }
		 else{}
		 }
	
	 function accountSearchContent(url) {
			 $.get(url).done(function (data) {
	    	 $('#accountWindow').jqxWindow('setContent', data);
		}); 
		}
	
	function funFocus(){
		document.getElementById("salesmanid").focus();
	}
	
	function funReadOnly() {
		$('#frmSalesman input').attr('readonly', true);
		$('#salesmandate').jqxDateTimeInput({ disabled: true}); 
	}
	
	function funRemoveReadOnly() {
		$('#frmSalesman input').attr('readonly', false);
		$('#salesmandate').jqxDateTimeInput({ disabled: false}); 
		$('#docno').attr('readonly', true);
		$('#txtaccno').attr('readonly', true);
		$('#txtaccname').attr('readonly', true);
	}
	
	function setValues() {
		if($('#hidsalesmandate').val()){
			$("#salesmandate").jqxDateTimeInput('val', $('#hidsalesmandate').val());
		}
		
			if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }
			
	}
	
	$(function(){
	    $('#frmSalesman').validate({
	             rules: {
	             salesmanid: {required:true,maxlength:4},
	             salesmanname: {required:true,maxlength:40},
	             txtaccname:{required:true},
	             telephone:{required:true,digits:true,minlength:12,maxlength:12},
	             salesmanmail:{email:true}
	             },
	             messages: {
	              salesmanid:{required:" *",maxlength:"Max 4 Chars."},
	              salesmanname:{required:" *",maxlength:"Max 40 Chars."},
	              txtaccname:{required:" *"},
	              telephone:{required:" *",digits:"Digits only.",minlength:"Min 12 Chars.",maxlength:'Max 12 Chars.'},
	              salesmanmail:{email:"Not a valid Email."}
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
	
	function funChkButton() {
		   /* funReset(); */
		  }
		  
	function funSearchLoad(){
		changeContent('salesmanSearch.jsp'); 
	 }
	function funExcelBtn(){
	   	 $("#jqxSalesmanSearch1").jqxGrid('exportdata', 'xls', 'Salesman');
	   }
 
</script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmSalesman" action="saveSalesman" method="post" autocomplete="off" >
	<jsp:include page="../../../../header.jsp" />
	<br/> 
<fieldset><legend>Salesman Details</legend>
<table width="100%">
  <tr>
    <td width="5%" align="right">Date</td>
    <td width="16%"><div id="salesmandate" name="salesmandate" value='<s:property value="salesmandate"/>'></div></td>
    <td colspan="3" align="right">Doc No.</td>
    <td width="30%"><input type="text" id="docno" name="docno" value='<s:property value="docno"/>' readonly tabindex="-1"></td>
  </tr>
  <tr>
    <td align="right">Code</td>
    <td><input type="text" name="salesmanid" id="salesmanid" placeholder="Code" value='<s:property value="salesmanid"/>' ></td>
    <td width="11%" align="right">Name</td>
    <td width="33%"><input type="text" name="salesmanname" id="salesmanname" placeholder="Code Name" value='<s:property value="salesmanname"/>' style="width:59%;"></td>
    <td width="5%" align="right">Email</td>
    <td><input type="email" name="salesmanmail" id="salesmanmail" style="width:80%;" placeholder="someone@example.com" value='<s:property value="salesmanmail"/>' ></td>
  </tr>
  <tr>
    <td align="right">Account</td>
    <td><input type="text" name="txtaccno" id="txtaccno" value='<s:property value="txtaccno"/>' onKeyDown="getAcc(event);" readonly placeholder="Press F3 to Search"></td>
    <td colspan="2"><input type="text" name="txtaccname" id="txtaccname" value='<s:property value="txtaccname"/>'  style="width:70%;" readonly></td>
    <td align="right">Mobile</td>
    <td><input type="text" name="telephone" id="telephone" value='<s:property value="telephone"/>'></td>
  </tr>
</table>
</fieldset>

<input type="hidden" name="hidsalesmandate" id="hidsalesmandate" value='<s:property value="hidsalesmandate"/>'/>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="hidacno" name="hidacno"  value='<s:property value="hidacno"/>'/>
</form>
</div>
<br/>
	<div id="jqxSalesmanSearch1"></div>
		
	<div id="accountWindow">
	<div >
	
	</div>
	<div>
	</div>
	 </div>  
	
</body>
</html>