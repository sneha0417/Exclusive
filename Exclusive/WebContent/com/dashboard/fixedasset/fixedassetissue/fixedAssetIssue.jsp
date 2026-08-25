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
	 $("#issueddate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#issuedtime").jqxDateTimeInput({  width: '20%', height: '17px', formatString: 'HH:mm', showCalendarButton: false });
	 $("#branchlabel").css("opacity","0");$("#branchdiv").css("opacity","0");
     $('#groupDetailsWindow').jqxWindow({width: '30%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Group Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
     $('#groupDetailsWindow').jqxWindow('close');
     $('#jobDetailsWindow').jqxWindow({width: '50%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Job Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
     $('#jobDetailsWindow').jqxWindow('close');
     $('#employeeDetailsWindow').jqxWindow({width: '50%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Employee Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
     $('#employeeDetailsWindow').jqxWindow('close');
     $('#branchDetailsWindow').jqxWindow({width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '25%' , title: 'Branch Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
     $('#branchDetailsWindow').jqxWindow('close');
     fundisable();
 
     $('#txtgroup').dblclick(function(){
	  groupSearchContent('groupSearchGrid.jsp');
      });
 
     $('#txtbranch').dblclick(function(){
	  branchSearchContent('branchSearchGrid.jsp');
      });
 
     $('#txtjobno').dblclick(function(){
    	 if($('#cmbjobtype').val()=='' || $('#cmbjobtype').val()=='0'){
     		  $.messager.alert('Message','Job Type is Mandatory.','warning');
     		  return;
     	   }
    	 jobSearchContent('jobDetailsSearch.jsp');
      });
      $('#txtemp').dblclick(function(){
    	 empSearchContent('employeeDetailsSearch.jsp?check=1');
      });
 
  });

    function getGroup(event){
      var x= event.keyCode;
      if(x==114){
      groupSearchContent('groupSearchGrid.jsp');
      }
      else{}
      }
    function groupSearchContent(url) {
      $('#groupDetailsWindow').jqxWindow('open');
	  $.get(url).done(function (data) {
	  $('#groupDetailsWindow').jqxWindow('setContent', data);
	  $('#groupDetailsWindow').jqxWindow('bringToFront');
      }); 
      }
    function funreload(event)
     {
	 var issue_stat="0";
	 if($("#issue_ret").val()=="issue"){
		 issue_stat="0,1,3";
	 }
	 if($("#issue_ret").val()=="ret"){
		 issue_stat="1,2";
	 }
	 
	 if($("#issue_ret").val()=="tfr"){
		 issue_stat="0,1,3";
	 }
	 
	 var groupno=$('#txtgroupno').val();
	 var issuestatus=$("#issue_ret").val();
	 
	  $("#overlay, #PleaseWait").show();
	  $("#faIssue").load("fixedAssetIssueGrid.jsp?issue_stat="+issue_stat+"&check=1"+"&groupno="+groupno+"&issuestatus="+issuestatus);
	  fundisable();
	 }
	
    function fundisable(){
			$('#issueddate').val(new Date());
			$('#issueddate').jqxDateTimeInput({disabled: true});
			$('#issuedtime').val(new Date());
			$('#issuedtime').jqxDateTimeInput({disabled: true});
			$("#save").attr("disabled",true);
			$("#cmbtype").attr("disabled",true);
			$("#txtjobno").attr("disabled",true);
			$("#cmbjobtype").attr("disabled",true);
			$("#txtemp").attr("disabled",true);
			$("#txtbranch").attr("disabled",true);
			$("#txtdesp").attr("disabled",true);
	
    }	
	function setValues(){
           if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
	}
	function funExportBtn(){
		JSONToCSVCon(dataexcel, 'FixedAssetIssue', true);
	}
	function getclr(){
		$('#txtgroup').val("");
		$('#txtgroupno').val("");
		$('#txtjobno').val("");
		$('#txtjobid').val("");
		$('#txtemp').val("");
		$('#txtempid').val("");
		$('#txtbranch').val("");
		$('#txtbranchid').val("");
	}
	function  funClear(){
		
		$('#issueddate').val(new Date());
		document.getElementById("issueinfo").value="";
		document.getElementById("cmbtype").value="2";
		document.getElementById("cmbjobtype").value="amc";
		document.getElementById("txtdesp").value="";
		document.getElementById("txtjobno").value="";
		document.getElementById("txtemp").value="";
		document.getElementById("txtbranch").value="";
		document.getElementById("txtbranchid").value="";
		document.getElementById("txtempid").value="";
		document.getElementById("txtjobid").value="";
		document.getElementById("txtgroup").value="";
		document.getElementById("txtgroupno").value="";
		$("#faIssueGrid").jqxGrid('clear');
		
		if (document.getElementById("txtgroupno").value == "") {
	        $('#txtgroup').attr('placeholder', 'Press F3 to Search'); 
	    }
		
		if (document.getElementById("txtjobid").value == "") {
		        $('#txtjobno').attr('placeholder', 'Press F3 to Search'); 
		    }
		 if (document.getElementById("txtempid").value == "") {
		        $('#txtemp').attr('placeholder', 'Press F3 to Search'); 
		    }
		 if (document.getElementById("txtbranchid").value == "") {
		        $('#txtbranch').attr('placeholder', 'Press F3 to Search'); 
		    }
			
		}
	
    function funsave()
	{
		 if($('#issue_ret').val()=="") 
		 {
			 $.messager.alert('Message','Select Issue Type ','warning');   
			 return 0;
		 }
		 
	      if($('#cmbjobtype').val()=="") 
	 	 {
	 		 $.messager.alert('Message','Select Job Type','warning');   
	 		 return 0;
	 	 }
	     var groupno=document.getElementById("txtgroupno").value;
		 var issue_ret=document.getElementById("issue_ret").value;
		 var userid=<%=session.getAttribute("USERID")%>;
		 var sbrhid=<%=session.getAttribute("BRANCHID")%>;
		 var hidfixmsrno=$('#hidfixmsrno').val();
		 var issueddate=$('#issueddate').val();
		 var issuedtime=$('#issuedtime').val();
		 var txtbranchid=$('#txtbranchid').val();
		 var txtjobid=$('#txtjobid').val();
		 var txtempid=$('#txtempid').val();
		 var txtdesp=document.getElementById("txtdesp").value;
		 var cmbtype=document.getElementById("cmbtype").value;
		 var cmbjobtype=document.getElementById("cmbjobtype").value;
			
		 $.messager.confirm('Message', 'Do you want to save changes?', function(r){
			 if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		 savedata(groupno,issue_ret,hidfixmsrno,issueddate,userid,sbrhid,issuedtime,txtbranchid,txtjobid,txtempid,txtdesp,cmbtype,cmbjobtype);	
		     	}
		  });
		
	}
	function  savedata(groupno,issue_ret,hidfixmsrno,issueddate,userid,sbrhid,issuedtime,txtbranchid,txtjobid,txtempid,txtdesp,cmbtype,cmbjobtype)
	{
		
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			     var items=x.responseText;
				 if(items==1){
				 /* document.getElementById("txtdocname").value="";
				 document.getElementById("txtdesc").value="";
				 document.getElementById("txtnote").value=""; */
			     $.messager.alert('Message', '  Record Successfully Saved', function(r){
				 $("#overlaysub, #PleaseWaitsub").show();
			     });
				 
				 	$('#issueddate').val(new Date());
					document.getElementById("issueinfo").value="";
					document.getElementById("cmbtype").value="2";
					document.getElementById("cmbjobtype").value="amc";
					document.getElementById("txtdesp").value="";
					document.getElementById("txtjobno").value="";
					document.getElementById("txtemp").value="";
					document.getElementById("txtbranch").value="";
					document.getElementById("txtbranchid").value="";
					document.getElementById("txtempid").value="";
					document.getElementById("txtjobid").value="";
					
					if (document.getElementById("txtjobid").value == "") {
					        $('#txtjobno').attr('placeholder', 'Press F3 to Search'); 
					    }
					 if (document.getElementById("txtempid").value == "") {
					        $('#txtemp').attr('placeholder', 'Press F3 to Search'); 
					    }
					 if (document.getElementById("txtbranchid").value == "") {
					        $('#txtbranch').attr('placeholder', 'Press F3 to Search'); 
					    }
				 funreload(event); 
				 fundisable();
				 }
				}
		}
			
	x.open("GET","savedata.jsp?groupno="+groupno+"&issue_ret="+issue_ret+"&hidfixmsrno="+hidfixmsrno+"&issueddate="+issueddate+"&userid="+userid+"&sbrhid="+sbrhid+"&issuedtime="+issuedtime+"&txtbranchid="+txtbranchid+"&txtjobid="+txtjobid+"&txtempid="+txtempid+"&txtdesp="+txtdesp+"&cmbtype="+cmbtype+"&cmbjobtype="+cmbjobtype,true);
    x.send();
	}
	function funTypeChange(){
		var val= document.getElementById("cmbtype").value;
		if(val==1){
			$("#txtbranch").attr("disabled",false);
		}
		else{
			$("#txtbranch").attr("disabled",true);
			
		}
	}
	function getBranchSearch(event){
        var x= event.keyCode;
        if(x==114){
        	branchSearchContent('branchSearchGrid.jsp');
        }
        else{}
        }
	function branchSearchContent(url) {
	    $('#branchDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#branchDetailsWindow').jqxWindow('setContent', data);
		$('#branchDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	function getJobNo(event){
        var x= event.keyCode;
        if(x==114){
        	if($('#cmbjobtype').val()=='' || $('#cmbjobtype').val()=='0'){
      		  $.messager.alert('Message','Job Type is Mandatory.','warning');
      		  return;
      	   }
        	jobSearchContent('jobDetailsSearch.jsp');
        }
        else{}
        
        }
	function jobSearchContent(url) {
	    $('#jobDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#jobDetailsWindow').jqxWindow('setContent', data);
		$('#jobDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
    function getEmployee(event){
        var x= event.keyCode;
        if(x==114){
        	empSearchContent('employeeDetailsSearch.jsp?check=1');
        }
        else{}
        }
	function empSearchContent(url) {
	    $('#employeeDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#employeeDetailsWindow').jqxWindow('setContent', data);
		$('#employeeDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
</script>
</head>
<body onload="getBranch();">
<form id="frmFAIssue" action="frmFAIssue" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>

  <tr>
     <tr><td align="right"><label class="branch">Issue Type</label></td>
     <td align="left"><select id="issue_ret" name="issue_ret"  value='<s:property value="issue_ret"/>' onchange="getclr(event);">
     <option value="issue">Issue</option><option value="ret">Return</option><option value="tfr">Transfer</option>
     </select></td></tr>
      
  	<tr><td align="right"><label class="branch">Group</label></td> 
	<td align="left"><input type="text" id="txtgroup" name="txtgroup" style="width:60%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtgroup"/>' onkeydown="getGroup(event);"/>
		             <input type="hidden" id="txtgroupno" name="txtgroupno" style="width:60%;height:20px;" value='<s:property value="txtgroupno"/>'/></td></tr>
	
		<tr><td colspan="2">&nbsp;</td></tr>
		
			
	<tr><td colspan="2" align="center"><textarea id="issueinfo" style="height:80px;width:200px;font: 10px Tahoma;resize:none" name="issueinfo"  readonly="readonly"  ><s:property value="issueinfo" ></s:property></textarea></td></tr>
		<tr><td colspan="2">&nbsp;</td></tr>
		
		
	 <tr><td align="right"><label class="branch">Type</label></td>
     <td align="left"><select id="cmbtype" name="cmbtype" onchange="funTypeChange();"  value='<s:property value="cmbtype"/>'">
     <option value="2">Issue</option><option value="1">Transfer</option><option value="3">Return</option>
     </select></td></tr>
	
	 <tr><td align="right"><label class="branch">Job Type</label></td>
     <td align="left"><select id="cmbjobtype" name="cmbjobtype"  value='<s:property value="cmbjobtype"/>'">
     <option value="amc">AMC</option><option value="sjob">SJOB</option>
     </select></td></tr>
	
	<tr><td align="right"><label class="branch">Job No.</label></td> 
	<td align="left"><input type="text" id="txtjobno" name="txtjobno" style="width:60%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" onkeydown="getJobNo(event);" value='<s:property value="txtjobno"/>'/>
		             <input type="hidden" id="txtjobid" name="txtjobid" style="width:60%;height:20px;" value='<s:property value="txtjobid"/>'/></td></tr>
	
	<tr><td align="right"><label class="branch">Employee</label></td> 
	<td align="left"><input type="text" id="txtemp" name="txtemp" style="width:60%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" onkeydown="getEmployee(event);" value='<s:property value="txtemp"/>'/>
		             <input type="hidden" id="txtempid" name="txtempid" style="width:60%;height:20px;" value='<s:property value="txtempid"/>'/></td></tr>
	

	 <tr>
	 <td align="right"><label class="branch">Date</label></td>
     <td align="left"><div id="issueddate" name="issueddate" value='<s:property value="issueddate"/>'></div></td></tr> 
	<tr>
   
    <tr>
     <td  align="right"><label class="branch">Time</label></td>
     <td align="left" ><div id='issuedtime' name='issuedtime' value='<s:property value="issuedtime"/>'  ></div></td>
    </tr>
   
   	<tr><td align="right"><label class="branch">Branch</label></td> 
	<td align="left"><input type="text" id="txtbranch" name="txtbranch" style="width:60%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtbranch"/>' onkeydown="getBranchSearch(event);"/>
		             <input type="hidden" id="txtbranchid" name="txtbranchid" style="width:60%;height:20px;" value='<s:property value="txtbranchid"/>'/></td></tr>
	
   
    <tr><td align="right"><label class="branch">Description</label></td> 
	<td align="left"><input type="text" id="txtdesp" name="txtdesp" style="width:60%;height:20px;"  value='<s:property value="txtdesp"/>'/>
		            
    
   <tr><td  colspan="2" align="center"><input type="Button" name="save" id="save" class="myButton" value="save" onclick="funsave();">
	<input type="Button" name="clear" id="clear" class="myButtons" value="clear" onclick="funClear();"></td> </tr>
		

	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td>
              <div id="faIssue"><jsp:include page="fixedAssetIssueGrid.jsp"></jsp:include></div> </td>
			  <input type="hidden" name="hidissustatus" id="hidissustatus" value='<s:property value="hidissustatus"/>'>
			  <input type="hidden" name="hidbranch" id="hidbranch" value='<s:property value="hidbranch"/>'>
			  <input type="hidden" name="hidfixmsrno" id="hidfixmsrno" value='<s:property value="hidfixmsrno"/>'>
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
		</tr>
	</table>
</tr>
</table>
</div>
<div id="jobDetailsWindow">
	<div></div><div></div>
</div>
<div id="employeeDetailsWindow">
	<div></div><div></div>
</div>
<div id="branchDetailsWindow">
	<div></div><div></div>
</div>
<div id="assetDetailsWindow">
	<div></div><div></div>
</div>
<div id="groupDetailsWindow">
	<div></div><div></div>
</div>
</div>
</form>
</body>
</html>