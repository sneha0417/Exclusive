<%@page import="com.cargo.transportmasters.mode.ClsModeDAO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="s" uri="/struts-tags"%>
    <%  ClsModeDAO cd= new ClsModeDAO (); %>
    
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../includes.jsp"></jsp:include>
 
<script type="text/javascript">
$(document).ready(function () {     
	 $("#modedate").jqxDateTimeInput({width : '125px',height : '15px',formatString : "dd.MM.yyyy"});
	    
	   
	 
	    document.getElementById("formdet").innerText="Mode (CTM)";
		document.getElementById("formdetail").value="Mode";
		document.getElementById("formdetailcode").value="CTM";
		window.parent.formCode.value="CTM";
		window.parent.formName.value="Mode";	
		
		
		
			
		var data= '<%=cd.getModeGrid()%>';
		
		 var source =
		 {
		     datatype: "json",
		     datafields: [
		               	{name : 'doc_no' , type: 'int' },
		 				{name : 'date', type: 'date'  },
		               	{name : 'modename', type: 'String'  },
		               	
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
		 $("#modegridid").jqxGrid(
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
		 				{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '30%' },
		 				{ text: 'Date',datafield: 'date',filtertype: 'date', width: '30%', cellsformat:'dd.MM.yyyy' },
		 				{ text: 'Mode', datafield: 'modename',filtertype: 'list', width: '40%' },
		 			

		               ]
		         
		         });

		 $('#modegridid').on('rowdoubleclick', function (event) {
             var rowindex1=event.args.rowindex;
             
             document.getElementById("docno").value= $('#modegridid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
             $("#modedate").jqxDateTimeInput('val', $("#modegridid").jqxGrid('getcellvalue', rowindex1, "date"));
             document.getElementById("modeid").value = $("#modegridid").jqxGrid('getcellvalue', rowindex1, "modename");
      
             
             $('#window').jqxWindow('hide');
         }); 

      
});

function funFocus(){
	document.getElementById("modeid").focus();
}

function funReadOnly() {
	$('#docno').attr('readonly', true);
	$('#modedate').jqxDateTimeInput({ disabled: true}); 
	$('#modeid').attr('readonly', true);
	$('#modegridid').attr('disabled', true);
}

function funRemoveReadOnly() {
	$('#modedate').jqxDateTimeInput({ disabled: false}); 
	$('#modeid').attr('readonly', false);
	$('#docno').attr('readonly', true);
	$('#modegridid').attr('disabled', false);
}

function setValues() {
	if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
	
}
function funNotify(){
	 if(document.getElementById("modeid").value==''){
			document.getElementById("errormsg").innerText="Mode is Mandatory.";
			return 0;
		}
	return 1;
}

function funChkButton() {
	   /* funReset(); */
	  }
function funSearchLoad(){
	
	changeContent('modeSearch.jsp'); 
 }
</script>

<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmMode" action="saveActionMode" method="post" autocomplete="off" >
	<jsp:include page="../../../header.jsp" />
	<br/> 
<fieldset><legend>Mode</legend>
<table width="100%">
 
  <tr>
    <td align="RIGHT">Date</td>
     <td><div id="modedate" name="modedate" value='<s:property value="modedate"/>'></div></td><td></td>

    <td align="RIGHT">Mode</td>
   <td><input type="text" name="modeid" id="modeid" value='<s:property value="modeid"/>'></td>
  
    <td align="right">Doc No</td>
    <td width="15%";><input type="text" name="docno" id="docno" tabindex="-1" value='<s:property value="docno"/>'></td><td></td>
    </tr>
 
  </table>
</fieldset>


<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>

</form>
</div>
<br/>
	
<tr><td><div id="modegridid"></div></tr>	
	
	
	</div>
	<div>
	</div>
	 </div> 
</body>
</html>