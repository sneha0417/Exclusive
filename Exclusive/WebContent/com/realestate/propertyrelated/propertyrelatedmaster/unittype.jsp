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
 <%@page import="com.realestate.propertyrelated.propertyrelatedmaster.ClsPropertyRelatedMasterDAO"%>
<%ClsPropertyRelatedMasterDAO DAO= new ClsPropertyRelatedMasterDAO();%> 

<script type="text/javascript">

var data= '<%=DAO.searchunitm() %>';
$(document).ready(function () { 	
	 $('#btnSearch').attr('disabled', true);
	 
	  $('#unitwindow').jqxWindow({ width: '30%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Unit Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	  $('#unitwindow').jqxWindow('close');
	  $("#udate").jqxDateTimeInput({width : '125px',height : '15px',formatString : "dd.MM.yyyy"});
	document.getElementById("formdet").innerText="Unit Type(UNT)";
	document.getElementById("formdetail").value="Unit Type";
	document.getElementById("formdetailcode").value="UNT";
	window.parent.formCode.value="UNT";
	window.parent.formName.value="Unit Type";
    

 
	
	
       var source =
    {
        datatype: "json",
        datafields: [
                  	    {name : 'doc_no' , type: 'number' },
						{name : 'unittype', type: 'String'  },
						{name : 'prtypeid', type:  'String'},
						{name : 'prtype', type:  'String'},
						{name : 'date', type:  'date'},
						
                  	
         ],
         localdata: data,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
            }		
    );
  
    $("#jqxUnitSearch1").jqxGrid(
            {
            	width: '70%',
                height: 337,
                source: dataAdapter,
                showfilterrow: true,
                filterable: true,
                selectionmode: 'singlerow',
         
                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
					 { text: 'Date', datafield: 'date', width: '10%', cellsformat: 'dd.MM.yyyy'  },
						{ text: 'Property type' , datafield: 'prtype',width: '40%'},
					{ text: 'Unit Type'  ,datafield: 'unittype', width: '40%' },
					{ text: 'prtypeid' , datafield: 'prtypeid',width: '30%',hidden:true }
			
					
		 
					
	              ]
            });
    $('#jqxUnitSearch1').on('rowdoubleclick', function (event) 
    		{ 
            	var rowindex1=event.args.rowindex;
                
             	if ($("#mode").val() != "A") 
             		
             		{
                document.getElementById("docno").value= $('#jqxUnitSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("unit").value = $("#jqxUnitSearch1").jqxGrid('getcellvalue', rowindex1, "unittype");
                document.getElementById("prtypeid").value = $("#jqxUnitSearch1").jqxGrid('getcellvalue', rowindex1, "prtypeid");
                document.getElementById("prtype").value = $("#jqxUnitSearch1").jqxGrid('getcellvalue', rowindex1, "prtype");
                
                
                
                $("#udate").jqxDateTimeInput('val', $("#jqxUnitSearch1").jqxGrid('getcellvalue', rowindex1, "date")); 
             		}
    		 });
    
    
	 $('#prtype').dblclick(function(){
		  $('#unitwindow').jqxWindow('open');
			  unitsearchContent('searchptype.jsp');
			  });
});
function getunit(event){
	 var x= event.keyCode;
	 if(x==114){
	  		$('#unitwindow').jqxWindow('open');
	  	  unitsearchContent('searchptype.jsp');	 
          
	 } else{}
}
       	 
function unitsearchContent(url) {
     	 $.get(url).done(function (data) {
		 $('#unitwindow').jqxWindow('setContent', data);
     	 }); 
}
function funSearchLoad(){
		 
	 }
	function funReadOnly() {
		$('#frmUnit input').attr('readonly', true)

		
		  $('#udate').jqxDateTimeInput({ disabled: true}); 
	}
	function funRemoveReadOnly() {
		$('#frmUnit input').attr('readonly', false);
		 $('#udate').jqxDateTimeInput({ disabled: false});
		$('#docno').attr('readonly', true);
		$('#prtype').attr('readonly', true);
		
	}
	 function setValues(){	
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
			if($('#hidudate').val()){
				$("#udate").jqxDateTimeInput('val', $('#hidudate').val());
			}
			}
		    function funFocus()
		    {
		    	 
		    		
		    }
 
		     function funNotify(){
				 var prtype = document.getElementById("prtype").value;
				 var unit = document.getElementById("unit").name;
				 

if(prtype=="")
	{
	 document.getElementById("errormsg").innerText="Property typeis required ";
	    
     return 0;
	}
				 

if(unit=="")
	{
	 document.getElementById("errormsg").innerText="Unit Type is required ";
	    
     return 0;
	}
		    		return 1;
			} 
		    
</script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmUnit" action="saveunitt"  autocomplete="off">

<jsp:include page="../../../../header.jsp" /><br/> 
<fieldset>
<!-- <legend>Unit Type</legend> -->
				<table width="100%">
					<tr>
					<td width="5%" align="right">Date</td>
   					 <td width="16%"><div id="udate" name="udate" value='<s:property value="udate"/>'></div></td>
					
						
						<td width="4%" align="right">Doc No</td>
						<td width="42%" align="left"><input type="text" name="docno"  
							value='<s:property value="docno"/>' id="docno"
							readonly="readonly" tabindex="-1"></td>
					</tr>
					<tr>
					
					<td align="right">Property Type</td>
						<td align="left"><input type="text" name="prtype"
							 value='<s:property value="prtype"/>' onkeypress="getunit(event);" readonly="readonly"
							id="prtype"> </td>
					
					<td width="9%" align="right">Unit Type</td>
						<td width="45%" align="left"><input type="text" name="unit"
							value='<s:property value="unit"/>' id="unit" ></td>
					
					
						
						 
					</tr>
				</table>
			</fieldset>
			
			
			<input type="hidden" id="hidudate" name="hidudate"  value='<s:property value="hidudate"/>'/>
			
			<input type="hidden" id="prtypeid" name="prtypeid"  value='<s:property value="prtypeid"/>'/>
			<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="text" name="deleted"  hidden="hidden" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="mode" hidden="hidden" name="mode"/>
</form>
<br/>
<div id="jqxUnitSearch1"></div>
<div id="unitwindow"><div></div></div>

 
	
</div>
</body>
</html>