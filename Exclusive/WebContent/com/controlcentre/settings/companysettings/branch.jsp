<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>

<!DOCTYPE html>
<html>
<head>
<s:head/>
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

.style1 {
	color: #FF0000;
	font-weight: bold;
}
</style>

<script type="text/javascript">
    $(document).ready(function () {
	getBranchLimit();  
	    //Date
    	$("#branchaccdate1").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"}); 
        $("#branchaccdate2").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 document.getElementById("datediv").style.display="none";
		document.getElementById("formdet").innerText="Branch(BRH)";
		 document.getElementById("formdetail").value="Branch";
		 document.getElementById("formdetailcode").value="BRH";
		 window.parent.formCode.value="BRH"; 
		 window.parent.formName.value="Branch";
     });
    function funSearchLoad(){
		changeContent('branchSearch.jsp', $('#window')); 
	 }
 	function funReadOnly(){
		$('#frmBranch input').attr('readonly', true );
		$('#frmBranch select').attr('disabled', true );
		 $('#branchaccdate1').jqxDateTimeInput({ disabled: true});
		 $('#branchaccdate2').jqxDateTimeInput({ disabled: true});
	}
	function funRemoveReadOnly(){
		$('#frmBranch input').attr('readonly', false );
		$('#frmBranch select').attr('disabled', false );
		$('#branchaccdate1').jqxDateTimeInput({ disabled: false});
		 $('#branchaccdate2').jqxDateTimeInput({ disabled: false});
	}
    function getCurrency()
	 {
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	items= x.responseText;
			 	items=items.split('***');
		        var currItems=items[0].split(",");
		        var curridItems=items[1].split(",");
		        	var optionscurr = '<option value="">--Select--</option>';
		        for ( var i = 0; i < currItems.length; i++) {
		    	   optionscurr += '<option value="' + curridItems[i] + '">' + currItems[i] + '</option>';
		        }
		         $("select#cmbbranchcurr").html(optionscurr);
		         //alert($('#hidcmbcurr').val());
			     $('#cmbbranchcurr').val($('#hidcmbbranchcurr').val()) ;
				   // alert($('#cmbcurr').val());
			    }
		       else
			  {
			  }
	     }
	      x.open("GET","getCurrency.jsp",true);
	     x.send();
	    
       }
    function getCompany()
    {
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			//alert(x.responseText);
			 	items= x.responseText;
			 	items=items.split('***');
			 	 var compidItems=items[1].split(",");
			 	var compItems=items[0].split(",");
		         var optionscomp = '<option value="">--Select--</option>';
		        for ( var i = 0; i < compItems.length; i++) {
		    	   optionscomp += '<option value="' + compidItems[i] + '">' + compItems[i] + '</option>';
		        }
		         $("select#cmbcompname").html(optionscomp);
		         //alert($('#cmbcompname').val());
			     $('#cmbbranchcurr').val($('#hidcmbbranchcurr').val()) ;
			     $('#cmbcompname').val($('#hidcmbcompname').val()) ;
			     // alert($('#cmbcurr').val());
			    }
		       else
			  {
			  }
	     }
	      x.open("GET","getCompany.jsp",true);
	     x.send();	
    }


	 function getBranchLimit()
    {
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			//alert(x.responseText);
			 	items= x.responseText;
			 	items=items.split('***');
			 	 var brLimit=items[0];
			 	 if(brLimit>10){
			 		$("#btnCreate").attr('disabled', true );
			 		document.getElementById("errormsg").innerText="Branch Count Exceeds Limit,Contact Administrator!!!";
			 		 //$.messager.alert('Message','Branch Count Exceeds Limit,Contact Administrator for more...');
			 	 }
			    }
		       else
			  {
			  }
	     }
	      x.open("GET","getBrlimit.jsp",true);
	     x.send();	
    }



    function verify()
    {
    	 //alert($('#chqfollowhr').val());
    }
    function setValues(){	
   
	 if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
	 

	}
    function checkBranchid(value){
    	var x=new XMLHttpRequest();
    	x.onreadystatechange=function(){
    	if (x.readyState==4 && x.status==200)
    		{
    		 	var items=x.responseText;
    		 	//alert(items.trim()!='undefine');
    		 	if(items.trim()!='undefine'){
    		 		document.getElementById("txtbranchid").focus();
    		 		document.getElementById("errormsg").innerText="Branch ID Already Exists";
    		 	}
    		 	else{
    		 		
    		 		document.getElementById("errormsg").innerText="";
    		 		
    		 	}
    		    }
    	       else
    		  {
    		  }
         }
          x.open("GET","checkBranchid.jsp?code="+value+"&doc="+document.getElementById("docno").value,true);
         x.send();
        
    }
    function funFocus()
    {
    	document.getElementById("cmbcompname").focus();
    		
    }
   
    $(function(){
        $('#frmBranch').validate({
                 rules: {
                 txtbranchid: {
                	 required:true,
                	 maxlength:5
                 },
                txtbranchname:"required",
                cmbcompname:"required",
                cmbbranchcurr:"required"/* ,
                txttel1:{
                	required:'*',
                	digits:true,
                	maxlength:12,
                	minlength:12
                } */
                 },
                 messages: {
                  txtbranchid:{
                	  required:" *",
                	  maxlength:'max 5 chars'
                  },
                  txtbranchname:" *",
                  cmbcompname:" *",
                  cmbbranchcurr:" *"/* ,
                  txttel1:{
                	  required:" *",
                	  digits:"Digits ",
                	  maxlength:"Max 12 ",
                	  minlength:"Min 12 "
                  } */
                 }
        });});
     function funNotify(){
    	 var date1 = $('#branchaccdate1').jqxDateTimeInput('getDate');
  		var date2 = $('#branchaccdate2').jqxDateTimeInput('getDate');
  	
    		if(date1>date2){
				document.getElementById("errormsg").innerText="";
				document.getElementById("errormsg").innerText="Accounting To Date Cannot be less than From Date";
				$('#branchaccdate1').jqxDateTimeInput('focus');
    			return 0;
    		}   
    		document.getElementById("errormsg").innerText="";
    		return 1;
	} 
</script>
</head>
<body onLoad="getCurrency();getCompany();setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmBranch" action="saveActionBranch" autocomplete="off">
	<jsp:include page="../../../../header.jsp" />
	<br/> 
     
<fieldset>
<table width="100%">
  <tr>
    <td width="11%" align="right">Company</td>
    <td colspan="6"><select name="cmbcompname" id="cmbcompname"  value='<s:property value="cmbcompname"/>' style="width:97%;"><option></option></select></td>
    <td width="36%">&nbsp;</td>
  </tr>
  <tr>
<input type="hidden" name="hidcmbcompname" id="hidcmbcompname" value='<s:property value="hidcmbcompname"/>'>
  <%-- <input type="text" id="compname" name="txtcompname" style="width:50%;" value='<s:property value="txtcompname"/>'> --%>
    <td align="right">Branch</td>
    <td width="18%"><input type="text" id="txtbranchid" name="txtbranchid" style="width:78%;" value='<s:property value="txtbranchid"/>' onblur="checkBranchid(this.value);"></td>
    <td colspan="5"><input type="text" id="txtbranchname" name="txtbranchname"  value='<s:property value="txtbranchname"/>' style="width:94.5%;"></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="right">Address</td>
    <td colspan="6"><input type="text" id="txtaddress" name="txtaddress" style="width:96%;"  value='<s:property value="txtaddress"/>'/></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="right">P.B.No</td>
    <td colspan="6"><input type="text" id="txtpbno" name="txtpbno" style="width:50%;" value='<s:property value="txtpbno"/>'></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="right">Tel</td>
    <td colspan="3"><input type="text" id="txttel1" name="txttel1" style="width:82%;" value='<s:property value="txttel1"/>'></td>
    <td width="5%"  align="right">Tel</td>
    <td colspan="2"><input type="text" id="txttel2" name="txttel2" style="width:91%;" value='<s:property value="txttel2"/>'></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="right">Fax</td>
    <td><input type="text" id="txtfax1"  name="txtfax1" style="width:100%;" value='<s:property value="txtfax1"/>'></td>
    <td colspan="3"  align="right">Fax</td>
    <td colspan="2"><input type="text" id="txtfax2" name="txtfax2" style="width:91%;" value='<s:property value="txtfax2"/>'></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td  align="right">Email</td>
    <td colspan="6"><input type="email" id="txtemail1" name="txtemail1" style="width:96.5%;" value='<s:property value="txtemail1"/>'></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td  align="right">Website</td>
    <td colspan="6"><input type="text"  id="txtwebsite" name="txtwebsite" style="width:96.5%;" value='<s:property value="txtwebsite"/>'></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td  align="right">Tin No.</td>
    <td><input type="text"  id="txttinno" name="txttinno" style="width:100%;" value='<s:property value="txttinno"/>'></td>
    <td colspan="3"  align="right">STC No.</td>
    <td colspan="2"><input type="text"  id="txtstcno" name="txtstcno" style="width:91%;" value='<s:property value="txtstcno"/>'></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="right">CST No</td>
    <td><input type="text"  id="txtcstno" name="txtcstno" style="width:100%;" value='<s:property value="txtcstno"/>'></td>
    <td colspan="5"  align="center"><input type="checkbox" id="chckfollowhr" name="chckfollowhr" onChange="verify();" value='<s:property value="chckfollowhr"/>'/>Follows Company HR Calendar</td>
    <td  align="center">&nbsp;</td>
  </tr>
  <tr>
    <td  align="right">Account Period</td>
    <td><div id="branchaccdate1" name="branchaccdate1" value='<s:property value="branchaccdate1"/>'></div>
        <input type="hidden" id="hidbranchaccdate1" name="hidbranchaccdate1" value='<s:property value="hidbranchaccdate1"/>'/></td>
    <td width="3%"  align="center">To</td>
    <td colspan="2"><div id="branchaccdate2" name="branchaccdate2" value='<s:property value="branchaccdate2"/>'></div>
        <input type="hidden" id="hidbranchaccdate2" name="hidbranchaccdate2" value='<s:property value="hidbranchaccdate2"/>'/></td>
    <td width="10%" align="right">Currency      
      <div align="right"></div></td>
    <td width="12%" align="left"><select id="cmbbranchcurr" name="cmbbranchcurr" value='<s:property value="cmbbranchcurr"/>' style="width:87%;" >
      <option></option>
    </select></td>
    <td><input type="hidden" id="hidcmbbranchcurr" name="hidcmbbranchcurr" value='<s:property value="hidcmbbranchcurr"/>'/></td>
  </tr>
  <tr>
    <td  align="right">&nbsp;</td>
    <td colspan="4"><div class="style1" id="datediv">
      <div align="right">Please select a valid Date</div>
    </div></td>
    <td align="right">&nbsp;</td>
    <td align="left">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>

<input type="hidden" id="docno" name="docno" value='<s:property value="docno"/>'>
<input type="text" name="deleted" id="deleted" value='<s:property value="deleted"/>' hidden="true"/>
<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/><br/>
</fieldset>

</form>
</div>
</body>
</html>