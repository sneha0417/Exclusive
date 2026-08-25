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
        .hidden-scrollbar{
        	height:600px;
        	overflow-y:auto;
        }
    </style>

    <script type="text/javascript">
        $(document).ready(function() {

            $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
            $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
            $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
            $("#todate").jqxDateTimeInput({
                width: '125px',
                height: '15px',
                formatString: "dd.MM.yyyy"
            });
            var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
 			var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
		    $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
 			$('#todate').on('change', function (event) {
				var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			 	var todates=new Date($('#todate').jqxDateTimeInput('getDate'));
			   	if(fromdates>todates){
		   			$.messager.alert('Message','To Date Less Than From Date  ','warning');   
	   				return false;
	  			}   
 			}); 
		});

        function funExportBtn() {
        	$("#detaildiv").excelexportjs({
				containerid: "detaildiv",
				datatype: 'json',
				dataset: null,
				gridId: "detailGrid",
				columns: getColumns("detailGrid"),
				worksheetName: "Managed Property Income / Expense"
			});
        }

        function funreload(event) {
			var fromdate=$('#fromdate').jqxDateTimeInput('val');
			var todate=$('#todate').jqxDateTimeInput('val');
			var branch=$('#cmbbranch').val();
            $("#overlay, #PleaseWait").show();
            $("#detaildiv").load("detailGrid.jsp?fromdate="+fromdate+"&branch="+branch+"&todate="+todate+"&id=1");
        }

        function funcleardata() {
			$('#postdate,#todate').jqxDateTimeInput('setDate',new Date());
			$('#contractGrid,#jqxPaymentGrid,#jvGrid').jqxGrid('clear');
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
                                        <label class="branch">From Date</label>
                                    </td>
                                    <td align="left">
                                        <div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        <label class="branch">To Date</label>
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
                                        <div id='paychaaaaa' style="width: 100% ; align:right; height:86px;"></div>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                    <td width="80%">
                    	<div id="detaildiv"><jsp:include page="detailGrid.jsp"></jsp:include></div>
                   	</td>
                </tr>
            </table>
            <input type="hidden" id="docno" name="docno" value='<s:property value="docno"/>'>
        </div>
    </div>
</body>

</html>