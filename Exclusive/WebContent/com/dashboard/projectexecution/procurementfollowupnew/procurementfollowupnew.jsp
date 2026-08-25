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
				$('#pvendorwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Vendor Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
				   $('#pvendorwindow').jqxWindow('close');
				
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
			  $('#vendor').dblclick(function(){
					 vendorSearchContent('vendorsearch.jsp', $('#pvendorwindow'));
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
	
	function funReserve(){
		var purchasearray=new Array();
	      var selectedrows=$("#procurementSubGrid").jqxGrid('selectedrowindexes');
		    
			if(selectedrows.length==0){
				$.messager.alert('Warning','Product Is Mandatory');
				return false;
			}
			
			      var selectedrows=$("#procurementSubGrid").jqxGrid('selectedrowindexes');
		    
			if(selectedrows.length==0){
				$.messager.alert('Warning','Product Is Mandatory');
				return false;
			}
			
			var aa=0;
			var selectedrows=$("#procurementSubGrid").jqxGrid('selectedrowindexes');
			selectedrows = selectedrows.sort(function(a,b){return a - b});  
			
				  for(var i=0 ; i < selectedrows.length ; i++){
						var proqty=	$("#procurementSubGrid").jqxGrid('getcellvalue',selectedrows[i],'proqty');
						if(parseFloat(proqty)<=0 ||proqty=="" || proqty==null)
							{
							aa=1;
							break;
							}
					 
						  }
				  
				  if(aa==1)
					  {
					  
					  $.messager.alert('Warning','Procurement Quantity Mandatory');
					  return false;
					  }
			
			
			
			var selectedrows=$("#procurementSubGrid").jqxGrid('selectedrowindexes');
			selectedrows = selectedrows.sort(function(a,b){return a - b});  
			
		 var aa=0;
			
				  for(var i=0 ; i < selectedrows.length ; i++){
					 
			 
						
						var stkqty=	$("#procurementSubGrid").jqxGrid('getcellvalue',selectedrows[i],'stkqty');
						var proqty=$("#procurementSubGrid").jqxGrid('getcellvalue',selectedrows[i],'proqty');
						
						
						if(proqty>stkqty)
							{
							aa=1;
							break;
							
							}
						
						
						
				  }
			
			if(aa==1)
				{
				
				 $.messager.alert('Message', 'Procurement Quantity Not More Than Stock Quantity');
				 
				 return 0;
				}
			
			
			
		 	
			
			  $.messager.confirm('Confirm', 'Do you want to Save Changes?', function(r){
	 			if (r){	
	 				
	 				var selectedrows=$("#procurementSubGrid").jqxGrid('selectedrowindexes');
	 				selectedrows = selectedrows.sort(function(a,b){return a - b});  
	 				
	 			 
	 				
	 					  for(var i=0 ; i < selectedrows.length ; i++){
	 						 
	 							var unitdocno=	$("#procurementSubGrid").jqxGrid('getcellvalue',selectedrows[i],'unitdocno');
	 							var psrno=$("#procurementSubGrid").jqxGrid('getcellvalue',selectedrows[i],'psrno');
	 							var prodoc=	$("#procurementSubGrid").jqxGrid('getcellvalue',selectedrows[i],'prodoc');
	 							
	 							var purqty=$("#procurementSubGrid").jqxGrid('getcellvalue',selectedrows[i],'proqty');
	 							var specid=$("#procurementSubGrid").jqxGrid('getcellvalue',selectedrows[i],'specid');
	 							
	 							
	 							var brhid=	$("#procurementSubGrid").jqxGrid('getcellvalue',selectedrows[i],'brhid');
	 							
	 							var costdocno=	$("#procurementSubGrid").jqxGrid('getcellvalue',selectedrows[i],'costdocno');
	 							 
	 						  var resqty=0;
	 						  
	 						  var locid=0;
	 						  
	 						  
	 						  var rowno=0;
	 						  
	 						 purchasearray.push(rowno+"::"+resqty+"::"+purqty+"::"+brhid+"::"+psrno+"::"+specid+"::"+locid+"::"+costdocno+"::");
	 						  
	 					  }
	 					  
	 					  
	 					 saveGridData(purchasearray);
	 				
	 			}
	 	 		});
		
		
		
		
	}
	
	
/* 	
	function funReserve(){
		
		var ins=0;
		var psr=0;
	var rows = $("#procurementSubGrid").jqxGrid('getrows');   
	var purchasearray=new Array();
	
		if(rows.length>0 && (rows[0].rowno=="undefined" || rows[0].rowno==null || rows[0].rowno=="")){
			return false;
		}
			       var selectedrows=$("#procurementSubGrid").jqxGrid('selectedrowindexes');
	    
		if(selectedrows.length==0){
			$.messager.alert('Warning','Select a document');
			return false;
		}
		   $.messager.confirm('Confirm', 'Do you want to Reserve Stock?', function(r){
	 			if (r){
	 				
	 				var i=0;
	                $('#subgridlength').val(selectedrows.length);
	              
				    for (i = 0; i < rows.length; i++) {
						for(var j=0;j<selectedrows.length;j++){
							
							if(selectedrows[j]==i){
								var rowno=rows[i].rowno;
								var resqty=rows[i].resqty;
								var oldbalqty=rows[i].oldbalqty;
								if(resqty>oldbalqty || resqty<=0)
									{
									ins=1;
									break;
									}
								var purqty=rows[i].purqty;
								var brhid=rows[i].brhid;
								var psrno=rows[i].psrno;
								if(parseInt(psrno)<=0)
								{
								psr=1;
								break;
								}
								var specid=rows[i].specid;
								var locid=rows[i].locid;
								
							purchasearray.push(rowno+"::"+resqty+"::"+purqty+"::"+brhid+"::"+psrno+"::"+specid+"::"+locid);
							}
						
							}
						
						}
				  
				    if(ins==1 || psr==1)
				    	{
				    	if(ins==1)
				    	$.messager.alert('Message', '  Quantity Mismatch ');
				    	if(psr==1)
					    	$.messager.alert('Message', '  Product Is Mandatory ');
				    	}
				    else
						{
					
						if(i==rows.length){
							
							saveGridData(purchasearray);
						}
			
						}
				    
				    
			 			}
			 	 		});
		
	}

	 */
	
	function saveGridData(purchasearray){
		var contocno=$('#contractdocno').val();
		var conttrno=$('#contracttrno').val();  
		var btn="reserve";
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
    x.open("GET","saveData.jsp?purchasearray="+purchasearray+"&contocno="+contocno+"&conttrno="+conttrno+"&click="+btn,true);			
	x.send();
			
	}
	
	

 	function funPurchaseReq()
		{
 		
 	      var selectedrows=$("#procurementSubGrid").jqxGrid('selectedrowindexes');
		    
			if(selectedrows.length==0){
				$.messager.alert('Warning','Product Is Mandatory');
				return false;
			}
			      var selectedrows=$("#procurementSubGrid").jqxGrid('selectedrowindexes');
		    
			if(selectedrows.length==0){
				$.messager.alert('Warning','Product Is Mandatory');
				return false;
			}
			
			var aa=0;
			var selectedrows=$("#procurementSubGrid").jqxGrid('selectedrowindexes');
			selectedrows = selectedrows.sort(function(a,b){return a - b});  
			
				  for(var i=0 ; i < selectedrows.length ; i++){
						var proqty=	$("#procurementSubGrid").jqxGrid('getcellvalue',selectedrows[i],'proqty');
						if(parseFloat(proqty)<=0 ||proqty=="" || proqty==null)
							{
							aa=1;
							break;
							}
					 
						  }
				  
				  if(aa==1)
					  {
					  
					  $.messager.alert('Warning','Procurement Quantity Mandatory');
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
						 
						
						purchaserequestarray.push(psrno+"::"+psrno+"::"+unitdocno+"::"+purqty+"::"+specid+"::");
						
						
					 
						  }
				  openPurchase(purchaserequestarray,estimationrequestarray);
	 			}
	 	 		});
		            }
			   	
			
 		
 		
	 
	
	
	
/* 	function funPurchaseReq()
	{
		
		var ins=0;
		var psr=0;
		var rows = $("#procurementSubGrid").jqxGrid('getrows');   
		var estimationrequestarray=new Array();
		var purchaserequestarray=new Array();
			if(rows.length>0 && (rows[0].rowno=="undefined" || rows[0].rowno==null || rows[0].rowno=="")){
				return false;
			}
				       var selectedrows=$("#procurementSubGrid").jqxGrid('selectedrowindexes');
		    
			if(selectedrows.length==0){
				$.messager.alert('Warning','Select a document');
				return false;
			}
			   $.messager.confirm('Confirm', 'Do you want to Save Changes?', function(r){
		 			if (r){
		 				
		 				var i=0;
		                $('#subgridlength').val(selectedrows.length);
		              
					    for (i = 0; i < rows.length; i++) {
							for(var j=0;j<selectedrows.length;j++){
								
								if(selectedrows[j]==i){
									var rowno=rows[i].rowno;
									var productid=rows[i].productid;
									var productname=rows[i].productname;
									var prodoc=rows[i].prodoc;
									var brandname=rows[i].brandname;
									var unit=rows[i].unit;
									var unitdocno=rows[i].unitdocno;
									var psrno=rows[i].psrno;
									if(parseInt(psrno)<=0)
									{
									psr=1;
									break;
									}
									var specid=rows[i].specid;
									var purqty=rows[i].purqty;
									var oldbalqty=rows[i].oldbalqty;
									if(purqty>oldbalqty || purqty<=0)
									{
									ins=1;
									break;
									}
									
													
									estimationrequestarray.push(rowno+"::"+purqty);
									
							
									purchaserequestarray.push(psrno+"::"+prodoc+"::"+unitdocno+"::"+purqty+"::"+specid+"::");
									
																	
									
								}
							
								}
							
							}
					  
					    if(ins==1 || psr==1)
				    	{
				    	if(ins==1)
				    	$.messager.alert('Message', '  Purchase Quantity Mismatch ');
				    	if(psr==1)
					    	$.messager.alert('Message', '  Product Is Mandatory ');
				    	}
					    else
							{
						
							if(i==rows.length){
								
								openPurchase(purchaserequestarray,estimationrequestarray);
							}
				
							}
					    
				 			}
				 	 		});
	}
	 */
	function openPurchase(purchaserequestarray,estimationrequestarray)
	{
		var btn="request";
		var conttrno=$('#contracttrno').val(); 
		var contocno=$('#contractdocno').val();
//alert(purchasearray);
		/*  var url=document.URL;
	 		var reurl=url.split("com/");
	 		var mod="A";
	 		window.parent.formName.value="Purchase Request";
	 		window.parent.formCode.value="PR";
	 		var detName= "Purchase Request";
	 		 var path1='com/Procurement/Purchase/purchaserequest/PurchaseRequest.jsp';
	 
	    		    var path= path1+"?mod="+mod+"&purchasearray="+purchasearray+"&purchaserequestarray="+purchaserequestarray+"&click="+btn;  
	      
	 		top.addTab( detName,reurl[0]+""+path); */
		 
		
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
	    x.open("GET","saveData.jsp?purchaserequestarray="+purchaserequestarray+"&click="+btn+"&conttrno="+conttrno+"&contocno="+contocno+"&estimationrequestarray="+estimationrequestarray,true);	 		
		x.send();
				
	
		
	}
	 
/* 		function funPurchaseOrder(){
			
			var vendor= document.getElementById("txtvendorid").value;

			if(vendor=="")
				{
				$.messager.alert('Message', '  Select vendor ');
				 return 0;
				   }
			      var selectedrows=$("#procurementSubGrid").jqxGrid('selectedrowindexes');
		    
			if(selectedrows.length==0){
				$.messager.alert('Warning','Product Is Mandatory');
				return false;
			}
			
			var aa=0;
			var selectedrows=$("#procurementSubGrid").jqxGrid('selectedrowindexes');
			selectedrows = selectedrows.sort(function(a,b){return a - b});  
			
				  for(var i=0 ; i < selectedrows.length ; i++){
						var proqty=	$("#procurementSubGrid").jqxGrid('getcellvalue',selectedrows[i],'proqty');
						if(parseFloat(proqty)<=0 ||proqty=="" || proqty==null)
							{
							aa=1;
							break;
							}
					 
						  }
				  
				  if(aa==1)
					  {
					  
					  $.messager.alert('Warning','Procurement Quantity Mandatory');
					  return false;
					  }
			
			
			 var net=0;
			  var tot=0;
			  
			  $.messager.confirm('Confirm', 'Do you want to Save Changes?', function(r){
		 			if (r){
			  
			  var selectedrows=$("#procurementSubGrid").jqxGrid('selectedrowindexes');
			    
				if(selectedrows.length==0){
					$.messager.alert('Warning','Product Is Mandatory');
					return false;
				}
				
				
				var estimationorderarray=new Array();
				var purchaseorderarray=new Array();
				var selectedrows=$("#procurementSubGrid").jqxGrid('selectedrowindexes');
				selectedrows = selectedrows.sort(function(a,b){return a - b});  
				
			 
				
					  for(var i=0 ; i < selectedrows.length ; i++){
						 
				 
							
							var unitdocno=	$("#procurementSubGrid").jqxGrid('getcellvalue',selectedrows[i],'unitdocno');
							var psrno=$("#procurementSubGrid").jqxGrid('getcellvalue',selectedrows[i],'psrno');
					 
							
							var purorderqty=$("#procurementSubGrid").jqxGrid('getcellvalue',selectedrows[i],'proqty');
							var specid=$("#procurementSubGrid").jqxGrid('getcellvalue',selectedrows[i],'specid');
							
							
							
							
							var unitprice=$("#procurementSubGrid").jqxGrid('getcellvalue',selectedrows[i],'amount');
							var total=$("#procurementSubGrid").jqxGrid('getcellvalue',selectedrows[i],'total');
							 
							 
							
						 
							var aa=0;
							
							
							net=parseFloat(net)+parseFloat(total);
							tot=parseFloat(tot)+parseFloat(total);
							
							purchaseorderarray.push(psrno+"::"+psrno+"::"+unitdocno+"::"+purorderqty+"::"+unitprice+"::"
									+total+"::"+aa+"::"+total+"::"+aa+"::"+aa+"::"
									+specid+"::"+aa+"::"+aa+"::"+aa+"::"+aa+"::"
									+aa+"::"+aa+"::"+aa+"::");
						
							 
							
							
							
						 
							  }
					  openPurchaseOrder(purchaseorderarray,net,tot,vendor,estimationorderarray);
		 			}
	 	 		});
			            } */
				   	
				
			
			
			
			
			
			
	 
	 
	 
 	
	function funPurchaseOrder(){
			            	
			            	if(document.getElementById("vendor").value==""){
			            		$.messager.alert('Warning','Vendor Is Mandatory');
			    				return false;
			            	} 
			            	
			            	var cmbbranch=document.getElementById("cmbbranch").value;
			            	if(cmbbranch=="a" || cmbbranch=="")
			            	{
			              $.messager.alert('Message',' Branch Is Mandatory','warning');   
			              document.getElementById("cmbbranch").focus();
			              return 0;
			            	}
			           	 $('#procurementSubGrid').jqxGrid('clearfilters');
			             
			            	
			            	var purchaseorderarray=new Array();
			            	var selectedrows=$("#procurementSubGrid").jqxGrid('selectedrowindexes');
			    			if(selectedrows.length==0){
			    				$.messager.alert('Warning','Product Is Mandatory');
			    				return false;
			    			}
			    			
			    			var aa=0;
			    			var selectedrows=$("#procurementSubGrid").jqxGrid('selectedrowindexes');
			    			selectedrows = selectedrows.sort(function(a,b){return a - b});  
			    			
			    				  for(var i=0 ; i < selectedrows.length ; i++){
			    						var proqty=	$("#procurementSubGrid").jqxGrid('getcellvalue',selectedrows[i],'proqty');
			    						if(parseFloat(proqty)<=0 ||proqty=="" || proqty==null)
			    							{
			    							aa=1;
			    							break;
			    							}
			    					 
			    						  }
			    				  
			    				  if(aa==1)
			    					  {
			    					  
			    					  $.messager.alert('Warning','Procurement Quantity Mandatory');
			    					  return false;
			    					  }
			    			
			            	var listss = new Array();
			            	var selectedrows=$("#procurementSubGrid").jqxGrid('selectedrowindexes');
			            	selectedrows = selectedrows.sort(function(a,b){return a - b});
			            		  for(var i=0 ; i < selectedrows.length ; i++){
			            			 listss.push($("#procurementSubGrid").jqxGrid('getcellvalue',selectedrows[i],'psrno')+"::"+$("#procurementSubGrid").jqxGrid('getcellvalue',selectedrows[i],'proqty')+"::"); 
			            				  }
			            		   save(listss); 
			            	
			            	
			            }
			    			
			    		
			        		/* var btn="order";
			        	 
			        		var selectedrows=$("#procurementSubGrid").jqxGrid('selectedrowindexes');
							selectedrows = selectedrows.sort(function(a,b){return a - b});  
							
						 
							
								  for(var i=0 ; i < selectedrows.length ; i++){
									 
							 
										
										var unitdocno=	$("#procurementSubGrid").jqxGrid('getcellvalue',selectedrows[i],'unitdocno');
										var psrno=$("#procurementSubGrid").jqxGrid('getcellvalue',selectedrows[i],'psrno');
								 
										
										var purorderqty=$("#procurementSubGrid").jqxGrid('getcellvalue',selectedrows[i],'proqty');
										var specid=$("#procurementSubGrid").jqxGrid('getcellvalue',selectedrows[i],'specid');
										
									 
										var productid=$("#procurementSubGrid").jqxGrid('getcellvalue',selectedrows[i],'productid');
										var productname=$("#procurementSubGrid").jqxGrid('getcellvalue',selectedrows[i],'productname');
										
										var brandname=$("#procurementSubGrid").jqxGrid('getcellvalue',selectedrows[i],'brandname');
										
										var unit=$("#procurementSubGrid").jqxGrid('getcellvalue',selectedrows[i],'unit');
									 
										
										 
										 
										purchaseorderarray.push(psrno+"::"+unitdocno+"::"+productid+"::"+productname+"::"
												+brandname+"::"+unit+"::"+purorderqty+"::"+specid+"::");
								  }
									
								 */
								 
								  
				 
			        		 
	
	/* } */
	 
			            
			            
			            function save(listss){
			    			var x=new XMLHttpRequest();
			    			x.onreadystatechange=function(){
			    				if (x.readyState==4 && x.status==200) 
			    					{
			    					 var items= x.responseText;
			    					 	var itemval=items.trim();
			    					 
			    	      if(parseInt(itemval)>0)
			    	      	{
			    				/* 	 	$.messager.alert('Message', '  Record successfully Updated ', function(r){
			    						     
			    					     });
			    					     */
			    					 	funopen(itemval);
			    			 
			    					}
			    				else
			    					{
			    					/* $.messager.alert('Message', '  Not Updated ', function(r){
			    					     
			    				     }); */
			    					}  
			    			}
			    			}  
			    		x.open("GET","saveprd.jsp?list="+listss+"&venddocno="+document.getElementById("hidvendoracno").value);
			    			x.send();
			    		}
			            
		function funopen(docno)
		{
			 
			
     	   var url=document.URL;
     	 		var reurl=url.split("com/");
     	 		var mod="A";
     	 		window.parent.formName.value="Purchase Order";
     	 		window.parent.formCode.value="PO";
     	 		var detName= "Purchase Order";
     	 		 var path1='com/Procurement/Purchase/PurchaseOrder/PurchaseOrder.jsp';   
     	 
     	    		    var path= path1+"?mod="+mod+"&docno="+docno+"&itemdocno="+document.getElementById("itemdocno").value
     	    		    		+"&costranno="+document.getElementById("costranno").value+"&contrtypes="+document.getElementById("contrtypes").value+"&prjnames="+document.getElementById("prjname").value.replace(/ /g,'')+"&hideitemtype="+document.getElementById("hideitemtype").value
     	    		    		+"&venddocno="+document.getElementById("hidvendoracno").value+"&vendname="+document.getElementById("vendor").value.replace(/ /g,"%20")+"&vendaccount="+document.getElementById("hidvendoraccount").value;
     	    		    		   
     	      
     	 		top.addTab( detName,reurl[0]+""+path); 
		}
			            
	function openPurchaseOrder(purchaseorderarray,net,tot,vendor,estimationorderarray)
	{
		var btn="order";
		var conttrno=$('#contracttrno').val(); 
		var contocno=$('#contractdocno').val();
	var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200){
		     			
					var items=x.responseText;
					if(parseInt(items)=="1")  
					{	
						$('#txtvendor').val('');
						$('#txtvendorid').val('');
					$.messager.alert('Message', '  Record Successfully Updated ');
				
					disable();
					}
					else
					{
					$.messager.alert('Message', '  Not Updated  ');
					}
					}
			}
	    x.open("GET","saveData.jsp?purchaseorderarray="+purchaseorderarray+"&click="+btn+"&conttrno="+conttrno+"&ordernet="+net+"&ordertot="+tot+"&vendor="+vendor+"&contocno="+contocno+"&estimationorderarray="+estimationorderarray,true); 
		x.send();
				
	
		
	}
	function getVendor(){
		 $('#pvendorwindow').jqxWindow('open');
			$('#pvendorwindow').jqxWindow('focus');
			vendorSearchContent('vendorsearch.jsp', $('#pvendorwindow'));

	}
	function vendorSearchContent(url) {
		/* $("#stocklistgrid").jqxGrid('clear'); */
	   $('#pvendorwindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#pvendorwindow').jqxWindow('setContent', data);
		$('#pvendorwindow').jqxWindow('bringToFront');
	}); 
	}
	
	
	function funExportBtn(){
	    

         JSONToCSVCon(procurmentexcel, 'Procurment Followup', true);
         JSONToCSVCon(subrocurmentexcel, 'Procurment Followup 1', true);
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
	 
	 
	 <tr><td colspan="2" align="center"><button class="myButton" type="button" id="btnreserve" name="btnreserve" onclick="funReserve(event);">Reserve</button>
	</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr> 
	 <tr><td colspan="2" align="center"><button class="myButton" type="button" id="btnpurchse" name="btnpurchse" onclick="funPurchaseReq(event);">Purchase Request</button>
	 </td></tr>
	 <tr><td>
	 &nbsp;</td></tr>
	  <tr><td align="right"><label class="branch">Vendor</label></td>
	<td align="left"><input type="text" id="vendor" name="vendor" style="width:90%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="vendor"/>' onKeyDown="getVendor(event);"/></td></tr>
   
	 
	 <tr><td colspan="2">&nbsp;</td></tr>
	  <tr><td colspan="2" align="center"> <button class="myButton" type="button" id="btnpurchseorder" name="btnpurchseorder" onclick="funPurchaseOrder(event);">Purchase Order</button></td></tr>
	   <tr>
	      <td align="right">&nbsp;</td>
	      <td ><input style="width:200px;height:19px;" type="hidden" name="txtvendor" id="txtvendor" value='<s:property value="txtvendor"/>' onKeyDown="getvendor(event);" readonly placeholder="Press F3 to Search">
	      <input type="hidden" id="txtvendorid" name="txtvendorid" value='<s:property value="txtvendorid"/>'>
	      </td></tr>
	  <tr><td colspan="2"></td></tr>
	
	 
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
  
         <input type="hidden" id="itemdocno" name="itemdocno" style="width:100%;height:20px;" value='<s:property value="itemdocno"/>'/>
             <input type="hidden" id="costranno" name="costranno" style="width:100%;height:20px;" value='<s:property value="costranno"/>'/>
                 <input type="hidden" id="prjname" name="prjname" style="width:100%;height:20px;" value='<s:property value="prjname"/>'/>
                  <input type="hidden" id="contrtypes" name="contrtypes" style="width:100%;height:20px;" value='<s:property value="contrtypes"/>'/>
     	 
                 	 
     
      <input type="hidden" name="subgridlength" id="subgridlength" value='<s:property value="subgridlength"/>'>
      <input type="hidden" name="contracttrno" id="contracttrno" value='<s:property value="contracttrno"/>'>
      <input type="hidden" name="contractdocno" id="contractdocno" value='<s:property value="contractdocno"/>'>
      
        <input type="hidden" name="hideitemtype" id="hideitemtype" value='<s:property value="hideitemtype"/>'>
       <input type="hidden" name="hidvendoracno" id="hidvendoracno">
			  <input type="hidden" name="hidvendorcldocno" id="hidvendorcldocno">
			  <input type="hidden" name="hidvendoraccount" id="hidvendoraccount">
      
      
      <input type="hidden" id="puchasechk" name="puchasechk"/> 
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
	<div id="pvendorwindow">
	   <div ></div>
	</div>
</div> 
</body>
</html>