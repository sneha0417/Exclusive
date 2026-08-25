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
	    $('#accountSearchwindow').jqxWindow({ width: '50%', height: '54%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
		   $('#accountSearchwindow').jqxWindow('close');
	    $('#acno').dblclick(function(){
	    	//($("#mode").val() == "view")
	    	if($('#mode').val()!= "view")
	    		{
	    	
	    		
		  	    $('#accountSearchwindow').jqxWindow('open');
		  	
		  	  accountSearchContent('accountsDetailsFromGrid.jsp?');
	    		}
	  });
   	 
 
   	 
	});
        

 function getaccountdetails(event){
  	 var x= event.keyCode;
    	
  	if($('#mode').val()!="view")
  		{
  		
  	 if(x==114){
  	  $('#accountSearchwindow').jqxWindow('open');
  	
  	 accountSearchContent('accountsDetailsFromGrid.jsp?');    }
  	 else{
  		 }
  		}
  	 }  
 	  function accountSearchContent(url) {
        //alert(url);
           $.get(url).done(function (data) {
 //alert(data);
         $('#accountSearchwindow').jqxWindow('setContent', data);

 	}); 
     	}	  
    function funReset(){
		//$('#frmEnquiry')[0].reset(); 
		
	}
	function funReadOnly(){
	
		$('#frmexp input').attr('readonly', true );

		$('#docno').attr('readonly', true);
	}
	function funRemoveReadOnly(){
		
		$('#frmexp input').attr('readonly', false );
		$('#acno').attr('readonly', true);
		
		$('#docno').attr('readonly', true);
		
		 
		
		
	}


	       
	       
	function funNotify(){

			
		 
	
		   var petrolchg=document.getElementById("acno").value;
			
			if(petrolchg=="")
				{
				document.getElementById("errormsg").innerText=" Search Account";
				document.getElementById("acno").focus();  
				return 0;
				}
			else{
				 document.getElementById("errormsg").innerText="";
			}
			 
			   var deisal=document.getElementById("desc1").value;
				
				if(deisal=="" )
					{
					document.getElementById("errormsg").innerText=" Enter Description";
					document.getElementById("desc1").focus();  
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
<form id="frmSaleExp" action="saveSaleExp" autocomplete="OFF" >

<jsp:include page="../../../../header.jsp"></jsp:include><br/><br/>
<fieldset>
 <br/>
<br/>
 
<table  width="100%" >  
<tr >

<tr>  
    <td align="right"width="10%">Account</td>   
    <td  width="10%"><input type="text" name="acno" id="acno" value='<s:property value="acno"/>' placeholder="Press F3 To Search"     onKeyDown="getaccountdetails(event);" >  
      <td width="50%"><input type="text" id="accname" name="accname" value='<s:property value="accname"/>'  style="width:50%;">
      
      <input type="hidden" id="accdocno" name="accdocno" value='<s:property value="accdocno"/>'  style="width:72%;">
      </td>
   <td align="right" width="10%">Doc No</td>
<td align="left" width="20%"><input type="text" id="docno" name="docno" tabindex="-1" readonly="readonly" value='<s:property value="docno"/>' /></td>
 </tr>
<tr>
<td align="right" width="10%">Description</td><td  width="60%" colspan="2"><input type="text" id="desc1" name="desc1" tabindex="-1"  style="width:90%;"  value='<s:property value="desc1"/>'  onkeypress="hidemsg();" /> </td>  
    <td width="10%">&nbsp;</td>
      <td width="20%">&nbsp;</td>

</tr>
<%-- <tr>
    <td align="right"width="10%">Account</td>  
    <td  width="10%"><input type="text" name="acno" id="acno" value='<s:property value="acno"/>' placeholder="Press F3 To Search"     onKeyDown="getaccountdetails(event);" >  
      <td width="50%"><input type="text" id="accname" name="accname" value='<s:property value="accname"/>'  style="width:50%;">
      
      <input type="hidden" id="accdocno" name="accdocno" value='<s:property value="accdocno"/>'  style="width:72%;">
      </td>
      <td width="10%">&nbsp;</td>
      <td width="20%">&nbsp;</td>
 </tr> --%>
</table>
<br/>
<br/>
</fieldset>
 
 


<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' /> 
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>


</form>

  <div id="accountSearchwindow">
	   <div ></div>
	</div>
</div>
</body>
</html>