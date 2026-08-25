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

<script type="text/javascript">

	$(document).ready(function () {
		
		
		 $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#followupdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $('#areawindow').jqxWindow({ width: '28%', height: '53%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Area Search'  , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
		   $('#areawindow').jqxWindow('close');
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		     
	     $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
		    
	     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
		 $('#todate').on('change', function (event) {
				
			   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			 
			 	 
			   if(fromdates<todates){
				   
				   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
				 
			   return false;
			  }   
		 });
		
		 $('#date').on('change', function (event) {
				
			   var fdate=new Date($('#date').jqxDateTimeInput('getDate'));
			   var curdate=new Date(); 
			   fdate.setHours(0,0,0,0);
			   curdate.setHours(0,0,0,0);
			   if(fdate<curdate){
				   
				   $.messager.alert('Message','Select Future Date','warning');   
				   $('#date').jqxDateTimeInput('setDate', new Date());
				 
			   return false;
			  }   
		 });
		 $('#txtarea').dblclick(function(){
		 	    
			   $('#areawindow').jqxWindow('open');
			   areaSearchContent('area.jsp', $('#areawindow')); 
		       });

	});
	
	
	function getProcess() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				
				var srno  = items[0].split(",");
				var process = items[1].split(",");
				var optionsbranch = '<option value="" selected>-- Select -- </option>';
				for (var i = 0; i < process.length; i++) {
					optionsbranch += '<option  value="' + srno[i].trim() + ':'+ process[i].trim() +'">'
					+ process[i] + '</option>';
					
				}
				$("select#cmbprocess").html(optionsbranch);
				
			} else {}
		}
		x.open("GET","getProcess.jsp", true);
		x.send();
	}
	
	
  
	
	function disable(){
		 $('#date').jqxDateTimeInput({ disabled: true});
		 $('#cmbprocess').attr("disabled",true);
		 $('#txtremarks').attr("readonly",true);
		 $('#btnupdate').attr("disabled",true);
		 $('#amcno').attr("disabled",true);
		 $("#amcfollowupGrid").jqxGrid('clear');
		 $("#amcfollowupGrid").jqxGrid("addrow", null, {}); 
		 $("#amcfollowupGrid").jqxGrid({ disabled: true});
	}
	
	function followupcheck(){
		 if(document.getElementById("chckfollowup").checked){
			 document.getElementById("hidchckfollowup").value = 1;
			 $('#followupdate').jqxDateTimeInput({ disabled: false});
		 }
		 else{
			 document.getElementById("hidchckfollowup").value = 0;
			 $('#followupdate').jqxDateTimeInput({ disabled: true});
		 }
	 }
	function funreload(event){
		disable();
		var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  }
		 var fromdate= $("#fromdate").val();
		 var todate= $("#todate").val();
		 var branchval = document.getElementById("cmbbranch").value;
		 var chkfollowup = $('#hidchckfollowup').val();
		 var followupdate = $('#followupdate').val();
		 var areaid=$("#areaid").val();
		 var salesmanid=$("#cmbsalesman").val();
		 $("#overlay, #PleaseWait").show();
		 
		 $("#enquiryfollowupDiv").load("enquiryfollowupGrid.jsp?branchval="+branchval+"&froms="+fromdate+"&tos="+todate+"&chkfollowup="+chkfollowup+"&followupdate="+followupdate+"&areaid="+areaid+"&salesmanid="+salesmanid);
		}
	
	function funUpdate(event){
		var pro= $('#cmbprocess').val().split(":");
		var bibid=pro[0];
		var proname=pro[1];
		var date =  $('#date').val();
		var branchid = $('#txtbranch').val();
		var remarks = $('#txtremarks').val();
		var docno = $('#txtdocno').val();
		var rdtype = $('#conttype').val();
		
		if(bibid==''){
			 $.messager.alert('Message','Choose a Process.','warning');
			 return 0;
		 }

		
		 
		 if(remarks==''){
			 $.messager.alert('Message','Please Enter Remarks.','warning');   
			 return 0;
		 }
		
		
		 $.messager.confirm('Message', 'Do you want to save changes?', function(r){
		        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		saveGridData(bibid,proname,date,branchid,docno,rdtype,remarks);	
		     	}
		});
	}
	
	
		
   
	    
	function saveGridData(bibid,proname,date,branchid,docno,rdtype,remarks){

		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){
	     			
				var items=x.responseText;
				if(parseInt(items)=="1")
				{	
				$('#cmbprocess').val('');
				$('#date').val(new Date());
				$('#txtbranch').val('');
				$('#txtremarks').val('');
				$('#txtdocno').val('');
				$('#enqstat').val('');
				$('#info').val('');
				$('#conttype').val('');
				
				$.messager.alert('Message', '  Record Successfully Updated ');
			//	funreload(event); 
				disable();
				}
				else
				{
				$.messager.alert('Message', '  Not Updated  ');
				}
				}
		}
			
	x.open("GET","saveData.jsp?bibid="+bibid+"&proname="+proname+"&date="+date+"&branchid="+branchid+"&docno="+docno+"&rdtype="+rdtype+"&remarks="+remarks,true);
	x.send();
			
	}
	
	function funtxtenable()
	{
		
	}
	
	
	
	function funExportBtn(){
	    

		JSONToCSVCon(enqfollowupexcel, 'Enquiry Followup', true);
		   }
	function getareas(event){
	 	 var x= event.keyCode;
	 	 //alert("x===="+x);
	 	 if(x==114){
	 	  $('#areawindow').jqxWindow('open');

	           areaSearchContent('area.jsp');  	 }
	  	 else{
	  		
	 		 }
	        	 }
	 
	        	 
	function areaSearchContent(url) {
	 //alert(url);
	 	 $.get(url).done(function (data) {
			 //alert(data);
	$('#areawindow').jqxWindow('setContent', data);

	               	}); 
	     	}
	 function getSalesman() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
				//alert(items);
					items = items.trim().split('####');
					var salIdItems  = items[0].split(",");
					var salItems = items[1].split(",");
					var salusrlink= items[2].split(",");
					var optionssal="" ;
					var userid='<%=session.getAttribute("USERID").toString()%>';
					var first=salIdItems[0].trim();
					var frstsalusrlink=salusrlink[0].trim();
					/* if(userid!=first){
						optionssal += '<option value="" selected>--Select--</option>';
					} */
					for (var i = 0; i < salItems.length; i++) {
						optionssal += '<option value="' + salIdItems[i].trim() + '">'
								      + salItems[i] + '</option>';
						
					}
					if(userid!=frstsalusrlink){
					optionssal += '<option value="a">All</option>';
					}
					$("select#cmbsalesman").html(optionssal);
					 if ($('#hidcmbsalesman').val() != null) {
						$('#cmbsalesman').val($('#hidcmbsalesman').val());
					} 
					 if(userid==frstsalusrlink){
							$('#cmbsalesman').val(first);
					}
					 else{
						 $('#cmbsalesman').val("a");
					 }
				} else {
					//alert("Error");
				}
			}
			x.open("GET",'salesmanonload.jsp', true);
			x.send();
		}
</script>
</head>
<body onload="getBranch();getProcess();disable();followupcheck();getSalesman();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
	 <tr><td colspan="2"></td></tr>
	  <tr><td width="20%" align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
      <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
       </td></tr>
        <tr><td colspan="2"><input type="checkbox" id="chckfollowup" name="chckfollowup" value="" onchange="followupcheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)" /> 
                                 <input type="hidden" id="hidchckfollowup" name="hidchckfollowup" value='<s:property value="hidchckfollowup"/>'/></td></tr>
     <tr><td align="right"><label class="branch">FollowUp</label></td>
     <td align="left"><div id="followupdate" name="followupdate" value='<s:property value="followupdate"/>'></div>
     <input type="hidden" id="areaid" name="areaid" value='<s:property value="areaid"/>' >
     </td></tr>
    <tr><td colspan="2"></td></tr>
        <tr><td align="right"><label class="branch">Salesman</label></td>
	<td><select id="cmbsalesman" name="cmbsalesman" style="width:100%;" value='<s:property value="cmbsalesman"/>'>
      <option value="">--Select--</option></select></td>
      <input type="hidden" id="hidcmbsalesman" name="hidcmbsalesman" value='<s:property value="hidcmbsalesman"/>'/></td></tr>
    <tr><td align="right"> <label class="branch">Area</label></td>
<td ><input type="text" id="txtarea" name="txtarea" style="height:20px;width:95%;" readonly="true" placeholder="press F3 to search" value='<s:property value="txtarea"/>' onKeyDown=" getareas(event);"/></td></tr>
    	<tr><td colspan="2" align="center"><textarea id="info" style="height:60px;width:200px;font-family:Tahoma;font-size:12px;resize:none" name="info"  readonly="readonly"  ><s:property value="info" ></s:property></textarea></td></tr>	
	 <tr><td colspan="2">&nbsp;</td></tr> 
	 <tr><td align="right"><label class="branch">Process</label></td>
	 <td align="left"><select name="cmbprocess" id="cmbprocess" style="width:40%;" name="cmbprocess" onChange="funtxtenable();"  value='<s:property value="cmbprocess"/>'></select></td></tr>
	 <tr><td align="right"><label class="branch">Date</label></td>
     <td align="left"><div id="date" name="date" value='<s:property value="date"/>'></div></td></tr>
     <tr><td align="right"><label class="branch">Remarks</label></td>
	 <td align="left"><input type="text" id="txtremarks" name="txtremarks" style="width:100%;height:20px;" value='<s:property value="txtremarks"/>'/></td></tr>
	 <tr><td colspan="2"></td></tr>
	 <tr><td colspan="2" align="center"><button class="myButton" type="button" id="btnupdate" name="btnupdate" onclick="funUpdate(event);">Update</button></td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	  <tr><td colspan="2">&nbsp;</td></tr>
	 
	 <tr><td colspan="2">
	 <input type="hidden" id="txtdocno" name="txtdocno" style="width:100%;height:20px;" value='<s:property value="txtdocno"/>'/>
     <input type="hidden" id="txtbranch" name="txtbranch" style="width:100%;height:20px;" value='<s:property value="txtbranch"/>'/>
     <input type="hidden" id="txtenqstat" name="txtenqstat" style="width:100%;height:20px;" value='<s:property value="txtenqstat"/>'/>
     <input type="hidden" id="conttype" name="conttype"  value='<s:property value="conttype"/>'/></td></tr>
	 </table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr><td><div id="enquiryfollowupDiv"><jsp:include page="enquiryfollowupGrid.jsp"></jsp:include></div><br/></td></tr>
		<tr><td><div id="detailDiv"><jsp:include page="detailGrid.jsp"></jsp:include></div></td></tr>
	</table>
	</td>
</tr>
</table>
</div>
<div id="areawindow">
   <div></div>
</div>
</div> 
</body>
</html>