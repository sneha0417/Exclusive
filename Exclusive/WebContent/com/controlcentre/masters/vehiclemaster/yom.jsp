<%@page import="com.controlcentre.masters.vehiclemaster.yom.ClsYomAction" %>
<%ClsYomAction coa=new ClsYomAction(); %>

<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
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
var data= '<%=coa.searchDetails() %>';
$(document).ready(function () { 	
   $("#btnSearch").hide(); 
    $("#btnEdit").hide(); 
     $("#btnDelete").hide(); 
    	document.getElementById("formdet").innerText="YOM(YOM)";
		document.getElementById("formdetail").value="YOM";
		document.getElementById("formdetailcode").value="YOM";
		window.parent.formCode.value="YOM";
		window.parent.formName.value="YOM";
		
     var num = 0; 
    var source =
    {
        datatype: "json",
        datafields: [
                  	{name : 'DOC_NO' , type: 'number' },
						{name : 'yom', type: 'String'  }
                  	
         ],
         localdata: data,
        
        
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

    $("#jqxYomSearch").jqxGrid(
            {
            	width: '70%',
                height: 315,
                source: dataAdapter,
                showfilterrow: true,
                filterable: true,
                selectionmode: 'multiplecellsextended',
                //pagermode: 'default',
                sortable: true,
                //pageable: true,
                altrows:true,
                //Add row method
                columns: [
					{ text: 'Doc No',filtertype: 'number', datafield: 'DOC_NO', width: '40%' },
					{ text: 'YOM',columntype: 'textbox', filtertype: 'input', datafield: 'yom', width: '60%' }
	              ]
            });
    $('#jqxYomSearch').on('rowdoubleclick', function (event) 
    		{ 
    			var rowindex1=event.args.rowindex;
      		 	 document.getElementById("docno").value= $('#jqxYomSearch').jqxGrid('getcellvalue', rowindex1, "DOC_NO"); 
       			 document.getElementById("yom").value = $("#jqxYomSearch").jqxGrid('getcellvalue', rowindex1, "yom");                
    	 		 $('#window').jqxWindow('hide');
    		 }); 
});
function funReadOnly(){
	$('#frmYom input').attr('readonly', true );
	/* $('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
}
function funRemoveReadOnly(){
	$('#frmYom input').attr('readonly', false );
	//$('#jqxDateTimeInput').jqxDateTimeInput({ disabled: false});
	$('#docno').attr('readonly', true);
}
function setValues(){	
   
	 if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }

	}
    function funFocus()
    {
    	document.getElementById("yom").focus();
    		
    }
   
    $(function(){
    	
        $('#frmYom').validate({
                 rules: {
                 color: {
                	 required:true,
                	 maxlength:45
                 }
                 
                 
                 },
                 messages: {
                  color:{
                	  required:" *",
                	  maxlength:"max 45 chars"
                  }
                  
                  
                 }
        });});
     function funNotify(){
    	
    		return 1;
	} 
     function funSearchLoad(){
			changeContent('colorSearch.jsp', $('#window')); 
		 }
     function funExcelBtn(){
		  $("#jqxYomSearch").jqxGrid('exportdata', 'xls', 'YOM');
	  }
</script>
</head>
<body onload="setValues();" >
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmYom" action="saveActionYom" autocomplete="off">
	<jsp:include page="../../../../header.jsp" />
	<br/>  
<fieldset><legend>Yom Details</legend>
<table>
<tr><td width="8%" align="right">Yom</td><td width="62%"><input type="text" name="yom" id="yom" value='<s:property value="yom"/>'></td>
  <td width="14%" align="right">Doc No</td>
  <td width="16%"><input type="text" name="docno"  id="docno" readonly="readonly" value='<s:property value="docno"/>' tabindex="-1"></td>
</tr>
</table>
<br/>
</fieldset>	
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="mode" name="mode"/>
				        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
</form>
<br/>
<div id="jqxYomSearch"></div>
	<%-- <div id="window">
			<div id="windowHeader" class="windowHead">
				<span> <img src="../../../../icons/search_new.png" alt=""
					style="margin-right: 15px" />Search
				</span>
			</div>
			<div id="windowContent" class="windowCont" style="overflow: hidden;">
				<jsp:include page="colorSearch.jsp"></jsp:include>
			</div>
		</div> --%>
	</div>
</body>
</html>