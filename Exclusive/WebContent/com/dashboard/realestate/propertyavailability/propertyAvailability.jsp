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
.myButtons {
	display: inline-block;
	margin-right:4px;
	margin-left:4px; 
  margin-bottom: 0;
  font-weight: normal;
  line-height: 1.3;
  text-align: center;
  white-space: nowrap;
  vertical-align: middle;
  -ms-touch-action: manipulation;
  touch-action: manipulation;
  cursor: pointer;
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
  background-image: none;
  border: 1px solid transparent;
  border-radius: 4px;
  color: #fff;
  background-color: grey;
}
.myButtons:hover {
	  color: #fff;
  background-color: #31b0d5;
  
}
.myButtons:active {
  color: #fff;
  background-color: #31b0d5;
  
}
.myButtons:focus {
  color: #fff;
  background-color: grey;
}
</style>


<script type="text/javascript">

	$(document).ready(function () {
		 $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
	      $('#ptypewindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Product Type Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		  $('#ptypewindow').jqxWindow('close');
	     document.getElementById('managed').checked=true;
	});

	function funExportBtn(){
		
		 $("#propertydiv").excelexportjs({
				containerid: "propertydiv",   
				datatype: 'json',
				dataset: null,
				gridId: "pagrid",
				columns: getColumns("pagrid") ,   
				worksheetName:"Property Info"  
			});   
		}
	
	
	function funreload(event){

		var branchid=document.getElementById("cmbbranch").value;
		var uptodate=$('#uptodate').jqxDateTimeInput('val');
		var managed=0;
		if(document.getElementById("managed").checked){
			managed=1;
		}
	    $('#pagrid').jqxGrid('clear');
		$("#overlay, #PleaseWait").show();
		$("#subgridiv").load("subgrid.jsp?uptodate="+uptodate+"&branchid="+branchid+"&managed="+managed+"&id=1");
			 
		}
	
	function funClearData(){
		$('#propertydet').jqxGrid('clear');
		$('#pagrid').jqxGrid('clear');
	}
	function showPropertyMasterInTab(pdocno) {
		var path1 = "/com/realestate/propertymaster/propertyMaster.jsp";
		var name = "Property Master";
		var url = document.URL;
		var reurl = url.split("/com");         
		var mode = "pview";
		var pavail="1";    

		window.parent.formName.value = "Property Master";    
		window.parent.formCode.value = "PPM";
		var detName = "Property Master";

		var path = path1
				+ "?pdocno="
				+ pdocno
				+ "&mode="
				+ mode
				+ "&pavail="   
				+ pavail;
				/* + "&pname="
				+ pname.replace("/\s/g", "%20").replace('#', '%23').replace(
						'&', '%26'); */
		top.addTab(detName, reurl[0] + "" + path);
	}
	
     function funPrintPA(){  
	        var branchid=document.getElementById("cmbbranch").value;
	        var reloadstatus=document.getElementById("hidreloadstatus").value;
			var uptodate=$('#uptodate').jqxDateTimeInput('val');
			var managed=0;
			if(document.getElementById("managed").checked){
				managed=1;
			}    
		  var url=document.URL;    
	      var reurl=url.split("propertyAvailability.jsp");                 
	      var win= window.open(reurl[0]+"printavailability?uptodate="+uptodate+"&reloadstatus="+reloadstatus+"&branch="+branchid+"&managed="+managed,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	      win.focus();           
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
		<tr>
	 
	 <td align="right"><label class="branch">&nbsp;</label></td> </tr>
     <tr><td align="left"> <label class="branch" >UpTo Date</label> </td><td><div  id="uptodate" name="uptodate" value='<s:property value="uptodate"/>' ></div></td></tr> 
	 <tr><td align="left"> <label class="branch" >Managed</label> </td><td><input type="checkbox"  id="managed" name="managed" value='<s:property value="managed"/>' ></div></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2"><div id="subgridiv"><jsp:include page="subgrid.jsp"></jsp:include></div></td></tr>
	<tr><td colspan="2" align="center"><input type="button" name="btnprint" id="btnprint" value="Print" class="myButtons" onclick="funPrintPA();"></td></tr>
	<tr><td colspan="2" align="center"><input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();"></td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
			<tr><td>
			 <input type="hidden" name="hidbrandid" id="hidbrandid">
			 <input type="hidden" name="hidreloadstatus" id="hidreloadstatus">
			</td></tr>
			  
	
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="propertydiv"><jsp:include page="propertyAvailabilityGrid.jsp"></jsp:include></div></td> 
		</tr>
		   
	</table>
</tr>
</table>
<div id="ptypewindow">
<div></div>
</div>


</div>
</div>
</body>
</html>