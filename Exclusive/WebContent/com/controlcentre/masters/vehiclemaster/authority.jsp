<%@page import="com.controlcentre.masters.vehiclemaster.authority.ClsAuthorityAction" %>
<%ClsAuthorityAction ca=new ClsAuthorityAction(); %>

<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
form label.error {
color:red;
  font-weight:bold;

}
</style>
<script type="text/javascript">
var data= '<%=ca.searchDetails() %>';

      $(document).ready(function (){   
    	  $("#authdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"}); 
    	  
    	  document.getElementById("formdet").innerText="Authority(AUT)";
  		  document.getElementById("formdetail").value="Authority";
  		  document.getElementById("formdetailcode").value="AUT";
		  window.parent.formName.value="Authority";
  			window.parent.formCode.value="AUT";    	  
    	  var num = 0; 
          var source =
          {
              datatype: "json",
              datafields: [
                        	{name : 'DOC_NO' , type: 'number' },
   						{name : 'authname', type: 'String'  },
                        	{name : 'date', type: 'date'  },
                        	{name : 'authid',type:'String'}
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
          $("#jqxAuthoritySearch1").jqxGrid(
                  {
                  	width: 850,
                      source: dataAdapter,
                      showfilterrow: true,
                      filterable: true,
                      selectionmode: 'multiplecellsextended',
                      //pagermode: 'default',
                      sortable: true,
                      //pageable: true,
                      altrows:true,
                      //Add row method
                      columns: [
      					{ text: 'Doc No',filtertype: 'number', datafield: 'DOC_NO', width: '10%' },
      					{ text: 'Auth Id', datafield: 'authid', width: '20%' },
      					{ text: 'Authority',columntype: 'textbox', filtertype: 'input', datafield: 'authname', width: '50%' },
      					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '20%',cellsformat:'dd.MM.yyyy' },
    					

      	              ]
                  });
     
          $('#jqxAuthoritySearch1').on('rowdoubleclick', function (event) 
          		{ 
		            	var rowindex1=event.args.rowindex;
		                document.getElementById("docno").value= $('#jqxAuthoritySearch1').jqxGrid('getcellvalue', rowindex1, "DOC_NO"); 
		                document.getElementById("authname").value = $("#jqxAuthoritySearch1").jqxGrid('getcellvalue', rowindex1, "authname");
		            	$('#authdate').jqxDateTimeInput({ disabled: false});

		                $("#authdate").jqxDateTimeInput('val', $("#jqxAuthoritySearch1").jqxGrid('getcellvalue', rowindex1, "date")); 
		                document.getElementById("auth").value= $("#jqxAuthoritySearch1").jqxGrid('getcellvalue', rowindex1, "authid");
		            	$('#authdate').jqxDateTimeInput({ disabled: true});

          		 }); 
      });
     
      function funSearchLoad(){
			changeContent('authoritySearch.jsp', $('#window')); 
		 }

function funReadOnly(){
	$('#frmAuthority input').attr('readonly', true );
	 $('#authdate').jqxDateTimeInput({ disabled: true}); 
	// $('#frmAuthority select').attr('disabled', true );
	
}
function funRemoveReadOnly(){
	$('#frmAuthority input').attr('readonly', false );
	$('#authdate').jqxDateTimeInput({ disabled: false});
	$('#docno').attr('readonly', true);
}
function setValues() {
	 if($('#authdatehidden').val()){
			$("#authdate").jqxDateTimeInput('val', $('#authdatehidden').val());

	 }
	 if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
}
function funFocus(){
	document.getElementById("auth").focus();
	}
	function funNotify(){
		return 1;
	}
	    $(function(){
	        $('#frmAuthority').validate({
	                 rules: {
	                 auth: {
	                	required:true,
	                	maxlength:8
	                 },
	                authname:{
	                	required:true,
	                	maxlength:25
	                }
	                 },
	                 messages: {
	                  auth:{
	                	  required:" *",
	                	  maxlength:"max 8 chars"
	                  },
	                  authname:{
	                	  required:" *",
	                	  maxlength:"max 25 chars"
	                  }
	                 }
	        });});
	    function funExcelBtn(){
	    	 $("#jqxAuthoritySearch1").jqxGrid('exportdata', 'xls', 'Authority');
	    }
</script>

</head>
<body onload="setValues();" >
<div id="mainBG" class="homeContent" data-type="background">
<%-- <%@include file="../../../../../header.jsp" %><br/> --%>
<form id="frmAuthority" action="saveActionAuthority" autocomplete="off">     
	<jsp:include page="../../../../header.jsp" />
	<br/> 

<fieldset><legend>Authority Details</legend><table width="100%">

<tr>
  <td width="6%">&nbsp;</td>
  <td width="21%">&nbsp;</td>
  <td width="6%">&nbsp;</td>
  <td>&nbsp;</td>
  <td width="30%"><div align="right">Doc No    </div></td>
  <td width="16%"><input type="text" name="docno" id="docno" readonly="readonly" value='<s:property value="docno"/>'></td>
<tr>
  <td><div align="right">Date</div></td>
  <td><div id="authdate" name="authdate"></div></td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td colspan="2">&nbsp;</td>
<tr><td><div align="right">Authority</div></td>
  <td><input type="text" name="auth" id="auth" value='<s:property value="auth"/>'></td>
  <td><div align="right">Name</div></td><td width="21%"><input type="text" name="authname" id="authname" value='<s:property value="authname"/>'style="width:85%;"></td><td colspan="2">&nbsp;</td>
</table>
</fieldset>
<input type="hidden" id="authdatehidden" name="authdatehidden" value='<s:property value="authdatehidden"/>'/>					
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>

<input type="hidden" id="mode" name="mode"/>
</form>
<br/>
<div id="jqxAuthoritySearch1"></div><%-- 
<div id="window">
<div id="windowHeader" class="windowHead">
<span> <img src="../../../../icons/search_new.png" alt="" style="margin-right: 15px" />Search</span>
</div>
<div id="windowContent" class="windowCont" style="overflow: hidden;">
<jsp:include page="authoritySearch.jsp"></jsp:include>
</div></div> --%>
</div>
</body>
</html>