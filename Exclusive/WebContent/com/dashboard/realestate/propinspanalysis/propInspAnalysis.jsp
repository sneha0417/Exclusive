<%@ taglib prefix="s" uri="/struts-tags" %>

    <!DOCTYPE html>
    <html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>GatewayERP(i)</title>
        <link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />
		<jsp:include page="../../../../includes.jsp"></jsp:include>
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

                $('#tenantwindow').jqxWindow({
                    width: '60%',
                    height: '62%',
                    maxHeight: '75%',
                    maxWidth: '70%',
                    title: 'Tenant Search',
                    position: {
                        x: 250,
                        y: 60
                    },
                    keyboardCloseKey: 27
                });
                $('#tenantwindow').jqxWindow('close');
				$('#propertywindow').jqxWindow({
                    width: '60%',
                    height: '62%',
                    maxHeight: '75%',
                    maxWidth: '70%',
                    title: 'Property Search',
                    position: {
                        x: 250,
                        y: 60
                    },
                    keyboardCloseKey: 27
                });
                $('#propertywindow').jqxWindow('close');
                $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
                $("#todate").jqxDateTimeInput({
                    width: '125px',
                    height: '15px',
                    formatString: "dd.MM.yyyy"
                });
                var fromdate=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 			var onemonthbefore=new Date(new Date(fromdate).setMonth(fromdate.getMonth()-1)); 
     			$('#fromdate').jqxDateTimeInput('setDate', new Date(onemonthbefore));
	 			
	 			$('#todate').on('change', function (event) {
		   			var startdate=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 	 		var enddate=new Date($('#todate').jqxDateTimeInput('getDate'));
		   			if(startdate>enddate){
			   			$.messager.alert('Message','To Date Less Than From Date  ','warning');   
		   				return false;
		  			}   
	 			});

                $('#property').dblclick(function() {
                    propertySearchContent('pmainsearch.jsp');
                });
                $('#tenant').dblclick(function() {
					tenantSearchContent('tmainsearch.jsp');
                });
            });

            function funExportBtn() {
            	if(document.getElementById("optsummary").checked==true){
            		$("#summarydiv").excelexportjs({
						containerid: "summarydiv",
						datatype: 'json',
						dataset: null,
						gridId: "summaryGrid",
						columns: getColumns("summaryGrid"),
						worksheetName: "Inspection Analysis Summary"
					});
            	}
            	else if(document.getElementById("optdetail").checked==true){
            		$("#detaildiv").excelexportjs({
						containerid: "detaildiv",
						datatype: 'json',
						dataset: null,
						gridId: "detailGrid",
						columns: getColumns("detailGrid"),
						worksheetName: "Inspection Detail Analysis"
					});	
            	}
                
            }

            function getProperty(event) {
                var x = event.keyCode;
                if (x == 114) {
                    propertySearchContent('pmainsearch.jsp');
                }
			}

            function getTenant(event) {
                var x = event.keyCode;
                if (x == 114) {
                    tenantSearchContent('tmainsearch.jsp');
                }
            }

            function propertySearchContent(url) {
                $('#propertywindow').jqxWindow('open');
                $.get(url).done(function(data) {
                    $('#propertywindow').jqxWindow('setContent', data);
                });
            }
			
			function tenantSearchContent(url) {
                $('#tenantwindow').jqxWindow('open');
                $.get(url).done(function(data) {
                    $('#tenantwindow').jqxWindow('setContent', data);
                });
            }
            
            function funreload(event) {
				var fromdate=new Date($('#fromdate').jqxDateTimeInput('getDate'));
				var todate=new Date($('#todate').jqxDateTimeInput('getDate'));
				if(fromdate>todate){
					$.messager.alert('Message','To Date Less Than From Date  ','warning');   
					return false;
                } 
                var branch=document.getElementById("cmbbranch").value;
                var tenantdocno = document.getElementById("hidtenant").value;
                var propdocno = document.getElementById("hidproperty").value;
                var fromdate =$('#fromdate').jqxDateTimeInput('val');
                var todate = $('#todate').jqxDateTimeInput('val');
                var summarytype=$('#cmbsummarytype').val();
				$("#overlay, #PleaseWait").show();
                if(document.getElementById("optsummary").checked==true){
            		$("#summarydiv").load("summaryGrid.jsp?branch=" + branch + "&tenantdocno=" + tenantdocno + "&propdocno=" + propdocno + "&fromdate=" + fromdate + "&todate=" + todate + "&id=1&summarytype="+summarytype);
            	}
            	else if(document.getElementById("optdetail").checked==true){
            		$("#detaildiv").load("detailGrid.jsp?branch=" + branch + "&tenantdocno=" + tenantdocno + "&propdocno=" + propdocno + "&fromdate=" + fromdate + "&todate=" + todate + "&id=1");	
            	}
                

            }

            function funcleardata() {
               	$('#tenant,#hidtenant,#property,#hidproperty').val('');
               	$('#detailGrid').jqxGrid('clear');
               	$('#summaryGrid').jqxGrid('clear');
               	$('#fromdate,#todate').jqxDateTimeInput('setDate',new Date());
               	var fromdate=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 			var onemonthbefore=new Date(new Date(fromdate).setMonth(fromdate.getMonth()-1)); 
     			$('#fromdate').jqxDateTimeInput('setDate', new Date(onemonthbefore));
            }
            function setReportType(){
            	if(document.getElementById("optsummary").checked==true){
            		$('#summarydiv').show();
            		$('#detaildiv').hide();
            	}
            	else if(document.getElementById("optdetail").checked==true){
            		$('#summarydiv').hide();
            		$('#detaildiv').show();
            	}
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
                                            <label class="branch">From</label>
                                        </td>
                                        <td align="left">
                                            <div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <label class="branch">To</label>
                                        </td>
                                        <td align="left">
                                            <div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td align="right">
                                            <label class="branch">Tenant</label>
                                        </td>
                                        <td>
                                            <input type="hidden" name="hidtenant" id="hidtenant" value='<s:property value="hidtenant"/>'>
                                            <input type="text" name="tenant" id="tenant" value='<s:property value="tenant"/>' readonly="readonly" placeholder="Press F3 To Search" style="width:80%;height:20px;" onKeyDown="getTenant(event);"> </td>
                                    </tr>

                                    <tr>
                                        <td align="right">
                                            <label class="branch">Property </label>
                                        </td>
                                        <td>
                                            <input type="hidden" name="hidproperty" id="hidproperty" value='<s:property value="hidproperty"/>'>
                                            <input type="text" readonly="readonly" name="property" id="property" value='<s:property value="property"/>' placeholder="Press F3 To Search" style="width:80%;height:20px;" onKeyDown="getProperty(event);"> </td>
                                    </tr>

                                    <tr>
                                        <td align="right">
                                            <label class="branch">Type</label>
                                        </td>
                                        <td>
                                        	<label class="radio-inline"><input type="radio" name="opttype" checked id="optsummary" onChange="setReportType();"><span style="padding-left:15px;">Summary</span></label>
											<label class="radio-inline"><input type="radio" name="opttype" id="optdetail"  onChange="setReportType();"><span style="padding-left:15px;">Detail</span></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <label class="branch">Summary Type</label>
                                        </td>
                                        <td>
                                        	<select id="cmbsummarytype">
                                        		<option value="M">Monthly</option>
                                        		<option value="Y">Yearly</option>
                                        	</select>
                                        </td>
                                    </tr>
									<tr>
                                        <td colspan="2">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td align="center" colspan="2">
                                            <input type="button" class="myButtons" name="clear" id="clear" value="Clear" onclick="funcleardata()">
                                        </td>
                                    </tr>

                                    <tr>
                                        <td colspan="2">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">&nbsp; <label id="mess" name="mess" style="color: red; font-weight: bold; position: absolute; font-size:15px; ">
                                        Colored Lines are Pending for Confirmation</label></td>
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
                                            <div id='paychaaaaa' style="width: 100% ; align:right; height:90px;"></div>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                        <td width="80%">
                            <table width="100%">
                                <tr>
                                    <td colspan="2">
                                    	<div id="summarydiv">
                                    		<jsp:include page="summaryGrid.jsp"></jsp:include>
                                    	</div>
                                        <div id="detaildiv" hidden="true">
                                            <jsp:include page="detailGrid.jsp"></jsp:include>
                                        </div>
                                    </td>
                                </tr>
                            </table>
						</td>
                    </tr>
                </table>
            </div>

            <div id="tenantwindow">
                <div></div>
            </div>
            <div id="propertywindow">
                <div></div>
            </div>
        </div>
    </body>

    </html>