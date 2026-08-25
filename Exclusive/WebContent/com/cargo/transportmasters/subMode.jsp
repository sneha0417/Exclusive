<%@page import="com.cargo.transportmasters.submode.ClsSubModeDAO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="s" uri="/struts-tags"%>
    <% ClsSubModeDAO cd=new ClsSubModeDAO(); %>
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
	 $("#submodedate").jqxDateTimeInput({width : '125px',height : '15px',formatString : "dd.MM.yyyy"});
	 
	 
	 //grid
	    document.getElementById("formdet").innerText="Sub Mode (SBM)";
		document.getElementById("formdetail").value="Sub Mode";
		document.getElementById("formdetailcode").value="SBM";
		window.parent.formCode.value="SBM";
		window.parent.formName.value="Sub Mode";	 
		
 
			var subdata= '<%=cd.getSubModeGrid()%>';
	
	 var source =
	 {
	     datatype: "json",
	     datafields: [

	               	{name : 'doc_no' , type: 'int' },
	               	{name : 'date', type: 'date'  },
	 				{name : 'modename', type: 'String'  },
	               	{name : 'submode', type: 'String'  },
	               	{name : 'modeid', type: 'int'  }
	               	
	      ],
	      localdata: subdata,
	     
	     
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
	 $("#submodegridid").jqxGrid(
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
	 				{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '20%' },
	 				{ text: 'Date',datafield: 'date',filtertype: 'date', width: '30%', cellsformat:'dd.MM.yyyy' },
	 				{ text: 'Mode', datafield: 'modename',filtertype: 'list', width: '25%' },
	 				{ text: 'Sub Mode', datafield: 'submode', width: '25%',filtertype: 'textbox' },
	 				{ text: 'Mode Id',filtertype: 'number', datafield: 'modeid', width: '20%' , hidden: true },
	 			

	               ]
	         });
	
	 $('#submodegridid').on('rowdoubleclick', function (event) {
         var rowindex1=event.args.rowindex;
         $('#cmbmode').attr('disabled', false);
         getMode();
         
         document.getElementById("docno").value= $('#submodegridid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
         $("#submodedate").jqxDateTimeInput('val', $("#submodegridid").jqxGrid('getcellvalue', rowindex1, "date"));
         document.getElementById("submodeid").value = $("#submodegridid").jqxGrid('getcellvalue', rowindex1, "submode");
         document.getElementById("cmbmodeid").value = $("#submodegridid").jqxGrid('getcellvalue', rowindex1, "modeid");
         
         //$('#cmbmode').attr('disabled', true);
         $('#window').jqxWindow('close');
     }); 
     
     
});

function funFocus(){
	document.getElementById("cmbmode").focus();
}

function funReadOnly() {
	$('#docno').attr('readonly', true);
	$('#submodedate').jqxDateTimeInput({ disabled: true}); 
	$('#cmbmode').attr('disabled', true);
	$('#submodegridid').attr('disabled', true);
	$('#submodeid').attr('readonly', true);
}

function funRemoveReadOnly() {
	$('#submodedate').jqxDateTimeInput({ disabled: false}); 
	$('#cmbmode').attr('disabled', false);
	
	$('#submodegridid').attr('disabled', false);
	$('#submodeid').attr('readonly', false);
	
	if ($("#mode").val() == "A") {
		$('#submodedate').val(new Date());
		
	}
}

function setValues() {
	
	
}
function funNotify(){
	if(document.getElementById("submodeid").value==''){
		document.getElementById("errormsg").innerText="Submode is Mandatory.";
		return 0;
	}
	return 1;
}

function funChkButton() {
	   /* funReset(); */
	  }
	  
function funSearchLoad(){
	
	changeContent('subModeSearch.jsp'); 
 }
	  
function getMode() {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			items = items.split('####');
			
			var srno  = items[0].split(",");
			var process = items[1].split(",");
			var optionsbranch = '<option value="" selected>-- Select -- </option>';
			for (var i = 0; i < process.length; i++) {
				optionsbranch += '<option value="' + srno[i].trim() + '">'
						+ process[i] + '</option>';
			}
			
			$("select#cmbmode").html(optionsbranch);
			if ($('#cmbmodeid').val() != null) {
				$('#cmbmode').val($('#cmbmodeid').val());
			}
			
		} else {}
	}
	x.open("GET","getMode.jsp", true);
	x.send();
}
</script>

<body onload="setValues();getMode();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmSubMode" action="saveSubMode" method="post" autocomplete="off" >
	<jsp:include page="../../../header.jsp" />
	<br/> 
<fieldset><legend>SubMode</legend>
<table width="100%">
    <tr>
     <td width="6%"; align="right">Date</td>
     <td width="60%";><div id="submodedate" name="submodedate" value='<s:property value="submodedate"/>'></div></td><td></td>
     <td align="right">Doc No</td>
    <td width="15%";><input type="text" name="docno" id="docno" tabindex="-1" value='<s:property value="docno"/>'></td><td></td>
  </tr>
   <tr>
    <td align="right">Mode</td>
     <td><select id="cmbmode" placeholde="--select--" name="cmbmode" value='<s:property value="cmbmode"/>' style="width:25%;">
     <option></option></select></td>
     <td colspan="2">&nbsp;</td>
  </tr>
  <tr>
    <td align="right">Submode</td>
   <td><input type="text" name="submodeid" id="submodeid" style="width:25%;" value='<s:property value="submodeid"/>'></td>
   <td colspan="2">&nbsp;</td>
    </tr>
  </table>
</fieldset>


<input type="hidden" name="cmbmodeid" id="cmbmodeid" value='<s:property value="cmbmodeid"/>'/>

<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>

</form>
</div>
<br/>
	
	<tr><td><div id="submodegridid"></div></tr>	
	
	
	</div>
	<div>
	</div>
	 </div> 
</body>
</html>