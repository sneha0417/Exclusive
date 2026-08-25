<%@ taglib prefix="s" uri="/struts-tags" %>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<style>
form label.error {
color:red;
  font-weight:bold;

}
.hidden-scrollbar {
    overflow: auto;
    height: 550px;
}
</style>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript">

$(document).ready(function() {

	  $("#date").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });
	  $("#invdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});
	
	  
	  $('#contractwindow').jqxWindow({ width: '60%', height: '50%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Contract Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	  $('#contractwindow').jqxWindow('close');
	  
	  $("body").prepend('<div id="overlay1" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	  $("body").prepend("<div id='PleaseWait1' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     
		 /*  $('#clientsearch1').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
		  $('#clientsearch1').jqxWindow('close'); */
		//  $('#invdate').jqxDateTimeInput('setDate', "");
		    
		  $('#invdate').on('change', function (event) {
				
			   var invdate=new Date($('#invdate').jqxDateTimeInput('getDate'));
			   var curdate=new Date(); 
			   invdate.setHours(0,0,0,0);
			   curdate.setHours(0,0,0,0);
			   if(invdate>curdate){
				   
				   $.messager.alert('Message','Future Date Not Allowed','warning');   
				   $('#invdate').jqxDateTimeInput('setDate', new Date());
				 
			   return false;
			  }   
		 });
		 
	 
	  $('#txtrefdetails').dblclick(function(){
		  var cmb=document.getElementById("cmbcontracttype").value;
		  if(cmb=="")
		 	{
		 	 document.getElementById("errormsg").innerText=" Select Contract Type";
		 	return 0;
		 	}
		  else
			  {
			  document.getElementById("errormsg").innerText="";
			  }
		  	
		  $('#contractwindow').jqxWindow('open');
	 		 contractSearchContent('contractMastersearch.jsp?', $('#contractwindow'));
		  	
	     });
	  
	/*   $('#txtclient').dblclick(function(){
		   
	    	 $('#clientsearch1').jqxWindow('open');
	    	 clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1')); 
			   		
			 }); */
	  	  
});




function getcontract(event){
 var cmb=document.getElementById("cmbcontracttype").value;
 if(cmb=="")
	{
	 document.getElementById("errormsg").innerText=" Select Contract Type";
	return 0;
	}
 else
 {
 document.getElementById("errormsg").innerText="";
 }
	var x= event.keyCode;
 	 if(x==114){
 		
 		// changeContent('contractMastersearch.jsp');  
 		
 			$('#contractwindow').jqxWindow('open');
 	 		 contractSearchContent('contractMastersearch.jsp?', $('#contractwindow'));
 		
    	 }
 	 else{
 		 
 		 }
 	 }
    	 
function contractSearchContent(url) {
	 $.get(url).done(function (data) {
	$('#contractwindow').jqxWindow('setContent', data);
           	}); 
 	}


/* function getclinfo(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#clientsearch1').jqxWindow('open');
	 clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1'));    }
	 else{
		 }
	 } 
    function clientSearchContent(url) {
          
              $.get(url).done(function (data) {
 
	           $('#clientsearch1').jqxWindow('setContent', data);

   	}); 
        	}
 */

function funFocus()
{
	//document.getElementById("txtcontract").focus();
		
}


function funReadOnly(){
	
	 $('#fromcompletioncertificate input').attr('readonly', true);
	 $('#fromcompletioncertificate input').attr('disabled', true);
	 $('#fromcompletioncertificate select').attr('disabled', true);
	 $('#txtcontract').attr('readonly', true);
	 
	 $('#pytval').attr('readonly', true);
	 $('#totinvoice').attr('readonly', true);
	 $('#tobeinvoice').attr('readonly', true);
	 $('#retnamount').attr('readonly', true);  
	 $('#contrval').attr('readonly', true); 
	 $('#invdesc').attr('disabled', true);
		$('#btninv').attr('disabled', true);
	  
		 $('#invdate').jqxDateTimeInput({ disabled: true});
	 
	 $('#txtrefdetails').attr('readonly', true);
	 $('#date').jqxDateTimeInput({ disabled: true});
	
	 $('#docno').attr('readonly', true);
	 $("#serviceGrid").jqxGrid({ disabled: true});
	
}

function funRemoveReadOnly(){
	
	 $('#fromcompletioncertificate input').attr('readonly', false);
	 $('#fromcompletioncertificate input').attr('disabled', false);
	 $('#fromcompletioncertificate select').attr('disabled', false);
	 $('#txtcontract').attr('readonly', true);
	 $('#txtrefdetails').attr('readonly', true);
	 $('#txtclient').attr('readonly', true);
	 $('#txtclientdet').attr('readonly', true);
	 $('#pytval').attr('readonly', true);
	 $('#totinvoice').attr('readonly', true);
	 $('#tobeinvoice').attr('readonly', true);
	 $('#retnamount').attr('readonly', true);
	 $('#contrval').attr('readonly', true); 
	 
	 $('#invdesc').attr('disabled', true);
		$('#btninv').attr('disabled', true);
	  
		 $('#invdate').jqxDateTimeInput({ disabled: true});
	 $('#docno').attr('readonly', true);
	 $('#date').jqxDateTimeInput({ disabled: false});
	
	 $("#serviceGrid").jqxGrid({ disabled: false});
	 if ($("#mode").val() == "A") {
		 
		 $("#txtlegalamt").val(0.0);
		 $("#txtseramt").val(0.0);
		 $("#txtexptotal").val(0.0);
		 $("#txtnettotal").val(0.0);
		 
		
	    $("#serviceGrid").jqxGrid('clear');
	    $("#serviceGrid").jqxGrid('addrow', null, {});
	   }
if ($("#mode").val() == "E") {
		
		 $("#serviceGrid").jqxGrid({ disabled: true});
	 }

	
}




function funNotify(){
	var contrno=document.getElementById("txtcontract").value;
	var certifyper=document.getElementById("certifyper").value;
	if(contrno=="")
		{
		 document.getElementById("errormsg").innerText=" Select Contract No.";
		return 0;
		}
	if(certifyper=="" || certifyper=="undefined" || certifyper==null || certifyper=="0")
	{
	 document.getElementById("errormsg").innerText=" Certified Percentage Is Mandatory";
	return 0;
	}
	if(certifyper<=0 || certifyper>100)
	{
	 document.getElementById("errormsg").innerText=" Certified Percentage Must Be Between 1 to 100";
	return 0;
	}
	  var rows = $("#serviceGrid").jqxGrid('getrows');
	 
	    $('#invgridlength').val(rows.length);

	  for(var i=0 ; i < rows.length ; i++){
			
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "inv"+i)
		       .attr("name", "inv"+i)
		       .attr("hidden", "true"); 
		 
		   newTextBox.val(rows[i].amount+"::"+rows[i].lfee+" :: ");
	
		   newTextBox.appendTo('form');
		  
		    
		   }
	  
	 
		return 1;
} 



function setValues() {
	  
  var docVal1 = document.getElementById("maintrno").value.trim();
  
  
  
 
  
	if(docVal1>0)
		{
		 if(document.getElementById("hidestedit").value=="1"){
			    $('#btnEdit').attr('disabled', true );
			    $('#btninv').attr('disabled', true);
			    document.getElementById("btninv").innerText="CALCULATE";
		} else {
			    $('#btnEdit').attr('disabled', false );
			    $('#btninv').attr('disabled', false);
				document.getElementById("btninv").innerText="CALCULATE";
		}
		var ctrno=document.getElementById("txtcontract").value;
     	$("#serdiv").load("serviceGrid.jsp?ctrno="+ctrno);
   
		}
	if($('#msg').val()!=""){
	   $.messager.alert('Message',$('#msg').val());
	  }

	
	 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";	
	 
	 if($('#contypeval').val()!="")
	  {
	  $('#cmbcontracttype').val($('#contypeval').val());
	  
	  }
	
	 
	 
}
	
	function funSearchLoad(){
		 changeContent('Mastersearch.jsp'); 
	} 
	 $(function(){
	        $('#fromcompletioncertificate').validate({
	                rules: { 
	                	
	                	cmbcontracttype:{"required":true},
	                	
	                //	desc: {maxlength:300},
	             
	                 },
	                 messages: {
	                	 
	                	 cmbcontracttype: {required:" * Required"},
	                
	               //  desc: {maxlength:" Max 300 chars"},
	                 
	                
	              
	                 }
	        });});
	 
	 
	 function funPrintBtn() {
			
		
}
	 
	 function refChange(){
	
	 }
	function funinv()
	{
		
		$('#invdesc').attr('disabled', false);
		 $('#invdesc').attr('readonly', false);
		 $('#invdate').jqxDateTimeInput({ disabled: false});
		var cval=document.getElementById("contrval").value;
		var cper=document.getElementById("certifyper").value;
		var retn=document.getElementById("contrretn").value;
		var ctotinv=document.getElementById("contrtotinv").value;
		var tobeinv=parseFloat(cval)*(parseFloat(cper)/100);
		var tobeinvoiced=parseFloat(tobeinv)-parseFloat(ctotinv);
		var retnamt1=parseFloat(tobeinvoiced)*(parseFloat(retn)/100);
		var retnamt=retnamt1.toFixed(2);
		
		 document.getElementById("pytval").value=cval;
		 document.getElementById("totinvoice").value=ctotinv;
		 document.getElementById("tobeinvoice").value=tobeinvoiced;
		 document.getElementById("retnamount").value=retnamt;
		
		 if(document.getElementById("btninv").innerText=="SAVE")
			 {
			 
			 if(tobeinvoiced<0) {
				 	document.getElementById("errormsg").innerText=" To Be Invoiced Amount Mismatch";
					return 0;
			 }
			 $("#overlay1, #PleaseWait1").show();
			 invgenerate(cval,ctotinv,tobeinvoiced,retnamt);
			 }
		 else{
			
		 }
		 document.getElementById("btninv").innerText="SAVE";
	}
	
	 function invgenerate(cval,ctotinv,tobeinvoiced,retnamt)
	 {
		 var invdates=$('#invdate').val();  
		 var invdescp=document.getElementById("invdesc").value;
		 var docno=document.getElementById("docno").value;
		 var contrno=document.getElementById("txtcontract").value;
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				 	var items= x.responseText.trim();
				 	 items=items.split('###');
				
				 	var val=items[0];
				 
				    $("#overlay1, #PleaseWait1").hide();
				 	if(val>0) {
				 		  $('#btninv').attr('disabled', true);
						  document.getElementById("btninv").innerText="CALCULATE";
				 		
				 		$.messager.alert('Message', '  Invoice No. '+items[2]+' is Successfully Generated', function(r){
						});
							
		        }else{
		        	
		        }
				 
				 	 
					}
			       else
				  {}
		     }  
		      x.open("GET","invGenerate.jsp?cval="+cval+"&ctotinv="+ctotinv+"&tobeinvoiced="+tobeinvoiced+"&retnamt="+retnamt+"&invdates="+invdates+"&invdescp="+invdescp+"&docno="+docno+"&contrno="+contrno,true)   
		     x.send();
		 
	 }
</script>
</head>

<body onLoad="setValues();">
<br/> 
	<div id="mainBG" class="homeContent" data-type="background"> 
	
	  <form id="fromcompletioncertificate" action="savecompletioncertificate" method="post" autocomplete="off">
		<jsp:include page="../../../../header.jsp" />
        <br>
		<div class='hidden-scrollbar'>

<body>
<fieldset style="background:#89FDBE;">
<table width="100%">
  <tr>
    <td align="right">Date</td>
    <td><div id="date" name="date" value='<s:property value="date"/>'></div></td>
    <%-- <td align="right">Ref No</td>
    <td><input type="text" name="refno" id="refno" value='<s:property value="refno"/>'></td> --%>
    <td align="right">Doc No</td>
    <td><input type="text" name="docno" id="docno"  value='<s:property value="docno"/>'></td>
  </tr>
  <tr>
    <td align="right">Contract Type</td>
    <td><select name="cmbcontracttype" id="cmbcontracttype" value='<s:property value="cmbcontracttype"/>' onchange="refChange();">
    <option value="">--Select--</option>
        <option value="AMC">AMC</option>
    <option value="SJOB">SJOB</option>
   
    </select>
    </td>
    <td align="right"><label id="contrno">Contract No</label></td>
    <td><input type="text" name="txtrefdetails" id="txtrefdetails" placeholder="Press F3 To Search"   onKeyDown="getcontract(event);"  value='<s:property value="txtrefdetails"/>'></td>
    <td><input type="hidden" name="txtcontract" id="txtcontract"   value='<s:property value="txtcontract"/>'></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="right">Client</td>
    <td colspan="3"><input type="text" name="txtclient" id="txtclient"   value='<s:property value="txtclient"/>'>
    <input type="text" name="txtclientdet" style="width:58.5%;" id="txtclientdet"  value='<s:property value="txtclientdet"/>'>
    </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <%-- <tr>
    <td align="right">Site</td>
    <td><input type="text" name="txtsite" id="txtsite" value='<s:property value="txtsite"/>'></td>
    <td align="right">Status</td>
    <td><select name="cmbstatus" id="cmbstatus">
      <option value="">--Select--</option>
      <option value="Completed">Completed</option>
      <option value="Closed">Closed</option>
      <option value="Pending">Pending</option>
    </select></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr> --%>
  <tr>
    <td align="right">Contract Value</td>
    <td colspan="3"><input type="text" name="contrval" style="width:30%;" id="contrval" value='<s:property value="contrval"/>'></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  
  <tr>
    <td align="right">Certified Percentage</td>
    <td colspan="3"><input type="text" name="certifyper" style="width:30%;" id="certifyper" value='<s:property value="certifyper"/>'></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="right">Description</td>
    <td colspan="3"><input type="text" name="desc" style="width:75.5%;" id="desc" value='<s:property value="desc"/>'></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
 </tr> 
</fieldset>
 </table>
<table width="100%"><tr><td>
    <fieldset >
    <div id="serdiv"><jsp:include page="serviceGrid.jsp"></jsp:include></div>
     </fieldset></td>
   </tr>
  </table>
   <table width="100%" ><tr><td>
    <fieldset ><legend>Invoice Generation</legend>
   <table width="100%" style="background:#ECFA8E;" >
   <tr>
   <td align="right">Payment Value</td>
   <td><input type="text" name="pytval" id="pytval" style="width:200px;" value='<s:property value="pytval"/>'></td>
    <td align="right">Already Invoiced</td>
    <td><input type="text" name="totinvoice" id="totinvoice" style="width:200px;" value='<s:property value="totinvoice"/>'>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <button class="myButton" type="button" id="btninv" name="btninv" onclick="funinv();">CALCULATE</button>
    </td>
   </tr>
   <tr>
   <td align="right">To Be Invoiced</td>
    <td><input type="text" name="tobeinvoice" id="tobeinvoice" style="width:200px;" value='<s:property value="tobeinvoice"/>'></td>
    <td align="right">Retention Amount</td>
    <td><input type="text" name="retnamount" id="retnamount" style="width:200px;" value='<s:property value="retnamount"/>'></td>
   </tr>
   <tr>
   <td align="right">Invoice Date</td>
    <td><div id="invdate" name="invdate" value='<s:property value="invdate"/>'></div></td>
    <td align="right">Invoice Description</td>
    <td><input type="text" name="invdesc" id="invdesc" style="width:700px;" value='<s:property value="invdesc"/>'></td>
   </tr>
   </table>
     </fieldset>
  </td></tr></table>
  <table>
 <tr>
 <td>
 
 <input type="hidden" id="contrretn" name="contrretn"  value='<s:property value="contrretn"/>'/> 
 <input type="hidden" id="contrtotinv" name="contrtotinv"  value='<s:property value="contrtotinv"/>'/>  
 
 
  <input type="hidden" id="txtlegalamt" name="txtlegalamt"  value='<s:property value="txtlegalamt"/>'/>
   <input type="hidden" id="txtseramt" name="txtseramt"  value='<s:property value="txtseramt"/>'/>
    <input type="hidden" id="txtexptotal" name="txtexptotal"  value='<s:property value="txtexptotal"/>'/>
     <input type="hidden" id="txtnettotal" name="txtnettotal"  value='<s:property value="txtnettotal"/>'/>
     <input type="hidden" name="hidestedit" id="hidestedit" value='<s:property value="hidestedit"/>'>
     
     
    <input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>
    <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
    <input type="hidden" id="deleted" name="deleted"  value='<s:property value="deleted"/>'/>
    <input type="hidden" id="clientid" name="clientid"  value='<s:property value="clientid"/>'/>
    <input type="hidden" id="costid" name="costid"  value='<s:property value="costid"/>'/>
     <input type="hidden" id="clacno" name="clacno"  value='<s:property value="clacno"/>'/>
     <input type="hidden" name="contypeval" id="contypeval" value='<s:property value="cmbcontracttype"/>'/>
      <input type="hidden" name="maintrno" id="maintrno" value='<s:property value="maintrno"/>'/>
      <%--   <input type="hidden" name="searchtrno" id="searchtrno" value='<s:property value="searchtrno"/>'/> --%>
     <input type="hidden" id="invgridlength" name="invgridlength" value='<s:property value="invgridlength"/>'/>
     <input type="hidden" id="expgridlength" name="expgridlength" value='<s:property value="expgridlength"/>'/>
     <input type="hidden" name="pdid" id="pdid" value='<s:property value="pdid"/>'>
     <input type="hidden" name="ptype" id="ptype" value='<s:property value="ptype"/>'>
     <input type="hidden" name="inctax" id="inctax" value='<s:property value="inctax"/>'> 
      
    </td>
   </tr>
</table>
</div>
<div id="contractwindow">
   <div ></div>
</div>
<!-- 
<div id="clientsearch1">
   <div ></div>
</div>  -->
</form>
</div>     
</body>
</html>
