<!doctype html>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
<style>
 #psearch {
 
background:#FAEBD7;
 
}
.btn {
  background: #3498db;
  background-image: -webkit-linear-gradient(top, #3498db, #2980b9);
  background-image: -moz-linear-gradient(top, #3498db, #2980b9);
  background-image: -ms-linear-gradient(top, #3498db, #2980b9);
  background-image: -o-linear-gradient(top, #3498db, #2980b9);
  background-image: linear-gradient(to bottom, #3498db, #2980b9);
  -webkit-border-radius: 28;
  -moz-border-radius: 28;
  border-radius: 28px;
  font-family: Arial;
  color: #ffffff;
  font-size: 10px;
  padding: 4px 15px 6px 17px;
  text-decoration: none;
}

.btn:hover {
  background: #3cb0fd;
  background-image: -webkit-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -moz-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -ms-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -o-linear-gradient(top, #3cb0fd, #3498db);
  background-image: linear-gradient(to bottom, #3cb0fd, #3498db);
  text-decoration: none;
}
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
</style>
<meta charset="utf-8">
 	<title>GatewayERP(i)</title>
 <jsp:include page="../../../includes.jsp"></jsp:include> 
  <%
	String contextPath=request.getContextPath();
 %>
 <script>
 
 $(document).ready(function () { 
	 
   	 $("#date").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});    
   	 $("#fixDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});    
   	 $("#deliveryDate").jqxDateTimeInput({ width: '144px', height: '15px', formatString:"dd.MM.yyyy"});   
   	 $("#deliveryTime").jqxDateTimeInput({ width: '80%', height: '17px', formatString: 'HH:mm', showCalendarButton: false });
   	 $('#searchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
     $('#searchwindow').jqxWindow('close');
     $('#printWindow').jqxWindow({width: '30%', height: '19%',  maxHeight: '50%' ,maxWidth: '40%' , title: 'Print',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	  $('#printWindow').jqxWindow('close');
     
     $('#accountSearchwindow').jqxWindow({ width: '60%', height: '62%',  maxHeight: '75%' ,maxWidth: '70%' , title: 'Account Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
     $('#accountSearchwindow').jqxWindow('close');
     $('#Salesmanwindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 700, y: 60 }, keyboardCloseKey: 27});
     $('#Salesmanwindow').jqxWindow('close');   
     $('#sidesearchwndow').jqxWindow({ width: '55%', height: '95%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Product Search ' , position: { x: 600, y: 0 }, keyboardCloseKey: 27});
     $('#sidesearchwndow').jqxWindow('close');
 	$('#codeWindow').jqxWindow({ width: '20%', height: '50%',  maxHeight: '75%' ,maxWidth: '60%'  , title: 'Search',position: { x: 700, y:100 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	$('#codeWindow').jqxWindow('close');
	 $('#refnosearchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
	   $('#refnosearchwindow').jqxWindow('close'); 
		 $('#date').on('change', function (event) {
			  
			    var maindate = $('#date').jqxDateTimeInput('getDate');
			  	 if ($("#mode").val() == "A" || $("#mode").val() == "E" ) {   
			    funDateInPeriodchk(maindate);
			  	 }
			   });
  $('#accid').dblclick(function(){
  	//($("#mode").val() == "view")
  	if($('#mode').val()!= "view")
  		{
  	
  		
	  	    $('#accountSearchwindow').jqxWindow('open');
	   
	  	  accountSearchContent('AccountDetailsSearch.jsp?');
  		}
});   
  
  $('#salesmanname').dblclick(function(){
	  
	  salesmanSearchContent('SearchSalesman.jsp?', $('#Salesmanwindow')); 
});
	   $('#itemdocno').dblclick(function(){

			  if($("#mode").val() == "A" || $("#mode").val() == "E")
				  {
		 
			 
	  	    $('#searchwindow').jqxWindow('open');
	  	
			if(document.getElementById("itemtype").value=="1") 
				{
			 
				refsearchContent('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/costCodeSearchGrid.jsp?docno='+document.getElementById("itemtype").value); 	
				}
			else if(document.getElementById("itemtype").value=="6")
			{
			 refsearchContent('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/fleetGrid.jsp?'); 	
			}
		
			else
				{
				 refsearchContent('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/costunitsearch.jsp?docno='+document.getElementById("itemtype").value); 	
				}
			
			 
				  }
		  }); 
	   
	   
		 $('#rrefno').dblclick(function(){
			   
			 
			 refsearchContent1('cormainsearch.jsp');
					
				 
				
			 
		  });
		 
		
	});
 
 function getrrefno(event)
 {
	  
 
		
	  
	  
 	 var x= event.keyCode;
 	 if(x==114){
 	
 	
 	  refsearchContent1('cormainsearch.jsp');  }
 	 else{
 		 }
 	 }  
 
 
	  function refsearchContent1(url) {
	 
	  $('#refnosearchwindow').jqxWindow('open');
      
        $.get(url).done(function (data) {
//alert(data);
      $('#refnosearchwindow').jqxWindow('setContent', data);

	}); 
  	}	
 function productSearchContent(url) {
  	 //alert(url);
  		 $.get(url).done(function (data) {
  			 
  			 $('#sidesearchwndow').jqxWindow('open');
  		$('#sidesearchwndow').jqxWindow('setContent', data);
  
  	}); 
  	} 

 function codeinfoSearchContent(url) {
	 //alert(url);
		 $.get(url).done(function (data) {
			 
			 $('#codeWindow').jqxWindow('open');
		$('#codeWindow').jqxWindow('setContent', data);
		       
	}); 
} 
 
 function salesmanSearchContent(url) {
     //alert(url);
       $.get(url).done(function (data) {
//alert(data);
 $('#Salesmanwindow').jqxWindow('open');
     $('#Salesmanwindow').jqxWindow('setContent', data);

	}); 
 	}
function getsal(event){
   	 var x= event.keyCode;
   	 if(x==114){
   	 
   
     
    salesmanSearchContent('SearchSalesman.jsp?', $('#Salesmanwindow')); }
   	 else{
   		 }
   	 }

	function getaccountdetails(event){
	 	 var x= event.keyCode;
	 	 
	 	if($('#mode').val()!= "view")
		{
		 	 if(x==114){
		 	  $('#accountSearchwindow').jqxWindow('open');
		 
		 
			  accountSearchContent('AccountDetailsSearch.jsp?');  }
		 	 else{
		 		 }
		  } 
	 	 }  
 
	  function accountSearchContent(url) {
	       //alert(url);
	        document.getElementById("errormsg").innerText="";
	          $.get(url).done(function (data) {
	//alert(data);
	        $('#accountSearchwindow').jqxWindow('setContent', data);
	
		}); 
	    	}
 function getitem(event){
  	 var x= event.keyCode;
  	 if(x==114){

  		  $('#searchwindow').jqxWindow('open');
  			
  		if(document.getElementById("itemtype").value=="1") //com/search/costunit/costCodeSearchGrid.jsp
		{
		refsearchContent('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/costCodeSearchGrid.jsp?docno='+document.getElementById("itemtype").value); 	
		}
  		
		else if(document.getElementById("itemtype").value=="6")
		{
		 refsearchContent('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/fleetGrid.jsp?'); 	
		}
	
  		
	else
		{
		 refsearchContent('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/costunitsearch.jsp?docno='+document.getElementById("itemtype").value); 	
		}
	

  		 
  		  
  	 
  	 }
  	 else{
  		 }
  	 }  
  	  function refsearchContent(url) {
       //alert(url);
       document.getElementById("errormsg").innerText="";
          $.get(url).done(function (data) {
  //alert(data);
        $('#searchwindow').jqxWindow('setContent', data);

  	}); 
    	}
 
 function funReadOnly(){  
	   
 	 $('#frmsave input').attr('readonly', true );
		 
		$('#frmsave select').attr('disabled', true);
		 $('#setbtn').attr('disabled', true );

		$('#date').jqxDateTimeInput({ disabled: true});
		 
		$("#deliveryDate").jqxDateTimeInput({ disabled: true});
		$("#deliveryTime").jqxDateTimeInput({ disabled: true});
		$("#fixDate").jqxDateTimeInput({ disabled: true});  
		
		
 $('#rrefno').attr('disabled', true );
		 
		 
		 $('#rrefno').attr('readonly', true );
		 
	 
 }
 
 function funRemoveReadOnly(){
	 
	 
	 $('#frmsave input').attr('readonly', false );
	 
		$('#frmsave select').attr('disabled', false);
		$('#setbtn').attr('disabled', false );

		$('#date').jqxDateTimeInput({ disabled: false});
		 
		$("#deliveryDate").jqxDateTimeInput({ disabled: false});
		$("#deliveryTime").jqxDateTimeInput({ disabled: false});
		$("#fixDate").jqxDateTimeInput({ disabled: false});
		 $('#itemdocno').attr('readonly', true );
		 $('#itemname').attr('readonly', true );
		 $('#salesmanname').attr('readonly', true );
		 
		 $('#totsize').attr('readonly', true );
		 $('#pcharge').attr('readonly', true );
		 $('#bvalue').attr('readonly', true );
		 $('#amounts').attr('readonly', true );
	 
		 
		 $('#docno').attr('readonly', true );
		 $('#accid').attr('readonly', true );
		 $('#accname').attr('readonly', true );
		 $('#currs').attr('readonly', true );
		 $('#ratess').attr('readonly', true );
		  $("#prdGridID").jqxGrid({ disabled: false});
		    $("#part").load("part.jsp?id=search");
		      $("#pnames").load("name.jsp?id=search");
		      
		    
		 
		 if ($("#mode").val() == "A") {
			 
		 		$('#date').val(new Date());
				$('#deliveryDate').val(new Date());
				$('#deliveryTime').val(new Date());
				//
				$('#fixDate').val(new Date());
				$('#jqxTimeOut').val(new Date());
				  $("#prdGridID").jqxGrid({ disabled: false});
		        $("#prdGridID").jqxGrid('clear');
		      $("#prdGridID").jqxGrid('addrow', null, {});
		      
				
		      $('#rrefno').attr('disabled', true );
		      $('#rrefno').attr('readonly', true );
		      
			   if($('#rreftypeval').val()=="COR")
			   {
			   $('#rrefno').attr('disabled', false );
			  	 $('#rrefno').attr('readonly', true );
			  	 $('#psearch').attr('disabled', true );
			   }
		   else
			   {
			   $('#rrefno').attr('disabled', true );
			  	 $('#rrefno').attr('readonly', true );
			  	 $('#psearch').attr('disabled', false );
			   }
		   
		      
		  
		      
		      
		     } 
		 if ($("#mode").val() == "E") {
			 
			   $("#prdGridID").jqxGrid('addrow', null, {});
			   
			   if($('#rreftypeval').val()=="COR")
				   {
				   $('#rrefno').attr('disabled', false );
				  	 $('#rrefno').attr('readonly', true );
				  	 $('#psearch').attr('disabled', true );
				   }
			   else
				   {
				   $('#rrefno').attr('disabled', true );
				  	 $('#rrefno').attr('readonly', true );
				  	 $('#psearch').attr('disabled', false );
				   }
			   
				
			   
		 }
		 
		 
		 
		 
	 
	  
 }
 
 function funNotify(){
		
		var maindate = $('#date').jqxDateTimeInput('getDate');
		   var validdate=funDateInPeriodchk(maindate);
		   if(validdate==0){
		   return 0; 
		   }
		   
		   if(document.getElementById("itemdocno").value=="")
		   {
		 
		   document.getElementById("errormsg").innerText=" * Job No Is Required ";
		   document.getElementById("itemdocno").focus();
	  	     return 0;
		   
		   }
	   if(document.getElementById("accid").value=="")
	   {
		   document.getElementById("errormsg").innerText=" * Account Is Required. ";
	   document.getElementById("accid").focus();
  	    
  	     return 0;
	   
	   }
	   

	 var rows = $("#prdGridID").jqxGrid('getrows');
	    $('#gridlenght').val(rows.length);
	   //alert($('#gridlength').val());
	   for(var i=0 ; i < rows.length ; i++){
	   // var myvar = rows[i].tarif; 
	    newTextBox = $(document.createElement("input"))
	       .attr("type", "dil")
	       .attr("id", "test"+i)
	       .attr("name", "test"+i)  
	    .attr("hidden", "true"); 
	    
	 
	    newTextBox.val(rows[i].psrno+"::"+rows[i].unitdocno+" :: "+rows[i].specid+" :: "+rows[i].floor+" :: "
	    		+rows[i].flatids+"::"+rows[i].width+" :: "+rows[i].height+" :: "+rows[i].quantity+" :: "
	    		+rows[i].sqm+"::"+rows[i].totsize+" :: "+rows[i].price+" :: "+rows[i].bevcode+" :: "
	    		+rows[i].bevrate+"::"+rows[i].bevvalue+" :: "+rows[i].polcode+" :: "+rows[i].polrate+" :: "
	    		+rows[i].polcharge+"::"+rows[i].temp+" :: "+rows[i].amount+" :: "+rows[i].refrow+" :: "+rows[i].productname+" :: "); 
	   
 
	   newTextBox.appendTo('form');
	  
	    
	   }   
	   
		$('#date').jqxDateTimeInput({ disabled: false});
		 
		$("#deliveryDate").jqxDateTimeInput({ disabled: false});
		$("#deliveryTime").jqxDateTimeInput({ disabled: false});
		$("#fixDate").jqxDateTimeInput({ disabled: false});
	
	return 1;
	 
	 
 }
 function funDateInPeriodchk(value){
	    var styear = new Date(window.parent.txtaccountperiodfrom.value);
	    var edyear = new Date(window.parent.txtaccountperiodto.value);
	    var mclose = new Date(window.parent.monthclosed.value);
	    mclose.setHours(0,0,0,0);
	    edyear.setHours(0,0,0,0);
	    styear.setHours(0,0,0,0);
	    var currentDate = new Date(new Date());
	 
	     if(value>currentDate){
	     document.getElementById("errormsg").innerText="Future Date, Transaction Restricted. ";
	    
	     return 0;
	    } 
	    
	    document.getElementById("errormsg").innerText="";
	   
	     return 1;
	 }

 function funFocus(){
	 $('#date').jqxDateTimeInput('focus'); 	    
 }
 
 
	function funchkforedit()
 {
	

	
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();	
				if(parseInt(items)>0)
					{
					
					 $("#btnEdit").attr('disabled', true );
					 $("#btnDelete").attr('disabled', true ); 
					 
					 
					 
					}
				else
					{
					 
					}
			  
				
				
				
			} else {
			}
		}
		x.open("GET", "linkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value, true);
		x.send();    
	
	
	}
 function setValues(){
	 if($('#hiddate').val()){
			$("#date").jqxDateTimeInput('val', $('#hiddate').val());
		}
	 if($('#hidfixDate').val()){
			$("#fixDate").jqxDateTimeInput('val', $('#hidfixDate').val());
		}
	 if($('#hiddeliveryDate').val()){
			$("#deliveryDate").jqxDateTimeInput('val', $('#hiddeliveryDate').val());
		}
		 
	 if($('#hiddeliveryTime').val()){
			$("#deliveryTime").jqxDateTimeInput('val', $('#hiddeliveryTime').val());
		}
	 
	 
	 
	  var docVal1 = document.getElementById("masterdoc_no").value;
	  
   	if(docVal1>0)
   		{
   	 
   		funchkforedit();
  
		 $("#Gridid").load("prdgrid.jsp?docno="+docVal1);
	     
         if($('#hideacctype').val()!="")
			  {
			  
			  
			  $('#acctype').val($('#hideacctype').val());  
			  
			  
			  
			  
			  }
         if($('#rreftypeval').val()!="")
		  {
		  
		  
		  $('#rreftype').val($('#rreftypeval').val());  
		  
		  
		  if($('#rreftypeval').val()=="COR")
			  {
			  
			   
				 $('#psearch').attr('disabled', true );
				 $('#rrefno').attr('disabled', true );
				 $('#rrefno').attr('readonly', true );
				 
				 
		 
				 
				 
				 }
			 else
				 {
		           $('#rrefno').attr('disabled', true );
				 
				 
				 $('#rrefno').attr('readonly', true );
				 $('#psearch').attr('disabled', false );
				 
				 }
		  
		  
		  
		  }
  	  
         
     
		 
   		}
   	if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
	 
   	document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";   
   	//document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
 }
 
 function funChkButton(){
	 
 }
 
 function funSearchLoad(){
		changeContent('mainsearch.jsp'); 
	}
 
 function getpcode(){ 
	 
		
	   var x=new XMLHttpRequest();
	   x.onreadystatechange=function(){
	   if (x.readyState==4 && x.status==200)
	    {
	      items= x.responseText;
	       
	      items=items.split('####');
	           var docno=items[0].split(",");
	           var type=items[1].split(",");
	        
	           var optionstype = '<option value="0">--select--</option>';

	
	           for ( var i = 0; i < type.length; i++) {
	        	   optionstype += '<option value="' + docno[i] + '">' + type[i] + '</option>';
		        }
	            
	            $("select#pcode").html(optionstype); 	
	            
	            
	         
	  
	    }
	       }
	   x.open("GET","getpcode.jsp?",true);
		x.send();
	        
	      
	        }
 
 function getbcode(){  
	 
		
	   var x=new XMLHttpRequest();
	   x.onreadystatechange=function(){
	   if (x.readyState==4 && x.status==200)
	    {
	      items= x.responseText;
	       
	      items=items.split('####');
	           var docno=items[0].split(",");
	           var type=items[1].split(",");
	        
	           var optionstype = '<option value="0">--select--</option>';

	
	           for ( var i = 0; i < type.length; i++) {
	        	   optionstype += '<option value="' + docno[i] + '">' + type[i] + '</option>';
		        }
	            
	            $("select#bcode").html(optionstype); 	
	            
	             
	  
	    }
	       }
	   x.open("GET","getbcode.jsp?",true);
		x.send();
	        
	      
	        }
 
 
 
 function getitemtype(){ 
	 
		
	   var x=new XMLHttpRequest();
	   x.onreadystatechange=function(){
	   if (x.readyState==4 && x.status==200)
	    {
	      items= x.responseText;
	       
	      items=items.split('####');
	           var docno=items[0].split(",");
	           var type=items[1].split(",");
	        
	           var optionstype = '';

	
	           for ( var i = 0; i < type.length; i++) {
	        	   optionstype += '<option value="' + docno[i] + '">' + type[i] + '</option>';
		        }
	            
	            $("select#itemtype").html(optionstype); 	
	            
	            
	            if($('#hideitemtype').val()!="")
				  {
				  
				  
				  $('#itemtype').val($('#hideitemtype').val());   
				  
				  }
			 
	  
	    }
	       }
	   x.open("GET","getitem.jsp?",true);
		x.send();
	        
	      
	        }
 function setgrid()
 {
	 var rows = $('#prdGridID').jqxGrid('getrows');
	  
 
		 
     var rowlength= rows.length;
 
     $('#prdGridID').jqxGrid('setcellvalue',  rowlength-1, "proid", document.getElementById("jqxInput").value);
     $('#prdGridID').jqxGrid('setcellvalue',  rowlength-1, "proname", document.getElementById("jqxInput1").value);
     
     $('#prdGridID').jqxGrid('setcellvalue',  rowlength-1, "floor", document.getElementById("floor").value);
     $('#prdGridID').jqxGrid('setcellvalue',  rowlength-1, "flatids", document.getElementById("flat").value);
     $('#prdGridID').jqxGrid('setcellvalue',  rowlength-1, "width", document.getElementById("width").value);
     $('#prdGridID').jqxGrid('setcellvalue',  rowlength-1, "height", document.getElementById("height").value);
          
     $('#prdGridID').jqxGrid('setcellvalue',  rowlength-1, "quantity", document.getElementById("quantity").value);
     
     $('#prdGridID').jqxGrid('setcellvalue',  rowlength-1, "sqm", document.getElementById("sqm").value);
     $('#prdGridID').jqxGrid('setcellvalue',  rowlength-1, "totsize", document.getElementById("totsize").value);
     $('#prdGridID').jqxGrid('setcellvalue',  rowlength-1, "price", document.getElementById("price").value);
    
     $('#prdGridID').jqxGrid('setcellvalue',  rowlength-1, "bevcode", document.getElementById("bcode").value);
     if(document.getElementById("bcode").value>0)
     {
     $('#prdGridID').jqxGrid('setcellvalue',  rowlength-1, "bevcodename", $("#bcode option:selected").text());
     }
     $('#prdGridID').jqxGrid('setcellvalue',  rowlength-1, "bevrate", document.getElementById("brate").value);
     $('#prdGridID').jqxGrid('setcellvalue',  rowlength-1, "bevvalue", document.getElementById("bvalue").value);
     
     $('#prdGridID').jqxGrid('setcellvalue',  rowlength-1, "polcode", document.getElementById("pcode").value);
     if(document.getElementById("pcode").value>0)
     {
     $('#prdGridID').jqxGrid('setcellvalue',  rowlength-1, "polcodename", $("#pcode option:selected").text()); 
     }
     $('#prdGridID').jqxGrid('setcellvalue',  rowlength-1, "polrate", document.getElementById("prate").value);
     $('#prdGridID').jqxGrid('setcellvalue',  rowlength-1, "polcharge", document.getElementById("pcharge").value);
     
     $('#prdGridID').jqxGrid('setcellvalue',  rowlength-1, "temp", document.getElementById("temp").value);
     $('#prdGridID').jqxGrid('setcellvalue',  rowlength-1, "amount", document.getElementById("amounts").value);
     
     $('#prdGridID').jqxGrid('setcellvalue',  rowlength-1, "psrno", document.getElementById("temppsrno").value);
     $('#prdGridID').jqxGrid('setcellvalue',  rowlength-1, "unit", document.getElementById("tempunit").value);
     $('#prdGridID').jqxGrid('setcellvalue',  rowlength-1, "unitdocno", document.getElementById("tempunitdocno").value);
     $('#prdGridID').jqxGrid('setcellvalue',  rowlength-1, "specid", document.getElementById("tempspecid").value);
     
     
     $('#prdGridID').jqxGrid('setcellvalue', rowlength-1, "productid" ,document.getElementById("jqxInput").value);
     $('#prdGridID').jqxGrid('setcellvalue',  rowlength-1, "productname", document.getElementById("jqxInput1").value);
     
   
     
	  if(document.getElementById("cleardata").checked==true) 
		  {
		   document.getElementById("jqxInput").value ="";
		   document.getElementById("jqxInput1").value="";
		   document.getElementById("floor").value=""; 
           document.getElementById("flat").value ="";
		   document.getElementById("width").value ="";
		   document.getElementById("height").value ="";
		         
		      document.getElementById("quantity").value="";
		     
		      document.getElementById("sqm").value="";
		      document.getElementById("totsize").value="";
		      document.getElementById("price").value="";
		    
		      document.getElementById("bcode").value="";
		      document.getElementById("brate").value="";
		      document.getElementById("bvalue").value="";
		     
		       document.getElementById("pcode").value="";
		       document.getElementById("prate").value="";
		       document.getElementById("pcharge").value="";
		     
		      document.getElementById("temp").value="";
		      document.getElementById("amounts").value="";
		      
		      
		       document.getElementById("temppsrno").value="";
		       document.getElementById("tempspecid").value="";
		       document.getElementById("tempunit").value="";
		       document.getElementById("tempunitdocno").value="";
		      
		      
		      document.getElementById("cleardata").checked=false;
		     
		      getpcode(); getbcode();
		      
		  }
	  $("#prdGridID").jqxGrid('addrow', null, {});
     document.getElementById("jqxInput").focus();
 
 }
 function cleardatas()
 {
	 
	 document.getElementById("itemdocno").value="";
	 document.getElementById("itemname").value="";
 
	 
 
 }
 function isNumber1(evt) {
     var iKeyCode = (evt.which) ? evt.which : evt.keyCode
     if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
     	{
  	   document.getElementById("errormsg").innerText=" Enter Numbers Only";  
        
         return false;
     	}
     document.getElementById("errormsg").innerText="";  
     return true;
 }
 
 function calculatedata()
 {
	var width=document.getElementById("width").value;
	var height=document.getElementById("height").value;
	var quantity=document.getElementById("quantity").value;
	
	var price=document.getElementById("price").value;
	var brate=document.getElementById("brate").value;
 
	var prate=document.getElementById("prate").value;
	var sqm=document.getElementById("sqm").value;
	 
	
	
	if(width=="" || width==null || width==0 ||typeof(width)=="undefined"|| typeof(width)=="NaN")
	{
		width=0;
	}
	 
	if(height=="" || height==null || height==0 || typeof(height)=="undefined"|| typeof(height)=="NaN")
	{
		height=0;
	}
	else
		 
	if(quantity=="" || quantity==null || quantity==0 || typeof(quantity)=="undefined"|| typeof(quantity)=="NaN")
	{
		quantity=0;
	}
	
	 
	 
	if(quantity==0)
		{
		document.getElementById("totsize").value=0;
		}
	else
		{
		document.getElementById("totsize").value=(((parseFloat(width)/1000)*(parseFloat(height)/1000))*parseFloat(quantity)).toFixed(4);
		}
	 
	
	 
	
  var brates=0;
	if(brate=="" || brate==null || brate==0 || typeof(brate)=="undefined"|| typeof(brate)=="NaN")
	{
		brate=0;
		document.getElementById("bvalue").value=0;
	}
	else
		{
		document.getElementById("bvalue").value=(((parseFloat(width)+parseFloat(height))/1000)*2*parseFloat(quantity)*parseFloat(brate)).toFixed(4);
		brates=(((parseFloat(width)+parseFloat(height))/1000)*2*parseFloat(quantity)*parseFloat(brate)).toFixed(4);
		}
	var braprates=0;
	if(prate=="" || prate==null || prate==0 || typeof(prate)=="undefined"|| typeof(prate)=="NaN")
	{
		prate=0;
		document.getElementById("pcharge").value=0;
	}
	else
		{
		document.getElementById("pcharge").value=(((parseFloat(width)+parseFloat(height))/1000)*2*parseFloat(quantity)*parseFloat(prate)).toFixed(4);
		braprates=(((parseFloat(width)+parseFloat(height))/1000)*2*parseFloat(quantity)*parseFloat(prate)).toFixed(4);
		}
	
	
	
	if(price=="" || price==null || price==0 || typeof(price)=="undefined"|| typeof(price)=="NaN")
	{
		price=0;
	}
	else
		{
		 
		if(sqm=="YES")
		 {
			var sqlval=(((parseFloat(width)/1000)*(parseFloat(height)/1000)));
			 
			
			document.getElementById("amounts").value=(((parseFloat(price)*parseFloat(quantity))*parseFloat(sqlval))+(parseFloat(brates)+parseFloat(braprates))).toFixed(4);
		 }
		else
			{
			document.getElementById("amounts").value=((parseFloat(price)*parseFloat(quantity))+(parseFloat(brates)+parseFloat(braprates))).toFixed(4);
			}
		}
	
	
	
	 
	 
 }
 
 
 function changedtype()
 {   
	 if(document.getElementById("rreftype").value=="COR")
		 {
		 
		 document.getElementById("rrefno").value="";
		 document.getElementById("masterrrefno").value="";
		 $('#psearch').attr('disabled', true );
		 $('#rrefno').attr('disabled', false );
		 $('#rrefno').attr('readonly', true );
		 
		  $("#prdGridID").jqxGrid('clear');
	      $("#prdGridID").jqxGrid('addrow', null, {});
		 
 
		 
		 
		 }
	 else
		 {
           $('#rrefno').attr('disabled', true );
		 
		 document.getElementById("rrefno").value="";
		 document.getElementById("masterrrefno").value="";
		 $('#rrefno').attr('readonly', true );
		 $('#psearch').attr('disabled', false );
		  $("#prdGridID").jqxGrid('clear');
	      $("#prdGridID").jqxGrid('addrow', null, {});
		 }
	 
 }
 
 
 function clearacdata()
 {
	 document.getElementById("accid").value="";
	 document.getElementById("accname").value="";
	 document.getElementById("currs").value="";
	 document.getElementById("ratess").value="";
	 document.getElementById("currsid").value="";
	 document.getElementById("acno").value="";
	 
 }
 function PrintContent(url) {
		$('#printWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#printWindow').jqxWindow('setContent', data);
		$('#printWindow').jqxWindow('bringToFront');
	}); 
	}
 function funPrintBtn(){
	 
	 
	 if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
		  
		  PrintContent('printVoucherWindow.jsp');
	   } 
	  
	   else {
	    	      $.messager.alert('Message','Select a Document....!','warning');
	    	      return false;
	    	     }
	   <%-- if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
	  
	   var url=document.URL;

     var reurl=url.split("savedly");
     
    // $("#docno").prop("disabled", false);                
     

var brhid=<%=session.getAttribute("BRANCHID").toString()%>
    	 var dtype=$('#formdetailcode').val();

var win= window.open(reurl[0]+"printdly?docno="+document.getElementById("masterdoc_no").value+"&dtype="+dtype+"&brhid="+brhid,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");    
win.focus();
	   } 
	  
	   else {
	    	      $.messager.alert('Message','Select a Document....!','warning');
	    	      return false;
	    	     } --%>
	    	
	}


 </script>
</head>

</head>
<body onload="setValues();getitemtype();getpcode();getbcode();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmsave" action="savedly" autocomplete="OFF" method="post" > 
<jsp:include page="../../../header.jsp"></jsp:include> 
<br>
<fieldset>
 
<table width="100%"   >
  <tr>
    <td width="5%" align="right">Date</td> 
    <td width="8">
	    <div id='date' name='date' value='<s:property value="date"/>'></div> 
    </td>
    <td width="25%" align="right">RefType<select id="rreftype" name="rreftype" width="10%" onchange="changedtype()" ><option>DIR</option><option>COR</option> </select>
     <input type="text" id="rrefno" placeholder="Press F3 to Search"   style="width:50%;"    name="rrefno"  onkeydown="getrrefno(event);" value='<s:property value="rrefno"/>' >  </td>
    <td width="55%" align="right" colspan="7">Group 
    <select  id="itemtype"  name="itemtype" style="width:17%;" onchange="cleardatas()">  <option>
     </option>   
                             
    </select> 
    Job No.<input type="text" id="itemdocno" placeholder="Press F3 to Search"   style="width:25%;"    name="itemdocno"  onkeydown="getitem(event);" value='<s:property value="itemdocno"/>' > 
    <input type="text" id="itemname" name="itemname" style="width:40%;"  tabindex="-1"  value='<s:property value="itemname"/>' ></td>
   
      
    <td width="5%" align="right">Doc No</td>
    <td width="10%"><input type="text" name="docno" id="docno" tabindex="-1" value='<s:property value="docno"/>'></td> 
  </tr>
  <tr>
    <td align="right">Acc No</td>
    <td colspan="8"><select style="width: 50px;" name="acctype" id="acctype" onchange="clearacdata()" value='<s:property value="acctype"/>'>
    <option value="AR">AR</option>
     <option value="AP">AP</option>
      <option value="GL">GL</option> 
    </select>  <input type="text" name="accid" id="accid" value='<s:property value="accid"/>' placeholder="Press F3 To Search"  style="width:21%;" onKeyDown="getaccountdetails(event);" >  
      <input type="text" id="accname" name="accname" value='<s:property value="accname"/>' tabindex="-1"   style="width:46%;"> 
   &nbsp; &nbsp;    Currency 
     <input name="currs"type="text" id="currs" style="width:8%;" tabindex="-1"  value='<s:property value="currs"/>'>&nbsp;&nbsp;&nbsp;Rate
    <input name="ratess" type="text" id="ratess"style="width:7%;" tabindex="-1"  value='<s:property value="ratess"/>'> 
      </td>
    <td align="right" width="5%">Fix Date</td>
    <td><div id='fixDate' name='fixDate' value='<s:property value="fixDate"/>'></div></td> 
     <td   align="right">&nbsp;</td>
 
  </tr>      
 <tr>
  <td align="right">LPO No</td>
    <td><input type="text" name="lpono" id="lpono" value='<s:property value="lpono"/>'>  </td>
      <td align="left" >Salesman 
    <input type="text" name="salesmanname" id="salesmanname"   placeholder="Press F3 to Search" style="width:75%;"  value='<s:property value="salesmanname"/>' onkeydown="getsal(event);" ></td>
      
      
  <td align="right" width="5%">Del. Date</td>
    <td width="8%"><div id='deliveryDate' name='deliveryDate' value='<s:property value="deliveryDate"/>'></div></td>
     <td align="right" width="6%" >Del. Time</td>
      <td width="5%"><div id='deliveryTime' name='deliveryTime' value='<s:property value="deliveryTime"/>'></div></td>
     <td align="right" width="5%" >Remarks</td>
      <td align="left" colspan="7" >
     <input name="remarks" type="text"  style="width:72%;" id="remarks" value='<s:property value="remarks"/>' ></td> 
      
</table>
</fieldset>
 <fieldset id="psearch">
 
 <legend><b>Item Details</b></legend>
 
   <table width="100%" >
   <tr> 
   <td align="center">Product ID</td>
   <td align="center" colspan="2">Product Name</td>
   <td align="center" style="width:5%;">Floor</td>
   <td align="center">Flat</td>
   <td  width="6%" align="center">Width (mm)</td>
   <td align="center">Height (mm)</td>
   <td align="center">Quantity</td>
   <td align="center">SQM</td>
   <td align="center">Tot Size</td>
   </tr>
  <!--   onblur="funRoundAmt(this.value,this.id);" -->
   
    <tr><td><div id="part" onkeydown="return (event.keyCode!=13);"><jsp:include page="part.jsp"></jsp:include></div> </td>
 <td colspan="2"> <div id="pnames" onkeydown="return (event.keyCode!=13);"><jsp:include page="name.jsp"></jsp:include></div> </td>
 <td>   <input type="text" id="floor"    ></td>
<td>   <input type="text" id="flat"   ></td>
<td width="6%">   <input type="text" id="width"  onkeypress="javascript:return isNumber1 (event);"  onchange="calculatedata();" ></td>
<td>   <input type="text" id="height" onkeypress="javascript:return isNumber1 (event);"  onchange="calculatedata();"  ></td>
 <td>   <input type="text" id="quantity"onkeypress="javascript:return isNumber1 (event);" onchange="calculatedata();"    ></td>
 <td align="center">  <select  id="sqm" onchange="calculatedata();"><option></option><option>YES</option><option>NO</option></select></td>
 <td>   <input type="text" id="totsize" tabindex="-1"   onkeypress="javascript:return isNumber1 (event);"  style="text-align: right;"   ></td>
 
 
 
 </tr>
 <tr>
 <td align="center">Price</td>
 <td align="center">Bevelling Code</td> 
   <td align="center">Bev. Rate</td>
      <td align="center">Bev. Value</td>
   <td    align="center">Polishing Code</td> 
   <td align="center">Pol Rate</td>
      <td align="center">Pol Charge</td>
   <td align="center">Temp</td>
   <td align="center">Amount</td>
    <td align="left">Clear</td> 
 </tr>
 <tr>
 <td>   <input type="text" id="price"    onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1 (event);"  onchange="calculatedata();" style="text-align: right;"></td>
  <td align="center">   <select  type="text" id="bcode"   ></select></td>
 <td>   <input type="text" id="brate"   onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1 (event);"  onchange="calculatedata();"  style="text-align: right;"  ></td>
<td>   <input type="text" id="bvalue" tabindex="-1" onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1 (event);"    style="text-align: right;"  ></td>
<td align="center">  <select  type="text" id="pcode"   ></select>
<td>   <input type="text" id="prate"   onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1 (event);"  onchange="calculatedata();" style="text-align: right;" ></td>
<td>   <input type="text" id="pcharge" tabindex="-1" onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1 (event);"  style="text-align: right;"   ></td>
<td>   <input type="text" id="temp"   ></td>
<td>   <input type="text" id="amounts" tabindex="-1"    onkeypress="javascript:return isNumber1 (event);"  style="text-align: right;" ></td>
 
  <td> <input type="checkbox" id="cleardata">  
  
   &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp;  
  <input type="button" id="setbtn"  class="btn" onclick="setgrid()" value="ADD" ></td>
 </tr>  
   
   </table> 
   </fieldset> 
  <input type="text" name="gridtext" id="gridtext"  style="width:0%;height:0%;"  class="textbox" value='<s:property value="gridtext"/>'  />   
   <input type="text" name="gridtext1" id="gridtext1"  style="width:0%;height:0%;"  class="textbox" value='<s:property value="gridtext1"/>' />  
<fieldset>

<div id="Gridid">
 <jsp:include page="prdgrid.jsp"></jsp:include>
</div>

</fieldset>

    <input type="hidden" name="salid" id="salid" value='<s:property value="salid"/>' >
    
    
       <input type="hidden" id="currsid" name="currsid"  value='<s:property value="currsid"/>'/> 
    
     <input type="hidden" id="acno" name="acno"  value='<s:property value="acno"/>'/> 
     
        <input type="hidden" id="temppsrno" > 
        <input type="hidden" id="tempspecid" > 
        <input type="hidden" id="tempunit" > 
        <input type="hidden" id="tempunitdocno" >     
    

 <input type="hidden" id="costtr_no" name="costtr_no"  value='<s:property value="costtr_no"/>'/> 
 <input type="hidden" id="costcheck" name="costcheck"  value='<s:property value="costcheck"/>'/>
 
 <input type="hidden" id="rreftypeval" name="rreftypeval"  value='<s:property value="rreftypeval"/>'/>
 
  
 <input type="hidden" id="hideitemtype" name="hideitemtype"  value='<s:property value="hideitemtype"/>'/> 
  <input type="hidden" id="hideacctype" name="hideacctype"  value='<s:property value="hideacctype"/>'/> 
 
  <input type="hidden" id="hiddate" name="hiddate"  value='<s:property value="hiddate"/>'/>
   <input type="hidden" id="hidfixDate" name="hidfixDate"  value='<s:property value="hidfixDate"/>'/>
    <input type="hidden" id="hiddeliveryDate" name="hiddeliveryDate"  value='<s:property value="hiddeliveryDate"/>'/>
     <input type="hidden" id="hiddeliveryTime" name="hiddeliveryTime"  value='<s:property value="hiddeliveryTime"/>'/>
 
  <input type="hidden" id="gridlenght" name="gridlenght"  value='<s:property value="gridlenght"/>'/>
     
 
 <input type="hidden" id="hidetype" name="hidetype"  value='<s:property value="hidetype"/>'/>
 
  <input type="hidden" id="masterrrefno" name="masterrrefno" value='<s:property value="masterrrefno"/>' />  
   
 <input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>' />  
 
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />

  <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>

</form>
 <div id="searchwindow">
   <div ></div>
</div>
 <div id="accountSearchwindow">
   <div ></div>
</div>
<div id="Salesmanwindow">
   <div ></div>
</div>


	 <div id="sidesearchwndow">
	   <div ></div>
	</div>
<div id="codeWindow"><div></div></div>
<div id="refnosearchwindow"><div></div></div>
<div id="printWindow"><div></div></div>

</div>
</body>
</html>
