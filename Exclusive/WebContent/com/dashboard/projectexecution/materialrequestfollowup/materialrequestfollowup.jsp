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

.hidden-scrollbar {
    overflow: auto;
    
    height: 550px;
}
</style>

<script type="text/javascript">

	$(document).ready(function () {
		 $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
			$('#accountSearchwindow').jqxWindow('close');
			 $('#lastpurchasewindow').jqxWindow({ width: '50%', height: '32%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Search' ,position: { x: 500, y: 120 }, keyboardCloseKey: 27});
				$('#lastpurchasewindow').jqxWindow('close');
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
	     $('#sidesearchwndow').jqxWindow({ width: '30%', height: '90%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Search ' , position: { x: 943, y: 0 }, keyboardCloseKey: 27});
			$('#sidesearchwndow').jqxWindow('close'); 
			 $('#servicetypewindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Service Type Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			  $('#servicetypewindow').jqxWindow('close');

			  $('#txtvendor').dblclick(function(){
			    	//($("#mode").val() == "view")
			    	if($('#mode').val()!= "view")
			    		{
			    	
			    		
				  	    $('#accountSearchwindow').jqxWindow('open');
				  	
				  	  accountSearchContent('accountsDetailsSearch.jsp?');
			    		}
			  });   
			    
			  
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
 	
	function priceSearchContent(url) {
		  $('#lastpurchasewindow').jqxWindow('open');
	     $.get(url).done(function (data) {
	//alert(data);
	   $('#lastpurchasewindow').jqxWindow('setContent', data);

		}); 
		}  

	function getvendor(event){
	 	 var x= event.keyCode;
	   	
	 	if($('#mode').val()!="view")
	 		{
	 		
	 	 if(x==114){
	 	  $('#accountSearchwindow').jqxWindow('open');
	 	
	 	 accountSearchContent('accountsDetailsSearch.jsp?');    }
	 	 else{
	 		 }
	 		}
	 	 }  
		  function accountSearchContent(url) {
	       //alert(url);
	          $.get(url).done(function (data) {
	//alert(data);
	        $('#accountSearchwindow').jqxWindow('setContent', data);

		}); 
	    	}
		  
	function disable(){
		
		$("#procurementSubGrid").jqxGrid('clear');
		 $("#procurementSubGrid").jqxGrid({ disabled: true});
		 
	}
	
	
	function funreload(event){
		disable();
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var branchval = document.getElementById("cmbbranch").value;
			
		 $("#overlay, #PleaseWait").show();  
		 $("#procFolDiv").load("procurementFollowupGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+"&check=1");
	}
	
	 
 
	

 	function funPurchaseReq()
		{
 		
 	      var selectedrows=$("#procurementSubGrid").jqxGrid('selectedrowindexes');
		    
			if(selectedrows.length==0){
				$.messager.alert('Warning','Product Is Mandatory');
				return false;
			}
			
			  $.messager.confirm('Confirm', 'Do you want to Save Changes?', function(r){
	 			if (r){	
			var estimationrequestarray=new Array();
			var purchaserequestarray=new Array();
			var selectedrows=$("#procurementSubGrid").jqxGrid('selectedrowindexes');
			selectedrows = selectedrows.sort(function(a,b){return a - b});  
			
		 
			
				  for(var i=0 ; i < selectedrows.length ; i++){
					 
			 
						
						var unitdocno=	$("#procurementSubGrid").jqxGrid('getcellvalue',selectedrows[i],'unitdocno');
						var psrno=$("#procurementSubGrid").jqxGrid('getcellvalue',selectedrows[i],'psrno');
						var prodoc=	$("#procurementSubGrid").jqxGrid('getcellvalue',selectedrows[i],'prodoc');
						
						var purqty=$("#procurementSubGrid").jqxGrid('getcellvalue',selectedrows[i],'proqty');
						var specid=$("#procurementSubGrid").jqxGrid('getcellvalue',selectedrows[i],'specid');
						 
						var aa=0;
						purchaserequestarray.push(psrno+"::"+psrno+"::"+unitdocno+"::"+purqty+"::"+"0"+"::"+aa+"::"+specid+"::"+aa+"::"+"0"+" :: "+"0");
						
						/*  newTextBox.val(rows[i].psrno+"::"+rows[i].prodoc+" :: "+rows[i].unitdocno+" :: "+rows[i].qty+" :: "  
								   +rows[i].saveqty+" :: "+rows[i].checktype+" :: "+rows[i].specid+" :: "+rows[i].foc+" ::"+"0"+" :: "+"0" ); */
					 
						  }
				  openPurchase(purchaserequestarray,estimationrequestarray);
	 			}
	 	 		});
		            }
			   	
			
 		
 		
	 
	 
	function openPurchase(purchaserequestarray,estimationrequestarray)
	{
		var btn="request";
		var conttrno=$('#contracttrno').val(); 
		var contocno=$('#contractdocno').val();
		var txtcldocno=$('#txtcldocno').val();
		var txtsiteid=$('#txtsiteid').val();
		
		
 
		 
		
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200){
		     			
					var items=x.responseText;
					if(parseInt(items)=="1")  
					{	
					
					$.messager.alert('Message', '  Record Successfully Updated ');
				
					disable();
					}
					else
					{
					$.messager.alert('Message', '  Not Updated  ');
					}
					}
			}
	    x.open("GET","saveData.jsp?purchaserequestarray="+purchaserequestarray+"&click="+btn+"&conttrno="+conttrno+"&contocno="+contocno+"&estimationrequestarray="+estimationrequestarray+"&txtsiteid="+txtsiteid+"&txtcldocno="+txtcldocno,true);	 		
		x.send();
				
	
		
	}
	 
 
			
			
			
			
	 
	  
	 
	function funExportBtn(){
	    

		JSONToCSVCon(dataexcel, 'Material Request Followup', true);
		   }

		
</script>
</head>
<body onload="getBranch();disable();">
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
	  <tr><td colspan="2">&nbsp;</td></tr>
	 
	 
	 <tr><td colspan="2" align="center"><!-- <button class="myButton" type="button" id="btnreserve" name="btnreserve" onclick="funReserve(event);">Reserve</button> -->
	 
	 <button class="myButton" type="button" id="btnpurchse" name="btnpurchse" onclick="funPurchaseReq(event);">Material Request</button>
	 </td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
<%-- 	   <tr>
	      <td align="right"><label class="branch"> Vendor</label></td>
	      <td ><input style="width:200px;height:19px;" type="text" name="txtvendor" id="txtvendor" value='<s:property value="txtvendor"/>' onKeyDown="getvendor(event);" readonly placeholder="Press F3 to Search">
	      <input type="hidden" id="txtvendorid" name="txtvendorid" value='<s:property value="txtvendorid"/>'>
	      </td></tr> --%>
	  <tr><td colspan="2"></td></tr>
	<!--  <tr><td colspan="3" align="center"> <button class="myButton" type="button" id="btnpurchseorder" name="btnpurchseorder" onclick="funPurchaseOrder(event);">Purchase Order</button></td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr> -->
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
	       <tr><td colspan="2">&nbsp;</td></tr>
	 
	 <tr><td colspan="2">
	 <input type="hidden" id="txtdocno" name="txtdocno" style="width:100%;height:20px;" value='<s:property value="txtdocno"/>'/>
     <input type="hidden" id="txtbranch" name="txtbranch" style="width:100%;height:20px;" value='<s:property value="txtbranch"/>'/>
     <input type="hidden" id="txtsalid" name="txtsalid" style="width:100%;height:20px;" value='<s:property value="txtsalid"/>'/>
     <input type="hidden" id="txtrdocno" name="txtrdocno" style="width:100%;height:20px;" value='<s:property value="txtrdocno"/>'/>
     <input type="hidden" id="txtbrchid" name="txtbrchid" style="width:100%;height:20px;" value='<s:property value="txtbrchid"/>'/>
     <input type="hidden" id="txtuserid" name="txtuserid" style="width:100%;height:20px;" value='<s:property value="txtuserid"/>'/>
      <input type="hidden" name="subgridlength" id="subgridlength" value='<s:property value="subgridlength"/>'>
      <input type="hidden" name="contracttrno" id="contracttrno" value='<s:property value="contracttrno"/>'>
      <input type="hidden" name="contractdocno" id="contractdocno" value='<s:property value="contractdocno"/>'>
      <input type="hidden" id="puchasechk" name="puchasechk"/> 
      
      
      
            <input type="hidden" id="txtsiteid" name="txtsiteid" style="width:100%;height:20px;" value='<s:property value="txtsiteid"/>'/>
      
       <input type="hidden" id="txtcldocno" name="txtcldocno" style="width:100%;height:20px;" value='<s:property value="txtcldocno"/>'/>
      
      
      
     </td></tr> 
	 </table>
	</fieldset>
</td>
<td width="80%" class='hidden-scrollbar'>
	<table width="100%" style=" vertical-align: top;">
		<tr><td><div id="procFolDiv"><jsp:include page="procurementFollowupGrid.jsp"></jsp:include></div><br/></td></tr>
		<tr><td><div id="detailDiv"><jsp:include page="procurementFollowupSubGrid.jsp"></jsp:include></div></td></tr>
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
  <div id="accountSearchwindow">
	   <div ></div>
	</div>
	<div id="lastpurchasewindow">
	   <div ></div>
	</div>
</div> 
</body>
</html>