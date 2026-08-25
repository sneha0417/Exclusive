<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<jsp:include page="tab.css" />
<%-- <%@include file="tab.jsp"%> --%>

<script type="text/javascript">
	
	$(document).ready(function() {
		$("#jqxDate1").jqxDateTimeInput({
			width : '125px',
			height : '15px',
			formatString : "dd.MM.yyyy"
		});
		$("#jqxPurchaseDate").jqxDateTimeInput({
			width : '125px',
			height : '15px',
			formatString : "dd.MM.yyyy"
		});
		$("#jqxFinRegDate").jqxDateTimeInput({
			width : '125px',
			height : '15px',
			formatString : "dd.MM.yyyy"
		});
		$("#jqxFinRelDate").jqxDateTimeInput({
			width : '125px',
			height : '15px',
			formatString : "dd.MM.yyyy"
		});
		$("#jqxOtherRegExp").jqxDateTimeInput({
			width : '125px',
			height : '15px',
			formatString : "dd.MM.yyyy"
		});
		$("#jqxOtherInsExp").jqxDateTimeInput({
			width : '125px',
			height : '15px',
			formatString : "dd.MM.yyyy"
		});
		$("#jqxWrntyFrmDate").jqxDateTimeInput({
			width : '125px',
			height : '15px',
			formatString : "dd.MM.yyyy"
		});
		$("#jqxWrntyToDate").jqxDateTimeInput({
			width : '125px',
			height : '15px',
			formatString : "dd.MM.yyyy"
		});
		$("#jqxLstSrvcDate").jqxDateTimeInput({
			width : '125px',
			height : '15px',
			formatString : "dd.MM.yyyy"
		});
	});

	function funReset() {
		$('#frmVehicle')[0].reset();
	}
	function funReadOnly() {
		$('#frmVehicle input').attr('readonly', true);
		getAuth();
		getBrand();
		getPlateCode();
		getGroup();
		getModel();
		getYOM();
		getColor();
		getFinancier();
		getBrch();
		/* $('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
	}
	function funRemoveReadOnly() {
		$('#frmVehicle input').attr('readonly', false);
		//$('#jqxDateTimeInput').jqxDateTimeInput({		disabled : false		});
		$('#docno').attr('readonly', true);
	}
	function getAuth() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var authItems = items[0].split(",");
				var authIdItems = items[1].split(",");
				var optionsauth = '<option value="-1">--Select--</option>';
				for (var i = 0; i < authItems.length; i++) {
					optionsauth += '<option value="' + authIdItems[i] + '">'
							+ authItems[i] + '</option>';
				}
				$("select#cmbauthority").html(optionsauth);
				if ($('#hidcmbauthority').val() != null) {
					$('#cmbauthority').val($('#hidcmbauthority').val());
				}
			} else {
			}
		}
		x.open("GET", "getAuthority.jsp", true);
		x.send();
	}
	function getColor() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var colorItems = items[0].split(",");
				var colorIdItems = items[1].split(",");
				var optionscolor = '<option value="-1">--Select--</option>';
				for (var i = 0; i < colorItems.length; i++) {
					optionscolor += '<option value="' + colorIdItems[i] + '">'
							+ colorItems[i] + '</option>';
				}
				$("select#cmbveh_color").html(optionscolor);
				if ($('#hidcmbveh_color').val() != null) {
					$('#cmbveh_color').val($('#hidcmbveh_color').val());
				}
			} else {
			}
		}
		x.open("GET", "getColor.jsp", true);
		x.send();
	}
	function getPlateCode() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var plateItems = items[0].split(",");
				var plateIdItems = items[1].split(",");
				var optionsplate = '<option value="-1">--Select--</option>';
				for (var i = 0; i < plateItems.length; i++) {
					optionsplate += '<option value="' + plateIdItems[i] + '">'
							+ plateItems[i] + '</option>';
				}
				$("select#cmbplate").html(optionsplate);
				if ($('#hidcmbplate').val() != null) {
					$('#cmbplate').val($('#hidcmbplate').val());
				}
			} else {
			}
		}
		x.open("GET", "getPlateCode.jsp", true);
		x.send();
	}
	function getGroup() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var groupItems = items[0].split(",");
				var groupIdItems = items[1].split(",");
				var optionsgroup = '<option value="-1">--Select--</option>';
				for (var i = 0; i < groupItems.length; i++) {
					optionsgroup += '<option value="' + groupIdItems[i] + '">'
							+ groupItems[i] + '</option>';
				}
				$("select#cmbgroup").html(optionsgroup);
				if ($('#hidcmbgroup').val() != null) {
					$('#cmbgroup').val($('#hidcmbgroup').val());
				}
			} else {
			}
		}
		x.open("GET", "getGroup.jsp", true);
		x.send();
	}

	function getBrand() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('***');
				var brandItems = items[0].split(",");
				var brandidItems = items[1].split(",");
				var optionsbrand = '<option value="-1">--Select--</option>';
				for (var i = 0; i < brandItems.length; i++) {
					optionsbrand += '<option value="' + brandidItems[i] + '">'
							+ brandItems[i] + '</option>';
				}
				$("select#cmbbrand").html(optionsbrand);
				if ($('#hidcmbbrand').val() != null) {
					$('#cmbbrand').val($('#hidcmbbrand').val());
				}
			} else {
			}
		}
		x.open("GET", "getBrand.jsp", true);
		x.send();
	}
	function getModel() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('####');
				var modelItems = items[0].split(",");
				var modelidItems = items[1].split(",");
				var optionsmodel = '<option value="-1">--Select--</option>';
				for (var i = 0; i < modelItems.length; i++) {
					optionsmodel += '<option value="' + modelidItems[i] + '">'
							+ modelItems[i] + '</option>';
				}
				$("select#cmbmodel").html(optionsmodel);
				if ($('#hidcmbmodel').val() != null) {
					$('#cmbmodel').val($('#hidcmbmodel').val());
				}
			} else {
			}
		}
		x.open("GET", "getModel.jsp", true);
		x.send();
	}
	function getYOM() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('####');
				var yomItems = items[0].split(",");
				var yomidItems = items[1].split(",");
				var optionsyom = '<option value="-1">--Select--</option>';
				for (var i = 0; i < yomItems.length; i++) {
					optionsyom += '<option value="' + yomidItems[i] + '">'
							+ yomItems[i] + '</option>';
				}
				$("select#cmbyom").html(optionsyom);
				if ($('#hidcmbyom').val() != null) {
					$('#cmbyom').val($('#hidcmbyom').val());
				}
			} else {
			}
		}
		x.open("GET", "getYOM.jsp", true);
		x.send();
	}
	function getFinancier() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('####');
				var finItems = items[0].split(",");
				var finidItems = items[1].split(",");
				var optionsfin = '<option value="-1">--Select--</option>';
				for (var i = 0; i < finItems.length; i++) {
					optionsfin += '<option value="' + finidItems[i] + '">'
							+ finItems[i] + '</option>';
				}
				$("select#cmbfinancer").html(optionsfin);
				if ($('#hidcmbfinancer').val() != null) {
					$('#cmbfinancer').val($('#hidcmbfinancer').val());
				}
			} else {
			}
		}
		x.open("GET", "getFinancier.jsp", true);
		x.send();
	}
	function getBrch() {
		var x = new XMLHttpRequest();
		var items, brchItems, currItems;
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('####');
				brchIdItems = items[0].split(",");
				brchItems = items[1].split(",");
				var optionsbrch = '';
				for (var i = 0; i < brchItems.length; i++) {
					optionsbrch += '<option value="' + brchIdItems[i] + '">'
							+ brchItems[i] + '</option>';
				}
				$("select#cmbavail_br1").html(optionsbrch);
				if ($('#hidcmbavail_br1').val() != null) {
					$('#cmbavail_br1').val($('#hidcmbavail_br1').val());
				}
			} else {
			}
		}
		x.open("GET", "getBranch.jsp", true);
		x.send();
	}

	function setValues() {
		$("#jqxDate1").jqxDateTimeInput('val', $('#hidjqxDate1').val());
		$("#jqxPurchaseDate").jqxDateTimeInput('val',
				$('#jqxPurchaseDate').val());
		$("#jqxFinRegDate").jqxDateTimeInput('val', $('#jqxFinRegDate').val());
		$("#jqxFinRelDate").jqxDateTimeInput('val', $('#jqxFinRelDate').val());
		$("#jqxOtherRegExp")
				.jqxDateTimeInput('val', $('#jqxOtherRegExp').val());
		$("#jqxOtherInsExp")
				.jqxDateTimeInput('val', $('#jqxOtherInsExp').val());
		$("#jqxWrntyFrmDate").jqxDateTimeInput('val',
				$('#jqxWrntyFrmDate').val());
		$("#jqxWrntyToDate")
				.jqxDateTimeInput('val', $('#jqxWrntyToDate').val());
		$("#jqxLstSrvcDate")
				.jqxDateTimeInput('val', $('#jqxLstSrvcDate').val());
		if ($('#hidpurchase').val() != null) {
			$('#purchase').val($('#hidpurchase').val());
		}
		if ($('#hidcmbinsurance_type').val() != null) {
			$('#cmbinsurance_type').val($('#hidcmbinsurance_type').val());
		}
		if ($('#hidcmbfuel').val() != null) {
			$('#cmbfuel').val($('#hidcmbfuel').val());
		}
		if ($('#hidbranded').val() != null) {
			$('#branded').val($('#hidbranded').val());
		}
	}
</script>
</head>
<body onload="funReadOnly();setValues();">
	<%
		session.setAttribute("FormName", "Vehicle Master");
		session.setAttribute("Code", "VEH");
	%>
	
	<div id="mainBG" class="homeContent" data-type="background"> 
		<form id="frmVehicle" action="saveVehicle" method="post">
	<jsp:include page="../../../../header.jsp"></jsp:include>	
			<fieldset>
				<legend>Vehicle Details</legend>
				<table width="100%" height="108">
					<tr>
						<td width="51" height="24" id="f" style="text-align: right"><div
								align="right">Fleet No</div></td>
						<td colspan="4">
							<input type="text" name="fleetno" id="fleetno"
							style="width: 50px;" value='<s:property value="fleetno"/>'> 
							<input type="text" name="fleetname" id="fleetname"
							style="width: 250px;" value='<s:property value="fleetname"/>'></td>
						<td width="113" align="right">Date</td>
						<td colspan="2" align="left"><div id='jqxDate1'
								name='jqxDate1' value='<s:property value="jqxDate1"/>'></div> <input
							type="hidden" id="hidjqxDate1" name="hidjqxDate1"
							value='<s:property value="hidjqxDate1"/>' /></td>
						<td width="68" align="right">Doc No</td>
						<td width="159" colspan="2" align="left"><input type="text"
							name="docno" id="docno" style="width: 50%;" readonly="readonly" value='<s:property value="docno"/>'></td>
					</tr>
					<tr>
						<td height="24" align="right">Authority</td>
						<td width="93"><select name="cmbauthority" id="cmbauthority"
							value='<s:property value="cmbauthority"/>'>
								<option>--Select--</option>
						</select> <input type="hidden" id="hidcmbauthority" name="hidcmbauthority"
							value='<s:property value="hidcmbauthority"/>' /></td>
						<td width="61" align="right">Plate Code</td>
						<td width="94"><select name="cmbplate" id="cmbplate"
							value='<s:property value="cmbplate"/>'>
								<option>--select--</option>
						</select> <input type="hidden" id="hidcmbplate" name="hidcmbplate"
							value='<s:property value="hidcmbplate"/>' /></td>
						<td width="69" align="right">Reg No</td>
						<td align="left"><input type="text" name="regno" id="regno"
							style="width: 93px;" value='<s:property value="regno"/>' autocomplete="off"></td>
						<td width="102" align="right">Group</td>
						<td colspan="3" align="left"><select name="cmbgroup"
							id="cmbgroup" value='<s:property value="cmbgroup"/>'>
								<option>--Select--</option>
						</select> <input type="hidden" id="hidcmbgroup" name="hidcmbgroup"
							value='<s:property value="hidcmbgroup"/>' />&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="text" name="group_name" id="group_name" value='<s:property value="group_name"/>'></td>
					</tr>
					<tr>
						<td height="24" style="text-align: right">Brand</td>
						<td><select name="cmbbrand" id="cmbbrand" value='<s:property value="cmbbrand"/>'>
								<option>--Select--</option>
						</select> <input type="hidden" id="hidcmbbrand" name="hidcmbbrand"
							value='<s:property value="hidcmbbrand"/>' /></td>
						<td align="right">Model</td>
						<td><select name="cmbmodel" id="cmbmodel" value='<s:property value="cmbmodel"/>'>
								<option>--Select--</option>
						</select> <input type="hidden" id="hidcmbmodel" name="hidcmbmodel"
							value='<s:property value="hidcmbmodel"/>' /></td>
						<td align="right">YoM</td>
						<td><select name="cmbyom" id="cmbyom" value='<s:property value="cmbyom"/>'>
								<option>--Select--</option>
								
						</select> <input type="hidden" id="hidcmbyom" name="hidcmbyom"
							value='<s:property value="hidcmbyom"/>' /></td>
						<td align="right">Ast status</td>
						<td width="214" align="left"><input type="text"
							name="aststatus" id="aststatus" style="width: 30%; align: left;" value='<s:property value="aststatus"/>' pattern="{1,3}" required>
							&nbsp;&nbsp;&nbsp;&nbsp;
							Op. Status <input type="text"
							name="opstatus" id="opstatus" style="width: 30%;" value='<s:property value="opstatus"/>'></td>
					</tr>
					<tr>
						<td height="24" colspan="2" align="right">Salik Tag</td>
						<td colspan="2"><input type="text" id="salik_tag" name="salik_tag"   value='<s:property value="salik_tag"/>' /></td>
						<td colspan="2" align="right">TC No</td>
						<td colspan="2" align="left"><input type="text" id="tcno" name="tcno"  value='<s:property value="tcno"/>' /></td>
						<td><input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/></td>
					</tr>
				</table>
				<br />

				<ul id="tabs">
					<li><a href="#" name="tab1">Induction</a></li>
					<li><a href="#" name="tab2">Services And Other Details</a></li>
					<li><a href="#" name="tab3">Specifications</a></li>
				</ul>
				<!-- <iframe  width=1100px height=400px align='center' id='page' ></iframe> -->
				<div id="content">
					<div id="tab1">
						<table width="100%">
							<tr>
								<td width="34%">
									<fieldset>
										<legend>Purchase Info</legend>
										<table width="88%">
											<tr>
												<td align="right">Dealer
													</div>
												</td>
												<td><input type="text" id="dealer3" name="dealer3" style="width: 20%;" value='<s:property value="dealer3"/>'> 
													<input type="text" id="dealer4" name="dealer4" style="width: 50%;" value='<s:property value="dealer4"/>'></td>
											</tr>
											<tr>
												<td width="28%" align="right">Deal No</td>
												<td width="72%"><input type="text" id="deal_no2" name="deal_no2" value='<s:property value="deal_no2"/>'/></td>
											</tr>
											<tr>
												<td align="right">Purchase Type</td>
												<td><select name="purchase" id="purchase" value='<s:property value="purchase"/>'>
														<option>--Select--</option>
														<option value="Cash">Cash</option>
														<option value="Credit">Credit</option>
												</select></td>
												<td><input type="hidden" id="hidpurchase" name="hidpurchase"
													value='<s:property value="hidpurchase"/>' /></td>
											</tr>
											<tr>
												<td align="right">&nbsp;LPO No</td>
												<td><input type="text" id="lpo_no" name="lpo_no" value='<s:property value="lpo_no"/>'/></td>
											</tr>
											<tr>
												<td align="right">Purchase Invoice</td>
												<td><input type="text" id="purchase_invoice" name="purchase_invoice" value='<s:property value="purchase_invoice"/>'/></td>
											</tr>
											<tr>
												<td align="right">Purchase Date</td>
												<td><div id='jqxPurchaseDate' name='jqxPurchaseDate'
														value='<s:property value="jqxPurchaseDate"/>'></div> <input
													type="hidden" id="hidjqxPurchaseDate" name="hidjqxPurchaseDate"
													value='<s:property value="hidjqxPurchaseDate"/>' /></td>
											</tr>
											<tr>
												<td align="right">Purchase Cost</td>
												<td><input type="text" id="purchase_cost"  id="purchase_cost" value='<s:property value="purchase_cost"/>'/></td>
											</tr>
											<tr>
												<td align="right">Additions</td>
												<td><input type="text" id="additions" name="additions" value='<s:property value="additions"/>' /></td>
											</tr>
											<tr>
												<td align="right">&nbsp;Total</td>
												<td><input type="text" id="total" name="total" value='<s:property value="total"/>'/></td>
											</tr>
										</table>
										<br />
										<br />
										<br />
									</fieldset>
								</td>

								<td width="33%"> 
									<fieldset>
										<legend>Finance Info</legend>
										<table width="96%">
											<tr>
												<td align="right">Financer</td>
												<td><select name="cmbfinancer" id="cmbfinancer" value='<s:property value="cmbfinancer"/>'>
														<option>--Select--</option>
												</select> <input type="hidden" id="hidcmbfinancer" name="hidcmbfinancer"
													value='<s:property value="hidcmbfinancer"/>' /></td>
											</tr>
											<tr>
												<td align="right">&nbsp;Interest Amt</td>
												<td><input type="text" id="interest_amt" name="interest_amt" value='<s:property value="interest_amt"/>'/></td>
											</tr>
											<tr>
												<td align="right">&nbsp;Down Payment</td>
												<td><input type="text" id="down_payment" name="down_payment" value='<s:property value="down_payment"/>' /></td>
											</tr>
											<tr>
												<td align="right">&nbsp;No. of Installments</td>
												<td><input type="text" id="no_installments" name="no_installments"
													style="width: 50px;" value='<s:property value="no_installments"/>'/></td>
											</tr>
											<tr>
												<td width="40%" align="right">&nbsp;Registered Date</td>
												<td width="60%"><div id='jqxFinRegDate'
														name='jqxFinRegDate' value='<s:property value="jqxFinRegDate"/>'></div>
													<input type="hidden" id="hidjqxFinRegDate" name="hidjqxFinRegDate"
													value='<s:property value="hidjqxFinRegDate"/>' /></td>
											</tr>
											<tr>
												<td align="right">Release Date</td>
												<td><div id='jqxFinRelDate' name='jqxFinRelDate'
														value='<s:property value="jqxFinRelDate"/>'></div> <input
													type="hidden" id="hidjqxFinRelDate" name="hidjqxFinRelDate"
													value='<s:property value="hidjqxFinRelDate"/>' /></td>
											</tr>
											<tr>
												<td><div align="right">
														<span style="text-align: right">Installment Amt</span>
													</div></td>
												<td><input type="text" id="installment_amt" name="installment_amt" value='<s:property value="installment_amt"/>'/></td>
											</tr>
											<tr>
												<td align="right">&nbsp;CostTran No</td>
												<td><input type="text" id="tran_no" name="tran_no" value='<s:property value="tran_no"/>'/></td>
											</tr>
											<tr>
												<td align="right">&nbsp;Depr %</td>
												<td><input type="text" id="depr_perc" name="depr_perc" value='<s:property value="depr_perc"/>'/></td>
											</tr>
											<tr>
												<td align="right">&nbsp;Accu. Dep.</td>
												<td><input type="text" id="accu_dep" name="accu_dep" value='<s:property value="accu_dep"/>'/></td>
											</tr>
										</table>
										<br />
										<br />
									</fieldset>
								</td>

								<td width="33%">
									<fieldset>
										<legend>Other Info</legend>
										<table width="80%">
											<tr>
												<td align="right">&nbsp;Reg. Expiry</td>
												<td><div id='jqxOtherRegExp' name='jqxOtherRegExp'
														value='<s:property value="jqxOtherRegExp"/>'></div> <input
													type="hidden" id="hidjqxOtherRegExp" name="hidjqxOtherRegExp"
													value='<s:property value="hidjqxOtherRegExp"/>' /></td>
											</tr>
											<tr>
												<td align="right">Insurance Type</td>
												<td><select name="cmbinsurance_type"
													id="cmbinsurance_type" value='<s:property value="cmbinsurance_type"/>'>
														<option value="Comprehensive">Comprehensive</option>
														<option value="3rdParty">3rd Party</option>
												</select> <input type="hidden" id="hidcmbinsurance_type"
													name="hidcmbinsurance_type"
													value='<s:property value="hidcmbinsurance_type"/>' /></td>
											</tr>
											<tr>
												<td align="right">&nbsp;&nbsp;Insurance Comp</td>
												<td><input type="text" id="insurance_comp" name="insurance_comp"
													style="width: 40px;" value='<s:property value="insurance_comp"/>'/></td>
											</tr>
											<tr>
												<td align="right">Insured Amt</td>
												<td><input type="text" id="insured_amt" name="insured_amt" value='<s:property value="insured_amt"/>'/></td>
											</tr>
											<tr>
												<td align="right">Insurance Expiry</td>
												<td><div id='jqxOtherInsExp' name='jqxOtherInsExp'
														value='<s:property value="jqxOtherInsExp"/>'></div> <input
													type="hidden" id="hidjqxOtherInsExp" name="hidjqxOtherInsExp"
													value='<s:property value="hidjqxOtherInsExp"/>' /></td>
											</tr>
											<tr>
												<td align="right">Premium %</td>
												<td><input type="text" id="premium_perc" id="premium_perc" value='<s:property value="premium_perc"/>' /></td>
											</tr>
											<tr>
												<td align="right">Policy No</td>
												<td><input type="text" id="policy_no" name="policy_no" value='<s:property value="policy_no"/>' /></td>
											</tr>
											<tr>
												<td align="right">Premium Amt</td>
												<td><input type="text" id="premium_amt" name="premium_amt" value='<s:property value="premium_amt"/>' /></td>
											</tr>
										</table>
										<br />
										<br />
										<br />
										<br />
										<br />
									</fieldset>
								</td>
							</tr>
						</table>
					</div>

					<div id="tab2">
						<table width="100%">
							<tr>
								<td colspan="8" style="text-align: right">
									<fieldset>
										<legend>Vehicle Info</legend>
										<table width="100%">
											<tr>
												<td width="11%" height="28" align="right">Engine No</td>
												<td width="14%" align="left"><input type="text"
													id="engine_no" name="engine_no" value='<s:property value="engine_no"/>'/></td>
												<td width="7%" align="right" >VIN</td>
												<td width="12%" align="left"><input type="text"
													name="vin" id="vin" value='<s:property value="vin"/>' /></td>
												<td width="15%" align="right">Chasis No</td>
												<td width="17%" align="left"><input type="text"
													id="chasis_no" name="chasis_no" value='<s:property value="chasis_no"/>' /></td>
												<td width="9%" align="right">Color</td>
												<td width="15%" align="left"><select
													name="cmbveh_color" id="cmbveh_color" value='<s:property value="cmbveh_color"/>'>
														<option>--Select--</option>
												</select> <input type="hidden" id="hidcmbveh_color" name="hidcmbveh_color"
													value='<s:property value="hidcmbveh_color"/>' /></td>
											</tr>
										</table>
									</fieldset>
								</td>
							</tr>

							<tr>
								<td colspan="8" style="text-align: right">
									<fieldset>
										<legend>Warranty Info</legend>
										<table width="100%">
											<tr>
												<td width="11%" height="28" align="right">Warranty
													Period</td>
												<td width="13%" align="left"><input type="text"
													id="warranty_period" name="warranty_period" value='<s:property value="warranty_period"/>'/></td>
												<td width="8%" align="right">From Date</td>
												<td width="12%" align="left"><div id='jqxWrntyFrmDate'
														name='jqxWrntyFrmDate'
														value='<s:property value="jqxWrntyFrmDate"/>'></div>
														 <input
													type="hidden" id="hidjqxWrntyFrmDate" name="hidjqxWrntyFrmDate"
													value='<s:property value="hidjqxWrntyFrmDate"/>' /></td>
												<td width="15%" align="right">To Date</td>
												<td width="17%" align="left"><div id='jqxWrntyToDate'
														name='jqxWrntyToDate'
														value='<s:property value="jqxWrntyToDate"/>'></div> 
														<input
													type="hidden" id="hidjqxWrntyToDate" name="hidjqxWrntyToDate"
													value='<s:property value="hidjqxWrntyToDate"/>' /></td>
												<td width="9%" align="right">Warranty KM</td>
												<td width="15%" align="left"><input type="text"
													name="warranty_km" id="warranty_km"  value='<s:property value="warranty_km"/>' /></td>
											</tr>
										</table>
									</fieldset>
								</td>
							</tr>
							<tr>
								<td colspan="8" align="right"></td>
							</tr>

							<tr>
								<td colspan="8" style="text-align: right">
									<fieldset>
										<legend>Service Info</legend>
										<table width="100%">
											<tr>
												<td width="11%" height="28" align="right">Service KM</td>
												<td width="13%" align="left"><input type="text"
													id="service_km" name="service_km" value='<s:property value="service_km"/>'/></td>
												<td width="8%" align="right">Last Srvc. Date</td>
												<td width="12%" align="left">
														<div id='jqxLstSrvcDate'
														name='jqxLstSrvcDate'
														value='<s:property value="jqxLstSrvcDate"/>'></div> 
														<input type="hidden" id="hidjqxLstSrvcDate" name="hidjqxLstSrvcDate"
													value='<s:property value="hidjqxLstSrvcDate"/>' /></td>
												<td width="15%" align="right">Last Service KM</td>
												<td width="17%" align="left"><input type="text"
													id="last_srvc_km" name="last_srvc_km" value='<s:property value="last_srvc_km"/>'/></td>
												<td width="9%"></td>
												<td width="15%"></td>
											</tr>
										</table>
									</fieldset>
								</td>
							</tr>

							<tr>
								<td colspan="8" style="text-align: right">
									<fieldset>
										<legend>Release Info</legend>
										<table width="100%">
											<tr>
												<td width="11%" height="30" align="right">Current KM</td>
												<td width="13%" align="left"><input type="text"
													id="current_km" name="current_km" value='<s:property value="current_km"/>'/></td>
												<td width="8%" align="right">Fuel</td>
												<td width="12%" align="left"><select name="cmbfuel"
													id="cmbfuel" value='<s:property value="cmbfuel"/>'>
														<option>----</option>
														<option value="H">H</option>
														<option value="F">F</option>
												</select> 
												<input type="hidden" id="hidcmbfuel" name="hidcmbfuel"
													value='<s:property value="hidcmbfuel"/>' /></td>
												<td width="15%" align="right">Branded</td>
												<td width="17%" align="left"><select name="branded" id="branded" value='<s:property value="branded"/>'>
														<option>----</option>
														<option value="Y">Y</option>
														<option value="N">N</option>
												</select>
												<input type="hidden" id="hidbranded" name="hidbranded"
													value='<s:property value="hidbranded"/>' />
												</td>
												<%-- <td width="9%" align="right">Rent Type</td>
												<td width="15%" align="left"><select
													name="cmbrent_type" id="cmbrent_type" value='<s:property value="cmbrent_type"/>'>
														<option>--Select--</option>
												</select> <input type="hidden" id="hidcmbrent_type" name="hidcmbrent_type"
													value='<s:property value="hidcmbrent_type"/>' /></td> --%>
											</tr>
											<tr>
												<td height="30"></td>
												<td></td>
												<td align="right">Avail. Br.</td>
												<td colspan="5" align="left"><select
													name="cmbavail_br1" id="cmbavail_br1" value='<s:property value="hidcmbavail_br1"/>' >
														<option>----</option>
												</select> <input type="hidden" id="hidcmbavail_br1" name="hidcmbavail_br1"
													value='<s:property value="hidcmbavail_br1"/>' /> 
													<input type="text" id="tcno" name="tcno" style="width: 275px;" value='<s:property value="tcno"/>'/></td>
											</tr>
										</table>
									</fieldset>
								</td>
							</tr>
						</table>
					</div>

					<div id="tab3">
						<center><jsp:include page="specificationGrid.jsp"></jsp:include></center>
						<br />
					</div>

				</div>
			</fieldset>
		</form>
<br/>
<div id="window">
	<div id="windowHeader" class="windowHead">
		<span> <img src="../../../../icons/search_new.png" alt="" style="margin-right: 15px" />Search</span>
	</div>
	<div id="windowContent" class="windowCont" style="overflow: hidden;">
		<jsp:include page="vehicleSearch.jsp"></jsp:include>
	</div></div>

	</div>
</body>
</html>