<%@page import="com.controlcentre.masters.maintenancemaster.garage.ClsGarageDAO" %>
<%ClsGarageDAO cgd=new ClsGarageDAO(); %>


<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>

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
	   $('#accountWindow').jqxWindow({width: '51%', height: '61%',  maxHeight: '61%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
	   $('#accountWindow').jqxWindow('close');
 	   $("#garagedate").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });  

 	    document.getElementById("formdet").innerText="Garage(GRG)";
 		document.getElementById("formdetail").value="Garage";
 		document.getElementById("formdetailcode").value="GRG";
 		window.parent.formCode.value="GRG";
 		window.parent.formName.value="Garage";
    var data2= '<%=cgd.getGarage()%>';

            var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number'},
     						{name : 'code', type: 'String'},
                          	{name : 'name', type: 'String'},
                          	{name : 'date',type:'date'},
                          	{name : 'type', type:'String'},
                          	{name : 'branch', type:'String'},
                          	{name : 'location', type:'String'},
                          	{name : 'acc_no', type:'number'},
                          	{name : 'description', type:'String'}
                 ],
                 localdata: data2,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    //alert(error);    
	                    }
		            }		
            );
            $("#jqxGarageSearch1").jqxGrid(
            {
                width: '100%',
                height: 310,
                source: dataAdapter,
                sortable: true,
                selectionmode: 'singlerow',

                //Add row method
                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
					{ text: 'Code', datafield: 'code', width: '50%',hidden:true },
					{text: 'Name',datafield:'name',width:'40%'},
					{ text: 'Branch', datafield: 'branch', width: '20%' ,hidden:true},
					{ text: 'Location', datafield: 'location', width: '20%' ,hidden:true},
					{ text: 'Date', datafield: 'date', width: '20%',cellsformat:'dd.MM.yyyy' },
					{ text: 'Acc No', datafield: 'acc_no', width: '20%' ,hidden:true},
					{ text: 'Type', datafield: 'type', width: '20%' ,hidden:true},
					{ text: 'Description', datafield: 'description', width:'30%'}
					]
            });

            $('#jqxGarageSearch1').on('rowselect', function (event) {
                
            	var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxGarageSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("garagecode").value=$('#jqxGarageSearch1').jqxGrid('getcellvalue', rowindex1, "code");
                document.getElementById("garagename").value=$('#jqxGarageSearch1').jqxGrid('getcellvalue', rowindex1, "name");
                $('#location').val($("#jqxGarageSearch1").jqxGrid('getcellvalue', rowindex1, "location")) ;
                $('#type').val($("#jqxGarageSearch1").jqxGrid('getcellvalue', rowindex1, "type")) ;
                document.getElementById("txtaccname").value=$('#jqxGarageSearch1').jqxGrid('getcellvalue', rowindex1, "description");
                document.getElementById("txtaccno").value=$('#jqxGarageSearch1').jqxGrid('getcellvalue', rowindex1, "acc_no");
                $("#garagedate").jqxDateTimeInput('val',$("#jqxGarageSearch1").jqxGrid('getcellvalue', rowindex1, "date"));
               
            }); 
       
});
function accountSearchContent(url) {
	  $('#accountWindow').jqxWindow('open');
		 $.get(url).done(function (data) {
			// alert(data);
		$('#accountWindow').jqxWindow('setContent', data);
	}); 
	}
function funSearchdblclick(){
	var url=document.URL;
	var reurl=url.split("com/");
	accountSearchContent(reurl[0]+'com/search/accountsearch/accountsSearchAP.jsp?dtype='+document.getElementById("formdetailcode").value);
}
function funSearchLoad(){
	changeContent('garageSearch.jsp', $('#window')); 
 }
function getAcc(event){
	
   var x= event.keyCode;
   if(x==114){
	   var url=document.URL;
		var reurl=url.split("com/");
		accountSearchContent(reurl[0]+'com/search/accountsearch/accountsSearchAP.jsp?dtype='+document.getElementById("formdetailcode").value);
   }
   else{
    }
   }
  </script>

<script>

function getLocation()
{
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	items= x.responseText;
			
			 	items=items.split('***');
		        var locItems=items[0].split(",");
		        var locnoItems=items[1].split(",");
		        	var optionsloc = '<option value="">--Select--</option>';
		       for ( var i = 0; i < locItems.length; i++) {
		    	   optionsloc += '<option value="' + locnoItems[i] + '">' + locItems[i] + '</option>';
		        }
		       $("select#location").html(optionsloc);
		       
		   	$('#location').val($('#hidlocation').val()) ;
		   	//$('#type').val($('#hidtype').val()) ;

			}
		else
			{
			}
	}
	x.open("GET","getLocation.jsp",true);
	x.send();
	}
</script>
<script type="text/javascript">
function funReadOnly(){
	$('#frmGarage input').attr('readonly', true );
	$('#frmGarage select').attr('disabled', true );
	 $('#garagedate').jqxDateTimeInput({ disabled: true});
	//getLocation();
}
function funRemoveReadOnly(){
	$('#frmGarage input').attr('readonly', false );
	$('#frmGarage select').attr('disabled', false );
	 $('#garagedate').jqxDateTimeInput({ disabled: false});
	$('#docno').attr('readonly', true);
	$('#txtaccname').attr('readonly', true);
}
function funFocus()
{
	document.getElementById("garagecode").focus();
		
}
function funNotify(){
	
	return 1;
} 
$(function(){
    $('#frmGarage').validate({
            	 rules: {
                     garagecode: {
                    	 required:true,
                    	 maxlength:2
                     },
                    garagename:{
                    	required:true,
                    	maxlength:25
                    }    	
                    },
                     
                     messages: {
                    	 garagecode:{
                    	  required:" *",
                    	  maxlength:"Max 2 chars"
                      },
                      garagename:{
                    	 required:" *",
                    	  maxlength:"Max 25 chars"
                      }
                     
                      }
    });});
function setValues()
{
  	$('#location').val($('#hidlocation').val()) ;
   	$('#type').val($('#hidtype').val()) ;
	//$('#accno').val($('#hidaccno').val()) ;
   	if($('#garagedatehidden').val()){
		$("#garagedate").jqxDateTimeInput('val', $('#garagedatehidden').val());
	}
   	if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }

	}
</script>
</head>
<body onLoad="getLocation();setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmGarage" action="saveActionGarage" autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/> 
<fieldset><legend>Garage Details</legend>
<table width="100%" >
 
  <tr>
    <td><div align="right">Date</div></td>
    <td colspan="2"><div id="garagedate" name="garagedate" value='<s:property value="garagedate"/>'></div></td>
    <td><div align="right">Doc No</div></td>
    <td>
      <input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly></td>
  </tr>
  <tr>
    <td><div align="right">Code</div></td>
    <td width="13%"><input type="text" name="garagecode" id="garagecode" value='<s:property value="garagecode"/>'></td>
    <td width="4%"><div align="right">Name</div></td>
    <td><input type="text" name="garagename" id="garagename" value='<s:property value="garagename"/>' ></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><div align="right">
      <div align="right">Type</div>
    </div></td>
    <td><select name="type" id="type" value='<s:property value="type"/>' style="width:90%;">
      <option value="">--Select--</option>
      <option value="E">External</option>
      <option value="O">Own</option>
    </select></td>
    <td align="right">Location</td>
    <td><select name="location" id="location" value='<s:property value="location"/>' style="width:32.5%;">
      <option>----</option>
    </select></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="right">Account</td>
    <td colspan="4"><input type="text" name="txtaccname" id="txtaccname" value='<s:property value="txtaccname"/>' style="width:32%;" ondblclick="funSearchdblclick();" onkeydown="getAcc(event);" placeholder="Press F3 to Search" readonly="readonly"></td>
    <input type="hidden" name="txtaccno" id="txtaccno" value='<s:property value="txtaccno"/>'>
  </tr>
</table>
</fieldset><br/>
	 <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
<input type="hidden" name="hidtype" id="hidtype" value='<s:property value="hidtype"/>'>
<input type="hidden" name="hidlocation" id="hidlocation" value='<s:property value="hidlocation"/>'>
<input type="hidden" name="hidacno" id="hidacno" value='<s:property value="hidacno"/>'>
<input type="hidden" name="hidgaragedate" id="hidgaragedate" value='<s:property value="hidgaragedate"/>'></form>

<div id="jqxGarageSearch1"></div>
 <div id="accountWindow">
				<div></div><div></div>
				</div> </div>
</body>
</html>