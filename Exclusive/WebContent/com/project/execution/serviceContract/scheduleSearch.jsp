 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%--   <jsp:include page="../../../../includes.jsp"></jsp:include>   --%> 
<style>
 <link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
</style>
<style>
 .myButtons {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #7892c2), color-stop(1, #476e9e));
	background:-moz-linear-gradient(top, #7892c2 5%, #476e9e 100%);
	background:-webkit-linear-gradient(top, #7892c2 5%, #476e9e 100%);
	background:-o-linear-gradient(top, #7892c2 5%, #476e9e 100%);
	background:-ms-linear-gradient(top, #7892c2 5%, #476e9e 100%);
	background:linear-gradient(to bottom, #7892c2 5%, #476e9e 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#7892c2', endColorstr='#476e9e',GradientType=0);
	background-color:#7892c2;
	border:1px solid #4e6096;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:12px;
	padding:2px 7px;
	text-decoration:none;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #476e9e), color-stop(1, #7892c2));
	background:-moz-linear-gradient(top, #476e9e 5%, #7892c2 100%);
	background:-webkit-linear-gradient(top, #476e9e 5%, #7892c2 100%);
	background:-o-linear-gradient(top, #476e9e 5%, #7892c2 100%);
	background:-ms-linear-gradient(top, #476e9e 5%, #7892c2 100%);
	background:linear-gradient(to bottom, #476e9e 5%, #7892c2 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#476e9e', endColorstr='#7892c2',GradientType=0);
	background-color:#476e9e;
}
.myButtons:active {
	position:relative;
	top:1px;
}      

        

</style>
	<script type="text/javascript">

	$(document).ready(function () { 
		document.getElementById("chkday").checked=true;
		document.getElementById("chkday").value=1;
		 var chkinv=document.getElementById("chkinv").value;
		 if(chkinv==0){
			 document.getElementById("srvalue").value=0;
			 $('#srvalue').attr('readonly', true);
		 }
		 else if(chkinv==1){
			 $('#srvalue').attr('readonly', false);
		 }
		 $('#dayid').show();
		  $('#intid').hide();
		  
		$("#serfrmdate").jqxDateTimeInput({ width : '90px', height : '15px', formatString : "dd.MM.yyyy" });
		  $("#sertodate").jqxDateTimeInput({ width : '90px', height : '15px', formatString : "dd.MM.yyyy" }); 
		   
	});   
		   
  	function loadSearchss() {
 		
 		var activity=document.getElementById("txtactivities").value;
 		var section=document.getElementById("txtsections").value;
 		var project=document.getElementById("txtprojects").value;
 		var id=1;
 		
 	
		getdatas(activity,section,project,id);
 

	}
	function getdatas(activity,section,project,id){
		
		    var activid=document.getElementById("activitiesid").value;
		    
			 $("#refsearch").load('subactivitysearch.jsp?activity='+activity+'&section='+section+'&project='+project+'&activid='+activid+'&id='+id);
		

		}  
	
	
		
/* 
	function funUpdate(){
		
		
	    var rows = $("#servserGrid").jqxGrid('selectedrowindexes');
	   var aid=0;
	  
	   //var activeid=document.getElementById("activitiesid").value;
	    var selectedRecords = new Array();
	    for (var m = 0; m < rows.length; m++) {
	    	
	        var row = $("#servserGrid").jqxGrid('getrowdata', rows[m]);
	        
	        
	        var rowlength=$("#servscGrid").jqxGrid('rows').records.length;
	        
	        if(rowlength==0)
	        {
	        $("#servscGrid").jqxGrid('addrow', null, {});
	        $('#servscGrid').jqxGrid('setcellvalue',m,"pldate",row.pldate);
	        $('#servscGrid').jqxGrid('setcellvalue',m,"days",row.days);
	        $('#servscGrid').jqxGrid('setcellvalue',m,"site",row.site);
	        $('#servscGrid').jqxGrid('setcellvalue',m,"service",row.service);
	        $('#servscGrid').jqxGrid('setcellvalue',m,"serviceid",row.serviceid);
	        $('#servscGrid').jqxGrid('setcellvalue',m,"siteid",row.siteid);
	        $('#servscGrid').jqxGrid('setcellvalue',m,"value",row.value);
	       /*  aid=aid+activeid+",";
	        aid=row.tr_no; */
	     
	        /*}
	        else
	        	{
	        	var totrow=0;
	        	totrow=row.length+rowlength;
	        	var test=0;
	        	for (var n =rowlength-1;n < totrow; n++) {
	        		var rowspec = $("#servscGrid").jqxGrid('getrowdata',n);
	        		
	        		/* if((rowspec.tr_no==row.tr_no))
	        			{
	        			
	        				test=1;
	        				break;
	            		} */
	       
	        	 /*if(test==0){
	        		$("#servscGrid").jqxGrid('addrow', null, {});
	        		 $('#servscGrid').jqxGrid('setcellvalue',n,"pldate",row.pldate);
	     	        $('#servscGrid').jqxGrid('setcellvalue',n,"days",row.days);
	     	        $('#servscGrid').jqxGrid('setcellvalue',n,"site",row.site);
	     	        $('#servscGrid').jqxGrid('setcellvalue',n,"service",row.service);
	     	        $('#servscGrid').jqxGrid('setcellvalue',n,"serviceid",row.serviceid);
	     	        $('#servscGrid').jqxGrid('setcellvalue',n,"siteid",row.siteid);
	     	       $('#servscGrid').jqxGrid('setcellvalue',n,"value",row.value);
	     	      /*  aid=aid+activeid+",";
	     	       aid=aid+row.tr_no+","; */
	        	 /*}
	        	}
	        
	        selectedRecords[selectedRecords.length] = row;
	    }
	    /* aid=aid.replace(/,(?=[^,]*$)/, '');
	    
	    document.getElementById("activitiesid").value=aid; */
	  
	    /* $("#servserGrid").jqxGrid('clear');
		$("#servserGrid").jqxGrid('addrow', null, {});
		
	    $('#schserchinfowindow').jqxWindow('close');
	    
	} */
	
	function funUpdate(){
	    var row = $("#servserGrid").jqxGrid('selectedrowindexes');
	    var rows = $("#servserGrid").jqxGrid('getrows');
	    /* alert(rows.length); */
	 //   var selectedRecords = new Array();
	    
		row = row.sort(function(a,b){return a - b});
	 
	    for (var m = 0; m < row.length; m++) {
	      //  var row = $("#suitSearch").jqxGrid('getrowdata', rows[m]);
	        // alert("==row===="+ row.service);
	       // var rowlength=$("#jqxSuitGrid").jqxGrid('rows').records.length;
	 
	       
	       var rr=$("#servscGrid").jqxGrid('getrows');
	      
	        $('#servscGrid').jqxGrid('setcellvalue',rr.length-1,"pldate",rows[m].pldate);
	        $('#servscGrid').jqxGrid('setcellvalue',rr.length-1,"pltime",rows[m].pltime);
	        $('#servscGrid').jqxGrid('setcellvalue',rr.length-1,"days",rows[m].days);
	        $('#servscGrid').jqxGrid('setcellvalue',rr.length-1,"site",rows[m].site);
	        $('#servscGrid').jqxGrid('setcellvalue',rr.length-1,"service",rows[m].service);
	        $('#servscGrid').jqxGrid('setcellvalue',rr.length-1,"serviceid",rows[m].serviceid);
	        $('#servscGrid').jqxGrid('setcellvalue',rr.length-1,"siteid",rows[m].siteid);
	        $('#servscGrid').jqxGrid('setcellvalue',rr.length-1,"value",rows[m].value);
	        
	        $("#servscGrid").jqxGrid('addrow', null, {});
	        	
	        
	    }
	    $('#schserchinfowindow').jqxWindow('close');
	}	
	

	function funscheduleres(){
		
		var serfrmdate=$("#serfrmdate").val();
		var sertodate=$("#sertodate").val();
		var cmbsrvday=$("#cmbsrvday").val();
		var srvalue=$("#srvalue").val();
		
		var srvint=$("#srvint").val();
		var srvdue=$("#srvdue").val();
		var csrvtyp=$("#csrvtyp").val();
		 
		var srvid=$("#srvid").val();
		var siteid=$("#siteid").val();
		
		var srvsite=$("#srvsite").val().replace(/ /g,'%20');
		var srvser=$("#srvser").val().replace(/ /g,'%20');
		
		var chkday=document.getElementById("chkday").value;
	
		if(chkday==1){
		
		if(cmbsrvday==""){
			document.getElementById("errormsg").innerText="Check atleast one day";
			return 0;
		}
		if(siteid==""){
			document.getElementById("errormsg").innerText="select atleast one Site";
			return 0;
		}
		if(srvid==""){
			document.getElementById("errormsg").innerText="select atleast one service";
			return 0;
		}
		if(srvalue==""){
			document.getElementById("errormsg").innerText="Enter service value";
			return 0;
		}
		
		
		
		}
		
		else{
			
			
			if(srvint==""){
				document.getElementById("errormsg").innerText="Enter service Interval";
				return 0;
			}
			if(srvdue==""){
				document.getElementById("errormsg").innerText="Enter service Due";
				return 0;
			}
		}
document.getElementById("errormsg").innerText=" ";
		
		
		$("#refsearch").load("serviceScheduleSearchGrid.jsp?serfrmdate="+serfrmdate+"&sertodate="+sertodate+"&cmbsrvday="+cmbsrvday+"&srvalue="+srvalue+"&srvid="+srvid+"&siteid="+siteid+"&srvser="+srvser+"&srvsite="+srvsite+"&srvint="+srvint+"&srvdue="+srvdue+"&csrvtyp="+csrvtyp+"&chkday="+chkday+"&gridload=1");
		
	}
	
function fundaycheck(){
	 var chkday=document.getElementById("chkday").value;
	  if(chkday==1){
		  $('#dayid').show();
		  $('#intid').hide();
	  }
	  else{
		  $('#dayid').hide();
		  $('#intid').show();
	  }
	
}
	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr >
   <td>
 
    </td>
  </tr>
  <tr>
  <td>
    
<table width="100%" >
  <tr>
   <td width="3%" align="center"><label for="chkday">Day</label><input type="checkbox" name="chkday" id="chkday" value='<s:property value="chkday" />' onclick="$(this).attr('value', this.checked ? 1 : 0);fundaycheck();"></td>
    <td width="2%" align="right">From</td>
    <td width="2%"><div id="serfrmdate" name="serfrmdate" value='<s:property value="serfrmdate" />'></div></td>
    <td width="3%" align="right">To</td>
    <td width="2%"><div id="sertodate" name="sertodate" value='<s:property value="sertodate" />'></div></td>
   
    <td width="40%">
    <fieldset id="dayid"><table width="100%">
    <tr>
     <td width="2%" align="right">Day</td>
    <td>
  Mon<input type="checkbox" id="mon" name="mon"  value="0"  onclick="$(this).attr('value', this.checked ? 0 : 0);daycheck();">
  Tue<input type="checkbox" id="tue" name="tue"    value="0" onclick="$(this).attr('value', this.checked ? 1 : 0);daycheck();">
  Wed<input type="checkbox" id="wed" name="wed"   value="0" onclick="$(this).attr('value', this.checked ? 2 : 0);daycheck();"> 
  Thu<input type="checkbox" id="thu" name="thu"   value="0" onclick="$(this).attr('value', this.checked ? 3 : 0);daycheck();"> 
  Fri<input type="checkbox" id="fri" name="fri"   value="0" onclick="$(this).attr('value', this.checked ? 4 : 0);daycheck();"> 
  Sat<input type="checkbox" id="sat" name="sat"   value="0" onclick="$(this).attr('value', this.checked ? 5 : 0);daycheck();"> 
  Sun<input type="checkbox" id="sun" name="sun"  value="0" onclick="$(this).attr('value', this.checked ? 6 : 0);daycheck();"> 
  </td></tr></table></fieldset>
  <fieldset id="intid"><table width="100%" >
    <tr>
    <td width="2%" align="right">Interval</td>
    <td width="5%"><input type="text" name="srvint" id="srvint" style="width:100%;" value='<s:property value="srvint"/>'></td>
    <td width="2%" align="right">Due.after</td>
    <td width="5%"><input type="text" name="srvdue" id="srvdue" style="width:100%;" value='<s:property value="srvdue"/>'></td>
    <td width="2%" align="right">Freq.</td>
    <td width="10%"><select name="csrvtyp" id="csrvtyp" style="width:100%;">
      <option value="1">DAYS</option>
      <option value="2">MONTHS</option>
      <option value="3">YEAR</option>
    </select></td>
    </tr></table></fieldset>
  </td>
    <td width="2%" align="right">Site</td>
    <td width="10%"><input type="text" name="srvsite" id="srvsite" placeholder="Press F3 to Search" readonly="true" onKeyDown="getsite(1);"  value='<s:property value="srvsite"/>'></td>
    <td width="2%" align="right">Service</td>
    <td width="8%"><input type="text" name="srvser" id="srvser" placeholder="Press F3 to Search" readonly="true" onKeyDown="getserType(1,2);"  value='<s:property value="srvser"/>'></td>
    <td width="2%" align="right">Value</td>
    <td width="12%"><input type="text" name="srvalue" id="srvalue" style="width:100%;"  value='<s:property value="srvalue"/>'></td>
     <td width="4%" align="center"><button class="myButton" type="button" id="btnAdd" name="btnAdd" onclick="funscheduleres();">Fill</button></td>
     <td><input type="text" name="srvid" id="srvid" hidden="true"   value='<s:property value="srvid"/>'>
     <input type="text" name="siteid" id="siteid" hidden="true" value='<s:property value="siteid"/>'></td>
  </tr>
 
</table>
  </td>

  <tr>
    <td colspan="8" align="right">
    
    <div id="refsearch">
      
   <jsp:include  page="serviceScheduleSearchGrid.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
  <table width="100%">
  <tr>
  <td width="100%" align="center">
<button class="myButton" type="button" id="btnAdd" name="btnAdd" onclick="funUpdate();">OK</button>
  </td>
  </tr>
  </table>
</body>
</html>