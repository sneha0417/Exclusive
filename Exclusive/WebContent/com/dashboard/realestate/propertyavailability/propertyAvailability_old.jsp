<jsp:include page="../../../../includes.jsp"></jsp:include>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<link
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
	rel="stylesheet" />

<script type="text/javascript">
	$(document) .ready(function() {
						  $("#todate").jqxDateTimeInput({ width: '125px', height: '25px',formatString:"dd.MM.yyyy"}); 
						  $("#fromdate").jqxDateTimeInput({ width: '125px', height: '25px',formatString:"dd.MM.yyyy"});
						$("body")
								.prepend(
										'<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
						$("body")
								.prepend(
										"<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

						/*  $('#ptypewindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Product Type Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
						 $('#ptypewindow').jqxWindow('close'); */

						autocompletefields(); //function call for autocomplete fields for Area,Landmark,Type 
 
						 load_data();
					});
		 
	function autocompletefields() {
		// area autocomplete
		$("#ddlarea").select2({
			minimumInputLength : 1,
			placeholder : 'Search Area',
			ajax : {
				url : 'getArea.jsp',
				dataType : 'json',
				type : "GET",
				quietMillis : 50,
				data : function(params) {
					return {
						term : params.term
					};
				},
				processResults : function(data) {
					return {
						results : data
					};
				}
			}
		});
		// area autocomplete

		//Landmark
		$("#ddllandmark").select2({
			minimumInputLength : 1,
			placeholder : 'Search Landmark',
			ajax : {
				url : 'getLandmark.jsp',
				dataType : 'json',
				type : "GET",
				quietMillis : 50,
				data : function(params) {
					return {
						term : params.term
					};
				},
				processResults : function(data) {
					return {
						results : data
					};
				}
			}
		});
		//landmark

		//unittype
		$("#ddlunittype").select2({
			minimumInputLength : 1,
			placeholder : 'Search Type',
			ajax : {
				url : 'getUnitType.jsp',
				dataType : 'json',
				type : "GET",
				quietMillis : 50,
				data : function(params) {
					return {
						term : params.term
					};
				},
				processResults : function(data) {
					return {
						results : data
					};
				}
			}
		});
		//unittype
		
		//Contact Person
		$("#ddlcontact").select2({
			minimumInputLength : 1,
			placeholder : 'Search Contact',
			ajax : {
				url : 'getContactPerson.jsp',
				dataType : 'json',
				type : "GET",
				quietMillis : 50,
				data : function(params) {
					return {
						term : params.term
					};
				},
				processResults : function(data) {
					return {
						results : data
					};
				}
			}
		});
		//Contact Person
	}

	function funExportBtn() {
		JSONToCSVCon(padata, 'Product Availability', true);
	}

	function funreload(event) {

	}

	function funClearData() {

	}

	function clickfun() {
		 $('.box').animate({  width: 'toggle'},'1200');
		/* var x = document.getElementById("btnfiltermenu");
		if (x.style.display === "none") {
			x.style.display = "block";
		} else {
			x.style.display = "none";
		} */
	}
	
	$('#btnSearch').click(function(){ 
	   load_data(); 
	});

	function load_data() {
		
		var fromdate,todate,contact,rdotype,ddlunittype,area,landmark,prtype,mgprpty;
		
		fromdate=$('#fromdate').val();
		todate=$('#todate').val();
		contact=$('#ddlcontact').val();
		area=$('#ddlarea').val();
		landmark=$('#ddllandmark').val();
		rdotype=$('#rdotype').val();
		ddlunittype=$('#ddlunittype').val();
		//mgprpty=$('#ddlunittype').val();
			
		$.ajax({
			url : 'getPropertyDetails.jsp',
			type : 'post',
			//data:{data1:data1,data2:data2},
			dataType : 'json',
			success : function(data) {
				//console.log(data);
				//var data1 = $.parseJSON(data);
				var html = '';
				$.each(	data,function(index, item) {
					//now you can access properties using dot notation											
					html += '<div class="row divproperty item" >';
					/* html += '<span class="occupied-badge">Occupied</span>'; */
					html += '<span class="vacant-badge">Vacant</span>';
					html += '<div class="col-md-1 col-xs-3">';
					html += '<a href="#"><img src="" class="img-round" style="width: 50px; height: 50px;"></a>';
					html += '</div>';
					html += '<div class="col-md-9 col-xs-6">';
					html += '<label class="lblpty" >Address:'
							+ item.address
							+ ' </label> ';
					html += '<label  class="lblpty">Owner :'
							+ item.owner + '</label>';
					html += '<label class="lblpty">Tenant:'
							+ item.tenant + '</label>';
					html += '<label class="lblpty">Availability Date:'
							+ item.inddate + '</label>';
					html += '<label class="lblpty">Current Status:</label>';
					html += '<label class="lblpty">Ind Date:'
							+ item.inddate + '</label>';
					html += '</div>';
					html += '<div class="col-md-2 col-xs-3">';
					html += '<a href="javascript:void(0)" onclick="showTenancyContractInTab(\''
							+ item.doc_no
							+ '\',\''
							+ item.address
							+ '\');"  style="margin-bottom: 1px;">Create New Contract</a> <br />';
					html += '</div>';
					html += '</div>';

				});
				$('#divlist').append(html);
			}

				});

	}
	
	function clear_data()
	{
		
	}

	function showTenancyContractInTab(pdocno, pname) {
		var path1 = "com/realestate/tenancycontract/tenancyContract.jsp";
		var name = "Tenancy Contract";
		var url = document.URL;
		var reurl = url.split("com");
		var mode = "A";

		window.parent.formName.value = "Tenancy Contract";
		window.parent.formCode.value = "TNC";
		var detName = "Tenancy Contract";

		var path = path1
				+ "?pdocno="
				+ pdocno
				+ "&mode="
				+ mode
				+ "&pname="
				+ pname.replace("/\s/g", "%20").replace('#', '%23').replace(
						'&', '%26');
		top.addTab(detName, reurl[0] + "" + path);
	}
</script>

<style type="text/css">
 
    
.item {
	position: relative;
	/*  padding-top:20px; 
    display:inline-block;*/
}

.occupied-badge {
	position: absolute;
	right: 35px;
	top: -18px;
	background: red;
	text-align: center;
	border-radius: 15px;
	color: white;
	padding: 5px 10px;
	font-size: 10px;
}

.vacant-badge {
	position: absolute;
	right: 35px;
	top: -18px;
	background: #19d219cf;
	text-align: center;
	border-radius: 15px;
	color: white;
	padding: 5px 10px;
	font-size: 10px;
}

.divproperty {
	margin-top: 3em;
	border: 1px solid #ccc;
	padding: 1em;
	box-shadow: 0px 1px 5px 1px #ccc;
}

.btnfilter {
	margin-top: 10px;
	border: #ccc solid 1px;
	padding: 0.5em;
	background-color: #10e2cb;
	color: #fff;
	font-size: 1.3em;
}

.lblpty {
	padding-right: 1em;
	font-weight: 200 !important;
}

@media only screen and (max-width: 600px) {
	.divproperty {
		padding: 0.3em;
		margin-top: 1em;
	}
}

.hidden-scrollbar {
	overflow: auto;
	height: 530px;
}

.page-header {
	padding-bottom: 0px !important;
	margin: 10px 0 20px !important;
}
</style>
</head>
<body>

	<div class='hidden-scrollbar'>
		<div class="container-fluid">
			<div class="page-header">
				<h4>
					Property Availability <a class="btn btn-info" style=""
						id="btnfilter" onclick="clickfun()"> <i class="fa fa-filter"
						aria-hidden="true"></i>
					</a>
				</h4>
			</div> 
			<div class="row box" id="btnfiltermenu"
				style="display: none; padding: 0.1em; border: #ccc 1px solid; box-shadow: 0px 1px 5px 1px #ccc;">
				<div class="col-md-12 ">
				
					<div class="row" style="padding: 1em;border-bottom: 1px solid #ccc;">
					<div class="col-md-3">
							<div class="col-md-2">From</div>
							<div class="col-md-10">
							
							<div id="fromdate" name="fromdate" ></div>
							 
							</div>
						</div>
						<div class="col-md-3">
							<div class="col-md-2">To</div>
							<div class="col-md-10">
							<div id="todate" name="todate" ></div> 
							</div>
						</div>
						<div class="col-md-3">
							<div class="col-md-3">Contact Person</div>
							<div class="col-md-9">
								<select id="ddlcontact" style="width: 100%;"></select>
							</div>
						</div>
						
							<div class="col-md-3" style="padding: 8px 25px;">
							 <button type="button" class="btn btn-info" id="btnSearch">
								<i class="fa fa-search" aria-hidden="true"></i>&nbsp;&nbsp;Search
							</button>
							 <button type="button" class="btn btn-warning" onclick="clear_data();" >
								<i class="fa fa-close" aria-hidden="true"></i>&nbsp;&nbsp;Clear
							</button>
							
						</div>
					</div>
				
				<div class="row" style="padding: 1em;border-bottom: 1px solid #ccc;">
				<div class="col-md-3" style="border: 1px solid #ccc;  padding: 0.5em;">
				<input type="radio" value="Sale" id="rdotype" name="rdotype">&nbsp;Sale 	 
				<input type="radio" value="Rent" id="rdotype" name="rdotype" >&nbsp;Rent <SPAN>|</SPAN> &nbsp;&nbsp;
				<input type="checkbox" value="managed" id="chkmanaged" >&nbsp; Managed Property 
				 </div>
				 <div class="col-md-3">
							<div class="col-md-2">Area</div>
							<div class="col-md-10">
								<select id="ddlarea" style="width: 100%;"></select>
							</div>
						</div>
						<div class="col-md-2">
							<div class="col-md-2">Type</div>
							<div class="col-md-10">
								<select id="ddlunittype" style="width: 100%;"></select>
							</div>
						</div>
						<div class="col-md-3">
							<div class="col-md-3">Nearest Landmark</div>
							<div class="col-md-9">
								<select id="ddllandmark" style="width: 100%;"></select>
							</div>
						</div>
				</div>
					<div class="row" style="padding: 1em;">
						
						<div class="col-md-8">
							<input type="checkbox" value="BLD" id="chkBLD" >&nbsp;BUILDING &nbsp;&nbsp;
							<input type="checkbox" value="VIL" id="chkVIL" >&nbsp;VILLA &nbsp;&nbsp;
							<input type="checkbox" value="PTH" id="chkPTH" >&nbsp;PENT HOUSE 	&nbsp;&nbsp; 
							<input type="checkbox" value="APT" id="chkAPT" >&nbsp;APT	  &nbsp;&nbsp;
							<input type="checkbox" value="OTH" id="chkOTH" >&nbsp;OTHER  &nbsp;&nbsp;
						</div>
					</div>
				</div>
			</div>
			<div id="divlist"></div>
		</div>
	</div>
</body>
</html>