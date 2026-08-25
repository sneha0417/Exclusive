<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String contextPath = request.getContextPath();
	String pdocno = request.getParameter("pdocno") == null || request.getParameter("pdocno") == "" ? "0" : request.getParameter("pdocno").toString();
	String pname = request.getParameter("pname") == null || request.getParameter("pname") == "" ? "0" : request.getParameter("pname").toString();
	String mod = request.getParameter("mode") == null || request.getParameter("mode") == "" ? "0" : request.getParameter("mode").toString();
	String renewalstatus = request.getParameter("renewalstatus") == null || request.getParameter("renewalstatus") == "" ? "0" : request.getParameter("renewalstatus").toString();
	String contractdocno = request.getParameter("contractdocno") == null || request.getParameter("contractdocno") == "" ? "0" : request.getParameter("contractdocno").toString();
%>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="UTF-8">
    <title>GatewayERP(i)</title>
    <jsp:include page="../../../includes.jsp"></jsp:include>
    <script type="text/javascript">
    
        var pdoc = '<%=pdocno%>';
        var mode1 = '<%=mod%>';
        var pname = '<%=pname%>';
        setVatDist();
		function roundToTwo(num) {
    		return +(Math.round(num + "e+2")  + "e-2");
		}
        function FillDatafromAvailability() {
            if (mode1 == "A") {
                //$('#mode').val(mode1);
                $('#txtpropertydocno').val(pdoc);
                $('#txtproperty').val(pname);
                $('#tenancyContractDate').val(new Date());
                $('#periodFromDate').val(new Date());
                $('#periodToDate').val(new Date());
                $('#txtnotificationperiod').val('60');
                $('#txtcontractperiod').val('1');
                $('#periodToDate').jqxDateTimeInput({
                    disabled: false
                });
                $("#termsOfContractGridId").jqxGrid('clear');
                $("#termsOfContractGridId").jqxGrid('addrow', null, {});
                $("#agentGridId").jqxGrid('clear');
                $("#agentGridId").jqxGrid('addrow', null, {});
                $("#paymentDistributionGridId").jqxGrid('clear');
                $("#paymentDistributionGridId").jqxGrid('addrow', null, {});
                $('#termsOfContractDiv').load("termsOfContractGrid.jsp?load=1");
            }

        }
        $(document).ready(function() {
        	 $('#printWindow').jqxWindow({width: '51%', height: '28%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Print',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    		 $('#printWindow').jqxWindow('close');
        	$('#txtnumofcheque').change(function(){
        		$('#txtmngfeeinstmnt').val($(this).val());
        		$('#txtmngfeeinstmnt').trigger('change');
        	});
        	if(document.getElementById("masterdoc_no").value!="" && document.getElementById("masterdoc_no").value!="0"){
	    		$('.user-details-container').show();
	    	} 
	    	else{
	    		$('.user-details-container').hide();
	    	}
            if ($("#mode").val() == "E") {
                var nettotal = $("#termsOfContractGridId").jqxGrid('getcolumnaggregateddata', 'amount', ['sum'], true);
                var tot = 0;

                if(nettotal.sum=="undefined" || nettotal.sum=="" || nettotal.sum ==null || typeof(nettotal.sum)=="undefined"){
                	tot= 0;
        		}
        		else{
        			tot = nettotal.sum.replace(/,/g, '');		
        		}
        	
                $('#hidnettotal').val(tot);
            }

            if ($('#tenantdet').val() != '' || $('#tenantdet').val() != 'undefined' || $('#tenantdet').val() != null) {
                var det = $('#tenantdet').val().replace(/\n/g, "<br />");
                $('#tenantdetail').html(det);
            }

            if ($('#propertydet').val() != '' || $('#propertydet').val() != 'undefined' || $('#propertydet').val() != null) {
                var det = $('#propertydet').val().replace(/\n/g, "<br />");
                //alert(det);	 
                $('#propertydetail').html(det);
            }
            $('#btntenantmaster').click(function(){
				var cldocno=$('#txttenantdocno').val();
				if(cldocno!="" && cldocno!="0" && cldocno!=null && cldocno!="undefined"){
					var url=document.URL;
					var reurl=url.split("com/");
	       			top.addTab("Client",reurl[0]+"com/controlcentre/masters/client/clientmaster.action?cldocno="+cldocno+"&mode=view");	
				}
			});
			$('#btnpropertymaster').click(function(){
				var propdocno=$('#txtpropertydocno').val();
				if(propdocno!="" && propdocno!="0" && propdocno!=null && propdocno!="undefined"){
					var url=document.URL;
					var reurl=url.split("com/");
	       			top.addTab("Property Master",reurl[0]+"com/realestate/propertymaster/saveptyMaster.action?masterdocno="+propdocno+"&mode=view");	
				}
			});
			$('#btnpropertycalculate').click(function(){
				
				if($('#mode').val()=='E'){
					var propdocno=$('#txtpropertydocno').val();
					var x = new XMLHttpRequest();
            		x.onreadystatechange = function() {
	                	if (x.readyState == 4 && x.status == 200) {
    	                	var items = x.responseText.trim();
    	                	console.log(items);
    	                	items=JSON.parse(items);
    	                	var mngp=items.mngperc;
       						$('#mgmtfeepercent').val(items.mgmtfeepercent);
        					$('#mgmtfeevalue').val(items.mgmtfeevalue);
        					var mgmtfeepercent=$('#mgmtfeepercent').val();
        					var mgmtfeevalue=$('#mgmtfeevalue').val();
        					if(mgmtfeepercent!="" && mgmtfeepercent!=null && mgmtfeepercent!="undefined" && typeof(mgmtfeepercent)!="undefined"){
        						if(parseFloat(mgmtfeepercent)>0.0){
        							$('#lblmgmtfeepercent').text(mgmtfeepercent).attr('hidden',false);
        							$('#txtmanagementperc').val(mgmtfeepercent);
        							$('#txtmanagementperc').trigger('change');
        							$('#txtmanagementperc').attr('hidden',true);
        							$('#mgmtfeepercent').val(mgmtfeepercent);
        						}
        						else{
        							$('#lblmgmtfeepercent').attr('hidden',true);
        							$('#txtmanagementperc').attr('hidden',false);
        						}
        					}
        					if(mgmtfeevalue!="" && mgmtfeevalue!=null && mgmtfeevalue!="undefined" && typeof(mgmtfeevalue)!="undefined"){
        						if(parseFloat(mgmtfeevalue)>0.0){
        							$('#lblmgmtfeevalue').text(mgmtfeevalue);
        							/* .attr('hidden',false); */
        							$('#txtmanagementval').val(mgmtfeevalue);
        							/* $('#txtmanagementval').attr('hidden',true); */
        							$('#txtmanagementval').trigger('change');
        							$('#mgmtfeevalue').val(mgmtfeevalue);
        						}
        						else{
        							/* $('#lblmgmtfeevalue').attr('hidden',true);
        							$('#txtmanagementval').attr('hidden',false); */
        						}
        					}
        					$('#chktenancychequeowner').val(items.chktenancychequeowner);
        					setMgmtFee();
        	        	} else {}
            		}
            		x.open("GET", "calculatePropDetails.jsp?propdocno="+propdocno, true);
            		x.send();
				}
			});
            $("#tenancyContractDate").jqxDateTimeInput({
                width: '125px',
                height: '15px',
                formatString: "dd.MM.yyyy"
            });
            $("#periodFromDate").jqxDateTimeInput({
                width: '125px',
                height: '15px',
                formatString: "dd.MM.yyyy"
            });
            $("#periodToDate").jqxDateTimeInput({
                width: '125px',
                height: '15px',
                formatString: "dd.MM.yyyy"
            });
            $('#tenancyContractDate').on('change', function(event) {
                var maindate = $('#tenancyContractDate').jqxDateTimeInput('getDate');
                if ($("#mode").val() == "A" || $("#mode").val() == "E") {
                    funDateInPeriodchk(maindate);
                }
            });
            $('#refnosearchwindow').jqxWindow({
                width: '50%',
                height: '60%',
                maxHeight: '75%',
                maxWidth: '50%',
                title: ' Search',
                position: {
                    x: 500,
                    y: 60
                },
                keyboardCloseKey: 27
            });
            $('#refnosearchwindow').jqxWindow('close');
            $('#refnosearchwindow1').jqxWindow({
                width: '50%',
                height: '60%',
                maxHeight: '75%',
                maxWidth: '50%',
                title: ' Search',
                position: {
                    x: 500,
                    y: 60
                },
                keyboardCloseKey: 27
            });
            $('#refnosearchwindow1').jqxWindow('close');
            $('#salespersonwindow').jqxWindow({
                width: '25%',
                height: '58%',
                maxHeight: '70%',
                maxWidth: '45%',
                title: '  Search',
                position: {
                    x: 500,
                    y: 87
                },

                showCloseButton: true,
                keyboardCloseKey: 27
            });
            $('#salespersonwindow').jqxWindow('close');
            $('#txtproperty').dblclick(function() {
                refsearchContent1('pmainsearch.jsp');
            });

            $('#txttenant').dblclick(function() {
                refsearchContent2('tmainsearch.jsp');
            });
            if (mode1 == "A" && parseInt(pdoc) > 0) {
                FillDatafromAvailability();
            }
        });

        function salespersonSearchContent(url) {
            $('#salespersonwindow').jqxWindow('open');
            $.get(url).done(function(data) {
                $('#salespersonwindow').jqxWindow('setContent', data);
                $('#salespersonwindow').jqxWindow('bringToFront');
            });
        }

        function getTenant(event) {
            /* if(event.keyCode==19)
            	{ */
            refsearchContent2('tmainsearch.jsp');
            //}
        }

        function refsearchContent2(url) {

            $('#refnosearchwindow1').jqxWindow('open');

            $.get(url).done(function(data) {
                //alert(data);
                $('#refnosearchwindow1').jqxWindow('setContent', data);

            });
        }

        function getProperty(event) {
            refsearchContent1('pmainsearch.jsp');
        }

        function refsearchContent1(url) {

            $('#refnosearchwindow').jqxWindow('open');
            $.get(url).done(function(data) {
                //alert(data);
                $('#refnosearchwindow').jqxWindow('setContent', data);

            });
        }

        function funReadOnly() {
            $('#frmTenancyContract input').attr('readonly', true);
            $('#frmTenancyContract select').attr('disabled', true);
            $('#tenancyContractDate').jqxDateTimeInput({
                disabled: true
            });
            $('#periodFromDate').jqxDateTimeInput({
                disabled: true
            });
            $('#periodToDate').jqxDateTimeInput({
                disabled: false
            });

            $("#termsOfContractGridId").jqxGrid({
                disabled: true
            });
            $("#agentGridId").jqxGrid({
                disabled: true
            });
            $("#paymentDistributionGridId").jqxGrid({
                disabled: true
            });
            document.getElementById("formdet").innerText ="Tenancy Contract (TNC)";
            document.getElementById("formdetail").value = "Tenancy Contract";
            document.getElementById("formdetailcode").value = "TNC";
        	
            if (mode1 == "A" && parseInt(pdoc) > 0) {
                document.getElementById("formdet").innerText ="Tenancy Contract (TNC)";
                document.getElementById("formdetail").value = "Tenancy Contract";
                document.getElementById("formdetailcode").value = "TNC";

                funCreateBtn();
                $('#txtpropertydocno').val(pdoc);
                $('#txtproperty').val(pname);

            }
        }

        function funRemoveReadOnly() {
            $('#frmTenancyContract input').attr('readonly', false);
            $('#frmTenancyContract select').attr('disabled', false);

            $('#txttenant').attr('readonly', true);
            $('#txtproperty').attr('readonly', true);
            $('#tenancyContractDate').jqxDateTimeInput({
                disabled: false
            });
            $('#periodFromDate').jqxDateTimeInput({
                disabled: false
            });
            $('#periodToDate').jqxDateTimeInput({
                disabled: false
            });
            $('#docno').attr('readonly', true);
            $("#termsOfContractGridId").jqxGrid({
                disabled: false
            });
            $("#agentGridId").jqxGrid({
                disabled: false
            });
            $("#paymentDistributionGridId").jqxGrid({
                disabled: false
            });
            $("#managementfeeGridId").jqxGrid({
                disabled: false
            });

            if ($("#mode").val() == "E") {
                //  $("#termsOfContractGridId").jqxGrid('addrow', null, {});
                $("#agentGridId").jqxGrid('addrow', null, {});
                $("#paymentDistributionGridId").jqxGrid('addrow', null, {});
                $('#periodToDate').jqxDateTimeInput({
                    disabled: false
                });
            }

            if ($("#mode").val() == "A") {
            	$('#lblmanage').text('');
            	$('.user-details-container').hide();
                $('#tenancyContractDate').jqxDateTimeInput('setDate',new Date());
                $('#periodFromDate').jqxDateTimeInput('setDate',new Date());
                $('#periodToDate').jqxDateTimeInput('setDate',new Date());
                $('#txtnotificationperiod').val('90');
                $('#txtcontractperiod').val('1');

                $('#periodToDate').jqxDateTimeInput({
                    disabled: false
                });

                $("#termsOfContractGridId,#managementfeeGridId").jqxGrid('clear');
                $("#termsOfContractGridId").jqxGrid('addrow', null, {});
                $("#agentGridId").jqxGrid('clear');
                $("#agentGridId").jqxGrid('addrow', null, {});
                $("#paymentDistributionGridId").jqxGrid('clear');
                $("#paymentDistributionGridId").jqxGrid('addrow', null, {});
                $("#managementfeeGridId").jqxGrid('addrow', null, {});

                $('#termsOfContractDiv').load("termsOfContractGrid.jsp?load=1");

                $('#tenantdetail').empty();
                $('#propertydetail').empty();

                $('#txtcommisionperc').val('0.00');
                $('#txtcommisionval').val('0.00');
                $('#txtnettotal').val('0.00');
                $('#txtmanagementperc').val('0.00');
                $('#txtmanagementval').val('0.00');
                $('#txtadminfeeowner').val('0.00');
                $('#txtownertotal').val('0.00');
                $('#txtmngfeeinstmnt').val('1');

            }
			
			var renewalstatus='<%=renewalstatus%>';
			var contractdocno='<%=contractdocno%>';
			if(renewalstatus=="1"){
				$('#renewalstatus').val(renewalstatus);
				$('#contractdocno').val(contractdocno);
				var x = new XMLHttpRequest();
            	x.onreadystatechange = function() {
	                if (x.readyState == 4 && x.status == 200) {
    	                var items = x.responseText.trim();
    	                items=JSON.parse(items);
    	                $("#agentGridId").jqxGrid('addrow', null, {});
    	                document.getElementById("txttenantdocno").value=items.tenantdocno;
               			document.getElementById("txttenant").value=items.tenantname;
              			var tenantdetails='';
                 		$('#tenantdetail').empty();
                 		tenantdetails+=items.tenantname;
                 		tenantdetails+='<br>';
                 		tenantdetails+='Tel:' + items.tenanttel;
                 		tenantdetails+='<br>';
                 		tenantdetails+='Mob:' + items.tenantmobile;
                 		tenantdetails+='<br>';
                 		tenantdetails+='Email:' + items.tenantemail;
                 		$('#tenantdetail').html(tenantdetails);  
                 		
        				document.getElementById("txtproperty").value = items.propname;
        				document.getElementById("txtpropertydocno").value = items.propdocno;
 						var mngp=items.mgmtfeepercent;
       					$('#mgmtfeepercent').val(items.mgmtfeepercent);
        				$('#mgmtfeevalue').val(items.mgmtfeevalue);
        				var mgmtfeepercent=$('#mgmtfeepercent').val();
        				var mgmtfeevalue=$('#mgmtfeevalue').val();
        				if(mgmtfeepercent!="" && mgmtfeepercent!=null && mgmtfeepercent!="undefined" && typeof(mgmtfeepercent)!="undefined"){
        					if(parseFloat(mgmtfeepercent)>0.0){
        						$('#lblmgmtfeepercent').text(mgmtfeepercent).attr('hidden',false);
        						$('#txtmanagementperc').attr('hidden',true);
        					}
        					else{
        						$('#lblmgmtfeepercent').attr('hidden',true);
        						$('#txtmanagementperc').attr('hidden',false);
        					}
        				}
        				if(mgmtfeevalue!="" && mgmtfeevalue!=null && mgmtfeevalue!="undefined" && typeof(mgmtfeevalue)!="undefined"){
        					if(parseFloat(mgmtfeevalue)>0.0){
        						$('#lblmgmtfeevalue').text(mgmtfeevalue).attr('hidden',false);
        						$('#txtmanagementval').attr('hidden',true);
        					}
        					else{
        						$('#lblmgmtfeevalue').attr('hidden',true);
        						$('#txtmanagementval').attr('hidden',false);
        					}
        				}
        				$('#chktenancychequeowner').val(items.chktenancychequeowner);
       					$('#lblmanage').text(items.strmanage);
        				var propertydetails='';
        				$('#propertydetail').empty();
        				propertydetails+=items.propid;
        				propertydetails+='<br>';
        				propertydetails+='Owner:' + items.propowner;
        				propertydetails+='<br>';
				        propertydetails+='Tel:' + items.ownertel;
				        propertydetails+='<br>';
				        propertydetails+='Mobile:' + items.ownermobile;
				        propertydetails+='<br>';
				        propertydetails+='Email:' + items.owneremail;
        				$('#propertydetail').html(propertydetails);   
                        $('#termsOfContractGridId').jqxGrid('setcellvalue',0,'amount',items.contractamount);
                        $('#cmbtenancytype').val(items.contracttype);
                        $('#cmbcontractperiod').val(1);
                        var strfromdate=items.contractenddate;
                        var dateParts = strfromdate.split(".");
                        var contractfromdate = new Date(+dateParts[2], dateParts[1] - 1, +dateParts[0]); 
                        $('#periodFromDate').jqxDateTimeInput('setDate',contractfromdate);
                        funInsEndDate();
        	        } else {}
            	}
            	x.open("GET", "getRenewalDetails.jsp?contractdocno="+contractdocno, true);
            	x.send();
			}
			$('#commvatamount,#mgmtvatamount').attr('readonly',true);
        }

        function funSearchLoad() {
            changeContent('masterSearch.jsp');
        }

        function funChkButton() {
            /* funReset(); */
        }

        function funFocus() {
            $('#tenancyContractDate').jqxDateTimeInput('focus');
        }

        function funPrintBtn() {
           
            var print=$("#printchk").val();
            if(parseInt(print)==1){
            	  if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
          			BankPrintContent('printVoucherWindow.jsp');
          		  }
          		else {
          				$.messager.alert('Message','Select a Document....!','warning');
          				return;
          			}
            }else{
            	  if (($("#mode").val() == "view") && $("#masterdoc_no").val() != "") {
                     var url = document.URL;
                     var reurl;
                     if (url.indexOf('saveTenancyContract') >= 0) {
                         reurl = url.split("saveTenancyContract");
                     } else {
                         reurl = url.split("tenancyContract.jsp");
                     }
                     $("#docno").prop("disabled", false);
                     var dtype = $('#formdetailcode').val();
                     var print=2;
                     var brhid = '<%=session.getAttribute("BRANCHID").toString()%>';
                     var win = window.open(reurl[0] + "printTenancyContract?docno=" + document.getElementById("masterdoc_no").value + "&brhid=" + brhid + "&dtype=" + dtype + "&print=" + print, "_blank", "top=250,left=310,Width=800,Height=800,location=no,scrollbars=yes,toolbar=yes");
                     win.focus();

                 } else {
                     $.messager.alert('Message', 'Select a Document....!', 'warning');
                     return false;
                 } 
            }
          
        }

    	function BankPrintContent(url) {
    		$('#printWindow').jqxWindow('open');
    		$.get(url).done(function (data) {
    		$('#printWindow').jqxWindow('setContent', data);
    		$('#printWindow').jqxWindow('bringToFront');
    	}); 
    	} 
        
        function funDateInPeriodchk(value) {
            var currentDate = new Date(new Date());
            if (value > currentDate) {
                document.getElementById("errormsg").innerText = "Future Date, Transaction Restricted. ";
                return 0;
            }
            document.getElementById("errormsg").innerText = "";
            return 1;
        }

        function funchk() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
					var renewalstatus=$('#renewalstatus').val();
                    if (parseInt(items) > 0 && renewalstatus!="1") {
                        document.getElementById("errormsg").innerText = "Property not available";
                        return 0;
                    } else {
                        save();
                    }

                } else {}
            }
            x.open("GET", "checkdate.jsp?fromdate=" + document.getElementById("periodFromDate").value + "&txtpropertydocno=" + document.getElementById("txtpropertydocno").value, true);
            x.send();

        }

        function funNotify() {
        	var contractnettotal=$('#txtnettotal').val();
        	var paymentdisttotal = $("#paymentDistributionGridId").jqxGrid('getcolumnaggregateddata', 'amount', ['sum'], true);
        		if(paymentdisttotal.sum=="undefined" || paymentdisttotal.sum=="" || paymentdisttotal.sum==null || typeof(paymentdisttotal.sum)=="undefined"){
        			paymentdisttotal= 0;
        		}
        		else{
        			paymentdisttotal= paymentdisttotal.sum.replace(/,/g, '');		
        		}
        	
        	if(parseFloat(contractnettotal).toFixed(2)!=parseFloat(paymentdisttotal).toFixed(2)){
        	//	$.messager.alert('Warning','Net total and payment distribution are not equal');
        	//	return false;
        	}
        	
        	var mgmtnettotal=$('#mgmtnettotal').val();
        	var mgmtvalue=$('#txtmanagementval').val();
        	var mgmtadmin=$('#txtadminfeeowner').val();
        	var mgmtvat=$('#mgmtvatamount').val();
        	var mgmtvattype=$('#cmbmgmtvattype').val();
        	var mgmttotal=0.0;
        	if(mgmtvattype=='Inclusive'){
        		mgmttotal=parseFloat(mgmtvalue)+parseFloat(mgmtadmin);
        	}
        	else if(mgmtvattype=='Exclusive'){
        		mgmttotal=parseFloat(mgmtvalue)+parseFloat(mgmtadmin)+parseFloat(mgmtvat);
        	}
        	
        	if(parseFloat(mgmttotal).toFixed(2)!=parseFloat(mgmtnettotal).toFixed(2)){
        		$.messager.alert('Warning','Management Total not tallied');
            	return false;
        	}
        	var termscontractgridrows=$('#termsOfContractGridId').jqxGrid('getrows');
        	for(var termindex=0;termindex<termscontractgridrows.length;termindex++){
        		var proptype=$('#cmbtenancytype').val();
        		var gridtax=$('#termsOfContractGridId').jqxGrid('getcellvalue',termindex,'tax');
        		if((termindex==0 && proptype=="2") || (termindex!=0 && gridtax=="1")){
        			var nontaxamount=$('#termsOfContractGridId').jqxGrid('getcellvalue',termindex,'amount');
        			if(nontaxamount!="undefined" && nontaxamount!="" && nontaxamount!=null && typeof(nontaxamount)!="undefined"){
        				if(parseFloat(nontaxamount)>0.0){
        					var taxtype=$('#termsOfContractGridId').jqxGrid('getcellvalue',termindex,'taxtype');
		        			if(taxtype!="Exclusive" && taxtype!="Inclusive"){
		        				var termsdesc=$('#termsOfContractGridId').jqxGrid('getcellvalue',termindex,'description');
		        				$.messager.alert('Warning',termsdesc+' Tax Type is mandatory');
		        				$('#paymentDistributionGridId').jqxGrid('clear');
		        				return false;
		        			}
        				}
        			}
        		}
        	}
            var chkpaymentmode, chkpaidto;
            var rows = $('#paymentDistributionGridId').jqxGrid('getrows');
            for (var m = 0; m < rows.length; m++) {
                chkpaymentmode = $("#paymentDistributionGridId").jqxGrid('getcellvalue', m, 'paymentmethod');
                chkpaidto = $("#paymentDistributionGridId").jqxGrid('getcellvalue', m, 'paidto');
                ("paymentmode=" + chkpaymentmode);
                (chkpaidto);
                if (chkpaymentmode == "Cash" && chkpaidto == "Owner") {
                    $.messager.alert('warning', 'Please select Self when the payment mode is Cash');
                    return false;
                }

            }
            var maindate = $('#tenancyContractDate').jqxDateTimeInput('getDate');
            var validdate = funDateInPeriodchk(maindate);
            if (validdate == 0) {
                return 0;
            }
            var type = document.getElementById("cmbtenancytype").value;
            var txttenant = document.getElementById("txttenant").value;
            var txtproperty = document.getElementById("txtproperty").value;
            var cmbcontractperiod = document.getElementById("cmbcontractperiod").value;
            if (type == "") {
                document.getElementById("errormsg").innerText = "Type is required ";

                return 0;
            }

            if (txttenant == "") {
                document.getElementById("errormsg").innerText = "Tenant is required ";

                return 0;
            }
            if (txtproperty == "") {
                document.getElementById("errormsg").innerText = "Property is required ";

                return 0;
            }

            if (cmbcontractperiod == "") {
                document.getElementById("errormsg").innerText = "Contract Period is required ";

                return 0;
            }
            var txtcommisionval = document.getElementById("txtcommisionval").value;
            var cmbcommvattype = document.getElementById("cmbcommvattype").value;
            if (txtcommisionval != "0.00" && cmbcommvattype =="" ) {
                document.getElementById("errormsg").innerText = "Select commsion Vat";
                return 0;
            }

            var txtownertotal = document.getElementById("txtownertotal").value;
            var cmbmgmtvattype = document.getElementById("cmbmgmtvattype").value;
            if (txtownertotal != "0.00" && cmbmgmtvattype =="" ) {
                document.getElementById("errormsg").innerText = "Select Owner Vat";
                return 0;
            }
			
			var agentrows=$("#agentGridId").jqxGrid('getrows');
			var agentFlg=true;
            for(var i=0;i<agentrows.length;i++){
            	if(agentrows[i].salid!="" && agentrows[i].salid!="undefined" && agentrows[i].salid!=null && typeof(agentrows[i].salid)!="undefined"){
					if(agentrows[i].commperc=="" || agentrows[i].commperc=="undefined" || agentrows[i].commperc==null || typeof(agentrows[i].commperc)=="undefined"){
						agentFlg=false
					}
            	}
            }
			
			if (!agentFlg) {
                document.getElementById("errormsg").innerText = " Enter Commission %";
                return 0;
            } else {
                document.getElementById("errormsg").innerText = "";
            }
            
            if (document.getElementById("mode").value == "A") {
                funchk();
            } else {
                save();
            }

        }

        function save() {

            var rows = $("#termsOfContractGridId").jqxGrid('getrows');
            $('#termgridlength').val(rows.length);
            for (var i = 0; i < rows.length; i++) {
                newTextBox = $(document.createElement("input"))
                    .attr("type", "dil")
                    .attr("id", "term" + i)
                    .attr("name", "term" + i)
                    .attr("hidden", "true");
                var aa = 0;
                newTextBox.val(rows[i].docno + "::" + rows[i].amount + "::" + rows[i].docno + "::" + aa + "::"+rows[i].tax+"::"+rows[i].taxtype+"::"+rows[i].taxvalue+"::"+rows[i].nettotal);
                newTextBox.appendTo('form');
            }

            var rows = $("#agentGridId").jqxGrid('getrows');
            $('#agentgridlength').val(rows.length);
            for (var i = 0; i < rows.length; i++) {
                newTextBox = $(document.createElement("input"))
                    .attr("type", "dil")
                    .attr("id", "agent" + i)
                    .attr("name", "agent" + i)
                    .attr("hidden", "true");
                var aa = 0;
                newTextBox.val(rows[i].salid + " :: " + rows[i].commperc + " :: " + rows[i].commamount + " :: " + aa + "::");
                newTextBox.appendTo('form');
            }

            var rows = $("#paymentDistributionGridId").jqxGrid('getrows');
            $('#paymentgridlength').val(rows.length);
            for (var i = 0; i < rows.length; i++) {
                newTextBox = $(document.createElement("input"))
                    .attr("type", "dil")
                    .attr("id", "payment" + i)
                    .attr("name", "payment" + i)
                    .attr("hidden", "true");
                var aa = 0;
                newTextBox.val(rows[i].description + "::" + $('#paymentDistributionGridId').jqxGrid('getcellText', i, "date") + "::" + rows[i].amount + "::" + rows[i].notes + "::" + rows[i].chqno + "::" + rows[i].paidto + "::" + rows[i].paymentmethod + "::" + rows[i].bankaccount + "::" + aa + "::");
                newTextBox.appendTo('form');
            }

            var rows = $("#managementfeeGridId").jqxGrid('getrows');
            $('#mngfeegridlen').val(rows.length);
            for (var i = 0; i < rows.length; i++) {
                newTextBox = $(document.createElement("input"))
                    .attr("type", "dil")
                    .attr("id", "mngfee" + i)
                    .attr("name", "mngfee" + i)
                    .attr("hidden", "true");
                var aa = 0;
                newTextBox.val(rows[i].date + "::" + rows[i].amount);
                newTextBox.appendTo('form');
            }

            $('#tenancyContractDate,#periodFromDate,#periodToDate').jqxDateTimeInput({
                disabled: false
            });
			
            document.getElementById("frmTenancyContract").submit();

        }

        function setValues() {
        	getTenancyTypes();
            

            if ($('#msg').val() != "") {
                $.messager.alert('Message', $('#msg').val());
            }
            if ($('#tenantdet').val() != '' && $('#tenantdet').val() != 'undefined' && $('#tenantdet').val() != null) {
                var det = $('#tenantdet').val().replace(/\n/g, "<br />");
                $('#tenantdetail').html(det);
            }

            if ($('#propertydet').val() != '' && $('#propertydet').val() != 'undefined' && $('#propertydet').val() != null) {
                var det = $('#propertydet').val().replace(/\n/g, "<br />");
                $('#propertydetail').html(det);
            }
            if ($('#hidcmbtenancytype').val() != "") {
                $('#cmbtenancytype').val($('#hidcmbtenancytype').val());
            }
            if ($('#hidcmbcontractperiod').val() != "") {
                $('#cmbcontractperiod').val($('#hidcmbcontractperiod').val());
            }
			if ($('#hidcmbmgmtvattype').val() != "") {
                $('#cmbmgmtvattype').val($('#hidcmbmgmtvattype').val());
            }
            if ($('#hidcmbcommvattype').val() != "") {
                $('#cmbcommvattype').val($('#hidcmbcommvattype').val());
            }
            if ($('#hidchkvatdistributed').val()== "1") {
                $('#chkvatdistributed').prop('checked',true);
            }
            if (document.getElementById("masterdoc_no").value > 0) {
                /*  document.getElementById("cmbtenancytype").value=document.getElementById("hidcmbtenancytype").value;

		  document.getElementById("cmbcontractperiod").value=document.getElementById("hidcmbcontractperiod").value; */
                funchkforedit();
                $('#termsOfContractDiv').load("termsOfContractGrid.jsp?docno=" + document.getElementById("masterdoc_no").value);
                $('#agentDiv').load("agentGrid.jsp?docno=" + document.getElementById("masterdoc_no").value);
                $('#paymentDistributionDiv').load("paymentDistributionGrid.jsp?docno=" + document.getElementById("masterdoc_no").value);
                $('#mngDiv').load("managementfeeGrid.jsp?docno=" + document.getElementById("masterdoc_no").value);

            }

            document.getElementById("formdet").innerText = $('#formdetail').val() + " (" + $('#formdetailcode').val().trim() + ")";
            funSetlabel();

        }

        function funInsEndDate() {

            if ($('#mode').val() == "view") {
                return 0;
            }

            var inststartday = $('#periodFromDate').jqxDateTimeInput('getDate');

            if (inststartday == null) {
                document.getElementById("errormsg").innerText = "Period From is Mandatory.";
                return 0;
            }
            /* 	  		$('#periodToDate').jqxDateTimeInput({disabled: false});
            	  	   if(inststartday>($('#periodToDate').jqxDateTimeInput('getDate'))){
            			 	document.getElementById("errormsg").innerText="  Date Should be less than   Date.";
            				$('#periodToDate').jqxDateTimeInput({disabled: true});
            			 	return 0;
            		   }
            	  		$('#periodToDate').jqxDateTimeInput({disabled: true}); */
            document.getElementById("errormsg").innerText = "";

            var startdate = $('#periodFromDate').jqxDateTimeInput('getText');
            var installno = document.getElementById("txtcontractperiod").value;
            var frequency = document.getElementById("cmbcontractperiod").value;
            getEndDate(frequency, installno, startdate);
        }

        function getEndDate(frequency, installno, startdate) {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText;
                    $('#periodToDate').jqxDateTimeInput({
                        disabled: false
                    });
                    $('#periodToDate').val(items);
                    $('#periodToDate').jqxDateTimeInput({
                        disabled: false
                    });
                }
            }
            x.open("GET", "getEndDate.jsp?frequency=" + frequency + '&installno=' + installno + '&startdate=' + startdate, true);
            x.send();
        }

        function isNumber(evt) {

            var iKeyCode = (evt.which) ? evt.which : evt.keyCode
            if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57) && iKeyCode == 110) {
                document.getElementById("errormsg").innerText = " Enter Numbers Only";

                return false;
            }
            document.getElementById("errormsg").innerText = "";
            return true;
        }

        function funchkforedit() {

            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();

                    if (parseInt(items) > 0)

                    {

                        $("#btnEdit").attr('disabled', true);
                        $("#btnDelete").attr('disabled', true);         

                    } else {

                    }

                } else {}
            }
            x.open("GET", "linkchk.jsp?masterdoc_no=" + document.getElementById("masterdoc_no").value, true);
            x.send();

        }
        function funchkprintConfig() {

            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();

                    if (parseInt(items) > 0)

                    {

                    	 $("#printchk").val(1);

                    } else {

                    }

                } else {}
            }
            x.open("GET", "checkConfig.jsp", true);
            x.send();

        }
        function calc_commision(perc, e) {

            var per, net, value, tot;
            per = $(perc).val();
            var i = isNumber(e);
            if (i == true) {
                var nettotal = $("#termsOfContractGridId").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'], true);
                var tot = nettotal.sum.replace(/,/g, '');

                var rent = $("#termsOfContractGridId").jqxGrid('getcellvalue', 0, 'amount');

                $('#hidnettotal').val(tot);
                if ($('#hidnettotal').val() != '' || $('#hidnettotal').val() != 'undefined' || $('#hidnettotal').val() != null) {
                    net = parseFloat($('#hidnettotal').val());

                    rentval = parseFloat(rent);
                    value = parseFloat(rentval * per / 100);
                    $('#txtcommisionval').val(value);
                    tot = Math.round(net + value).toFixed(2);
                    $('#txtnettotal').val(tot);
                }

            }
            funSetCommVAT();
            var nettotal = $("#termsOfContractGridId").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'], true);
            var tot = nettotal.sum.replace(/,/g, '');
        	var commissionvalue=$('#txtcommisionval').val();
        	var commissiontax=$('#commvatamount').val();
        	var grandtotal=0.0;
        	grandtotal+=parseFloat(tot);
        	if(commissionvalue!="" && commissionvalue!=null && commissionvalue!="undefined" && typeof(commissionvalue)!="undefined"){
        		var cmbcommvattype=$('#cmbcommvattype').val();
        		if(cmbcommvattype=='Inclusive'){
        			var inclusiveamt=(commissionvalue/105)*100;
        			inclusiveamt=Math.round(inclusiveamt).toFixed(2);
        			var taxamount=parseFloat(commissionvalue)-parseFloat(inclusiveamt);
        			var newcommission=parseFloat(commissionvalue)-parseFloat(taxamount);
        			grandtotal+=Math.round(parseFloat(newcommission)).toFixed(2);	
        		}
        		else{
        			grandtotal+=parseFloat(commissionvalue);
        		}
        	}
        	if(commissiontax!="" && commissiontax!=null && commissiontax!="undefined" && typeof(commissiontax)!="undefined"){
        		grandtotal+=parseFloat(commissiontax);
        	}
        	$('#txtnettotal').val(Math.round(grandtotal).toFixed(2));
        }

		function calcCommissionPercent(){
			var nettotal=0.0;
			var commValue=$('#txtcommisionval').val();
			commValue=parseFloat(commValue);
			commValue=commValue.toFixed(2);
			var rent = $("#termsOfContractGridId").jqxGrid('getcellvalue', 0, 'amount');
			rent=parseFloat(rent);
			rent=rent.toFixed(2);
			var percentage=0.0;
			percentage=(commValue*100)/rent;
			percentage=percentage.toFixed(2)
			$('#txtcommisionperc').val(percentage);
			
			nettotal = $("#termsOfContractGridId").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'], true);
            var tot = nettotal.sum.replace(/,/g, '');
        	var commissionvalue=$('#txtcommisionval').val();
        	var commissiontax=$('#commvatamount').val();
        	funSetCommVAT();
        	var grandtotal=0.0;
        	grandtotal+=parseFloat(tot);
        	if(commissionvalue!="" && commissionvalue!=null && commissionvalue!="undefined" && typeof(commissionvalue)!="undefined"){
        		var cmbcommvattype=$('#cmbcommvattype').val();
        		if(cmbcommvattype=='Inclusive'){
        			var inclusiveamt=(commissionvalue/105)*100;
        			inclusiveamt=Math.round(inclusiveamt).toFixed(2);
        			var taxamount=parseFloat(commissionvalue)-parseFloat(inclusiveamt);
        			var newcommission=parseFloat(commissionvalue)-parseFloat(taxamount);
        			grandtotal+=parseFloat(newcommission).toFixed(2);	
        		}
        		else{
        			grandtotal+=parseFloat(commissionvalue);
        		}
        	}
        	if(commissiontax!="" && commissiontax!=null && commissiontax!="undefined" && typeof(commissiontax)!="undefined"){
        		grandtotal+=parseFloat(commissiontax);
        	}
        	$('#txtnettotal').val(grandtotal.toFixed(2));
		}
        function calcownertotal(t, e) {
            var mngfeeval, adminfee, tot;

            var i = isNumber(e);
            if (i == true) {
                mngfeeval = parseFloat($('#txtmanagementval').val());
                adminfee = parseFloat($('#txtadminfeeowner').val());

                tot = Math.round(mngfeeval + adminfee).toFixed(2);

                $('#txtownertotal').val(tot);
            }

        }

        function fillgrid() {

            var tenancyDate = $('#tenancyContractDate').jqxDateTimeInput('getDate');
            var instldate = $('#tenancyContractDate').jqxDateTimeInput('getDate');
			var chktenancychequeowner=$('#chktenancychequeowner').val();
            $('#periodToDate').jqxDateTimeInput({
                disabled: false
            });

            var startDate = $('#periodFromDate').jqxDateTimeInput('getDate');
            var endDate = $('#periodToDate').jqxDateTimeInput('getDate');
			endDate.setDate(endDate.getDate()+1);
            var datediff = (endDate.getFullYear() * 12 + endDate.getMonth()) - (startDate.getFullYear() * 12 + startDate.getMonth());

            $('#paymentDistributionGridId').jqxGrid('clear');
            $("#paymentDistributionGridId").jqxGrid('addrow', null, {});
            
            var i = 0,
                n = 0,
                terms_rows = 0,
                terms_rowlen = 0,
                amount = 0,
                k = 0;

            n = $('#txtnumofcheque').val();

            terms_rows = $('#termsOfContractGridId').jqxGrid('getrows');

            terms_rowlen = terms_rows.length;

            if (n > 0 || n != "") {
                var installment = datediff / n;
				var installindex=1;	
                for (i = 0; i < n; i++) {
                    if (i == 0) {
                        instldate = $('#periodFromDate').jqxDateTimeInput('getDate');
                    } else {
                        instldate.setMonth(instldate.getMonth() + installment);
                    }
					var taxtype=$('#termsOfContractGridId').jqxGrid('getcellvalue', 0, "taxtype");
					if(taxtype=="Inclusive"){
						var taxamount=$('#termsOfContractGridId').jqxGrid('getcellvalue', 0, "taxvalue");
						taxamount=parseFloat(taxamount);
						var nontaxamount=0.0;
						nontaxamount=$('#termsOfContractGridId').jqxGrid('getcellvalue', 0, "amount");
						amount=parseFloat(nontaxamount-taxamount);
						amount=amount/n;
						
					}
					else if(taxtype=="Exclusive"){
						amount = $('#termsOfContractGridId').jqxGrid('getcellvalue', 0, "amount") / n;
						
					}
					else{
						amount = $('#termsOfContractGridId').jqxGrid('getcellvalue', 0, "amount") / n;
					}
                    
                    $('#paymentDistributionGridId').jqxGrid('setcellvalue', i, "description", $('#termsOfContractGridId').jqxGrid('getcellvalue', 0, "description"));
                    $('#paymentDistributionGridId').jqxGrid('setcellvalue', i, "date", instldate);
                    $('#paymentDistributionGridId').jqxGrid('setcellvalue', i, "amount", amount);
                    $('#paymentDistributionGridId').jqxGrid('setcellvalue', i, "notes", $('#termsOfContractGridId').jqxGrid('getcellvalue', 0, "description")+" "+installindex+"/"+n);
					var paymentdesc=$('#paymentDistributionGridId').jqxGrid('getcellvalue', i, "description");
					if(chktenancychequeowner=='Y' && paymentdesc=="Rental value"){
                    	$('#paymentDistributionGridId').jqxGrid('setcellvalue', i, "paymentmethod", "Bank");
                    	$('#paymentDistributionGridId').jqxGrid('setcellvalue', i, "paidto", "Owner");
                    }
                    $("#paymentDistributionGridId").jqxGrid('addrow', null, {});
                    k = i;
                    installindex++;
                }
            } else {
                $('#paymentDistributionGridId').jqxGrid('setcellvalue', 0, "description", $('#termsOfContractGridId').jqxGrid('getcellvalue', 0, "description"));
                $('#paymentDistributionGridId').jqxGrid('setcellvalue', 0, "date", $('#periodFromDate').jqxDateTimeInput('getDate'));
                $('#paymentDistributionGridId').jqxGrid('setcellvalue', 0, "amount", $('#termsOfContractGridId').jqxGrid('getcellvalue', 0, "amount"));
                $('#paymentDistributionGridId').jqxGrid('setcellvalue', 0, "notes", $('#termsOfContractGridId').jqxGrid('getcellvalue', 0, "description"));
                $("#paymentDistributionGridId").jqxGrid('addrow', null, {});
            }
            
			var vatamount=0.0;
            for (var j = 0; j < terms_rowlen - 1; j++) {
            	amount = $('#termsOfContractGridId').jqxGrid('getcellvalue', j + 1, "amount");
            	var taxtype=$('#termsOfContractGridId').jqxGrid('getcellvalue', j + 1, "taxtype");
					if(taxtype=="Inclusive"){
						var taxamount=$('#termsOfContractGridId').jqxGrid('getcellvalue', j + 1, "taxvalue");
						taxamount=parseFloat(taxamount).toFixed(2);
						var nontaxamount=0.0;
						nontaxamount=$('#termsOfContractGridId').jqxGrid('getcellvalue', j + 1, "amount");
						nontaxamount=parseFloat(nontaxamount).toFixed(2);
						amount=parseFloat(nontaxamount-taxamount).toFixed(2);
						amount=parseFloat(amount)+parseFloat(taxamount);
						amount=parseFloat(amount).toFixed(2);
					}
					else if(taxtype=="Exclusive"){
						amount = $('#termsOfContractGridId').jqxGrid('getcellvalue', j + 1, "amount");
						var taxamount=$('#termsOfContractGridId').jqxGrid('getcellvalue', j + 1, "taxvalue");
						amount=parseFloat(amount)+parseFloat(taxamount);
						amount=parseFloat(amount).toFixed(2);
					}
					else{
						amount = $('#termsOfContractGridId').jqxGrid('getcellvalue', j + 1, "amount");
					}
                

                if (typeof(amount) != "undefined" && typeof(amount) != "NaN" && amount != "") {
                    $('#paymentDistributionGridId').jqxGrid('setcellvalue', i, "description", $('#termsOfContractGridId').jqxGrid('getcellvalue', j + 1, "description"));
                    $('#paymentDistributionGridId').jqxGrid('setcellvalue', i, "date", $('#periodFromDate').jqxDateTimeInput('getDate'));
                    $('#paymentDistributionGridId').jqxGrid('setcellvalue', i, "amount", amount);
                    $('#paymentDistributionGridId').jqxGrid('setcellvalue', i, "notes", $('#termsOfContractGridId').jqxGrid('getcellvalue', j + 1, "description"));

                    $("#paymentDistributionGridId").jqxGrid('addrow', null, {});
                    i++;
                }

            }

			var gridrows=$('#paymentDistributionGridId').jqxGrid('getrows');
			var termrows=$('#termsOfContractGridId').jqxGrid('getrows');
			var gridrowindex=0;
			for(var index=0;index<termrows.length;index++){
				var strvatamount=$('#termsOfContractGridId').jqxGrid('getcellvalue', index, "taxvalue");
				if(strvatamount!="" && strvatamount!=null && strvatamount!="undefined" && typeof(strvatamount)!="undefined"){
					vatamount+=parseFloat(strvatamount);
				}
			}
			
			if($('#commvatamount').val()!="" && $('#commvatamount').val()!=null && $('#commvatamount').val()!="undefined" && typeof($('#commvatamount').val())!="undefined"){
				vatamount+=parseFloat($('#commvatamount').val());
			}
			
            var comm = 0.0;
			if($('#cmbcommvattype').val()=="Inclusive"){
				var taxamount=parseFloat($('#commvatamount').val());
				var commission=parseFloat($('#txtcommisionval').val());
				comm=parseFloat(commission);
				comm=parseFloat(comm).toFixed(2);
			}
			else{
				comm=parseFloat($('#txtcommisionval').val());
				var taxamount=parseFloat($('#commvatamount').val());
				comm=parseFloat(comm)+parseFloat(taxamount);	
				comm=parseFloat(comm).toFixed(2);
			}
            for(var index=0;index<gridrows.length;index++){
				var desc=$('#paymentDistributionGridId').jqxGrid('getcellvalue', index, "description");
				if(desc=="" || desc==null || desc=="undefined" || typeof(desc)=="undefined"){
					gridrowindex=index;
					break;
				}
			}
			
			
            if (comm!="undefined" && comm!=null && comm!="" && typeof(comm)!="undefined") {
            	if(parseFloat(comm)>0.0){
                    $('#paymentDistributionGridId').jqxGrid('setcellvalue', gridrowindex, "description", "Commision");
                    $('#paymentDistributionGridId').jqxGrid('setcellvalue', gridrowindex, "date", $('#periodFromDate').jqxDateTimeInput('getDate'));
                    $('#paymentDistributionGridId').jqxGrid('setcellvalue', gridrowindex, "amount", comm);
                    $('#paymentDistributionGridId').jqxGrid('setcellvalue', gridrowindex, "notes", "Commision");
                    $("#paymentDistributionGridId").jqxGrid('addrow', null, {});
                    gridrowindex++;            		
            	}
            }
            /*if($('#chkvatdistributed').prop('checked')==true){
            	if(parseFloat(vatamount)>0.0){
					$('#paymentDistributionGridId').jqxGrid('setcellvalue', gridrowindex, "description", "VAT");
	                $('#paymentDistributionGridId').jqxGrid('setcellvalue', gridrowindex, "date", $('#periodFromDate').jqxDateTimeInput('val'));
	                $('#paymentDistributionGridId').jqxGrid('setcellvalue', gridrowindex, "amount", parseFloat(vatamount).toFixed(2));
	                $('#paymentDistributionGridId').jqxGrid('setcellvalue', gridrowindex, "notes", "VAT");
	                $("#paymentDistributionGridId").jqxGrid('addrow', null, {});
				}
            }*/
            
            if($('#chkvatdistributed').prop('checked')==true){
            	var rentalamount=$('#termsOfContractGridId').jqxGrid('getcellvalue', 0, 'nettotal');
            	var interval=parseInt($('#txtnumofcheque').val());
            	rentalamount=parseFloat(rentalamount/interval).toFixed(2);
            	for(var index=0;index<interval;index++){
            		$('#paymentDistributionGridId').jqxGrid('setcellvalue', index, "amount",parseFloat(rentalamount).toFixed(2));
            	}
            }
            else{
            	var taxamount=$('#termsOfContractGridId').jqxGrid('getcellvalue', 0, "taxvalue");
            	
            	var gridamount=$('#paymentDistributionGridId').jqxGrid('getcellvalue', 0, "amount");
            	console.log(taxamount+"::"+gridamount);
            	$('#paymentDistributionGridId').jqxGrid('setcellvalue', 0, "amount",parseFloat(gridamount+taxamount).toFixed(2));
            }
            
        }

        function calc_manageval() {
            var mngperc = $('#txtmanagementperc').val();

            var rent = $('#termsOfContractGridId').jqxGrid('getcellvalue', 0, "amount");
            var mngval = parseFloat(rent * mngperc / 100).toFixed(2);

            $('#txtmanagementval').val(mngval);

            var mngfeeval = parseFloat($('#txtmanagementval').val());
			var adminfee=0.0;
            if ($('#txtadminfeeowner').val() != '' && $('#txtadminfeeowner').val() != null && $('#txtadminfeeowner').val() != 'undefined') {
                ($('#txtadminfeeowner').val());
                adminfee = parseFloat($('#txtadminfeeowner').val());
            } else {
                adminfee = 0.00;
            }

            var tot = Math.round(mngfeeval + adminfee).toFixed(2);

            $('#txtownertotal').val(tot);

            LoadManagementfeeGrid();

        }

        function LoadManagementfeeGrid() {
            var instldate = $('#tenancyContractDate').jqxDateTimeInput('getDate');

            ('instldate date = ' + instldate);
            $('#periodToDate').jqxDateTimeInput({
                disabled: false
            });

            var startDate1 = $('#periodFromDate').jqxDateTimeInput('getDate');
            var endDate1 = $('#periodToDate').jqxDateTimeInput('getDate');
            endDate1.setDate(endDate1.getDate()+1);
            var datediff = (endDate1.getFullYear() * 12 + endDate1.getMonth()) - (startDate1.getFullYear() * 12 + startDate1.getMonth());

            var n = $('#txtmngfeeinstmnt').val();

            $('#managementfeeGridId').jqxGrid('clear');
            $("#managementfeeGridId").jqxGrid('addrow', null, {});

            if (n > 0 || n != "") {
            	
                var installment = datediff / n;

                for (i = 0; i < n; i++) {
                    

                    amount = ($('#txtmanagementval').val() / n).toFixed(2);

                    $('#managementfeeGridId').jqxGrid('setcellvalue', i, "date", startDate1);
                    $('#managementfeeGridId').jqxGrid('setcellvalue', i, "amount", amount);
                    $("#managementfeeGridId").jqxGrid('addrow', null, {});
                    startDate1.setMonth(startDate1.getMonth() + installment);
                }
            }

        }

        function isNumber_Id(evt, id) {
            //Function to restrict characters and enter number only
            var iKeyCode = (evt.which) ? evt.which : evt.keyCode
            if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) {
                $.messager.alert('Warning', 'Enter Numbers Only');
                $("#" + id + "").focus();
                return false;
            }
            return true;
        }
        
        function funSetCommVAT(){
        	var commission=$('#txtcommisionval').val();
        	if(commission!=null && commission!="" && commission!="undefined" && typeof(commission)!="undefined"){
        		commission=parseFloat($('#txtcommisionval').val());
        		commission.toFixed(2);
        		if($('#cmbcommvattype').val()=='Inclusive'){
	        		var inclusiveamt=(commission/105)*100;
	        		var taxamount=0.0;
	        		taxamount=parseFloat(commission)-parseFloat(inclusiveamt);
	        		$('#commvatamount').val(parseFloat(taxamount).toFixed(2));
	        		var strnettotal = $("#termsOfContractGridId").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'], true);
                	var nettotal = strnettotal.sum.replace(/,/g, '');
                	nettotal=parseFloat(nettotal)+parseFloat(commission);
                	("Net Total1:"+nettotal);
                	nettotal=parseFloat(nettotal).toFixed(2);
                	("Net Total2:"+nettotal);
                	$('#txtnettotal').val(nettotal);
	        	}
	        	else if($('#cmbcommvattype').val()=='Exclusive'){
	        		var taxamount=commission*(5/100);
					var finalamount=0.0;
					finalamount=parseFloat(commission)+parseFloat(taxamount);
					finalamount=finalamount.toFixed(2);
	        		$('#commvatamount').val(taxamount);
	        		var strnettotal = $("#termsOfContractGridId").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'], true);
                	var nettotal = strnettotal.sum.replace(/,/g, '');
                	nettotal=parseFloat(nettotal)+parseFloat(commission)+parseFloat(taxamount);
                	nettotal=parseFloat(nettotal);
                	nettotal=nettotal.toFixed(2);
	        		$('#txtnettotal').val(nettotal);
	        	}
	        	else{
	        		$('#commvatamount').val(0.0);
	        		var strnettotal = $("#termsOfContractGridId").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'], true);
                	var nettotal = strnettotal.sum.replace(/,/g, '');
                	nettotal=parseFloat(nettotal)+parseFloat(commission);
                	nettotal=parseFloat(nettotal);
                	nettotal=nettotal.toFixed(2);
	        		$('#txtnettotal').val(nettotal);
	        	}
        	}
        	
        }
        
        function funSetMgmtVATType(){
        	var mgmttotal=0.0;
        	if($('#txtownertotal').val()!='' && $('#txtownertotal').val()!='undefined' && $('#txtownertotal').val()!=null && typeof($('#txtownertotal').val())!='undefined'){
        		mgmttotal=parseFloat($('#txtownertotal').val());
        		mgmttotal=mgmttotal.toFixed(2);
        		if($('#cmbmgmtvattype').val()=='Inclusive'){
        			var inclusiveamount=(mgmttotal/105)*100;
        			inclusiveamount=parseFloat(inclusiveamount).toFixed(2);
        			var taxamount=parseFloat(mgmttotal)-parseFloat(inclusiveamount);
        			taxamount=parseFloat(taxamount).toFixed(2);
        			$('#mgmtvatamount').val(taxamount);
        			$('#mgmtnettotal').val(mgmttotal);
        		}
        		else if($('#cmbmgmtvattype').val()=='Exclusive'){
        			var taxamount=mgmttotal*(5/100);
        			taxamount=parseFloat(taxamount).toFixed(2);
        			$('#mgmtvatamount').val(taxamount);
        			var finalamount=parseFloat(mgmttotal)+parseFloat(taxamount);
        			finalamount=parseFloat(finalamount).toFixed(2);
        			$('#mgmtvatamount').val(taxamount);
        			$('#mgmtnettotal').val(finalamount);
        		}
        		else{
        			$('#mgmtvatamount').val(0.0);
        			$('#mgmtnettotal').val(mgmttotal);
        		}
        	}
        }
        
        function setVatDist(){
        	if($('#chkvatdistributed').prop('checked')==true){
        		$('#hidchkvatdistributed').val(1);
        	}
        	else{
        		$('#hidchkvatdistributed').val(0);
        	}
        }
        
        function setMgmtFee(){
        	//alert("Percent:"+$('#txtmanagementperc').val());
        	var rentalvalue=$('#termsOfContractGridId').jqxGrid('getcellvalue',0,'amount');
        	var rentaltaxtype=$('#termsOfContractGridId').jqxGrid('getcellvalue',0,'taxtype');
        	var finalvalue=0.0;
        	var mgmtfeepercent=$('#mgmtfeepercent').val();
        	var mgmtfeevalue=$('#mgmtfeevalue').val();
        	if(mgmtfeepercent==''){
        		mgmtfeepercent=0.0;
        	}
        	if(mgmtfeevalue==''){
        		mgmtfeevalue=0.0;
        	}
        	if(parseFloat(mgmtfeepercent)==0.0 && parseFloat(mgmtfeevalue)==0.0){
				if($('#txtmanagementperc').val()=="" || $('#txtmanagementperc').val()=="undefined" || $('#txtmanagementperc').val()==null || typeof($('#txtmanagementperc').val())=="undefined"){
					mgmtfeepercent=0.0;
				}
				else{
					mgmtfeepercent=$('#txtmanagementperc').val();
				}
				if($('#txtmanagementval').val()=="" || $('#txtmanagementval').val()=="undefined" || $('#txtmanagementval').val()==null || typeof($('#txtmanagementval').val())=="undefined"){
					mgmtfeevalue=0.0;
				}
				else{
					mgmtfeevalue=$('#txtmanagementval').val();
				}
			}
        	//alert("Percent:"+$('#txtmanagementperc').val());
        	var custompercent=0.0;
			if(parseFloat(mgmtfeepercent)>0.0 || parseFloat(mgmtfeevalue)>0.0){
				if(rentaltaxtype=="Inclusive"){
	        		var rentalvat=$('#termsOfContractGridId').jqxGrid('getcellvalue',0,'taxvalue');
	        		var calculated=parseFloat(rentalvalue)-parseFloat(rentalvat);
	        		var mgmtpercentvalue=parseFloat(calculated)*(mgmtfeepercent/100);
	        		if(parseFloat(mgmtpercentvalue)>parseFloat(mgmtfeevalue)){
	        			finalvalue=parseFloat(mgmtpercentvalue);
	        		}
	        		else{
	        			finalvalue=parseFloat(mgmtfeevalue);
	        		}
	        		custompercent=(parseFloat(finalvalue)/parseFloat(calculated))*100;
	        	}
	        	else{
	        		var mgmtpercentvalue=parseFloat(rentalvalue)*(mgmtfeepercent/100);
	        		if(parseFloat(mgmtpercentvalue)>parseFloat(mgmtfeevalue)){
	        			finalvalue=parseFloat(mgmtpercentvalue);
	        		}
	        		else{
	        			finalvalue=parseFloat(mgmtfeevalue);
	        		}
	        		custompercent=(parseFloat(finalvalue)/parseFloat(rentalvalue))*100;
	        	}
					
			}
			//alert("Percent:"+$('#txtmanagementperc').val());
			
			$('#txtmanagementperc').val(parseFloat(custompercent).toFixed(2));
        	$('#txtmanagementval').val(parseFloat(finalvalue).toFixed(2));
			//console.log("Admin FEe:"+$('#txtadminfeeowner').val());
        	if($('#txtadminfeeowner').val()!="" && $('#txtadminfeeowner').val()!=null && $('#txtadminfeeowner').val()!="undefined" && typeof($('#txtadminfeeowner').val())!="undefined"){
        		finalvalue+=parseFloat($('#txtadminfeeowner').val());
        	}
        	$('#txtownertotal').val(parseFloat(finalvalue).toFixed(2));
        	funSetMgmtVATType();
        	LoadManagementfeeGrid();
        }
        
        function getTenancyTypes() {
      		var x = new XMLHttpRequest();
      		x.onreadystatechange = function() {
      			if (x.readyState == 4 && x.status == 200) {
      				var items = x.responseText;
      				items = items.split('####');
      				//alert("items=="+items);
      				var typeItems = items[0].split(":");
      				var typeIdItems = items[1].split(":");
      				var optionsgroup = '<option value="">--Select--</option>';
      				for (var i = 0; i < typeItems.length; i++) {
      					optionsgroup += '<option value="' + typeIdItems[i] + '">'+ typeItems[i] + '</option>';
      				}
      				
      				//alert("optionsgroup=="+optionsgroup);
      				
      				$("select#cmbtenancytype").html(optionsgroup);
      				if ($('#hidcmbtenancytype').val() != null) {
      					$('#cmbtenancytype').val($('#hidcmbtenancytype').val());
      				}
      			} else {
      			}
      		}
      		x.open("GET", "getType.jsp", true);
      		x.send();
      	}  
    </script>

    <style>
        .hidden-scrollbar {
            overflow: auto;
            height: 490px;
        }
        .user-details-container{
        	border: 1px solid rgba(0,0,0,0.1);
        	border-radius: 8px;
        	padding-left: 10px;
        	padding-top: 5px;
        }
    </style>

</head>

<body onload="setValues();funchkprintConfig();getTenancyTypes();" style="overflow: auto; height: 400px;">
    <div id="mainBG" class="homeContent" data-type="background">
        <form id="frmTenancyContract" action="saveTenancyContract" method="post" autocomplete="off">
            <jsp:include page="../../../header.jsp"></jsp:include>
            <br />
            <div class='hidden-scrollbar'>
                <!-- <div  class='hidden-scrollbar'> -->
                <div class="container-fluid">
                    <div class="row">
                        <!-- style="border-bottom:1px solid #ccc;margin-bottom:4px;" -->
                        <div class="col-md-3">
                            <div class="col-md-3">Doc No</div>
                            <div class="col-md-9">
                                <input type="text" id="docno" name="docno" style="width: 60%;" value='<s:property value="docno"/>' tabindex="-1" />
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="col-md-3">Date</div>
                            <div class="col-md-9">
                                <div id="tenancyContractDate" name="tenancyContractDate" value='<s:property value="tenancyContractDate"/>'></div>
                                <input type="hidden" id="hidtenancyContractDate" name="hidtenancyContractDate" value='<s:property value="hidtenancyContractDate"/>' />
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="col-md-3">Type</div>
                            <div class="col-md-9">
                                <select id="cmbtenancytype" name="cmbtenancytype" style="width: 100%;" value='<s:property value="cmbtenancytype"/>'>
                                    <!-- <option value="">--Select--</option>
                                    <option value="1">Residence</option>
                                    <option value="2">Commercial</option> -->
                                </select>
                                <input type="hidden" id="hidcmbtenancytype" name="hidcmbtenancytype" value='<s:property value="hidcmbtenancytype"/>' />

                            </div>
                        </div>
						<div class="col-md-3">
							<div class="user-details-container">
								<label name="lblcreatedby" id="lblcreatedby"><s:property value="lblcreatedby"/></label>
								<label name="lblpostedby" id="lblpostedby"><s:property value="lblpostedby"/></label>
							</div>
							<input type="checkbox" name="chkvatdistributed" id="chkvatdistributed" onchange="setVatDist();"/>&nbsp;Multi Tax Invoice
							<input type="hidden" id="hidchkvatdistributed" name="hidchkvatdistributed" value='<s:property value="hidchkvatdistributed"/>' />
                        </div>
                    </div>

                    <div class="row" style="padding: 1.5em 0;">

                        <div class="col-md-5" style="border: 1px #ccc solid; height: 135px; padding-top: 1em;">
                            <div class="col-md-1">Tenant</div>
                            <div class="col-md-10">
                                <input style="width:75%;" type="text" id="txttenant" name="txttenant" placeholder="Press F3 to Search" value='<s:property value="txttenant"/>' onkeydown="getTenant(event);" />
                                <button class="myButton" type="button" name="btntenantmaster" id="btntenantmaster">Master</button>
                                <input type="hidden" id="txttenantdocno" name="txttenantdocno" value='<s:property value="txttenantdocno"/>' />
                                <br /> <span style="height: 50px; font-weight: 600;" id="tenantdetail">

								</span>
                            </div>

                        </div>
                        <div class="col-md-1"></div>

                        <div class="col-md-6" style="border: 1px #ccc solid; height: 135px; padding-top: 1em;">

                            <div class="col-md-1">Property</div>
                            <div class="col-md-10">
                                <input type="text" id="txtproperty" name="txtproperty" style="width: 50%;" placeholder="Press F3 to Search" value='<s:property value="txtproperty"/>' onkeydown="getProperty(event);" />
                                <label id="lblmanage" name="lblmanage"><s:property value="lblmanage"/></label>
                                <button class="myButton" type="button" name="btnpropertymaster" id="btnpropertymaster">Master</button>
                                <button class="myButton" type="button" name="btnpropertycalculate" id="btnpropertycalculate">Calculate</button>
                                <input type="hidden" id="txtpropertydocno" name="txtpropertydocno" value='<s:property value="txtpropertydocno"/>' />
                                <br /> <span style="height: 50px; font-weight: 600;" id="propertydetail">

								</span>
                            </div>

                        </div>

                    </div>

                    <div class="row">

                        <div class="col-md-5">
                            <div class="col-md-3">Contract Period</div>
                            <div class="col-md-9">
                                <div class="col-md-6">
                                    <select id="cmbcontractperiod" name="cmbcontractperiod" style="width: 100%;" onchange="funInsEndDate()" value='<s:property value="cmbcontractperiod"/>'>
                                        <option value="">--Select--</option>
                                        <option value="1">Years</option>
                                        <option value="2">Months</option>
                                        <option value="3">Days</option>
                                    </select>
                                    <input type="hidden" id="hidcmbcontractperiod" name="hidcmbcontractperiod" value='<s:property value="hidcmbcontractperiod"/>' />
                                </div>
                                <div class="col-md-6">
                                    <input type="text" id="txtcontractperiod" name="txtcontractperiod" style="width: 100%; text-align: center;" onkeypress="isNumber(event);" onblur="funInsEndDate()" value='<s:property value="txtcontractperiod"/>' />
                                </div>
                            </div>
                        </div>

                        <div class="col-md-2">
                            <div class="col-md-3">Period From</div>
                            <div class="col-md-9">
                                <div id="periodFromDate" name="periodFromDate" onchange="funInsEndDate()" value='<s:property value="periodFromDate"/>'></div>
                                <input type="hidden" id="hidperiodFromDate" name="hidperiodFromDate" value='<s:property value="hidperiodFromDate"/>' />
                            </div>
                        </div>

                        <div class="col-md-2">
                            <div class="col-md-3">To</div>
                            <div class="col-md-9">
                                <div id="periodToDate" name="periodToDate" value='<s:property value="periodToDate"/>'></div>
                                <input type="hidden" id="hidPeriodToDate" name="hidPeriodToDate" value='<s:property value="hidPeriodToDate"/>' />
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="col-md-5">Notification Days</div>
                            <div class="col-md-7">
                                <input type="text" id="txtnotificationperiod" name="txtnotificationperiod" onkeypress="isNumber(event);" style="width: 60%; text-align: right;" value='<s:property value="txtnotificationperiod"/>' />
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <table width="100%">
                            <tr>
                                <td width="50%">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">Terms of Contract</div>
                                        <div class="panel-body">
                                            <div id="termsOfContractDiv">
                                                <jsp:include page="termsOfContractGrid.jsp"></jsp:include>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-3">Commission Fee%</div>
                                                <div class="col-md-3">
                                                    <input type="text" id="txtcommisionperc" name="txtcommisionperc" style="width: 100%; text-align: right;" onkeyup="calc_commision(this,event)" value='<s:property value="txtcommisionperc"/>' />
                                                </div>
                                                <div class="col-md-3">Commission Value</div>
                                                <div class="col-md-3">
                                                    <input type="text" id="txtcommisionval" name="txtcommisionval" style="width: 100%; text-align: right;" onkeypress="isNumber(event);" value='<s:property value="txtcommisionval"/>' onkeyup="calcCommissionPercent();"/>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-3">VAT Type</div>
                                                <div class="col-md-3">
                                                	<select name="cmbcommvattype" id="cmbcommvattype" value='<s:property value="cmbcommvattype"/>' onchange="funSetCommVAT();">
                                                		<option value="">--Select--</option>
                                                		<option value="Inclusive">Inclusive</option>
                                                		<option value="Exclusive">Exclusive</option>
                                                	</select>
                                                	<input type="hidden" name="hidcmbcommvattype" id="hidcmbcommvattype" value='<s:property value="hidcmbcommvattype"/>'>  
                                                </div>
                                                <div class="col-md-3">VAT Amount</div>
                                                <div class="col-md-3">
                                                    <input type="text" id="commvatamount" name="commvatamount" style="width: 100%; text-align: right;" onkeypress="isNumber(event);" value='<s:property value="commvatamount"/>' readonly="readonly"/>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-offset-6 col-md-3">Net Total</div>
                                                <div class="col-md-3">
                                                	<input type="text" id="txtnettotal" name="txtnettotal" style="width: 100%; text-align: right;" onkeypress="isNumber(event);" value='<s:property value="txtnettotal"/>' />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td width="50%">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">From Owner</div>
                                        <div class="panel-body">
                                            <div class=" col-md-6">
                                                <div class="row">
                                                    <div class="col-md-7">Management Fee%</div>
                                                    <div class="col-md-5" style="text-align:right;">
                                                    	<!-- onkeypress="calc_manageval();" -->
                                                        <input type="text" id="txtmanagementperc" name="txtmanagementperc" style="width: 100%; text-align: right;"  value='<s:property value="txtmanagementperc"/>' onchange="setMgmtFee();"/>
                                                    	<label name="lblmgmtfeepercent" id="lblmgmtfeepercent" hidden="true" style="text-align:right;"></label>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-7">Management Fee Value</div>
                                                    <div class="col-md-5"  style="text-align:right;">
                                                        <input type="text" id="txtmanagementval" name="txtmanagementval" style="width: 100%; text-align: right;" value='<s:property value="txtmanagementval"/>'  onchange="setMgmtFee();"/>
                                                    	<label name="lblmgmtfeevalue" id="lblmgmtfeevalue" hidden="true" style="text-align:right;"></label>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-7">Administration Fee</div>
                                                    <div class="col-md-5">
                                                    	<!-- onkeyup="calc_manageval();" -->
                                                        <input type="text" id="txtadminfeeowner" name="txtadminfeeowner" style="width: 100%; text-align: right;"  value='<s:property value="txtadminfeeowner"/>'  onchange="setMgmtFee();"/>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-7">Total</div>
                                                    <div class="col-md-5">
                                                        <input type="text" id="txtownertotal" name="txtownertotal" style="width: 100%; text-align: right;" onkeypress="isNumber(event);" value='<s:property value="txtownertotal"/>' />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-7">VAT Type</div>
                                                    <div class="col-md-5">
                                                        <select name="cmbmgmtvattype" id="cmbmgmtvattype" value='<s:property value="cmbmgmtvattype"/>' onchange="funSetMgmtVATType();" style="width:100%;">
                                                        	<option value="">--Select--</option>
                                                        	<option value="Inclusive">Inclusive</option>
                                                        	<option value="Exclusive">Exclusive</option>
                                                        </select>
                                                        <input type="hidden" name="hidcmbmgmtvattype" id="hidcmbmgmtvattype" value='<s:property value="hidcmbmgmtvattype"/>'>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-7">VAT Amount</div>
                                                    <div class="col-md-5">
                                                        <input type="text" id="mgmtvatamount" name="mgmtvatamount" style="width: 100%; text-align: right;" value='<s:property value="mgmtvatamount"/>' readonly="readonly"/>
                                                    </div>
                                                </div>
												<div class="row">
                                                    <div class="col-md-7">Net Total</div>
                                                    <div class="col-md-5">
                                                        <input type="text" id="mgmtnettotal" name="mgmtnettotal" style="width: 100%; text-align: right;" onchange="LoadManagementfeeGrid()" value='<s:property value="mgmtnettotal"/>' />
                                                    </div>
                                                </div>                                                
                                            </div>
                                            <div class="row">
                                                <div class=" col-md-6">
                                                    <div class="col-md-4">Installments</div>
                                                    <div class="col-md-5">
                                                        <input type="text" id="txtmngfeeinstmnt" name="txtmngfeeinstmnt" style="width: 100%; text-align: right;" onchange="LoadManagementfeeGrid()" value='<s:property value="txtmngfeeinstmnt"/>' />
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div id="mngDiv">
                                                        <jsp:include page="managementfeeGrid.jsp"></jsp:include>
                                                    </div>
                                                </div>
                                            </div>

                                            <div id="agentDiv">
                                                <jsp:include page="agentGrid.jsp"></jsp:include>
                                            </div>
                                        </div>
                                    </div>

                                </td>
                            </tr>
                        </table>
                    </div>

                    <div class="row">
                        <div class="panel panel-default">
                            <div class="panel-heading">Payment Distribution</div>
                            <div class="panel-body">
                                <div class="row">
                                    <div class=" col-md-6">
                                        <div class="col-md-3">No. Of Cheque</div>
                                        <div class="col-md-2">
                                            <input type="text" id="txtnumofcheque" name="txtnumofcheque" style="width: 100%; text-align: center;" onkeypress="isNumber(event);" value='<s:property value="txtnumofcheque"/>' />
                                        </div>
                                        <div class="col-md-2">
                                            <input type="button" class="btn btn-info" id="btnfillgrid" value="Fill" style="width: 100%;" onclick="fillgrid();">
                                        </div>
                                    </div>
                                </div>
                                <div id="paymentDistributionDiv">
                                    <jsp:include page="paymentDistributionGrid.jsp"></jsp:include>
                                </div>
                                <div class="pull-right" style="margin-top:10px;">
                                    Holding Security
                                    <input type="text" name="holdingsecurity" id="holdingsecurity" value='<s:property value="holdingsecurity"/>' style="text-align:right;">
                                </div>

                            </div>
                        </div>
                    </div>
					<input type="hidden" id="renewalstatus" name="renewalstatus" value='<s:property value="renewalstatus"/>' />
					<input type="hidden" id="contractdocno" name="contractdocno" value='<s:property value="contractdocno"/>' />
                    <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
                    <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>' />
                    <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>' />
                    <input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>' />
                    <input type="hidden" id="termgridlength" name="termgridlength" value='<s:property value="termgridlength"/>' />
                    <input type="hidden" id="agentgridlength" name="agentgridlength" value='<s:property value="agentgridlength"/>' />
                    <input type="hidden" id="paymentgridlength" name="paymentgridlength" value='<s:property value="paymentgridlength"/>' />
                    <input type="hidden" id="tenantdet" name="tenantdet" value='<s:property value="tenantdet"/>' />
                    <input type="hidden" id="propertydet" name="propertydet" value='<s:property value="propertydet"/>' />
                    <input type="hidden" id="hidnettotal" name="hidnettotal" />
                    <input type="hidden" id="hidrent" name="hidrent" />
                    <input type="hidden" id="mngfeegridlen" name="mngfeegridlen" value='<s:property value="mngfeegridlen"/>' />
					<input type="hidden" id="chktenancychequeowner" name="chktenancychequeowner" value='<s:property value="chktenancychequeowner"/>' />
					<input type="hidden" id="mgmtfeepercent" name="mgmtfeepercent" value='<s:property value="mgmtfeepercent"/>' />
					<input type="hidden" id="mgmtfeevalue" name="mgmtfeevalue" value='<s:property value="mgmtfeevalue"/>' />
					<input type="hidden" id="printchk" name="printchk" value='<s:property value="printchk"/>' />
                </div>
            </div>
        </form>
        <div id="refnosearchwindow1">
            <div></div>
        </div>
        <div id="refnosearchwindow">
            <div></div>
        </div>
        <div id="salespersonwindow">
            <div></div>
        </div>
<div id="printWindow">
	<div></div><div></div>
</div> 
    </div>
</body>

</html>