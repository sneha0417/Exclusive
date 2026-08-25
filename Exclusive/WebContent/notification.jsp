<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<%
String contextPath=request.getContextPath();
%>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
.windowHead{
background: #81BEF7;
}
.windowCont{
background: #E0ECF8;
}
</style>
<jsp:include page="includes.jsp"></jsp:include>

<script type="text/javascript">

 
function createElements() {
/*
    $('#eventWindowSuccess').jqxWindow({width: '100%', height : 230,
    	maxHeight: 150, maxWidth: 280, minHeight: 30, minWidth: 250,
        resizable: false, isModal: true, modalOpacity: 0,
        okButton: $('#ok'),
        initContent: function () {
            $('#ok').jqxButton({ theme: 'energyblue', width: '65px' });
            $('#ok').focus();
        }
    });
    
    $('#eventWindowFailure').jqxWindow({width: '100%', height : 230,
    	maxHeight: 150, maxWidth: 280, minHeight: 30, minWidth: 250,
        resizable: false, isModal: true, modalOpacity: 0,
        okButton: $('#ok'),
        initContent: function () {
            $('#ok').jqxButton({ theme: 'energyblue', width: '65px' });
            $('#ok').focus();
        }
    });
	*/
}

/* Creating Confirmation,Success/Error,Print,Excel Pop-Up windows  Ends*/
 
$(document).ready(function () {
	//addEventListeners();
    createElements();
    $("#jqxWidget").css('visibility', 'visible');
    /* $('#eventWindowSuccess').jqxWindow('close'); 
    $('#eventWindowSuccess').jqxWindow({closeAnimationDuration: 0 });
    $('#eventWindowFailure').jqxWindow('close'); 
    $('#eventWindowFailure').jqxWindow({closeAnimationDuration: 0 }); */
    $('#window').jqxWindow({width: '60%', height: '58%',  maxHeight: '70%' ,maxWidth: '60%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
    $('#window').jqxWindow('close');
    
    $('#windowattach').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Attach',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
    $('#windowattach').jqxWindow('close');
	
	$('#windowcosting').jqxWindow({width: '51%', height: '65%',  maxHeight: '75%' ,maxWidth: '51%' , title: 'Costing',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
    $('#windowcosting').jqxWindow('close');
	
	$('#windowterms').jqxWindow({width: '75%', height: '65%',  maxHeight: '70%' ,maxWidth: '80%' , title: 'Terms and Conditions',position: { x: 150, y: 87 } ,    theme:'energyblue', showCloseButton: true});
    $('#windowterms').jqxWindow('close');
    
    $('#windowapprove').jqxWindow({width: '95%', height: '88%',  maxHeight: '70%' ,maxWidth: '71%' , title: 'Approve',position: { x: 130, y: 55 } , theme: 'energyblue', showCloseButton: true});
    $('#windowapprove').jqxWindow('close');

    $('#windowGuideline').jqxWindow({width: '95%', height: '80%',  maxHeight: '80%' ,maxWidth: '95%' , title: 'Guideline',position: { x: 8, y: 8 } , theme: 'energyblue', showCloseButton: true, showCollapseButton: true});
    $('#windowGuideline').jqxWindow('close');
});

	/* Search Pop-Up window */
	function changeContent(url) {
		$.get(url).done(function (data) {
			$('#window').jqxWindow('open');
			$('#window').jqxWindow('setContent', data);
			$('#window').jqxWindow('bringToFront');
		}); 
	} 
	/* Search Pop-Up window Ends*/
 
	/* Attach Pop-Up window */
	function changeAttachContent(url) {
		$.get(url).done(function (data) {
		    $('#windowattach').jqxWindow('open');
			$('#windowattach').jqxWindow('setContent',data);
			$('#windowattach').jqxWindow('bringToFront');
	}); 
	}
	/* Attach Pop-Up window Ends*/
 
	/* Costing Pop-Up window */
	function changeCostingContent(url) {
		$.get(url).done(function (data) {
		    $('#windowcosting').jqxWindow('open');
			$('#windowcosting').jqxWindow('setContent',data);
			$('#windowcosting').jqxWindow('bringToFront');
	}); 
	}
	/* Costing Pop-Up window Ends*/

	/*function changeHelpContent(url) {
		$.get(url).done(function (data) {
		$('#windowHelp').jqxWindow('open');
		$('#windowHelp').jqxWindow('setContent', data);
		$('#windowHelp').jqxWindow('bringToFront');
		}); 
	} */ 

	function changeGuidelineContent(url) {
		$('#windowGuideline').jqxWindow('focus'); 
		$.get(url).done(function (data) {
		$('#windowGuideline').jqxWindow('setContent', data);
		}); 
	}
	
	function changeTermsContent(url) {
		$.get(url).done(function (data) {
			    $('#windowterms').jqxWindow('open');
				$('#windowterms').jqxWindow('setContent',data);
				$('#windowterms').jqxWindow('bringToFront');
		}); 
	}

	function changeApproveContent(url) {
		$.get(url).done(function (data) {
				$('#windowapprove').jqxWindow('open');
				$('#windowapprove').jqxWindow('setContent',data);
				$('#windowapprove').jqxWindow('bringToFront');
		}); 
	}

</script>
</head>
<body>
<div style="visibility: hidden;" id="jqxWidget">
    <%--        
		<div id="eventWindowSuccess" >
			<div style="background: #97C897;">Saving</div>
			<div>
				<div>
					<img width="35" height="40" src="<%=contextPath%>/icons/success.png" alt="" />
					<center><%=request.getAttribute("SAVED")%></center>
				</div>

				<div align="center" style="margin-top: 30px;">
					<input type="button" id="ok" value="OK" />
				</div>
			</div>
		</div>
		

	<div id="eventWindowFailure">
			<div style="background: #FF9999;">Error</div>
			<div>
				<div>
					<img width="35" height="40" src="<%=contextPath%>/icons/error.png" alt="" />&nbsp;&nbsp;&nbsp;
					<center><%=request.getAttribute("SAVED")%></center>
				</div>

				<div align="center" style="margin-top: 30px;">
					<input type="button" id="ok" value="Ok" style="margin-right: 10px" />
				</div>
			</div>
		</div> 
	--%>
            
<div id="window">
   <div></div><div></div>
</div> 
				
<div id="windowattach">
   <div></div>
</div>

<div id="windowcosting">
	<div></div>
</div> 

<div id="windowGuideline">
	<div></div>
</div> 

<div id="windowapprove">
	<div></div>
</div> 

<div id="windowterms">
   <div></div>
</div>

</div>
</body>
</html>