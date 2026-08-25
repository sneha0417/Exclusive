<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<%
String contextPath=request.getContextPath();
%>
<%@page import="com.controlcentre.settings.productsettings.productmaster.ClsProductMasterDAO"%>
<%ClsProductMasterDAO DAO= new ClsProductMasterDAO(); %>
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
		$('#btnSearch').attr('disabled', true);
	    $("#date").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
	    
	    document.getElementById("formdet").innerText="Category(CAT)";
		document.getElementById("formdetail").value="Category";
		document.getElementById("formdetailcode").value="CAT";
		window.parent.formCode.value="CAT";
		window.parent.formName.value="Category";
 		 var data= '<%=DAO.prdcategoryLoad(session)%>'; 
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'category', type: 'String'  },
                          	{name : 'date', type: 'date'  }
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
    
            $("#jqxcategorySearch1").jqxGrid(
                    {
                    	width: 850,
                        source: dataAdapter,
                        showfilterrow: true,
                        filterable: true,
                        selectionmode: 'multiplecellsextended',
                        //Add row method
                        columns: [
        					{ text: 'DOC NO', datafield: 'doc_no', width: '10%' },
        					{ text: 'CATEGORY',columntype: 'textbox', filtertype: 'input', datafield: 'category', width: '50%' },
        					{ text: 'DATE',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '40%',cellsformat:'dd.MM.yyyy' }
        	              ]
                    });
            $('#jqxcategorySearch1').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxcategorySearch1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("txtcategory").value = $("#jqxcategorySearch1").jqxGrid('getcellvalue', rowindex1, "category");
                $("#date").jqxDateTimeInput('val', $("#jqxcategorySearch1").jqxGrid('getcellvalue', rowindex1, "date"));
                //document.getElementById("search").style.display="none";
               // $('#window').jqxWindow('hide');
            }); 
        });
	function funSearchLoad(){
		changeContent('categorySearch.jsp', $('#window')); 
	 }
	/* function funReset() {
		$(this).closest('form').find("input[type=text]").val("");
		//$('#frmcategory').trigger("reset");
		//document.getElementById("frmcategory").reset();
		//document.getElementById("docno").value="";
		//document.getElementById("category").value="";
	} */
	function funReadOnly() {
		$('#frmcategory input').attr('readonly', true);
		$('#date').jqxDateTimeInput({
			readonly : true
		});
		
		/* 	$('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
	}
	function funRemoveReadOnly() {
		$('#frmcategory input').attr('readonly', false);
		$('#date').jqxDateTimeInput({
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
			$("#date").jqxDateTimeInput('val', $('#datehidden').val());
		}
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
	}
	
	 $(function(){
	        $('#frmcategory').validate({
	                 rules: {
	                 category: {
	                	 required:true,
	                	 maxlength:40
	                 }
	                 },
	                 messages: {
	                  category: {
	                	  required:" *",
	                	  maxlength:"max 40 only"
	                  } 
	                 }
	        });});
	     function funNotify(){
	    
	    		return 1;
		} 
	     function funFocus(){
	    	 document.getElementById("txtcategory").focus();
	     }
	  
</script>  
 
</head>
<body onLoad="setValues();" >
<form id="frmcategory" action="savepcmAction" method="post" autocomplete="off">
	<jsp:include page="../../../../header.jsp" />
	<br/> 
	<fieldset><legend>Category Details</legend>
	<table width="100%">
		<tr><td width="6%" align="right">Date</td>
			<td width="31%"  align="left"><div id="date" name="date"></div>
		  	</td>
			<td width="46%" align="right">Doc No.</td>
			<td width="17%">
					<input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly tabindex="-1">
			</td>
		</tr><!-- pattern=".{1,3}" required="required" -->
		<tr><td align="right">Category</td>
			<td><input type="text" name="txtcategory" id="txtcategory"  value='<s:property value="txtcategory"/>' ></td></tr>
			
			<tr>
			
				<td><input
				type="hidden" name="mode" id="mode"
				value='<s:property value="mode"/>' /> <input type="hidden"
				name="deleted" id="deleted" value='<s:property value="deleted"/>' />
			<input type="hidden" id="msg" name="msg"
				value='<s:property value="msg"/>' /></td>
			</tr>
	</table>
	
	</fieldset>
    	
	</form>
<table width="100%">
      <tr>
        <td width="3%">&nbsp;</td>
        <td width="42%">	 <div id="jqxcategorySearch1"></div>  
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
					<jsp:include page="categorySearch.jsp"></jsp:include>
				</div></div>
	 --%>
	

</body>
</html>