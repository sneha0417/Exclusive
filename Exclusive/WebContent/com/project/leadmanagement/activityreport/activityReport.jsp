<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<script type="text/javascript">
	$(document).ready(function() {
		
		 $("#activityDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 
		 $('#clientDetailsSearchWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#clientDetailsSearchWindow').jqxWindow('close');  
		 
		 $('#jobDetailsWindow').jqxWindow({width: '50%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Job Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	     $('#jobDetailsWindow').jqxWindow('close');
	});
	
	function clientSearchContent(url) {
		$('#clientDetailsSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#clientDetailsSearchWindow').jqxWindow('setContent', data);
		$('#clientDetailsSearchWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function jobSearchContent(url) {
		$('#jobDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#jobDetailsWindow').jqxWindow('setContent', data);
		$('#jobDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function funactivityconfirm(){
		  
		  $.messager.confirm('Confirm', 'Do you want to confirm?', function(r){
			    if (r){
			    	 $("#mode").val("EDIT");
			    	 document.getElementById("frmActivityReport").submit(); 
			    }
		});
	  }
	
	 function funReadOnly(){
			$('#frmActivityReport input').attr('readonly', true );
			$('#frmActivityReport select').attr('disabled', true);
			$('#activityDate').jqxDateTimeInput({disabled: true});
			$("#activityReportGridID").jqxGrid({ disabled: true});
	 }
	 
	 function funRemoveReadOnly(){
			$('#frmActivityReport input').attr('readonly', false );
			$('#frmActivityReport select').attr('disabled', false);
			
			$('#activityDate').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			$("#activityReportGridID").jqxGrid({ disabled: false}); 
			document.getElementById("lblformusername").innerText='<%=session.getAttribute("USERNAME")%>';
			
			if ($("#mode").val() == "A") {
				$('#activityDate').val(new Date());
				document.getElementById("lblformstatus").innerText='TO BE SUBMITTED';
				$('#lblformstatus').css('color','#FF5733');
				$('#btnactivityconfirm').hide();
				$("#activityReportGridID").jqxGrid('clear');
				$("#activityReportGridID").jqxGrid('addrow', null, {});
			}
			
			if ($("#mode").val() == "E") {
				$("#activityReportGridID").jqxGrid('addrow', null, {});
			}
			
	 }
	 
	 function funSearchLoad(){
		changeContent('earMainSearch.jsp'); 
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
	    	$('#activityDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	   $(function(){
	        $('#frmActivityReport').validate({
	                rules: {
	                lblformusername:"required",
	                txthighlight:{maxlength:500}
	                 },
	                 messages: {
	                 lblformusername:" *",
	                 txthighlight: {maxlength:"    Max 500 chars"}
	                 }
	        });});
	   
	  function funNotify(){	
		  
		  /* Activity Report Grid  Saving*/
  		  var rows = $("#activityReportGridID").jqxGrid('getrows');
  		  var length=0;
		  for(var i=0 ; i < rows.length ; i++){
			    var chk=rows[i].actualhrs;
			    if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != "" && chk != "0"){
  					newTextBox = $(document.createElement("input"))
  				    .attr("type", "dil")
  				    .attr("id", "test"+length)
  				    .attr("name", "test"+length)
  				    .attr("hidden", "true");
  					length=length+1;
  					
  					var intime=$('#activityReportGridID').jqxGrid('getcelltext', i, "intime");
  					var outtime=$('#activityReportGridID').jqxGrid('getcelltext', i, "outtime");
  					var hrs=$('#activityReportGridID').jqxGrid('getcelltext', i, "hrs");
  					var followupdate=$('#activityReportGridID').jqxGrid('getcelltext', i, "followupdate");
  					var clnew="0";
  					if(rows[i].clnew==true){
  						clnew="1";
					}
  					
  				newTextBox.val(intime+":: "+outtime+":: "+hrs+":: "+rows[i].actualhrs+"::"+clnew+":: "+rows[i].cldocno+":: "+rows[i].client+":: "+rows[i].jobtype+":: "+rows[i].jobno+"::"+rows[i].notes+":: "+followupdate+"::"+rows[i].followupnotes);
  				newTextBox.appendTo('form');
  				}
		      }
		      $('#gridlength').val(length);
  	 		   /* Activity Report Grid  Saving Ends*/
  	 		   
				 
	    		return 1;
		} 
	  
	  
	  function setValues(){
		  
		  if($('#hidactivityDate').val()){
				 $("#activityDate").jqxDateTimeInput('val', $('#hidactivityDate').val());
			  }
		  
		  if($('#lblformstatus').text()=='TO BE SUBMITTED' || $('#lblformstatus').val()=='TO BE SUBMITTED'){
				$('#lblformstatus').css('color','#FF5733');$('#btnactivityconfirm').show();
		  } else {
				$('#lblformstatus').css('color','#2ED376');$('#btnactivityconfirm').hide();
				$('#btnEdit').attr('disabled', true );$('#btnDelete').attr('disabled', true );
		  }
		  
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
			
		  var indexVal = document.getElementById("docno").value;
		  if(indexVal>0){
				 var check=1;
	         	 $("#activityReportDiv").load("activityReportGrid.jsp?txtactivitydocno2="+indexVal+"&check="+check);
		  } 
		  
		}
	  
	  function getActivityDateCheck(date){
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText;
	  			    if(parseInt(items)<0){
	  			    	document.getElementById("errormsg").innerText="Transaction restricted. Invalid Date.";
	  	                return 0;
	  			    } else {
	  			    	document.getElementById("errormsg").innerText="";
	  			    }
	  				
	  		}
	  		}
	  		x.open("GET", "getActivityDateCheck.jsp?date="+date, true);
	  		x.send();
	 }
	  
	  function datechange(){
		  getActivityDateCheck($('#activityDate').val());
	  }
	  
</script>

<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
</style>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmActivityReport" action="saveActivityReport" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div  class='hidden-scrollbar'>
<table width="100%">
  <tr>
    <td width="3%" height="42" align="right">Date</td>
    <td width="11%"><div id="activityDate" name="activityDate" onchange="datechange();" onblur="datechange();" value='<s:property value="activityDate"/>'></div>
    <input type="hidden" id="hidactivityDate" name="hidactivityDate" value='<s:property value="hidactivityDate"/>'/></td>
    <td width="21%" align="center"><b><label id="lblformstatus"  name="lblformstatus" style="font-size: 13px;font-family: Tahoma;"><s:property value="lblformstatus"/></label></b>&nbsp;&nbsp;
    <button class="myButton" type="button" id="btnactivityconfirm" name="btnactivityconfirm" onclick="funactivityconfirm();">Confirm</button></td>
    <td width="9%" align="right">User Name :</td>
    <td width="29%"><i><b><label id="lblformusername" name="lblformusername" style="font-size: 13px;font-family: Tahoma;color:#6000FC;"><s:property value="lblformusername"/></label></b></i></td>
    <td width="6%" align="right">Doc No.</td>
    <td width="21%"><input type="text" id="docno" name="txtactivityreportdocno" style="width:50%;" value='<s:property value="txtactivityreportdocno"/>' tabindex="-1"/></td>
  </tr>
  <tr>
  <td align="right">Highlight</td>
  <td colspan="6"><input type="text" id="txthighlight" name="txthighlight" style="width:40%;" value='<s:property value="txthighlight"/>'/></td>
  </tr>
</table>

<div id="activityReportDiv"><jsp:include page="activityReportGrid.jsp"></jsp:include></div>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
</div>
</form>
	
 <div id="clientDetailsSearchWindow">
	<div></div><div></div>
</div> 
<div id="jobDetailsWindow">
	<div></div><div></div>
</div> 
</div>
</body>
</html>
