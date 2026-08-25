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

		  document.getElementById("formdet").innerText="PriceCategory(PCAT)";
   		  document.getElementById("formdetail").value="PriceCategory";
   		  document.getElementById("formdetailcode").value="PCAT";
   		  window.parent.formCode.value="PCAT";
   		  window.parent.formName.value="PriceCategory";
   		  
		});
	
	 
	
	function funReadOnly(){
		$('#frmPriceCategory input').attr('readonly', true );
		$("#jqxPriceCategory").jqxGrid({ disabled: false});
	}
	
	function funRemoveReadOnly(){
		$('#frmPriceCategory input').attr('readonly', false );
		$('#docno').attr('readonly', true);
		$("#jqxPriceCategory").jqxGrid({ disabled: false});
		
		if ($("#mode").val() == "A") {
	        /*$("#jqxNation").jqxGrid('clear');
	        $("#jqxPriceCategory").jqxGrid('addrow', null, {});*/
	        $('#docno').attr('readonly', true);
	        $('#code').attr('readonly', false);
	     }
		
		/* if ($("#mode").val() == "E") {
			$("#jqxNation").jqxGrid('addrow', null, {});
		} */
		
	}
	
	
	function funNotify(){
		
		
		if(document.getElementById("category").value==''){
			document.getElementById("errormsg").innerText="Enter a Category.";
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
<body onLoad="setValues();"><div id="mainBG" class="homeContent" data-type="background">
<form id="frmPriceCategory" action="saveActionPriceCategory" method="post"  autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/> 
<fieldset>
<legend>Price Category</legend>
<table width="100%">
  <tr>
  <td align="right"><label >Price Category</label></td>
	<td width="33%"><input type="text" name="category" id="category" style="width: 200px;" placeholder="Price Category" value='<s:property value="category"/>' style="width:81%;" ></td>
	
	
    <td  align="right">Doc No.</td>
    <td ><input type="text" id="docno" name="docno" value='<s:property value="docno"/>' readonly tabindex="-1"></td>
  </tr>
  
</table>
</fieldset><br/>
 <div id="pricediv"><jsp:include page="priceCategoryGrid.jsp"></jsp:include></div>

<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
 <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
<input type="hidden" name="gridlength" id="gridlength" value='<s:property value="gridlength"/>'>
<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>

</form>


</div>

</body>
</html>

