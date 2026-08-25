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
	 
   	 $("#EnquiryDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});    
   	 $('#modesearchwndow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Mode Search' ,position: { x: 200, y: 120 }, keyboardCloseKey: 27});
     $('#modesearchwndow').jqxWindow('close'); 
     $('#clientsearch1').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
     $('#clientsearch1').jqxWindow('close');
     $('#submodesearchwndow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Submode Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
     $('#submodesearchwndow').jqxWindow('close');
     $('#termsearchwndow').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Term Search' ,position: { x: 500, y: 120 }, keyboardCloseKey: 27});
     $('#termsearchwndow').jqxWindow('close');
     $('#shipmentsearchwndow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Shipment Search' ,position: { x: 200, y: 120 }, keyboardCloseKey: 27});
     $('#shipmentsearchwndow').jqxWindow('close'); 
     
    $('#cmbclient').dblclick(function(){
	  	   
	   
	       clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1')); 
       });
 
   $('#EnquiryDate').on('change', function (event) {
       var maindate = $('#EnquiryDate').jqxDateTimeInput('getDate');
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
          function modeinfoSearchContent(url) {
      	 //alert(url);
      		 $.get(url).done(function (data) {
      			 
      			 $('#modesearchwndow').jqxWindow('open');
      		$('#modesearchwndow').jqxWindow('setContent', data);
      
      	}); 
      	} 
          function shipmentinfoSearchContent(url) {
           	 //alert(url);
           		 $.get(url).done(function (data) {
           			 
           			 $('#shipmentsearchwndow').jqxWindow('open');
           		$('#shipmentsearchwndow').jqxWindow('setContent', data);
           
           	}); 
           	} 
          function submodeinfoSearchContent(url) {
           	 //alert(url);
           		 $.get(url).done(function (data) {
           			 
           			 $('#submodesearchwndow').jqxWindow('open');
           		$('#submodesearchwndow').jqxWindow('setContent', data);
           
           	}); 
           	} 
          function terminfoSearchContent(url) {
            	 //alert(url);
            		 $.get(url).done(function (data) {
            			 
            			 $('#termsearchwndow').jqxWindow('open');
            		$('#termsearchwndow').jqxWindow('setContent', data);
            
            	}); 
            	} 
    
	       function text()
	       {
	    	   var url=document.URL;
	      
			var reurl=url.split("com/");
	       top.addTab("Client",reurl[0]+"com/operations/clientrelations/client/clientMaster.jsp");
	     
	       }
    function funReset(){
		//$('#frmEnquiry')[0].reset(); 
	}
	function funReadOnly(){
		$('#frmEnquiry input').prop('readonly', true );
		
		$('#frmEnquiry textarea').attr('readonly', true );
		$('#frmEnquiry select').attr('disabled', true);
	 
		 
		$('#EnquiryDate').jqxDateTimeInput({ disabled: true});
	    $("#jqxEnquiry").jqxGrid({ disabled: true});
		
	   
	
	}
	function funRemoveReadOnly(){
		
		$('#frmEnquiry input').attr('readonly', true );
		
		$('#cmbclient').attr('readonly', true );
		
		$('#txtRemarks').attr('readonly', false );
		
		
		$('#frmEnquiry textarea').attr('readonly', false );
		$('#frmEnquiry select').attr('disabled', false);
		 
		$('#EnquiryDate').jqxDateTimeInput({ disabled: false});
	
		$("#jqxEnquiry").jqxGrid({ disabled: false});
		$('#docno').attr('readonly', true);
		if ($("#mode").val() == "A") {
			
			 $('#EnquiryDate').val(new Date());
		     $("#jqxEnquiry").jqxGrid('clear');
		    $("#jqxEnquiry").jqxGrid('addrow', null, {});
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
	       
	       
	function funNotify1(){	
		
		$('#EnquiryDate').jqxDateTimeInput({ disabled: false});
		
		/* 
		
		  var maindate = $('#EnquiryDate').jqxDateTimeInput('getDate');
		   var validdate=funDateInPeriod(maindate);
		   if(validdate==0){
		   return 0; 
		   }
 */		 

		
		 		 var rows = $("#jqxEnquiry").jqxGrid('getrows');
		 
		 	
		 
		 
		/*  
		 
			 var rows = $("#jqxEnquiry").jqxGrid('getrows');
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
        $('#frmEnquiry').validate({
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
		
		
		
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();	
				if(parseInt(items)>0)
					{
					
	 
					 $.messager.alert('Message', 'Not Possible To Update');
					 return 0;
					 
					}
				else
					{
					funSaveData();
					 
					}
			  
				
				
				
			} else {
			}
		}
		x.open("GET", "linkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value, true);
		x.send(); 
	}
	
	
	
	
	
	function funSaveData(){	
		 
		
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
			
		 var rows = $("#jqxEnquiry").jqxGrid('getrows');
		    $('#enqgridlenght').val(rows.length);
		   //alert($('#gridlength').val());
		   for(var i=0 ; i < rows.length ; i++){
		   // var myvar = rows[i].tarif; 
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "enqtest"+i)
		       .attr("name", "enqtest"+i)  
		    .attr("hidden", "true"); 
		    
		 
		    newTextBox.val(rows[i].modeid+" :: "+rows[i].smodeid+" :: "+rows[i].shipmentid+" :: "+rows[i].termid+" :: "+rows[i].orgin+" :: "+rows[i].pol+" :: "+rows[i].pod+" :: "+rows[i].comodity+" :: "+rows[i].weight+" :: "+rows[i].noofpacks+" :: "+rows[i].dimension+" :: "+rows[i].volume+" :: "+rows[i].remarks+" :: "+rows[i].qty+" :: ");
		
		   newTextBox.appendTo('form');
		  
		   
		   
		   }
		   
		   
		
		   $("#frmEnquiry").submit();
	} 
	
	function funChkButton() {
		
		//frmEnquiry.submit();
	}

	function funSearchLoad(){
		 changeContent('lprMastersearch.jsp'); 
	}
 
		
	function funFocus(){
		 
	   /* 	$('#EnquiryDate').jqxDateTimeInput('focus');  */
	   
	   

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
		if($('#hidEnquiryDate').val()){
			$("#EnquiryDate").jqxDateTimeInput('val', $('#hidEnquiryDate').val());
		}
	   		
		  
  	  var docVal1 = document.getElementById("masterdoc_no").value;
  	
      	if(docVal1>0)
      		{
      		funchkforedit();
		 var indexVal2 = document.getElementById("masterdoc_no").value;
     	  
         $("#enqdiv").load("reqDetails.jsp?enqrdocno="+indexVal2);
      		}
      	if($('#msg').val()!=""){
 		   $.messager.alert('Message',$('#msg').val());
 		  }
	
      	
      	 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";	
      	 
     	chkChange();
	}
	 
    function funPrintBtn(){
 	/*    if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
 	  
 	   var url=document.URL;

        var reurl=url.split("saveLeasepricereq");
        
        $("#docno").prop("disabled", false);                
        
  
var win= window.open(reurl[0]+"printLeasepricereq?docno="+document.getElementById("masterdoc_no").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
     
win.focus();
 	   } 
 	  
 	   else {
	    	      $.messager.alert('Message','Select a Document....!','warning');
	    	      return false;
	    	    }
	    	 */
 	}
</script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmEnquiry" action="cargoenquiry" autocomplete="OFF" >

 <jsp:include page="../../../header.jsp"></jsp:include><br/>
 <fieldset>
         <!-- EnquiryDate, docno,cmbclientb,txtclientname,txtaddress -->
<table width="100%" >                        
  <tr>
    <td width="11%" align="right">Date</td>
    <td colspan="2"><div id='EnquiryDate' name='EnquiryDate' value='<s:property value="EnquiryDate"/>'></div>
                     <input type="hidden" id="hidEnquiryDate" name="hidEnquiryDate" value='<s:property value="hidEnquiryDate"/>'/></td>
   <%--  <td width="32%" align="right">User Name</td>
    <td width="33%"><input type="text" id="enquserName" name="enquserName" tabindex="-1" value="<%=session.getAttribute("USERNAME")%>"/></td> --%>
    <td width="32%" align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      Doc No</td>
    <td width="33%"><input type="text" id="docno" name="docno" tabindex="-1" value='<s:property value="docno"/>' onfoucs="disfields();"/></td>
  </tr>
       
  <tr>
    <td align="right">Client</td>     
    <td colspan="3"><input type="text" id="cmbclient" name="cmbclient" placeholder="Press F3 To Search" value='<s:property value="cmbclient"/>' onKeyDown="getclinfo(event);" >
		
		<input type="text" id="txtclientname" name="txtclientname" style="width: 40%;" value='<s:property value="txtclientname"/>' onfocus="reqdata();disfields();"></td>
    
  </tr>
 
 </table>
  <table width="100%" >
   <tr>
    <td width="10.8%" align="right">Address</td>
    <td><input type="text" id="txtaddress" name="txtaddress" style="width:70%;" value='<s:property value="txtaddress"/>' onfocus="reqdata();disfields();"></td>


  </tr>
  </table>
  <table  width="100%">
  <tr>
    <td align="right" width="10.8%">MOB</td>
    <td width="33.2%" ><input type="text" id="txtmobile" name="txtmobile" style="width:68.7%;" value='<s:property value="txtmobile"/>' onfocus="reqdata();disfields();"></td>
    <td align="right" width="3%" >Email</td>
    <td > <input type="email" id="txtemail" name="txtemail" style="width: 49.2%;" value='<s:property value="txtemail"/>' onfocus="reqdata();disfields();"></td>
  </tr>
  </table>
  <table  width="100%">
  <tr>
  <td align="right" width="10.8%">Remarks</td> 
    <td colspan="3">
    <input type="text" id="txtRemarks" name="txtRemarks" style="width:69.9%;" value='<s:property value="txtRemarks"/>'onfocus="reqdata();disfields();"></td>

  </tr>
</table>  
</fieldset>           
<br/>
<fieldset>
<div id="enqdiv">
<jsp:include page="reqDetails.jsp"></jsp:include></div>
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

<div id="shipmentsearchwndow">
   <div ></div>
</div>
<div id="termsearchwndow">
   <div ></div>
</div>
<div id="submodesearchwndow">
   <div ></div>
</div>
<div id="modesearchwndow">
   <div ></div>
</div>
<div id="clientsearch1">
   <div ></div>
</div>
</div>
</body>
</html>