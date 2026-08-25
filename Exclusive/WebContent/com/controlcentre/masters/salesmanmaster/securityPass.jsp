<%@page import="com.controlcentre.masters.vehiclemaster.securitypass.ClsSecurityPassDAO" %>
<%ClsSecurityPassDAO DAO1=new ClsSecurityPassDAO(); %>

<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<%
String contextPath=request.getContextPath();
%>
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
<script type="text/javascript">
	$(document).ready(function () {    
	    $("#date").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
	     $("#startdate").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
	      $("#enddate").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
	    document.getElementById("formdet").innerText="Security Pass(SPA)";
		document.getElementById("formdetail").value="Security Pass";
		document.getElementById("formdetailcode").value="SPA";
		window.parent.formCode.value="SPA";
		window.parent.formName.value="Security Pass";
 		
		
		/* Grid starts */
			var spdata='<%=DAO1.searchDetails()%>'; 
            var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'name', type: 'String'  },
                          	{name : 'date', type: 'date'  },
                          	{name : 'startdate', type: 'date'  },
                          	{name : 'enddate', type: 'date'  },
							{name : 'description',type:'string'},
							{name : 'qty',type:'string'},
                 ],
               localdata: spdata,
                //url: "/searchDetails",
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                   // alert(error);    
	                    }
		            }		
            );
    
            $("#jqxSecpassSearch1").jqxGrid(
                    {
                    	width: '100%',
                    	height:350,
                        source: dataAdapter,
                        showfilterrow: true,
                        filterable: true,
                        selectionmode: 'singlerow',
                        //Add row method
                        columns: [
        					{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
        					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
							{ text: 'Name',columntype: 'textbox', filtertype: 'input', datafield: 'name', width: '30%' },
							{ text: 'Description',datafield:'description',width:'50%',columntype: 'textbox', filtertype: 'input'},
							{ text: 'StartDate',columntype: 'textbox', filtertype: 'input', datafield: 'startdate', width: '10%',cellsformat:'dd.MM.yyyy' },
							{ text: 'EndDate',columntype: 'textbox', filtertype: 'input', datafield: 'enddate', width: '10%',cellsformat:'dd.MM.yyyy' },
							{ text: 'Qty',columntype: 'textbox', filtertype: 'input', datafield: 'qty', width: '10%' },
        	              ]
                    });
            $('#jqxSecpassSearch1').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxSecpassSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("name").value = $("#jqxSecpassSearch1").jqxGrid('getcellvalue', rowindex1, "name");
				document.getElementById("description").value = $("#jqxSecpassSearch1").jqxGrid('getcellvalue', rowindex1, "description");
                $("#date").jqxDateTimeInput('val', $("#jqxSecpassSearch1").jqxGrid('getcellvalue', rowindex1, "date"));
                 $("#startdate").jqxDateTimeInput('val', $("#jqxSecpassSearch1").jqxGrid('getcellvalue', rowindex1, "startdate"));
                  $("#enddate").jqxDateTimeInput('val', $("#jqxSecpassSearch1").jqxGrid('getcellvalue', rowindex1, "enddate"));
                  document.getElementById("qty").value= $('#jqxSecpassSearch1').jqxGrid('getcellvalue', rowindex1, "qty");
                $('#window').jqxWindow('close');
                // 
            });  
            
            /* Grid Ends */
        });
	
	
	
	function funSearchLoad(){
		changeContent('securityPassSearch.jsp', $('#window')); 
	 }
	function funReadOnly() {
		$('#frmSecpass input').attr('readonly', true);
		$('#date').jqxDateTimeInput({
			readonly : true
		});
		
		/* 	$('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
	}
	function funRemoveReadOnly() {
		$('#frmSecpass input').attr('readonly', false);
		$('#date').jqxDateTimeInput({
			readonly : false
		});
		$('#docno').attr('readonly', true);
		 if(document.getElementById("mode").value=='A'){
		  $("#startdate").jqxDateTimeInput('setDate', new Date());
	    	 $("#enddate").jqxDateTimeInput('setDate', new Date());
	    	  $("#date").jqxDateTimeInput('setDate', new Date());
		 
		 
		 }
	}
	function setValues() {
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
	}
	
	 $(function(){
	        $('#frmSecpass').validate({
	                 rules: {
	                 name: {
	                	 required:true,
	                	 maxlength:40
	                 }
	                 },
	                 messages: {
	                  name: {
	                	  required:" *",
	                	  maxlength:"max 40 only"
	                  } 
	                 }
	        });});
	     function funNotify(){
	    
	    		return 1;
		} 
	     function funFocus(){
	    	 document.getElementById("name").focus();
	     }
	  function funExcelBtn(){
		  $("#jqxSecpassSearch1").jqxGrid('exportdata', 'xls', 'Brand');
	  }
</script>  
 
</head>
<body onLoad="setValues();" >
<form id="frmSecpass" action="saveSecurityPass" method="get" autocomplete="off">
	<jsp:include page="../../../../header.jsp" />
	<br/> 
	<fieldset><legend>Security Pass Details</legend>
	<table width="100%" border="0">
	  <tr>
	    <td width="6%" align="right">Date</td>
	    <td width="22%"><div id="date" name="date" value='<s:property value="date"/>'></div></td>
	    <td width="6%" align="right">StartDate</td>
	    <td width="22%"><div id="startdate" name="startdate" value='<s:property value="startdate"/>'></div></td>
	    <td width="6%" align="right">EndDate</td>
	    <td width="22%"><div id="enddate" name="enddate" value='<s:property value="enddate"/>'></div></td>
	    <td width="6%" align="right">Doc No.</td>
	    <td width="17%"><input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly  tabindex="-1"></td>
	  </tr>
	  <tr>
	    <td align="right">Name</td>
	    <td><input type="text" name="name" id="name"  value='<s:property value="name"/>' ></td>
	    <td align="right">Description</td>
	    <td colspan="3"><input type="text" name="description" id="description" style="width:92%;" value='<s:property value="description"/>' ></td>
	    <td width="6%" align="right">Qty</td>
	    <td width="15%"><input type="text" name="qty" id="qty"  value='<s:property value="qty"/>' ></td>
	  </tr>
	  <tr>
		<td><input type="hidden" id="mode" name="mode"/></td>
        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
		<td><input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/></td>
	  </tr>
	</table>
	</fieldset>
    	
	</form>
<table width="100%">
      <tr>
        <td align="center"><div id="jqxSecpassSearch1"></div>  </td>
      </tr>
    </table>
<br/>
		
	

</body>
</html>