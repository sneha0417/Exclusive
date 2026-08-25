<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>

<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
  
<script type="text/javascript">
 
$(document).ready(function () { 

	
	$('#bacthWindow').jqxWindow({ width: '45%', height: '65%',  maxHeight: '75%' ,maxWidth: '60%'  , title: 'Search',position: { x: 700, y:100 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
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
	

		  var summaryData= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'netotal', ['sum'],true);
		  
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
	 
</script> 

</head>
<body>
  <input type="hidden" id="roundmethod">
<input type="hidden" id="roundval">

<div id="bacthWindow"> <div></div></div>
 
</body>
</html>