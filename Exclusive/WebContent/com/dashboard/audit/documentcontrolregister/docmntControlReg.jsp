
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/resample.js"></script>
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

$(document).ready(function () {
	 
	 
	
	     $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     $("body").prepend('<div id="overlaysub" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWaitsub' style='display: none;position:absolute; z-index: 1;top:230px;left:120px;'><img src='../../../../icons/31load.gif'/></div>");

	     $('#fieldexpdocmnt').hide();
	     $('#chkvalue').val("1");
	/*  $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"}); */
	/*  $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"}); */
	 $("#expfromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#exptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#expupdatefromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});
	 $("#expupdatetodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});
	 $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
/* 	 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
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
	 }); */
	 $("#branchlabel").css("opacity","0");$("#branchdiv").css("opacity","0");
	 fundisable();
});

function funreload(event)
{
	/* var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate')); */
// out date
	 /* var todates=new Date($('#todate').jqxDateTimeInput('getDate'));  */
 /* if(fromdates>todates){
	   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
	 
 return false;
}  */
	 var barchval = document.getElementById("cmbbranch").value;
     /* var fromdate= $("#fromdate").val(); */
	/*  var todate= $("#todate").val(); */
	 var chk_val= $('#chkvalue').val();
  $("#overlaysub, #PleaseWaitsub").show();
 $("#docmntControlReg").load("docmntControlRegGrid.jsp?branchval="+barchval+"&id=1"+"&chk_val="+chk_val);
  fundisable();
	}
	

function funchangeinfo()
{
	
	 $('#date').jqxDateTimeInput( 'focus');
	
	}
function fundisable(){
	$('#datadelete').attr('disabled',true);  
	$('#dataupdate').attr('disabled',true);
	$('#update').attr('disabled',true);
	$('#txtdocnameupd').val("");
	$('#txtdescupd').val("");
	$('#txtnoteupd').val("");
	$('#txtdocnameupd').attr('disabled',true);
	$('#txtdescupd').attr('disabled',true);
	$('#expupdatefromdate').jqxDateTimeInput({disabled:true});
	$('#expupdatetodate').jqxDateTimeInput('disabled',true);
	$('#txtnoteupd').attr('disabled',true);
	
	
}
function funchkval(){
	 if (document.getElementById('chknew').checked) {
		 $('#fieldnewdocmnt').show();
		 $('#fieldupdatedocmnt').show();
		 $('#fieldexpdocmnt').hide();
		 $('#chkvalue').val("1");
		 $('#docCntrlRegId').jqxGrid('clear');
		 $('#txtdocnameupd').val("");
			$('#txtdescupd').val("");
			$('#txtnoteupd').val("");
			$('#txtdocnameupd').attr('disabled',true);
			$('#txtdescupd').attr('disabled',true);
			$('#expupdatefromdate').jqxDateTimeInput({disabled:true});
			$('#expupdatetodate').jqxDateTimeInput('disabled',true);
			$('#txtnoteupd').attr('disabled',true);
			$('#update').attr('disabled',true);
			$('#dataupdate').attr('disabled',true); 
			$('#datadelete').attr('disabled',true);
	 	}
	 else if (document.getElementById('chkexpd').checked) {

		 $('#fieldnewdocmnt').hide();
		 $('#fieldupdatedocmnt').hide();
		 $('#fieldexpdocmnt').show();
		 $('#chkvalue').val("2");
		 $('#docCntrlRegId').jqxGrid('clear');
	 }
	 }
	 
function funupdate(){
	 var date=$('#date').val();
	 var docno=$('#hidocno').val();
	 
	  $.messager.confirm('Message', 'Do you want to save changes?', function(r){
	     	  
		        
	     	if(r==false)
	     	  {
	     		return false; 
	     	  }
	     	else{
	     		 updatedata(docno,date);	
	     	}
		     });
	
	
	
}
function updatedata(docno,date)
{
	
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		
     			
			var items=x.responseText;
			 if(items==1){		
			 
			  $('#date').val(new Date());
			  $.messager.alert('Message', '  Record Successfully Updated ', function(r){
				  var barchval = document.getElementById("cmbbranch").value;
				     /* var fromdate= $("#fromdate").val(); */
					/*  var todate= $("#todate").val(); */
					 var chk_val= $('#chkvalue').val();
				  $("#overlaysub, #PleaseWaitsub").show();
				 $("#docmntControlReg").load("docmntControlRegGrid.jsp?branchval="+barchval+"&id=1"+"&chk_val="+chk_val);
				  
		 		 
			     
		     });
			 funreload(event); 
			 fundisable();
			 }
			}
	}
		
x.open("GET","savedata.jsp?docno="+docno+"&date="+date+"&op=2",true);

x.send();
		
}

 function funupdatedata(){     
	 if(document.getElementById("txtdocnameupd").value=="")
	 {
		 $.messager.alert('Message','Enter Doc.Name ','warning');   
		 return 0;
	 } 
	 if($('#txtdescupd').val()=="") 
	 {
		 $.messager.alert('Message','Enter Description ','warning');   
		 return 0;
	 }
	 var desc = document.getElementById("txtdescupd").value;
	 var nmax = desc.length;
      if(nmax>99)
   	   {
   	  $.messager.alert('Message',' Description cannot contain more than 100 characters ','warning');   
   	
			return false; 
   	   } 
      if($('#txtnoteupd').val()=="") 
 	 {
 		 $.messager.alert('Message','Enter Note ','warning');   
 		 return 0;
 	 }
 	 var note =document.getElementById("txtnoteupd").value;
 	 var nmax1 =note.length;
       if(nmax1>99)
    	   {
    	  $.messager.alert('Message',' Note cannot contain more than 100 characters ','warning');   
    	
 			return false; 
    	   } 
      
       /* var expfromdates=$('#expfromdate').val();
	   var exptodates=$('#exptodate').val(); */
	   var expupfromdates1=new Date($('#expupdatefromdate').jqxDateTimeInput('getDate'));
	   var expuptodates1=new Date($('#expupdatetodate').jqxDateTimeInput('getDate'));
	   if(expupfromdates1>expuptodates1){
			   
			   $.messager.alert('Message','Issue Date Less Than Exp.From Date  ','warning');   
			 
		   return false;
		  } 
	   $('#expupdatetodate').on('change', function (event) {
		    
		      var fdate=new Date($('#expupdatetodate').jqxDateTimeInput('getDate'));
		      var curdate=new Date(); 
		      fdate.setHours(0,0,0,0);
		      curdate.setHours(0,0,0,0);
		      if(fdate<curdate){
		       
		       $.messager.alert('Message','Select Future Date','warning');   
		       $('#expupdatetodate').jqxDateTimeInput('setDate', new Date());
		     
		      return false;
		     } 
	   });     
     var doc_name=document.getElementById("txtdocnameupd").value;
	 var desc=document.getElementById("txtdescupd").value;
	 var note=document.getElementById("txtnoteupd").value;
	 var brchid=<%=session.getAttribute("BRANCHID")%>;
	 var userid=<%=session.getAttribute("USERID")%>;
	 var expupfromdates=$('#expupdatefromdate').val();
	 var expuptodates=$('#expupdatetodate').val();
	 var op="3";
	 var docno=$('#hidocno').val();
	 $.messager.confirm('Message', 'Do you want to save changes?', function(r){
	     	  
		        
	     	if(r==false)
	     	  {
	     		return false; 
	     	  }
	     	else{
	     		updatedata1(doc_name,desc,note,expupfromdates,expuptodates,brchid,userid,docno,op);	
	     	}
		     });
	
	
	
}
 function updatedata1(doc_name,desc,note,expfromdates,exptodates,brchid,userid,docno,op)
 {
 	
 	var x=new XMLHttpRequest();
 	x.onreadystatechange=function(){
 	if (x.readyState==4 && x.status==200)
 		{
 		
      			
 			var items=x.responseText;
 			 if(items==1){
 			 document.getElementById("txtdocname").value="";
 			 document.getElementById("txtdesc").value="";
 			 document.getElementById("txtnote").value="";
 			
 			 
 			  $('#date').val(new Date());
 			  $.messager.alert('Message', '  Record Successfully Updated', function(r){
 				  var barchval = document.getElementById("cmbbranch").value;
 				     /* var fromdate= $("#fromdate").val(); */
 					/*  var todate= $("#todate").val(); */
 					 var chk_val= $('#chkvalue').val();
 				  $("#overlaysub, #PleaseWaitsub").show();
 				 $("#docmntControlReg").load("docmntControlRegGrid.jsp?branchval="+barchval+"&id=1"+"&chk_val="+chk_val);
 		     });
 			 fundisable();
 			 funreload(event); 
 			 }
 			}
 	}
 		
 x.open("GET","savedata.jsp?doc_name="+doc_name+"&desc="+desc+"&note="+note+"&expfromdates="+expfromdates+"&exptodates="+exptodates+"&brchid="+brchid+"&userid="+userid+"&op="+op+"&docno="+docno,true);

 x.send();
 		
 }	 
 
function funsave()
{
	
	  if(document.getElementById("txtdocname").value=="")
	 {
		 $.messager.alert('Message','Enter Doc.Name ','warning');   
		 return 0;
	 } 
	 if($('#txtdesc').val()=="") 
	 {
		 $.messager.alert('Message','Enter Description ','warning');   
		 return 0;
	 }
	 var desc = document.getElementById("txtdesc").value;
	 var nmax = desc.length;
      if(nmax>99)
   	   {
   	  $.messager.alert('Message',' Description cannot contain more than 100 characters ','warning');   
   	
			return false; 
   	   } 
      if($('#txtnote').val()=="") 
 	 {
 		 $.messager.alert('Message','Enter Note ','warning');   
 		 return 0;
 	 }
 	 var note =document.getElementById("txtnote").value;
 	 var nmax1 =note.length;
       if(nmax1>99)
    	   {
    	  $.messager.alert('Message',' Note cannot contain more than 100 characters ','warning');   
    	
 			return false; 
    	   } 
      
       /* var expfromdates=$('#expfromdate').val();
	   var exptodates=$('#exptodate').val(); */
	   var expfromdates1=new Date($('#expfromdate').jqxDateTimeInput('getDate'));
	   var exptodates1=new Date($('#exptodate').jqxDateTimeInput('getDate'));
	   if(expfromdates1>exptodates1){
			   
			   $.messager.alert('Message','Issue Date Less Than Exp.From Date  ','warning');   
			 
		   return false;
		  } 
	   $('#exptodate').on('change', function (event) {
		    
		      var fdate=new Date($('#exptodate').jqxDateTimeInput('getDate'));
		      var curdate=new Date(); 
		      fdate.setHours(0,0,0,0);
		      curdate.setHours(0,0,0,0);
		      if(fdate<curdate){
		       
		       $.messager.alert('Message','Select Future Date','warning');   
		       $('#exptodate').jqxDateTimeInput('setDate', new Date());
		     
		      return false;
		     } 
	   });     
     var doc_name=document.getElementById("txtdocname").value;
	 var desc=document.getElementById("txtdesc").value;
	 var note=document.getElementById("txtnote").value;
	 var brchid=<%=session.getAttribute("BRANCHID")%>;
	 var userid=<%=session.getAttribute("USERID")%>;
	 var expfromdates=$('#expfromdate').val();
	 var exptodates=$('#exptodate').val();
	 var op="1";
	  $.messager.confirm('Message', 'Do you want to save changes?', function(r){
	     	  
		        
	     	if(r==false)
	     	  {
	     		return false; 
	     	  }
	     	else{
	     		 savedata(doc_name,desc,note,expfromdates,exptodates,brchid,userid,op);	
	     	}
		     });
	
	
	
}
function savedata(doc_name,desc,note,expfromdates,exptodates,brchid,userid,op)
{
	
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		
     			
			var items=x.responseText;
			 if(items==1){
			 document.getElementById("txtdocname").value="";
			 document.getElementById("txtdesc").value="";
			 document.getElementById("txtnote").value="";
			
			 
			  $('#date').val(new Date());
			  $.messager.alert('Message', '  Record Successfully Saved', function(r){
				  var barchval = document.getElementById("cmbbranch").value;
				     /* var fromdate= $("#fromdate").val(); */
					 /* var todate= $("#todate").val(); */
					 var chk_val= $('#chkvalue').val();
				  $("#overlaysub, #PleaseWaitsub").show();
				 $("#docmntControlReg").load("docmntControlRegGrid.jsp?branchval="+barchval+"&id=1"+"&chk_val="+chk_val);
				  
		 		 
			     
		     });
			 funreload(event); 
			 fundisable();
			 }
			}
	}
		
x.open("GET","savedata.jsp?doc_name="+doc_name+"&desc="+desc+"&note="+note+"&expfromdates="+expfromdates+"&exptodates="+exptodates+"&brchid="+brchid+"&userid="+userid+"&op="+op,true);
x.send();
}
function funExportBtn(){
	JSONToCSVCon(documentntcontrolexcel, 'Document Control Register', true);
}
function fundeletedata(){
	 var doc_name=document.getElementById("txtdocname").value;
	 var desc=document.getElementById("txtdesc").value;
	 var note=document.getElementById("txtnote").value;
	 var brchid=<%=session.getAttribute("BRANCHID")%>;
	 var userid=<%=session.getAttribute("USERID")%>;    
	 var expfromdates=$('#expfromdate').val();
	 var exptodates=$('#exptodate').val();
	 var op="4";
	 var docno=$('#hidocno').val();
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
			var items=x.responseText;
			 if(items==1){
			 document.getElementById("txtdocname").value="";
			 document.getElementById("txtdesc").value="";
			 document.getElementById("txtnote").value="";
			  $('#date').val(new Date());
			  $.messager.alert('Message', '  Record Successfully Deleted', function(r){
				  var barchval = document.getElementById("cmbbranch").value;
				     /* var fromdate= $("#fromdate").val(); */
					/*  var todate= $("#todate").val(); */
					 var chk_val= $('#chkvalue').val();
				  $("#overlaysub, #PleaseWaitsub").show();
				 $("#docmntControlReg").load("docmntControlRegGrid.jsp?branchval="+barchval+"&id=1"+"&chk_val="+chk_val);
		     });
			 fundisable();
			 funreload(event); 
			 }
			}
	}
x.open("GET","savedata.jsp?doc_name="+doc_name+"&desc="+desc+"&note="+note+"&expfromdates="+expfromdates+"&exptodates="+exptodates+"&brchid="+brchid+"&userid="+userid+"&op="+op+"&docno="+docno,true);
x.send();
}
</script>
</head>
<body onload="setval()">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%"  >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>
		 <%-- <tr><td  align="right" width="25%" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div></td></tr> --%>
         <%-- <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div> </td></tr> --%>
         <tr><td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" name="chk"  checked="checked" id="chknew" value="out" onchange="funchkval()"><label class="branch">New Document</label>&nbsp;&nbsp;&nbsp;
         											  <input type="radio" name="chk" id="chkexpd" value="in" onchange="funchkval()"><label class="branch">Expired Docment</label></td></tr>
	
	  </table> 
	  <div style="display: table; height: 170px; width:100%; overflow: hidden; ">
  		 <div style="display: table-cell; vertical-align: middle;">
	  <div id="divprocess" >
	  <fieldset id="fieldnewdocmnt" >
	  <legend>New Document</legend>
	  <table width="100%">
      <tr><td align="right"><label class="branch">Document name </label></td><td align="left"><input type="text" id="txtdocname" style="height:20px;width:99%;" name="txtdocname"  value='<s:property value="txtdocname"/>'> </td></tr>
      <tr><td align="right"><label class="branch">Description </label></td><td align="left"><input type="text" id="txtdesc" style="height:20px;width:99%;" name="txtdesc"  value='<s:property value="txtdesc"/>'> </td></tr>
      <tr><td  align="right" width="25%" ><label class="branch">Issue Date</label></td><td align="left"><div id='expfromdate' name='expfromdate' value='<s:property value="expfromdate"/>'></div></td></tr>
      <tr><td  align="right" ><label class="branch">Exp.Date</label></td><td align="left"><div id='exptodate' name='exptodate' value='<s:property value="exptodate"/>'></div></td></tr>
      <tr><td align="right"><label class="branch">Notes</label></td><td align="left"><input type="text" id="txtnote" style="height:20px;width:99%;" name="txtnote"  value='<s:property value="txtnote"/>'> </td></tr>
	  <tr><td colspan="2"></td></tr> 
	<tr><td  align="center" colspan="2"><input type="Button" name="save" id="save" class="myButton" value="save" onclick="funsave()"></td> </tr>
 </table>
</fieldset>
	  <fieldset id="fieldupdatedocmnt" >
	  <legend>Update Document</legend>
	  <table width="100%">
      <tr><td align="right"><label class="branch">Document name </label></td><td align="left"><input type="text" id="txtdocnameupd" style="height:20px;width:99%;" name="txtdocnameupd"  value='<s:property value="txtdocnameupd"/>'> </td></tr>
      <tr><td align="right"><label class="branch">Description </label></td><td align="left"><input type="text" id="txtdescupd" style="height:20px;width:99%;" name="txtdescupd"  value='<s:property value="txtdescupd"/>'> </td></tr>
       <tr><td align="right"><label class="branch">Notes</label></td><td align="left"><input type="text" id="txtnoteupd" style="height:20px;width:99%;" name="txtnoteupd"  value='<s:property value="txtnoteupd"/>'> </td></tr>
      <tr><td  align="right" width="25%" ><label class="branch">Issue Date</label></td><td align="left"><div id='expupdatefromdate' name='expupdatefromdate' value='<s:property value="expupdatefromdate"/>'></div></td></tr>
      <tr><td  align="right" ><label class="branch">Exp.Date</label></td><td align="left"><div id='expupdatetodate' name='expupdatetodate' value='<s:property value="expupdatetodate"/>'></div></td></tr>
     
	  <tr><td colspan="2"></td></tr> 
	<tr><td align="left" ><input type="Button" name="dataupdate" id="dataupdate" class="myButton" value="Update" onclick="funupdatedata()"></td> 
	<td align="right" ><input type="Button" name="datadelete" id="datadelete" class="myButton" value="Delete" onclick="fundeletedata()"></td> </tr>
 </table>
</fieldset>
	  <fieldset id="fieldexpdocmnt">
	  <legend>Extend Exp.Date</legend>
	  <table width="100%" > 
	      <tr><td  align="right" ><label class="branch">Extend To</label></td><td align="left"><div id='date' name='date' value='<s:property value="date"/>'></div></td></tr>
 		  <tr><td  align="center" colspan="2"><input type="Button" name="update" id="update" class="myButton" value="Update Exp.Date" onclick="funupdate()"></td> </tr> 
           <tr><td>&nbsp;</td></tr>
	 <tr><td>&nbsp;</td></tr>
	 <tr><td>&nbsp;</td></tr>
	 <tr><td>&nbsp;</td></tr>
	  <tr><td>&nbsp;</td></tr>
	 <tr><td>&nbsp;</td></tr>
	 <tr><td>&nbsp;</td></tr>
	 <tr><td>&nbsp;</td></tr>
	 <tr><td>&nbsp;</td></tr>
	 <tr><td>&nbsp;</td></tr>
	 <tr><td>&nbsp;</td></tr>
	 <tr><td>&nbsp;</td></tr>
 </table>
</fieldset>
</div>

</div>
</div>
<input type="hidden" name="hidocno" id="hidocno" style="height:20px;width:70%;" value='<s:property value="hidocno"/>' >
<input type="hidden" name="chkvalue" id="chkvalue" style="height:20px;width:70%;" value='<s:property value="chkvalue"/>' >
	</fieldset>

</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="docmntControlReg"><jsp:include page="docmntControlRegGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>

</table>

</div>
</div>
</body>
</html>