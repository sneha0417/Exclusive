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


.textbox {
    border: 0;
    height: 25px;
    width: 20%;
    border-radius: 5px;
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
    box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -moz-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-background-clip: padding-box;
    outline: 0;
}
.hidden-scrollbar {
    overflow: auto;
    
    height: 550px;
}
</style>

<script type="text/javascript">

	$(document).ready(function () {
		
		 
		   
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
				  }})
		   
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     $('#sidesearchwndow').jqxWindow({ width: '30%', height: '70%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Search ' , position: { x: 300, y: 0 }, keyboardCloseKey: 27});
			$('#sidesearchwndow').jqxWindow('close');
			 $('#servicetypewindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Service Type Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			  $('#servicetypewindow').jqxWindow('close');
			  $('#sitewindow').jqxWindow({ width: '25%', height: '60%',  maxHeight: '60%' ,maxWidth: '80%' ,title: ' Site Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			  $('#sitewindow').jqxWindow('close');

	});
	
	 function productSearchContent(url) {
      	 //alert(url);
      		 $.get(url).done(function (data) {
      			 
      			 $('#sidesearchwndow').jqxWindow('open');
      		$('#sidesearchwndow').jqxWindow('setContent', data);
      
      	}); 
      } 
	
	
	 
	function getservicetype(rowBoundIndex){
		 
		  $('#servicetypewindow').jqxWindow('open');

	        serviceSearchContent('servicesearch.jsp?rowBoundIndex='+rowBoundIndex);
	     	 }
	     	 
	function serviceSearchContent(url) {
	
		 $.get(url).done(function (data) {
			
	$('#servicetypewindow').jqxWindow('setContent', data);

	            	}); 
	  	}
	function getsite(rowBoundIndex,reftrno,id){
		 
		  $('#sitewindow').jqxWindow('open');
	  var reftype="ENQ";
	 // $('#accountWindow').jqxWindow('focus');
	        siteSearchContent("sitesearch.jsp?rowBoundIndex="+rowBoundIndex+"&reftrno="+reftrno+"&id="+id+"&reftype="+reftype);
	     	 }
	     	 
	function siteSearchContent(url) {
	//alert(url);
		 $.get(url).done(function (data) {
			 //alert(data);
	$('#sitewindow').jqxWindow('setContent', data);

	            	}); 
	  	}
	
	
	function disable(){
		 
		
		
		 $('#btnupdate').attr("disabled",true);
		
		 
		 $("#materialEstPriceGrid").jqxGrid('clear');
		 $("#materialEstPriceGrid").jqxGrid("addrow", null, {}); 
		 $("#materialEstPriceGrid").jqxGrid({ disabled: true});
	}
	
	
	function funreload(event){
		disable();
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var branchval = document.getElementById("cmbbranch").value;
		
		
		 $("#overlay, #PleaseWait").show();  
		 $("#engConfirmDiv").load("engineeringConfirmationGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+"&check=1");
	}
	
	function funUpdate(event){     
		$("#materialEstPriceGrid").jqxGrid('clearfilters');
		
		 var rdocno=$('#txtrdocno').val();
		
	   
		 var branchid =$("#txtbrchid").val(); 
		 var userid=$("#txtuserid").val(); 
		 var contracttrno=$("#hidcontracttrno").val(); 
		
		var rows1 = $("#materialEstPriceGrid").jqxGrid('getrows');
	    
	  	//document.getElementById("errormsg").innerText="";

	  	 $('#estimationgrdlen').val(rows1.length);
	  	 
	  	 for(var i=0 ; i < rows1.length ; i++){
	  		     newTextBox = $(document.createElement("input"))
	  		       .attr("type", "dil")
	  		       .attr("id", "mate"+i)
	  		       .attr("name", "mate"+i)
	  		       .attr("hidden", "true"); 
		 
	  	  		   newTextBox.val(rows1[i].desc1+" :: "+rows1[i].prodoc+" :: "+rows1[i].psrno+" :: "+rows1[i].unitdocno+" :: "+rows1[i].qty+" :: "+
	  	  				   rows1[i].amount+" :: "+rows1[i].total+" :: "+rows1[i].margin+" :: "+rows1[i].nettotal+" :: "+rows1[i].activityid+" :: "+
	  	  				   rows1[i].site+" :: "+rows1[i].stypeid+" :: "+rows1[i].sitesrno+" :: "+rows1[i].newqty+" :: "+rows1[i].rowno+" :: ");
	  		   newTextBox.appendTo('form');
	  		  
	  				}	
	 	$('#frmECRevision').submit();
	    return 1;
		

	

		 
	}
	
	
	
	
	function funExportBtn(){
	   
		JSONToCSVCon(estvariation,'Estimation Variation',true);
		JSONToCSVCon(estvariationdata,'Estimation Variation Details',true);
		   }
	   function setValues(){

			 if($('#msg').val()!=""){
				 
	   		  $.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
	   		  }
		}
	   
		
</script>
</head>
<body onload="getBranch();disable();setValues();">
<form id="frmECRevision" action="saveECRevisiondetails" method="post" autocomplete="off">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
	<tr><td colspan="2"></td></tr>
	 <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr>                 
	 
     
	 <tr><td colspan="2">&nbsp;</td></tr> 
	  <tr><td colspan="2">&nbsp;</td></tr>
	  	 <tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">
	 	<input type="text" name="gridtext" id="gridtext" style="width:0%;height:0%;"  class="textbox"  value='<s:property value="gridtext"/>'  />   
  
    <input type="text" name="gridtext1" id="gridtext1" style="width:0%;height:0%;"  class="textbox"  value='<s:property value="gridtext1"/>' />
	 </td></tr>
	 <tr><td colspan="2" align="center"><button class="myButton" type="button" id="btnupdate" name="btnupdate" onclick="funUpdate(event);">Update</button></td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	  <tr><td colspan="2">&nbsp;</td></tr> 
	  <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr> 
	 <tr><td colspan="2">&nbsp;</td></tr>
	  <tr><td colspan="2">&nbsp;</td></tr>
	   <tr><td colspan="2">&nbsp;</td></tr>
	  <tr><td colspan="2"></td></tr> <tr><td colspan="2">&nbsp;</td></tr>
	  <tr><td colspan="2"></td></tr> <tr><td colspan="2"></td></tr> <tr><td colspan="2">&nbsp;</td></tr>
	  <tr><td colspan="2"></td></tr>
	   <tr><td colspan="2"></td></tr> <tr><td colspan="2">&nbsp;</td></tr>
		   
	      <tr><td colspan="2">&nbsp;</td></tr>
	      
	
	  	
	  <tr><td colspan="2">&nbsp;</td></tr>
	  
	  
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">
	 <input type="hidden" id="txtdocno" name="txtdocno" style="width:100%;height:20px;" value='<s:property value="txtdocno"/>'/>
     <input type="hidden" id="txtbranch" name="txtbranch" style="width:100%;height:20px;" value='<s:property value="txtbranch"/>'/>
     <input type="hidden" id="txtsalid" name="txtsalid" style="width:100%;height:20px;" value='<s:property value="txtsalid"/>'/>
     <input type="hidden" id="txtrdocno" name="txtrdocno" style="width:100%;height:20px;" value='<s:property value="txtrdocno"/>'/>
     <input type="hidden" id="txtbrchid" name="txtbrchid" style="width:100%;height:20px;" value='<s:property value="txtbrchid"/>'/>
     <input type="hidden" id="txtuserid" name="txtuserid" style="width:100%;height:20px;" value='<s:property value="txtuserid"/>'/>
     <input type="hidden" id="txtnettotal" name="txtnettotal" style="width:100%;height:20px;" value='<s:property value="txtnettotal"/>'/> 
     <input type="hidden" id="txtmatotal" name="txtmatotal" style="width:100%;height:20px;" value='<s:property value="txtmatotal"/>'/> 
       <input type="hidden" id="hidsurtrno" name="hidsurtrno" value='<s:property value="hidsurtrno"/>' />
  <input type="hidden" id="hidenqtrno" name="hidenqtrno" value='<s:property value="hidenqtrno"/>' />
  <input type="hidden" id="estimationgrdlen" name="estimationgrdlen" style="width:100%;height:20px;" value='<s:property value="estimationgrdlen"/>'/>
  
  
  <input type="hidden" id="hidcontracttrno" name="hidcontracttrno" value='<s:property value="hidcontracttrno"/>' />
  <input type="hidden" id="productchk" name="productchk"  value='<s:property value="productchk"/>' />
     </td></tr> 
	 </table>
	</fieldset>
</td>
<td width="80%" class='hidden-scrollbar'>
	<table width="100%">
		<tr><td><div id="engConfirmDiv"><jsp:include page="engineeringConfirmationGrid.jsp"></jsp:include></div><br/></td></tr>
		<tr><td><div id="EstDiv"><jsp:include page="EstDetailGrid.jsp"></jsp:include></div><br/></td></tr>
		
	</table>
	</td>
</tr>
</table>
</div>
<div id="sidesearchwndow">
   <div ></div> 
</div>
<div id="servicetypewindow">
   <div ></div>
</div>
<div id="sitewindow">
   <div ></div>
</div>
</div> 
</form>
</body>
</html>