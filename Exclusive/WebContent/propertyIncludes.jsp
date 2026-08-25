<html>
<% String contextPath=request.getContextPath();%>
<head>

<%-- <link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" /> --%>
<link href="<%=contextPath%>/css/jqx.base.css" rel="stylesheet"  type="text/css" />
<link href="<%=contextPath%>/css/table.css" rel="stylesheet" type="text/css" />
<link href="<%=contextPath%>/css/myButton.css" media="screen" rel="stylesheet" type="text/css" /> 
<link href="<%=contextPath%>/css/jqx.mobile.css" media="screen" rel="stylesheet" type="text/css" /> 
<link href="<%=contextPath%>/css/jqx.energyblue.css" media="screen" rel="stylesheet" type="text/css" />  
    <script type="text/javascript" src="<%=contextPath%>/js/jquery-1.11.1.min.js"></script> 
	<script type="text/javascript" src="<%=contextPath%>/js/jqxcore.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/demos.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jqxdatetimeinput.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jqxcalendar.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqxmenu.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jqxtabs.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqxbuttons.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqxscrollbar.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqxgrid.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqxgrid.selection.js"></script> 
    <script type="text/javascript" src="<%=contextPath%>/js/jqxgrid.columnsresize.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqxgrid.edit.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqxgrid.sort.js"></script> 
    <script type="text/javascript" src="<%=contextPath%>/js/jqxgrid.pager.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqxgrid.filter.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jqxgrid.grouping.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqxdata.js"></script> 
    <script type="text/javascript" src="<%=contextPath%>/js/globalize.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqxpanel.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqxlistbox.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqxdropdownlist.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqxcheckbox.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jqxtooltip.js"></script>  
	<script type="text/javascript" src="<%=contextPath%>/js/globalize.js"></script>  
	<script type="text/javascript" src="<%=contextPath%>/js/jqxwindow.js"></script>
  	<script type="text/javascript" src="<%=contextPath%>/js/jqxtree.js"></script>
  	<script type="text/javascript" src="<%=contextPath%>/js/jqxgrid.aggregates.js"></script>
  	<script type="text/javascript" src="<%=contextPath%>/js/jqxexpander.js"></script>
  	<script type="text/javascript" src="<%=contextPath%>/js/jquery.easyui.min.js"></script>
	
	<script type="text/javascript" src="<%=contextPath%>/js/jqxdatatable.js"></script>
  	<script type="text/javascript" src="<%=contextPath%>/js/jqxtreegrid.js"></script>
	
	<%-- <script type="text/javascript" src="<%=contextPath%>/js/alert/jquery-1.4.4.min.js"></script> 
	<script type="text/javascript" src="<%=contextPath%>/js/alert/jquery.easyui.min.js"></script>--%>
	
	<script type="text/javascript" src="<%=contextPath%>/js/jqxchart.core.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jqxdraw.js"></script>
	<%--<script type="text/javascript" src="<%=contextPath%>/js/jqxslider.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jqxradiobutton.js"></script> --%>
	
    <link rel="stylesheet" type="text/css" href="<%=contextPath%>/css/easyui.css">
    <link rel="stylesheet" type="text/css" href="<%=contextPath%>/css/icon.css">
  	
  	<script type="text/javascript" src="<%=contextPath%>/js/additional-methods.min.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jquery.validate.min.js"></script>
	
	<script type="text/javascript" src="<%=contextPath%>/js/pace.min.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jqxdata.export.js"></script> 
	<script type="text/javascript" src="<%=contextPath%>/js/jqxgrid.export.js"></script> 
	<script type="text/javascript" src="<%=contextPath%>/js/jqxinput.js"></script>   
	<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>   
	<script type="text/javascript" src="<%=contextPath%>/js/exportExcel.js"></script>       
	<script type="text/javascript">
	<%--  
	function getformbranch(){
	
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				 	var items= x.responseText.trim();
				 	if(parseInt(items)==0)
			 		{
			 		 
			 		
			 		// $.messager.alert('Message','Your Secure Session Has Expired ,Please Login Again.....!','warning');
			 		$.messager.confirm('Confirm', 'Your Secure Session Has Expired ,Please Login Again.....!', function(r){
						if (r){
							window.parent.location.href=<%=contextPath+"/"%>+"login.jsp";
						}
					});
			 		
			 		
			 		 /* window.history.back(); */
			 		 				 		 
			 		Exit();
			 		return 0;
			 		}
		     }
			}
		      x.open("GET", "<%=contextPath%>/sessionset.jsp",true);
		     x.send();
		  
   }
  --%>           
</script> 
</head> 
<body>
</body>
</html>
