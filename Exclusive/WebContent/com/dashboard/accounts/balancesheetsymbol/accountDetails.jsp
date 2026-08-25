<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<% String contextPath=request.getContextPath();
   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
   String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
   String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
   String accountno = request.getParameter("accdocno")==null?"0":request.getParameter("accdocno").trim();
   String accountname = request.getParameter("name")==null?"0":request.getParameter("name").trim();%>
<html lang="en">
     
<style type="text/css">
        
    .icon {
		width: 2.5em;
		height: 3em;
		border: none;
		background-color: #E0ECF8;
    }
        
</style>

<script type="text/javascript">

	$(document).ready(function () {
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     
	     $("#overlay, #PleaseWait").show();
	});
	
  		   setInterval(function(){ 
  			   
  			 var temp=$("#formsetchecking").val();
  			 
  			 if(parseInt(temp)==2) {
  				 
  			   $("#overlay, #PleaseWait").show();
  			   var branchval='<%=branchval%>';
  			   var fromdate='<%=fromDate%>';
  			   var todate='<%=toDate%>';
  			   var accountno='<%=accountno%>';
  			   var accountname='<%=accountname%>'; 
  			
  			   $("#accountDetailsDiv").load("balanceSheetSymbolAccountDetailsGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&accdocno='+accountno+'&name='+accountname.replace(/ /g, "%20")+'&check=1');

  			   $("#formsetchecking").val('1');
  			   
  			 }
  			 
  			 if($("#formsetchecking").val()==""){
  			 	$("#formsetchecking").val('2');
  			 }
  			 
  		    }, 500);
  	     
		
		 
	
</script>
</head>
<body class='default'>
<button type="button" class="icon" id="excelExport" title="Export current Document to Excel">
<img alt="excelDocument" src="<%=contextPath%>/icons/excel_new.png">
</button>
    <div id="accountDetailsDiv"><jsp:include page="balanceSheetSymbolAccountDetailsGrid.jsp"></jsp:include></div><br/>
    <div id="accountDetailsDetailedDiv"><jsp:include page="balanceSheetSymbolDetailedAccountDetailsGrid.jsp"></jsp:include></div>
    <input type="hidden" id="formsetchecking" name="formsetchecking" style="height:20px;" value='<s:property value="formsetchecking"/>'/>	
</body>
</html>