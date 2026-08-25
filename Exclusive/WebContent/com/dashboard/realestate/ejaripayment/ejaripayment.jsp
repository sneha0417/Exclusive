
<jsp:include page="../../../../includes.jsp"></jsp:include>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GatewayERP(i)</title>
    <link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.24.4/dist/sweetalert2.all.min.js"></script>
    <style type="text/css">
        .hidden-scrollbar {
            height: 500px;
            overflow: auto;
        }
        
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
        
        legend.scheduler-border {
            width: inherit;
            /* Or auto */
            padding: 0 10px;
            /* To give a bit of padding on the left and right */
            border-bottom: none;
        }
    </style>

    <script type="text/javascript">
        $(document).ready(function() {
                    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
                    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
                    $('#accountSearchwindow').jqxWindow({
                        width: '60%',
                        height: '62%',
                        maxHeight: '75%',
                        maxWidth: '70%',
                        title: 'Account Search',
                        position: {
                            x: 250,
                            y: 60
                        },
                        keyboardCloseKey: 27
                    });
                    $('#accountSearchwindow').jqxWindow('close');
                    $("#podate").jqxDateTimeInput({
                        width: '125px',
                        height: '15px',
                        formatString: "dd.MM.yyyy"
                    });
                    /* $("#fromdate").jqxDateTimeInput({
                        width: '125px',
                        height: '15px',
                        formatString: "dd.MM.yyyy"
                    });
                    $("#todate").jqxDateTimeInput({
                        width: '125px',
                        height: '15px',
                        formatString: "dd.MM.yyyy"
                    });
                    var fromdates = new Date($('#fromdate').jqxDateTimeInput('getDate'));
                    var onemounth = new Date(new Date(fromdates).setMonth(fromdates.getMonth() - 1));
                    $('#fromdate').jqxDateTimeInput('setDate',new Date(onemounth));
                    $('#todate').on('change',function(event) {
                                var fromdates = new Date($('#fromdate').jqxDateTimeInput('getDate'));
                                // out date
                                var todates = new Date($('#todate').jqxDateTimeInput('getDate')); //del date
                                if (fromdates > todates) {
                                    $.messager
                                        .alert(
                                            'Message',
                                            'To Date Less Than From Date  ',
                                            'warning');

                                    return false;
                                }
                            }); */

                    $("#podate").val(new Date());
                    $('#bankaccid')
                        .dblclick(
                            function() {

                                accountSearchContent('AccountDetailsSearch.jsp?id=2');

                            });
                    $('#cashaccid')
                        .dblclick(
                            function() {

                                accountSearchContent('AccountDetailsSearch.jsp?id=1');

                            });

                });

        function funExportBtn() {

        }

        function getaccountdetails1(event) {
            var x = event.keyCode;

            if (x == 114) {

                accountSearchContent('AccountDetailsSearch.jsp?id=1');
            } else {}

        }

        function getaccountdetails2(event) {
            var x = event.keyCode;

            if (x == 114) {

                accountSearchContent('AccountDetailsSearch.jsp?id=2');
            } else {}

        }

        function accountSearchContent(url) {
            //alert(url);
            $('#accountSearchwindow').jqxWindow('open');
            $.get(url).done(function(data) {
                //alert(data);
                $('#accountSearchwindow').jqxWindow('setContent', data);

            });
        }

        function funreload(event) {

          /*   var fromdates = new Date($('#fromdate').jqxDateTimeInput('getDate'));

            // out date
            var todates = new Date($('#todate').jqxDateTimeInput('getDate')); //del date

            if (fromdates > todates) {

                $.messager.alert('Message', 'To Date Less Than From Date  ',
                    'warning');

                return false;
            } else { */
                var barchval = document.getElementById("cmbbranch").value;
                var fromdate = "";
                var todate = "";

                var statusselect = "";

                var aa = "yes";
                
                $("#overlay, #PleaseWait").show();
                $("#listdiv").load(
                    "mainGrid.jsp?barchval=" + barchval + "&fromdate=" + fromdate + "&todate=" + todate + "&statusselect=" + statusselect + "&aa=" + aa);

            
        }

        function funupdategrid() {
           /*  var nettotal = $("#paymentDistributionGridId").jqxGrid('getcolumnaggregateddata', 'amount', ['sum'], true);

            var tot = Math.round(nettotal.sum.replace(/,/g, '')).toFixed(2);

            $('#txtnettotal').val(tot);

            var mtotal = $('#txtmainnettotal').val();
            var pgridtotal = $('#txtnettotal').val(); */

            /* console.log("mtotal="+mtotal);
            console.log("pgridtotal="+pgridtotal); */

           /*  if (mtotal != pgridtotal) {
                //$('#warningModal').modal('toggle');
                $.messager.alert('warning', 'Net total is not the same. Net Total =' + mtotal);
                return false;
            } else { */
                var chkpaymentmode, chkpaidto;
                /* var rows = $('#paymentDistributionGridId').jqxGrid('getrows');
                for (var m = 0; m < rows.length; m++) {
                    chkpaymentmode = $("#paymentDistributionGridId").jqxGrid('getcellvalue', m, 'paymentmethod');
                    chkpaidto = $("#paymentDistributionGridId").jqxGrid('getcellvalue', m, 'paidto');
                    console.log("paymentmode=" + chkpaymentmode);
                    console.log(chkpaidto);
                    if (chkpaymentmode == "Cash" && chkpaidto == "Owner") {
                        $.messager.alert('warning', 'Please select Self when the payment mode is Cash');
                        return false;
                    }
                } */

                $('#searshgrid1').jqxGrid('clearfilters', true);
                var rdocno = $('#prdocno').val();
                var amnt=$('#amount').val();
                var aa = 0;
                var gridarray = new Array();
                var rows = $("#searshgrid1").jqxGrid('getrows');
                var rows1 = $("#searshgrid1").jqxGrid('getselectedrowindexes'); 
               /*  var rows = $("#searshgrid1").jqxGrid('getrows'); */
               // alert("rows======"+rows.length);
                $('#paymentgridlength').val(rows.length);
                for (var i = 0; i <=rows1.length-1; i++) {
                	var j=rows1[i];
                	 //alert("rows======"+j); 
                    gridarray.push(rows[j].doc_no + "::" + rows[j].pymt + "::");
                }

                var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText.trim();
                        if (items == "success") {
                            swal({
                                type: 'success',
                                title: 'Success',
                                text: 'Successfully Updated'
                            });
                            //console.log("true");
                           // $("#listdiv2").load("paymentDistributionGrid.jsp?docno=" + rdocno);
                           funreload(event);
                        } else {
                            swal({
                                type: 'error',
                                title: 'Error',
                                text: 'Not Updated'
                            });
                            /* console.log("false"); */
                        }
                    } else {}
                }

                 x.open("GET", "updatepaymentgrid.jsp?gridarray=" + gridarray + "&amount=" + amnt, true);
                x.send(); 

            
        }

        function funupdate() {

            var cashacno = document.getElementById("cashacno").value;
            var podate = document.getElementById("podate").value;
            
            var listss = new Array();
            var listss1 = new Array();
            var cashacno = document.getElementById("cashaccid").value;
            
            $('#searshgrid1').jqxGrid('clearfilters', true);
            
            //alert("cashacno==="+cashacno);
            if(cashacno==""){
            	$.messager.alert('Message','Account is Mandatory','warning');
            	return 0;
            }

                
						/* var selectedrows = $("#termsOfContractGridId").jqxGrid('getrows');
                        for (var i = 0; i < selectedrows.length; i++) {
                        	listss.push($("#termsOfContractGridId") .jqxGrid('getcellvalue', selectedrows[i], 'description') + "::" + $("#termsOfContractGridId") .jqxGrid('getcellvalue', selectedrows[i], 'qty') + "::" + $("#termsOfContractGridId") .jqxGrid('getcellvalue', selectedrows[i], 'amount') + "::" + $("#termsOfContractGridId") .jqxGrid('getcellvalue', selectedrows[i], 'vatper') + "::" + $("#termsOfContractGridId") .jqxGrid('getcellvalue', selectedrows[i], 'vatvalue') + "::" + $("#termsOfContractGridId") .jqxGrid('getcellvalue', selectedrows[i], 'total') + "::" + $("#termsOfContractGridId") .jqxGrid('getcellvalue', selectedrows[i], 'atype') + "::" + $("#termsOfContractGridId") .jqxGrid('getcellvalue', selectedrows[i], 'acno') + "::" + $("#termsOfContractGridId") .jqxGrid('getcellvalue', selectedrows[i], 'ftype') + "::");
                        }

                        // payment distribution grid
                        var selectedrows1 = $("#paymentDistributionGridId").jqxGrid('getrows');
						for (var i = 0; i < selectedrows1.length; i++) {
                        	var paidto = $("#paymentDistributionGridId").jqxGrid('getcellvalue',selectedrows1[i], 'paidto');
							var paymentmethod = $("#paymentDistributionGridId").jqxGrid('getcellvalue',selectedrows1[i],'paymentmethod');
                            var acno = 0;
                            var curid = 1;
                            var rate = 1;
                            var ftype = "0";
							if (paymentmethod == "Cash" && paidto == "Self") {
                            if (cashacno == "") {
                            	$.messager.alert('Message','Cash Account Is Mandatory','warning');
                                return 0;
                            }

                                        acno = document
                                            .getElementById("cashacno").value;

                                        if (document.getElementById("currs1").value == "0" || document
                                            .getElementById("currs1").value == "" || document
                                            .getElementById("currs1").value == 0) {
                                            curid = 1;
                                        } else {
                                            curid = document
                                                .getElementById("currs1").value;
                                        }
                                        if (document.getElementById("ratess1").value == "0" || document
                                            .getElementById("ratess1").value == "" || document
                                            .getElementById("ratess1").value == 0) {
                                            rate = 1;
                                        } else {
                                            rate = document
                                                .getElementById("ratess1").value;
                                        }

                                        ftype = "111";
                                    } else if (paymentmethod == "Bank" && paidto == "Self") {
                                        if (bankacno == "") {
                                            $.messager
                                                .alert(
                                                    'Message',
                                                    'Bank Account Is Mandatory',
                                                    'warning');
                                            return 0;
                                        }

                                        acno = document
                                            .getElementById("bankacno").value;
                                        if (document.getElementById("currs2").value == "0" || document
                                            .getElementById("currs2").value == "" || document
                                            .getElementById("currs2").value == 0) {
                                            curid = 1;
                                        } else {
                                            curid = document
                                                .getElementById("currs2").value;
                                        }
                                        if (document.getElementById("ratess2").value == "0" || document
                                            .getElementById("ratess2").value == "" || document
                                            .getElementById("ratess2").value == 0) {
                                            rate = 1;
                                        } else {
                                            rate = document
                                                .getElementById("ratess2").value;
                                        }

                                        ftype = "222";
                                    } else if (paidto == "Owner") {;

                                        ftype = "333";
                                    }

                                    listss1.push($("#paymentDistributionGridId").jqxGrid('getcellvalue',selectedrows1[i],'description') + "::" + $("#paymentDistributionGridId").jqxGrid('getcellText',selectedrows1[i],'date') + "::" + $("#paymentDistributionGridId").jqxGrid( 'getcellvalue', selectedrows1[i], 'amount') + "::" + $( "#paymentDistributionGridId") .jqxGrid( 'getcellvalue', selectedrows1[i], 'notes') + "::" + $( "#paymentDistributionGridId") .jqxGrid( 'getcellvalue', selectedrows1[i], 'chqno') + "::" + $( "#paymentDistributionGridId") .jqxGrid( 'getcellvalue', selectedrows1[i], 'paidto') + "::" + $( "#paymentDistributionGridId") .jqxGrid( 'getcellvalue', selectedrows1[i], 'paymentmethod') + "::" + acno + "::" + curid + "::" + rate + "::" + ftype + "::" + $( "#paymentDistributionGridId") .jqxGrid( 'getcellvalue', selectedrows1[i], 'doc_no') + "::" + $( "#paymentDistributionGridId") .jqxGrid( 'getcellvalue', selectedrows1[i], 'rdocno') + "::");
                                } */

                                savegriddata(listss, listss1, podate);
     
            
        }

        function savegriddata(listss, listss1, podate) {
        	
        	//console.log("List:"+listss);
            var docno = document.getElementById("masterdocno").value;
            var description = document.getElementById("descr").value;
            var cashacno = document.getElementById("cashaccid").value;
           
            var totsum=0;
            var gridarray = new Array();
            var gridarray2 = new Array();
            //[1100::1::1.0::false::-1500.0::::-1500.0::0::0::0      ,       0::1::1.0::true::0.0::::0.0::0.0::0::0    ,   5716::1::1::true::1500::::1500::0:: :: ]
           
            var rows = $("#searshgrid1").jqxGrid('getrows');
            var rows1 = $("#searshgrid1").jqxGrid('getselectedrowindexes'); 
           /*  var rows = $("#searshgrid1").jqxGrid('getrows'); */
           // alert("rows======"+rows.length);
            $('#paymentgridlength').val(rows.length);
            for (var i = 0; i <=rows1.length-1; i++) {
            	var j=rows1[i];
            	 var payval=rows[j].pymt;
            	totsum+=rows[j].pymt;
            	if(parseFloat(payval)>0){
                gridarray.push(rows[j].doc_no + "::" + rows[j].pymt + "::"+ rows[j].voc_no + "::"+ rows[j].refname + "::");
            	}else{
            		$.messager.alert('Message','Update Payment Amount','warning');
            		return 0;
            	}
            }
            //alert("totsum======"+totsum);
            
             //gridarray2.push(cashacno+"::"+"1"+"::"+"1.0"+"::"+"false"+"::"+totsum*-1+"::"+description+"::"+totsum*-1+"::"+"0"+"::"+"0"+"::"+"0"+"::"+","+0+"::"+1+"::"+1.0+"::"+true+"::"+0.0+"::"+description+"::"+0.0+"::"+0.0+"::"+0+"::"+0+"::"+","+"5716"+"::"+1+"::"+1+"::"+true+"::"+totsum*-1+"::"+"0"+"::"+totsum*-1+"::"+0+"::"+"0"+"::");
            
             var branchids = document.getElementById("brhid").value;
             $.messager.confirm('Message','Do you want to save changes?',function(r) {
					if (r == false) {
                 	return false;
					} else {
						$("#overlay, #PleaseWait").show();
			var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {

                    var items = x.responseText.trim().split("##");
                   // alert(items);
                   var msg=items[0].split("##");
                 
                    if (msg>0) {
                        var doc=items[1].split("##");
                        //alert("doc====="+doc);
                        $.messager.alert('Message', 'CPV-'+doc+' Successfully Generated');
                        funreload(event);
                        $("#podate").val(new Date());
						$("#overlay, #PleaseWait").hide();
                        disitems(0);
                        funcleardata();

                    } else {
                    	$("#overlay, #PleaseWait").hide();
                        $.messager.alert('Message', ' Not Updated ');
                    }

                }
            }

            x.open("GET", "savedata.jsp?totsum=" + totsum + "&branchids=" + branchids + "&desc=" + description + "&cashacno=" + cashacno + "&aa=2" + "&podate=" + podate+"&agentarray="+gridarray, true);

            x.send();
					}
			});
        }

		function funmarkasposted(){
			
            var gridarray = new Array();
            var rows = $("#searshgrid1").jqxGrid('getrows');
            var rows1 = $("#searshgrid1").jqxGrid('getselectedrowindexes'); 
            $('#paymentgridlength').val(rows.length);
            for (var i = 0; i <=rows1.length-1; i++) {
            	var j=rows1[i];
            	gridarray.push(rows[j].doc_no + "::");
            }
           
            $.messager.confirm('Message','Do you want to save changes?',function(r) {
					if (r == false) {
                 	return false;
					} else {
						$("#overlay, #PleaseWait").show();
						var x = new XMLHttpRequest();
						x.onreadystatechange = function() {
							if (x.readyState == 4 && x.status == 200) {
			
								var items = x.responseText.trim();
								if (parseInt(items)==0) {
									$.messager.alert('Message', 'Successfully Updated');
									funreload(event);
									$("#overlay, #PleaseWait").hide();
								}else {
									$("#overlay, #PleaseWait").hide();
									$.messager.alert('Message', ' Not Updated');
								}
							}
						}
			
						x.open("GET", "updatepostingstatus.jsp?agentarray="+gridarray, true);
						x.send();
					}
			});
		}

        function disitems(val) {

           /*  $('#Update').attr("disabled", true); */

        }

        function funcleardata() {
            document.getElementById("cashacno").value = "";
            document.getElementById("cashaccid").value = "";
            document.getElementById("caccname").value = "";
            document.getElementById("currs1").value = "";
            document.getElementById("descr").value = "";
            document.getElementById("ratess1").value = "";
			$('#agentGridId').jqxGrid('clear');
            document.getElementById("bankacno").value = "";
            document.getElementById("bankaccid").value = "";
            document.getElementById("baccname").value = "";
            document.getElementById("currs2").value = "";
            document.getElementById("ratess2").value = "";
            $('#cashaccid').attr('placeholder', 'Press F3 TO Search');
            $('#bankaccid').attr('placeholder', 'Press F3 TO Search');

        }
    </script>
</head>

<body onload="getBranch();disitems(0);">
    <div id="mainBG" class="homeContent" data-type="background">
        <div class='hidden-scrollbar'>
            <table width="100%">
                <tr>
                    <td width="20%" style="vertical-align: top;">
                        <fieldset style="background: #ECF8E0;">
                            <table width="100%">
                                <jsp:include page="../../heading.jsp"></jsp:include>
                                <%-- <tr>
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
                                    <td colspan="2">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td colspan="2">&nbsp;</td>
                                </tr>--%>
                             
                             
                                <tr>
                                 
                                    <td colspan="2">
                                    <fieldset>
                                        <legend class="scheduler-border">Update</legend>
                                           <table width="100%">
                                            <tr>
                                        <td align="center">Amount<input type="text" name="amount" id="amount" value='<s:property value="amount"/>'  style="width: 80%; height: 20px;" ></td>
                                        </tr>
                                           <tr>
                                           <td align="center">
                                        <input type="Button" name="Upategrid" id="Upategrid" class="myButton" value="Update Grid" onclick="funupdategrid()">
                                        </td>
                                        </tr>
                                       
                                        </table>
                                        
                                    </fieldset>
                                    </td>
                                    
                                </tr>
                               
                                
                              <!--   <tr>
                                    <td colspan="2">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td colspan="2">&nbsp;</td>
                                </tr> -->

                                <tr>

                                    <td colspan="2">
                                        <fieldset>
                                            <legend class="scheduler-border">Posting</legend>
                                            <table>
                                                <!-- <tr>
									<td colspan="2" style="text-align:center;padding-bottom:10px;">Posting</td>
								</tr>  -->
                                                <tr>
                                                    <td align="right">
                                                        <label class="branch">Cash </label>
                                                    </td>
                                                    <td>
                                                        <input type="hidden" name="cashacno" id="cashacno" value='<s:property value="cashacno"/>'>
                                                        <input type="text" name="cashaccid" id="cashaccid" value='<s:property value="cashaccid"/>' readonly="readonly" placeholder="Press F3 To Search" style="width: 80%; height: 20px;" onKeyDown="getaccountdetails1(event);">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>&nbsp;</td>
                                                    <td colspan="1">
                                                        <input type="text" id="caccname" name="caccname" value='<s:property value="caccname"/>' tabindex="-1" readonly="readonly" style="width: 100%; height: 20px;">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <label class="branch">Description </label>
                                                    </td>
                                                    <td>
                                                        <input type="text" name="descr" id="descr" value='<s:property value="descr"/>' style="width: 100%; height: 20px;">
                                                    </td>
                                                </tr>
                                                <%-- <tr>
                                                    <td align="right">
                                                        <label class="branch">Bank </label>
                                                    </td>
                                                    <td>
                                                        <input type="hidden" name="bankacno" id="bankacno" value='<s:property value="bankacno"/>'>
                                                        <input type="text" readonly="readonly" name="bankaccid" id="bankaccid" value='<s:property value="bankaccid"/>' placeholder="Press F3 To Search" style="width: 80%; height: 20px;" onKeyDown="getaccountdetails2(event);">
                                                    </td>
                                                </tr> --%>
                                                <%-- <tr>
                                                    <td>&nbsp;</td>
                                                    <td colspan="1">
                                                        <input type="text" id="baccname" name="baccname" value='<s:property value="baccname"/>' tabindex="-1" readonly="readonly" style="width: 100%; height: 20px;">
                                                    </td>
                                                </tr> --%>

                                                <tr>
                                                    <td colspan="1" align="right">
                                                        <label class="branch">Date</label>
                                                    </td>
                                                    <td>
                                                        <div id='podate' name='podate' value='<s:property value="podate"/>'></div>
                                                    </td>
                                                </tr>

                                                <input name="currs1" type="hidden" id="currs1" style="width: 8%;" value='<s:property value="currs1"/>'>
                                                <input name="ratess1" type="hidden" id="ratess1" style="width: 7%;" value='<s:property value="ratess1 "/>'>

                                                <input name="currs2" type="hidden" id="currs2" style="width: 8%;" value='<s:property value="currs2"/>'>
                                                <input name="ratess2" type="hidden" id="ratess2" style="width: 7%;" value='<s:property value="ratess2 "/>'>

                                               

                                                <tr>
                                                    <td align="center" colspan="2">
                                                        <input type="button" class="myButtons" name="clear" id="clear" value="Clear" onclick="funcleardata()"> &nbsp; &nbsp; &nbsp;
                                                        <input type="Button" name="Update" id="Update" class="myButton" value="Post" onclick="funupdate()">
                                                    </td>
                                                </tr>
												
												   <tr>
                                                    <td align="center" colspan="2">
                                                        <input type="Button" name="MarkAsPosted" id="MarkAsPosted" class="myButton" value="Mark As Posted" onclick="funmarkasposted()">
                                                    </td>
                                                </tr>

                                            </table>
                                        </fieldset>
                                    </td>

                                </tr>

                                
                                <tr>
                                    <td colspan="2">
                                        <div id='paychaaaaa' style="width: 100%; align: right; height: 90px;"></div>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                        <input type="hidden" id="acno" name="acno" value='<s:property value="acno"/>'>
                        <input type="hidden" id="brhid" name="brhid" value='<s:property value="brhid"/>'>
                        <input type="hidden" id="reftype" name="reftype" value='<s:property value="reftype"/>'>

                        <input type="hidden" id="txtmainnettotal" name="txtmainnettotal">

                        <input type="hidden" id="txtnettotal" name="txtnettotal">

                        <input type="hidden" id="prdocno" name="prdocno">

                    </td>
                    <td width="80%">
                        <table width="100%">
                            <tr>
                                <td colspan="2">
                                    <div id="listdiv">
                                        <jsp:include page="mainGrid.jsp"></jsp:include>
                                    </div>
                                </td>
                            </tr>
                           <%--  <tr>
                                <td colspan="2" style="text-align:center;">Payment Distribution</td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <div id="listdiv2">
                                        <jsp:include page="paymentDistributionGrid.jsp"></jsp:include>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                            	<td>Terms of Contract</td>
                            	<td>Agent Details</td>
                            </tr>
                            <tr>
                            	<td>
                           			<div id="listdiv1"><jsp:include page="termsOfContractGrid.jsp"></jsp:include></div>
                            	</td>
                            	<td>
                           			<div id="agentdiv"><jsp:include page="agentGrid.jsp"></jsp:include></div>
                            	</td>
                            </tr> --%>
						</table>
					</td>
                </tr>
            </table>
            <input type="hidden" id="masterdocno" name="masterdocno" value='<s:property value="masterdocno"/>'>

        </div>

        <div id="accountSearchwindow">
            <div></div>
        </div>
    </div>

    <!-- warning modal -->
    <div class="modal fade" id="warningModal" role="dialog">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header" style="background:#ff7600e0;padding:0 15px;">
                    <h4 style="text-align:center;color:#FFF;">Warning ! <button type="button" class="close" data-dismiss="modal" aria-label=""><span>×</span></button></h4>
                </div>

                <div class="modal-body">
                    <div class="thank-you-pop">
                        <h5>net total not same</h5>
                        <button type="button" class="btn btn-default" data-dismiss="modal" aria-label=""><span>close</span></button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Warning modal -->
</body>

</html>