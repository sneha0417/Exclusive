<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>

<!DOCTYPE html>
<html>
<head>
<s:head/>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
form label.error {
color:red;
  font-weight:bold;
}

</style>
<script type="text/javascript">
$(document).ready(function () {  
    //Date
    
      $("#date_province").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"}); 
	   document.getElementById("formdet").innerText="Province(PRV)";
		 document.getElementById("formdetail").value="Province";
		 document.getElementById("formdetailcode").value="PRV";
		 window.parent.formCode.value="PRV";
		 window.parent.formName.value="Province";
    });
        function funReadOnly(){
	       $('#frmProvince input').attr('readonly', true );
	       $('#frmProvince select').attr('disabled', true );
	        $('#date_province').jqxDateTimeInput({ disabled: true}); 
        }
        function funRemoveReadOnly(){
	       $('#frmProvince input').attr('readonly', false );
	       $('#frmProvince select').attr('disabled', false );
	       $('#docno').attr('readonly', true );
	       $('#date_province').jqxDateTimeInput({ disabled: false}); 
	      
        }
      
        function funSearchLoad(){
			changeContent('ProvinceSearch.jsp', $('#window')); 
		 }
        function getBranch()
        {
 
        }
       
        function setValues(){
        	
       	 if($('#msg').val()!=""){
    		   $.messager.alert('Message',$('#msg').val());
    		  }

        }
        function funFocus()
        {
        	//document.getElementById("cmbbranchname").focus();
        		
        }
 
         function funNotify(){
        return 1;
    	}
         function checkLocCode(value){
        	 
         }
</script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmProvince" action="saveActionProvince" autocomplete="off" >

	<jsp:include page="../../../../header.jsp" />
	<br/>     
<fieldset >
<table width="50%">
<tr>
  <td width="14%"><div align="right">Date</div></td>
  <td width="30%"><div id="date_province" name="date_province" value='<s:property value="date_province"/>'></div></td>
  <td width="23%"><div align="right">Doc No</div></td>
  <td width="51%"><input type="text" name="docno" value='<s:property value="docno"/>' id="docno" readonly="readonly"  tabindex="-1"></td>
</tr>
  <tr>
    <td width="13%" align="right">Code</td>
    <td width="11%"><input type="text" id="txtprovincecode" name="txtprovincecode" style="width:50%;" value='<s:property value="txtprovincecode"/>' onblur="checkcompid(this.value);"></td>
  </tr>
  <tr>
    <td align="right">Name</td>
    <td colspan="8"><input type="text" id="txtprovincename" name="txtprovincename" style="width:50%;" value='<s:property value="txtprovincename"/>'></td>
  </tr>
 <!--   <tr>
    <td align="right">Type</td>
      <td width="11%"><select name="cmbtype" id="cmbtype" style="width:50%;" value='<s:property value="cmbtype"/>'>
      <option value="">--Select--</option></select>
      </td>-->
</table>
<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>

<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' hidden="true"/>


<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>

<input type="hidden" id="hidcmbbranchname" name="hidcmbbranchname" value='<s:property value="hidcmbbranchname"/>'>
 
<input type="text" name="deleted" id="deleted" value='<s:property value="deleted"/>' hidden="true"/>
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/><br/>
</fieldset>
</form>
		<%-- <div id="window">
			<div id="windowHeader" style="background: #81BEF7;">
				<span> <img src="../../../../icons/search_new.png" alt=""
					style="margin-right: 15px" />Search
				</span>
			</div>
			<div style="overflow: hidden; background: #E0ECF8;"
				id="windowContent">
				<jsp:include page="locationSearch.jsp"></jsp:include>                                                          
			</div>
		</div> --%>
	</div>
</body>
</html>                        