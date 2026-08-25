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

</style>
<script type="text/javascript">
$(document).ready(function () {  
    //Date
	   document.getElementById("formdet").innerText="Location(LOC)";
		 document.getElementById("formdetail").value="Location";
		 document.getElementById("formdetailcode").value="LOC";
		 window.parent.formCode.value="LOC";
		 window.parent.formName.value="Location";
    });
        function funReadOnly(){
	       $('#frmLocation input').attr('readonly', true );
	       $('#frmLocation select').attr('disabled', true );
	       /* $('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
        }
        function funRemoveReadOnly(){
	       $('#frmLocation input').attr('readonly', false );
	       $('#frmLocation select').attr('disabled', false );
	       //$('#jqxDateTimeInput').jqxDateTimeInput({ disabled: false});
        }
      
        function funSearchLoad(){
			changeContent('locationSearch.jsp', $('#window')); 
		 }
        function getBranch()
        {
        	
        	var x=new XMLHttpRequest();
    		x.onreadystatechange=function(){
    		if (x.readyState==4 && x.status==200)
    			{
    			 	items= x.responseText;
    			 	//System.out.println(x.responseText);
    			 	items=items.split('***');
    			 	 var branchidItems=items[1].split(",");
    			 	var branchItems=items[0].split(",");
    		         var optionsbranch = '<option value="">--Select--</option>';
    		        for ( var i = 0; i < branchItems.length; i++) {
    		    	   optionsbranch += '<option value="' + branchidItems[i] + '">' + branchItems[i] + '</option>';
    		        }
    		        $("select#cmbbranchname").html(optionsbranch);
   			     $('#cmbbranchname').val($('#hidcmbbranchname').val()) ;

    			    }
    		       else
    			  {
    			  }
    	     }
    	      x.open("GET","getBranch.jsp",true);
    	     x.send();	
        }
        function setValues(){
        	
       	 if($('#msg').val()!=""){
    		   $.messager.alert('Message',$('#msg').val());
    		  }

        }
        function funFocus()
        {
        	document.getElementById("cmbbranchname").focus();
        		
        }
        $(function(){
            $('#frmLocation').validate({
                     rules: {
                   cmbbranchname: "required",
                    txtloccode:"required",
                    txtlocname:"required"/* ,
                    txttel1:{
                    	required:true,
                    	digits:true,
                    	minlength:12,
                    	maxlength:12
                    } */
                     },
                     messages: {
                      cmbbranchname: " *",
                      txtloccode:" *",
                      txtlocname:" *"/* ,
                      txttel1:{
                    	  required:" *",
                    	  digits:'Digits',
                    	  minlength:'Min 12',
                    	  maxlength:'Max 12'
                      } */
                     
                     }
            });});
         function funNotify(){
        return 1;
    	}
         function checkLocCode(value){
        	 var x=new XMLHttpRequest();
        		x.onreadystatechange=function(){
        		if (x.readyState==4 && x.status==200)
        			{
        			 	var items=x.responseText;
        			 	//alert(items.trim()!='undefine');
        			 	if(items.trim()!='undefine'){
        			 		document.getElementById("txtloccode").focus();
        			 		document.getElementById("errormsg").innerText="Location ID Already Exists";
        			 	}
        			 	else{
        			 		document.getElementById("txtlocname").focus();
        			 		document.getElementById("errormsg").innerText="";
        			 		
        			 	}
        			    }
        		       else
        			  {
        			  }
        	     }
        	      x.open("GET","checkLocCode.jsp?code="+value+"&doc="+document.getElementById("docno").value,true);
        	     x.send();
         }
</script>
</head>
<body onload="getBranch();funReadOnly();setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmLocation" action="saveActionLocation" autocomplete="off" >

	<jsp:include page="../../../../header.jsp" />
	<br/>     
<fieldset>
<%-- <input type="text" id="txtbranchname" name="txtbranchname" style="width:50.5%;" value='<s:property value="txtbranchname"/>'> --%>
<table width="100%">
  <tr> 
    <td width="12%" align="right">Branch</td>
    <td colspan="4"><select id="cmbbranchname" name="cmbbranchname" style="width:50.8%" value='<s:property value="cmbbranchname"/>'><option></option></select></td>
  </tr>
  <tr>
    <td align="right">Location</td>
    <td width="15%"><input type="text" id="txtloccode" name="txtloccode" style="width:79%;" value='<s:property value="txtloccode"/>' onblur="checkLocCode(this.value);"></td>
    <td colspan="3"><input type="text" id="txtlocname" name="txtlocname" style="width:40%;" value='<s:property value="txtlocname"/>'></td>
  </tr>
   <tr>
    <td align="right">Address</td>
    <td colspan="4"><input type="text" id="txtaddress" name="txtaddress" style="width:50.2%;" value='<s:property value="txtaddress"/>' /></td>    
  </tr>
  <tr>
    <td align="right">P.B.No</td>
    <td colspan="4"><input type="text" id="txtpbno" name="txtpbno" style="width:50.5%;" value='<s:property value="txtpbno"/>'></td>
  </tr>
  <tr>
    <td align="right">Tel</td>
    <td colspan="2"><input type="text" id="txttel1" name="txttel1" style="width:60%;" value='<s:property value="txttel1"/>'></td>
    <td width="6%" align="right">Tel</td>
    <td width="61%" align="left"><input type="text" id="txttel2" name="txttel2" style="width:28%;" value='<s:property value="txttel2"/>'></td>
  </tr>
  <tr>
    <td align="right">Fax</td>
    <td colspan="2"><input type="text" id="txtfax1"  name="txtfax1" style="width:60%;" value='<s:property value="txtfax1"/>'></td>
    <td align="right">Fax</td>
    <td><input type="text" id="txtfax2" name="txtfax2" style="width:28%;" value='<s:property value="txtfax2"/>'></td>
  </tr>
  <tr>
    <td align="right">Email</td>
    <td colspan="4"><input type="email" id="txtemail1" name="txtemail1" style="width:50.5%;" value='<s:property value="txtemail1"/>'></td>
  </tr>
  <tr>
    <td align="right">Website</td>
    <td colspan="4"><input type="text"  id="txtwebsite" name="txtwebsite" style="width:50.5%;" value='<s:property value="txtwebsite"/>'></td>
  </tr>
</table>
<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>

<input type="hidden" id="hidcmbbranchname" name="hidcmbbranchname" value='<s:property value="hidcmbbranchname"/>'>
<input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>'>
<input type="text" name="deleted" id="deleted" value='<s:property value="deleted"/>' hidden="true"/>
<input type="hidden" id="mode" name="mode"/><br/>
</fieldset>
</form>
		<%-- <div id="window">
			<div id="windowHeader" style="background: #81BEF7;">
				<span> <img src="../../../../icons/search_new.png" alt=""
					style="margin-right: 15px" />Search
				</span>
			</div>
			<div style="overflow: hidden; background: #E0ECF8;"
				id="windowContent">
				<jsp:include page="locationSearch.jsp"></jsp:include>
			</div>
		</div> --%>
	</div>
</body>
</html>