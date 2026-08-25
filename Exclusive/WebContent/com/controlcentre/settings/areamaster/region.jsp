<%@page import="com.controlcentre.settings.areamaster.region.ClsRegionAction"%>
<%ClsRegionAction DAO= new ClsRegionAction();%> 
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<%
String contextPath=request.getContextPath();
%>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
form label.error {
color:red;
  font-weight:bold;

}
</style>
<script type="text/javascript">
	$(document).ready(function () {    
	    $("#date_reg").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
	    var data= '<%=DAO.searchDetails()%>';
  
 var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'DOC_NO' , type: 'number' },
     						{name : 'REG_NAME', type: 'String'  },     						
                          	{name : 'DATE', type: 'String'  }
                 ],
               localdata: data,
                //url: "/searchDetails",
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                   // alert(error);    
	                    }
		            }		
            );
    
            $("#jqxregionSearch1").jqxGrid(
                    {
                    	width: 850,
                        source: dataAdapter,
                        showfilterrow: true,
                        filterable: true,
                        selectionmode: 'multiplecellsextended',
                        //Add row method
                        columns: [
        					{ text: 'DOC NO',filtertype: 'number', datafield: 'DOC_NO', width: '10%' },
        					{ text: 'REGION',columntype: 'textbox', filtertype: 'input', datafield: 'REG_NAME', width: '50%' },
        					{ text: 'DATE',columntype: 'textbox', filtertype: 'input', datafield: 'DATE', width: '40%' }
        	              ]
                    });
            $('#jqxregionSearch1').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxregionSearch1').jqxGrid('getcellvalue', rowindex1, "DOC_NO"); 
                document.getElementById("region").value = $("#jqxregionSearch1").jqxGrid('getcellvalue', rowindex1, "REG_NAME");
                $("#date_reg").jqxDateTimeInput('val', $("#jqxregionSearch1").jqxGrid('getcellvalue', rowindex1, "DATE"));
                //document.getElementById("search").style.display="none";
               // $('#window').jqxWindow('hide');
            }); 
        });
       function funSearchLoad(){
		changeContent('regionSearch.jsp', $('#window')); 
	 } 
	/* function funReset() {
		$(this).closest('form').find("input[type=text]").val("");
		//$('#frmBrand').trigger("reset");
		//document.getElementById("frmBrand").reset();
		//document.getElementById("docno").value="";
		//document.getElementById("brand").value="";
	} */
	function funReadOnly() {
		$('#frmRegion input').attr('readonly', true);
		$('#date_reg').jqxDateTimeInput({
			readonly : true
		});
		setValues();
		/* 	$('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
	}
	function funRemoveReadOnly() {
		$('#frmRegion input').attr('readonly', false);
		$('#date_reg').jqxDateTimeInput({
			readonly : false
		});
		$('#docno').attr('readonly', true);
		if(document.getElementById("mode").value=='A'){
			$('#jqxregionSearch1').jqxGrid({ disabled: true});
		}
	}
/* 	function show_image(src, width, height, alt,position,norepeat) {
	    var img = document.createElement("img");
	    img.src = src;
	    img.width = width;
	    img.height = height;
	    img.alt = alt;
	    img.position=position;
	    img.repeat=norepeat;

	    // This next line will just add it to the <body> tag
	    document.body.appendChild(img);
	} */
	function setValues() {
		if($('#datehidden').val()){
			$("#date_reg").jqxDateTimeInput('val', $('#datehidden').val());
		}
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	}
	
	 $(function(){
	        $('#frmRegion').validate({
	                 rules: {
	                	 region: {
	                	 required:true,
	                	 maxlength:40
	                 }
	                 },
	                 messages: {
	                	 region: {
	                	  required:" *",
	                	  maxlength:"max 40 only"
	                  } 
	                 }
	        });});
	     function funNotify(){
	    
	    		return 1;
		} 
	     function funFocus(){
	    	 document.getElementById("region").focus();
	     }
	  
</script>  
 
</head>
<body onLoad="funReadOnly();setValues();" >
<form id="frmRegion" action="saveRegion" method="get" autocomplete="off">
<script>
			 window.parent.formName.value="REGION";
			window.parent.formCode.value="REG"; 
	</script>
	<%-- <jsp:include page="../../../../header.jsp" /> --%>
	<jsp:include page="../../../../header.jsp" />
	<br/> 
	<fieldset><legend>Region Details</legend>
	<table width="100%">
		<tr><td width="6%" align="right">Date</td>
			<td width="31%"  align="left"><div id="date_reg" name="date_reg"></div>
		  	</td>
			<td width="46%" align="right">Doc No.</td>
			<td width="17%">
					<input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly="true"  tabindex="-1">
			</td>
		</tr><!-- pattern=".{1,3}" required="required" -->
		<tr><td align="right">Region</td>
			<td><input type="text" name="region" id="region"  value='<s:property value="region"/>' ></td></tr>
			
			<tr>
				<%-- <td><input type="hidden" id="mode" name="mode"/></td>
				        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/> --%>
				
				
				<td><input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/></td>
			</tr>
	</table>
	
	</fieldset>
    	<table width="100%">
      <tr>
        <td width="3%">&nbsp;</td>
        <td width="42%">	 <div id="jqxregionSearch1"></div>  
        <input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>
		<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
		<input type="hidden" id="deleted" name="deleted"  value='<s:property value="deleted"/>'/>
</td>
        <td width="55%">&nbsp;</td>
      </tr>
    </table>
	</form>

<br/>

</body>
</html>