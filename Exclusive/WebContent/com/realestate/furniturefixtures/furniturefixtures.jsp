<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<%@page
	import="com.realestate.furniturefixtures.ClsFurnitureFixturesDAO"%>
<%
	String contextPath = request.getContextPath();
	ClsFurnitureFixturesDAO DAO = new ClsFurnitureFixturesDAO();
%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../includes.jsp"></jsp:include>

<script type="text/javascript">
	function funReadOnly() {
		$('#frmfurniturefixtures input').attr('readonly', true);
		$('#frmfurniturefixtures select').attr('disabled', true);		
	}
	function funRemoveReadOnly() {
		$('#frmfurniturefixtures input').attr('readonly', false);
		$('#frmfurniturefixtures select').attr('disabled', false);
		$("#jqxRoomGrid").jqxGrid({
			disabled : false
		});	
		
	}
	
	
	function funNotify() {  

		docno = $("#docno").val();
		mode = $("#mode").val();
        if($("#roomdesc").val()==""){
        	$.messager.alert('Warning', 'Please select a document');   
        	return 0;
        }
		var furrows = $("#jqxFurnitureGrid").jqxGrid('getrows');
		var furlength = 0;
		for (var i = 0; i < furrows.length; i++) {
			var chks = furrows[i].fdesc1;
			if (typeof (chks) != "undefined" && typeof (chks) != "NaN"
					&& chks != "") {
				newTextBox = $(document.createElement("input"))
				.attr("type","dil")
						.attr("id", "txtfurniture" + furlength)
						.attr("name", "txtfurniture" + furlength)
						.attr("hidden","true");
				furlength = furlength + 1;

				newTextBox.val(furrows[i].fdesc1+"::"+furrows[i].doc_no);
				newTextBox.appendTo('form');
			}
		}
		$('#furgridlength').val(furlength);

		var insrows = $("#jqxInspectionGrid").jqxGrid('getrows');
		var inslenghth = 0;
		for (var i = 0; i < insrows.length; i++) {
			var chks = insrows[i].fdesc1;
			if (typeof (chks) != "undefined" && typeof (chks) != "NaN"
					&& chks != "") {
				newTextBox = $(document.createElement("input")).attr("type", "dil")
				.attr("id", "txtinspection" + inslenghth)
				.attr("name", "txtinspection" + inslenghth)
				.attr("hidden","true");
				inslenghth = inslenghth + 1;

				newTextBox.val(insrows[i].fdesc1+"::"+insrows[i].doc_no);          
				newTextBox.appendTo('form');
			}
		}
		$('#insgridlength').val(inslenghth);

		return 1;
	}

	function funSearchLoad() {
// 		changeContent('pownerMainSearch.jsp');
	}

	function funFocus() {

	}

	function setValues() {
		$("#formdetail").val("Furniture and Fixtures");
		$("#formdetailcode").val("FRF");
		$("#formdet").html("Furniture and Fixtures(FRF)");
		window.parent.formCode.value = "FRF";
		window.parent.formName.value = "Furniture and Fixtures";

		if ($('#msg').val() != "") {
			$.messager.alert('Message', $('#msg').val());
		}

		document.getElementById("formdet").innerText = $('#formdetail').val()
				+ " (" + $('#formdetailcode').val().trim() + ")";
		//funSetlabel();

	}

	function isNumber(evt, id) {

	}
	function getBDcenter(event) {

	}
	function bdcSearchContent(url) {

	}
	function ValidateNo(event, id) {

	}

	$(document).ready(
			function() {
				$("#docno").val('');
				$("#roomdesc").val(''); 
				document.getElementById('selectedroomname').innerHTML="";
				$('#jqxRoomGrid').on( 'celldoubleclick', function(event) { 
							$("#docno").val('');
							$("#roomdesc").val('');
							document.getElementById('selectedroomname').innerHTML="";
							var args = event.args;
							// row's bound index.
							var boundIndex = event.args.rowindex;						
							var rdocno = $('#jqxRoomGrid').jqxGrid('getcellvalue', boundIndex, "doc_no");
							var roomdesc = $('#jqxRoomGrid').jqxGrid('getcellvalue', boundIndex, "rdesc1");
							//set docno to a hiddenfield
							$("#docno").val(rdocno);
							$("#roomdesc").val(roomdesc);       
							document.getElementById('selectedroomname').innerHTML=$('#jqxRoomGrid').jqxGrid('getcellvalue', boundIndex, "rdesc1");
							$("#furdiv").load(
									"furnitureGrid.jsp?rdocno=" + rdocno);
							$("#insdiv").load(
									"inspectionGrid.jsp?rdocno=" + rdocno);

							if ($('#mode').val() == 'view') {

								$("#jqxFurnitureGrid").jqxGrid({
									disabled : true
								});
							} else {
								$("#jqxFurnitureGrid").jqxGrid({
									disabled : false
								});
							}

						});
			});
</script>

<style>
.hidden-scrollbar {
	overflow: auto;
	height: 530px;
}
</style>

</head>
<body onload="setValues();">
	<div id="mainBG" class="homeContent" data-type="background">
		<form id="frmfurniturefixtures" action="saveFurnitureFixtures"
			method="post" autocomplete="off">
			<jsp:include page="../../../header.jsp"></jsp:include><br />
			<div class='hidden-scrollbar'>
				<div class="clearfix"></div>
				<div class="container-fluid">
					<!-- margin: 5px; box-shadow: 1px 2px 7px 0px #ccc; -->
					<div class="row">
							<div class="col-md-6" style="text-align:right;">Selected Room:</div>  
							<div class="col-md-6">
								<label id="selectedroomname"></label>   
							</div>
				    </div>		
					<div class="row" style="padding: 1em 0px; border: #ccc;">
						<div style="display: none;">
							<div class="col-md-4">Doc No</div>
							<div class="col-md-8">
								<input type="text" id="docno" name="docno"
									style="text-align: right" tabindex="-1"
									value='<s:property value="docno"/>' />
							</div>
						</div>
						<div class="col-md-6">
							<div class="panel panel-default" style="font-size: 1em;">
								<div class="panel-heading">List of Rooms</div>
								<div class="panel-body">
									<div id="roomDiv">
										<jsp:include page="roomGrid.jsp"></jsp:include><br />
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="panel panel-default" style="font-size: 1em;">
								<div class="panel-heading">Furniture &amp; Fixtures</div>
								<div class="panel-body">
									<div id="furnitureDiv" style="">
										<div role="tabpanel">
											<ul class="nav nav-tabs" style="background: #d9edf7;"
												role="tablist">
												<li class="active"><a data-toggle="tab" href="#insdiv">Inspection</a></li>
												<li><a data-toggle="tab" href="#furdiv">Furniture
														&amp; Fixtures</a></li>
											</ul>
											<div class="tab-content">
												<div id="insdiv" class="tab-pane fade in active"></div>
												<div id="furdiv" class="tab-pane fade in">
												</div>   
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<input type="hidden" id="mode" name="mode" /> 
				<input type="hidden" id="roomdesc" name="roomdesc" value='<s:property value="roomdesc"/>' />
				<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>' />
				<input type="hidden" id="furgridlength" name="furgridlength" /> <input
					type="hidden" id="insgridlength" name="insgridlength" /> <input
					type="hidden" id="msg" name="msg" value='<s:property value="msg"/>' />
				<input type="hidden" id="txtmobilevalidation"
					name="txtmobilevalidation"
					value='<s:property value="txtmobilevalidation"/>' /> <input
					type="hidden" id="typeallowed" name="typeallowed"
					value='<s:property value="typeallowed"/>' />
			</div>
		</form>
		<div id="nationalityWindow">
			<div></div>
		</div>
	</div>
</body>
</html>