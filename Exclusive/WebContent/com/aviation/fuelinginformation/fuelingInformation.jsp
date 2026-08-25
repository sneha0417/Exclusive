<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
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
 <jsp:include page="../../../includes.jsp"></jsp:include> 
<style>
form label.error {
color:red;
  font-weight:bold;

}
</style>
<script type="text/javascript">
<%-- var text1='<%=dtype%>'; --%>
 $(document).ready(function () {
	 
   	 $("#FuelInfoDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});    
   	  $('#clientsearch1').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
     $('#clientsearch1').jqxWindow('close');
     $('#productsearch1').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Product Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
     $('#productsearch1').jqxWindow('close');
     $('#unitsearch1').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Unit Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
     $('#unitsearch1').jqxWindow('close');
     $('#portsearch1').jqxWindow({ width: '30%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Port Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
     $('#portsearch1').jqxWindow('close');
     
    $('#cmbclient').dblclick(function(){
	  	   
	   
	       clientSearchContent('clientINgridsearch.jsp?dtype=CRM', $('#clientsearch1')); 
       });
     
    $('#vendor').dblclick(function(){
	  	   
 	   
	       clientSearchContent('clientINgridsearch.jsp?dtype=VND', $('#clientsearch1')); 
    });
    
    
   $('#FuelInfoDate').on('change', function (event) {
       var maindate = $('#FuelInfoDate').jqxDateTimeInput('getDate');
 	 	 if ($("#mode").val() == "A" || $('#mode').val()=="E" ) {   
    funDateInPeriod(maindate);
   	 }
  });
   
   
   
	  
   
 		
    
		
		  
		/* $('#txtdescription').keydown(function (evt) {
		     if (evt.keyCode==9) {
		             event.preventDefault();
		             $('#jqxJournalVoucher').jqxGrid('selectcell',0, 'type');
		             $('#jqxJournalVoucher').jqxGrid('focus',0, 'type');
		     }
		   });
		 */
	});
          
    
	       function text()
	       {
	    	   var url=document.URL;
	      
			var reurl=url.split("com/");
	       top.addTab("Client",reurl[0]+"com/operations/clientrelations/client/clientMaster.jsp");
	     
	       }
    function funReset(){
		//$('#frmFuelInfo')[0].reset(); 
	}
	function funReadOnly(){
		$('#frmFuelInfo input').prop('readonly', true );
		
		$('#frmFuelInfo textarea').attr('readonly', true );
		$('#frmFuelInfo select').attr('disabled', true);
	 
		 
		$('#FuelInfoDate').jqxDateTimeInput({ disabled: true});
	    $("#jqxFuelInfo").jqxGrid({ disabled: true});
		
	   
	
	}
	function funRemoveReadOnly(){
		
		$('#frmFuelInfo input').attr('readonly', true );
		
		$('#cmbclient').attr('readonly', true );
		$('#vendor').attr('readonly', true );
		$('#txtnotes').attr('readonly', false );
		
		
		$('#frmFuelInfo textarea').attr('readonly', false );
		$('#frmFuelInfo select').attr('disabled', false);
		 
		$('#FuelInfoDate').jqxDateTimeInput({ disabled: false});
	
		$("#jqxFuelInfo").jqxGrid({ disabled: false});
		$('#docno').attr('readonly', true);
		if ($("#mode").val() == "A") {
			
			 $('#FuelInfoDate').val(new Date());
		     $("#jqxFuelInfo").jqxGrid('clear');
		    $("#jqxFuelInfo").jqxGrid('addrow', null, {"invoiced":"0","delstat":"0"});
		   }
		
		if ($("#mode").val() == "E") {
			
		    $("#jqxFuelInfo").jqxGrid('addrow', null, {"invoiced":"0","delstat":"0"});
		   }
	
		
		
		
	}

	 function getclinfo(event){
    	 var x= event.keyCode;
    	 if(x==114){
    	  
    
    	 clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1'));    }
    	 else{
    		 }
    	 } 
	       function clientSearchContent(url) {
	    	   $('#clientsearch1').jqxWindow('open');
	                 $.get(url).done(function (data) {
        
		           $('#clientsearch1').jqxWindow('setContent', data);

          	}); 
	           	} 
	       function portSearchContent(url) {
	        	// alert(url);
	        		 $.get(url).done(function (data) {
	        			 
	        			 $('#portsearch1').jqxWindow('open');
	        		$('#portsearch1').jqxWindow('setContent', data);
	        
	        	}); 
	        	} 
	       
	       function productSearchContent(url) {
	        	 //alert(url);
	        		 $.get(url).done(function (data) {
	        			 
	        			 $('#productsearch1').jqxWindow('open');
	        		$('#productsearch1').jqxWindow('setContent', data);
	        
	        	}); 
	        	} 
	       function unitSearchContent(url) {
	        	 //alert(url);
	        		 $.get(url).done(function (data) {
	        			 
	        			 $('#unitsearch1').jqxWindow('open');
	        		$('#unitsearch1').jqxWindow('setContent', data);
	        
	        	}); 
	        	} 
	       function getvendorinfo(event){
	      	 var x= event.keyCode;
	      	 if(x==114){
	      	  
	      
	      	 vendorSearchContent('clientINgridsearch.jsp?', $('#clientsearch1'));    
	      	 }
	      	 else{
	      		 }
	      	 } 
	       
	function funNotify(){	
		
		$('#FuelInfoDate').jqxDateTimeInput({ disabled: false});
		
		/* 
		
		  var maindate = $('#FuelInfoDate').jqxDateTimeInput('getDate');
		   var validdate=funDateInPeriod(maindate);
		   if(validdate==0){
		   return 0; 
		   }
 */		 

		
		 		 var rows = $("#jqxFuelInfo").jqxGrid('getrows');
		 
		 	
		 
		 
		/*  
		 
			 var rows = $("#jqxFuelInfo").jqxGrid('getrows');
		    $('#enqgridlenght').val(rows.length);
		  
		   for(var i=0 ; i < rows.length ; i++){
		
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "enqtest"+i)
		       .attr("name", "enqtest"+i)
		       .attr("hidden", "true"); 
		 
		   newTextBox.val(rows[i].sr_no+"::"+rows[i].brdid+" :: "+rows[i].modid+" :: "
				   +rows[i].specification+" :: "+rows[i].clrid+" :: "+rows[i].ldur+" :: "+rows[i].hidfromdate+" :: "+rows[i].kmusage+" :: "+rows[i].qty+" :: ");
		
		   newTextBox.appendTo('form'); 
		   }
		   */
		  
		    
		   
		
		return 1;
	} 
	$(function(){
        $('#frmFuelInfo').validate({
                rules: { 
              
                	delterms:{maxlength:200},
                	purdesc:{maxlength:200},
                	payterms:{maxlength:200},
                	/* refno:{required:true}, */
                	cmbclient:{required:true}
                 },
                 messages: {
                	 delterms: {maxlength:"  Max 200 chars"},
                	 purdesc: {maxlength:"  Max 200 chars"},
                	 payterms: {maxlength:"  Max 200 chars"},
               /*  	 refno: {required:" * required"}, */
                	 cmbclient: {required:" *"}
                 }
        });});
	function funNotify(){	
		 
		
		 var purid= document.getElementById("cmbclient").value;
		if(purid=="")
		 	{
		 	 document.getElementById("errormsg").innerText=" Client Required";
		 	 
		 	 document.getElementById("cmbclient").focus();
		 	 return 0;
		 	   }
		 else
		 	   {
		 	   document.getElementById("errormsg").innerText="";
		 	   }
		 var valid2=document.getElementById("txtclientname").value;
		 	
			if(valid2=="")
				{
				document.getElementById("errormsg").innerText=" Select Client";
				return 0;
				}
			else{
				 document.getElementById("errormsg").innerText="";
			}
			 var purid1= document.getElementById("vendor").value;
			 
			if(purid1=="")
		 	{
		 	 document.getElementById("errormsg").innerText=" Vendor Required";
		 	 
		 	 document.getElementById("vendor").focus();
		 	 return 0;
		 	   }
		 else
		 	   {
		 	   document.getElementById("errormsg").innerText="";
		 	   }
			var valid3=document.getElementById("txtvendorname").value;
			
			if(valid3=="")
			{
			document.getElementById("errormsg").innerText=" Select Vendor";
			return 0;
			}
		else{
			 document.getElementById("errormsg").innerText="";
		}
			
		 var rows = $("#jqxFuelInfo").jqxGrid('getrows');
		   var length=0;
		   //alert($('#gridlength').val());
		   for(var i=0 ; i < rows.length ; i++){
		   // var myvar = rows[i].tarif; 
		    var chks=rows[i].date;
		    var chk=rows[i].port;
		   if((typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != "") || typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
		  
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "enqtest"+i)
		       .attr("name", "enqtest"+i)  
		       .attr("hidden", "true"); 
				length=length+1;
		    
		    //alert(typeof(chk));
		    if(typeof(chk) == "undefined" || typeof(chk) == "NaN" || chk == ""){
		    	document.getElementById("errormsg").innerText=" Select Port";
		    	
				return 0;
		    }
		    else{
				 document.getElementById("errormsg").innerText="";
			}
		    var date = $('#jqxFuelInfo').jqxGrid('getcelltext',i, "date");
		    var eta = $('#jqxFuelInfo').jqxGrid('getcelltext',i, "eta");
		    var etd = $('#jqxFuelInfo').jqxGrid('getcelltext',i, "etd");
		    newTextBox.val(date+" :: "+rows[i].portid+" :: "+rows[i].productid+" :: "+rows[i].ac_type+" :: "+rows[i].aircraftno+" :: "+rows[i].flightno+" :: "+rows[i].unitid+" :: "+rows[i].qty+" :: "+rows[i].operator+" :: "+eta+" :: "+etd+" :: "+rows[i].timezone+" :: "+rows[i].remarks+" :: "+rows[i].parking+" :: "+rows[i].invoiced+" :: "+rows[i].delstat+" :: ");

		
		   newTextBox.appendTo('form');
		  
		   }
		   
		   }
		   $('#enqgridlenght').val(length);
		   
		
		return 1;
	} 
	
	function funChkButton() {
		
		//frmFuelInfo.submit();
	}

 	function funSearchLoad(){
 		 changeContent('Mastersearch.jsp'); 
 	}
 
		
	function funFocus(){
		 
	   /* 	$('#FuelInfoDate').jqxDateTimeInput('focus');  */
	   
	   

		//document.getElementById("r1").focus();
	   
	   
	}
	function reqdata()
	{
 	     
    }
	
	
	function chkChange()
    {
	 
    
	    
    } 
	
	
	 function disfields()
	 { 
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
	function setValues() {
		 /*  document.getElementById("formdetail").value="Lease Price Request";
	   		document.getElementById("formdetailcode").value="LPR";   */
		if($('#hidFuelInfoDate').val()){
			$("#FuelInfoDate").jqxDateTimeInput('val', $('#hidFuelInfoDate').val());
		}
	   		
		  
  	  var docVal1 = document.getElementById("masterdoc_no").value;
  	
      	if(docVal1>0)
      		{
      		funchkforedit();
		 var indexVal2 = document.getElementById("masterdoc_no").value;
     	  
         $("#enqdiv").load("fuelingInformationGrid.jsp?enqrdocno="+indexVal2);
      		}
      	if($('#msg').val()!=""){
 		   $.messager.alert('Message',$('#msg').val());
 		  }
	
      	
      	 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";	
      	 
     	chkChange();
	}
	function funPrintBtn(){
        var url=document.URL;
        var reurl=url.split("fuelinformation");
       
    var brhid=<%=session.getAttribute("BRANCHID").toString()%>
         var dtype=$('#formdetailcode').val();
         
         //alert(reurl[0]);
              
              var win= window.open(reurl[0]+"fuelinformationprint?docno="+document.getElementById("masterdoc_no").value+"&dtype="+dtype+"&brhid="+brhid,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");    
           win.focus();
	}
   
</script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmFuelInfo" action="fuelinformation" autocomplete="OFF" >

 <jsp:include page="../../../header.jsp"></jsp:include><br/>
 <fieldset>
       
<table width="100%" >                        
  <tr>
    <td width="6%" align="right">Date</td>
    <td colspan="2"><div id='FuelInfoDate' name='FuelInfoDate' value='<s:property value="FuelInfoDate"/>'></div>
                     <input type="hidden" id="hidFuelInfoDate" name="hidFuelInfoDate" value='<s:property value="hidFuelInfoDate"/>'/></td>
   <%--  <td width="32%" align="right">User Name</td>
    <td width="33%"><input type="text" id="enquserName" name="enquserName" tabindex="-1" value="<%=session.getAttribute("USERNAME")%>"/></td> --%>
    <td width="30%" align="right">Doc No</td>
    <td width="23%"><input type="text" id="docno" name="docno" tabindex="-1" value='<s:property value="docno"/>' onfoucs="disfields();"/></td>
  
  </tr>
       
  <tr>
    <td align="right">Client</td>     
    <td><input type="text" id="cmbclient" name="cmbclient" style="width: 20%;" placeholder="Press F3 To Search" value='<s:property value="cmbclient"/>' onKeyDown="getclinfo(event);" >
		
		<input type="text" id="txtclientname" name="txtclientname" style="width: 50%;" value='<s:property value="txtclientname"/>' onfocus="reqdata();disfields();"></td>
     
   
     
  </tr>
   <tr>
    <td align="right">Vendor</td>     
    <td colspan="3"><input type="text" id="vendor" name="vendor" placeholder="Press F3 To Search" value='<s:property value="vendor"/>' onKeyDown="getvendorinfo(event);" >
	<input type="text" id="txtvendorname" name="txtvendorname" style="width: 27%;" value='<s:property value="txtvendorname"/>' onfocus="reqdata();disfields();"></td>
  </tr>
  
  <tr>
    <td align="right">Notes</td>     
    <td colspan="3"><input type="text" id="txtnotes" name="txtnotes" style="width: 41%;" value='<s:property value="txtnotes"/>'></td>
  </tr>
 </table>
 
</fieldset>           
<br/>
<fieldset>
<div id="enqdiv">
<jsp:include page="fuelingInformationGrid.jsp"></jsp:include></div>
</fieldset>

<input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>' />
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />

<input type="hidden" name="enqdtype" id="enqdtype" value='<s:property value="enqdtype"/>' />

<input type="hidden" id="enqgridlenght" name="enqgridlenght" />

<input type="hidden" name="gridval" id="gridval" value='<s:property value="gridval"/>' />  

<input type="hidden" name="forradiochk" id="forradiochk" value='<s:property value="forradiochk"/>' />  
<input type="hidden" name="modeval" id="modeval" value='<s:property value="modeval"/>' />  


<input type="hidden" name="fromdatesval" id="fromdatesval" value='<s:property value="fromdatesval"/>' />  
<input type="hidden" name="todateval" id="todateval" value='<s:property value="todateval"/>' />  



<input type="hidden" name="txtradio" id="txtradio" value='<s:property value="txtradio"/>' /> 

  <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>


</form>

<div id="portsearch1">
   <div ></div>
</div>
<div id="unitsearch1">
   <div ></div>
</div>
<div id="clientsearch1">
   <div ></div>
</div>
<div id="productsearch1">
   <div ></div>
</div>
</div>
</body>
</html>