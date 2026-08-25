
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
.branch1 {
	color: black;
	 
	width: 100%;
	font-family: Tahoma;
	font-size: 10px;
}

</style>

<script type="text/javascript">








$(document).ready(function () {
	

	 	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     document.getElementById("cmpbranch").value="Company/Branch Name";
	   
	     $("#btnupdate").attr('disabled',true);
	     $("#btnupdates").attr('disabled',true);
	     
	     $("#btnupdates").hide();
	     $("#btnupdate").show();
	     
	     
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
	
	     $('#div1').show();
		 $('#div2').hide();
	 
			document.getElementById('rsumm').checked="true";
			
			
				$('#catsearchwindow').jqxWindow({
					width : '25%',
					height : '58%',
					maxHeight : '70%',
					maxWidth : '45%',
					title : 'Category Search',
					position : {
						x : 420,
						y : 87
				},
			theme : 'energyblue',
			showCloseButton : true,
			keyboardCloseKey : 27
		});
		$('#catsearchwindow').jqxWindow('close');
		$('#subcatsearchwindow').jqxWindow({
			width : '25%',
			height : '58%',
			maxHeight : '70%',
			maxWidth : '45%',
			title : 'Sub Category Search',
			position : {
				x : 420,
				y : 87
			},
			theme : 'energyblue',
			showCloseButton : true,
			keyboardCloseKey : 27
		});
		$('#subcatsearchwindow').jqxWindow('close');
		
		$('#brandsearchwindow').jqxWindow({
			width : '25%',
			height : '58%',
			maxHeight : '70%',
			maxWidth : '70%',
			title : 'Brand Search',
			position : {
				x : 420,
				y : 87
			},
			theme : 'energyblue',
			showCloseButton : true,
			keyboardCloseKey : 27
		});
		$('#brandsearchwindow').jqxWindow('close');
		   $('#productwindow').jqxWindow({ width: '50%',height: '62%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Product Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#productwindow').jqxWindow('close');   
		
		   
			 
		$('#name').dblclick(function(){
			 if($('#type').val()=="BR")
				 {
				 brandFormSearchContent('brandFormSearchGrid.jsp');  
				 } 
			 else if($('#type').val()=="CA")
				 {
				 catFormSearchContent('catFormSearchGrid.jsp'); 
				 }
			 else if($('#type').val()=="SC")
				 {
				 subCatFormSearchContent('subCatFormSearchGrid.jsp');
				 }
			 else if($('#type').val()=="PR")
			 {
				 productSearchContent('productSearch.jsp');
			 }
		
			
			
		}); 
		
		 
		
});



function funExportBtn(){
	if (document.getElementById('rsumm').checked) {
	JSONToCSVCon(dat1, 'Reorder Level - Reset Reorder ', true);
	}
	else
		{
	
	JSONToCSVCon(dat2, 'Reorder Level - To Be Ordered ', true);
		}
	 }

function brandFormSearchContent(url) {
	$('#brandsearchwindow').jqxWindow('open');
	$.get(url).done(function(data) {
		$('#brandsearchwindow').jqxWindow('setContent', data);
		$('#brandsearchwindow').jqxWindow('bringToFront');
	});
}
function subCatFormSearchContent(url) {
	$('#subcatsearchwindow').jqxWindow('open');
	$.get(url).done(function(data) {
		$('#subcatsearchwindow').jqxWindow('setContent', data);
		$('#subcatsearchwindow').jqxWindow('bringToFront');
	});
}
function catFormSearchContent(url) {
	$('#catsearchwindow').jqxWindow('open');
	$.get(url).done(function(data) {
		$('#catsearchwindow').jqxWindow('setContent', data);
		$('#catsearchwindow').jqxWindow('bringToFront');
	});
}

function productSearchContent(url) {
	$('#productwindow').jqxWindow('open');
	    $.get(url).done(function (data) {
	//alert(data);
	  $('#productwindow').jqxWindow('setContent', data);

	}); 
	}


function getname(event)
{
	if($('#type').val()=="BR")
	 {
	 brandFormSearchContent('brandFormSearchGrid.jsp');  
	 } 
else if($('#type').val()=="CA")
	 {
	 catFormSearchContent('catFormSearchGrid.jsp'); 
	 }
else if($('#type').val()=="SC")
	 {
	 subCatFormSearchContent('subCatFormSearchGrid.jsp');
	 }
else if($('#type').val()=="PR")
{
	 productSearchContent('productSearch.jsp');
}
	
	
	}


 
 
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
		   
		  /*  if(document.getElementById("cmbbranch").value=="a")
			   {
			   
			   $.messager.alert('Message',' Select Branch' ); 
			   document.getElementById("cmbbranch").focus();
			   return 0;
			   }
		   
		    */
	
    /*         var type=   $("#type option:selected").text().trim();
		   
		   if(document.getElementById("name").value=="")
			   {
			   
			   $.messager.alert('Message',' Search Your '+type ); 
			 
			   document.getElementById("name").focus();
			   return 0;
			   } */
	 var barchval = document.getElementById("cmbbranch").value;
     var fromdate= $("#fromdate").val();
	 var todate= $("#todate").val();
	 
	 var type=$('#type').val();
	 var brandid=$("#brandid").val();
	 var catid=$("#catid").val();
	 var subcatid=$("#subcatid").val();                  
	 var psrno=$("#psrno").val(); 
	 
	 var levelcount=$("#levelcount").val();
	 
	   $("#overlay, #PleaseWait").show(); 
	   
	   
	   
	   
		if (document.getElementById('rsumm').checked) {
	    document.getElementById("cmpbranch").value="Company/Branch Name";
	    $("#sublist").jqxGrid('clear');
	   var load="yes";
 	  $("#listdiv").load("listGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&type="+type+"&brandid="+brandid+"&catid="+catid+"&subcatid="+subcatid+"&psrno="+psrno+"&load="+load+"&levelcount="+levelcount);
		}
		else
			{
			   var load="yes";
			$("#tobeorderdiv").load("tobeorderdGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&type="+type+"&brandid="+brandid+"&catid="+catid+"&subcatid="+subcatid+"&psrno="+psrno+"&load="+load+"&levelcount="+levelcount);	
			}
 	 
		 
		   }
  	
 	  $("#btnupdate").attr('disabled',true);
 	  
	}
	
 
  
  function funCalculates()
  {
	  
		  
  }
  
  
  
  
	function hidebranch() 
	{
		
		 
		 $("#branchdiv").hide();
		  $("#branchlabel").hide();
		  
		 
	}
	
	     
	
	function fundisable(){
		

		
		if (document.getElementById('rsumm').checked) {
			
			  $('#div1').show();
			   $('#div2').hide();
			   $("#btnupdates").hide();
			     $("#btnupdate").show();
			  
			}
		 else if (document.getElementById('rdet').checked) {
			 
			  $('#div1').hide();
			  $('#div2').show();
			  $("#btnupdates").show();
			  $("#btnupdate").hide();
			 
			}
		 }
	
	
	
	
	 function funupdate()
	  {
		  
			$.messager.confirm('Message', 'Do you want to save changes?', function(r){
			 	  
			     
			   	if(r==false)
			   	{
			   		
			    }
			   	else
			    {
			   		
			   	  
			   	
			   		
						var listss = new Array();
		 				var prorows = $("#sublist").jqxGrid('getrows'); 
		 				
		 				
		 				for (var i = 0; i < prorows.length; i++) {
		 					var dis=0;
		 					
		 					if (prorows[i].selects == true) {


		 						if (prorows[i].discontinued == true) {
		 							
		 							//alert("1");
		 							
		 							dis=1;
		 						}
		 						listss.push(prorows[i].bdocno + "::" +prorows[i].selects
		 								+ "::" + dis + "::"
		 								+ prorows[i].bin+ "::" + prorows[i].minstock + "::"
		 								+ prorows[i].maxstock+ "::" + prorows[i].retailprice
		 								+ "::" + prorows[i].wholesale+ "::"
		 								+ prorows[i].normal+ "::"+prorows[i].reorderlevel+ "::"+prorows[i].reorderqty+ "::");  



		 					}
		 					
		 				}
		 				
		  			/* 	for(var i=0 ; i < rows.length ; i++)
		  				{
			   
			 						  listss.push(rows[i].psrno+"::"+rows[i].doc_no+"::"+rows[i].reorderlevels+"::"+rows[i].reorderqtys);  
		  				 } */
		  				 save(listss);
			   }
			   	
			}); 
	  }
	  function save(listss) 
	  {
				var x=new XMLHttpRequest();
				x.onreadystatechange=function()
				{
				if (x.readyState==4 && x.status==200)
				{
						 var items= x.responseText;
					 	var itemval=items.trim();
					 	
					 	//alert(items);
					 	
	      				if(parseInt(itemval)==1)
	      				{
									 	$.messager.alert('Message', '  Record successfully Updated ', function(r){
						     
					 				    });

										 $("#sublist").jqxGrid('clear');
										    $("#sublist").jqxGrid('addrow', null, {});
					    
					 					funreload(event);


					 	
					}
					else
					{
								$.messager.alert('Message', '  Not Updated ', function(r){
					     
				    			 });
					}  
			}
			}
			x.open("GET","saveupdate.jsp?list="+listss+"&prddocno="+document.getElementById("prddocno").value);  
			x.send();
		}

	 function fungo()
	 {
		 
		 var checkval="open"; 
	 		 
	 	/* 	 var masterdoc_no=document.getElementById("masterdoc_no").value; 
	 		 var branchvals=document.getElementById("branchvals").value; 
	 		 
	 		 */
	 		 
	 		 
	 		var psrno=0;
	 		 var selectedrows = $("#tobeorderdgrid").jqxGrid('selectedrowindexes');
			   selectedrows = selectedrows.sort(function(a,b){return a - b});
			   for(var i=0 ; i < selectedrows.length ; i++){
				  
				   psrno=psrno+$("#tobeorderdgrid").jqxGrid('getcellvalue',selectedrows[i],'psrno')+"::";
				    
					    
				 
			   } 
	 		 
	 		 
	 		 var barchval = document.getElementById("cmbbranch").value;
	 	 
	 		 
             var url=document.URL;
		     var reurl=url.split("com");
		     var path1='com/Procurement/Purchase/purchaserequest/PurchaseRequest.jsp';
      	     var path= path1+"?psrno="+psrno+"&checkval="+checkval+"&barchval="+barchval;
			 top.addTab( "Purchase Request",reurl[0]+""+path);		
			
		 
		 
	 }
	
	
	</script>
	</head>
	<body onload="getBranch();hidebranch();">    
			<div id="mainBG" class="homeContent" data-type="background"> 
				<div class='hidden-scrollbar'>
					<table width="100%"  >
						<tr>
								<td width="20%" >
    									<fieldset style="background: #ECF8E0;">
												<table width="100%"  >
														<jsp:include page="../../heading.jsp"></jsp:include>
	 													<tr><td  align="right" colspan="2" >&nbsp;</td></tr>	 
	  
	  
	  	  <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td> 
                     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td>
                    </tr>
													  	 <tr><td colspan="2" align="center"><input type="radio" id="rsumm" name="stkled" onchange="fundisable();" value="rsumm"><label for="rsumm" class="branch">Reset Reorder</label>&nbsp;&nbsp;
	 																						<input type="radio" id="rdet" name="stkled" onchange="fundisable();" value="rdet"><label for="rdet" class="branch">To Be Ordered</label></td></tr>
	  
	                  
         <tr><td  align="right" ><label class="branch">Level Count</label></td><td  align="left"  > <input type="number" id="levelcount" name="levelcount"   style="width: 75%;height:20PX;font-size: 11px"  >  </td></tr>            
              
	  
	  
	   													<tr><td  align="right" colspan="2" >
	   
	  															<table width="100%"  >
   					
  																		<tr><td  align="right" ><label class="branch">Type </label></td><td  align="left"   ><select id="type"   style="width: 75%;height:20PX;"   name="type" onchange="clearnames()">
  																								
  																									<option value="">--select--</option>
  																								<option value="BR">Brand</option>
 																								 <!-- <option value="CA">Category</option>
 																								<option value="SC">Sub Category</option> -->
  																								<option value="PR">Product</option>
  
 																						 </select></td></tr>
  																		 <tr> <td  align="center" colspan="2"><input type="text" id="name" style="width: 100%;height:20PX;"  style="width: 75%;"  placeholder="Press F3 for Search" readonly="readonly" onKeyDown="getname(event);" name="name"  value='<s:property value="name"/>'> </td></tr>
  
 																		 <tr></tr>
 																		<tr></tr>
 																		<tr>    
 																							<td></td>
 																							<td><input type="button" id="btnupdate" name="btnupdate" class="myButton" value="Update" style="width:90px;"  onclick="funupdate();"></td></tr>

                                <tr> <td>&nbsp;</td> <td  > <input type="button" id="btnupdates" name="btnupdates" class="myButton" value="Purchase Request " style="width:140px;"  onclick="fungo();"></td></tr>
  
  																 </table>
               											 </td></tr>   
 														<tr><td  align="center" colspan="2"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="hidden" name="updatdata" id="updatdata" class="myButton" value="Update" onclick="funupdates()"></td></tr>
        
   
 	    						  		     
 	         											<tr><td colspan="2">&nbsp;</td></tr>
 	       												<tr><td colspan="2">&nbsp;</td></tr> 
 	         										    <tr><td colspan="2">&nbsp;</td></tr>
 	           									     	<tr><td colspan="2">&nbsp;</td></tr> 
    													<tr><td colspan="2">&nbsp;</td></tr>
 	            										<tr><td colspan="2">&nbsp;</td></tr> 
    													<tr><td colspan="2">&nbsp;</td></tr>

	
												</table>
											</fieldset>
   										<input type="hidden" id="cldocno" name="cldocno" value='<s:property value="cldocno"/>'>
									</td>
									<td width="80%">
													<div id="div1">
  															<table width="100%">
																		<tr>
																				 <td><div id="listdiv"><jsp:include page="listGrid.jsp"></jsp:include></div></td>
																		</tr>
																		<tr>
																				 <td><div id="sublistdiv"><jsp:include page="sublistGrid.jsp"></jsp:include></div></td>
																		</tr>
															</table>
	
													</div>
													<div id="div2">
 															<table width="100%"> 
																		<tr>
			 																	<td><div id="tobeorderdiv"><jsp:include page="tobeorderdGrid.jsp"></jsp:include></div></td>
																		</tr>
		
															</table>
	
													</div>
	
									 </td>
						</tr>
				</table>

  	        	        	   <input type="hidden" id="cmpbranch">     	  
      			 <input type="hidden" id="brandid" name="brandid" >  
       			 <input type="hidden" id="catid" name="catid" >
      			 <input type="hidden" id="subcatid" name="subcatid" >      
       			 <input type="hidden" id="psrno" name="psrno" >
       			 
       			 
       			  <input type="hidden" id="prddocno" name="prddocno" >
       			 

				<div id="brandsearchwindow">
						<div></div>
						<div></div>
				</div>
		
				<div id="catsearchwindow">
						<div></div>
						<div></div>
				</div>
		
				<div id="subcatsearchwindow">
						<div></div>
						<div></div>
				</div>	
				<div id="productwindow">
						<div></div>
				</div>
			</div>
 
		</div>
	</body>
</html>