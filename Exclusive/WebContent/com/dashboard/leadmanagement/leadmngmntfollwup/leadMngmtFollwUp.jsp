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
		   
		   $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
			 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
			
			 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
			  
		     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
		     $('#todate').on('change', function (event) {
					
				   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
				 lead
				  // out date
				 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
				 	 
				   if(fromdates>todates){
					   
					   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
					 
				   return false;
				  }})
		   
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

	     $('#salesmanwindow').jqxWindow({ width: '25%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Salesman Search'  , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
		   $('#salesmanwindow').jqxWindow('close');
	     
		   
		   $('#txtsalesman').dblclick(function(){
		  	    $('#salesmanwindow').jqxWindow('open');
		   
		  	//  salesmanSearchContent('salesmansearch.jsp');
		  	  salesmanSearchContent('salesmanMasterSearch.jsp?', $('#salesmanwindow'));
	     });
	 
		   getCategory();
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
					optionsbranch += '<option  value="' + srno[i].trim()+'">'
					+ process[i] + '</option>';
				}
				$("select#cmbprocess").html(optionsbranch);
				
			} else {}
		}
		x.open("GET","getProcess.jsp", true);
		x.send();
	}
	
	/* function getPriority() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				
				var srno  = items[0].split(",");
				var process = items[1].split(",");
				var optionsbranch = '<option value="" selected>-- Select -- </option>';
				for (var i = 0; i < process.length; i++) {
					optionsbranch += '<option  value="' + srno[i].trim()+'">'
					+ process[i] + '</option>';
				}
				$("select#cmbpriority").html(optionsbranch);
				
			} else {}
		}
		x.open("GET","getPriority.jsp", true);
		x.send();
	} */
	
	
  
	
	function disable(){
		 
		 $('#cmbcategory').attr("disabled",true);
		 $('#date').jqxDateTimeInput({ disabled: true});
		 $('#cmbprocess').attr("disabled",true);
		 $('#cmbpriority').attr("disabled",true); 
		 $('#txtremarks').attr("readonly",true);
		 $('#btnupdate').attr("disabled",true);
		 $('#txtsalesman').attr("disabled",true);
		 $("#amcfollowupGrid").jqxGrid('clear');
		 $("#amcfollowupGrid").jqxGrid("addrow", null, {}); 
		 $("#amcfollowupGrid").jqxGrid({ disabled: true}); 
		
	}
	
	
	function funreload(event){
		disable();
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var branchval = document.getElementById("cmbbranch").value;
		 var chkfollowup = $('#hidchckfollowup').val();
		 var followupdate = $('#followupdate').val();
		 var salesmanid=$('#cmbsalesman').val()
		 $("#overlay, #PleaseWait").show();  
		 $("#leadFollowupDiv").load("leadMngmtFollowupGrid.jsp?branchval="+branchval+"&followupdate="+followupdate+'&fromdate='+fromdate+'&todate='+todate+"&chkfollowup="+chkfollowup+"&check=1"+"&salesmanid="+salesmanid);
	}
	
	function funUpdate(event){     
		
		 var rdocno=$('#txtrdocno').val();
		 var date =  $('#date').val();
		 var remarks = $('#txtremarks').val();
	     var proid=$('#cmbprocess').val();
	     var priorityid=$("#cmbpriority").val();  
		 var branchid =$("#txtbrchid").val(); 
		 var userid=$("#txtuserid").val();
		 var clientacid=$("#hidcmbacgroup").val();
		 var catid=$("#hidcatid").val(); 
		 var pstatus=$("#cmbpriority").val();
		 var cmbcat=$("#cmbcategory").val();
		 var salid=$("#txtsalid").val();
		if(proid==''){
			 $.messager.alert('Message','Choose a Process.','warning');
			 return 0;
		 }
if(proid==3 && pstatus=="")
		{
	 $.messager.alert('Message','Choose a Status.','warning');
	 return 0;
		}
if(proid==4 && cmbcat=="")
{
$.messager.alert('Message','Choose a Category.','warning');
return 0;
}
if(proid==5 && salid=="")
{
$.messager.alert('Message','Select a Salesman.','warning');
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
		     		
		     		saveGridData(rdocno,date,remarks,proid,priorityid,branchid,userid,clientacid,catid,salid);	
		     	}
		});
	}
	
	function followupcheck(){
		 if(document.getElementById("chckfollowup").checked){
			 document.getElementById("hidchckfollowup").value = 1; 
			 $('#cmbprocess').attr("disabled",false);
			/*  $('#cmbpriority').attr("disable",false); */
			 $('#followupdate').jqxDateTimeInput({ disabled: false});
			 $('#fromdate').jqxDateTimeInput({ disabled: true});
			 $('#todate').jqxDateTimeInput({ disabled: true});
		 }
		 else{
			 document.getElementById("hidchckfollowup").value = 0;
			 $('#followupdate').jqxDateTimeInput({ disabled: true});
			 $('#fromdate').jqxDateTimeInput({ disabled: false});
			 $('#todate').jqxDateTimeInput({ disabled: false});
		 }
	 }
		
	function getsalesman(event){

		var x= event.keyCode;
	 	 if(x==114){
	 		 $('#salesmanwindow').jqxWindow('open');
	 		// changeContent('salesmansearch.jsp');  
	 		 salesmanSearchContent('salesmanMasterSearch.jsp?', $('#salesmanwindow'));
	    	 }
	 	 else{
	 		 
	 		 }
	 	 }
	function salesmanSearchContent(url) {
		 $.get(url).done(function (data) {
		$('#salesmanwindow').jqxWindow('setContent', data);
	           	}); 
	 	}
	function saveGridData(rdocno,date,remarks,proid,priorityid,branchid,userid,clientacid,catid,salid){

		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){
	     			
				var items=x.responseText;
				if(parseInt(items)=="1")  
				{	
				 $('#cmbprocess').val('');
				$('#date').val(new Date());
				$('#txtbrchid').val('');
				$('#txtremarks').val('');
				$('#txtrdocno').val('');
				$('#txtcldocno').val('');
				$('#txtuserid').val('');
				$('#txtsalid').val('');
				$('#cmbpriority').val(''); 
				$('#txtsalesman').val('');
				
				$('#cmbcategory').val('');
				$('#hidcmbcategory').val('');
				$('#hidcmbacgroup').val(''); 
				$("#hidcatid").val('');
				
				
				$.messager.alert('Message', '  Record Successfully Updated ');
				funreload(event); 
				disable();
				}
				else
				{
				$.messager.alert('Message', '  Not Updated  ');
				}
				}
		}
    x.open("GET","saveData.jsp?trdocno="+rdocno+"&fldate="+date+"&remark="+remarks+"&bibpid="+proid+"&leadstatus="+priorityid+"&brchid="+branchid+"&userid="+userid+"&clientacid="+clientacid+"&catid="+catid+"&salid="+salid,true);			
	x.send();
			
	}
	
	function funtxtenable(value)
	{
		
		if(value=="3"){
			$('#cmbpriority').attr("disabled",false);
			$('#cmbcategory').attr("disabled",true);
			$('#txtsalesman').attr("disabled",true);
		}
		if(value=="4"){
			 $('#cmbcategory').attr("disabled",false);
			 $('#cmbpriority').attr("disabled",true);
			 $('#txtsalesman').attr("disabled",true);
		}
		if(value=="5"){
			 $('#cmbcategory').attr("disabled",true);
			 $('#cmbpriority').attr("disabled",true);
			 $('#txtsalesman').attr("disabled",false);
		}
		
	}
	
	
	
	function funExportBtn(){
	    

		//JSONToCSVCon(amcrenewalexcel, 'AMC Renewal Followup', true);
		   }
	  function getsalesmanonload(){
			
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				 	var res= x.responseText;
					 var ressplt=res.split("::");
					 var salname=ressplt[0].trim();
					 var salid=ressplt[1].trim();
				 	if(salid>0){
				 		document.getElementById("txtsalesman").value=salname;
				 		document.getElementById("txtsalid").value=salid;
						  }
					}
			       else
				  {}
		     }
		      x.open("GET",'salesmanonload.jsp',true);
		     x.send();
		    
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
	  function getCategoryAccountGroup(a) {
			
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText.trim();
					var dat=items.split("###");
					
				    $('#hidcmbacgroup').val(dat[0]);
				    $('#hidcatid').val(dat[1]);
					/* if ($('#hidcmbacgroup').val() != "") {
						$('#cmbacgroup').val($('#hidcmbacgroup').val());
					} */
				} else {
				}
			}
			x.open("GET", "getCategoryAccountGroup.jsp?category="+a, true);
			x.send();
		} 
	  
	  function getCategory() {
			 
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					items = items.split('####');
					var categoryItems = items[0].split(",");
					var categoryIdItems = items[1].split(",");
					var optionscategory = '<option value="">--Select--</option>';
					for (var i = 0; i < categoryItems.length; i++) {
						optionscategory += '<option value="' + categoryIdItems[i] + '">'
								+ categoryItems[i] + '</option>';
					}
					$("select#cmbcategory").html(optionscategory);
					
				} else {
				}
				//alert("=========="+$('#hidcmbcategory').val());
				if ($('#hidcmbcategory').val() != null) {
					$('#cmbcategory').val($('#hidcmbcategory').val());
				}
			}
			x.open("GET", "getCategory.jsp", true);
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
	 <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr>                 
	 
      <tr><td colspan="2" > <input type="hidden" id="hidchckfollowup" name="hidchckfollowup" value='<s:property value="hidchckfollowup"/>'/></td></tr>
     <tr><td align="left"><input type="checkbox" id="chckfollowup" name="chckfollowup" value="" onchange="followupcheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)" /> 
                           <label class="branch">FollowUp</label></td>
     <td align="left"><div id="followupdate" name="followupdate" value='<s:property value="followupdate"/>'></div></td></tr>
    <tr><td colspan="2"></td></tr>
    <tr><td align="right"><label class="branch">Salesman</label></td>
	<td><select id="cmbsalesman" name="cmbsalesman" style="width:100%;" value='<s:property value="cmbsalesman"/>'>
      <option value="">--Select--</option></select></td>
      <input type="hidden" id="hidcmbsalesman" name="hidcmbsalesman" value='<s:property value="hidcmbsalesman"/>'/></td></tr>
    </td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr> 
	 <tr><td align="right"><label class="branch">Process</label></td>
	  <td align="left"><select name="cmbprocess" id="cmbprocess" style="width:60%;" name="cmbprocess" onchange="funtxtenable(value);"  value='<s:property value="cmbprocess"/>'></select></td></tr>
	 
	 <tr>
	 	<td align="right"><label class="branch">Salesman</label></td>
	 	<td align="left">
	 		<input type="text" name="txtsalesman" id="txtsalesman" placeholder="Press F3 To Search"  onKeyDown="getsalesman(event);"   style="height:20px;width:100%;" value='<s:property value="txtsalesman"/>'>
	 	</td>
	 </tr>
	 <tr><td align="right"><label class="branch">Status</label></td>
	  <td align="left"><select name="cmbpriority" id="cmbpriority" style="width:60%;" name="cmbpriority"   value='<s:property value="cmbpriority"/>'>

	   <option value="">--Select--</option>
	   <option value="1">Cold</option>
	   <option value="2">Warm</option>
	   <option value="3">Hot</option>
	   </select></td></tr>
	<tr>
	<tr><td align="right"><label class="branch">Category</label></td>
	  <td align="left"><select id="cmbcategory" name="cmbcategory" style="width:100%;" onchange="getCategoryAccountGroup(this.value);" value='<s:property value="cmbcategory"/>'>
	  <option value="">--Select--</option>
	  </select>
      <input type="hidden" id="hidcmbcategory" name="hidcmbcategory" value='<s:property value="hidcmbcategory"/>'/>
       <input type="hidden" id="hidcatid" name="hidcatid" value='<s:property value="hidcatid"/>'/>
      <input type="hidden" id="hidcmbacgroup" name="hidcmbacgroup" value='<s:property value="hidcmbacgroup"/>'/>
	  </td></tr>

	 <tr><td align="right"><label class="branch">Date</label></td>
     <td align="left"><div id="date" name="date" value='<s:property value="date"/>'></div></td></tr>
     <tr><td align="right"><label class="branch">Remarks</label></td>
	 <td align="left"><input type="text" id="txtremarks" name="txtremarks" style="width:100%;height:20px;" value='<s:property value="txtremarks"/>'/></td></tr>
	 <tr><td colspan="2"></td></tr>
	 <tr><td colspan="2" align="center"><button class="myButton" type="button" id="btnupdate" name="btnupdate" onclick="funUpdate(event);">Update</button></td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 
	 <tr><td colspan="2">
	 <input type="hidden" id="txtdocno" name="txtdocno" style="width:100%;height:20px;" value='<s:property value="txtdocno"/>'/>
     <input type="hidden" id="txtbranch" name="txtbranch" style="width:100%;height:20px;" value='<s:property value="txtbranch"/>'/>
     <input type="hidden" id="txtsalid" name="txtsalid" style="width:100%;height:20px;" value='<s:property value="txtsalid"/>'/>
     <input type="hidden" id="txtrdocno" name="txtrdocno" style="width:100%;height:20px;" value='<s:property value="txtrdocno"/>'/>
     <input type="hidden" id="txtbrchid" name="txtbrchid" style="width:100%;height:20px;" value='<s:property value="txtbrchid"/>'/>
     <input type="hidden" id="txtuserid" name="txtuserid" style="width:100%;height:20px;" value='<s:property value="txtuserid"/>'/>
     </td></tr> 
	 </table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr><td><div id="leadFollowupDiv"><jsp:include page="leadMngmtFollowupGrid.jsp"></jsp:include></div><br/></td></tr>
		<tr><td><div id="detailDiv"><jsp:include page="leadMngmtDetailGrid.jsp"></jsp:include></div></td></tr>
	</table>
	</td>
</tr>
</table>
</div>
<div id="salesmanwindow">
   <div></div>
</div>
</div> 
</body>
</html>