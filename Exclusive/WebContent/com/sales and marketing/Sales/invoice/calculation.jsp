<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>

<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
  
<script type="text/javascript">
 
$(document).ready(function () { 

	
	$('#bacthWindow').jqxWindow({ width: '40%', height: '60%',  maxHeight: '75%' ,maxWidth: '60%'  , title: 'Search',position: { x: 700, y:100 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	$('#bacthWindow').jqxWindow('close'); 
	
		}); 
	

function getround(){ 
 
	   var x=new XMLHttpRequest();
	   x.onreadystatechange=function(){
	   if (x.readyState==4 && x.status==200)
	    {
	      items= x.responseText;
	     
	      items=items.split('::');
	      
	        
	      document.getElementById("roundmethod").value=items[0];
	      document.getElementById("roundval").value=items[1];
	          
	    }
	       }
	   x.open("GET","getroundval.jsp?",true);
		x.send();
	        
	      
	        }
	
 

	 function roundvals()
	{
			 
 
		 if(parseInt(document.getElementById("roundmethod").value)>0)
			 {
			 
			    var roundOf1=document.getElementById('roundOf').value;
			    var roundval1=document.getElementById('roundval').value;
			    var id=1;
			    if(parseFloat(roundOf1)<0)
			    	{
			    	roundOf1=roundOf1*-1;
			    	id=-1;
			    	}
			    
			    if(parseFloat(roundOf1)>parseFloat(roundval1))
			    	{
			 		document.getElementById("errormsg").innerText="Maximum Allowed Round of Is "+roundval1*id;
			 		document.getElementById('roundOf').value=0;
			 		document.getElementById('roundOf').focus();
			 		 
			    	 
			    	}
			    else
			    	{
			   	 document.getElementById("errormsg").innerText="";
			    	}
			 
			 
			 }
	

		  var summaryData= $("#jqxInvoiceGrid").jqxGrid('getcolumnaggregateddata', 'taxamount', ['sum'],true);
		  
		  var  netTotaldown=summaryData.sum.replace(/,/g,'');
		
		  

		  
	    var roundOf=document.getElementById('roundOf').value;

	    if(roundOf!="")
	    {	 
		var	 netval=parseFloat(netTotaldown)+parseFloat(roundOf);
		funRoundAmt(netval,"txtnettotal"); 
		
					
		
		  var ordertotal="0";
	      var nettotalval="0";
	      
	          
	          if(document.getElementById("nettotal").value!="" && !(document.getElementById("nettotal").value==null) && !(document.getElementById("nettotal").value=="undefiend")) 
	       	   {
	       	   
	            nettotalval=parseFloat(document.getElementById("nettotal").value);
	       	   }
	          
	                      
	          
	        
	         ordertotal=parseFloat(nettotalval)+parseFloat(document.getElementById("txtnettotal").value);
	       	   
	    
		funRoundAmt(ordertotal,"orderValue");

		
			
			 
			
		    }
			  
	
	
}
	  function batchinfoSearchContent(url) {
        	 //alert(url);
        		 $.get(url).done(function (data) {
        			 
        			 $('#bacthWindow').jqxWindow('open');
        		$('#bacthWindow').jqxWindow('setContent', data);
        		       
        	}); 
	  } 
	  
	  
	  
	  
	  function setgrid()
		 {
			
			   
			 
			 var temppsrno=document.getElementById("temppsrno").value; 
			 var unit=document.getElementById("unit").value; 
			 
			 
	 
    	  
		var rows1 = $("#jqxInvoiceGrid").jqxGrid('getrows');
	    var aa=0;
	    for(var i=0;i<rows1.length;i++){
	 
	    	
	    	 
		   if(parseInt(rows1[i].prodoc)==parseInt(temppsrno))
			   {
		  
				 if((parseInt(document.getElementById("multimethod").value)==1))
				{	
					   
			   if(parseInt(rows1[i].unitdocno)==parseInt(unit))
			   {
				   
				   aa=1;
    			   break;
			   }
				}
				 else
					 {
			   
			   aa=1;
			   break;
					 }
			   }
		   else{
			   
			   aa=0;
		       } 
	    }
			 
	   if(parseInt(aa)==1)
		   {
		   
			document.getElementById("errormsg").innerText="You have already select this product";
		 document.getElementById("stockmsg").innerText="";  

				 
		     document.getElementById("jqxInput1").focus();
			 
		   return 0;
		   
		   
		   
		   }
	   else
		   {
		   document.getElementById("errormsg").innerText="";
		   }
	    
			
			
			
			 var rows = $('#jqxInvoiceGrid').jqxGrid('getrows');
			  
		 	 
		     var rowlength= rows.length;
		     
		
		    
		    var quantity=document.getElementById("quantity").value;
		    var focs=0;
		    var totalstock=document.getElementById("totalstock").value;
		    
			if(quantity=="" || quantity==null || quantity=="0.00" || quantity==0 ||typeof(quantity)=="undefined"|| typeof(quantity)=="NaN")
			{
				quantity=0;
			}
			
			if(focs=="" || focs==null || focs=="0.00" || focs==0 ||typeof(focs)=="undefined"|| typeof(focs)=="NaN")
			{
				focs=0;
				
				
			}
			if(totalstock=="" || totalstock==null || totalstock==0 ||typeof(totalstock)=="undefined"|| typeof(totalstock)=="NaN")
			{
				totalstock=0;
			}
			
			 var aoq=100;
		    
			
			 
			if(parseFloat(totalstock)<((parseFloat(quantity))))
				{
				 document.getElementById("errormsg").innerText="Quantity   should not be greater than available stock quantity : "+totalstock;
				  
				
				 return 0;
				
				}
			
			
		    if(parseFloat(document.getElementById("uprice").value)>0)
	    	{
	    	
	    	}
	    else
	    	{
	    	document.getElementById("errormsg").innerText="unit price is required";
	    	document.getElementById("uprice").focus();
	   	     return 0;
	    	}
	     
			
		     $('#datas3').val(1);
		     
		 
		
		     $('#jqxInvoiceGrid').jqxGrid('setcellvalue',  rowlength-1, "proid", document.getElementById("jqxInput").value);
		     $('#jqxInvoiceGrid').jqxGrid('setcellvalue',  rowlength-1, "proname", document.getElementById("jqxInput1").value);
		     $('#jqxInvoiceGrid').jqxGrid('setcellvalue',  rowlength-1, "allowdiscount",aoq);
		     
		     
		     
		     $('#jqxInvoiceGrid').jqxGrid('setcellvalue',  rowlength-1, "brandname", document.getElementById("brand").value);
		    // $('#jqxInvoiceGrid').jqxGrid('setcellvalue',  rowlength-1, "collectqty", document.getElementById("collqty").value);
		   
		   //  $('#jqxInvoiceGrid').jqxGrid('setcellvalue',  rowlength-1, "foc", document.getElementById("focs").value);
		     $('#jqxInvoiceGrid').jqxGrid('setcellvalue',  rowlength-1, "unitprice", document.getElementById("uprice").value);  
		     $('#jqxInvoiceGrid').jqxGrid('setcellvalue',  rowlength-1, "total", document.getElementById("totamt").value);
		     
		     
		     
		     
		     $('#jqxInvoiceGrid').jqxGrid('setcellvalue',  rowlength-1, "netotal", document.getElementById("totamt").value);
		     
		     if(parseFloat(document.getElementById("dispers").value)>0)    		 {
			     $('#jqxInvoiceGrid').jqxGrid('setcellvalue',  rowlength-1, "discper", document.getElementById("dispers").value);  
			     $('#jqxInvoiceGrid').jqxGrid('setcellvalue',  rowlength-1, "dis", document.getElementById("dict").value);
			     $('#jqxInvoiceGrid').jqxGrid('setcellvalue',  rowlength-1, "netotal", document.getElementById("amounts").value);	 }
			     else   	 {  	  $('#jqxInvoiceGrid').jqxGrid('setcellvalue',  rowlength-1,"discper", 0);  
					     $('#jqxInvoiceGrid').jqxGrid('setcellvalue',  rowlength-1,"dis", 0);
					     $('#jqxInvoiceGrid').jqxGrid('setcellvalue',  rowlength-1, "netotal", document.getElementById("totamt").value);
			    	 
			    	 }
		     $('#jqxInvoiceGrid').jqxGrid('setcellvalue',  rowlength-1, "taxper", document.getElementById("taxpers").value);
		     $('#jqxInvoiceGrid').jqxGrid('setcellvalue',  rowlength-1, "taxperamt", document.getElementById("taxamounts").value);
		     $('#jqxInvoiceGrid').jqxGrid('setcellvalue',  rowlength-1, "taxamount", document.getElementById("taxamountstotal").value);
		     

		     $('#jqxInvoiceGrid').jqxGrid('setcellvalue',  rowlength-1, "unitdocno", document.getElementById("unit").value);
		     if(document.getElementById("unit").value>0)
		     {
		     $('#jqxInvoiceGrid').jqxGrid('setcellvalue',  rowlength-1, "unit", $("#unit option:selected").text());
		     }
		     
		     $('#jqxInvoiceGrid').jqxGrid('setcellvalue',  rowlength-1, "psrno", document.getElementById("temppsrno").value);
		     $('#jqxInvoiceGrid').jqxGrid('setcellvalue',  rowlength-1, "prodoc", document.getElementById("temppsrno").value);
		     
		     
		     
		     $('#jqxInvoiceGrid').jqxGrid('setcellvalue',  rowlength-1, "specid", document.getElementById("tempspecid").value);
		     
		     
		     $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowlength-1, "productid" ,document.getElementById("jqxInput").value);
		     $('#jqxInvoiceGrid').jqxGrid('setcellvalue',  rowlength-1, "productname", document.getElementById("jqxInput1").value);
		     
		     $('#jqxInvoiceGrid').jqxGrid('setcellvalue',  rowlength-1, "qty", document.getElementById("quantity").value);
		     
		   
		     
		 
				  
			
				  
				  
				   document.getElementById("jqxInput").value ="";
				   document.getElementById("jqxInput1").value="";
				   document.getElementById("brand").value=""; 
		       //    document.getElementById("collqty").value ="";
				   document.getElementById("quantity").value ="";
				   document.getElementById("unit").value ="";
				         
				   //   document.getElementById("focs").value="";
				     
				      document.getElementById("uprice").value="";
				      document.getElementById("totamt").value="";
				      document.getElementById("amounts").value="";
				    
				      document.getElementById("taxpers").value="";
				      document.getElementById("taxamounts").value="";
				      document.getElementById("taxamountstotal").value="";
				     
				      
				      document.getElementById("dispers").value="";
					     
					      document.getElementById("dict").value="";
				  
				      
				       document.getElementById("temppsrno").value="";
				       document.getElementById("tempspecid").value="";
				       
				       document.getElementById("stockmsg").innerText="";
				     // document.getElementById("cleardata").checked=false;
				     
				     
				     
				     var summaryData1= $("#jqxInvoiceGrid").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
      		var summaryData= $("#jqxInvoiceGrid").jqxGrid('getcolumnaggregateddata', 'taxamount', ['sum'],true);
	        		var summaryData2= $("#jqxInvoiceGrid").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
  			
     document.getElementById("txtproductamt").value=summaryData1.sum.replace(/,/g,''); 
    document.getElementById("txtdiscount").value=summaryData2.sum.replace(/,/g,''); 
    document.getElementById("txtnettotal").value=summaryData.sum.replace(/,/g,'');
    document.getElementById("orderValue").value=summaryData.sum.replace(/,/g,''); 
    
    var orderValue= parseFloat(document.getElementById("txtnettotal").value)+parseFloat(document.getElementById("nettotal").value);
	funRoundAmt(orderValue,"orderValue");
	
	
	if(document.getElementById("mode").value=="view" )
		{
		
		}
	else
		{

	funRoundAmt(0,"roundOf");
		}
	
	
	
	funRoundAmt(orderValue,"orderValue");
    
 	var summaryData10= $("#jqxInvoiceGrid").jqxGrid('getcolumnaggregateddata', 'taxperamt', ['sum'],true);
  
	var aa1=summaryData10.sum.replace(/,/g,'');
	   	
	/*   
	 var aa1 =parseFloat(aa)-parseFloat(document.getElementById("txtnettotal").value);
	  */
	 funRoundAmt4(aa1,"st");
	 funRoundAmt4(aa1,"taxtotal");
				     
				       
				       $('#datas3').val(0);  
				   
			  $("#jqxInvoiceGrid").jqxGrid('addrow', null, {});
		     document.getElementById("jqxInput1").focus();
		  
		 }
		
		function calculatedatas(val)
		 {
			
			document.getElementById("errormsg").innerText="";
			
			 
			
	 
			var quantity=document.getElementById("quantity").value;
 
			
		 
			var focs=0;
			
			var uprice=document.getElementById("uprice").value;
			var taxpers=document.getElementById("taxpers").value;
			var totalstock=document.getElementById("totalstock").value;
			
			
			var disper=document.getElementById("dispers").value;
			var discount=document.getElementById("dict").value;
			
			if(val=="dispers"){discount=0; }
			 if(val=="dict"){disper=0; }
			
			var totamt=0;
			var taxamounts=0;
			var taxamountstotal=0;
			
			if(quantity=="" || quantity==null || quantity==0 ||typeof(quantity)=="undefined"|| typeof(quantity)=="NaN")
			{
				quantity=0;
			}
			
			if(focs=="" || focs==null || focs==0 ||typeof(focs)=="undefined"|| typeof(focs)=="NaN")
			{
				focs=0;
				
				
			}
			if(totalstock=="" || totalstock==null || totalstock==0 ||typeof(totalstock)=="undefined"|| typeof(totalstock)=="NaN")
			{
				totalstock=0;
			}
			
			
			if(disper=="" || disper==null || disper==0 || typeof(disper)=="undefined"|| typeof(disper)=="NaN")
			{
				disper=0;
			}
			
			
			if(discount=="" || discount==null || discount==0 || typeof(discount)=="undefined"|| typeof(discount)=="NaN")
			{
				discount=0;
			}
			
			
			
			
			
			 
			if(parseFloat(totalstock)<((parseFloat(quantity))))
				{
				 document.getElementById("errormsg").innerText="Quantity  should not be greater than available stock quantity : "+totalstock;
			 
				
				 return 0;
				
				}
			
			
			
			
			if(uprice=="" || uprice==null || uprice==0 || typeof(uprice)=="undefined"|| typeof(uprice)=="NaN")
			{
				uprice=0;
			}
			 
				 
			if(taxpers=="" || taxpers==null || taxpers==0 || typeof(taxpers)=="undefined"|| typeof(taxpers)=="NaN")
			{
				taxpers=0;
			}
			
			
			
			var netamount=0; 
			 if(parseFloat(quantity)>0 && parseFloat(uprice)>0)
				 {
				 
				 totamt=parseFloat(quantity)*parseFloat(uprice);
				/*  taxamountstotal=parseFloat(totamt)+parseFloat(taxamounts); */
				 
				 
				 
				 }
			 
				if(parseFloat(disper)>0 || parseFloat(discount)>0)
					
				{
				
				if(parseFloat(disper)>0)
					{
						discount=(parseFloat(totamt)*parseFloat(disper))/100;
					
					}
				
				else if(parseFloat(discount)>0)
					{
					
					disper=(100/parseFloat(totamt))*parseFloat(discount);
					
					}
				 
				netamount=parseFloat(totamt)-parseFloat(discount);
				
				}
			else
				{
				disper=0;
				discount=0;
				netamount=totamt;
				
				
				
				}
			
		 
			 
			 
			 if(parseFloat(taxpers))
			 {
				 
				 taxamounts=parseFloat(netamount)*(parseFloat(taxpers)/100);
				 taxamountstotal=parseFloat(netamount)+parseFloat(taxamounts);
			 }
			 else
				 {
				 taxamountstotal=netamount;
				 }
			 
			 document.getElementById("totamt").value=(totamt).toFixed(2);
			 document.getElementById("amounts").value=(totamt).toFixed(2);
			 document.getElementById("dispers").value=parseFloat(disper).toFixed(2);
			 document.getElementById("dict").value=parseFloat(discount).toFixed(2);
			 document.getElementById("amounts").value=(netamount).toFixed(2);
			 document.getElementById("taxamounts").value=(taxamounts).toFixed(2);
			 document.getElementById("taxamountstotal").value=(taxamountstotal).toFixed(2);
			
			 
	 
			//	document.getElementById("jqxInput1").focus();
			 
				 
		 
		 }
		
		
		
		function calculatedata()
		 {
	 
			var quantity=document.getElementById("quantity").value;
			
			var uprice=document.getElementById("uprice").value;
			var taxpers=document.getElementById("taxpers").value;
	 
			var totamt=0;
			var taxamounts=0;
			var taxamountstotal=0;
			
			if(quantity=="" || quantity==null || quantity==0 ||typeof(width)=="quantity"|| typeof(quantity)=="NaN")
			{
				quantity=0;
			}
			 
			if(uprice=="" || uprice==null || uprice==0 || typeof(uprice)=="undefined"|| typeof(uprice)=="NaN")
			{
				uprice=0;
			}
			 
				 
			if(taxpers=="" || taxpers==null || taxpers==0 || typeof(taxpers)=="undefined"|| typeof(taxpers)=="NaN")
			{
				taxpers=0;
			}
			
			 if(parseFloat(quantity)>0 && parseFloat(uprice)>0)
				 {
				 
				 totamt=parseFloat(quantity)*parseFloat(uprice);
				 taxamountstotal=totamt;
				 
				 
				 
				 }
			 if(parseFloat(taxpers))
			 {
				 
				 taxamounts=parseFloat(totamt)*(parseFloat(taxpers)/100);
				 taxamountstotal=parseFloat(totamt)+parseFloat(taxamounts);
			 }else{
				 taxamountstotal=totamt;	 
			 }
			 
			 
			 document.getElementById("totamt").value=(totamt).toFixed(2);
			 document.getElementById("amounts").value=(totamt).toFixed(2);
			 
			 document.getElementById("taxamounts").value=(taxamounts).toFixed(2);
			 document.getElementById("taxamountstotal").value=(taxamountstotal).toFixed(2);
				 
				 
			 document.getElementById("setbtn").focus();
				 
			 
			 
		 }

		function reloads()
		{
 	 var prodsearchtype=0;
	 var refmasterdocno="";
	 

	 
	 var reftype=$("#cmbreftype").val();
		 
		 
		var clientid=document.getElementById("clientid").value;
		 
		  
  		
		
		var cmbprice=document.getElementById("cmbprice").value;
		var cmbreftype=document.getElementById("cmbreftype").value;
		 var clientcaid=document.getElementById("clientcaid").value; 
		 var dates=document.getElementById("date").value;
		 
		 
		 var cmbbilltype=document.getElementById("cmbbilltype").value; 
		 
		
		 
 
		 
		 $("#part").load('part.jsp?prodsearchtype?prodsearchtype='+prodsearchtype+'&enqmasterdocno='+refmasterdocno+'&reftype='+reftype+'&cmbprice='+cmbprice+'&clientid='+clientid+'&cmbreftype='+cmbreftype+'&location='+document.getElementById("locationid").value+"&clientcaid="+clientcaid+"&dates="+dates+"&cmbbilltype="+cmbbilltype);
  	
		
		 $("#pnames").load('name.jsp?prodsearchtype='+prodsearchtype+'&enqmasterdocno='+refmasterdocno+'&reftype='+reftype+'&cmbprice='+cmbprice+'&clientid='+clientid+'&cmbreftype='+cmbreftype+'&location='+document.getElementById("locationid").value+"&clientcaid="+clientcaid+"&dates="+dates+"&cmbbilltype="+cmbbilltype);
	 
		}
		
		 function getunit(val){ 
			 
				
			   var x=new XMLHttpRequest();
			   x.onreadystatechange=function(){
			   if (x.readyState==4 && x.status==200)
			    {
			      items= x.responseText;
			       
			      items=items.split('####');
			           var docno=items[0].split(",");
			           var type=items[1].split(",");
			        
			           var optionstype;

			
			           for ( var i = 0; i < type.length; i++) {
			        	   optionstype += '<option value="' + docno[i] + '">' + type[i] + '</option>';
				        }
			            
			            $("select#unit").html(optionstype); 	
			            
			            
			         
			  
			    }
			       }
			   x.open("GET","getunit.jsp?psrno="+val,true);
				x.send();
			        
			      
			        }	
		 
		 
</script> 

</head>
<body>
  <input type="hidden" id="roundmethod">
<input type="hidden" id="roundval">

<div id="bacthWindow"> <div></div></div>
 
</body>
</html>