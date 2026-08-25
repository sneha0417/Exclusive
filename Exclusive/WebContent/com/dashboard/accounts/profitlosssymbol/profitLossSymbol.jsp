<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<style type="text/css">
.account {
	color: black;
	background-color: #E0ECF8;
	width: 100%;
	height: 28px;
	font-family: Myriad Pro;
	font-weight: bold;
}
.accname {
	color: black;
	background-color: #E0ECF8;
	width: 100%;
	font-family: comic sans ms;
}

</style>
<script type="text/javascript">
    
	var selectedBox = null;
	
	$(document).ready(function () {
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     
		 var year = window.parent.txtaccountperiodfrom.value;
		 var newDate = year.split('-');
		 year = newDate[1] + "-" + newDate[0] + "-" + newDate[2];
		 $('#fromdate ').jqxDateTimeInput('setDate', new Date(year));
	     
	     /* document.getElementById("hidchckgroup").value=1;
 		 document.getElementById("chckgroup").checked = true; */
 		 
 		 $(".chcklevels").click(function() {
 	        selectedBox = this.id;

 	        $(".chcklevels").each(function() {
 	            if ( this.id == selectedBox )
 	            {
 	                this.checked = true;
 	            }
 	            else
 	            {
 	                this.checked = false;
 	            };        
 	        });
 	    });    
 		 
		 document.getElementById("hidchcklevel4").value=1;
 		 document.getElementById("chcklevel4").checked = true;
	});
	
	function isNumber(evt) {
        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
         {
          $.messager.alert('Message',' Enter Numbers Only ','warning');    
            return false;
         }
        return true;
    }
	
	function analysischeck(){
		 if(document.getElementById("chckanalysis").checked){
			 document.getElementById("hidchckanalysis").value = 1;
			 $('#txtnoofdays').val("0");
 			 $('#txtfrequency').val("0");
		 }
		 else{
			 document.getElementById("hidchckanalysis").value = 0;
		 }
		 hidedata();
	 }
	
	function checklevel1(){
		if(document.getElementById("chcklevel1").checked){
			 document.getElementById("hidchcklevel1").value = 1;
			 document.getElementById("hidchcklevel2").value = 0;
			 document.getElementById("hidchcklevel3").value = 0;
			 document.getElementById("hidchcklevel4").value = 0;
		 }
		 else{
			 document.getElementById("hidchcklevel1").value = 0;
		 }
	 }
	
	function checklevel2(){
		 if(document.getElementById("chcklevel2").checked){
			 document.getElementById("hidchcklevel2").value = 1;
			 document.getElementById("hidchcklevel1").value = 0;
			 document.getElementById("hidchcklevel3").value = 0;
			 document.getElementById("hidchcklevel4").value = 0;
		 }
		 else{
			 document.getElementById("hidchcklevel2").value = 0;
		 }
	 }
	
	function checklevel3(){
		 if(document.getElementById("chcklevel3").checked){
			 document.getElementById("hidchcklevel3").value = 1;
			 document.getElementById("hidchcklevel1").value = 0;
			 document.getElementById("hidchcklevel2").value = 0;
			 document.getElementById("hidchcklevel4").value = 0;
		 }
		 else{
			 document.getElementById("hidchcklevel3").value = 0;
		 }
	 }
	
	function checklevel4(){
		 if(document.getElementById("chcklevel4").checked){
			 document.getElementById("hidchcklevel4").value = 1;
			 document.getElementById("hidchcklevel1").value = 0;
			 document.getElementById("hidchcklevel2").value = 0;
			 document.getElementById("hidchcklevel3").value = 0;
		 }
		 else{
			 document.getElementById("hidchcklevel4").value = 0;
		 }
	 }
	
	function hidedata(){
  		var analysis=$('#hidchckanalysis').val();
  		
  		if(parseInt(analysis)==1){
  			   $("#analysisDiv").prop("hidden", false);
  			   $("#viewDiv").attr("hidden", true);
  			}
  			else{
  				$("#analysisDiv").prop("hidden", true);
  				$("#viewDiv").attr("hidden", false);
  			}
  		}
	
	 function funreload(event){
		 var branchval = document.getElementById("cmbbranch").value;
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var level1 = $('#hidchcklevel1').val();
		 var level2 = $('#hidchcklevel2').val();
		 var level3 = $('#hidchcklevel3').val();
		 var level4 = $('#hidchcklevel4').val();
		 var check=1;
		 
		 $("#overlay, #PleaseWait").show();

		 $("#profitLossDiv").load("profitLossSymbolGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&level1='+level1+'&level2='+level2+'&level3='+level3+'&level4='+level4+'&check='+check);
		}
		
		function funExportBtn(){
		 if(parseInt(window.parent.chkexportdata.value)=="1") {
		  	JSONToCSVCon(dataExcelExport, 'ProfitAndLossSymbol', true);
		 } else {
			 $("#profitLossGrid").jqxTreeGrid('exportData', 'xls');
		 }
	 }
	
</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
  <tr>
    <td width="20%" >
    <fieldset style="background: #ECF8E0;">
	 <table width="100%"  >
	 <jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2"><table width="100%">
     <tr><%-- <td colspan="2" align="center"><input type="checkbox" id="chckanalysis" name="chckanalysis" value="" onchange="analysischeck();" onclick="$(this).attr('value', this.checked ? 1 : 0)"><label class="branch">Analysis</label>
	 <input type="hidden" id="hidchckanalysis" name="hidchckanalysis" value='<s:property value="hidchckanalysis"/>'/></td> --%>
     <td colspan="2">&nbsp;</td>
     </tr>
     <tr><td align="right"><label class="branch">Period</label></td>
         <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td>
     </tr>
     </table></tr> 
	 <tr><td colspan="2"><div id="viewDiv">
	 <%-- <table width="100%">
     <tr>
     <td colspan="2">
     <table width="100%">
	  <tr>
	    <td width="17%" align="right"><label class="branch">To</label></td>
        <td width="83%" align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
	 </tr>
	 </table>
     </td>
     
     </tr>
     <tr>
     <td colspan="2">&nbsp;</td>
     </tr>
     <tr>
      <td colspan="2"><fieldset><legend><b><label class="branch">View</label></b></legend>
	  <table width="100%">
	  <tr>
	    <td width="40%"><input type="checkbox" id="chckdetail" name="chckdetail" value="" onchange="detailcheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)"><label class="branch">Detail</label>
	    <input type="hidden" id="hidchckdetail" name="hidchckdetail" value='<s:property value="hidchckdetail"/>'/></td>
	    <td width="60%"><input type="checkbox" id="chckgroup" name="chckgroup" value="" onchange="groupcheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)"><label class="branch">Group</label>
	    <input type="hidden" id="hidchckgroup" name="hidchckgroup" value='<s:property value="hidchckgroup"/>'/></td>
	 </tr>
	 </table>
	 </fieldset></td>
     </tr>
     <tr><td colspan="2">&nbsp;</td></tr>
      <tr><td align="right"><label class="branch">Description</label></td>
	 <td align="left"><input type="text" id="txtdescription" name="txtdescription" style="width:100%;height:20px;" value='<s:property value="txtdescription"/>'/></td></tr>
	<tr><td align="right"><label class="branch">Group</label></td>
	 <td align="left"><input type="text" id="txtgroup" name="txtgroup" style="width:100%;height:20px;" value='<s:property value="txtgroup"/>'/></td></tr>
	<tr><td align="right"><label class="branch">Amount</label></td>
	 <td align="left"><input type="text" id="txtamount" name="txtamount" style="width:100%;height:20px;text-align: right;" onkeypress="javascript:return isNumber(event)" onblur="funRoundAmt(this.value,this.id);" value='<s:property value="txtamount"/>'/></td></tr>
    </table> --%>
    
    <table width="100%">
     <tr><td colspan="2">
     <table width="100%"><tr>
	    <td width="17%" align="right"><label class="branch">To</label></td>
        <td width="83%" align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td></tr></table>
     </td></tr>
     <tr><td colspan="2">&nbsp;</td></tr>
     <tr><td colspan="2"><fieldset><legend><b><label class="branch">Levels</label></b></legend>
     <table width="100%">
	  <tr><td colspan="2">
     <input type="checkbox" id="chcklevel1" name="chcklevel1" class="chcklevels" value="" onchange="checklevel1();" onclick="$(this).attr('value', this.checked ? 1 : 0)"><label class="branch">Level 1</label>
	    <input type="hidden" id="hidchcklevel1" name="hidchcklevel1" value='<s:property value="hidchcklevel1"/>'/></td></tr>
    <tr><td colspan="2"><input type="checkbox" id="chcklevel2" name="chcklevel2" class="chcklevels" value="" onchange="checklevel2();" onclick="$(this).attr('value', this.checked ? 1 : 0)"><label class="branch">Level 2</label>
	    <input type="hidden" id="hidchcklevel2" name="hidchcklevel2" value='<s:property value="hidchcklevel2"/>'/></td></tr>
    <tr><td colspan="2"><input type="checkbox" id="chcklevel3" name="chcklevel3" class="chcklevels" value="" onchange="checklevel3();" onclick="$(this).attr('value', this.checked ? 1 : 0)"><label class="branch">Level 3</label>
	    <input type="hidden" id="hidchcklevel3" name="hidchcklevel3" value='<s:property value="hidchcklevel3"/>'/></td></tr>
	<tr><td colspan="2"><input type="checkbox" id="chcklevel4" name="chcklevel4" class="chcklevels" value="" onchange="checklevel4();" onclick="$(this).attr('value', this.checked ? 1 : 0)"><label class="branch">Level 4</label>
	    <input type="hidden" id="hidchcklevel4" name="hidchcklevel4" value='<s:property value="hidchcklevel4"/>'/></td></tr>
	</table></fieldset>
	</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
    </table>
    </div></td></tr>
	<tr><td colspan="2"><div id="analysisDiv" hidden="true"><table width="100%">
    <tr>
      <td colspan="2"><select id="cmbchoose" name="cmbchoose" style="width:30%;" value='<s:property value="cmbchoose"/>'>
      <option value="1">Days</option><option value="2">Monthly</option>
      <option value="3">Quarterly</option><option value="4">Yearly</option></select>&nbsp;&nbsp;
      <input type="text" id="txtnoofdays" name="txtnoofdays" style="width:50%;height:20px;" value='<s:property value="txtnoofdays"/>'/>
      </td>
    </tr>
    <tr><td width="10%" align="right"><label class="branch">Frequency</label></td>
	  <td width="90%" align="left"><input type="text" id="txtfrequency" name="txtfrequency" style="width:82%;height:20px;" value='<s:property value="txtfrequency"/>'/></td></tr>
    <tr><td colspan="2">&nbsp;</td></tr>
    <tr><td colspan="2">&nbsp;</td></tr>
    <tr><td colspan="2">&nbsp;</td></tr>
    <tr><td colspan="2">&nbsp;</td></tr>
    <tr><td colspan="2">&nbsp;</td></tr>
    <tr><td colspan="2">&nbsp;</td></tr>
    <tr><td colspan="2">&nbsp;<br/><br/></td></tr>
    </table></div></td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		 <tr>
		    <td><div id="profitLossDiv"><jsp:include page="profitLossSymbolGrid.jsp"></jsp:include></div></td>
		 </tr> 
	</table>
</td></tr>
</table>
</div>

</div> 
</body>
</html>