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

 $(document).ready(function () {
	 $('#customerDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#customerDetailsWindow').jqxWindow('close'); 
	 
	 $('#cldocno').dblclick(function(){
		   
	    	if($('#mode').val()!= "view")
	    		{
		  	  CustomerSearchContent('clientINgridsearch.jsp');
	    		}
	  });
	 
   	 
	});
        

 function getclient(event){
  	 var x= event.keyCode;
    	
  	if($('#mode').val()!="view")
  		{
  		
  	 if(x==114){
  		 CustomerSearchContent('clientINgridsearch.jsp');
  	 
  	 
  	 
  	 }
  	 else{
  		 }
  		}
  	 }  
 	  function CustomerSearchContent(url) {
 		 $('#customerDetailsWindow').jqxWindow('open');
           $.get(url).done(function (data) {
 //alert(data);
         $('#customerDetailsWindow').jqxWindow('setContent', data);

 	}); 
     	}	  
    function funReset(){
		//$('#frmEnquiry')[0].reset(); 
		
	}
	function funReadOnly(){
	
		$('#frmshipping input').attr('readonly', true );
		$('#chkcllient').attr('disabled', true );
		$('#cldocno').attr('disabled', true );
		$('#docno').attr('readonly', true);
	}
	function funRemoveReadOnly(){
		
		$('#frmshipping input').attr('readonly', false );
		 
		$('#chkcllient').attr('disabled', false );
		$('#docno').attr('readonly', true);
		
		if($('#mode').val()=="E")
			{
	 if(document.getElementById("hidechkcllient").value>0)
		{
			$('#chkcllient').attr('disabled', false );
			document.getElementById("chkcllient").checked=true;	
			$('#cldocno').attr('disabled', false );
			document.getElementById("chkcllient").value=1;
		}
	 else
		 {
		 $('#chkcllient').attr('disabled', false );
		 document.getElementById("chkcllient").checked=false;	
		 $('#cldocno').attr('disabled', true );
		 document.getElementById("chkcllient").value=0;
		 }
		 
			}
		
	}

	function funCheck()
	{
		if(document.getElementById("chkcllient").checked==true)
			{
			$('#cldocno').attr('disabled', false );
			$('#cldocno').attr('readonly', true );
			}
		else
			{
			$('#cldocno').attr('disabled', true );
			}
	}
	       
	       
	function funNotify(){

			
		 
	
		   var clname=document.getElementById("clname").value;
			
			if(clname=="")
				{
				document.getElementById("errormsg").innerText=" Name is mandatory";
				 
				return 0;
				}
			else{
				 document.getElementById("errormsg").innerText="";
			}
			 
			  
      return 1;
	} 

	function funChkButton() {
		
	 
	}

	function funSearchLoad(){
		 changeContent('masterSearch.jsp'); 
	}

		
	function funFocus(){
		 
		 
	   
	   
	}

	
	
	 
	 
	function setValues() {
	
	
		 
		if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
	    }
		
	if(document.getElementById("docno").value>0)
		{
		if(document.getElementById("hidechkcllient").value>0)
			{
			$('#chkcllient').attr('disabled', false );
			document.getElementById("chkcllient").checked=true;
			$('#chkcllient').attr('disabled', true );
			}
			 
			else
				{
				document.getElementById("chkcllient").checked=false;
				$('#chkcllient').attr('disabled', true );
				
				}
			 
		}
	
		document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		funSetlabel();
		
		
		
		
		
	}
	
	function hidemsg()
	{
		 document.getElementById("errormsg").innerText="";
		
	}
	

  
</script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmshipping" action="saveShipplingdetails" autocomplete="OFF" >

<jsp:include page="../../../../header.jsp"></jsp:include><br/><br/> 
<fieldset>
  <legend>Shipping Details</legend>
<table width="100%"   >
  <tr>
    <td width="10%" align="right"><input type="checkbox" id="chkcllient" name="chkcllient" value="0" onchange="funCheck();"  onclick="$(this).attr('value', this.checked ? 1 : 0)"  />&nbsp;&nbsp;&nbsp;&nbsp;Name</td>
    <td width="15%"><input type="text" id="cldocno" name="cldocno" style="width:80%;" placeholder="Press F3 To Search"  value='<s:property value="cldocno"/>' onkeydown="getclient(event)" ></td>
    <td colspan="2"><input type="text" id="clname" name="clname" style="width:91%;"   value='<s:property value="clname"/>' ></td>
    <td width="7%" align="right">Doc No</td>
    <td width="25%"><input type="text" id="docno" name="docno" style="width:40%;" tabindex="-1"  value='<s:property value="docno"/>' ></td>
  </tr>
  <tr>
    <td align="right">Shipping Address</td>
    <td colspan="5"><input type="text" id="shipaddress" name="shipaddress"  style="width:60%;"  value='<s:property value="shipaddress"/>' ></td>
  </tr>
  <tr>
    <td align="right">Contact Person</td>
    <td colspan="5"><input type="text" id="contactperson" name="contactperson"  style="width:60%;"    value='<s:property value="contactperson"/>' ></td>
  </tr>
  <tr>
    <td align="right">Telephone</td>
    <td><input type="text" id="shiptelephone" name="shiptelephone"   style="width:95%;"   value='<s:property value="shiptelephone"/>' ></td>
    <td width="5%" align="right">Email</td>
    <td colspan="2"><input type="text" id="shipemail" name="shipemail"   style="width:75.2%;"   value='<s:property value="shipemail"/>' ></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="right" width="5%">MOB</td>
    <td><input type="text" id="shipmob" name="shipmob"   style="width:95%;"   value='<s:property value="shipmob"/>' ></td>
    <td align="right">FAX</td>
    <td colspan="2"><input type="text" id="shipfax"  style="width:75.2%;"  name="shipfax" value='<s:property value="shipfax"/>' ></td>
    <td>&nbsp;</td>
  </tr>
</table>
 
</fieldset>
 
 

<input type="hidden" id="hidechkcllient" name="hidechkcllient" value='<s:property value="hidechkcllient"/>' /> 
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' /> 
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>


</form>

  <div id="customerDetailsWindow">
	   <div ></div>
	</div>
</div>
</body>
</html>