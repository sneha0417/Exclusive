<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../includes.jsp"></jsp:include>

<style>
/* =========================================================
SCOPED UI: Modern Layout (Matches Client Master)
========================================================= */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 24px 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 15px;
    max-width: 100%;
    margin: 0 auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding: 5px 15px;
    box-sizing: border-box;
    width: 100%;
}

.modern-ui form label.error {
    color: red;
    font-weight: bold;
}

/* Master Input Heights - Forced to 24px */
.modern-ui input[type="text"],
.modern-ui select { 
    height: 24px !important; 
    border: 1px solid #b8c6d8; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus { 
    border-color: #007bff; 
    outline: none;
}

.modern-ui input[readonly],
.modern-ui input:disabled,
.modern-ui select:disabled { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

/* Layout Utilities */
.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 10px; 
    flex-wrap: wrap;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Middle Section Panels */
.modern-ui .middle-panel {
    border: 1px solid #c5d3e0; 
    padding: 20px 10px 10px 10px; 
    background: #ffffff; 
    position: relative; 
    border-radius: 4px; 
    margin-bottom: 15px;
    margin-top: 12px;
}

.modern-ui .middle-panel-title { 
    position: absolute; 
    top: -12px;
    left: 10px; 
    background: #ffffff; 
    padding: 0 8px; 
    color: #0056b3;
    font-weight: bold; 
    font-size: 14px; 
    border-left: 3px solid #0056b3;
    z-index: 2; 
    line-height: normal; 
}

/* Custom UI Buttons matching 24px height */
.modern-ui .myButton {
    height: 24px !important;
    line-height: 22px !important;
    padding: 0 12px;
    font-family: Arial, sans-serif;
    font-size: 11px;
    font-weight: bold;
    border-radius: 3px;
    cursor: pointer;
    text-shadow: none;
    transition: all 0.2s;
    box-shadow: 0 1px 2px rgba(0,0,0,0.1);
    border: none;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    white-space: nowrap;
}
.modern-ui .myButton:hover { background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); }

/* Search Icon Wrapper */
.modern-ui .input-search-container {
    position: relative;
    display: flex;
}
.modern-ui .input-search-container input {
    padding-right: 25px !important;
}
.modern-ui .magnifier-icon {
    position: absolute;
    right: 6px; 
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: #64748b; 
    z-index: 10;
}
.modern-ui .magnifier-icon:hover { color: #2563eb; }

/* Grid Wrappers */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}

/* Scrollbar Logic */
.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 150px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }
</style>

<script type="text/javascript">
        $(document).ready(function() {
            getAccountTypeEntity();
            checkEdit();
            
            /* Formatted jqxDateTimeInput heights to match modern UI 24px */
            $("#nipurchasedate").jqxDateTimeInput({ width: '120px', height: 24, formatString: "dd.MM.yyyy", theme: 'energyblue'});
            $("#contractfromdate").jqxDateTimeInput({ width: '120px', height: 24, formatString: "dd.MM.yyyy", theme: 'energyblue'});
            $("#contracttodate").jqxDateTimeInput({ width: '120px', height: 24, formatString: "dd.MM.yyyy", theme: 'energyblue'});
            
            /* force internal alignment AFTER render */
            setTimeout(function () {
                $("#nipurchasedate, #contractfromdate, #contracttodate").find("input").css({
                    "margin-top": "0px",
                    "line-height": "24px",
                    "font-size": "12px", 
                    "font-family": "Arial, sans-serif", 
                    "padding": "0 6px", 
                    "box-sizing":"border-box"
                });
                $("#nipurchasedate, #contractfromdate, #contracttodate").find(".jqx-action-button").css({
                    "top": "0px",
                    "height": "24px"
                });
            }, 0);

            $('#nipurchasedate').on('change', function(event) {
                var maindate = $('#nipurchasedate').jqxDateTimeInput('getDate');
                if ($("#mode").val() == "A" || $("#mode").val() == "E") {
                    funDateInPeriod(maindate);
                }
            });

            $('#accountSearchwindow').jqxWindow({
                width: '50%',
                height: '75%',
                maxHeight: '74%',
                maxWidth: '50%',
                title: 'Account Search',
                position: {
                    x: 100,
                    y: 60
                },
                theme: 'energyblue',
                keyboardCloseKey: 27
            });
            $('#accountSearchwindow').jqxWindow('close');
            $('#accounttypeSearchwindow').jqxWindow({
                width: '60%',
                height: '62%',
                maxHeight: '75%',
                maxWidth: '70%',
                title: 'Account Search',
                position: {
                    x: 500,
                    y: 60
                },
                theme: 'energyblue',
                keyboardCloseKey: 27
            });
            $('#accounttypeSearchwindow').jqxWindow('close');
            $('#costtpesearchwndow').jqxWindow({
                width: '35%',
                height: '60%',
                maxHeight: '75%',
                maxWidth: '50%',
                title: 'Cost Type Search',
                position: {
                    x: 700,
                    y: 60
                },
                theme: 'energyblue',
                keyboardCloseKey: 27
            });
            $('#costtpesearchwndow').jqxWindow('close');
            $('#costcodesearchwndow').jqxWindow({
                width: '35%',
                height: '60%',
                maxHeight: '75%',
                maxWidth: '50%',
                title: 'Cost code Search',
                position: {
                    x: 800,
                    y: 60
                },
                theme: 'energyblue',
                keyboardCloseKey: 27
            });
            $('#costcodesearchwndow').jqxWindow('close');
            $('#refnosearchwindow').jqxWindow({
                width: '50%',
                height: '59%',
                maxHeight: '75%',
                maxWidth: '50%',
                title: 'Ref No Search',
                position: {
                    x: 450,
                    y: 40
                },
                theme: 'energyblue',
                keyboardCloseKey: 27
            });
            $('#refnosearchwindow').jqxWindow('close');
            $('#nipurchslnosearch').jqxWindow({
                width: '50%',
                height: '59%',
                maxHeight: '62%',
                maxWidth: '60%',
                title: ' Search',
                position: {
                    x: 200,
                    y: 60
                },
                theme: 'energyblue',
                keyboardCloseKey: 27
            });
            $('#nipurchslnosearch').jqxWindow('close');
            $('#printWindow').jqxWindow({
                width: '30%',
                height: '25%',
                maxHeight: '50%',
                maxWidth: '40%',
                title: 'Print',
                position: {
                    x: 300,
                    y: 87
                },
                theme: 'energyblue',
                showCloseButton: true,
                keyboardCloseKey: 27
            });
            $('#salespersonwindow').jqxWindow({
				width : '25%',
				height : '58%',
				maxHeight : '70%',
				maxWidth : '45%',
				title : '  Search',
				position : {
					x : 500,
					y : 87
				},
				theme: 'energyblue',
				showCloseButton : true,
				keyboardCloseKey : 27
			});
			$('#salespersonwindow').jqxWindow('close');
            $('#printWindow').jqxWindow('close');
            getCurrencyIds($("#nipurchasedate").val());

            $('#nipuraccid').dblclick(function() {
                if ($('#mode').val() != "view") {
                    $('#accountSearchwindow').jqxWindow('open');

                    accountSearchContent('accountDetailsFromSearch.jsp?type=' + $('#cmbtype').val());
                }
            });
        });

		function salespersonSearchContent(url) {
			$('#salespersonwindow').jqxWindow('open');
			$.get(url).done(function(data) {
				$('#salespersonwindow').jqxWindow('setContent', data);
				$('#salespersonwindow').jqxWindow('bringToFront');
			});
		}
        function getAccountTypeEntity() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                }
            }
            x.open("GET", "getAccountTypeEntity.jsp", true);
            x.send();
        }

		function checkEdit() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    if(items=="1"){
                    	$('#btnEdit').attr('disabled',true);
                    }
                    else{
                    	$('#btnEdit').attr('disabled',false);
                    }
                }
            }
            x.open("GET", "checkEdit.jsp?docno="+$('#masterdoc_no').val(), true);
            x.send();
        }
        function getNonTaxableEntity() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    $('#txtnontaxableentity').val(items);
                    if (parseInt($('#txtnontaxableentity').val().trim()) == 1) {
                        getTaxper($("#nipurchasedate").jqxDateTimeInput('val'));
                    }
                }
            }
            x.open("GET", "getNonTaxableEntity.jsp", true);
            x.send();
        }

        function getTaxper(date) {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    $('#taxperc').val(items);
                }
            }
            x.open("GET", "getTaxper.jsp?date=" + date, true);
            x.send();
        }

        function costcodeSearchContent(url) {
            $.get(url).done(function(data) {
                $('#costcodesearchwndow').jqxWindow('open');
                $('#costcodesearchwndow').jqxWindow('setContent', data);
            });
        }

        function costSearchContent(url) {
            $.get(url).done(function(data) {
                $('#costtpesearchwndow').jqxWindow('open');
                $('#costtpesearchwndow').jqxWindow('setContent', data);
            });
        }

        function CashSearchContent(url) {
            $.get(url).done(function(data) {
                $('#accounttypeSearchwindow').jqxWindow('open');
                $('#accounttypeSearchwindow').jqxWindow('setContent', data);
            });
        }

        function getaccountdetails(event) {
            var x = event.keyCode;
            if ($('#mode').val() != "view") {
                if (x == 114) {
                    $('#accountSearchwindow').jqxWindow('open');
                    accountSearchContent('accountDetailsFromSearch.jsp?type=' + $('#cmbtype').val());
                } else {}
            }
        }

        function accountSearchContent(url) {
            $.get(url).done(function(data) {
                $('#accountSearchwindow').jqxWindow('setContent', data);
            });
        }

        function nipurhsaeslnocontent(url) {
            $.get(url).done(function(data) {
                $('#nipurchslnosearch').jqxWindow('open');
                $('#nipurchslnosearch').jqxWindow('setContent', data);
            });
        }

        function funFocus() {
            $('#nipurchasedate').jqxDateTimeInput('focus');
        }

        function funNotify() {

            var maindate = $('#nipurchasedate').jqxDateTimeInput('getDate');
            var validdate = funDateInPeriod(maindate);
            if (validdate == 0) {
                return 0;
            }
            var rows = $('#nidescdetailsGrid').jqxGrid('getrows');
            var length = rows.length;
        
            if (typeof(rows[length - 1].nettotal) != "undefined" && (rows[length - 1].nettotal)!="" && (rows[length - 1].nettotal)!=NaN) {
                for (var i = length - 1; i >= 0; i--) {
                    if (((rows[i].netottal != "") || (rows[i].nettotal != "0.00")) && rows[i].account == "") {
                        document.getElementById("errormsg").innerText = " Select an Account";
                        return 0;
                        i = 0;
                    } else {
                        document.getElementById("errormsg").innerText = "";
                    }
                }
            } else {
                for (var i = length - 2; i >= 0; i--) {
                    if (((rows[i].nettotal != "") || (rows[i].nettotal != "0.00")) && rows[i].account == "") {
                        document.getElementById("errormsg").innerText = " Select an Account";
                        return 0;
                        i = 0;
                    } else {
                        document.getElementById("errormsg").innerText = "";
                    }
                }
            }
            
            var refno = document.getElementById('refno').value;
            if (refno == "") {
                document.getElementById("errormsg").innerText = " Enter Ref NO";
                document.getElementById('refno').focus();
                return 0;
            } else {
                document.getElementById("errormsg").innerText = "";
            }
            
            var purid = document.getElementById("nipuraccid").value;
            if (purid == "") {
                document.getElementById("errormsg").innerText = " Select An Account";
                document.getElementById("nipuraccid").focus();
                return 0;
            } else {
                document.getElementById("errormsg").innerText = "";
            }
            
            var refval = document.getElementById("nettotal").value;
            if (refval == "") {
                document.getElementById("errormsg").innerText = "Net Total Empty";
                return 0;
            } else {
                document.getElementById("errormsg").innerText = "";
            }
            var validrows = $("#nidescdetailsGrid").jqxGrid('getrows');
            var valtax = 0;
		    for(var i=0 ; i < validrows.length ; i++){  
		     	if(validrows[i].description!="" && validrows[i].description!="undefined" && validrows[i].description!=null && typeof(validrows[i].description)!="undefined"){
		     	if(validrows[i].taxper != 5 && validrows[i].taxper != 0){   
      		      valtax=1;
      		        }
		     	}
		    }
		    if(valtax==1){
		    	document.getElementById("errormsg").innerText = "Tax Percentage should be either 0 or 5.";
 		         return 0;  
		    }
            var rows = $("#nidescdetailsGrid").jqxGrid('getrows');
            $('#nidescdetailslenght').val(rows.length);
            for (var i = 0; i < rows.length; i++) {
                newTextBox = $(document.createElement("input"))
                    .attr("type", "dil")
                    .attr("id", "desctest" + i)
                    .attr("name", "desctest" + i)
                    .attr("hidden", "true");
                var aa = 0;
                newTextBox.val(rows[i].srno + "::" + rows[i].qty + " :: " + rows[i].description + " :: " + rows[i].unitprice + " :: " + rows[i].total + " :: " + rows[i].discount + " :: " + rows[i].nettotal + " :: " + rows[i].taxper + " :: " + rows[i].taxperamt + " :: " + Math.round((rows[i].taxamount + Number.EPSILON) * 100) / 100 + " :: " +  Math.round((rows[i].nuprice + Number.EPSILON) * 100) / 100 + " :: " + rows[i].costtype + " :: " + rows[i].costcode + " :: " + rows[i].remarks + " :: " + rows[i].headdoc + " :: " + aa + " :: " + rows[i].rowno + " :: ");
                newTextBox.appendTo('form');
            }
            var agentrows=$("#agentGridId").jqxGrid('getrows');
            var agentrowlength=0;
			var agentFlg=true;
            for(var i=0;i<agentrows.length;i++){
            	if(agentrows[i].salid!="" && agentrows[i].salid!="undefined" && agentrows[i].salid!=null && typeof(agentrows[i].salid)!="undefined"){
					if(agentrows[i].commamount!="" && agentrows[i].commamount!="undefined" && agentrows[i].commamount!=null && typeof(agentrows[i].commamount)!="undefined"){
					
            		newTextBox = $(document.createElement("input"))
                    .attr("type", "dil")
                    .attr("id", "agentarray" + i)
                    .attr("name", "agentarray" + i)
                    .attr("hidden", "true");
                	newTextBox.val(agentrows[i].salid + "::" + agentrows[i].commperc + " :: " + agentrows[i].commamount);
                	newTextBox.appendTo('form');
                	agentrowlength++;
					}else{
						agentFlg=false
					}
            	}
            }
			if (!agentFlg) {
                document.getElementById("errormsg").innerText = " Enter Commission % or Amount";
                return 0;
            } else {
                document.getElementById("errormsg").innerText = "";
            }
			
            $('#agentrowlength').val(agentrowlength);
            document.getElementById("errormsg").innerText = "";
            document.getElementById("frmPropertyInvoice").submit();
            
        }

        function funChkButton() {

        }

        function funSearchLoad() {
            changeContent('nipurchaseMastersearch.jsp');
        }

        function funReset() {
            //$('#frmPropertyInvoice')[0].reset(); 
        }

        function funReadOnly() {
            $('#frmPropertyInvoice input').attr('readonly', true);
            $('#frmPropertyInvoice select').attr('disabled', true);
            $('#nipurchasedate').jqxDateTimeInput({
                disabled: true
            });
            $('#interstate').attr('disabled', true);

            $('#cmbcurr').attr('disabled', true);
            $('#acctype').attr('disabled', true);
            $('#refslno').attr('disabled', true);
            $("#nidescdetailsGrid").jqxGrid({
                disabled: true
            });
            combochange();
            funinterstate();
        }

        function funRemoveReadOnly() {
            funinterstate();
            fungetterms();
            getNonTaxableEntity();
            $('#frmPropertyInvoice input').attr('readonly', false);
            $('#frmPropertyInvoice select').attr('disabled', false);
            $('#nipurchasedate').jqxDateTimeInput({
                disabled: false
            });
            $('#interstate').attr('disabled', false);
            $('#cmbcurr').attr('disabled', false);
            $('#acctype').attr('disabled', false);;
            $('#docno').attr('readonly', true);
            $('#currate').attr('readonly', true);
            $('#nipuraccid').attr('readonly', true);
            $('#puraccname').attr('readonly', true);
            $('#refslno').attr('disabled', true);
            $('#refslno').attr('readonly', true);

            $("#nidescdetailsGrid").jqxGrid({
                disabled: false
            });
            $('#agentGridId').jqxGrid({
                disabled: false
            });
            getCurrencyIds($("#nipurchasedate").val());

            if ($("#mode").val() == "A") {

                $('#nipurchasedate').val(new Date());
                getCurrencyIds($("#nipurchasedate").val());
                $("#nidescdetailsGrid,#agentGridId").jqxGrid('clear');
                $("#nidescdetailsGrid,#agentGridId").jqxGrid('addrow', null, {});
                $('#contractfromdate,#contracttodate').jqxDateTimeInput('setDate',new Date());
                $('#cmbreftype').val('TNC');
                $('#rentsalevalue').val(0.0);
            }
            if ($("#mode").val() == "E") {
            	$("#agentGridId").jqxGrid('addrow', null, {});
                if (document.getElementById("interstate").checked == true) {
                    document.getElementById("interstate").value = '1';

                } else {
                    document.getElementById("interstate").value = '0';
                }
                if ($('#reftypeval').val() == "NPO") {

                    $('#refno').attr('disabled', false);
                    $('#refslno').attr('disabled', false);
                    $('#refno').attr('readonly', true);
                    $('#refslno').attr('readonly', true);
                }

            }

        }

        function getCurrencyIds(a) {

            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    items = x.responseText;
                    items = items.split('####');
                    var curidItems = items[0];
                    var curcodeItems = items[1];
                    var currateItems = items[2];
                    var multiItems = items[3];
                    var optionscurr = '';

                    if (curcodeItems.indexOf(",") >= 0) {
                        var currencyid = curidItems.split(",");
                        var currencycode = curcodeItems.split(",");
                        multiItems.split(",");

                        for (var i = 0; i < currencycode.length; i++) {
                            optionscurr += '<option value="' + currencyid[i] + '">' + currencycode[i] + '</option>';
                        }

                        $("select#cmbcurr").html(optionscurr);

                        if ($('#hidcmbcurr').val() != null && $('#hidcmbcurr').val() != "") {
                            $('#cmbcurr').val($('#hidcmbcurr').val());
                        }

                        if (document.getElementById("masterdoc_no").value == "") {

                            funRoundRate(currateItems, "currate");
                        }
                        $('#currate').attr('readonly', true);

                    } else {
                        optionscurr += '<option value="' + curidItems + '"selected>' + curcodeItems + '</option>';

                        $("select#cmbcurr").html(optionscurr);

                        if ($('#hidcmbcurr').val() != null && $('#hidcmbcurr').val() != "") {
                            $('#cmbcurr').val($('#hidcmbcurr').val());
                        }
                        if (document.getElementById("masterdoc_no").value == "") {

                            funRoundRate(currateItems, "currate");
                        }

                        $('#currate').attr('readonly', true);

                    }
                }
            }
            x.open("GET", "getCurrencyId.jsp?date=" + a, true);
            x.send();

        }

        function getRatevalue(angel) {

            if (document.getElementById("masterdoc_no").value > 0) {
                return 0;
            }

            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText;

                    funRoundRate(items, "currate");

                } else {}
            }
            x.open("GET", "getRateTo.jsp?curr=" + a, true);
            x.send();

        }

        function funrefdisslno() {

            $("#nidescdetailsGrid").jqxGrid('clear');
            $("#nidescdetailsGrid").jqxGrid('addrow', null, {});

            if ($('#nireftype').val() == "NPO") {
                $('#refno').attr('disabled', false);
                $('#refslno').attr('disabled', false);

            } else {
                $('#refno').val(" ");
                $('#refslno').val(" ");
                $('#refno').attr('disabled', true);
                $('#refslno').attr('disabled', true);

            }
        }

        function combochange() {
            if ($('#cmbcurrval').val() != "") {

                $('#cmbcurr').val($('#cmbcurrval').val());
            }
            if ($('#acctypeval').val() != "") {

                $('#acctype').val($('#acctypeval').val());
            }
            if ($('#reftypeval').val() != "") {

                $('#nireftype').val($('#reftypeval').val());

                if ($('#reftypeval').val() == "NPO") {

                    $('#refno').attr('disabled', false);
                    $('#refslno').attr('disabled', false);
                    $('#refno').attr('readonly', true);
                    $('#refslno').attr('readonly', true);
                }
            }

        }

        function fungetterms() {

            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    if (parseInt(items) > 0) {

                        $('#termsval').val(1);

                    } else {

                        $('#termsval').val(0);

                    }
                } else {

                }
            }
            x.open("GET", "terms.jsp?", true);

            x.send();

        }

        function funinterstate() {

            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    if (parseInt(items) > 0) {
                        $('#interdiv').hide();

                    } else {
                        $('#interdiv').hide();

                    }
                } else {

                }
            }
            x.open("GET", "interstate.jsp?", true);

            x.send();

        }

        function setValues() {
            funinterstate();

            $('#nipurchasedate').jqxDateTimeInput({
                disabled: false
            });
            var date = $('#nipurchasedate').val();
            getCurrencyIds(date);
            $('#nipurchasedate').jqxDateTimeInput({
                disabled: true
            });

            if ($('#hidnipurchasedate').val()) {
                $("#nipurchasedate").jqxDateTimeInput('val', $('#hidnipurchasedate').val());
            }
			if($('#hidcmbreftype').val()) {
                $("#cmbreftype").val($('#hidcmbreftype').val());
            }
            var interstate = document.getElementById("hidinterstate").value;

            if (interstate > 0) {
                document.getElementById("interstate").checked = true;
            } else {
                document.getElementById("interstate").checked = false;
            }

            var dis = document.getElementById("masterdoc_no").value;
            if (dis > 0) {
                funchkforedit();
                var indexval1 = document.getElementById("masterdoc_no").value;

                $("#nipurdetails").load("descgridDetails.jsp?nipurdoc=" + indexval1+"&id=1");
				$("#agentdiv").load("agentGrid.jsp?rdocno="+indexval1+"&id=1");
            }

            if ($('#msg').val() != "") {
                $.messager.alert('Message', $('#msg').val());
            }
            document.getElementById("formdet").innerText = $('#formdetail').val() + " (" + $('#formdetailcode').val().trim() + ")";
            combochange();
            
            if(document.getElementById("masterdoc_no").value!="" && document.getElementById("masterdoc_no").value!="0"){
				var invtypedesc="";
		       	if(parseInt($('#manual').val())==3){
		       		invtypedesc="Invoice created from Inv Processing";
		       	}
		       	else if(parseInt($('#manual').val())==2){
		       		invtypedesc="Invoice created from Tenancy Contract Posting";
		       	}
		       	else if(parseInt($('#manual').val())==1){
		       		invtypedesc="Manual Invoice";
		       	}
		       	else if(parseInt($('#manual').val())==4){
		       		invtypedesc="Invoice created from Maintenance Posting";
		       	}
		       	else{
		       		invtypedesc="Imported Invoice";
		       	}
		       	$('#lblinvoicetype').text(invtypedesc);            	
            }
        }
        $(function() {
            $('#frmPropertyInvoice').validate({
                rules: {

                    delterms: {
                        maxlength: 2000
                    },
                    purdesc: {
                        maxlength: 2000
                    },
                    payterms: {
                        maxlength: 2000
                    }

                },
                messages: {
                    delterms: {
                        maxlength: "  Max 2000 chars"
                    },
                    purdesc: {
                        maxlength: "  Max 2000 chars"
                    },
                    payterms: {
                        maxlength: "  Max 2000 chars"
                    }

                }
            });
        });

        function funPrintBtn() {
			   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
					var url=document.URL;
					var reurl;
					if( url.indexOf('savePropertyInvoice') >= 0){
						reurl=url.split("savePropertyInvoice");
					}else {
						reurl=url.split("propertyInvoice.jsp");
					}
					$("#docno").prop("disabled", false);                
					var dtype=$('#formdetailcode').val();
					var brhid=$("#brchName").val();
					var win= window.open(reurl[0]+"printPropertyInvoice?docno="+document.getElementById("masterdoc_no").value+"&brhid="+brhid+"&dtype="+dtype+"&header=1","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=yes,toolbar=yes");
					win.focus();
				} 
				else {
					$.messager.alert('Message','Select a Document....!','warning');
					return false;
				}
        }

        function PrintContent(url) {
            $('#printWindow').jqxWindow('open');
            $.get(url).done(function(data) {
                $('#printWindow').jqxWindow('setContent', data);
                $('#printWindow').jqxWindow('bringToFront');
            });
        }

        function funchkforedit() {  
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    if (parseInt(items) > 0) {

                        $("#btnEdit").attr('disabled', true);
                        $("#btnDelete").attr('disabled', true);

                    } else {

                    }

                } else {}
            }
            x.open("GET", "linkchk.jsp?masterdoc_no=" + document.getElementById("masterdoc_no").value, true);
            x.send();
        }
    </script>
</head>

<body onload="setValues();funinterstate();">

    <div id="mainBG" class="homeContent" data-type="background">
        <form id="frmPropertyInvoice" action="savePropertyInvoice" method="post" autocomplete="off">
            <jsp:include page="../../../header.jsp" />
            
            <div class="modern-ui hidden-scrollbar">

                <!-- General Info Panel -->
                <div class="middle-panel">
                    <span class="middle-panel-title">General Info</span>
                    
                    <div class="field-row">
                        <label class="lbl-right" style="width:80px;">Date</label>
                        <div style="width: 120px;">
                            <div id="nipurchasedate" name="nipurchasedate" value='<s:property value="nipurchasedate"/>'></div>
                            <input type="hidden" name="hidnipurchasedate" id="hidnipurchasedate" value='<s:property value="hidnipurchasedate"/>'>
                        </div>
                        
                        <label class="lbl-right" style="width:80px; margin-left: 15px;">Ref Type</label>
                        <select name="cmbreftype" id="cmbreftype" style="width:120px;" value='<s:property value="cmbreftype"/>'>
                            <option value="TNC">Tenancy</option>
                            <option value="LES">Leasing</option>
                            <option value="SAL">Sales</option>
                        </select>
                        
                        <label class="lbl-right" style="width:80px; margin-left: 15px;">Ref No</label>
                        <input type="text" name="refno" id="refno" style="width:150px;" value='<s:property value="refno"/>'>
                        
                        <label class="lbl-right" style="width:80px; margin-left: auto;">Doc No.</label>
                        <input type="text" name="docno" id="docno" style="width:120px;" tabindex="-1" value='<s:property value="docno"/>' readonly="readonly">
                    </div>
                    
                    <div class="field-row">
                        <label class="lbl-right" style="width:80px;">Curr</label>
                        <select name="cmbcurr" id="cmbcurr" style="width:120px;" value='<s:property value="cmbcurr"/>' onload="getRatevalue(this.value);">
                            <option value="-1">--Select--</option>
                        </select>
                        <input type="hidden" id="hidcmbcurr" name="hidcmbcurr" value='<s:property value="hidcmbcurr"/>' />
                        <input type="hidden" name="refslno" id="refslno" value='<s:property value="refslno"/>'>
                        
                        <label class="lbl-right" style="width:80px; margin-left: 15px;">Rate</label>
                        <input type="text" name="currate" id="currate" style="width:120px; text-align:right;" value='<s:property value="currate"/>'>
                        
                        <label name="lblinvoicetype" id="lblinvoicetype" style="margin-left:auto; font-weight:bold; color:#0056b3;"><s:property value="lblinvoicetype"/></label>
                    </div>

                    <div class="field-row">
                        <label class="lbl-right" style="width:80px;">Type</label>
                        <select name="cmbtype" id="cmbtype" style="width:120px;" value='<s:property value="cmbtype"/>'>
                            <option value="AR">AR</option>
                            <option value="AP">AP</option>
                            <option value="GL">GL</option>
                        </select>
                        
                        <label class="lbl-right" style="width:80px; margin-left: 15px;">Account</label>
                        <input type="hidden" name="acctype" id="acctype" value='<s:property value="acctype"/>'>
                        
                        <div class="input-search-container" style="width: 150px;">
                            <input type="text" name="nipuraccid" id="nipuraccid" value='<s:property value="nipuraccid"/>' placeholder="Press F3" onKeyDown="getaccountdetails(event);">
                            <svg class="magnifier-icon" onclick="if($('#mode').val()!='view'){ $('#accountSearchwindow').jqxWindow('open'); accountSearchContent('accountDetailsFromSearch.jsp?type='+$('#cmbtype').val()); }" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                        </div>
                        <input type="text" id="puraccname" name="puraccname" style="flex:1; max-width:400px; margin-left:8px;" value='<s:property value="puraccname"/>' readonly tabindex="-1">
                    </div>
                    
                    <div class="field-row">
                        <label class="lbl-right" style="width:80px;">Billing Name</label>
                        <input type="text" name="billingname" id="billingname" style="flex:1; max-width:400px;" value='<s:property value="billingname"/>'>
                        
                        <label class="lbl-right" style="width:80px; margin-left: 15px;">Billing TRN</label>
                        <input type="text" name="billingtrn" id="billingtrn" style="flex:1; max-width:250px;" value='<s:property value="billingtrn"/>'>
                    </div>

                    <div class="field-row">
                        <label class="lbl-right" style="width:80px;">Owner</label>
                        <input type="text" name="owner" id="owner" style="flex:1; max-width:300px;" value='<s:property value="owner"/>'>
                        
                        <label class="lbl-right" style="width:80px; margin-left: 15px;">Property</label>
                        <input type="text" name="property" id="property" style="flex:1; max-width:300px;" value='<s:property value="property"/>'>
                    </div>

                    <div class="field-row" style="margin-bottom:0;">
                        <label class="lbl-right" style="width:80px;">From Date</label>
                        <div style="width: 120px;">
                            <div id="contractfromdate" name="contractfromdate" value='<s:property value="contractfromdate"/>'></div>
                        </div>
                        
                        <label class="lbl-right" style="width:80px; margin-left: 15px;">To Date</label>
                        <div style="width: 120px;">
                            <div id="contracttodate" name="contracttodate"  value='<s:property value="contracttodate"/>'></div>
                        </div>
                        
                        <label class="lbl-right" style="width:120px; margin-left: auto;">Rent/Sale Value</label>
                        <input type="text" name="rentsalevalue" id="rentsalevalue" style="width:120px; text-align:right;" value='<s:property value="rentsalevalue"/>' onkeypress="javascript:return isNumber (event,id)" onblur="funRoundAmt(value,id);">
                    </div>
                    
                </div>
                
                <div class="middle-panel" style="margin-bottom: 15px;">
                    <div class="field-row" style="margin-bottom:0;">
                        <label class="lbl-right" style="width:80px; align-self:flex-start; padding-top:4px;">Description</label>
                        <textarea name="purdesc" id="purdesc" style="flex:1; height:40px;" rows="2"><s:property value="purdesc"/></textarea>
                    </div>
                </div>

                <div style="display:flex; gap:15px; margin-bottom: 15px;">
                    <div class="middle-panel" style="flex:1.5; margin-bottom:0;">
                        <span class="middle-panel-title">Details</span>
                        <div id="nipurdetails" class="grid-container" style="border:none;">
                            <jsp:include page="descgridDetails.jsp"></jsp:include>
                        </div>
                    </div>

                    <div class="middle-panel" style="flex:1; margin-bottom:0;">
                        <span class="middle-panel-title">Agent Details</span>
                        <div id="agentdiv" class="grid-container" style="border:none;">
                            <jsp:include page="agentGrid.jsp"></jsp:include>
                        </div>
                    </div>
                </div>

            <!-- Hidden Properties Container -->
            <div style="display:none;">
                <input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>' />
                <input type="hidden" id="termsval" name="termsval" value='<s:property value="termsval"/>' />
                <input type="hidden" id="hidcmbreftype" name="hidcmbreftype" value='<s:property value="hidcmbreftype"/>' />
                <input type="hidden" id="ordermasterdoc_no" name="ordermasterdoc_no" value='<s:property value="ordermasterdoc_no"/>' />
                <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>' />
                <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
                <input type="hidden" id="nettotal" name="nettotal" value='<s:property value="nettotal"/>' />
                <input type="hidden" id="rowval" name="rowval" value='<s:property value="rowval"/>' />
                <input type="hidden" id="accdocno" name="accdocno" value='<s:property value="accdocno"/>' />
                <input type="hidden" id="descgridlenght" name="descgridlenght" value='<s:property value="descgridlenght"/>' />
                <input type="hidden" id="cmbcurrval" name="cmbcurrval" value='<s:property value="cmbcurrval"/>' />
                <input type="hidden" id="acctypeval" name="acctypeval" value='<s:property value="acctypeval"/>' />
                <input type="hidden" id="reftypeval" name="reftypeval" value='<s:property value="reftypeval"/>' />
                <input type="checkbox" id="interstate" name="interstate" value='<s:property value="interstate"/>' hidden="true"/>
                <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>' />
                <input type="hidden" id="acctypegrid" name="acctypegrid" value='<s:property value="acctypegrid"/>' />
                <input type="hidden" id="nidescdetailslenght" name="nidescdetailslenght" value='<s:property value="nidescdetailslenght"/>' />
                <input type="hidden" id="costgropename" name="costgropename" value='<s:property value="costgropename"/>' />
                <input type="hidden" id="tarannumber" name="tarannumber" value='<s:property value="tarannumber"/>' />
                <input type="hidden" id="hidinterstate" name="hidinterstate" value='<s:property value="hidinterstate"/>' />
                <input type="hidden" id="txtnontaxableentity" name="txtnontaxableentity" value='<s:property value="txtnontaxableentity"/>' />
                <input type="hidden" id="taxpers" name="taxpers" value='<s:property value="taxpers"/>' />
                <input type="hidden" id="taxperc" name="taxperc" value='<s:property value="taxperc"/>' />
                <input type="hidden" id="agentrowlength" name="agentrowlength" value='<s:property value="agentrowlength"/>' />
                <input type="hidden" id="manual" name="manual" value='<s:property value="manual"/>' />
            </div>

        </div>
        </form>

        <div id="accountSearchwindow"><div></div></div>
        <div id="accounttypeSearchwindow"><div></div></div>
        <div id="costtpesearchwndow"><div></div></div>
        <div id="costcodesearchwndow"><div></div></div>
        <div id="refnosearchwindow"><div></div></div>
        <div id="nipurchslnosearch"><div></div></div>
        <div id="printWindow"><div></div></div>
        <div id="salespersonwindow"><div></div></div>
        
    </div>
</body>

</html>