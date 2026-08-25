
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
	String contextPath=request.getContextPath();
 %>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 

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

	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     $('#clientsearch1').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
		  $('#clientsearch1').jqxWindow('close');
/* 
	       $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
		   $('#accountSearchwindow').jqxWindow('close');
 */	

 	$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
 	$("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	
 	var year = window.parent.txtaccountperiodfrom.value;
	 var newDate = year.split('-');
	 year = newDate[1] + "-" + newDate[0] + "-" + newDate[2];
	 $('#fromdate ').jqxDateTimeInput('setDate', new Date(year));
	 
     $('#txtclient').dblclick(function(){
		   
    	 $('#clientsearch1').jqxWindow('open');
    	 clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1')); 
		   		
		 });
	 
	   
	  
});

function funExportBtn(){
	JSONToCSVCon(dataExcelExport, 'SurveySchedulerList', true);
}

function funreload(event)
{

	 var barchval = document.getElementById("cmbbranch").value;
	 var fromdate = $('#fromdate').val();
	 var todate = $('#todate').val();
	 var clientid=$('#clientid').val();
	 var salesmanid=$("#cmbsalesman").val();

	// var rds=$('#ctype').val();
	 $("#overlay, #PleaseWait").show();
	 $("#loadgriddata").load("gridDetails.jsp?barchval="+barchval+"&salesmanid="+salesmanid+"&clientid="+clientid+'&fromdate='+fromdate+'&todate='+todate+"&rds=1");
	
	  
	}


function funCreate()
{
	
	var ins=0;
	var rows = $("#jqxEstPriceGrid").jqxGrid('getrows');   
	
	var rfqarray=new Array();
		/* if(rows.length>0 && (rows[0].rowno=="undefined" || rows[0].rowno==null || rows[0].rowno=="")){
			return false;
		} */
			       var selectedrows=$("#jqxEstPriceGrid").jqxGrid('selectedrowindexes');
	    
		if(selectedrows.length==0){
			$.messager.alert('Warning','Select a document');
			return false;
		}
		   $.messager.confirm('Confirm', 'Do you want to Create RFQ?', function(r){
	 			if (r){ 
	 				
	 				var i=0;
	 		   
				 
				    for (i = 0; i < rows.length; i++) {
						for(var j=0;j<selectedrows.length;j++){
							
							if(selectedrows[j]==i){
								var rowno=rows[i].doc_no;
								var productid=rows[i].productid;
								var productname=rows[i].productname;
								var prodoc=rows[i].prodoc;
								var brandname=rows[i].brandname;
								var unit=rows[i].unit;
								var unitdocno=rows[i].unitdocno;
								var psrno=rows[i].psrno;
								var specid=rows[i].specid;
								var purqty=rows[i].qty;
								
							rfqarray.push(rowno+"::"+productid+"::"+productname+"::"+prodoc+"::"+brandname+"::"+unit+"::"+unitdocno+"::"+psrno+"::"+specid+"::"+purqty);
							}
						
							}
						
						}
			
						if(i==rows.length){
							
							openFRQ(rfqarray);
						}
			
			 			}
			 	 		});
}
function getclinfo(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#clientsearch1').jqxWindow('open');
	 clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1'));    }
	 else{
		 }
	 } 
    function clientSearchContent(url) {
          
              $.get(url).done(function (data) {
 
	           $('#clientsearch1').jqxWindow('setContent', data);

   	}); 
        	}

function openFRQ(rfqarray)
{
//alert(rfqarray);
	 var url=document.URL;
 		var reurl=url.split("com/");
 		var mod="A";
 		window.parent.formName.value="Purchase Request For Quote";
 		window.parent.formCode.value="RFQ";
 		var detName= "Purchase Request For Quote";
 		 var path1='com/Procurement/Purchase/purchaserequestforquote/purchaserequestforquote.jsp';
 
    		    var path= path1+"?mod="+mod+"&rfqarray="+rfqarray;
    		  
 		top.addTab( detName,reurl[0]+""+path);
}
function getSalesman() {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
		//alert(items);
			items = items.trim().split('####');
			var salIdItems  = items[0].split(",");
			var salItems = items[1].split(",");
			var salusrlink= items[2].split(",");
			var optionssal="" ;
			var userid='<%=session.getAttribute("USERID").toString()%>';
			var first=salIdItems[0].trim();
			var frstsalusrlink=salusrlink[0].trim();
			/* if(userid!=first){
				optionssal += '<option value="" selected>--Select--</option>';
			} */
			for (var i = 0; i < salItems.length; i++) {
				optionssal += '<option value="' + salIdItems[i].trim() + '">'
						      + salItems[i] + '</option>';
				
			}
			if(userid!=frstsalusrlink){
			optionssal += '<option value="a">All</option>';
			}
			$("select#cmbsalesman").html(optionssal);
			 if ($('#hidcmbsalesman').val() != null) {
				$('#cmbsalesman').val($('#hidcmbsalesman').val());
			} 
			 if(userid==frstsalusrlink){
					$('#cmbsalesman').val(first);
			}
			 else{
				 $('#cmbsalesman').val("a");
			 }
		} else {
			//alert("Error");
		}
	}
	x.open("GET",'salesmanonload.jsp', true);
	x.send();
}

	
</script>
</head>
<body onload="getBranch(),getSalesman();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

<table width="100% "  >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td align="right"><label class="branch">From</label></td>
     <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr> 
	 <tr><td align="right"><label class="branch">To</label></td>
     <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td></tr> 
     <tr><td align="right"><label class="branch">Client</label></td>
	 <td ><input style="height:19px;" type="text" name="txtclient" id="txtclient" value='<s:property value="txtclient"/>' onKeyDown="getclinfo(event);" readonly placeholder="Press F3 to Search">
     <input type="hidden" id="clientid" name="clientid" value='<s:property value="clientid"/>'></td></tr>       
     <tr><td align="right"><label class="branch">Salesman</label></td>
	 <td><select id="cmbsalesman" name="cmbsalesman" style="width:100%;" value='<s:property value="cmbsalesman"/>'>
     <option value="">--Select--</option></select>
     <input type="hidden" id="hidcmbsalesman" name="hidcmbsalesman" value='<s:property value="hidcmbsalesman"/>'/></td></tr>
   	 <tr><td colspan="2">&nbsp;</td></tr> 
	 <!-- <tr><td> <label class="branch">ALL</label></td>
     <td>   <input type="radio" id="radio_all" name="category" value="ALL" checked="checked">  
	 &nbsp;&nbsp; <label class="branch">SJOB</label>
     <input type="radio" id="radio_sjob" name="category" value="SJOB" >
     &nbsp;&nbsp; <label class="branch">AMC</label><input type="radio" id="radio_amc" name="category" value="AMC" > -->
         
     <!--  <tr><td colspan="2" align="center"><button class="myButton" type="button" id="btncreate" name="btncreate" onclick="funCreate(event);">Create RFQ</button></td></tr> -->
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
	 <tr><td colspan="2">&nbsp;</td></tr>
	</table>
	</fieldset>
   <%-- <input type="hidden" id="acno" name="acno" value='<s:property value="acno"/>'> --%>
</td>
<td width="80%">
	<table width="100%">
	<tr><td><div id="loadgriddata"><jsp:include page="gridDetails.jsp"></jsp:include></div></td></tr>
		
	</table>
</tr>
</table>
<div id="clientsearch1">
   <div ></div>
</div>
</div>
 
</div>
</body>
</html>