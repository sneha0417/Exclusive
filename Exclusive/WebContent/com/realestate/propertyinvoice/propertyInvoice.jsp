	<%@ taglib prefix="s" uri="/struts-tags" %>
	<!DOCTYPE html>
<html>

<head>
    <title>GatewayERP(i)</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <jsp:include page="../../../includes.jsp"></jsp:include>

    <style>
        form label.error {
            color: red;
            font-weight: bold;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function() {
            getAccountTypeEntity();
            checkEdit();
            /* Date */
            $("#nipurchasedate").jqxDateTimeInput({
                width: '125px',
                height: '15px',
                formatString: "dd.MM.yyyy"
            });
            $("#contractfromdate").jqxDateTimeInput({
                width: '125px',
                height: '15px',
                formatString: "dd.MM.yyyy"
            });
            $("#contracttodate").jqxDateTimeInput({
                width: '125px',
                height: '15px',
                formatString: "dd.MM.yyyy"
            });
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
                    /*if (items == 1) {
                        $("#typetd1").show();
                        $("#typetd2").show();
                    } else {
                        $("#typetd1").hide();
                        $("#typetd2").hide();
                    }*/
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
            //alert(url);
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
                // alert(Math.round((rows[i].taxamount + Number.EPSILON) * 100) / 100);
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
           // alert(agentFlg);
            //console.log(agentFlg);
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
                    /*       $('#currate').val(items) ; */

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
                    //alert("items"+items);
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
                    //alert("items"+items);
                    if (parseInt(items) > 0) {
                        $('#interdiv').hide();
                        // $('#interstate').attr('disabled', false);

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
            /*  if(document.getElementById("interstate").checked=true){
							   $('#interstate').val()=='1';
						   }
						   else{
							   $('#interstate').val()=='0';
						   } */
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
        /*function diserror(){
						   document.getElementById("errormsg").innerText="";
					   } */
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
            <fieldset style="margin-top:10px;">
                <table width="100%">
                    <tr>
                        <td width="4%" align="right">Date</td>
                        <td width="4%" align="left">
                            <div id="nipurchasedate" name="nipurchasedate" value='<s:property value="nipurchasedate"/>'></div>
                            <input type="hidden" name="hidnipurchasedate" id="hidnipurchasedate" value='<s:property value="hidnipurchasedate"/>'>
                        </td>
                        <td align="right" width="5%">Ref Type</td>
                        <td align="right" width="10%">
                        	<select name="cmbreftype" id="cmbreftype" style="width:100%;" value='<s:property value="cmbreftype"/>'>
                        		<!-- <option value="DIR">Direct</option> -->
                        		<option value="TNC">Tenancy</option>
                        		<option value="LES">Leasing</option>
                        		<option value="SAL">Sales</option>
                        	</select>
                        </td>
                        
                        <td align="right" width="5%">Ref No</td>
                        <td align="left" width="15%"><input type="text" name="refno" id="refno" style="width:90%;" value='<s:property value="refno"/>'></td>
                        <td align="right" width="5%">Curr</td>
                        <td align="left" width="10%">
                        	<select name="cmbcurr" id="cmbcurr" style="width:100%;" value='<s:property value="cmbcurr"/>' onload="getRatevalue(this.value);">
                                <option value="-1">--Select--</option>
                            </select>
                            <input type="hidden" id="hidcmbcurr" name="hidcmbcurr" value='<s:property value="hidcmbcurr"/>' />
                            <input type="hidden" name="refslno" id="refslno" value='<s:property value="refslno"/>'>
                        </td>
                        <td width="10%" align="right">Rate</td>
                        <td width="8%" align="left"><input type="text" style="width:99%;" name="currate" id="currate" value='<s:property value="currate"/>'></td>
                        <!-- <td width="10%"></td> -->
                        <td width="30%" align="left" colspan="3"><label name="lblinvoicetype" id="lblinvoicetype"><s:property value="lblinvoicetype"/></label></td>

                        <td width="13%" align="right">Doc No </td>
                        <td width="13%">
                            <input type="text" name="docno" id="docno" tabindex="-1" value='<s:property value="docno"/>' readonly="readonly">
                        </td>
                    </tr>

                    <tr>
                        <td width="3.1%" align="right" id="typetd1">Type</td>
                        <td width="4%" align="left" id="typetd2">
                            <select name="cmbtype" id="cmbtype" style="width:68%;" value='<s:property value="cmbtype"/>'>
                                <option value="AR">AR</option>
                                <option value="AP">AP</option>
                                <option value="GL">GL</option>
                            </select>
                        </td>

                        <td width="3.1%" align="right">Account</td>
                        <td colspan="5" width="13%" align="left">
                            <input type="hidden" name="acctype" id="acctype" value='<s:property value="acctype"/>'>
                            <input type="text" name="nipuraccid" id="nipuraccid" value='<s:property value="nipuraccid"/>' placeholder="Press F3 To Search" style="width:20%;" onKeyDown="getaccountdetails(event);">
                            <input type="text" id="puraccname" name="puraccname" value='<s:property value="puraccname"/>' style="width:78%;">
                        </td>
                        <td colspan="7" rowspan="3">
                        	<div id="agentdiv"><jsp:include page="agentGrid.jsp"></jsp:include></div>
                        </td>
                    </tr>
                    <tr>
                    	<td align="right">Billing Name</td>
                    	<td colspan="4"><input type="text" name="billingname" id="billingname" value='<s:property value="billingname"/>' style="width:99%;"></td>
                    	<td align="right">Billing TRN</td>
                    	<td colspan="2"><input type="text" name="billingtrn" id="billingtrn"  value='<s:property value="billingtrn"/>' style="width:99%;"></td>
                    </tr>
                    <tr>
                        <td align="right" width="4.7%">Description</td>
                        <td colspan="7" align="left">
                            <input type="text" name="purdesc" id="purdesc" value='<s:property value="purdesc"/>' style="width:99.4%;">
                        </td>
                    </tr>
                    <tr>
                    	<td align="right">Owner</td>
                    	<td colspan="3" align="left"><input type="text" name="owner" id="owner" value='<s:property value="owner"/>' style="width:100%;"></td>
                    	<td align="right">Property</td>
                    	<td colspan="4" align="left"><input type="text" name="property" id="property" value='<s:property value="property"/>'  style="width:100%;"></td>
                    	<td align="right">From Date</td>
                    	<td align="left"><div id="contractfromdate" name="contractfromdate" value='<s:property value="contractfromdate"/>'></div></td>
                    	<td align="right">To Date</td>
                    	<td align="left"><div id="contracttodate" name="contracttodate"  value='<s:property value="contracttodate"/>'></div></td>
                    	<td align="right">Rent/Sale Value</td>
                    	<td align="left"><input type="text" name="rentsalevalue" id="rentsalevalue" value='<s:property value="rentsalevalue"/>' style="text-align:right;" onkeypress="javascript:return isNumber (event,id)" onblur="funRoundAmt(value,id);"></td>
                    </tr>
                </table>

            </fieldset>
            <br>
            <fieldset>

                <div id="nipurdetails">
                    <jsp:include page="descgridDetails.jsp"></jsp:include>
                </div>

            </fieldset>
            <input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>' />

            <input type="hidden" id="termsval" name="termsval" value='<s:property value="termsval"/>' />
			<input type="hidden" id="hidcmbreftype" name="hidcmbreftype" value='<s:property value="hidcmbreftype"/>' />
            <input type="hidden" id="ordermasterdoc_no" name="ordermasterdoc_no" value='<s:property value="ordermasterdoc_no"/>' />
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>' />
            <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
            <input type="hidden" id="nettotal" name="nettotal" value='<s:property value="nettotal"/>' />
            <input type="hidden" id="rowval" name="rowval" value='<s:property value="rowval"/>' />
            <!-- for refno  slno set grid -->
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
        </form>
        <div id="accountSearchwindow">
            <div></div>
        </div>
        <div id="accounttypeSearchwindow">
            <div></div>
        </div>
        <div id="costtpesearchwndow">
            <div></div>
        </div>
        <div id="costcodesearchwndow">
            <div></div>
        </div>
        <div id="refnosearchwindow">
            <div></div>
        </div>
        <div id="nipurchslnosearch">
            <div></div>
        </div>
        <div id="printWindow">
            <div></div>
        </div>
        <div id="salespersonwindow">
            <div></div>
        </div>
        
    </div>
</body>

</html>