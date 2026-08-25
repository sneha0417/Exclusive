<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<script type="text/javascript">
	$(document).ready(function(){
		
		 $('#btnCreate').attr('disabled', true );$('#btnClose').attr('disabled', true );
		 $('#btnEdit').attr('disabled', true );$('#btnDelete').attr('disabled', true );
		 $('#btnSearch').attr('disabled', true );$('#btnExcel').attr('disabled', true );
		 $('#btnPrint').attr('disabled', true );
		 $('#btnHeaderUpdate').hide();
		 $('#btnHeaderDelete').hide();
		 
		 $('#btnFooterUpdate').hide();
		 $('#btnFooterDelete').hide();
		
		 $("#jqxItacDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 
		 $('#dtypeDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: ' Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#dtypeDetailsWindow').jqxWindow('close');
		 
		 $('#txthdoctype').click(function(){
				document.getElementById("rheader").checked = true;
				document.getElementById("rfooter").checked = false; 
				
				$("#rheader").click();
	     });
		 $('#txtfdoctype').click(function(){
				document.getElementById("rheader").checked = false;
				document.getElementById("rfooter").checked = true;
				
				 
				 $("#rfooter").click();
				
	     });
		 
		 $('#txthdoctype').dblclick(function(){
			  dtypeSearchContent('docTypeGrid.jsp?dtype=1');
	     });
		 
		 $('#txtfdoctype').dblclick(function(){
			  dtypeSearchContent('docTypeGrid.jsp?dtype=2');
	     });
		 
		 $("#rheader").click(function() {
				/* $('#headerdiv').show();
				$('#footerdiv').hide();*/
				$('#txtfdoctype').attr('disabled', true);
				$('#txthdoctype').attr('disabled', false);
				$('#txtfheaderdescription').attr('disabled', true);
				$("#txtfooterdescription").val('');$("#jqxFooter").jqxGrid({ disabled: true});$("#jqxHeader").jqxGrid({ disabled: false});
				$('#txtfooterdescription').attr('disabled', true);$('#btnFooterAdd').attr('disabled', true);$('#btnFooterUpdate').attr('disabled', true);
				$('#btnFooterDelete').attr('disabled', true);$('#txtheaderdescription').attr('disabled', false);$('#btnHeaderAdd').attr('disabled', false);
				$('#btnHeaderUpdate').attr('disabled', false);$('#btnHeaderDelete').attr('disabled', false);
 				document.getElementById("rheader").checked = true;
				document.getElementById("rfooter").checked = false;
				
				
				$("#txtfdoctype").val('');
				$("#txtfheaderdescription").val('');
				
			});
		 
		 $("#rfooter").click(function() {
				/* $('#footerdiv').show();
				$('#headerdiv').hide(); */
				$('#txthdoctype').attr('disabled', true);
				$('#txtfdoctype').attr('disabled', false);
				$('#txtfheaderdescription').attr('disabled', false);
				$("#txtheaderdescription").val('');$("#jqxHeader").jqxGrid({ disabled: true});$("#jqxFooter").jqxGrid({ disabled: false});
				$('#txtheaderdescription').attr('disabled', true);$('#btnHeaderAdd').attr('disabled', true);$('#btnHeaderUpdate').attr('disabled', true);
				$('#btnHeaderDelete').attr('disabled', true);$('#txtfooterdescription').attr('disabled', false);$('#btnFooterAdd').attr('disabled', false);
				$('#btnFooterUpdate').attr('disabled', false);$('#btnFooterDelete').attr('disabled', false);
				document.getElementById("rheader").checked = false;
				document.getElementById("rfooter").checked = true;
				$("#txthdoctype").val('');
				
			});
		 
		 $('#txtfheaderdescription').dblclick(function(){
				var dtype=$("#txtfdoctype").val();
			 dtypeSearchContent('headerSearchGrid.jsp?dtype='+dtype);
	     });
		
		 
    });
	
	function dtypeSearchContent(url) {
	    $('#dtypeDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#dtypeDetailsWindow').jqxWindow('setContent', data);
		$('#dtypeDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function headercheck(){
		$("#hidrheader").val(1);$("#hidrfooter").val('0');$("#txtfooterdescription").val('');$("#jqxFooter").jqxGrid({ disabled: true});$("#jqxHeader").jqxGrid({ disabled: false});
		$('#txtfooterdescription').attr('disabled', true)    ;$('#btnFooterAdd').attr('disabled', true);$('#btnFooterUpdate').attr('disabled', true);
		$('#btnFooterDelete').attr('disabled', true);$('#txtheaderdescription').attr('disabled', false);$('#btnHeaderAdd').attr('disabled', false);
		$('#btnHeaderUpdate').attr('disabled', false);$('#btnHeaderDelete').attr('disabled', false);
		
		$("#txtfdoctype").val('');
		$("#txtfheaderdescription").val('');
		 
	}
	
	function footercheck(){
		$("#hidrfooter").val(2);$("#hidrheader").val('0');$("#txtheaderdescription").val('');$("#jqxHeader").jqxGrid({ disabled: true});$("#jqxFooter").jqxGrid({ disabled: false});
		$('#txtheaderdescription').attr('disabled', true);$('#btnHeaderAdd').attr('disabled', true);$('#btnHeaderUpdate').attr('disabled', true);
		$('#btnHeaderDelete').attr('disabled', true);$('#txtfooterdescription').attr('disabled', false);$('#btnFooterAdd').attr('disabled', false);
		$('#btnFooterUpdate').attr('disabled', false);$('#btnFooterDelete').attr('disabled', false);
		$("#txthdoctype").val('');
	}
	
	function getDtype(event,dtype){
		
        var x= event.keyCode;
        if(x==114){
        	dtypeSearchContent('docTypeGrid.jsp?dtype='+dtype);
        }
        else{
         }
        }
	
	
function getHdtype(event){
		var dtype=$("#txtfdoctype").val();
        var x= event.keyCode;
        if(x==114){
        	dtypeSearchContent('headerSearchGrid.jsp?dtype='+dtype);
        }
        else{
         }
        }
	
	function funReadOnly(){
	
		/* document.getElementById("rheader").checked = true; */
    }
	 function funRemoveReadOnly(){
			if ($("#mode").val() == "A") {
				
				$("#jqxHeader").jqxGrid('clear'); 
				$("#jqxHeader").jqxGrid('addrow', null, {});
				$("#jqxFooter").jqxGrid('clear');
				$("#jqxFooter").jqxGrid('addrow', null, {});
			}
	 }
	 
	 function funSearchLoad(){
		/* changeContent('crvMainSearch.jsp'); */ 
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
	    	$('#jqxItacDate').jqxDateTimeInput('focus'); 	    		
	    }
 
  function funNotify(){
	  
	  
		 var rows = $("#jqxHeader").jqxGrid('getrows');
		 var frows = $("#jqxFooter").jqxGrid('getrows');
		
		   $('#headergridlen').val(rows.length);
		   
		  for(var i=0 ; i < rows.length ; i++){ 
			  
			  var mand=0;
			  var priono=0;
			  
		   newTextBox = $(document.createElement("input"))
		      .attr("type", "dil")
		      .attr("id", "hdrs"+i)
		      .attr("name", "hdrs"+i)
		      .attr("hidden", "true");
		   
		   if (rows[i].mand == true) {
			   mand=1;
			}
		    priono=rows[i].priono;
			
		   if((priono=="" || typeof(priono)=="undefined" || typeof(priono)=="NaN"))
			  {
			   priono=i+1;
			  }
		   
		  
		  newTextBox.val(rows[i].header+" :: "+rows[i].voc_no+" :: "+mand+" :: "+priono);
		  newTextBox.appendTo('form');
		  }
		  
		  
		  $('#footergridlen').val(frows.length);
		 
		  
		  for(var i=0 ; i < frows.length ; i++){ 
			  
			  var mand=0;
			  var priono=0;
			  
		   newTextBox = $(document.createElement("input"))
		      .attr("type", "dil")
		      .attr("id", "fdrs"+i)
		      .attr("name", "fdrs"+i)
		      .attr("hidden", "true");
		   
		   if (frows[i].mand == true) {
			   mand=1;
			}
		   priono=frows[i].priono;
			
		   if((priono=="" || typeof(priono)=="undefined" || typeof(priono)=="NaN"))
			  {
			   priono=i+1;
			  }
		    
		  newTextBox.val(frows[i].footer+" :: "+mand+" :: "+priono);
		  newTextBox.appendTo('form');
		  }
		  
		 document.getElementById("errormsg").innerText="";		 
		 /* Validation Ends*/
    	 return 1;
	} 
  
  function setValues(){
	  
	
	  
	  if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
	  
	  	document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	  	funSetlabel();
	  	 var headVal =0;
		  headVal = $("#headergridlen").val();
		 var indexVal = $("#indexval").val();
		 
		
				 var hdtype = $("#txthdoctype").val();
	            $("#headerGridDiv").load("headerGrid.jsp?dtype="+hdtype);
			
				 var fdtype = $("#txtfdoctype").val();
				 var fhdesc = $("#headerid").val();
				 
	            $("#footerGridDiv").load("footerGrid.jsp?dtype="+fdtype+"&fhdesc="+fhdesc);
			
       }
	
</script>

<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
</style>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmTermsNConditions" action="saveTermsNConditions" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div  class='hidden-scrollbar'>
<table width="100%">
  <tr>
    <td width="4%" align="right">Date</td>
    <td width="29%"><div id="jqxItacDate" name="jqxItacDate" value='<s:property value="jqxItacDate"/>'></div>
    <input type="hidden" id="hidjqxItacDate" name="hidjqxItacDate" value='<s:property value="hidjqxItacDate"/>'/></td>
    <td width="16%" align="right"><input type="radio" id="rheader" name="rcheck" value='<s:property value="0"/>' >Terms&nbsp;
                                  <input type="hidden" id="hidrheader" name="hidrheader" value='<s:property value="hidrheader"/>'/></td>
    <td width="51%" align="left">&nbsp;&nbsp;<input type="radio" id="rfooter" name="rcheck" value='<s:property value="1"/>' >Description
        <input type="hidden" id="hidrfooter" name="hidrfooter" value='<s:property value="hidrfooter"/>'/></td>
  </tr>
</table>
<table width="100%">
  <tr>
    <td width="50%">
    <div id="headerdiv">
<fieldset>
<table width="100%">
<%-- <tr>
    <td align="right">Doc. Type</td>
    <td colspan="2"><input type="text" id="txthdoctype" name="txthdoctype" style="width:25%;" readonly="readonly" placeholder="Press F3 to Search" onkeydown="getDtype(event,1);" value='<s:property value="txthdoctype"/>'/></td>
</tr> --%>
  <tr>   
     <td width="16%" align="right">Doc. Type</td> 
    <td width="67%"><input type="text" id="txthdoctype" name="txthdoctype" readonly="readonly" placeholder="Press F3 to Search" style="width:28%;" onkeydown="getDtype(event,1);" value='<s:property value="txthdoctype"/>'/></td>
    <td width="5%"><button class="myButton" type="button" id="btnHeaderAdd" name="btnHeaderAdd" onclick="$('#mode').val('A');$('#btnSave').mousedown();">Add</button></td>
    <td width="6%"><button class="myButton" type="button" id="btnHeaderUpdate" name="btnHeaderUpdate" onclick="$('#mode').val('E');$('#btnSave').mousedown();">Update</button></td>
    <td width="6%"><button class="myButton" type="button" id="btnHeaderDelete" name="btnHeaderDelete" onclick="$('#btnDelete').mousedown();">Delete</button></td>
  </tr>
  <tr>
    <td colspan="5"><div id="headerGridDiv"><jsp:include page="headerGrid.jsp"></jsp:include></div></td>
  </tr>
  </br>
  </br>
</table></fieldset></div>
</td>
<td width="50%">
<div id="footerdiv">
<fieldset>
<table width="100%"  >
<tr>
    <td align="right">Doc. Type</td>
    <td colspan="4"><input type="text" id="txtfdoctype" name="txtfdoctype" style="width:29%;" readonly="readonly" placeholder="Press F3 to Search" onkeydown="getDtype(event,2);" value='<s:property value="txtfdoctype"/>'/>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Terms
     <input type="text" id="txtfheaderdescription" readonly="readonly" name="txtfheaderdescription" style="width:40%;" placeholder="Press F3 to Search" onkeydown="getHdtype(event);" value='<s:property value="txtfheaderdescription"/>'/></td>
</tr>
  <tr>
     <td width="17%" align="right"><!-- Footer Description --></td>
    <td width="68%"><input type="hidden" id="txtfooterdescription" name="txtfooterdescription" style="width:84%;" value='<s:property value="txtfooterdescription"/>'/></td>
    <td width="5%"><button class="myButton" type="button" id="btnFooterAdd" name="btnFooterAdd" onclick="$('#mode').val('A');$('#btnSave').mousedown();">Add</button></td>
    <td width="6%"><button class="myButton" type="button" id="btnFooterUpdate" name="btnFooterUpdate" onclick="$('#mode').val('E');$('#btnSave').mousedown();">Update</button></td>
    <td width="6%"><button class="myButton" type="button" id="btnFooterDelete" name="btnFooterDelete" onclick="$('#btnDelete').mousedown();">Delete</button></td>
  </tr>
  <tr>
    <td colspan="5"><div id="footerGridDiv"><jsp:include page="footerGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</fieldset></div>
<input type="hidden" id="docno" name="txthidtermsnconditiondocno" value='<s:property value="txthidtermsnconditiondocno"/>'/>
</td></tr></table>
</div>

<input type="hidden" id="headerid" name="headerid"  value='<s:property value="headerid"/>'/>
<input type="hidden" id="indexval" name="indexval"  value='<s:property value="indexval"/>'/>
<input type="hidden" id="headergridlen" name="headergridlen"  value='<s:property value="headergridlen"/>'/>
<input type="hidden" id="footergridlen" name="footergridlen"  value='<s:property value="footergridlen"/>'/>
 <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>		
  <input type="hidden" id="deleted" name="deleted"  value='<s:property value="deleted"/>'/>
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />

</form>
</div>
<div id="dtypeDetailsWindow">
	<div></div><div></div>
</div>
</body>
</html>
