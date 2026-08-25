<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../includes.jsp"></jsp:include>

<script type="text/javascript">
	$(document).ready(function() {
		
    });
	
	
</script>
<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;  
}
</style>

</head>
<body>
<div id="mainBG" class="homeContent" data-type="background" >
<form autocomplete="off">   

 <div id="approvalDataGrid"><jsp:include page="approvalDataGridNew.jsp"></jsp:include></div>
 <input type="hidden" id="formData" />
<input type="hidden" id="formName" />
<input type="hidden" id="formCode" />
</form>
	
</div>
</body>
</html>