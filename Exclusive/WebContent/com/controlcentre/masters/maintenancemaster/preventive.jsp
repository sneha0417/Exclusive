
<%@page import="com.controlcentre.masters.maintenancemaster.preventive.ClsPreventiveDAO" %>
<%ClsPreventiveDAO cpd=new ClsPreventiveDAO(); %>

<!DOCTYPE html>
<html>
<head>
<%@ taglib prefix="s" uri="/struts-tags" %>
 <s:head/>
 <% String contextPath=request.getContextPath();%>
 
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
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
$(document).ready(function() {
	$("#prevdate").jqxDateTimeInput({
		width : '125px',
		height : '15px',
		formatString : "dd.MM.yyyy"
	});
document.getElementById("deleteimg").style.display="none";
    var data= '<%=cpd.getPreventive() %>';
	             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'id', type: 'String'  },
                          	{name : 'name', type: 'String'  },
                          	{name : 'date',type:'String'},
                          	{name : 'l_chg', type:'number'}
                 ],
                 localdata: data,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                  //  alert(error);    
	                    }
		            }		
            );
            $("#jqxPreventiveSearch1").jqxGrid(
            {
                width: '100%',
                height: 315,
                source: dataAdapter,
                columnsresize: true,
               // pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
               // pagermode: 'default',
                sortable: true,
                //Add row method

                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
					{ text: 'Id', datafield: 'id', width: '50%' },
					{text: 'Type',datafield:'name',width:'50%'},
					{ text: 'Date', datafield: 'date', width: '20%' },
					{ text: 'Charge', datafield: 'l_chg', width: '20%' }
					]
            });
           $("#jqxPreventiveSearch1").jqxGrid('hidecolumn', 'id'); 
          // $("#jqxPreventiveSearch1").jqxGrid('hidecolumn', 'l_chg'); 

            $('#jqxPreventiveSearch1').on('rowselect', function (event) {
                
            	var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxPreventiveSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("maintenanceid").value=$('#jqxPreventiveSearch1').jqxGrid('getcellvalue', rowindex1, "id");
                document.getElementById("maintenancetype").value=$('#jqxPreventiveSearch1').jqxGrid('getcellvalue', rowindex1, "name");
                document.getElementById("lbrchg").value=$('#jqxPreventiveSearch1').jqxGrid('getcellvalue', rowindex1, "l_chg");
                $("#prevdate").jqxDateTimeInput('val',$("#jqxPreventiveSearch1").jqxGrid('getcellvalue', rowindex1, "date"));
               
            }); 
            
});
  </script>

<script type="text/javascript">
function funReset(){
	document.getElementById("frmPreventive").reset();
}
function funReadOnly(){
	$('#frmPreventive input').attr('readonly', true );
	/* $('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
}
function funRemoveReadOnly(){
	$('#frmPreventive input').attr('readonly', false );
	//$('#jqxDateTimeInput').jqxDateTimeInput({ disabled: false});
	$('#docno').attr('readonly', true);
}
function funFocus()
{
	document.getElementById("maintenanceid").focus();
		
}
function funSearchLoad(){
	changeContent('preventiveSearch.jsp', $('#window')); 
 }
function funNotify(){
	
	return 1;
} 
$(function(){
    $('#frmPreventive').validate({
            	 rules: {
                     maintenanceid: {
                    	 required:true,
                    	 maxlength:5
                     },
                     maintenancetype:{
                    	//required:true,
                    	maxlength:45
                    },
                    lbrchg:{
                    	number:true
                    }	
                    	
                    },
                     
                     messages: {
                    	 maintenanceid:{
                    	  required:" *",
                    	  maxlength:"Max 5 chars"
                      },
                      maintenancetype:{
                    	 //required:" *",
                    	  maxlength:"Max 45 chars"
                      },
                    lbrchg:{
                    	  number:"Only numbers allowed"
                      }
                     
                      }
    });});
function setValues()
{
	if($('#prevdatehidden').val()){
		$("#prevdate").jqxDateTimeInput('val', $('#prevdatehidden').val());
	}
   	//$('#prevdate').val($('#prevdatehidden').val()) ;
	if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
	 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";

	}
</script>

</head>
<body onload="funReadOnly();setValues();"><div id="mainBG" class="homeContent" data-type="background">
<form id="frmPreventive" action="saveActionPreventive" autocomplete="off">
	<script>
	window.parent.formName.value="Preventive";
	window.parent.formCode.value="PMT";
</script>
<jsp:include page="../../../../header.jsp" />
<br/> 
<fieldset><legend>Preventive Maintenance Details</legend>
<table width="100%" >
  <tr>
    <td width="12%"><div align="right">Date</div></td>
    <td colspan="3"><div id="prevdate" name="prevdate" value='<s:property value="prevdate"/>'></div></td><input type="hidden" name="prevdatehidden" id="prevdatehidden" value='<s:property value="prevdatehidden"/>'>
    <td width="9%"><div align="right">Doc No</div></td>
    <td width="24%"><span class="homeContent">
      <input type="text" name="docno" readonly="readonly" id="docno" value='<s:property value="docno"/>'>
    </span></td>
  </tr>
  <tr>
    <td><div align="right">Maintenance Id</div></td>
    <td width="13%"><input type="text" name="maintenanceid" id="maintenanceid" value='<s:property value="maintenanceid"/>'></td>
    <td width="11%" align="right"> Maintenance Type </span></td>
    <td width="31%"><input type="text" name="maintenancetype" id="maintenancetype"  style="width:70%;" value='<s:property value="maintenancetype"/>'></td>
    <td><div align="right">Labour Chg</div></td>
    <td><input type="text" name="lbrchg" id="lbrchg" value='<s:property value="lbrchg"/>' ></td>
   
  </tr>

</table>
<input type="hidden" id="mode" name="mode"/>
          <input type="text" name="deleted" id="deleted" value='<s:property value="deleted"/>' hidden="true"/>
          	 <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
          
</fieldset>
 <fieldset>
			    <table width="100%">
                  <tr>
                    <td width="12%">&nbsp;</td>
                     <img src="<%=contextPath%>/icons/docStatus.png" alt="Smiley face" height="42" width="42" id="deleteimg">
                    <td width="55%"><div id="jqxPreventiveSearch1" style="position:relative;"></div>
</td>
                    <td width="33%">&nbsp;</td>
                  </tr>
                </table>
                </fieldset>
               
</form>

<%-- <div id="window">
				<div id="windowHeader" style="background: #81BEF7;">
					<span> <img src="../../../../icons/search_new.png" alt="" style="margin-right: 15px" />Search
					</span>
				</div>
				<div style="overflow: hidden; background: #E0ECF8;" id="windowContent">
					<jsp:include page="preventiveSearch.jsp"></jsp:include>
				</div>
               
</div> --%>

</div>
</body>
</html>