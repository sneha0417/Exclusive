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
			$('#existingbrvwindow').jqxWindow({
                width: '50%',
                height: '75%',
                maxHeight: '74%',
                maxWidth: '50%',
                title: 'Existing BRV Search',
                position: {
                    x: 100,
                    y: 60
                },
                keyboardCloseKey: 27
            });
            $('#existingbrvwindow').jqxWindow('close');
            $('#newbrvwindow').jqxWindow({
                width: '50%',
                height: '75%',
                maxHeight: '74%',
                maxWidth: '50%',
                title: 'New BRV Search',
                position: {
                    x: 100,
                    y: 60
                },
                keyboardCloseKey: 27
            });
            $('#newbrvwindow').jqxWindow('close');
            $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
            $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
            /*  $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"}); */
            $("#todate").jqxDateTimeInput({
                width: '125px',
                height: '15px',
                formatString: "dd.MM.yyyy"
            });
            $('#existingbrv,#newbrv').dblclick(function() {
            	if($(this).attr('id')=='existingbrv'){
            		$('#existingbrvwindow').jqxWindow('open');
            		var paymenttrno=$('#paymenttrno').val();
            		var tenantacno=$('#tenantacno').val();
					existingbrvSearchContent('brvExistingSearchGrid.jsp?type=0&id=1&paymenttrno='+paymenttrno+'&tenantacno='+tenantacno);
            	}
            	else if($(this).attr('id')=='newbrv'){
            		$('#newbrvwindow').jqxWindow('open');
            		var paymenttrno=$('#paymenttrno').val();
            		var tenantacno=$('#tenantacno').val();
					newbrvSearchContent('brvNewSearchGrid.jsp?type=1&id=1&paymenttrno='+paymenttrno+'&tenantacno='+tenantacno);
            	}
            });
            /*  
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
 			*/
 			
		});

        function funExportBtn() {
        	$("#contractdiv").excelexportjs({
				containerid: "contractdiv",
				datatype: 'json',
				dataset: null,
				gridId: "contractGrid",
				columns: getColumns("contractGrid"),
				worksheetName: "Contract PDC Update Data"
			});
        }

        function funreload(event) {
			var todate=$('#todate').jqxDateTimeInput('val');
			var branch=$('#cmbbranch').val();
			
            $("#overlay, #PleaseWait").show();
            $("#contractdiv").load("contractGrid.jsp?branch="+branch+"&todate="+todate+"&id=1");
            
        }

        function funupdate() {
            var contractdocno=$('#docno').val();
            var existingbrv=$('#hidexistingbrv').val();
            var newbrv=$('#hidnewbrv').val();
			var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    if(items=="0"){
                    	$('#existingbrv,#newbrv,#docno,#paymenttrno,#tenantacno').val('');
                    	$.messager.alert('Warning','Successfully Updated');
                    	funreload("");
                    }
                    else{
                    	$.messager.alert('Warning','Not Updated');
                    }
                    
                }
            }
            x.open("GET", "updateBRV.jsp?contractdocno="+contractdocno+"&existingbrv="+existingbrv+"&newbrv="+newbrv, true);
            x.send();        	
        }

        function funcleardata() {
			$('#todate').jqxDateTimeInput('setDate',new Date());
			$('#contractGrid').jqxGrid('clear');
			$('#existingbrv,#newbrv,#docno').val('');
			funreload("");
        }
        function getBRV(value,event){
        	var x = event.keyCode;
            if (x == 114) {
            	if(value=='0'){
	        		//Existing
	        		$('#existingbrvwindow').jqxWindow('open');
	        		var paymenttrno=$('#paymenttrno').val();
            		var tenantacno=$('#tenantacno').val();
					existingbrvSearchContent('brvExistingSearchGrid.jsp?type='+value+'&id=1');
	        	}
	        	else if(value=='1'){
	        		//New
	        		$('#newbrvwindow').jqxWindow('open');
	        		var paymenttrno=$('#paymenttrno').val();
            		var tenantacno=$('#tenantacno').val();
					newbrvSearchContent('brvNewSearchGrid.jsp?type='+value+'&id=1&paymenttrno='+paymenttrno+'&tenantacno='+tenantacno);
	        	}
            } else {}
        }
        
        function existingbrvSearchContent(url) {
            $.get(url).done(function(data) {
                $('#existingbrvwindow').jqxWindow('setContent', data);
            });
        }
        
        function newbrvSearchContent(url) {
            $.get(url).done(function(data) {
                $('#newbrvwindow').jqxWindow('setContent', data);
            });
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
                                    <td colspan="2">
                                   		<table style="width:100%;">
                                   			<tr>
                                   				<td><label class="branch">Existing BRV#</label></td>
                                   				<td><input type="text" name="existingbrv" id="existingbrv" placeholder="Press F3 to Search" onkeydown="getBRV(0,event);">
                                   					<input type="hidden" name="hidexistingbrv" id="hidexistingbrv">
                                   				</td>
                                   			</tr>
                                   			<tr>
                                   				<td><label class="branch">New BRV#</label></td>
                                   				<td><input type="text" name="newbrv" id="newbrv" placeholder="Press F3 to Search"  onkeydown="getBRV(1,event);">
                                   				<input type="hidden" name="hidnewbrv" id="hidnewbrv">
                                   				</td>
                                   			</tr>
                                   		</table>
                                    </td>
                                </tr>

                                <tr>
                                    <td align="center" colspan="2">
										<input type="button" class="myButtons" name="clear" id="clear" value="Clear" onclick="funcleardata();">
                                        <input type="button" name="Update" id="Update" class="myButton" value="Update" onclick="funupdate();"> </td>
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
                                        <div id='paychaaaaa' style="width: 100% ; align:right; height:120px;"></div>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                        <input type="hidden" id="acno" name="acno" value='<s:property value="acno"/>'>
                        <input type="hidden" id="brhid" name="brhid" value='<s:property value="brhid"/>'>
          		        <input type="hidden" name="hiddescription" id="hiddescription">  
                        <input type="hidden" id="reftype" name="reftype" value='<s:property value="reftype"/>'>

                    </td>
                    <td width="80%">
                    	<div id="contractdiv"><jsp:include page="contractGrid.jsp"></jsp:include></div>
                   	</td>
                </tr>
            </table>
            <input type="hidden" id="docno" name="docno" value='<s:property value="docno"/>'>
            <input type="hidden" id="tenantacno" name="tenantacno" value='<s:property value="tenantacno"/>'>
            <input type="hidden" id="paymenttrno" name="paymenttrno" value='<s:property value="paymenttrno"/>'>
        </div>
    </div>
    <div id="existingbrvwindow">
    	<div></div>
    </div>
    <div id="newbrvwindow">
    	<div></div>
    </div>
</body>

</html>