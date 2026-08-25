<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<%
	String mod = request.getParameter("mod") == null ? "view" : request
			.getParameter("mod").toString();
 String purchasearray = request.getParameter("purchasearray") == null? "0": request.getParameter("purchasearray").toString() ;
 System.out.println("purchasearray==="+purchasearray);

%>
<html>
<%--   <% 
  
String dtype=  session.getAttribute("Code").toString();
  System.out.println("sss    "+dtype);
  %>  --%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>GatewayERP(i)</title>
 <jsp:include page="../../../../includes.jsp"></jsp:include> 
 
 <%
	String contextPath=request.getContextPath();
 %>
 
<style>
form label.error {
color:red;
  font-weight:bold;

}
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
<script type="text/javascript">
<%-- var text1='<%=dtype%>'; --%>
var mod1='<%=mod%>';
var prcharray='<%=purchasearray%>';
 $(document).ready(function () {
	 
   	 $("#reqmasterdate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});   
   	 
  
  /*  	$('#brandsearchwndow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Brand Search',position: { x: 250, y: 60 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    $('#brandsearchwndow').jqxWindow('close'); */
/*     
 	 $('#brandsearchwndow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Brand Search' ,position: { x: 350, y: 60 }, keyboardCloseKey: 27});
     $('#brandsearchwndow').jqxWindow('close'); 

     $('#modelsearchwndow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Model Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
     $('#modelsearchwndow').jqxWindow('close');
     $('#colorsearchwndow').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Color Search' ,position: {x: 600, y: 60  }, keyboardCloseKey: 27});
     $('#colorsearchwndow').jqxWindow('close');
 */
     
 
 

 
     $('#sidesearchwndow').jqxWindow({ width: '55%', height: '95%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Product Search ' , position: { x: 600, y: 0 }, keyboardCloseKey: 27});
     $('#sidesearchwndow').jqxWindow('close');   
     $('#searchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
     $('#searchwindow').jqxWindow('close');
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
		
	});
 
 
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
          $.get(url).done(function (data) {
  //alert(data);
        $('#searchwindow').jqxWindow('setContent', data);

  	}); 
    	}
 
 
       
          function productSearchContent(url) {
          	 //alert(url);
          		 $.get(url).done(function (data) {
          			 
          			 $('#sidesearchwndow').jqxWindow('open');
          		$('#sidesearchwndow').jqxWindow('setContent', data);
          
          	}); 
          	} 
    
         
          
    function funReset(){
		//$('#frmpurReq')[0].reset(); 
	}
	function funReadOnly(){
		$('#frmpurReq input').attr('readonly', true );
		$('#frmpurReq textarea').attr('readonly', true );
		$('#frmpurReq select').attr('disabled', true);
		 $('#psearch').attr('disabled', true );
		 $('#setbtn').attr('disabled', true ); 
		$('#reqmasterdate').jqxDateTimeInput({ disabled: true});
		 
		$("#purchasedetails").jqxGrid({ disabled: true});
		
		 if(document.getElementById("status").value.trim()=="0" )
			{
			mod1="view";
			}
			if(mod1=="A")
				{
				
				 document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
				document.getElementById("formdetail").value=window.parent.formName.value;
				document.getElementById("formdetailcode").value=window.parent.formCode.value.trim(); 
				funCreateBtn();
				}
	
	}
	function funRemoveReadOnly(){
		 chkmultiqty();
		$('#frmpurReq input').attr('readonly', false );
		$('#frmpurReq textarea').attr('readonly', false );
		$('#frmpurReq select').attr('disabled', false);
	
		$('#reqmasterdate').jqxDateTimeInput({ disabled: false});
	 
		$("#purchasedetails").jqxGrid({ disabled: false});
		$('#docno').attr('readonly', true);
		if ($("#mode").val() == "A") {
			$('#reqmasterdate').val(new Date());

		  
			 $("#purchasedetails").jqxGrid('clear');
			    $("#purchasedetails").jqxGrid('addrow', null, {});
		   }
		
		
		 if(mod1=="A")
			{
		    	
		    	$("#vehpurcgasereq").load("purreqDetails.jsp?prcharray="+'<%=purchasearray.replaceAll("\\s","a@b@c")%>'+"&modebprf=a1");
		     	}
		
		 chkcostcode();
		 
		 $('#itemdocno').attr('readonly', true);
		 $('#itemname').attr('readonly', true);
		 
		  
		 
		 chkproductconfig();
			$('#psearch').attr('disabled', false );
			   $('#setbtn').attr('disabled', false );
		 
	}
	 
	
 
	
	
	
	function funNotify(){	
 
		
		
		
 		 var rows = $("#purchasedetails").jqxGrid('getrows');
		    $('#reqgridlenght').val(rows.length);
		   //alert($('#gridlength').val());
		   for(var i=0 ; i < rows.length ; i++){
		   // var myvar = rows[i].tarif; 
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "reqtest"+i)
		       .attr("name", "reqtest"+i)  
		    .attr("hidden", "true"); 
		    
		 
		    newTextBox.val(rows[i].psrno+"::"+rows[i].prodoc+" :: "+rows[i].unitdocno+" :: "+rows[i].qty+" :: "+rows[i].specid+" :: ");
		
		   newTextBox.appendTo('form');
		  
		    
		   }   
		
		return 1;
	} 

	function funChkButton() {
		
		frmpurReq.submit();
	}

	function funSearchLoad(){

		 changeContent('mainsearch.jsp?'); 
	}
   $(function(){
        $('#frmpurReq').validate({
                rules: { 
              
                
           
                	purdesc:{maxlength:100}
             
                 },
                 messages: {
                	 purdesc: {maxlength:" Max 100 chars"}
               
                
               
              
                 }
        });});
    
		 
	function funFocus(){
		 
	   	$('#reqmasterdate').jqxDateTimeInput('focus'); 	    		
	} 
	 
	function setValues() {
		if($('#hidreqmasterdate').val()){
			$("#reqmasterdate").jqxDateTimeInput('val', $('#hidreqmasterdate').val());
		}
		 
   	  var docVal1 = document.getElementById("masterdoc_no").value;
  	  
      	if(docVal1>0)
      		{
      	//	funchkforedit();
      	
      	
		 var indexVal2 = document.getElementById("masterdoc_no").value;
		 

     	  
         $("#vehpurcgasereq").load("purreqDetails.jsp?reqdoc="+indexVal2);
			funchkforedit(); 
      		}
      	if($('#msg').val()!=""){
 		   $.messager.alert('Message',$('#msg').val());
 		  }
	 
      	document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";   
      	//document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
		  
		
	}
	
    function funPrintBtn(){
  	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
  	  
  	   var url=document.URL;

         var reurl=url.split("savepurreqdata");
         
        // $("#docno").prop("disabled", false);                
         
   
  var brhid=<%=session.getAttribute("BRANCHID").toString()%>
        	 var dtype=$('#formdetailcode').val();
  
   var win= window.open(reurl[0]+"printPurchaseReq?docno="+document.getElementById("masterdoc_no").value+"&dtype="+dtype+"&brhid="+brhid,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");    
 win.focus();
  	   } 
  	  
  	   else {
 	    	      $.messager.alert('Message','Select a Document....!','warning');
 	    	      return false;
 	    	     }
 	    	
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
		x.open("GET", "reqlinkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value, true);
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
	 
     
     function chkcostcode()
     {
      
        var x=new XMLHttpRequest();
        x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200)
         {
           var items= x.responseText.trim();
          
           if(parseInt(items)>0)
            {
        	   
        	   document.getElementById("costcheck").value=1;
        	   
        	   $('#hcostcodes').show();
        	    
        	   
         	  
             }
               else
           { 
            	   document.getElementById("costcheck").value=0;
            	   $('#hcostcodes').hide();
           }
           
            }}
        x.open("GET","<%=contextPath%>/com/Procurement/Purchase/costcodesearch/checkcostcode.jsp?",true);
     	x.send();
      
           
             
     	
     } 
     
	 function cleardata()
	 {
		 document.getElementById("itemdocno").value="";
		 document.getElementById("itemname").value="";
	/* 	 document.getElementById("clientname").value="";
	 
		 document.getElementById("cldocno").value="";
		 document.getElementById("siteid").value="";
		 document.getElementById("site").value=""; */
		 
	 
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
		function setgrid()
		 {
			
			   
			 
			 var temppsrno=document.getElementById("temppsrno").value; 
			 var unit=document.getElementById("unit").value; 
			 
			 
	 
      	  
  		var rows1 = $("#purchasedetails").jqxGrid('getrows');
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
			  

				 
		     document.getElementById("jqxInput1").focus();
			 
		   return 0;
		   
		   
		   
		   }
	   else
		   {
		   document.getElementById("errormsg").innerText="";
		   }
	    
			
			
			
			 var rows = $('#purchasedetails').jqxGrid('getrows');
			  
		 	 
		     var rowlength= rows.length;
			 

		     
		  /*    if(document.getElementById("multi").checked)
			 {
		    	
		    	 
		    	 
		    	 
		    	 $('#purchasedetails').jqxGrid('setcellvalue', rowlength-1, "chkbox",true);
				 $('#purchasedetails').jqxGrid('setcellvalue',  rowlength-1, "batch_no",'');
				  $('#purchasedetails').jqxGrid('setcellvalue',  rowlength-1, "exp_date",'');
				  
				 
				  if(document.getElementById("colbatch").value=="")
					  {
					  document.getElementById("errormsg").innerText="Multi_Batch Details Is Required ";
		        		 
		        		return 0;
					  }
				  
				  
				  $('#purchasedetails').jqxGrid('setcellvalue',  rowlength-1, "colbatch", document.getElementById("colbatch").value);
				     
		    	 
		    	 
		     }
		     else
		    	 {
		    	 
		    	 
		    	 $('#purchasedetails').jqxGrid('setcellvalue', rowlength-1, "chkbox",false);
				 $('#purchasedetails').jqxGrid('setcellvalue',  rowlength-1, "batch_no", document.getElementById("batch").value);
				 
			 
				 if(parseInt(document.getElementById("expchk").value)==1)
					 {
					 
					  var  exp_date=document.getElementById("expdate").value;
					 
					 
					   if(exp_date=="" ||exp_date==null || typeof(exp_date)=="undefiend") 
		      	 	   {
							 document.getElementById("errormsg").innerText="Expiry Date Is Required ";
			        		 
				        		return 0;
		      	 	   }
		     		   
					 
			 
					 
					 
					 
					   $('#purchasedetails').jqxGrid('setcellvalue',  rowlength-1, "exp_date", $('#expdate').jqxDateTimeInput('getDate'));
					 }else
						 {
						 $('#purchasedetails').jqxGrid('setcellvalue',  rowlength-1, "exp_date", "1990.01.01");
						 }
				 
				 
				
				 
		    	 
		    	 } */
		     $('#purchasedetails').jqxGrid('setcellvalue',  rowlength-1, "proid", document.getElementById("jqxInput").value);
		     $('#purchasedetails').jqxGrid('setcellvalue',  rowlength-1, "proname", document.getElementById("jqxInput1").value);
		     $('#purchasedetails').jqxGrid('setcellvalue',  rowlength-1, "brandname", document.getElementById("brand").value);
		    // $('#purchasedetails').jqxGrid('setcellvalue',  rowlength-1, "foc", document.getElementById("focs").value);
		    
		     $('#purchasedetails').jqxGrid('setcellvalue',  rowlength-1, "unitdocno", document.getElementById("unit").value);
		     if(document.getElementById("unit").value>0)
		     {
		     $('#purchasedetails').jqxGrid('setcellvalue',  rowlength-1, "unit", $("#unit option:selected").text());
		     }
		     $('#purchasedetails').jqxGrid('setcellvalue',  rowlength-1, "psrno", document.getElementById("temppsrno").value);
		     $('#purchasedetails').jqxGrid('setcellvalue',  rowlength-1, "prodoc", document.getElementById("temppsrno").value);
		     $('#purchasedetails').jqxGrid('setcellvalue',  rowlength-1, "specid", document.getElementById("tempspecid").value);
		     $('#purchasedetails').jqxGrid('setcellvalue', rowlength-1, "productid" ,document.getElementById("jqxInput").value);
		     $('#purchasedetails').jqxGrid('setcellvalue',  rowlength-1, "productname", document.getElementById("jqxInput1").value);
		     $('#purchasedetails').jqxGrid('setcellvalue',  rowlength-1, "qty", document.getElementById("quantity").value);
		   /*  


		     
		     if(document.getElementById("multi").checked)
			 {
		    	
		    	 
		    	 
		    	 
		    	 $('#purchasedetails').jqxGrid('setcellvalue', rowlength-1, "chkbox",true);
				 $('#purchasedetails').jqxGrid('setcellvalue',  rowlength-1, "batch_no",'');
				  $('#purchasedetails').jqxGrid('setcellvalue',  rowlength-1, "exp_date",'');
				  
				 
				  if(document.getElementById("colbatch").value=="")
					  {
					  document.getElementById("errormsg").innerText="Multi_Batch Details Is Required ";
		        		 
		        		return 0;
					  }
				  
				  
				  $('#purchasedetails').jqxGrid('setcellvalue',  rowlength-1, "colbatch", document.getElementById("colbatch").value);
				     
		    	 
		    	 
		     }
		     else
		    	 {
		    	 
		    	 
		    	 $('#purchasedetails').jqxGrid('setcellvalue', rowlength-1, "chkbox",false);
				 $('#purchasedetails').jqxGrid('setcellvalue',  rowlength-1, "batch_no", document.getElementById("batch").value);
				 
			 
				 if(parseInt(document.getElementById("expchk").value)==1)
					 {
					 
					  var  exp_date=document.getElementById("expdate").value;
					 
					 
					   if(exp_date=="" ||exp_date==null || typeof(exp_date)=="undefiend") 
		      	 	   {
							 document.getElementById("errormsg").innerText="Expiry Date Is Required ";
			        		 
				        		return 0;
		      	 	   }
		     		   
					 
			 
					 
					 
					 
					   $('#purchasedetails').jqxGrid('setcellvalue',  rowlength-1, "exp_date", $('#expdate').jqxDateTimeInput('getDate'));
					 }else
						 {
						 $('#purchasedetails').jqxGrid('setcellvalue',  rowlength-1, "exp_date", "1990.01.01");
						 }
				 
				 
				
				 
		    	 
		    	 }
				  
				  */ 
				   document.getElementById("jqxInput").value ="";
				   document.getElementById("jqxInput1").value="";
				   document.getElementById("brand").value=""; 
		           document.getElementById("collqty").value ="";
				   document.getElementById("quantity").value ="";
				   document.getElementById("unit").value ="";
				  /*  document.getElementById("focs").value="";
			  	   document.getElementById("batch").value="";
				   document.getElementById("colbatch").value=""; */
				    document.getElementById("temppsrno").value="";
				     document.getElementById("tempspecid").value="";
				     
				      
				     /*  
				      
				      document.getElementById("multi").checked=false;
					 	 document.getElementById("batch").value="";
						 document.getElementById("colbatch").value="";
						 
						 
						  $('#batch').attr('readonly', false);
						 $('#expdate').jqxDateTimeInput({ disabled: false});
						 $('#expdate').val(null);
						  */
				      								
			 		 $("#purchasedetails").jqxGrid('addrow', null, {});
		    		 document.getElementById("jqxInput1").focus();
		 
		 }
		function calculatedata(val)
		 {

		 }
	 
	 
</script>
</head>
<body onload="setValues();chkcostcode();getitemtype();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmpurReq" action="savepurreqdata" autocomplete="OFF" >     

<jsp:include page="../../../../header.jsp"></jsp:include>
<jsp:include page="multiqty.jsp"></jsp:include><br/>
<br>
<fieldset>

<table width="100%" >                        
  <tr>
    <td width="4.5%" align="right">Date</td> 
    <td colspan="2"  width="6%"><div id='reqmasterdate' name='reqmasterdate' value='<s:property value="reqmasterdate"/>'></div> 
                     <input type="hidden" id="hidreqmasterdate" name="hidreqmasterdate" value='<s:property value="hidreqmasterdate"/>'/></td>
                     
                 <td width="20%" align="right">Ref No</td><td><input type="text" id="refno" name="refno" value='<s:property value="refno"/>'  /></td>
                 
                <td width="50%" align="right">&nbsp;<div id="hcostcodes" hidden="true"> Group&nbsp; <select  id="itemtype"  name="itemtype" style="width:15%;" onchange="cleardata()"> 
    <option>
     </option>   
                             
    </select> &nbsp;  &nbsp;
    Job No&nbsp;<input type="text" id="itemdocno" placeholder="Press F3 to Search"    name="itemdocno"  onkeydown="getitem(event);" value='<s:property value="itemdocno"/>' >
    
    <input type="text" id="itemname" name="itemname" style="width:43%;"   value='<s:property value="itemname"/>' > </div></td>
                 
                 
    <td width="5%" align="right">Doc No</td>
    <td width="33%"><input type="text" id="docno" name="docno" tabindex="-1" value='<s:property value="docno"/>'/></td>
  </tr>
  
   
</table>    
<table width="100%" >                                                                 
<tr>
  

 <td width="3%" align="right">Description</td>
    <td colspan="2"  width="70%">  <input type="text" id="purdesc" name="purdesc"  style="width:70%;" value='<s:property value="purdesc"/>'/></td>
     <td></td> <td></td>          
</tr>

</table>    
</fieldset>    
  
<br/>
 <fieldset id="psearch">
 
 <legend>Item Details</legend>
 
   <table width="100% "  >   
   <tr> 
   <td align="center">Product ID</td>
   <td align="center" colspan="2">Product Name</td>
   <td align="center" style="width:15%;"  >Brand</td>
   <td align="center">Unit</td>
   <td  width="6%" align="center">Qty</td>
  <!--  <td align="center" class="ff">FOC</td>
  <td align="center" class="ff1">Multi_Batch</td> 
   <td align="center" class="ff2">Batch</td>
      <td align="center" class="ff3">ExpDate</td>  --> 
    <td align="center">&nbsp;</td>  
   </tr>
 
   
    <tr><td align="center"><div id="part"><jsp:include page="part.jsp"></jsp:include></div> </td>
 <td colspan="2" align="center"> <div id="pnames"><jsp:include page="name.jsp"></jsp:include></div> </td> 
 <td align="center" >   <input type="text" id="brand"   > <input type="hidden" id="collqty"   ></td>
<td align="center"> <select    id="unit"   >   </select>      </td> 
 
<td width="6%" align="center"> <input type="hidden" id="loads" class="myButtons" value="Load Data" onclick="loaddatass()">  
  <input type="text" id="quantity"   onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1 (event);" style="text-align: left;" onchange="calculatedata(this.id);"  ></td>
<td align="center" class="ff"><input type="hidden" id="focs"  onblur="funRoundAmt(this.value,this.id);"  style="width:82%;" onkeypress="javascript:return isNumber1 (event);"     ></td>
 
 
   <td align="center" class="ff1"> 
   <input type="hidden" id="multi" style="text-align: right;" onchange="chkmultis()" > </td>
 
   <td align="center" class="ff2"> 
   <input type="hidden" id="batch"    onkeydown="getbatch(event)" > </td>
<td  class="ff3"><div id="expdate" hidden:"true" name="expdate" value='<s:property value="expdate"/>'></div> </td> 
 
  <td align="center">
     <input type="hidden" id="cleardata">
 &nbsp; <input type="button" id="setbtn"  class="btn" onclick="setgrid()" value="ADD" ></td>

 </tr>
 
   
   </table> 
   </fieldset> 
<fieldset>
<div id="vehpurcgasereq">  <jsp:include page="purreqDetails.jsp"></jsp:include></div>
 </fieldset>
 
 
  
 <input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>' /> 
 
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />

  <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
 
 <input type="hidden" name="reqgridlenght" id="reqgridlenght" value='<s:property value="reqgridlenght"/>' />   
 
 
  <input type="text" name="gridtext" id="gridtext"  style="width:0%;height:0%;"  class="textbox" value='<s:property value="gridtext"/>'  />   
  
    <input type="text" name="gridtext1" id="gridtext1"  style="width:0%;height:0%;"  class="textbox" value='<s:property value="gridtext1"/>' />   
    
 
 
 <input type="hidden" id="costtr_no" name="costtr_no"  value='<s:property value="costtr_no"/>'/> 
 <input type="hidden" id="costcheck" name="costcheck"  value='<s:property value="costcheck"/>'/> 
 <input type="hidden" id="hideitemtype" name="hideitemtype"  value='<s:property value="hideitemtype"/>'/> 
 <input type="hidden" id="hidetype" name="hidetype"  value='<s:property value="hidetype"/>'/>
 <input type="hidden" id="productchk" name="productchk"  value='<s:property value="productchk"/>' />
   <input type="hidden" id="temppsrno" >  
        <input type="hidden" id="tempspecid" > 
        <input type="hidden" id="tempunitdocno" > 

</form>

	 <div id="sidesearchwndow">
	   <div ></div>
	</div>
 <div id="searchwindow">
   <div ></div>
</div>
<!-- <div id="colorsearchwndow">
   <div ></div>
</div>
<div id="modelsearchwndow">
   <div ></div>
</div>
<div id="brandsearchwndow">
   <div ></div>
</div> -->

</div>
</body>
</html>