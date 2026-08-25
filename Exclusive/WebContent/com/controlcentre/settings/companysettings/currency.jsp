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
    	   document.getElementById("formdet").innerText="Currency(CUR)";
  		 document.getElementById("formdetail").value="Currency";
  		 document.getElementById("formdetailcode").value="CUR";
  		window.parent.formCode.value="CUR";
  		window.parent.formName.value="Currency";
        });
       function funSearchLoad(){
			changeContent('currencySearch.jsp', $('#window')); 
		 }
       function funReset(){
	       $('#frmCurrency')[0].reset(); 
        }
        function funReadOnly(){
	       $('#frmCurrency input').attr('readonly', true );
	       /* $('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
        }
        function funRemoveReadOnly(){
	       $('#frmCurrency input').attr('readonly', false );
	      // $('#jqxDateTimeInput').jqxDateTimeInput({ disabled: false});
	       $('#docno').attr('readonly', true);
        }
        function funFocus()
        {
        	document.getElementById("txtcode").focus();
        		
        }
        $(function(){
            $('#frmCurrency').validate({
                    	 rules: {
                             txtcode: {
                            	 required:true,
                            	 maxlength:3
                             },
                            txtcodename:{
                            	required:true,
                            	maxlength:15
                            },
                            	txtcountry:"required",
                            	txtfraction:"required",
                            	txtdecimal:{
                            	required:true,
                            	number:true
                            	}
                            },
                             
                             messages: {
                              txtcode:{
                            	  required:" *",
                            	  maxlength:"Max 3 chars"
                              },
                              txtcodename:{
                            	  required:" *",
                            	  maxlength:"Max 15 chars"
                              },
                              txtcountry:" *",
                              txtfracttion:" *",
                              txtdecimal:{
                            	  required:" *",
                            	  number:"Invalid Decimal"
                              }
                             }
            });});
        function funNotify(){
        	return 1;
        }
        function setValues(){	
        
        	 if($('#msg').val()!=""){
      		   $.messager.alert('Message',$('#msg').val());
      		  }

        	}
        function checkCurrency(value){
        	var x=new XMLHttpRequest();
        	x.onreadystatechange=function(){
        	if (x.readyState==4 && x.status==200)
        		{
        		 	var items=x.responseText;
        		 	//alert(items.trim()!='undefine');
        		 	if(items.trim()!='undefine'){
        		 		document.getElementById("txtcode").focus();
        		 		document.getElementById("errormsg").innerText="Currency Code Already Exists";
        		 	}
        		 	else{
        		 		
        		 		document.getElementById("errormsg").innerText="";
        		 		
        		 	}
        		    }
        	       else
        		  {
        		  }
             }
              x.open("GET","checkCurrency.jsp?code="+value+"&doc="+document.getElementById("docno").value,true);
             x.send();
        }
</script>
</head>
<body onLoad="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmCurrency" action="saveActionCurrency" autocomplete="off">

	<jsp:include page="../../../../header.jsp" />
	<br/> 
  
<fieldset>
<table width="100%" >
  <tr>
    <td width="16%" align="right">Doc No</td>
    <td width="44%"><input type="text" id="docno" name="docno" style="width:12%;" value='<s:property value="docno"/>' readonly="readonly"/></td>
  </tr>
  <tr>
    <td align="right">Code</td>
    <td colspan="3"><input type="text" id="txtcode" name="txtcode" style="width:5%;" value='<s:property value="txtcode"/>' onblur="checkCurrency(this.value);"/>
    <input type="text" id="txtcodename" name="txtcodename" style="width:20%;" value='<s:property value="txtcodename"/>' /></td>
  </tr>
  <tr>
    <td align="right">Country</td>
    <td colspan="3"><input type="text" id="txtcountry" name="txtcountry" style="width:12%;" value='<s:property value="txtcountry"/>' /></td>
  </tr>
  <tr>
    <td align="right">Fraction</td>
    <td colspan="3"><input type="text" id="txtfraction" name="txtfraction" style="width:12%;" value='<s:property value="txtfraction"/>' /></td>
  </tr>
  <tr>
    <td><div align="right">Price Decimals</div></td>
    <td colspan="3"><input type="text" id="txtdecimal" name="txtdecimal" style="width:12%;" value='<s:property value="txtdecimal"/>' /></td>
  </tr>
</table>

<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'>
<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
<input type="hidden" id="mode" name="mode"/><br/>
</fieldset>
<%-- <div style="width: 100%; height: 350px; margin-top: 50px;" id="mainDemoContainer"> 
            <div id="window">
                <div id="windowHeader" style="background: #81BEF7;">
                    <span>
                        <img src="../../../../icons/search_new.png" alt="" style="margin-right: 15px" />Search
                    </span>
                </div>
                <div style="overflow: hidden;background: #E0ECF8;" id="windowContent">
								 	<jsp:include page="currencySearch.jsp"></jsp:include> 
							</div>
						</div>
				</div> --%>
</form>
</div>
</body>
</html>