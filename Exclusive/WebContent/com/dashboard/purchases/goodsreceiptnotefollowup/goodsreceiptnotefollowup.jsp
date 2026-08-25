 
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

</style>

<script type="text/javascript">

$(document).ready(function () {
	

	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");


	       $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
		   $('#accountSearchwindow').jqxWindow('close');
		   
		   $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
			 
		     $('#locationwindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Location Search' ,position: { x: 200, y: 70 }, keyboardCloseKey: 27});
		     $('#locationwindow').jqxWindow('close');  
		   
		     $("#invdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});  
		     
		   
	/*  $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
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
	 
	  */
	 
	   $('#account').dblclick(function(){
	    
	    	
	    		
		  	    $('#accountSearchwindow').jqxWindow('open');
		  	
		  	  accountSearchContent('accountsDetailsSearch.jsp?');
	    		 
	  });   
	    
	  
});
 
function funExportBtn(){
	JSONToCSVCon(datasex,'Goods Receipt Note Followup Mater', true);
	JSONToCSVCon(datas11ex,'Goods Receipt Note Followup Details', true);
	 }

function locationsearchContent(url) {
    //alert(url);
       $.get(url).done(function (data) {
//alert(data);
     $('#locationwindow').jqxWindow('setContent', data);

	}); 
 	}
function getaccountdetails(event){
	 var x= event.keyCode;
  	
 
		
	 if(x==114){
	  $('#accountSearchwindow').jqxWindow('open');
	
	 accountSearchContent('accountsDetailsSearch.jsp?');    }
	 else{
		 }
		 
	 }  
	  function accountSearchContent(url) {
 
         $.get(url).done(function (data) {
 
       $('#accountSearchwindow').jqxWindow('setContent', data);

	}); 
   	}
function funreload(event)
{

	/*   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
	  // out date
	 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
	 	 
	   if(fromdates>todates){
		   
		   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		 
	   return false;
	  } 
	   else
		   { */
	 var barchval = document.getElementById("cmbbranch").value;
/*      var fromdate= $("#fromdate").val();
	 var todate= $("#todate").val(); */
	 
	 var fromdate="";
	 var todate="";
	 
	 var statusselect="";
	 
	 var acno=$("#acno").val();
	  $("#ordersubgrid").jqxGrid('clear');
	  $("#duedetailsgrid").jqxGrid('clear');
	   $("#overlay, #PleaseWait").show();
	  $("#listdiv").load("ordermainGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&statusselect="+statusselect+"&acno="+acno);
	
		  /*  } */
	}

function  funcleardata()
{
	document.getElementById("acno").value="";
	document.getElementById("account").value="";
	document.getElementById("accname").value="";
 
	
 
	document.getElementById("statusselect").value="All";
	
	
	
	 if (document.getElementById("account").value == "") {
			
		 
	        $('#account').attr('placeholder', 'Press F3 TO Search'); 
	    }
	  
		
	}
function getinfo() {
	  var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
		//alert(items);
			items = items.split('####');
			
			var srno  = items[0].split(",");
			var process = items[1].split(",");
			var optionsbranch = '<option value="" selected>-- Select -- </option>';
			for (var i = 0; i < process.length; i++) {
				optionsbranch += '<option value="' + srno[i].trim() + '">'
						+ process[i] + '</option>';
			}
			$("select#cmbinfo").html(optionsbranch);
			
		} else {
			//alert("Error");
		}
	}
	x.open("GET","getinfo.jsp", true);
	x.send(); 
}
function getstatus() {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var itemss = x.responseText;
		//alert(items);
			itemss = itemss.split('####');
			
			var srno1  = itemss[0].split(",");
			var process1 = itemss[1].split(",");
			var optionsbranch1= '<option value="" selected>-- Select -- </option>';
			for (var i = 0; i < process1.length; i++) {
				optionsbranch1 += '<option value="' + srno1[i].trim() + '">'
						+ process1[i] + '</option>';
			}
			$("select#status").html(optionsbranch1);
			
		} else {
			//alert("Error");
		}
	}
	x.open("GET","getstatus.jsp", true);
	x.send();
}


function funupdate()
{
	
	var listss = new Array();
	 if(document.getElementById("cmbinfo").value=="")
	 {
		 $.messager.alert('Message','Select Process ','warning');   
					 
		 return 0;
	 }
	 
	 
	 if(document.getElementById("cmbinfo").value=="1")
		 {
	 
	 if($('#remarks').val()=="")
	 {
		 $.messager.alert('Message','Enter Remarks ','warning');   
		 return 0;
	 }
	 var remarkss = document.getElementById("remarks").value;
	 var nmax = remarkss.length;
      if(nmax>99)
   	   {
   	  $.messager.alert('Message',' Remarks cannot contain more than 200 characters ','warning');   
   	
			return false; 
   	 
   	   } 
		 }
	 
	 
	 else if(document.getElementById("cmbinfo").value=="2")
		 {
		 if($('#status').val()=="")
		 {
			 $.messager.alert('Message','Select Status ','warning');   
			 return 0;
		 }
		 
		 }
	  
	 
	 else if(document.getElementById("cmbinfo").value=="3")
		 {
		  
		 
		 if($('#invno').val()=="")
		 {
			 $.messager.alert('Message','Enter Inv No ','warning');   
			 return 0;
		 }
		 
		
			var selectedrows=$("#ordersubgrid").jqxGrid('selectedrowindexes');
			 
			
			
			 if(selectedrows.length=="0" ||selectedrows.length==0)
			 {
				 $.messager.alert('Message','Select Product','warning');   
				 return 0;
			 }
			 
			 
			 
			 //  specid unitdocno qty amount  total disper discount  nettotal
			
			selectedrows = selectedrows.sort(function(a,b){return a - b});  
			 var aa= 0;
			  for(var i=0 ; i < selectedrows.length ; i++){
				  
				var amount=$("#ordersubgrid").jqxGrid('getcellvalue',selectedrows[i],'nettotal');
				if(amount==""||typeof(amount)=="undefined"|| typeof(amount)=="NaN" || amount=="0" || parseFloat(amount)<=0)
				  {
				aa=1;
				break;
				  }
				  
			  	}
			  
			  	if(aa==1)
				  {
			  		
			  	  $.messager.alert('Message','Net Total Is Mandatory','warning');   
				  return 0;
				  }
			 
				  for(var i=0 ; i < selectedrows.length ; i++){
					 listss.push($("#ordersubgrid").jqxGrid('getcellvalue',selectedrows[i],'psrno')+"::"+
							 $("#ordersubgrid").jqxGrid('getcellvalue',selectedrows[i],'specid')+"::"+
							 $("#ordersubgrid").jqxGrid('getcellvalue',selectedrows[i],'unitdocno')+"::"+
							 $("#ordersubgrid").jqxGrid('getcellvalue',selectedrows[i],'qty')+"::"+
							 $("#ordersubgrid").jqxGrid('getcellvalue',selectedrows[i],'amount')+"::"+
							 $("#ordersubgrid").jqxGrid('getcellvalue',selectedrows[i],'total')+"::"+
							 $("#ordersubgrid").jqxGrid('getcellvalue',selectedrows[i],'disper')+"::"+
							 $("#ordersubgrid").jqxGrid('getcellvalue',selectedrows[i],'discount')+"::"+
							 $("#ordersubgrid").jqxGrid('getcellvalue',selectedrows[i],'nettotal')+"::"+
							 $("#ordersubgrid").jqxGrid('getcellvalue',selectedrows[i],'stockid')+"::"); 
						  }
				  
		 
		 
		 }
	  
	 
	 
      
      
      var docno = document.getElementById("masterdocno").value;
  
 	 var branchids = document.getElementById("brhid").value;
 	 var remarks = document.getElementById("remarks").value;
 	 var cmbinfo = document.getElementById("cmbinfo").value;
       var refrowno=0;
 	 var folldate =$('#date').val();
 	 
 	var cmbval = document.getElementById("cmbinfo");
 	var cmbText = cmbval.options[cmbval.selectedIndex].text;
 	 
	 var statuschg = document.getElementById("status").value;
	 
	 
	 var invdate = document.getElementById("invdate").value;
	 var invno = document.getElementById("invno").value;
	 var txtlocationid =0;
 	

	    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
	     	  
		        
	     	if(r==false)
	     	  {
	     		return false; 
	     	  }
	     	else{
	     		
	     		
	     		
	     		
	     		
	     		 savegriddata(docno,branchids,remarks,cmbinfo,folldate,cmbText,refrowno,statuschg,invdate,invno,txtlocationid,listss);	
	     	}
		     });
	
	
	
}
function savegriddata(docno,branchids,remarks,cmbinfo,folldate,cmbText,refrowno,statuschg,invdate,invno,txtlocationid,listss)
{
	
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		
     			
			var items=x.responseText;
			if(parseInt(items)>0)
				 {
				 
				  $.messager.alert('Message', ' Successfully Updated');
				  funreload(event);
				
				  
				  disitems(0);
				  
				 }
			 else
				 {
				 $.messager.alert('Message', ' Not Updated '); 
				 }
			 
			  
			
			 
			
			}
	}
		
x.open("GET","savedata.jsp?docno="+docno+"&branchids="+branchids+"&remarks="+remarks+"&cmbinfo="+cmbinfo+"&folldate="+folldate+"&cmbText="+cmbText+"&refrowno="+refrowno+"&statuschg="+statuschg+"&invdate="+invdate+"&invno="+invno+"&txtlocationid="+txtlocationid+"&listss="+listss,true);

x.send();
		
}


function disitems(val)
{
	
	 
			if(val=="1")
				{
				
				 $('#cmbinfo').attr("disabled",false);
				 $('#status').attr("disabled",true);
				 $('#remarks').attr("disabled",false);
				 $('#remarks').attr("readonly",false);
				 $('#Update').attr("disabled",false);
			   
				 document.getElementById("remarks").value="";
				 document.getElementById("status").value="";
				 
				 $('#date').val(new Date());
				 $('#date').jqxDateTimeInput({ disabled: false});
				 document.getElementById("status").value="";
				 document.getElementById("txtlocation").value="";
				 document.getElementById("txtlocationid").value="";
				 document.getElementById("invno").value="";
				 $('#invdate').val(new Date());
				 $('#invdate').jqxDateTimeInput({ disabled: true});
				 $('#txtlocation').attr("disabled",true);
				 $('#invno').attr("disabled",true);
					 
				}
			else if(val=="2")
			{
			    $('#cmbinfo').attr("disabled",false);
			    $('#status').attr("disabled",false);
			    $('#remarks').attr("readonly",true);
			    $('#remarks').attr("disabled",true);
			    $('#Update').attr("disabled",false);
				 
				document.getElementById("remarks").value="";
				document.getElementById("status").value="";
		 
			    $('#date').val(new Date());
			    $('#date').jqxDateTimeInput({ disabled: true});
			    document.getElementById("status").value="1";
		 
			    document.getElementById("invno").value="";
			    $('#invdate').val(new Date());
			    $('#invdate').jqxDateTimeInput({ disabled: true});
			    $('#txtlocation').attr("disabled",true);
			    $('#invno').attr("disabled",true);
				 
				 
				 
			}
			else if(val=="3")
			{
			    $('#cmbinfo').attr("disabled",false);
			    $('#status').attr("disabled",true);
			    $('#remarks').attr("readonly",true);
			    $('#Update').attr("disabled",false);
			    $('#remarks').attr("disabled",true);
				document.getElementById("remarks").value="";
				document.getElementById("status").value="";
			    $('#date').val(new Date());
			    $('#date').jqxDateTimeInput({ disabled: true});
			    document.getElementById("status").value="";
 
				document.getElementById("invno").value="";
				$('#invdate').val(new Date());
				$('#invdate').jqxDateTimeInput({ disabled: false});
				 $('#txtlocation').attr("disabled",false);
				 $('#invno').attr("disabled",false);
			
			}
			
			else
			{
	 
				document.getElementById("invno").value="";
				$('#invdate').val(new Date());
				$('#invdate').jqxDateTimeInput({ disabled: true});
				$('#txtlocation').attr("disabled",true);
				$('#invno').attr("disabled",true);
			    document.getElementById("cmbinfo").value="";
			    document.getElementById("remarks").value="";
			    document.getElementById("status").value="";
			    document.getElementById("masterdocno").value="";
			    $('#date').val(new Date());
			    $('#date').jqxDateTimeInput({ disabled: true});
			    $('#cmbinfo').attr("disabled",true);
			    $('#status').attr("disabled",true);
			    $('#remarks').attr("readonly",true);
			   $('#Update').attr("disabled",true);
			
			}
		
			
	
}




</script>
</head>
<body onload="getBranch();getinfo();getstatus();disitems(0);">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
	<tr><td align="right"><label class="branch">Account</label></td>
    <td><input type="text" name="account" id="account" value='<s:property value="account"/>' readonly="readonly" placeholder="Press F3 To Search"   style="height:20px;width:70%;" onKeyDown="getaccountdetails(event);" >  </td></tr>
    <tr><td>&nbsp;</td><td> <input type="text" id="accname" name="accname" value='<s:property value="accname"/>'  readonly="readonly"  style="height:20px;width:100%;"></td></tr>
   	<tr><td colspan="2">&nbsp;</td></tr> 
    <tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funcleardata()"></td></tr>
    <tr><td colspan="2">&nbsp;</td></tr> 
    <tr> <td  align="right"><label class="branch">Process</label></td><td align="left">
    <select name="cmbinfo" id="cmbinfo" style="width:70%;" value='<s:property value="cmbinfo"/>' onchange="disitems(this.value);" > </select></td></tr>
    <tr><td  align="right" ><label class="branch">Date</label></td><td align="left"><div id='date' name='date' value='<s:property value="date"/>'></div> </td></tr>
    <tr><td align="right"><label class="branch">Remarks</label></td><td align="left"><input type="text" id="remarks" style="height:20px;width:88%;" name="remarks"  value='<s:property value="remarks"/>'> </td></tr>
     <tr><td align="right"><label class="branch">Status</label></td><td align="left"><select name="status" id="status" style="width:70%;"  value='<s:property value="status"/>'> </select></td></tr>
    
      <tr><td  align="right" ><label class="branch">Inv Date</label></td><td align="left"><div id='invdate' name='invdate' value='<s:property value="invdate"/>'></div> </td></tr>
       <tr><td  align="right" ><label class="branch">Inv No</label></td><td align="left"> <input type="text" id="invno" style="height:20px;width:70%;"  name="invno" value='<s:property value="invno"/>'/> </td></tr>
     
    <tr><td colspan="2">&nbsp;</td></tr> 
    <tr><td  align="center" colspan="2"><input type="Button" name="Update" id="Update" class="myButton" value="Update" onclick="funupdate()"> </td> </tr>
    	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr>
	<td colspan="2"><div id='paychaaaaa' style="width: 100% ; align:right; height:90px;"></div></td>
	</tr>	
	</table>
	</fieldset>
   <input type="hidden" id="acno" name="acno" value='<s:property value="acno"/>'>
      <input type="hidden" id="brhid" name="brhid" value='<s:property value="brhid"/>'>
      
        <input type="hidden" id="reftype" name="reftype" value='<s:property value="reftype"/>'>
      
      

      
   
</td>
<td width="80%">
	<table width="100%">
		<tr><td><div id="listdiv"><jsp:include page="ordermainGrid.jsp"></jsp:include></div></td></tr>
	    <tr><td><div id="listdiv1"><jsp:include page="ordersubGrid.jsp"></jsp:include></div></td></tr>
		<tr><td><div id="detaildiv"><jsp:include page="detailgrid.jsp"></jsp:include></div></td></tr>
	</table>
</tr>
</table>
<input type="hidden" id="masterdocno" name="masterdocno" value='<s:property value="masterdocno"/>'>



</div>
	  <div id="locationwindow">
	   <div ></div>
	</div>

<div id="accountSearchwindow">
   <div ></div>
</div> 
</div>
</body>
</html>