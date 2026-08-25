<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<%
	String contextPath = request.getContextPath();
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../includes.jsp"></jsp:include>

<script type="text/javascript">
     
$(document).ready(function () {  
		$("#jqxDate").jqxDateTimeInput({ width: '100%', height: '23px', formatString:"dd.MM.yyyy"});	  	 
	});  
      
	 function funReadOnly(){
		 $('#frmJobmaster input').attr('readonly', true );
	     $('#frmJobmaster select').attr('disabled', true); 
		 $('#jqxDate').jqxDateTimeInput({disabled: true});
	 	 $('#txtjobdesc').attr('disabled', true); 
     }
	 
	 function funRemoveReadOnly(){
			$('#frmJobmaster input').attr('readonly', false );
			$('#frmJobmaster select').attr('disabled', false); 
			$('#jqxDate').jqxDateTimeInput({disabled: false}); 
			$('#vdocno').attr('readonly', true); 
			if ($("#mode").val() == "A") {
				$('#jqxDate').val(new Date()); 
			}
			$('#txtjobdesc').attr('disabled', false);    
	 }
	function funNotify(){	 
		 docno=document.getElementById("docno").value;
		 mode=document.getElementById("mode").value;
		 return 1;
	} 
	 
	 function funSearchLoad(){
			changeContent('jobSearch.jsp'); 
		 }
	 
	 function funFocus()
	    {
	    	$('#jqxDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	 function setValues(){
		
		 if($('#hidjqxDate').val()){ 
			 $("#jqxDate").jqxDateTimeInput('val', $('#hidjqxDate').val());     
		  }
		
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
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
	<div id="mainBG" class="homeContent" data-type="background">
		<form id="frmJobmaster" action="saveJobmaster"
			method="post" autocomplete="off">
			<jsp:include page="../../../header.jsp"></jsp:include><br />
			<div class='hidden-scrollbar'>
				<div class="clearfix"></div>
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-4">
							<div class="col-md-3">Date</div>
							<div class="col-md-4">
								<div id="jqxDate" name="jqxDate" style="height: 23px !important;" value='<s:property value="jqxDate"/>'></div>
								<input type="hidden" id="hidjqxDate" name="hidjqxDate" value='<s:property value="hidjqxDate"/>' /> 
							</div>
							<div class="col-md-5"></div>    
						</div>        
						<div class="col-md-8">
							<div class="col-md-9"></div> 
							<div class="col-md-1">Doc No</div>    
							<div class="col-md-2">
								<input type="text" id="docno" name="docno" style="text-align: right;width:100%;" tabindex="-1" value='<s:property value="docno"/>' /> 
							</div>
						</div>
					</div>
					<div class="row" style="padding-bottom: 1em;">
						<div class="col-md-12">
							<div class="col-md-1">Description</div>        
							<div class="col-md-11">
								<input type="text" id="txtjobdesc" name="txtjobdesc" style="width: 100%;" value='<s:property value="txtjobdesc"/>'/> 
							</div>
						</div>
					</div> 
				</div>
				<input type="hidden" id="mode" name="mode" /> 
				<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>' />    
				<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>' /> 
			</div>
		</form>
	</div>
</body>
</html>