
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
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<style>
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
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	
     
	  
	$("#cmbbranch").attr('hidden',true); 
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	  
     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	 $('#todate').on('change', function (event) {
			
		   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  }   
	 });
	 
	 
});

function funreload(event)
{

	var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 
	  // out date
	 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
	 	 
	   if(fromdates>todates){
		   
		   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		 
	   return false;
	  } 
	   else
	   {
	

var fromdate= $("#fromdate").val();
var todate= $("#todate").val(); 

var test ="10"; 

$("#Readygrid").load("subgrid.jsp?test="+test+"&from="+fromdate+"&to="+todate);



//  $("#detlist").load("detailsGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate);
 }

	
	}
	
function hiddenbrh(){
	
	$("#branchlabel").attr('hidden',true);
	$("#branchdiv").attr('hidden',true);
	//$('#gridlength').val(""); 
}

 
	
function funExportBtn(){
    
	   JSONToCSVConvertor(leadexceldata, 'Lead Management Followup Log', true);
	   }
	  
	  
	  function JSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {

	      var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
	      
	     // alert("arrData");
	      var CSV = '';    
	      //Set Report title in first row or line
	      
	      CSV += ReportTitle + '\r\n\n';

	      //This condition will generate the Label/Header
	      if (ShowLabel) {
	          var row = "";
	          
	          //This loop will extract the label from 1st index of on array
	          for (var index in arrData[0]) {
	              
	              //Now convert each value to string and comma-seprated
	              row += index + ',';
	          }

	          row = row.slice(0, -1);
	          
	          //append Label row with line break
	          CSV += row + '\r\n';
	      }
	      
	      //1st loop is to extract each row
	      for (var i = 0; i < arrData.length; i++) {
	          var row = "";
	          
	          //2nd loop will extract each column and convert it in string comma-seprated
	          for (var index in arrData[i]) {
	              row += '"' + arrData[i][index] + '",';
	          }

	          row.slice(0, row.length - 1);
	          
	          //add a line break after each row
	          CSV += row + '\r\n';
	      }

	      if (CSV == '') {        
	          alert("Invalid data");
	          return;
	      }   
	      
	      //Generate a file name
	      var fileName = "";
	      //this will remove the blank-spaces from the title and replace it with an underscore
	      fileName += ReportTitle.replace(/ /g,"_");   
	      
	      //Initialize file format you want csv or xls
	      var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);
	      
	      // Now the little tricky part.
	      // you can use either>> window.open(uri);
	      // but this will not work in some browsers
	      // or you will not get the correct file extension    
	      
	      //this trick will generate a temp <a /> tag
	      var link = document.createElement("a");    
	      link.href = uri;
	      
	      //set the visibility hidden so it will not effect on your web-layout
	      link.style = "visibility:hidden";
	      link.download = fileName + ".csv";
	      
	      //this part will append the anchor tag and remove it after automatic click
	      document.body.appendChild(link);
	      link.click();
	      document.body.removeChild(link);
	  }

	  function  funcleardata()
	  {
		  $("#userdetails").jqxGrid('clear');
		    $("#userdetails").jqxGrid('addrow', null, {});
	  	
	   	
	  		  		
	  	}

	
	  
	
	 
</script>
</head>
<body onload="getBranch();hiddenbrh()">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%">
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>

	<!--  <tr><td colspan="2">&nbsp;</td></tr> -->
<!--  <tr><td colspan="2" align="center"><label class="branch">Detail</label><input type="checkbox" id="det_chk"  name="det_chk" value="0"   onclick="funsetaval()" >
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>  -->
	 <tr><td colspan="2">&nbsp;</td></tr>
	  <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr>
                    <tr><td colspan="2">&nbsp;</td></tr>                 
		<tr><td colspan="2">&nbsp;</td></tr>
		 <tr>
	<td colspan="2" ><div id="Readygrid"><jsp:include page="subgrid.jsp"></jsp:include>
	</div></td>
	</tr> 
<tr><td colspan="2">&nbsp;</td></tr>
	
	 <tr>
	 <td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funcleardata()">
	 </td>
	 </tr>
	
<tr><td colspan="2">&nbsp;</td></tr><tr><td colspan="2">&nbsp;</td></tr>
	</table>
	</fieldset>
	
</td>
<td width="80%">
<div  >
	<table width="100%" id="grid1">
	<tr><td ><label name="user" id="user"></label></td></tr> 
		<tr>
			  <td ><div  id="fleetdiv"><jsp:include page="detailsgrid.jsp"></jsp:include></div> 
			</td></tr>
	</table>
</div>
<div >
	<!-- <table width="100%" id="chart">
		<tr>
			 <td width="50%">
			<div id='fleetStatus1' style="width: 100%; height: 250px;"></div>
			  <div id='sec1' style="width: 100%; height: 250px;"></div>
			   </td><td>  <div id='thr1' style="width: 100%; height: 250px;"></div>
			   <div id='four1' style="width: 100%; height: 250px;"></div></td></tr>
	</table> -->
</div>
</tr>
</table>
  
</div>
<div id="clientwindow">
   <div></div>
</div>
</div>

</body>
</html>
