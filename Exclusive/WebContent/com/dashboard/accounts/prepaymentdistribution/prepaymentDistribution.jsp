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
	-moz-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	-webkit-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	box-shadow:inset 0px -1px 3px 0px #91b8b3;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	
	font-size:8pt;
	
	padding:3px 17px;
	text-decoration:none;
	text-shadow:0px -1px 0px #2b665e;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButtons:active {
	position:relative;
	top:1px;
}

</style>

<script type="text/javascript">

	$(document).ready(function () {
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
	     $('#documentSearchWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Document Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#documentSearchWindow').jqxWindow('close');
		 
	     $('#prepaymentDistributionGridWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#prepaymentDistributionGridWindow').jqxWindow('close');
		 
		 $('#costTypeSearchGridWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Type Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#costTypeSearchGridWindow').jqxWindow('close');
 		 
 		 $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Code Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costCodeSearchWindow').jqxWindow('close');
		 
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
	     $('#txtdocumentno').dblclick(function(){
	    	 var branchval = document.getElementById("cmbbranch").value;
			 var fromdate = $('#fromdate').val();
			 var todate = $('#todate').val();
	    	 documentSearchContent('documentSearchGrid.jsp?branchval='+branchval+'&fromdate='+fromdate+'&todate='+todate+'&check=1');
	     });
	});
	
	function documentSearchContent(url) {
	 	$('#documentSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#documentSearchWindow').jqxWindow('setContent', data);
		$('#documentSearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function prepaymentDistributionSearchContent(url) {
	 	$('#prepaymentDistributionGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#prepaymentDistributionGridWindow').jqxWindow('setContent', data);
		$('#prepaymentDistributionGridWindow').jqxWindow('bringToFront');
	}); 
	}

	function costTypeSearchContent(url) {
	    $('#costTypeSearchGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#costTypeSearchGridWindow').jqxWindow('setContent', data);
		$('#costTypeSearchGridWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function costCodeSearchContent(url) {
	    $('#costCodeSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#costCodeSearchWindow').jqxWindow('setContent', data);
		$('#costCodeSearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getDocument(event){
        var x= event.keyCode;
        if(x==114){
        	var branchval = document.getElementById("cmbbranch").value;
			 var fromdate = $('#fromdate').val();
			 var todate = $('#todate').val();
	    	 documentSearchContent('documentSearchGrid.jsp?branchval='+branchval+'&fromdate='+fromdate+'&todate='+todate+'&check=1');
        }
        else{}
        }
	
	function funGenerate(){
		
		 var rows = $("#prepaymentDistributionGridID").jqxGrid('getrows');
		 var length=0;
		 
		 for(var j=0;j<rows.length;j++){
			 	var chk=rows[j].rowno;
				if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != "" && chk != "0"){
					length=length+1;
					break;
				}
		 }
		 
		 if(parseInt(length)==0){
			 $.messager.alert('Message','Distributing Details to be Entered.','warning');   
			 return false;
		 }
		 
		 $.messager.confirm('Confirm', 'Do you want to Distribute?', function(r){
	  	 		if (r){
	  	 			
	  	 			/* var gridarray=new Array();
	  	 		 	for(var i=0;i<rows.length;i++){
		  	 		 	var chk=rows[i].rowno;
						if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != "" && chk != "0"){
							
							var tranid = $('#prepaymentDistributionGridID').jqxGrid('getcellvalue', i, "tranid");
							var trno = $('#prepaymentDistributionGridID').jqxGrid('getcellvalue', i, "trno");
			     		 	var acno = $('#prepaymentDistributionGridID').jqxGrid('getcellvalue', i, "acno");
			     		 	var postacno = $('#prepaymentDistributionGridID').jqxGrid('getcelltext', i, "postacno");
			     		 	var stdate = $('#prepaymentDistributionGridID').jqxGrid('getcelltext', i, "stdate");
			     		 	var enddate = $('#prepaymentDistributionGridID').jqxGrid('getcelltext', i, "enddate");
			     		    var costtype = $('#prepaymentDistributionGridID').jqxGrid('getcelltext', i, "costtype");
			     		    var costcode = $('#prepaymentDistributionGridID').jqxGrid('getcelltext', i, "costcode");
			     		    var amount = $('#prepaymentDistributionGridID').jqxGrid('getcellvalue', i, "dramount");
			     		    var brhid = $('#prepaymentDistributionGridID').jqxGrid('getcelltext', i, "brhid");
				     		 	
							gridarray.push(tranid+":: "+acno+":: "+postacno+":: "+stdate+":: "+enddate+":: "+costtype+":: "+costcode+":: "+amount+":: "+brhid+":: "+trno);
							
						}
	  	 		 	}*/
	  	 		 	
	  	 		    $("#overlay, #PleaseWait").show();
	  	 		    var mode = $('#mode').val();
	  	 		 	var fromdate = $('#fromdate').val();
	  			 	var todate = $('#todate').val();
	  			 	var docno = $('#txtdocno').val();
	  	 		 	saveData(mode,fromdate,todate,docno);
	  	 		}
	  	 		
		 });
	}
	
	function saveGridData(docno,dtype,date,trno,tranid,acno,postacno,stdate,enddate,costtype,costcode,amount,brhid,mode){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;
				
				if(parseInt(items)>0 && $('#mode').val()=='E') {
					$.messager.alert('Message', '  Record Successfully Updated ', function(r){
				    });
				} 
			  $('#mode').val('');
		      funreload(event); 
		  }
		}
			
	x.open("GET","saveGridData.jsp?docno="+docno+"&dtype="+dtype+"&date="+date+"&trno="+trno+"&tranid="+tranid+"&acno="+acno+"&postacno="+postacno+"&stdate="+stdate+"&enddate="+enddate+"&costtype="+costtype+"&costcode="+costcode+"&amount="+amount+"&brhid="+brhid+"&mode="+mode,true);
	x.send();
	}
	
	function saveData(mode,fromdate,todate,docno) {
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;
				if(parseInt(items)>0) {
					$.messager.alert('Message', ' Distributed Successfully.', function(r){
					});
				}  else {
					$.messager.alert('Message', ' Failed', function(r){
					});
				}
				$('#mode').val('');
			    funreload(event); 
				
		  }
		}
			
		
	x.open("GET","saveData.jsp?mode="+mode+"&fromdate="+fromdate+"&todate="+todate+"&docno="+docno,true);
	x.send();
	}
	
	function funClearInfo(){
		
		 $('#cmbbranch').val('a');
 	 	 $('#fromdate').val(new Date());
 	 	 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
		 $('#todate').val(new Date());
		 
		 document.getElementById("txtdocumentno").value="";document.getElementById("txtdocno").value="";document.getElementById("mode").value="";
		 $("#prepaymentDistributionGridID").jqxGrid('clear');
		 
		 if (document.getElementById("txtdocumentno").value == "") {
		        $('#txtdocumentno').attr('placeholder', 'Press F3 to Search'); 
		 }
	}

	function funreload(event){
		 var branchval = document.getElementById("cmbbranch").value;
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var docno = $('#txtdocno').val();
		 $("#overlay, #PleaseWait").show();
		 
		 $("#prepaymentDistributionDiv").load('prepaymentDistributionGrid.jsp?branchval='+branchval+'&fromdate='+fromdate+'&todate='+todate+'&docno='+docno+'&check=1');
		}

	function funExportBtn(){
		 if(parseInt(window.parent.chkexportdata.value)=="1") {
		  	JSONToCSVCon(data, 'PrepaymentDistributor', true);
		 } else {
			 $("#prepaymentDistributionGridID").jqxGrid('exportdata', 'xls', 'PrepaymentDistributor');
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
	 <tr>
	 <td align="right"><label class="branch">Period</label></td>
     <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr> 
	<tr>
	<td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
	</tr>  
	<tr><td width="6%" align="right"><label class="branch">DocNo</label></td>
    <td><input type="text" id="txtdocumentno" name="txtdocumentno" style="width:95%;height:20px;" onKeyDown="getDocument(event);" readonly placeholder="Press F3 to Search" value='<s:property value="txtdocumentno"/>' />
    <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/></td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();">
    <button class="myButton" type="button" id="btnGenerate" name="btnGenerate" onclick="funGenerate();">Generate</button></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>	
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2"><input type="hidden" name="mode" id="mode" style="width:100%;height:20px;" value='<s:property value="mode"/>'></td></tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="prepaymentDistributionDiv"><jsp:include page="prepaymentDistributionGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>
</div>

<div id="documentSearchWindow">
	<div></div><div></div>
</div>

<div id="prepaymentDistributionGridWindow">
	<div></div><div></div>
</div> 

<div id="costTypeSearchGridWindow">
	<div></div><div></div>
</div> 

<div id="costCodeSearchWindow">
	<div></div><div></div>
</div>

</body>
</html>