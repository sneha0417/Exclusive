
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Tabs</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="../../css/main.css" rel="stylesheet" type="text/css" />
<link href="../../css/body.css" media="screen" rel="stylesheet" type="text/css" />
<link href="../../css/tab.css" media="screen" rel="stylesheet" type="text/css" />


<%@ include file="../vehiclemaster/tab.jsp" %> 
<script type="text/javascript" src="jquery-1.7.2.min.js"></script>
</head>
<body>
<ul id="tabs">
    <li><a href="#" name="tab1">Vendor Details</a></li>
    <li><a href="#" name="tab2">Product Details</a></li>
    <!-- <li><a href="#" name="tab3">Credit Details</a></li>
    <li><a href="#" name="tab4">Vendor Details</a></li>
    <li><a href="#" name="tab5">Product Details</a></li>
    <li><a href="#" name="tab6">Credit Details</a></li>
    <li><a href="#" name="tab7">Vendor Details</a></li>
    <li><a href="#" name="tab8">Product Details</a></li>
    <li><a href="#" name="tab9">Credit Details</a></li>
    <li><a href="#" name="tab10">Vendor Details</a></li>  -->   
    <!--<li><a href="#" name="tab11">Credit Details</a></li>
    <li><a href="#" name="tab12">Vendor Details</a></li>
    <li><a href="#" name="tab13">Product Details</a></li>
    <li><a href="#" name="tab14">Credit Details</a></li>
    <li><a href="#" name="tab15">Vendor Details</a></li> -->    
</ul>

<div id="content"> 
    <div id="tab1">
<div style="width:1053px;border-color: white;">
<fieldset>
    <legend style="color:black;font-weight:bold;">Credit details</legend>
<table width="1043">
  <tr>
    <td width="154">Credit Period(Min)</td>
    <td width="171"><input type="text" name="credit_period_min" style="width:60px"></td>
    <td width="149">Credit Period(Max)</td>
    <td width="187"><input type="text" name="credit_period_max" style="width:60px"></td>
    <td width="125">Credit Amount</td>
    <td width="217"><input type="text" name="credit_amount"></td>
  </tr>
</table>
<br>
</fieldset>
</div>
<br>
<div style="width:1053px;">
<fieldset>
    <legend style="color:black;font-weight:bold;">Representation</legend>
<table width="1043" height="46">
  <tr>
    <td><div align="left">Check if Representation Office&nbsp;&nbsp;&nbsp;  
    <select name="check_representation_office"><option>--Select--</option></select></div></td>    
    </tr>
</table>
 <table width="1043" height="46">
  <tr>
    <td><div align="right">Name</div></td>
    <td><input type="text" name="name" ></td>
    <td><div align="right">Address</div></td>    
    <td><textarea name="address" cols="21" rows="2" style="resize: none;"></textarea></td>
  </tr>
  <tr>
    <td><div align="right">Tel 1</div></td>
    <td><input type="text" name="tel1"></td>
    <td><div align="right">Fax</div></td>
    <td><input type="text" name="fax"></td>
  </tr>
  <tr>
    <td><div align="right">Contact</div></td>
    <td><input type="text" name="contact"></td>
    <td><div align="right">E-mail</div></td>
     <td><input type="text" name="email" style="width:250px"></td></td>
  </tr>
  <tr>
     <td><div align="right">Mobile No.</div></td>
     <td><input type="text" name="mob_no"></td>
    <td colspan="2">&nbsp;</td>
  </tr>
</table> 
</fieldset>
</div>
<br>
<div style="width:1053px;">
<fieldset>
  <table width="1043" height="46">
  <tr>
    <td width="268"><div align="right">Pmt mode&nbsp;&nbsp;&nbsp;
    <select name="pmt_mode"><option>--Select--</option></select></div></td>
    <td width="270"><div align="center"><button class="btn" type="button" onclick="button()">Bank Details</button>
      </div>
      </td>
    </tr>
</table>
<br>
</fieldset>
</div>
<br>
</body>

</div>

    <div id="tab2">
   

<body bgcolor="#fofofo">
<div style="width:900px;">
<fieldset>
    <legend style="color:black;font-weight:bold;">Communication address</legend>
<table width="848" height="102">
  <tr>
    <td width="113">Add 1</td>
    <td colspan="2"><textarea name="ca_add1" cols="39" rows="2" style="resize: none;"></textarea></td>
    <td><div align="center">Add 2</div></td>
    <td colspan="2"><textarea name="ca_add2" cols="35" rows="2" style="resize: none;"></textarea></td>
    </tr>
  <tr>
    <td>Tel 1</td>
    <td width="144"><input type="text" name="ca_tel1"></td>
    <td width="113"><div align="center">Tel 2</div></td>
    <td width="156"><input type="text" name="ca_tel2"></td>
    <td width="97"><div align="center">Fax</div></td>
    <td width="185"><input type="text" name="ca_fax"></td>
  </tr>
  <tr>
    <td>Contact</td>
    <td><input type="text" name="ca_contact"></td>
    <td><div align="center">Ext No</div></td>
    <td><input type="text" name="ca_ext_no"  style="width:50px"></td>
    <td><div align="center">Mobile No</div></td>
    <td><input type="text" name="ca_mob_no"></td>
  </tr>
  <tr>
    <td>E-Mail</td>
    <td colspan="2"><input type="text" name="ca_email" style="width:252px;"></td>
    <td><div align="center">G.Email</div></td>
    <td colspan="2"><input type="text" name="ca_g_email" style="width:252px;"></td>
    </tr>
</table>
<br>
</fieldset>
</div>
<br>
<div style="width:900px;">
<fieldset>
    <legend style="color:black;font-weight:bold;">Permanent address</legend>
<table width="850" height="102">
  <tr>
    <td width="105">Add 1</td>
    <td colspan="2"><textarea name="pa_add1" cols="39" rows="2" style="resize: none;"></textarea></td>
    <td><div align="center">Add 2</div></td>
    <td colspan="2"><textarea name="pa_add2" cols="35" rows="2" style="resize: none;"></textarea></td>
    </tr>
  <tr>
    <td>Tel 1</td>
    <td width="144"><input type="text" name="pa_tel1"></td>
    <td width="121"><div align="center">Tel 2</div></td>
    <td width="150"><input type="text" name="pa_tel2"></td>
    <td width="98"><div align="center">Fax</div></td>
    <td width="192"><input type="text" name="pa_fax"></td>
  </tr>
  <tr>
    <td>Contact</td>
    <td><input type="text" name="pa_contact"></td>
    <td><div align="center">Ext No</div></td>
    <td><input type="text" name="pa_ext_no"  style="width:50px"></td>
    <td><div align="center">Mobile No</div></td>
    <td><input type="text" name="pa_mob_no"></td>
  </tr>
  <tr>
    <td>E-Mail</td>
    <td colspan="2"><input type="text" name="pa_email" style="width:252px;"></td>
    <td><div align="center">G.Email</div></td>
    <td colspan="2"><input type="text" name="pa_g_email" style="width:252px;"></td>
    </tr>
</table>
<br>
</fieldset>
</div>
<br>
<div style="width:900px;">
<fieldset>
    <legend style="color:black;font-weight:bold;">Optional address</legend>
<table width="854" height="102">
  <tr>
    <td width="97">Add 1</td>
    <td colspan="2"><textarea name="op_add1" cols="39" rows="2" style="resize: none;"></textarea></td>
    <td><div align="center">Add 2</div></td>
    <td colspan="2"><textarea name="op_add2" cols="35" rows="2" style="resize: none;"></textarea></td>
    </tr>
  <tr>
    <td>Tel 1</td>
    <td width="144"><input type="text" name="op_tel1"></td>
    <td width="126"><div align="center">Tel 2</div></td>
    <td width="153"><input type="text" name="op_tel2"></td>
    <td width="101"><div align="center">Fax</div></td>
    <td width="193"><input type="text" name="op_fax"></td>
  </tr>
  <tr>
    <td>Contact</td>
    <td><input type="text" name="op_contact"></td>
    <td><div align="center">Ext No</div></td>
    <td><input type="text" name="op_ext_no"  style="width:50px"></td>
    <td><div align="center">Mobile No</div></td>
    <td><input type="text" name="op_mob_no"></td>
  </tr>
  <tr>
    <td>E-Mail</td>
    <td colspan="2"><input type="text" name="op_email" style="width:252px;"></td>
    <td><div align="center">G.Email</div></td>
    <td colspan="2"><input type="text" name="op_g_email" style="width:252px;"></td>
    </tr>
</table>
<br>
</fieldset>
</div>
<br>
4

    </div>
    </div>
</body>
</html>