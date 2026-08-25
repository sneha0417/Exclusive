<%@page import="com.controlcentre.masters.maintenancemaster.maintenance.ClsMaintenanceDAO"%>
<% ClsMaintenanceDAO cmd=new ClsMaintenanceDAO();%>

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
	$("#miandate").jqxDateTimeInput({
		width : '125px',
		height : '15px',
		formatString : "dd.MM.yyyy"
	});
	
	    document.getElementById("formdet").innerText="Maintenance(MAT)";
		document.getElementById("formdetail").value="Maintenance";
		document.getElementById("formdetailcode").value="MAT";
		window.parent.formCode.value="MAT";
		window.parent.formName.value="Maintenance";
    var datas= '<%=cmd.mainserch() %>';
	             var num = 0; 
            var source =
            {                            
                datatype: "json",
                datafields: [  
                          	{name : 'docno' , type: 'number' },
     						{name : 'mtype', type: 'String'  },
                          	{name : 'name', type: 'String'  },
                          	{name : 'date',type:'date'}
          
                 ],
                 localdata: datas,
                
                
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
            $("#maintearch1").jqxGrid(
            {
                width: '100%',
                height: 325,
                source: dataAdapter,
                sortable: true,    
                selectionmode: 'singlerow',
       

                columns: [
					{ text: 'Doc No', datafield: 'docno', width: '15%' },
					{ text: ' Maintenance Type', datafield: 'mtype', width: '35%' },
					{ text: 'Description',datafield:'name',width:'50%' },
					{ text: 'Date', datafield: 'date', width: '20%',cellsformat:'dd.MM.yyyy',hidden:true },
				
					]
            });
      

            $('#maintearch1').on('rowselect', function (event) {
                
            	var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#maintearch1').jqxGrid('getcellvalue', rowindex1, "docno");
                document.getElementById("maintenancetype").value=$('#maintearch1').jqxGrid('getcellvalue', rowindex1, "mtype");
                document.getElementById("desc").value=$('#maintearch1').jqxGrid('getcellvalue', rowindex1, "name");
               
                $("#miandate").jqxDateTimeInput('val',$("#maintearch1").jqxGrid('getcellvalue', rowindex1, "date"));
               
            }); 
            
});
  </script>

<script type="text/javascript">
function funReadOnly(){
	$('#frmmaint input').attr('readonly', true );
	 $('#miandate').jqxDateTimeInput({ disabled: true}); 
}
function funRemoveReadOnly(){
	$('#frmmaint input').attr('readonly', false );
	$('#miandate').jqxDateTimeInput({ disabled: false});
	$('#docno').attr('readonly', true);
}
function funFocus()
{
	document.getElementById("maintenancetype").focus();
		
}
function funSearchLoad(){
	changeContent('mainmasterSearch.jsp'); 
 }
function funNotify(){
	$('#miandate').jqxDateTimeInput({ disabled: false});
	return 1;
} 
$(function(){
    $('#frmmaint').validate({
            	 rules: {
            		 maintenancetype: {
                    	 required:true,
                    	 maxlength:20
                     },
                     desc:{
                    	required:true,
                    	maxlength:45
                    }
                   
                    },
                     
                     messages: {
                    	 maintenancetype:{
                    	  required:" * required",
                    	  maxlength:"  Max 20 chars"
                      },
                      desc:{
                    	 required:" *  required",
                    	  maxlength:"  Max 45 chars"
                      }
                   
                     
                      }
    });});
function setValues()
{
	if($('#miandatehidden').val()){
		$("#miandate").jqxDateTimeInput('val', $('#miandatehidden').val());
	}
   	//$('#prevdate').val($('#prevdatehidden').val()) ;
	if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
	}
</script>

</head>
<body onload="setValues();"><div id="mainBG" class="homeContent" data-type="background">
<form id="frmmaint" action="saveMain" autocomplete="off" method="post">
<jsp:include page="../../../../header.jsp" /><br/> 
<fieldset><legend>Maintenance Details</legend>
<table width="100%" >
  <tr>
    <td width="12%"><div align="right">Date</div></td> 
    <td colspan="3"><div id="miandate" name="miandate" value='<s:property value="miandate"/>'></div></td>
    <input type="hidden" name="miandatehidden" id="miandatehidden" value='<s:property value="miandatehidden"/>'>
    <td width="9%"><div align="right">Doc No</div></td>
    <td width="24%">
      <input type="text" name="docno" readonly="readonly" id="docno" value='<s:property value="docno"/>'>
   </td>
  </tr>                   
  <tr>
    <td><div align="right">Maintenance Type</div></td>
    <td width="30%"><input type="text" name="maintenancetype" id="maintenancetype" value='<s:property value="maintenancetype"/>'></td>
    <td width="11%" align="right"> Description </td>
    <td width="31%"><input type="text" name="desc" id="desc"  style="width:70%;" value='<s:property value="desc"/>'></td>
  
   
  </tr>

</table>
<input type="hidden" id="mode" name="mode"/>
          <input type="text" name="deleted" id="deleted" value='<s:property value="deleted"/>' hidden="true"/>
          	 <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
          
</fieldset>

			    <table width="100%">
                  <tr>
                    <td width="10%">&nbsp;</td>
                     
                    <td width="78%"><div id="maintearch1" style="position:relative;"></div>
</td>
            <td width="10%">&nbsp;</td>
          </tr>
        </table>  
</form>



</div>
</body>
</html>