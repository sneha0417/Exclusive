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
            /*  $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"}); */
            $("#todate").jqxDateTimeInput({
                width: '125px',
                height: '15px',
                formatString: "dd.MM.yyyy"
            });
            $("#postdate").jqxDateTimeInput({
                width: '125px',
                height: '15px',
                formatString: "dd.MM.yyyy"
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
 			$('#postdate').on('change', function (event) 
			{  
				var postdateval=funDateInPeriod($('#postdate').jqxDateTimeInput('getDate'));
				if(postdateval==0){
					$('#postdate').jqxDateTimeInput('focus');
					return false;
				}
			});
		});

        function funExportBtn() {
        	
        }

        function funreload(event) {
			var todate=$('#todate').jqxDateTimeInput('val');
			var branch=$('#cmbbranch').val();
			
            $("#overlay, #PleaseWait").show();
            $("#contractdiv").load("contractGrid.jsp?branch="+branch+"&todate="+todate+"&id=1");
            $('#jvdiv').load('jvGrid.jsp?docno=0');
        }

        function funupdate() {
        	 $.messager.confirm('Message', 'Do you want to create JV?', function(r){     
 		     	if(r==false)
 		     	  {
 		     		return false; 
 		     	  }  
 		     	else {
 		     		funupdate1();      
 		     	}  
 		 }); 
        }
        function funupdate1() {
            var postdateval=funDateInPeriod($('#postdate').jqxDateTimeInput('getDate'));
			if(postdateval==0){
				$('#postdate').jqxDateTimeInput('setDate',new Date());
				$('#postdate').jqxDateTimeInput('focus');
				return false;
			}
            var docno=$('#docno').val();
        	var jvdesc=$('#jvdesc').val();
        	//jvdesc=encodeURIComponent(jvdesc);  
        	if(docno==''){
        		$.messager.alert('Warning','Please select any document');
        		return false;
        	}
        	var jvdate=$('#postdate').jqxDateTimeInput('val');
        	var paymentrows=$('#jqxPaymentGrid').jqxGrid('getrows');
        	var gridarray=new Array();
        	console.log(paymentrows.length);  
        	for(var i=0;i<paymentrows.length;i++){
        		$('#hiddescription').val("TA "+docno+" "+$('#jvdesc').val() +" "+$('#jqxPaymentGrid').jqxGrid('getcellvalue',i,'notes')+" "+$('#jqxPaymentGrid').jqxGrid('getcelltext',i,'date')+" "+$('#jqxPaymentGrid').jqxGrid('getcelltext',i,'chqno'));    
		 		if ($('#hiddescription').val().indexOf('"') >= 0) { $('#hiddescription').val($('#hiddescription').val().replace(/["']/g, ''));};
				if (($('#hiddescription').val()).includes(',')) { $('#hiddescription').val($('#hiddescription').val().replace(/,/g, ''));}
		 		var date=$('#jqxPaymentGrid').jqxGrid('getcelltext',i,'date');
        		var amount=$('#jqxPaymentGrid').jqxGrid('getcellvalue',i,'amount');
        		var notes=$('#jqxPaymentGrid').jqxGrid('getcelltext',i,'notes');
        		var paymentmethod=$('#jqxPaymentGrid').jqxGrid('getcelltext',i,'paymentmethod');
        		var paidto=$('#jqxPaymentGrid').jqxGrid('getcelltext',i,'paidto');
        		var detaildocno=$('#jqxPaymentGrid').jqxGrid('getcelltext',i,'doc_no');
        		gridarray.push(paymentrows[i].description+"::"+date+"::"+amount+"::"+notes+"::"+paymentmethod+"::"+paidto+"::"+detaildocno+"::"+$('#hiddescription').val());
        		$('#hiddescription').val('');  
        	}
        	console.log(gridarray); 
			var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    if(items.split("::")[0]=="0"){
                    	$('#jqxPaymentGrid,#jvGrid').jqxGrid('clear');
                    	$('#jvdesc,#hiddescription').val('');
                    	$.messager.alert('Warning','Successfully Generated'+items.split("::")[1]);
                    	funreload("");
                    	
                    }
                    else{
                    	$.messager.alert('Warning','Not Generated');    
                    }
                    
                }
            }
            x.open("GET", "calculateJv.jsp?docno="+docno+"&gridarray="+encodeURIComponent(gridarray)+"&jvdesc="+encodeURIComponent(jvdesc)+"&jvdate="+jvdate, true);
            x.send();        	
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
                                    	<fieldset><legend><label class="branch"><strong>JV Details<strong></label></legend>
                                    		<table style="width:100%;">
                                    			<tr>
                                    				<td><label class="branch">Date</label></td>
                                    				<td><div id="postdate"></div></td>
                                    			</tr>
                                    			<tr>
                                    				<td><label class="branch">Description</label></td>
                                    				<td><input type="text" name="jvdesc" id="jvdesc" style="width:100%;"></td>
                                    			</tr>
                                    		</table>
                                    	</fieldset>
                                    </td>
                                </tr>

                                <tr>
                                    <td align="center" colspan="2">
										<input type="button" class="myButtons" name="clear" id="clear" value="Clear" onclick="funcleardata();">
                                        <input type="button" name="Update" id="Update" class="myButton" value="Create JV" onclick="funupdate();"> </td>
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
                        <input type="hidden" id="acno" name="acno" value='<s:property value="acno"/>'>
                        <input type="hidden" id="brhid" name="brhid" value='<s:property value="brhid"/>'>
          		        <input type="hidden" name="hiddescription" id="hiddescription">  
                        <input type="hidden" id="reftype" name="reftype" value='<s:property value="reftype"/>'>

                    </td>
                    <td width="80%">
                    	<div id="contractdiv"><jsp:include page="contractGrid.jsp"></jsp:include></div>
                    	<div id="paymentdiv"><jsp:include page="paymentGrid.jsp"></jsp:include></div>
                    	<br>
                    	<div id="jvdiv"><jsp:include page="jvGrid.jsp"></jsp:include></div>
                   	</td>
                </tr>
            </table>
            <input type="hidden" id="docno" name="docno" value='<s:property value="docno"/>'>
        </div>
    </div>
</body>

</html>