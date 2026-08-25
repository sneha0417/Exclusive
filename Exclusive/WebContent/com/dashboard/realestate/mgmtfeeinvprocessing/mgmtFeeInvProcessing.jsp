<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GatewayERP(i)</title>
    <link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />

    <style type="text/css">
        .myButtons {
            -moz-box-shadow: inset 0px -1px 3px 0px #91b8b3;
            -webkit-box-shadow: inset 0px -1px 3px 0px #91b8b3;
            box-shadow: inset 0px -1px 3px 0px #91b8b3;
            background: -webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
            background: -moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
            background: -webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
            background: -o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
            background: -ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
            background: linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
            filter: progid: DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c', GradientType=0);
            background-color: #768d87;
            border: 1px solid #566963;
            display: inline-block;
            cursor: pointer;
            color: #ffffff;
            font-size: 8pt;
            padding: 3px 17px;
            text-decoration: none;
            text-shadow: 0px -1px 0px #2b665e;
        }
        
        .myButtons:hover {
            background: -webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
            background: -moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
            background: -webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
            background: -o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
            background: -ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
            background: linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
            filter: progid: DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87', GradientType=0);
            background-color: #6c7c7c;
        }
        
        .myButtons:active {
            position: relative;
            top: 1px;
        }
    </style>

    <script type="text/javascript">
        $(document).ready(function() {

            $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
            $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
            /*  $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"}); */
            $("#todate").jqxDateTimeInput({
                width: '125px',
                height: '15px',
                formatString: "dd.MM.yyyy"
            });
            
		});

        function funExportBtn() {
        	$("#contractdiv").excelexportjs({
				containerid: "contractdiv",
				datatype: 'json',
				dataset: null,
				gridId: "contractGrid",
				columns: getColumns("contractGrid"),
				worksheetName: "Management Fee Invoice Processing"
			});
        }

        function funreload(event) {
			var todate=$('#todate').jqxDateTimeInput('val');
			var branch=$('#cmbbranch').val();
			
            $("#overlay, #PleaseWait").show();
            $("#contractdiv").load("contractGrid.jsp?branch="+branch+"&todate="+todate+"&id=1");

        }

        function funupdate() {
        	
        	//alert("from==="+$('#fromchk').val()+"==to=="+$('#tochk').val());
        	
        	var docno=$('#docno').val();
        	if(docno==''){
        		$.messager.alert('Warning','Please select a document');
        		return false;
        	}
        	var rentalamt=$('#contractGrid').jqxGrid('getcellvalue',$('#gridrowindex').val(),'rentalamt');
        	var mgmtamt=$('#contractGrid').jqxGrid('getcellvalue',$('#gridrowindex').val(),'mgmtamt');
        	var detaildocno=$('#contractGrid').jqxGrid('getcellvalue',$('#gridrowindex').val(),'detaildocno');
        	var paymentdesc=$('#contractGrid').jqxGrid('getcellvalue',$('#gridrowindex').val(),'pytdesc');
        	paymentdesc=encodeURIComponent(paymentdesc);
        	if(rentalamt=="undefined" || rentalamt=="" || rentalamt==null || typeof(rentalamt)=="undefined"){
        		rentalamt=0.0;
        	}
        	if(mgmtamt=="undefined" || mgmtamt=="" || mgmtamt==null || typeof(mgmtamt)=="undefined"){
        		mgmtamt=0.0;
        	}
        	$.messager.confirm('Confirm', 'Are you sure to create Invoice for '+docno+'?', function(r){
				if (r){
					var x = new XMLHttpRequest();
		            x.onreadystatechange = function() {
		                if (x.readyState == 4 && x.status == 200) {
		                    var items = x.responseText.trim();
		                    if(items.split("::")[0]=="0"){
		                    	$('#contractGrid').jqxGrid('clear');
		                    	$('#docno,#gridrowindex').val('');
		                    	$.messager.alert('Warning',items.split("::")[1]);
		                    	funreload("");
		                    }
		                    else{
		                    	$.messager.alert('Warning','Not Generated');
		                    }
		                    
		                }
		            }
		            x.open("GET", "createInvoice.jsp?docno=" + docno+"&rentalamt="+rentalamt+"&mgmtamt="+mgmtamt+"&detaildocno="+detaildocno+"&paymentdesc="+paymentdesc+"&from="+$('#fromchk').val()+"&to="+$('#tochk').val(), true);
		            x.send();
				}
			});
        }

        function funcleardata() {
			$('#todate').jqxDateTimeInput('setDate',new Date());
			$('#contractGrid').jqxGrid('clear');
			$('#docno,#gridrowindex').val('');
			funreload("");
        }
        
    </script>
</head>

<body onload="getBranch();">
    <div id="mainBG" class="homeContent" data-type="background">
        <div class='hidden-scrollbar'>
            <table width="100%">
                <tr>
                    <td width="20%">
                        <fieldset style="background: #ECF8E0;">
                            <table width="100%">
                                <jsp:include page="../../heading.jsp"></jsp:include>
                                <tr>
                                    <td align="right">
                                        <label class="branch">Up To</label>
                                    </td>
                                    <td align="left">
                                        <div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                                    </td>
                                </tr>

                                <tr>
                                    <td colspan="2">&nbsp;</td>
                                </tr>

                                <tr>
                                    <td align="center" colspan="2">
                                        
                                    </td>
                                </tr>

                                <tr>
                                    <td colspan="2">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td colspan="2">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2">
										<input type="button" class="myButtons" name="clear" id="clear" value="Clear" onclick="funcleardata();">
                                        <input type="button" name="Update" id="Update" class="myButton" value="Create Invoice" onclick="funupdate();"> </td>
                                </tr>

                                <tr>
                                    <td colspan="2">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td colspan="2">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td colspan="2">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td colspan="2">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <div id='paychaaaaa' style="width: 100% ; align:right; height:155px;"></div>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                        <input type="hidden" id="acno" name="acno" value='<s:property value="acno"/>'>
                        <input type="hidden" id="brhid" name="brhid" value='<s:property value="brhid"/>'>

                        <input type="hidden" id="reftype" name="reftype" value='<s:property value="reftype"/>'>

                    </td>
                    <td width="80%">
                    	<div id="contractdiv"><jsp:include page="contractGrid.jsp"></jsp:include></div>
                    	
                   	</td>
                </tr>
            </table>
            <input type="hidden" id="docno" name="docno" value='<s:property value="docno"/>'>
            <input type="hidden" id="fromchk" name="fromchk" value='<s:property value="fromchk"/>'>
             <input type="hidden" id="tochk" name="tochk" value='<s:property value="tochk"/>'>
        </div>
    </div>
</body>

</html>