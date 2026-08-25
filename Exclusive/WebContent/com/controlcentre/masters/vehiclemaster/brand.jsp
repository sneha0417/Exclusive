<%@page import="com.controlcentre.masters.vehiclemaster.brand.ClsBrandAction" %>
<%ClsBrandAction cba=new ClsBrandAction(); %>

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
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
form label.error {
color:red;
  font-weight:bold;

}
</style>
<script type="text/javascript">
	$(document).ready(function () {    
	    $("#date_brand").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
	    
	    document.getElementById("formdet").innerText="Brand(BRD)";
		document.getElementById("formdetail").value="Brand";
		document.getElementById("formdetailcode").value="BRD";
		window.parent.formCode.value="BRD";
		window.parent.formName.value="Brand";
 		var data= '<%=cba.searchDetails() %>';
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'DOC_NO' , type: 'number' },
     						{name : 'BRAND_NAME', type: 'String'  },
                          	{name : 'DATE', type: 'date'  }
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
    
            $("#jqxBrandSearch1").jqxGrid(
                    {
                    	width: 850,
                        source: dataAdapter,
                        showfilterrow: true,
                        filterable: true,
                        selectionmode: 'multiplecellsextended',
                        //Add row method
                        columns: [
        					{ text: 'DOC NO', datafield: 'DOC_NO', width: '10%' },
        					{ text: 'BRAND',columntype: 'textbox', filtertype: 'input', datafield: 'BRAND_NAME', width: '50%' },
        					{ text: 'DATE',columntype: 'textbox', filtertype: 'input', datafield: 'DATE', width: '40%',cellsformat:'dd.MM.yyyy' }
        	              ]
                    });
            $('#jqxBrandSearch1').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxBrandSearch1').jqxGrid('getcellvalue', rowindex1, "DOC_NO"); 
                document.getElementById("brand").value = $("#jqxBrandSearch1").jqxGrid('getcellvalue', rowindex1, "BRAND_NAME");
                $("#date_brand").jqxDateTimeInput('val', $("#jqxBrandSearch1").jqxGrid('getcellvalue', rowindex1, "DATE"));
                //document.getElementById("search").style.display="none";
               // $('#window').jqxWindow('hide');
            }); 
        });
	function funSearchLoad(){
		changeContent('brandSearch.jsp', $('#window')); 
	 }
	/* function funReset() {
		$(this).closest('form').find("input[type=text]").val("");
		//$('#frmBrand').trigger("reset");
		//document.getElementById("frmBrand").reset();
		//document.getElementById("docno").value="";
		//document.getElementById("brand").value="";
	} */
	function funReadOnly() {
		$('#frmBrand input').attr('readonly', true);
		$('#date_brand').jqxDateTimeInput({
			readonly : true
		});
		
		/* 	$('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
	}
	function funRemoveReadOnly() {
		$('#frmBrand input').attr('readonly', false);
		$('#date_brand').jqxDateTimeInput({
			readonly : false
		});
		$('#docno').attr('readonly', true);
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
			$("#date_brand").jqxDateTimeInput('val', $('#datehidden').val());
		}
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
	}
	
	 $(function(){
	        $('#frmBrand').validate({
	                 rules: {
	                 brand: {
	                	 required:true,
	                	 maxlength:40
	                 }
	                 },
	                 messages: {
	                  brand: {
	                	  required:" *",
	                	  maxlength:"max 40 only"
	                  } 
	                 }
	        });});
	     function funNotify(){
	    
	    		return 1;
		} 
	     function funFocus(){
	    	 document.getElementById("brand").focus();
	     }
	  function funExcelBtn(){
		  $("#jqxBrandSearch1").jqxGrid('exportdata', 'xls', 'Brand');
	  }
</script>  
 
</head>
<body onLoad="setValues();" >
<form id="frmBrand" action="saveBrand" method="get" autocomplete="off">
	<jsp:include page="../../../../header.jsp" />
	<br/> 
	<fieldset><legend>Brand Details</legend>
	<table width="100%">
		<tr><td width="6%" align="right">Date</td>
			<td width="31%"  align="left"><div id="date_brand" name="date_brand"></div>
		  	</td>
			<td width="46%" align="right">Doc No.</td>
			<td width="17%">
					<input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly="true"  tabindex="-1">
			</td>
		</tr><!-- pattern=".{1,3}" required="required" -->
		<tr><td align="right">Brand</td>
			<td><input type="text" name="brand" id="brand"  value='<s:property value="brand"/>' ></td></tr>
			
			<tr>
				<td><input type="hidden" id="mode" name="mode"/></td>
				        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
				
				<td><input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/></td>
				<td><input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/></td>
			</tr>
	</table>
	
	</fieldset>
    	
	</form>
<table width="100%">
      <tr>
        <td width="3%">&nbsp;</td>
        <td width="42%">	 <div id="jqxBrandSearch1"></div>  
</td>
        <td width="55%">&nbsp;</td>
      </tr>
    </table>
<br/>
		<%-- 	<div id="window">
				<div id="windowHeader" class="windowHead">
					<span> <img src="../../../../icons/search_new.png" alt="" style="margin-right: 15px" />Search
					</span>
				</div>
				<div id="windowContent" class="windowCont" style="overflow: hidden;">
					<jsp:include page="brandSearch.jsp"></jsp:include>
				</div></div>
	 --%>
	

</body>
</html>