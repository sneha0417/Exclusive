<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript">
      $(document).ready(function () { 
    	  $("#jqxCurrencyBookDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    	  
    	  /* Searching Window */
     	 $('#currencyWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Currency Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
  		 $('#currencyWindow').jqxWindow('close');
  		 
      });
      
      function CurrencySearchContent(url) {
  		$('#currencyWindow').jqxWindow('open');
  		$.get(url).done(function (data) {
  		$('#currencyWindow').jqxWindow('setContent', data);
  		$('#currencyWindow').jqxWindow('bringToFront');
  	}); 
  	} 
      
      function getBaseCurrency(){
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				items= x.responseText;
				 	items=items.split('####');
			        var curidItems=items[0];
			        var curcodeItems=items[1];
	  			    $('#txtbasecurId').val(items[0]);
	  			    $('#txtbasecurrency').val(items[1]);
	  		}
	  		}
	  		x.open("GET", "getBaseCurrency.jsp", true);
	  		x.send();
	 }
      
      function funReadOnly(){
    	$('#frmCurrencyBook input').attr('readonly', true );
    	$('#jqxCurrencyBookDate').jqxDateTimeInput({disabled: true});
  	 	$("#jqxCurrencyBook").jqxGrid({ disabled: true});
  	}

  	function funRemoveReadOnly(){
  		getBaseCurrency();
  		
  		$('#frmCurrencyBook input').attr('readonly', true );
  		$('#jqxCurrencyBookDate').jqxDateTimeInput({disabled: false});
  		$("#jqxCurrencyBook").jqxGrid({ disabled: false});
  		
  		 if ($("#mode").val() == "A") {
  			 $("#jqxCurrencyBook").jqxGrid('clear');
  			 $("#currencyBookDiv").load("currencyBookGrid.jsp?check=1");
  		}  
  		
  	}

  	function funSearchLoad(){
  	 	/*  changeContent('opnMainSearch.jsp', $('#window')); */  
  	}

  	function funChkButton(){
  		/* funReset(); */
  	}

  	function funFocus(){
  		$('#jqxCurrencyBookDate').jqxDateTimeInput('focus'); 
  	}

  	function funNotify(){	
  			
  	/* Currency Grid Saving */
     	 var rows = $("#jqxCurrencyBook").jqxGrid('getrows');
     	 var length=0;
  		 for(var i=0 ; i < rows.length ; i++){
  			var chk=rows[i].curid;
  			if(typeof(chk) != "undefined"){
  				length=length+1;
  				newTextBox = $(document.createElement("input"))
  			    .attr("type", "dil")
  			    .attr("id", "test"+i)
  			    .attr("name", "test"+i)
  				.attr("hidden", "true");
  			
  			newTextBox.val(rows[i].curid+"::"+rows[i].c_rate+":: "+rows[i].type+":: "+rows[i].description);
  			newTextBox.appendTo('form');
  			}
  		 }
  		 $('#gridlength').val(length);
  		/* Currency Grid Saving Ends */
  			 
  			return 1;
  	} 


  	function setValues(){
  		
  	if($('#hidjqxCurrencyBookDate').val()){
		 $("#jqxCurrencyBookDate").jqxDateTimeInput('val', $('#hidjqxCurrencyBookDate').val());
	  }
  	
  	  if($('#msg').val()!=""){
  		   $.messager.alert('Message',$('#msg').val());
  		  }
  	  
  	  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
  	  funSetlabel(); 
  	 
  	  var indexVal = document.getElementById("txtbasecurId").value;
  	  if(indexVal>0){
		$("#currencyBookDiv").load("currencyBookGrid.jsp?check=1&disable=1");
  	  } 
  	}
      
</script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmCurrencyBook" action="saveCurrencyBook" >
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<fieldset>
<table width="100%">
  <tr>
    <td width="4%" align="right">Date</td>
    <td width="15%"><div id="jqxCurrencyBookDate" name="jqxCurrencyBookDate" value='<s:property value="jqxCurrencyBookDate"/>'></div>
    <input type="hidden" id="hidjqxCurrencyBookDate" name="hidjqxCurrencyBookDate" value='<s:property value="hidjqxCurrencyBookDate"/>'/></td>
    <td width="19%" align="right">Base Currency</td>
    <td width="62%"><input type="text" id="txtbasecurrency" name="txtbasecurrency" style="width:7%;" tabindex="-1" value='<s:property value="txtbasecurrency"/>'/>
                    <input type="hidden" id="txtbasecurId" name="txtbasecurId" value='<s:property value="txtbasecurId"/>'/></td>
  </tr>
  <tr>
    <td colspan="4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <div id="currencyBookDiv"><jsp:include page="currencyBookGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</fieldset>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
</form>

<div id="currencyWindow">
	<div></div><div></div>
</div>
</div>
</body>
</html>