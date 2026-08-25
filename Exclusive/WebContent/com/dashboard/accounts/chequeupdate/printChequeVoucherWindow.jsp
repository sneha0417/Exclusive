 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

<script type="text/javascript">

	$(document).ready(function() {
		$("#bankChqDate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
		
		$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:50%;left:50%;'><img src='../../../../icons/31load.gif'/></div>");
	    
		$('#txtchqbankname').dblclick(function(){
			  accountsSearchContent('accountsDetailsSearch.jsp');
		});
		
		 $('#hidchckunclrchq').val(0);
		 document.getElementById("chckunclrchq").checked = false;
	     $('#txtchqbankname').attr('readonly', true );
	});
	
	function getBankAccount(event){
        var x= event.keyCode;
        if(x==114){
      		accountsSearchContent('accountsDetailsSearch.jsp');
        }
        else{}
        }
	
	function unclrchqcheck(){
		 $("#jqxChqGrid").jqxGrid('clear');	
		 if(document.getElementById("chckunclrchq").checked){
			 document.getElementById("hidchckunclrchq").value = 1;
		 }
		 else{
			 document.getElementById("hidchckunclrchq").value = 0;
		 }
	 }
	
	function funPrintGridLoad(){
		
		var branchval = document.getElementById("cmbbranch").value;
		var fromdate = $('#fromdate').val();
		var todate = $('#todate').val();
		var bankacno = $('#txtchqbankdocno').val();
		var chqno = $('#txtbankchqno').val();
		var chqdate = $('#bankChqDate').val();
		var unclrchq = $('#hidchckunclrchq').val();
		
		if(document.getElementById("txtchqbankdocno").value==""){
			$.messager.show({title:'Message',msg:'Bank Account is Mandatory.',showType:'show',
                style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
            }); 
 			document.getElementById("txtchqbankname").focus();
 			return false;
 		}
		
		var check = 2;
		$("#overlay, #PleaseWait").show();
		
		$("#printGridDiv").load("printChequeGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&bankacno='+bankacno+'&chqno='+chqno+'&chqdate='+chqdate+'&unclrchq='+unclrchq+'&check='+check);
	}
	
	function funGetPrint(){
		document.getElementById("printdocno").value="";
		document.getElementById("printdtype").value="";
		
		if(document.getElementById("txtchqbankdocno").value==""){
 			$.messager.show({title:'Message',msg:'Bank Account is Mandatory.',showType:'show',
                style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
            }); 
 			document.getElementById("txtchqbankname").focus();
 			return false;
 		}
		
		if(document.getElementById("rdomultiple").checked==true){
			
			var rows=$('#jqxChqGrid').jqxGrid('selectedrowindexes');
			for(var i=0;i<rows.length;i++){
				if(i==0){
					document.getElementById("printdocno").value+=$('#jqxChqGrid').jqxGrid('getcellvalue',rows[i],'doc_no');
					document.getElementById("printdtype").value+=$('#jqxChqGrid').jqxGrid('getcellvalue',rows[i],'dtype');
				}
				else{
					document.getElementById("printdocno").value+=","+$('#jqxChqGrid').jqxGrid('getcellvalue',rows[i],'doc_no');
					document.getElementById("printdtype").value+="','"+$('#jqxChqGrid').jqxGrid('getcellvalue',rows[i],'dtype');
				}
			}
			
			if(document.getElementById("txtchqbankdocno").value!="" && document.getElementById("printdocno").value=="" && document.getElementById("printdtype").value==""){
	 			$.messager.show({title:'Message',msg:'Please Choose Cheques.',showType:'show',
	                style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
	            }); 
	 			return false;
	 			
	 		}
		}

		var url=document.URL;
		var reurl=url.split("com");
		var branch='<%=request.getParameter("branch")%>';
	    var win= window.open(reurl[0]+"printMultiPaymentCheques?acno="+document.getElementById("txtchqbankdocno").value+"&docno="+document.getElementById("printdocno").value+"&dtype="+document.getElementById("printdtype").value+"&branch=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	    win.focus();
	    win_voucher.close(); 
	}

</script>

<body>
<div id=search><br/>
<table width="100%">
  <tr>
    <td width="8%" align="right"  style="font-size:9px;">Bank</td>
    <td colspan="2"><input type="text" name="txtchqbankname" id="txtchqbankname" style="width:100%;height:22px;" readonly placeholder="Press F3 to Search" onkeydown="getBankAccount(event);">
    <input type="hidden" name="txtchqbankdocno" id="txtchqbankdocno" style="width:100%;height:20px;">
    <input type="hidden" name="printdocno" id="printdocno" style="width:100%;height:20px;">
	<input type="hidden" name="printdtype" id="printdtype" style="width:100%;height:20px;"></td>
    <td width="16%" align="right">
    <button type="button" name="btnPrintSearch" id="btnPrintSearch" class="myButton" onclick="funPrintGridLoad();">Search</button></td>
     <td width="17%" align="center">
    <button type="button" name="btnGetPrint" id="btnGetPrint" class="myButton" onclick="funGetPrint()">Print</button></td>
  </tr>
  <tr>
    <td align="right"  style="font-size:9px;">Cheque No</td>
    <td width="32%"><input type="text" name="txtbankchqno" id="txtbankchqno" style="width:100%;height:20px;"></td>
    <td width="27%" align="right"  style="font-size:9px;">Cheque Date</td>
    <td><div id="bankChqDate" name="bankChqDate"  value='<s:property value="bankChqDate"/>'></div></td>
    <td align="center"  style="font-size:9px;"><input type="checkbox" id="chckunclrchq" name="chckunclrchq" value="" onchange="unclrchqcheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)">Uncleared Cheque
    <input type="hidden" id="hidchckunclrchq" name="hidchckunclrchq" value='<s:property value="hidchckunclrchq"/>'/></td>
  </tr>
  <tr>
    <td colspan="5"><div id="printGridDiv"><jsp:include page="printChequeGrid.jsp"/></div></td>
  </tr>
</table>
</div>
</body>
</html>