<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<script type="text/javascript">
	$(document).ready(function () {     
		$('#btnExcel').attr({ disabled: true});
		$('#btnSearch').attr({ disabled: true});

		  document.getElementById("formdet").innerText="NationType(NAT)";
   		  document.getElementById("formdetail").value="Nation";
   		  document.getElementById("formdetailcode").value="NAT";
   		  window.parent.formCode.value="NAT";
   		  window.parent.formName.value="Nation";
   		  
		});
	
	 
	
	function funReadOnly(){
		$('#frmNationType input').attr('readonly', true );
		$("#jqxNation").jqxGrid({ disabled: false});
	}
	
	function funRemoveReadOnly(){
		$('#frmNationType input').attr('readonly', false );
		$('#docno').attr('readonly', true);
		$("#jqxNation").jqxGrid({ disabled: false});
		
		if ($("#mode").val() == "A") {
	        /*$("#jqxNation").jqxGrid('clear');
	        $("#jqxNation").jqxGrid('addrow', null, {});*/
	        $('#docno').attr('readonly', true);
	        $('#nation').attr('readonly', false);
	        $('#code').attr('readonly', false);
	     }
		
		/* if ($("#mode").val() == "E") {
			$("#jqxNation").jqxGrid('addrow', null, {});
		} */
		
	}
	
	
	function funNotify(){
		
		
		if(document.getElementById("nation").value==''){
			document.getElementById("errormsg").innerText="Enter a nation.";
			return false;
		}
		
		document.getElementById("errormsg").innerText="";
		return 1;		
	}
	
	
		  
	function setValues() {
	
			 if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  } 
		   
	}
	
	function funFocus(){
		document.getElementById("category").focus();
	}
	
	/* function funSearchLoad(){
		changeContent('staffSearch.jsp'); 
	 } */
	 
	 /*  $(function(){
		    $('#frmStaff').validate({
	            rules: {
	            code: {required:true,maxlength:10},
	            name:{required:true,maxlength:40},
	            txtaccname:{required:true},
	            mail:{email:true}
	            },
	            messages: {
	             code:{required:" *",maxlength:"Max 10 Chars"},
	             name:{required:" *",maxlength:"Max 40 Chars"},
	             txtaccname:{required:" *"},
	             mail:{email:"Not a valid Email."}
	             }
	   });});  */
	 
function getProcess() {
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
				$("select#category").html(optionsbranch);

			} else {}
		}
		x.open("GET","getCategory.jsp", true);
		x.send();
	}
		 
</script>
</head>
<body onLoad="setValues();getProcess();"><div id="mainBG" class="homeContent" data-type="background">
<form id="frmNationType" action="saveActionNationType" method="post"  autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/> 
<fieldset>
<legend>Nation Type</legend>
<table width="100%">
  <tr>
  <td align="right"><label >Price Category</label></td>
	<td align="left"><select name="category" id="category" style="width:50%;" name="category"  value='<s:property value="category"/>'></select></td>
	
	<td align="right">Nation</td>
    <td ><input type="text" name="nation" id="nation" placeholder="Nation" value='<s:property value="nation"/>' style="width:81%;" ></td>
   
    <td  align="right">Doc No.</td>
    <td ><input type="text" id="docno" name="docno" value='<s:property value="docno"/>' readonly tabindex="-1"></td>
  </tr>
  
</table>
</fieldset><br/>
 <div id="nationdiv"><jsp:include page="nationtypeGrid.jsp"></jsp:include></div>

<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
 <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
<input type="hidden" name="gridlength" id="gridlength" value='<s:property value="gridlength"/>'>
<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>

</form>


</div>

</body>
</html>

