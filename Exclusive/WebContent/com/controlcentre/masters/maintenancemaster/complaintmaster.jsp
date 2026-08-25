<%@page import="com.controlcentre.masters.maintenancemaster.complaint.ClsComplaintDAO" %>
<%ClsComplaintDAO ccd=new ClsComplaintDAO(); %>
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
	$("#compdate").jqxDateTimeInput({
		width : '125px',
		height : '15px',
		formatString : "dd.MM.yyyy"
	});
	
		document.getElementById("formdet").innerText="Complaint(CMT)";
		document.getElementById("formdetail").value="Complaint";
		document.getElementById("formdetailcode").value="CMT";
		window.parent.formCode.value="CMT";
window.parent.formName.value="Complaint";
    var comdata= '<%=ccd.mainserch() %>';
	             var num = 0; 
            var source =
            {                            
                datatype: "json",
                datafields: [  
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'compname', type: 'String'  },
                        	{name : 'date', type: 'date'  }
          
                 ],
                 localdata: comdata,
                
                
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
            $("#maintearch10").jqxGrid(
            {
                width: '100%',
                height: 315,
                source: dataAdapter,
                sortable: true,
                selectionmode: 'singlerow',

                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '20%' },
					{ text: ' Name', datafield: 'compname', width: '80%' },
					{ text: ' Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy',hidden:true }
					
					]
            });
      

            $('#maintearch10').on('rowselect', function (event) {
                
            	var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#maintearch10').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("compliant").value=$('#maintearch10').jqxGrid('getcellvalue', rowindex1, "compname");
                $("#compdate").jqxDateTimeInput('val',$("#maintearch10").jqxGrid('getcellvalue', rowindex1, "date"));
               
            }); 
            
});
  </script>

<script type="text/javascript">

function funReadOnly(){
	$('#frmcomplaint input').attr('readonly', true );
	 $('#compdate').jqxDateTimeInput({ disabled: true}); 
}
function funRemoveReadOnly(){
	$('#frmcomplaint input').attr('readonly', false );
	//$('#jqxDateTimeInput').jqxDateTimeInput({ disabled: false});
		 $('#compdate').jqxDateTimeInput({ disabled: false}); 
	$('#docno').attr('readonly', true);
}
function funFocus()
{
	document.getElementById("compliant").focus();
		
}
function funSearchLoad(){
	changeContent('complaintmastersearch.jsp'); 
 }
function funNotify(){
	 $('#compdate').jqxDateTimeInput({ disabled: false}); 	
	return 1;
} 

    
    $(function(){
        $('#frmcomplaint').validate({
                	 rules: {
                	
                         compliant:{
                        	required:true,
                        	maxlength:50
                        }
                       
                        },
                         
                         messages: {
                        	 
                        	 compliant:{
                        	 required:"  *   required",
                        	  maxlength:"   Max 50 chars"
                          }
                       
                         
                          }
        });});
    
function setValues()
{
	if($('#compdatehidden').val()){
		$("#compdate").jqxDateTimeInput('val', $('#compdatehidden').val());
	}
   	//$('#prevdate').val($('#prevdatehidden').val()) ;
	if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }

	}
</script>

</head>
<body onload="setValues();"><div id="mainBG" class="homeContent" data-type="background">
<form id="frmcomplaint" action="saveComplaint" autocomplete="off" method="post">
<jsp:include page="../../../../header.jsp" /><br/> 
<fieldset><legend>Compliant Details</legend>
<table width="100%" >
  <tr>
    <td width="12%"><div align="right">Date</div></td> 
    <td colspan="3"><div id="compdate" name="compdate" value='<s:property value="compdate"/>'></div></td>
    <input type="hidden" name="compdatehidden" id="compdatehidden" value='<s:property value="compdatehidden"/>'>
    <td width="9%"><div align="right">Doc No</div></td>
    <td width="24%">
      <input type="text" name="docno" readonly="readonly" id="docno" value='<s:property value="docno"/>'>
   </td>
  </tr>                   
  <tr>
    <td><div align="right">Name</div></td>
    <td width="50%"><input type="text" name="compliant" style="width:50%;" id="compliant" value='<s:property value="compliant"/>'></td>
    
  </tr>

</table>
<input type="hidden" id="mode" name="mode"/>
          <input type="text" name="deleted" id="deleted" value='<s:property value="deleted"/>' hidden="true"/>
          	 <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
          
</fieldset>

			    <table width="100%">
                  <tr>
                    <td width="20%">&nbsp;</td>
                     
                    <td width="60%"><div id="maintearch10" style="position:relative;"></div>
</td>
                    <td width="20%">&nbsp;</td>
                  </tr>
                </table>
               
         
</form>



</div>
</body>
</html>