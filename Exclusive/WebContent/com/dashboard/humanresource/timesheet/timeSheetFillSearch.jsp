 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

<script type="text/javascript">

	$(document).ready(function () { 
		  
		$("#timeSheetFillFromDate").jqxDateTimeInput({ width : '90px', height : '15px', formatString : "dd.MM.yyyy" });
		$("#timeSheetFillToDate").jqxDateTimeInput({ width : '90px', height : '15px', formatString : "dd.MM.yyyy" }); 
		$("#timeSheetFillNormalHrs").jqxDateTimeInput({ width : '40px', height : '15px', formatString : "HH:mm",showCalendarButton: false });
		$("#timeSheetFillOTHrs").jqxDateTimeInput({ width : '40px', height : '15px', formatString : "HH:mm",showCalendarButton: false });
		$("#timeSheetFillHOTHrs").jqxDateTimeInput({ width : '40px', height : '15px', formatString : "HH:mm",showCalendarButton: false });
		$("#timeSheetFillInTime").jqxDateTimeInput({ width : '40px', height : '15px', formatString : "HH:mm",showCalendarButton: false });
		$("#timeSheetFillOutTime").jqxDateTimeInput({ width : '40px', height : '15px', formatString : "HH:mm",showCalendarButton: false });
		
		var fromdate = $('#timeSheetFillFromDate').jqxDateTimeInput('val');
		var fromday = fromdate.split(".");
		var restrictedFromDate = new Date(new Date($('#cmbyear').val(),(parseInt($('#cmbmonth').val())-1),fromday[0]));
		$("#timeSheetFillFromDate").jqxDateTimeInput('val', restrictedFromDate);
		
		var todate = $('#timeSheetFillToDate').jqxDateTimeInput('val');
		var today = todate.split(".");
		var restrictedToDate = new Date(new Date($('#cmbyear').val(),(parseInt($('#cmbmonth').val())-1),today[0]));
		$("#timeSheetFillToDate").jqxDateTimeInput('val', restrictedToDate);
		  
		$('#txtselectedempids').dblclick(function(){
		  	 employeeSearchContent("employeeDetailsMultiSearch.jsp");
	     });
		
		$('#txtselectedcosttypename').dblclick(function(){
			 $('#txtorgridclick').val('3');
			 costTypeSearchContent("costTypeSearchGrid.jsp");
	     });
		 
		 $('#txtselectedcostid').dblclick(function(){
			 if($('#txtselectedcosttypeid').val()==''){
	   			 	$.messager.show({title:'Message',msg:'Cost Type is Mandatory.',showType:'show',style:{left:27,right:'',top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}});
	   			 	return 0;
	   		 }
			 $('#txtorgridclick').val('3');
			 costCodeSearchContent("costCodeSearchGrid.jsp?costtype="+$('#txtselectedcosttypeid').val());
	     });
		 
		 checknormal();
		 
	});  
	
	function getFillEmployeeId(event){
        var x= event.keyCode;
        if(x==114){
        	employeeSearchContent("employeeDetailsMultiSearch.jsp");
        }
        else{}
	 }
	
	function getFillProjectType(event){
        var x= event.keyCode;
        if(x==114){
        	$('#txtorgridclick').val('3');
			costTypeSearchContent("costTypeSearchGrid.jsp");
        }
        else{}
	 }
 
 	function getFillProjectId(event){
        var x= event.keyCode;
        if(x==114){
        	if($('#txtselectedcosttypeid').val()==''){
        		$.messager.show({title:'Message',msg:'Cost Type is Mandatory.',showType:'show',style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}});
   			 	return 0;
   		     }
        	 $('#txtorgridclick').val('3');
			 costCodeSearchContent("costCodeSearchGrid.jsp?costtype="+$('#txtselectedcosttypeid').val());
        }
        else{}
	 }
	
	function daycheck(){
		  
		  var aid=0;

		 if(document.getElementById("mon").checked){
			 aid=aid+0+",";
		  }
		 if(document.getElementById("tue").checked){
			 aid=aid+1+",";	  
		 }
		 if(document.getElementById("wed").checked){
			 aid=aid+2+",";
		 }
		 if(document.getElementById("thu").checked){
			 aid=aid+3+",";
		 }
		 if(document.getElementById("fri").checked){
			 aid=aid+4+",";
		 }
		 if(document.getElementById("sat").checked){
			 aid=aid+5+",";
		 }
		 if(document.getElementById("sun").checked){
			 aid=aid+6+",";
		 }
		 
		 document.getElementById("txtdaysselected").value=aid;
		  
	}
	
	function funRestrictFillFromDate(){
		 if($('#cmbyear').val()=='' || $('#cmbmonth').val()=='') {
			 $.messager.show({title:'Message',msg:'Year and Month are Mandatory.',showType:'show',style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}});
             return 0;
		 }
		
		  var date = $('#timeSheetFillFromDate').jqxDateTimeInput('val');
		  var day = date.split(".");
		  var restrictedDate = new Date(new Date($('#cmbyear').val(),(parseInt($('#cmbmonth').val())-1),day[0]));
		  $("#timeSheetFillFromDate").jqxDateTimeInput('val', restrictedDate);
	}
	
	function funRestrictFillToDate(){
		 if($('#cmbyear').val()=='' || $('#cmbmonth').val()=='') {
			 $.messager.show({title:'Message',msg:'Year and Month are Mandatory.',showType:'show',style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}});
            return 0;
		 }
		
		  var date = $('#timeSheetFillToDate').jqxDateTimeInput('val');
		  var day = date.split(".");
		  var restrictedDate = new Date(new Date($('#cmbyear').val(),(parseInt($('#cmbmonth').val())-1),day[0]));
		  $("#timeSheetFillToDate").jqxDateTimeInput('val', restrictedDate);
	}
	
	function funUpdate(){
	    
		$("#overlay, #PleaseWait").show();
		
	    var rows = $("#timeSheetFillSearchGridId").jqxGrid('getrows');
	    
	    var selectedrows = $("#timeSheetFillSearchGridId").jqxGrid('selectedrowindexes');
	    selectedrows = selectedrows.sort(function(a,b){return a - b});
	 
		var n=0;
	    for (var m = 0; m < rows.length; m++) {
	       
	    	if(selectedrows[n]==m){
	    		
		        var rr=$("#timeSheetDetailsGridID").jqxGrid('getrows');
          	    
		        $('#timeSheetDetailsGridID').jqxGrid('setcellvalue',rr.length-1,"date",rows[m].date);
		        $('#timeSheetDetailsGridID').jqxGrid('setcellvalue',rr.length-1,"empid",rows[m].empid);
		        $('#timeSheetDetailsGridID').jqxGrid('setcellvalue',rr.length-1,"empname",rows[m].empname);
		        $('#timeSheetDetailsGridID').jqxGrid('setcellvalue',rr.length-1,"empdocno",rows[m].empdocno);
		        $('#timeSheetDetailsGridID').jqxGrid('setcellvalue',rr.length-1,"costgroup",rows[m].costgroup);
		        $('#timeSheetDetailsGridID').jqxGrid('setcellvalue',rr.length-1,"costtype",rows[m].costtype);
		        $('#timeSheetDetailsGridID').jqxGrid('setcellvalue',rr.length-1,"costcodename",rows[m].costcodename);
		        $('#timeSheetDetailsGridID').jqxGrid('setcellvalue',rr.length-1,"costcode",rows[m].costcode); 
		        $('#timeSheetDetailsGridID').jqxGrid('setcellvalue',rr.length-1,"intime",rows[m].intime);
		        $('#timeSheetDetailsGridID').jqxGrid('setcellvalue',rr.length-1,"outtime",rows[m].outtime);
		        $('#timeSheetDetailsGridID').jqxGrid('setcellvalue',rr.length-1,"othrs",rows[m].othrs);
		        $('#timeSheetDetailsGridID').jqxGrid('setcellvalue',rr.length-1,"hothrs",rows[m].hothrs);
		        $('#timeSheetDetailsGridID').jqxGrid('setcellvalue',rr.length-1,"hrs",rows[m].hrs);
		        $('#timeSheetDetailsGridID').jqxGrid('setcellvalue',rr.length-1,"costperhour",rows[m].costperhour);
		        
		        $("#timeSheetDetailsGridID").jqxGrid('addrow', null, {"date": ""+$('#date').val()+"","empid": ""+$('#txtemployeeid').val()+"","empname": ""+$('#txtemployeename').val()+"","costtype": ""+$('#txtprojecttypeid').val()+"","costgroup": ""+$('#txtprojecttype').val()+"","costcodename": ""+$('#txtprojectidname').val()+"","costcode": ""+$('#txtprojectid').val()+"","hrs": "","empdocno": ""+$('#txtemployeedocno').val(),"costperhour": ""+$('#txtemployeecostperhour').val()+""});
		        
		        n++; 
	    	}
	    }
	    
	    $("#overlay, #PleaseWait").hide();
	    $('#txtfillbtnclick').val('0');
	    $('#schserchinfowindow').jqxWindow('close');
	}	

	function funSetFillGrid(){
		
		var fillfromdate=$("#timeSheetFillFromDate").val();
		var filltodate=$("#timeSheetFillToDate").val();
		var daysselected=$("#txtdaysselected").val();
		var selectedempdocnos=$("#txtselectedempdocnos").val();
		var selectedcosttypename=$("#txtselectedcosttypename").val();
		var selectedcosttypeid=$("#txtselectedcosttypeid").val();
		var selectedcostid=$("#txtselectedcostid").val();
		var selectedcostiddocno=$("#txtselectedcostiddocno").val();
		var fillnormalhrs=$("#timeSheetFillNormalHrs").val();
		var fillothrs=$("#timeSheetFillOTHrs").val();
		var fillhothrs=$("#timeSheetFillHOTHrs").val();
		var intime=$('#timeSheetFillInTime').jqxDateTimeInput('val');
  		var outtime=$('#timeSheetFillOutTime').jqxDateTimeInput('val');
  		
  		if(document.getElementById("chcknormal").checked==false){
  			if((typeof(intime) == "undefined" || typeof(intime) == "NaN" || intime == "" || intime == "00:00") && (typeof(outtime) != "undefined" && typeof(outtime) != "NaN" && outtime != "" && outtime != "00:00")){
  				$.messager.show({title:'Message',msg:'In Time is required for Normal Hours.',showType:'show',style:{left:27,right:'',top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}});
   			 	return 0;
  			}
  			
  			if((typeof(intime) != "undefined" && typeof(intime) != "NaN" && intime != "" && intime != "00:00") && (typeof(outtime) == "undefined" || typeof(outtime) == "NaN" || outtime == "" || outtime == "00:00")){
  				$.messager.show({title:'Message',msg:'Out Time is required for Normal Hours.',showType:'show',style:{left:27,right:'',top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}});
   			 	return 0;
  			}
  			var startDate = new Date($('#timeSheetFillInTime').jqxDateTimeInput('val', 'date'));
  			var endDate = new Date($('#timeSheetFillOutTime').jqxDateTimeInput('val', 'date'));
            if(Date.parse(endDate) < Date.parse(startDate)){
            	$.messager.show({title:'Message',msg:'Out time should be greater than in time',showType:'show',style:{left:27,right:'',top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}});
				return 0;
            }
  			
  			
  		}
  		
		$("#overlay, #PleaseWait").show();
		$("#refsearch").load("timeSheetFillSearchGrid.jsp?fillfromdate="+fillfromdate+"&filltodate="+filltodate+"&daysselected="+daysselected+"&selectedempdocnos="+selectedempdocnos+"&selectedcosttypename="+selectedcosttypename.replace(/ /g, "%20")+"&selectedcosttypeid="+selectedcosttypeid+"&selectedcostid="+selectedcostid.replace(/ /g, "%20")+"&selectedcostiddocno="+selectedcostiddocno+"&fillintime="+intime+"&fillouttime="+outtime+"&fillnormalhrs="+fillnormalhrs+"&fillothrs="+fillothrs+"&fillhothrs="+fillhothrs+"&gridload=1");
		
	}
	
	function funNormalHours(){
		
		var intime=$('#timeSheetFillInTime').jqxDateTimeInput('val');
  		var outtime=$('#timeSheetFillOutTime').jqxDateTimeInput('val');
  		
  		if((typeof(intime) != "undefined" && typeof(intime) != "NaN" && intime != "" && intime != "00:00") && typeof(outtime) != "undefined" && typeof(outtime) != "NaN" && outtime != "" && outtime != "00:00"){
  			
		var startDate = new Date($('#timeSheetFillInTime').jqxDateTimeInput('val', 'date'));
		var endDate = new Date($('#timeSheetFillOutTime').jqxDateTimeInput('val', 'date'));
        
        if(Date.parse(endDate) < Date.parse(startDate)){
        	//endDate = new Date(endDate.setDate(endDate.getDate() + 1));
        }
        
        var hours1 = (endDate.getTime() - startDate.getTime()) / (1000 * 60);
        /* var newhours = parseFloat(hours1/60).toFixed(0); this function rounds to nearest integer ,but we need floor
        var newhours1 = ('0' + newhours).slice(-2);
        var newminutes = parseFloat(hours1%60); reason: one hr extra coming 
        var newminutes1 = ('0' + newminutes).slice(-2); */
        
        var newhours = Math.floor(hours1/60);
        var newhours1 = ('0' + newhours).slice(-2);
        var newminutes1 = hours1-(newhours*60);
        var normalHours = new Date("01/01/2017 " + (newhours1+":"+newminutes1+":00"));
        
        $('#timeSheetFillNormalHrs').jqxDateTimeInput('val', normalHours);
        
  		}
	}
	
	function checknormal(){
		 if(document.getElementById("chcknormal").checked==true){
			 document.getElementById("hidchcknormal").value = 1;
			 $('#timeSheetFillInTime').jqxDateTimeInput('val',(new Date("01/01/2017 " + "00:00:00")));
		  	 $('#timeSheetFillOutTime').jqxDateTimeInput('val',(new Date("01/01/2017 " + "00:00:00")));
		  	 $('#timeSheetFillNormalHrs').jqxDateTimeInput('val',(new Date("01/01/2017 " + "00:00:00")));
			 $('#timeSheetFillNormalHrs').jqxDateTimeInput({disabled: false});
			 $('#timeSheetFillInTime').jqxDateTimeInput({disabled: true});
			 $('#timeSheetFillOutTime').jqxDateTimeInput({disabled: true});
		 } else {
			 document.getElementById("hidchcknormal").value = 0;
			 $('#timeSheetFillInTime').jqxDateTimeInput('val',(new Date("01/01/2017 " + "00:00:00")));
		  	 $('#timeSheetFillOutTime').jqxDateTimeInput('val',(new Date("01/01/2017 " + "00:00:00")));
		  	 $('#timeSheetFillNormalHrs').jqxDateTimeInput('val',(new Date("01/01/2017 " + "00:00:00")));
			 $('#timeSheetFillNormalHrs').jqxDateTimeInput({disabled: true});
			 $('#timeSheetFillInTime').jqxDateTimeInput({disabled: false});
			 $('#timeSheetFillOutTime').jqxDateTimeInput({disabled: false});
		 }
	 }
	
</script>
</head>
<body bgcolor="#E0ECF8">
<div id=search>

<%-- <table width="100%">
  <tr>
    <td width="2%" align="right" style="font-size:9px;">From</td>
    <td width="8%"><div id="timeSheetFillFromDate" name="timeSheetFillFromDate" onchange="funRestrictFillFromDate();" value='<s:property value="timeSheetFillFromDate" />'></div></td>
    <td width="17%" rowspan="2">
    <fieldset><legend style="font-size:9px;">Day</legend>
    <table width="100%">
      <tr>
        <td align="center" style="font-size:9px;"><input type="checkbox" id="mon" name="mon"  value="0"  onclick="$(this).attr('value', this.checked ? 0 : 0);daycheck();">Mon</td>
        <td align="center" style="font-size:9px;"><input type="checkbox" id="wed" name="wed"   value="0" onclick="$(this).attr('value', this.checked ? 2 : 0);daycheck();">Wed</td>
        <td align="center" style="font-size:9px;"><input type="checkbox" id="fri" name="fri"   value="0" onclick="$(this).attr('value', this.checked ? 4 : 0);daycheck();">Fri</td>
         <td align="center" style="font-size:9px;"><input type="checkbox" id="sun" name="sun"  value="0" onclick="$(this).attr('value', this.checked ? 6 : 0);daycheck();">Sun</td>
      </tr>
      <tr>
      <td align="center" style="font-size:9px;"><input type="checkbox" id="tue" name="tue"    value="0" onclick="$(this).attr('value', this.checked ? 1 : 0);daycheck();">Tue</td>
      <td align="center" style="font-size:9px;"><input type="checkbox" id="thu" name="thu"   value="0" onclick="$(this).attr('value', this.checked ? 3 : 0);daycheck();">Thu</td>
        
        <td align="center" style="font-size:9px;"><input type="checkbox" id="sat" name="sat"   value="0" onclick="$(this).attr('value', this.checked ? 5 : 0);daycheck();">Sat</td>
        <td>&nbsp;</td>
      </tr>
	</table>
    </fieldset>
    </td>
    <td width="4%" align="right" style="font-size:9px;">Costtype</td>
    <td width="34%"><input type="text" name="txtselectedcosttypename" id="txtselectedcosttypename" placeholder="Press F3 to Search" style="width:80%;height: 20px;" readonly onkeydown="getFillProjectType(event);" value='<s:property value="txtselectedcosttypename"/>'>
    <input type="hidden" name="txtselectedcosttypeid" id="txtselectedcosttypeid" style="width:100%;height: 20px;" readonly value='<s:property value="txtselectedcosttypeid"/>'></td>
    <td width="4%" align="right" style="font-size:9px;">CostId</td>
    <td width="15%"><input type="text" name="txtselectedcostid" id="txtselectedcostid" placeholder="Press F3 to Search" style="width:70%;height: 20px;" readonly onkeydown="getFillProjectId(event);" value='<s:property value="txtselectedcostid"/>'>
    <input type="hidden" name="txtselectedcostiddocno" id="txtselectedcostiddocno" style="width:100%;height: 20px;" readonly value='<s:property value="txtselectedcostiddocno"/>'>
    <input type="hidden" id="txtdaysselected" name="txtdaysselected" style="width:100%;height: 20px;" readonly value='<s:property value="txtdaysselected"/>'/></td>
    <td width="4%" align="right" style="font-size:9px;">Normal</td>
    <td width="6%"><div id="timeSheetFillNormalHrs" name="timeSheetFillNormalHrs" value='<s:property value="timeSheetFillNormalHrs" />'></div></td>
    <td width="6%" align="center"><button class="myButton" type="button" id="btnAdd" name="btnAdd" onclick="funSetFillGrid();">Fill</button></td>
    
  </tr>
  <tr>
    <td align="right" style="font-size:9px;">To</td>
    <td><div id="timeSheetFillToDate" name="timeSheetFillToDate" onchange="funRestrictFillToDate();" value='<s:property value="timeSheetFillToDate" />'></div></td>
    <td align="right" style="font-size:9px;">Employee</td>
    <td><input type="text" name="txtselectedempids" id="txtselectedempids" placeholder="Press F3 to Search" style="width:100%;height: 20px;" readonly  onkeydown="getFillEmployeeId(event);" value='<s:property value="txtselectedempids"/>'>
    <input type="hidden" name="txtselectedempdocnos" id="txtselectedempdocnos" style="width:100%;height: 20px;" readonly value='<s:property value="txtselectedempdocnos"/>'></td>
    <td align="right" style="font-size:9px;">OT</td>
    <td><div id="timeSheetFillOTHrs" name="timeSheetFillOTHrs" value='<s:property value="timeSheetFillOTHrs" />'></div></td>
    <td align="right" style="font-size:9px;">Holiday OT</td>
    <td><div id="timeSheetFillHOTHrs" name="timeSheetFillHOTHrs" value='<s:property value="timeSheetFillHOTHrs" />'></div></td>
    <td align="center"><button class="myButton" type="button" id="btnAdd" name="btnAdd" onclick="funUpdate();">OK</button></td>
  
  </tr>
  <tr>
    <td colspan="10"><div id="refsearch"><jsp:include  page="timeSheetFillSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table> --%>

<table width="100%">
  <tr>
    <td width="2%" align="right" style="font-size:9px;">From</td>
    <td width="1%"><div id="timeSheetFillFromDate" name="timeSheetFillFromDate" onchange="funRestrictFillFromDate();" value='<s:property value="timeSheetFillFromDate" />'></div></td>
    <td width="14%" rowspan="2">
    <fieldset><legend style="font-size:9px;">Day</legend>
    <table width="100%">
      <tr>
        <td align="center" style="font-size:9px;"><input type="checkbox" id="mon" name="mon"  value="0"  onclick="$(this).attr('value', this.checked ? 0 : 0);daycheck();">Mon</td>
        <td align="center" style="font-size:9px;"><input type="checkbox" id="wed" name="wed"   value="0" onclick="$(this).attr('value', this.checked ? 2 : 0);daycheck();">Wed</td>
        <td align="center" style="font-size:9px;"><input type="checkbox" id="fri" name="fri"   value="0" onclick="$(this).attr('value', this.checked ? 4 : 0);daycheck();">Fri</td>
         <td align="center" style="font-size:9px;"><input type="checkbox" id="sun" name="sun"  value="0" onclick="$(this).attr('value', this.checked ? 6 : 0);daycheck();">Sun</td>
      </tr>
      <tr>
      <td align="center" style="font-size:9px;"><input type="checkbox" id="tue" name="tue"    value="0" onclick="$(this).attr('value', this.checked ? 1 : 0);daycheck();">Tue</td>
      <td align="center" style="font-size:9px;"><input type="checkbox" id="thu" name="thu"   value="0" onclick="$(this).attr('value', this.checked ? 3 : 0);daycheck();">Thu</td>
        
        <td align="center" style="font-size:9px;"><input type="checkbox" id="sat" name="sat"   value="0" onclick="$(this).attr('value', this.checked ? 5 : 0);daycheck();">Sat</td>
        <td>&nbsp;</td>
      </tr>
	</table>
    </fieldset>
    </td>
    <td width="4%" align="right" style="font-size:9px;">Costtype</td>
    <td width="32%"><input type="text" name="txtselectedcosttypename" id="txtselectedcosttypename" placeholder="Press F3 to Search" style="width:80%;height: 20px;" readonly onkeydown="getFillProjectType(event);" value='<s:property value="txtselectedcosttypename"/>'>
    <input type="hidden" name="txtselectedcosttypeid" id="txtselectedcosttypeid" style="width:100%;height: 20px;" readonly value='<s:property value="txtselectedcosttypeid"/>'></td>
    <td width="3%" align="right" style="font-size:9px;">CostId</td>
    <td colspan="5"><input type="text" name="txtselectedcostid" id="txtselectedcostid" placeholder="Press F3 to Search" style="width:70%;height: 20px;" readonly onkeydown="getFillProjectId(event);" value='<s:property value="txtselectedcostid"/>'>
      <input type="hidden" name="txtselectedcostiddocno" id="txtselectedcostiddocno" style="width:100%;height: 20px;" readonly value='<s:property value="txtselectedcostiddocno"/>'>
    <input type="hidden" id="txtdaysselected" name="txtdaysselected" style="width:100%;height: 20px;" readonly value='<s:property value="txtdaysselected"/>'/></td>
    <td width="6%" align="right" style="font-size:9px;"><input type="checkbox" id="chcknormal" name="chcknormal" value="" onchange="checknormal();" onclick="$(this).attr('value', this.checked ? 1 : 0)" />Normal
    <input type="hidden" id="hidchcknormal" name="hidchcknormal" style="width:100%;height: 20px;" value='<s:property value="hidchcknormal"/>'/>
    </td>
    <td width="9%"><div id="timeSheetFillNormalHrs" name="timeSheetFillNormalHrs" value='<s:property value="timeSheetFillNormalHrs" />'></div></td>
    <td width="6%" align="center"><button class="myButton" type="button" id="btnAdd" name="btnAdd" onclick="funSetFillGrid();">Fill</button></td>
    
  </tr>
  <tr>
    <td align="right" style="font-size:9px;">To</td>
    <td><div id="timeSheetFillToDate" name="timeSheetFillToDate" onchange="funRestrictFillToDate();" value='<s:property value="timeSheetFillToDate" />'></div></td>
    <td align="right" style="font-size:9px;">Employee</td>
    <td><input type="text" name="txtselectedempids" id="txtselectedempids" placeholder="Press F3 to Search" style="width:100%;height: 20px;" readonly  onkeydown="getFillEmployeeId(event);" value='<s:property value="txtselectedempids"/>'>
    <input type="hidden" name="txtselectedempdocnos" id="txtselectedempdocnos" style="width:100%;height: 20px;" readonly value='<s:property value="txtselectedempdocnos"/>'></td>
    <td align="right" style="font-size:9px;">In</td>
    <td width="7%"><div id="timeSheetFillInTime" name="timeSheetFillInTime" onchange="funNormalHours();" value='<s:property value="timeSheetFillInTime" />'></div></td>
    <td width="2%" align="right" style="font-size:9px;">Out</td>
    <td width="7%"><div id="timeSheetFillOutTime" name="timeSheetFillOutTime" onchange="funNormalHours();" value='<s:property value="timeSheetFillOutTime" />'></div></td>
    <td width="2%" align="right" style="font-size:9px;">OT</td>
    <td width="7%"><div id="timeSheetFillOTHrs" name="timeSheetFillOTHrs" value='<s:property value="timeSheetFillOTHrs" />'></div></td>
    <td align="right" style="font-size:9px;">Holiday OT</td>
    <td><div id="timeSheetFillHOTHrs" name="timeSheetFillHOTHrs" value='<s:property value="timeSheetFillHOTHrs" />'></div></td>
    <td align="center"><button class="myButton" type="button" id="btnAdd" name="btnAdd" onclick="funUpdate();">OK</button></td>
  
  </tr>
  <tr>
    <td colspan="14"><div id="refsearch"><jsp:include  page="timeSheetFillSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>

</div>
</body>
</html>