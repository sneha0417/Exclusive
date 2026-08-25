<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<%
String contextPath=request.getContextPath();
%>
<%@page import="com.aviation.taxmaster.ClsTaxMasterDAO"%>
<%ClsTaxMasterDAO DAO= new ClsTaxMasterDAO(); %>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../includes.jsp"></jsp:include>
<style>
form label.error {
color:red;
  font-weight:bold;

}
</style>
<script type="text/javascript">
	$(document).ready(function () {    
	    $("#date").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
	    $('#btnSearch').attr('disabled', false);
	    document.getElementById("formdet").innerText="Tax Master (TAX)";
		document.getElementById("formdetail").value="Tax Master";
		document.getElementById("formdetailcode").value="TAX";
		window.parent.formCode.value="TAX";
		window.parent.formName.value="Tax Master";
 		var datatax= '<%=DAO.prdtaxLoad(session)%>';
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'tax', type: 'String'  },
     						{name : 'desc1', type: 'String'  },
                          	{name : 'date', type: 'date'  }
                 ],
               localdata: datatax,
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
    
            $("#jqxTaxSearch1").jqxGrid(
                    {
                    	width: 850,
                        source: dataAdapter,
                        showfilterrow: true,
                        filterable: true,
                        selectionmode: 'multiplecellsextended',
                        //Add row method
                        columns: [
        					{ text: 'DOC NO', datafield: 'doc_no', width: '8%' },
        					{ text: 'TAX',columntype: 'textbox', filtertype: 'input', datafield: 'tax', width: '28%' },
        					{ text: 'TAX DESCRIPTION',columntype: 'textbox', filtertype: 'input', datafield: 'desc1', width: '45%' },
        					{ text: 'DATE',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '19%',cellsformat:'dd.MM.yyyy' }
        	              ]
                    });
            $('#jqxTaxSearch1').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxTaxSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("tax").value = $("#jqxTaxSearch1").jqxGrid('getcellvalue', rowindex1, "tax");
                document.getElementById("taxdesc").value = $("#jqxTaxSearch1").jqxGrid('getcellvalue', rowindex1, "desc1");
                $("#date").jqxDateTimeInput('val', $("#jqxTaxSearch1").jqxGrid('getcellvalue', rowindex1, "date"));
                //document.getElementById("search").style.display="none";
               // $('#window').jqxWindow('hide');
            }); 
        });
	function funSearchLoad(){
		changeContent('brandSearch.jsp', $('#window')); 
	 }
	/* function funReset() {
		$(this).closest('form').find("input[type=text]").val("");
		//$('#frmTax').trigger("reset");
		//document.getElementById("frmTax").reset();
		//document.getElementById("docno").value="";
		//document.getElementById("brand").value="";
	} */
	function funReadOnly() {
		$('#frmTax input').attr('readonly', true);
		$('#date').jqxDateTimeInput({
			readonly : true
		});
		
		/* 	$('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
	}
	function funRemoveReadOnly() {
		$('#frmTax input').attr('readonly', false);
		$('#date').jqxDateTimeInput({
			readonly : false
		});
		$('#docno').attr('readonly', true);
	}
	function funSearchLoad(){
		 changeContent('Mastersearch.jsp'); 
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
			$("#date").jqxDateTimeInput('val', $('#date').val());
		}
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
	}
	
	 $(function(){
	        $('#frmTax').validate({
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
	    	 document.getElementById("tax").focus();
	     }
	     
	  
</script>  
 
</head>
<body onLoad="setValues();" >
<form id="frmTax" action="savetaxAction" method="get" autocomplete="off">
	<jsp:include page="../../../header.jsp" />
	<br/> 
	<fieldset><legend> Tax Master Details</legend>
	<table width="100%">
<tr>
<td>
<table width="100%">
		<tr><td width="6%" align="right">Date</td>
			<td width="31%"  align="left"><div id="date" name="date"></div>
		  	</td>
			<td width="46%" align="right">Doc No.</td>
			<td width="17%">
					<input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly  tabindex="-1">
			</td>
		</tr>
        </table>
        <table width="100%">
        <!-- pattern=".{1,3}" required="required" -->
		<tr><td width="6%" align="right">Tax</td>
			<td width="31%" align="left" ><input type="text" name="tax" id="tax"  value='<s:property value="tax"/>' ></td>
			<td width="20%" align="right">Description</td>
				<td width="65%"><input type="text" id="taxdesc" name="taxdesc" style="width:50%;" value='<s:property value="taxdesc"/>'/></td>
			</tr>
	</table>
    <input
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
        <td width="42%">	 <div id="jqxTaxSearch1"></div>  
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