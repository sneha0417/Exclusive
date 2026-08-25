<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
<!--  <link href="../../../../css/body.css" rel="stylesheet" type="text/css"> -->
 <script type="text/javascript">
 function test(){
	 getBranch();
	 getStatus();
 }
function getBranch(){
	//alert("here");
		var x = new XMLHttpRequest();
		var items, brchItems, currItems;
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				
				items = items.split('####');
				brchIdItems = items[0].split(",");
				brchItems = items[1].split(",");
				var optionsbrch = '<option value="">--Select--</option>';
				for (var i = 0; i < brchItems.length; i++) {
					optionsbrch += '<option value="' + brchIdItems[i] + '">'
							+ brchItems[i] + '</option>';
				}
				$("select#cmbrlsbranch").html(optionsbrch);
				if ($('#hidcmbrlsbranch').val() != null) {
					$('#cmbrlsbranch').val($('#hidcmbrlsbranch').val());
				}
			} else {
			}
		}
		x.open("GET", "getBranch.jsp", true);
		x.send();
	}
function getLocation(value)
{
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	items= x.responseText;
			 	items=items.split('***');
		        var locationItems=items[0].split(",");
		        var locationidItems=items[1].split(",");
		        	var optionslocation = '<option value="">--Select--</option>';
		       for ( var i = 0; i < locationItems.length; i++) {
		    	   optionslocation += '<option value="' + locationidItems[i] + '">' + locationItems[i] + '</option>';
		        }
		       $("select#cmbrlsloc").html(optionslocation);
			   //	$('#accno').val($('#accnohidden').val()) ;
			   	if ($('#hidcmbrlsloc').val() != null) {
			$('#cmbrlsloc').val($('#hidcmbrlsloc').val());
		}
			}
		else
			{
			}
	}
	x.open("GET","../nonpoolvehicle/getLocation.jsp?id="+value,true);
	x.send();
//document.write(document.getElementById("authname").value);

}
function getStatus()
{
	//alert("here");
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	items= x.responseText;
			 	items=items.split('***');
		        var status=items[0].split(",");
		        var stdesc=items[1].split(",");
		        	var optionsstatus = '<option value="">--Select--</option>';
		       for ( var i = 0; i < stdesc.length; i++) {
		    	   optionsstatus += '<option value="' + status[i] + '">' + stdesc[i] + '</option>';
		        }
		       $("select#cmbstatus").html(optionsstatus);
			   //	$('#accno').val($('#accnohidden').val()) ;
			   	if ($('#hidcmbstatus').val() != null) {
			$('#cmbstatus').val($('#hidcmbstatus').val());
		}
			}
		else
			{
			}
	}
	x.open("GET","getStatus.jsp",true);
	x.send();
//document.write(document.getElementById("authname").value);

}
</script>
</head>
<body >
<div id="mainBG" class="homeContent" data-type="background"> 
<form autocomplete="off" >
<fieldset><legend>Release Info</legend>
		<table width="100%" >
		  <tr>
		    <td align="right">Fleet No</td>
		    <td align="left"><input type="text" name="releasefleet" id="releasefleet" value='<s:property value="releasefleet"/>'></td>
	      </tr>
		  <tr>
		    <td align="right">Branch</td>
		    <td align="left"><select name="cmbrlsbranch" id="cmbrlsbranch" value='<s:property value="cmbrlsbranch"/>' onchange="getLocation(this.value);">
		      <option value="">--Select--</option>
	        </select>
	        <input type="hidden" name="hidcmbrlsbranch" id="hidcmbrlsbranch" value='<s:property value="hidcmbrlsbranch"/>'></td>
	      </tr>
		  <tr>
		    <td align="right">Location</td>
		    <td align="left"><select name="cmbrlsloc" id="cmbrlsloc" value='<s:property value="cmbrlsloc"/>'><option value="">--Select--</option></select><input type="hidden" name="hidcmbrlsloc" id="hidcmbrlsloc" value='<s:property value="hidcmbrlsloc"/>'></td>
	      </tr>
		  <tr>
		    <td align="right">Rental Type</td>
		    <td align="left"><select name="cmbrentalstatus" id="cmbrentalstatus" value='<s:property value="cmbrentalstatus"/>'>
		      <option value="">--Select--</option>
		      <option value="R">Rental</option>
		      <option value="L">Lease</option>
	        </select>
	        <input type="hidden"  name="hidcmbrentalstatus" id="hidcmbrentalstatus" value='<s:property value="hidcmbrentalstatus"/>'></td>
	      </tr>
		  <tr>
		    <td align="right">Status</td>
		    <td align="left"><select name="cmbstatus" id="cmbstatus" value='<s:property value="cmbstatus"/>'>
		      <option value="">--Select--</option>
		      
	        </select>
	        <input type="hidden" name="hidcmbstatus" id="hidcmbstatus" value='<s:property value="hidcmbstatus"/>'></td>
	      </tr>
  </table>
<!-- <input type="button" onclick="funtest();"> -->
		</fieldset>
</form>

<fieldset>
										<legend>Purchase Info</legend>
										<table width="88%">
											<tr>
												<td align="right">Dealer
													</div>
												</td>
												<td><%-- <input type="text" id="dealer3" name="dealer3" style="width: 20%;" value='<s:property value="dealer3"/>'> 
													<input type="text" id="dealer4" name="dealer4" style="width: 50%;" value='<s:property value="dealer4"/>'> --%>
													<input type="text" name="dealer" id="dealer" value='<s:property value="dealer"/>' ondblclick="funSearchdblclick();" onkeydown="getDealer(event);">
													</td><input type="hidden" name="hiddealer" id="hiddealer" value='<s:property value="hiddealer"/>'>
											</tr>
											<tr>
												<td width="28%" align="right">Deal No</td>
												<td width="72%"><input type="text" id="deal_no2" name="deal_no2" value='<s:property value="deal_no2"/>'/></td>
											</tr>
											<tr>
												<td align="right">Purchase Type</td>
												<td><select name="purchase" id="purchase" value='<s:property value="purchase"/>' style="width:62%;">
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
												<td><input type="text" name="purchase_cost"  id="purchase_cost" value='<s:property value="purchase_cost"/>' /></td>
											</tr>
											<tr>
												<td align="right">Additions</td>
												<td><input type="text" id="additions" name="additions" value='<s:property value="additions"/>' /></td>
											</tr>
											<tr>
												<td align="right">&nbsp;Total</td>
												<td><input type="text" id="total" name="total" value='<s:property value="total"/>' onfocus="getTotal();"/></td>
											</tr>
										</table>
										<br />
										<br />
										<br />
									</fieldset>
<table width="100%" border="1">
  <tr>
    <td align="right">Dealer</td>
    <td align="left"><input type="text" name="dealer" id="dealer" value='<s:property value="dealer"/>' ondblclick="funSearchdblclick();" onkeydown="getDealer(event);"></td><input type="hidden" name="hiddealer" id="hiddealer" value='<s:property value="hiddealer"/>'>
  </tr>
  <tr>
    <td align="right">Deal No</td>
    <td align="left"><input type="text" id="deal_no" name="deal_no" value='<s:property value="deal_no"/>'/></td>
  </tr>
  <tr>
    <td align="right">Purchase Type</td>
    <td align="left"><select name="purchase" id="purchase" value='<s:property value="purchase"/>' style="width:62%;">
      <option>--Select--</option>
      <option value="Cash">Cash</option>
      <option value="Credit">Credit</option>
    </select></td>
  </tr>
  <tr>
    <td align="right">LPO No</td>
    <td align="left"><input type="text" id="lpo_no" name="lpo_no" value='<s:property value="lpo_no"/>'/></td>
  </tr>
  <tr>
    <td align="right">Purchase Invoice</td>
    <td align="left"><input type="text" id="purchase_invoice" name="purchase_invoice" value='<s:property value="purchase_invoice"/>'/></td>
  </tr>
  <tr>
    <td align="right">Purchase Date</td>
    <td align="left"><div id='jqxPurchaseDate' name='jqxPurchaseDate'
														value='<s:property value="jqxPurchaseDate"/>'></div>
    <input
													type="hidden" id="hidjqxPurchaseDate" name="hidjqxPurchaseDate"
													value='<s:property value="hidjqxPurchaseDate"/>' /></td>
  </tr>
  <tr>
    <td align="right">Purchase Cost</td>
    <td align="left"><input type="text" name="purchase_cost"  id="purchase_cost" value='<s:property value="purchase_cost"/>' /></td>
  </tr>
  <tr>
    <td align="right">Additions</td>
    <td align="left"><input type="text" id="additions" name="additions" value='<s:property value="additions"/>' /></td>
  </tr>
  <tr>
    <td align="right">Total</td>
    <td align="left"><input type="text" id="total" name="total" value='<s:property value="total"/>' onfocus="getTotal();"/></td>
  </tr>
</table>




</div>
</body>
</html>