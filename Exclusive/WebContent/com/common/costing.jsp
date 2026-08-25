<%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/resample.js"></script>
 <% String docNo = request.getParameter("docno")==null?"0":request.getParameter("docno"); %>
 
 <style type="text/css">
 .icon {
	width: 2.5em;
	height: 2em;
	border: none;
	background-color: #E0ECF8;
}
 </style>

<script type="text/javascript">
	$(document).ready(function(){
		
		 $('#costTypeSearchGridWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Type Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costTypeSearchGridWindow').jqxWindow('close');
		 
		 $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Code Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costCodeSearchWindow').jqxWindow('close');
		 
		 $('#txtaccountno').val('');
   		 $('#txtaccounttrno').val('');
   		 $('#txtaccounttranid').val('');
		 funCostingRoundAmt(0.00,"txtaccounttotal");
	});
	
	function costTypeSearchContent(url) {
	    $('#costTypeSearchGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#costTypeSearchGridWindow').jqxWindow('setContent', data);
		$('#costTypeSearchGridWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function costCodeSearchContent(url) {
	    $('#costCodeSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#costCodeSearchWindow').jqxWindow('setContent', data);
		$('#costCodeSearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function funCostingRoundAmt(value,id){
		  var res=parseFloat(value).toFixed(window.parent.amtdec.value);
		  var res1=(res=='NaN'?"0":res);
		  document.getElementById(id).value=res1;  
		 }
	
	function funCostingSave() {
		
		var acno=document.getElementById("txtaccountno").value;
		var trno=document.getElementById("txtaccounttrno").value;
		var tranid=document.getElementById("txtaccounttranid").value;
		var id=document.getElementById("txtaccountid").value; 
		var rows=$('#costingGridID').jqxGrid('getrows');
		var arr=new Array();
		for(var i=0;i<rows.length;i++){
			var chk=$('#costingGridID').jqxGrid('getcellvalue',i,'costtype');
		    if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
		    	var chks=$('#costingGridID').jqxGrid('getcellvalue',i,'costcode');
		    	if(typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != ""){
		    		var chked=$('#costingGridID').jqxGrid('getcellvalue',i,'amount');
		    		if(typeof(chked) != "undefined" && typeof(chked) != "NaN" && chked != ""){
						arr.push($('#costingGridID').jqxGrid('getcellvalue',i,'costtype')+" :: "+$('#costingGridID').jqxGrid('getcellvalue',i,'costcode')+" :: "+(($('#costingGridID').jqxGrid('getcellvalue',i,'amount'))*id)+" :: ");
		    		}
		    	}
		    }
		}
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
		{
			var items= x.responseText.trim();
			if(items=="1"){
				$.messager.show({title:'Message',msg:'Successfully Updated',showType:'show',
                    style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                }); 
				$("#costingGridID").jqxGrid('clear');
	       		$("#costingGridDiv").load("<%=contextPath%>/com/common/costingGrid.jsp?tranid="+$('#txtaccounttranid').val()+'&checks=1');
	       		document.getElementById("costingmsg").innerText="";
			}
			else{
				$.messager.show({title:'Message',msg:'Not Updated',showType:'show',
                    style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                });
			}
			
		}
		else {}
		}
		x.open("GET", "<%=contextPath%>/com/common/saveCosting.jsp?acno="+acno+"&trno="+trno+"&tranid="+tranid+"&gridarray="+arr, true);
		x.send();
	}

	
</script>

<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="80%" align="center">&nbsp;<label id="costingmsg" name="costingmsg" style="color:green;font-weight:bold;"></label>
    <input type="hidden" id="txtaccounttotal" name="txtaccounttotal" style="width:50%;text-align: right;" value='<s:property value="txtaccounttotal"/>'/>
    <input type="hidden" id="txtcostingtotal" name="txtcostingtotal" style="width:50%;text-align: right;" value='<s:property value="txtcostingtotal"/>'/>
    <input type="hidden" id="txtaccounttranid" name="txtaccounttranid" value='<s:property value="txtaccounttranid"/>'/>
    <input type="hidden" id="txtaccounttrno" name="txtaccounttrno" value='<s:property value="txtaccounttrno"/>'/>
    <input type="hidden" id="txtaccountno" name="txtaccountno" value='<s:property value="txtaccountno"/>'/>
    <input type="hidden" id="txtaccountid" name="txtaccountid" value='<s:property value="txtaccountid"/>'/></td>
    <td width="20%" align="center"><button class="icon" id="btnCostingSave" title="Save Changes" onclick="funCostingSave();">
							<img alt="Save Changes" src="<%=contextPath%>/icons/save_new.png">
					</button></td>
  </tr>
  <tr>
    <td colspan="2"><div id="costingAccountGridDiv"><jsp:include page="costingAccountGrid.jsp"></jsp:include></div></td>
  </tr>
  <tr>
    <td colspan="2"><div id="costingGridDiv"><jsp:include page="costingGrid.jsp"></jsp:include></div></td>
  </tr>
</table>

</div>

<div id="costTypeSearchGridWindow">
	<div></div>
</div> 

<div id="costCodeSearchWindow">
	<div></div>
</div> 
</body>
</html>