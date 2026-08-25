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
.hidden-scrollbar {
  overflow: auto;
  height: 540px;      
}
#psearch {
background:#FAEBD7;
 
}
     #info{
color: blue;
background-color: transparent;
}
.btn {
  background: #3498db;
  background-image: -webkit-linear-gradient(top, #3498db, #2980b9);
  background-image: -moz-linear-gradient(top, #3498db, #2980b9);
  background-image: -ms-linear-gradient(top, #3498db, #2980b9);
  background-image: -o-linear-gradient(top, #3498db, #2980b9);
  background-image: linear-gradient(to bottom, #3498db, #2980b9);
  -webkit-border-radius: 28;
  -moz-border-radius: 28;
  border-radius: 28px;
  font-family: Arial;
  color: #ffffff;
  font-size: 10px;
  padding: 4px 15px 6px 17px;
  text-decoration: none;
}

.textbox {
    border: 0;
    height: 25px;    
    width: 20%;
    border-radius: 5px;
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
    box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -moz-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-background-clip: padding-box;
    outline: 0;
}  
</style>
<script type="text/javascript">
	$(document).ready(function () {     
		  
      $('#comsearchwndow').jqxWindow({ width: '55%', height: '58%',isModal:true,autoOpen:false,  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	  $('#comsearchwndow').jqxWindow('close');
	  $('#concomsearchwndow').jqxWindow({ width: '55%', height: '58%',isModal:true,autoOpen:false,  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	  $('#concomsearchwndow').jqxWindow('close');
	  
		  document.getElementById("formdet").innerText="TourType(TOUR)";
   		  document.getElementById("formdetail").value="TourType";
   		  document.getElementById("formdetailcode").value="TOUR";
   		  window.parent.formCode.value="TOUR";
   		  window.parent.formName.value="TourType";
   		  
		});
	
	
	 
	
	function funReadOnly(){
		$('#frmTourType input').attr('readonly', true );
		$('#frmTourType input').attr('disabled', true );
		$('#frmTourType select').attr('disabled', true );
		$("#jqxComTerms").jqxGrid({ disabled: true});
	}
	
	function funRemoveReadOnly(){
		$('#frmTourType input').attr('readonly', false );
		$('#frmTourType input').attr('disabled', false );
		$('#frmTourType select').attr('disabled', false );
		$('#docno').attr('readonly', true);
		$("#jqxComTerms").jqxGrid({ disabled: false});
		
		if ($("#mode").val() == "A") {
		 $("#jqxComTerms").jqxGrid('clear');
	     $("#jqxComTerms").jqxGrid('addrow', null, {});
		$("#jqxComTerms").jqxGrid({ disabled: true});
	     /*   $("#jqxTour").jqxGrid('clear');
	        $("#jqxTour").jqxGrid('addrow', null, {});*/
	        $('#docno').attr('readonly', true);
	        $('#name').attr('readonly', false);
	        $('#code').attr('readonly', false);
	     }
		
		/* if ($("#mode").val() == "E") {
			$("#jqxTour").jqxGrid('addrow', null, {});
		} */
		
	}
	
	
	function funNotify(){
		
		document.getElementById("errormsg").innerText="";
		return 1;		
	}
	
		  	 /* Terms */
	  	 function termsSearchContent(url) {
	  			$('#comsearchwndow').jqxWindow('open');
	  	       $.get(url).done(function (data) {
	  	     $('#comsearchwndow').jqxWindow('setContent', data);
	  	    // $('#comsearchwndow').jqxWindow('bringToFront');

	  		}); 
	  	 	} 
	  	function condSearchContent(url) {
	  	//alert("in===");
		$('#concomsearchwndow').jqxWindow('open');
	     $.get(url).done(function (data) {
	   $('#concomsearchwndow').jqxWindow('setContent', data);
	  // $('#comsearchwndow').jqxWindow('bringToFront');

		}); 
		}
	function funChkButton() {
		   /* funReset(); */
		  }
		  
	function setValues() {
		 $("#btnterms").attr('disabled', false );
		  var indexVal1 = document.getElementById("docno").value;  
		 // alert(indexVal1); 
		  var qbrhid=<%=session.getAttribute("BRANCHID")%>;    
		   //alert(ebrhid);        
	 	  $("#comtermsDiv").load("termsGrid.jsp?qbrhid="+qbrhid+"&qotdoc="+indexVal1); 
			if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  } 
				  //alert($('#hidrefund').val());
			if($('#hidrefund').val()!=""){
				    document.getElementById("refund").value=$('#hidrefund').val();
				  }
			if($('#hidtransportation').val()!=""){
			    document.getElementById("transportation").value=$('#hidtransportation').val();
			  }
			var chkprivate=$("#hidchkprivate").val();  
			if(chkprivate>0){                   
				document.getElementById("chkprivate").checked=true;                                          
			}else{
				document.getElementById("chkprivate").checked=false;  
			}	
	}     
	
	function funFocus(){
		document.getElementById("code").focus();
	}
	 function funSave(){
		if($('#btnterms').val()=="Edit" && $('#mode').val()=="view" && $('#docno').val()>0){
			  $("#jqxComTerms").jqxGrid({ disabled: false});
			  var indexVal2 = document.getElementById("docno").value; 
			 
			  var dtype='TOUR';               
			  var qbrhid=<%=session.getAttribute("BRANCHID")%>;    
			 
			  if(indexVal2>0){            
		 			$("#comtermsDiv").load("termsGrid.jsp?qbrhid="+qbrhid+"&qotdoc="+indexVal2);
		 		}               
		 		else{
		 			 $("#comtermsDiv").load("termsGrid.jsp?dtype="+dtype);
		 		}  
			  
		  }
		  if($('#btnterms').val()=="Save" && $('#mode').val()=="view" && $('#docno').val()>0){
			  termsave();
		  }
		  if($('#btnterms').val()=="Edit" && $('#mode').val()=="view" && $('#docno').val()>0){
			  $('#btnterms').val("Save");
		  }
	}
	
	function termsave(){           
		/* terms grid */
		funRemoveReadOnly();
		 $("#overlay, #PleaseWait").show();
			   var priono=0;
			   
			   var rows = $("#jqxComTerms").jqxGrid('getrows');
			   
			   var rowindex=0;
			   for(var i=0;i<rows.length;i++){
				   var voc_no= $.trim(rows[i].voc_no);   
				    priono=rows[i].priorno;
				    $('#prior').val(rows[i].priorno);
				    /* if (($(prior).val()).includes('$')) { $(prior).val($(prior).val().replace(/$/g, ''));};if (($(prior).val()).includes('%')) { $(prior).val($(prior).val().replace(/%/g, ''));};
			    	if (($(prior).val()).includes('^')) { $(prior).val($(prior).val().replace(/^/g, ''));};if (($(prior).val()).includes('`')) { $(prior).val($(prior).val().replace(/`/g, ''));};
			    	if (($(prior).val()).includes('~')) { $(prior).val($(prior).val().replace(/~/g, ''));};if ($(prior).val().indexOf('\'')  >= 0 ) { $(prior).val($(prior).val().replace(/'/g, ''));};
			    	if (($(prior).val()).includes(',')) { $(prior).val($(prior).val().replace(/,/g, ''));}
			     */	if ($(prior).val().indexOf('"') >= 0) { $(prior).val($(prior).val().replace(/["']/g, ''));};
			     /* if (($(prior).val()).match(/\\/g)) { $(prior).val($(prior).val().replace(/\\/g, ''));}; */
			    	priono= $('#prior').val();   
				    
					     if((priono=="" || typeof(priono)=="undefined" || typeof(priono)=="NaN"))
						  {
						   priono=i+1;
						  }
					  
					if(voc_no.trim()!="" && typeof(voc_no)!="undefined" && typeof(voc_no)!="NaN" )
						{
						newTextBox = $(document.createElement("input"))   
					       .attr("type", "dil")
					       .attr("id", "term_test"+i)
					       .attr("name", "term_test"+i)
					       .attr("hidden", "true");
						$('#condition').val(rows[i].conditions);
						/* if (($(condition).val()).includes('$')) { $(condition).val($(condition).val().replace(/$/g, ''));};if (($(condition).val()).includes('%')) { $(condition).val($(condition).val().replace(/%/g, ''));};
				    	if (($(condition).val()).includes('^')) { $(condition).val($(condition).val().replace(/^/g, ''));};if (($(condition).val()).includes('`')) { $(condition).val($(condition).val().replace(/`/g, ''));};
				    	if (($(condition).val()).includes('~')) { $(condition).val($(condition).val().replace(/~/g, ''));};if ($(condition).val().indexOf('\'')  >= 0 ) { $(condition).val($(condition).val().replace(/'/g, ''));};
				    	if (($(condition).val()).includes(',')) { $(condition).val($(condition).val().replace(/,/g, ''));}
				     */	if ($(condition).val().indexOf('"') >= 0) { $(condition).val($(condition).val().replace(/["']/g, ''));};
				     /* if (($(condition).val()).match(/\\/g)) { $(condition).val($(condition).val().replace(/\\/g, ''));}; */
				    	   
						newTextBox.val(rows[i].voc_no+"::"+$('#condition').val()+" :: "+priono+" :: ");  
						
				   newTextBox.appendTo('form');
				   rowindex++;
				   $('#termgridlenght').val(rowindex);
				  
						 }
			   }
			   $('#prior').val('');
				$('#condition').val(''); 
			   document.getElementById("mode").value="SAVE";       
			   document.getElementById("frmTourType").submit();        
				$("#jqxComTerms").jqxGrid({ disabled: true});

	} 
	  function isNumberKey(evt)
       {
          var charCode = (evt.which) ? evt.which : evt.keyCode;
          if (charCode != 46 && charCode > 31 
            && (charCode < 48 || charCode > 57))
             return false;

          return true;
       }
	
	function funSearchLoad(){
		changeContent('tourtypeGrid.jsp'); 
	 }
</script>
</head>
<body onLoad="setValues();"><div id="mainBG" class="homeContent" data-type="background">
<form id="frmTourType" action="saveActionTourType" method="post"  autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/> 
<fieldset>
<legend>Tour Type</legend>
<table width="100%">
<tr>
<td width="30%">
 <table width="40%">         
  <tr>
    <td width="5%"align="right">Code</td>
    <td width="5%"><input type="text" id="code" name="code" style="width: 200px;" placeholder="Code" value='<s:property value="code"/>' ></td>
 </tr>
 <tr>
    <td width="5%" align="right">Name</td>
    <td width="5%"><input type="text" name="name" id="name" style="width: 300px;" placeholder="Name" value='<s:property value="name"/>' ></td>
 </tr>
 <tr>
    <td width="5%" align="right">Description</td>
    <td width="5%"><input type="text" name="desc" id="desc" style="width: 300px;" placeholder="Description" value='<s:property value="desc"/>' ></td>
 </tr>
 <tr>
    <td width="50%" align="left" colspan="2">Refundable<select id="refund" name="refund" value='<s:property value="refund"/>'>
	<option value="1">Yes</option>
	<option value="0">No</option>
	</select>
	<input type="hidden" name="hidrefund" id="hidrefund" value='<s:property value="hidrefund"/>'/>            
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	Transportation<select id="transportation" name="transportation" value='<s:property value="transportation"/>'>
	<option value="1">Yes</option>
	<option value="0">No</option>  
	</select>
	<input type="hidden" name="hidtransportation" id="hidtransportation" value='<s:property value="hidtransportation"/>'/>   
    &nbsp;&nbsp;&nbsp;<input type="checkbox" name="chkprivate" id="chkprivate" value='<s:property value="chkprivate" />' onclick="$(this).attr('value', this.checked ? 1 : 0);">
    <input type="hidden" name="hidchkprivate" id="hidchkprivate" value='<s:property value="hidchkprivate" />'>            
	<label class="branch">Private</label></td>               
 </tr>
 </table>
 </td>
 <td width="30%" align="center">
  
  <table width="50%" >
  <tr>
  <td  width="8%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Min&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Max</td>
  </tr>
  <tr>
  <td width="6%">Child Age&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text"  onkeypress="return isNumberKey(event)"  name="childmin" id="childmin" style="width: 50px;" value='<s:property value="childmin"/>' >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text"  onkeypress="return isNumberKey(event)"  name="childmax" id="childmax" style="width: 50px;" value='<s:property value="childmax"/>' ></td>
  <!-- <td width="8%"></td> -->
  </tr>
  <tr>
  <td width="8%">Height(cm)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text"  onkeypress="return isNumberKey(event)"  name="hghtmin" id="hghtmin" style="width: 50px;" value='<s:property value="hghtmin"/>'>&nbsp;&nbsp;&nbsp;&nbsp;<input type="text"  onkeypress="return isNumberKey(event)"  name="hghtmax" id="hghtmax" style="width: 50px;" value='<s:property value="hghtmax"/>' ></td>
  <%-- <td width="8%"><input type="text" name="desc" id="desc" style="width: 50px;" value='<s:property value="desc"/>' ></td> --%>
  </tr>
  <tr>
  <td width="8%">Weight(kg)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text"  onkeypress="return isNumberKey(event)"  name="wghtmin" id="wghtmin" style="width: 50px;" value='<s:property value="wghtmin"/>' >&nbsp;&nbsp;&nbsp;&nbsp;<input type="text"  onkeypress="return isNumberKey(event)"  name="wghtmax" id="wghtmax" style="width: 50px;" value='<s:property value="wghtmax"/>' ></td>
  <%-- <td width="8%"><input type="text" name="desc" id="desc" style="width: 50px;" value='<s:property value="desc"/>' ></td> --%>
  </tr>
  <tr>
  <td width="8%">Age Restriction&nbsp;&nbsp;<input type="text"  onkeypress="return isNumberKey(event)"  name="agemin" id="agemin" style="width: 50px;" value='<s:property value="agemin"/>' >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text"  onkeypress="return isNumberKey(event)"  name="agemax" id="agemax" style="width: 50px;" value='<s:property value="agemax"/>' ></td>
  <%-- <td width="8%"><input type="text" name="desc" id="desc" style="width: 50px;" value='<s:property value="desc"/>' ></td> --%>
  </tr>
  </table>
  </td>
  <td valign="top" width="12%"  >
  Doc No.<input type="text" id="docno" name="docno" value='<s:property value="docno"/>' readonly tabindex="-1">
</td>
  </tr>
</table>

 </fieldset>
<fieldset>   
<legend>Terms And Conditions</legend>
<table>

<tr><td><input class="btn" type="button" name="btnterms" id="btnterms" value="Edit" onclick="funSave();" /></td></tr>
</table>

<div id="comtermsDiv">

<jsp:include page="termsGrid.jsp"></jsp:include></div>
</fieldset> 

<input type="hidden" name="hidservicedate" id="hidservicedate" value='<s:property value="hidservicedate"/>'>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
 <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
<input type="hidden" name="gridlength" id="gridlength" value='<s:property value="gridlength"/>'>
<input type="hidden" name="termgridlenght" id="termgridlenght" value='<s:property value="termgridlenght"/>'>
<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
<input type="hidden" name="txtcond" id="txtcond" value='<s:property value="txtcond"/>' /> 
<input type="hidden" id="condition" name="condition"  value='<s:property value="condition"/>' />
<input type="hidden" id="prior" name="prior"  value='<s:property value="prior"/>' />               

</form>

<div id="accountWindow">
	<div ></div>
</div>

<div id="nationalityWindow">
   <div></div>
</div>	

<div id="stateWindow">
   <div></div>
</div>
  <div id="comsearchwndow">
   <div></div>
   </div>
   <div id="concomsearchwndow">
   <div></div>
   </div>
</div>

</body>
</html>

