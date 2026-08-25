<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
form label.error {
 color:red;
 font-weight:bold;

}
</style>

<%@page import="com.humanresource.setup.hrsetup.agent.ClsAgentDAO"%>
<% ClsAgentDAO showDAO = new ClsAgentDAO(); %>   

<script type="text/javascript">

	$(document).ready(function () {    
	    document.getElementById("formdet").innerText="Agent(AGT)";
		document.getElementById("formdetail").value="Agent";
		document.getElementById("formdetailcode").value="AGT";
		window.parent.formCode.value="AGT";
		window.parent.formName.value="Agent";
	    
		$("#agentdate").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
	    
	    	var agentdata='<%=showDAO.searchAgent()%>';
 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'agent', type: 'String'  },
                          	{name : 'date', type: 'date'  },
                          	{name : 'remarks', type: 'String'  }
                 ],
               	 localdata: agentdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#agentgrid").jqxGrid(
                    {
                    	width: "100%",
                        source: dataAdapter,
                        showfilterrow: true,
                        filterable: true,
                        selectionmode: 'singlerow',

                        columns: [
        					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
        					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '12%',cellsformat:'dd.MM.yyyy' },
        					{ text: 'Agent',columntype: 'textbox', filtertype: 'input', datafield: 'agent', width: '38%' },
        					{ text: 'Remarks',columntype: 'textbox', filtertype: 'input', datafield: 'remarks', width: '40%' },
        	              ]
                    });

            $('#agentgrid').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                
                document.getElementById("docno").value= $('#agentgrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("agent").value = $("#agentgrid").jqxGrid('getcellvalue', rowindex1, "agent");
                $("#agentdate").jqxDateTimeInput('val', $("#agentgrid").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("remarks").value = $("#agentgrid").jqxGrid('getcellvalue', rowindex1, "remarks");
              
            });   
        });

	function funSearchLoad(){
		 changeContent('agentsearch.jsp'); 
	 }
 
	function funReadOnly() {
		$('#frmagent input').attr('readonly', true);
		$('#agentdate').jqxDateTimeInput({ disabled: true});
		 
		/* 	$('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
	}
	function funRemoveReadOnly() {
		$('#frmagent input').attr('readonly', false);
		$('#agentdate').jqxDateTimeInput({ disabled: false});
		$('#docno').attr('readonly', true);
		
		if ($("#mode").val() == "A") {
			 $('#agentdate').val(new Date());
		   }
	}
 
	function setValues() {
		if($('#datehidden').val()){
			$("#agentdate").jqxDateTimeInput('val', $('#datehidden').val());
		}
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		 //document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		 
	}
	
 
	     function funNotify(){
	          	if(document.getElementById("agent").value=="")
        		{
        		document.getElementById("errormsg").innerText=" Enter Agent	";
        		document.getElementById("agent").focus();
        		return 0;
        		}
	        	
	    		return 1;
		} 
	     function funFocus(){
	    	 $('#agentdate').jqxDateTimeInput('focus');
	     }
	  
</script>  
 
</head>
<body onLoad="setValues();" >
<form id="frmagent" action="saveAgent" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/>
 
<fieldset><legend>Agent Details</legend>  
<table width="100%"  >
	<tr><td width="10%"  align="right">Date</td> 
	<td width="15%" align="left"><div id="agentdate" name="agentdate" value='<s:property value="agentdate"/>'> </div></td>
	<td width="12%" align="right">Agent</td>
	<td width="34%"><input type="text" name="agent" id="agent" style="width:100%;" placeholder="Agent" value='<s:property value="agent"/>'></td>
	<td width="10%" align="right">Doc No</td>
	<td width="10%"><input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly="readonly" tabindex="-1"></td>
	<td  width="9%" >&nbsp;</td></tr> 
	<tr><td align="right">Remarks</td>
	<td colspan="4"><input type="text" name="remarks" id="remarks"  style="width:85.8%;" placeholder="Remarks" value='<s:property value="remarks"/>' ></td></tr>
</table> 

<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/> 
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/> 
<input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/> 
</fieldset> 
</form>

<table width="100%">
    <tr><td><div id="agentgrid"></div></td></tr>
</table><br/>

</body>
</html>