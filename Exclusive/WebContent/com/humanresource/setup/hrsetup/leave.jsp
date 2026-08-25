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

<%@page import="com.humanresource.setup.hrsetup.leave.ClsLeaveDAO"%>
<% ClsLeaveDAO showDAO = new ClsLeaveDAO(); %>  

<script type="text/javascript">
	$(document).ready(function () {    
	    document.getElementById("formdet").innerText="Leave(LEV)";
		document.getElementById("formdetail").value="Leave";
		document.getElementById("formdetailcode").value="LEV";
		window.parent.formCode.value="LEV";
		window.parent.formName.value="Leave";
		
	    $("#leavedate").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
 
	    $('#abbrevationDetailsWindow').jqxWindow({width: '31%', height: '38%',  maxHeight: '50%' ,maxWidth: '31%' , title: 'Abbreviation Search',position: { x: 600, y: 100 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		$('#abbrevationDetailsWindow').jqxWindow('close'); 
		 
		$('#abbreviation').dblclick(function(){
			abbrevationSearchContent("leaveAbbreviationSearch.jsp");
		});
		
	        var leavedata='<%=showDAO.searchLeave()%>';
             
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'leave1', type: 'String'  },
                          	{name : 'date', type: 'date'  },
                          	{name : 'remarks', type: 'String'  },
                        	{name : 'abbreviation', type: 'String'  }
                          	
                 ],
                  localdata: leavedata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // leavedata called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
    
            $("#leavegrid").jqxGrid(
                    {
                    	width: "100%",
                        source: dataAdapter,
                        showfilterrow: true,
                        filterable: true,
                        selectionmode: 'singlerow',
                        
                        columns: [
		        					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
		        					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '12%',cellsformat:'dd.MM.yyyy' },
		        					{ text: 'Leave',columntype: 'textbox', filtertype: 'input', datafield: 'leave1', width: '30%' },
		        					{ text: 'Abbreviation',columntype: 'textbox', filtertype: 'input', datafield: 'abbreviation', width: '10%' },
		        					{ text: 'Remarks',columntype: 'textbox', filtertype: 'input', datafield: 'remarks', width: '38%' },
        	              ]
                    });
            
           $('#leavegrid').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
           
                document.getElementById("docno").value= $('#leavegrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("leave").value = $("#leavegrid").jqxGrid('getcellvalue', rowindex1, "leave1");
                $("#leavedate").jqxDateTimeInput('val', $("#leavegrid").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("remarks").value = $("#leavegrid").jqxGrid('getcellvalue', rowindex1, "remarks");
                document.getElementById("abbreviation").value=$("#leavegrid").jqxGrid('getcellvalue', rowindex1, "abbreviation"); 
            });   
        });
	
	
	function abbrevationSearchContent(url) {
	    $('#abbrevationDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#abbrevationDetailsWindow').jqxWindow('setContent', data);
		$('#abbrevationDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function funSearchLoad(){
		 changeContent('leavesearch.jsp'); 
	 }
	
	 function getAbbrevation(event){
         var x= event.keyCode;
         if(x==114){
        	 abbrevationSearchContent("leaveAbbreviationSearch.jsp");
         }
         else{}
         }
 
	function funReadOnly() {
		$('#frmleave input').attr('readonly', true);
		$('#leavedate').jqxDateTimeInput({ disabled: true});
		 
		/* 	$('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
	}
	function funRemoveReadOnly() {
		$('#frmleave input').attr('readonly', false);
		$('#abbreviation').attr('readonly', true);
		$('#leavedate').jqxDateTimeInput({ disabled: false});
		$('#docno').attr('readonly', true);
		
		if ($("#mode").val() == "A") {
			 $('#leavedate').val(new Date());
		   }
	}
 
	function setValues() {
		if($('#datehidden').val()){
			$("#leavedate").jqxDateTimeInput('val', $('#datehidden').val());
		}

		if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
		}
		
		 //document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	}
	
 
	     function funNotify(){
	        	if(document.getElementById("leave").value=="") {
	        		document.getElementById("errormsg").innerText=" Enter Leave";
	        		document.getElementById("leave").focus();
	        		return 0;
        		}
	    		return 1;
		}
	     
	     function funFocus(){
	    	 $('#leavedate').jqxDateTimeInput('focus');
	     }
	  
</script>   
 
</head>
<body onLoad="setValues();" >        

<form id="frmleave" action="saveLeave" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp" /> <br/>
 
<fieldset><legend>Leave Details</legend>
<table width="100%">
	<tr><td width="10%" align="right">Date</td>  
    <td width="15%" align="left"><div id="leavedate" name="leavedate" value='<s:property value="leavedate"/>'></div></td>
	<td width="6%" align="right">Leave</td>
	<td width="34%"><input type="text" name="leave" id="leave" style="width:97%;" placeholder="Leave" value='<s:property value="leave"/>'></td>
	<td width="6%" align="right">Abbreviation</td>
	<td width="10%" ><input type="text" name="abbreviation" id="abbreviation" style="width:100%;" placeholder="Press F3 to Search" onkeydown="getAbbrevation(event);" readonly="readonly" value='<s:property value="abbreviation"/>'></td>
	<td width="10%" align="right">Doc No</td>
	<td width="10%"><input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly="readonly" tabindex="-1"></td>
	<td  width="9%" >&nbsp;</td></tr> 
	<tr><td align="right">Remarks</td>
	<td colspan="5"><input type="text" name="remarks" id="remarks" style="width:100%;" placeholder="Remarks" value='<s:property value="remarks"/>' ></td></tr>
</table>
	 
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/> 
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/> 
<input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/> 

</fieldset> 
</form>

<table width="100%">
    <tr><td><div id="leavegrid"></div></td></tr>
</table><br/>
		 
<div id="abbrevationDetailsWindow">
	<div></div>
</div> 	

</body>
</html>