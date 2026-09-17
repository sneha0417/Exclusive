<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<% String contextPath=request.getContextPath();%>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
/* =========================================================
   SCOPED UI: Master Layout (Sidebar + Content)
========================================================= */
body, html {
    margin: 0;
    padding: 0;
    height: 100%;
    background-color: #f4f7fb;
    font-family: 'Segoe UI', Arial, sans-serif;
    overflow: hidden; /* Prevents double scrollbars */
}

/* Flexbox Container to hold Sidebar and iFrame side-by-side */
.layout-wrapper {
    display: flex;
    width: 100%;
    height: 100vh;
}

/* Left Sidebar Panel */
.sidebar {
    width: 200px; /* Fixed width for the button column */
    background-color: #f4f7fb;
    padding: 15px;
    display: flex;
    flex-direction: column; /* Stacks buttons vertically */
    gap: 10px; /* Perfect spacing between buttons */
    box-sizing: border-box;
    overflow-y: auto; /* Allows scrolling if screen is small */
}

/* Right Content Panel (iFrame Container) */
.content-area {
    flex-grow: 1; /* Fills all remaining space to the right */
    background-color: #fff;
    border-left: 1px solid #c5d3e0; /* Subtle divider line */
    box-sizing: border-box;
    height: 100%;
    position: relative;
}

.content-area iframe {
    width: 100%;
    height: 100%;
    border: none;
    display: block;
}

/* =========================================================
   NEW UI BUTTON STYLING
========================================================= */
input[type="button"].myButton {
    font-family: Tahoma, Geneva, sans-serif;
    font-weight: 600;
    font-size: 11px;
    width: 100%; /* Forces buttons to stretch to sidebar width */
    height: 38px;
    padding: 8px 10px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 2px 4px rgba(59, 130, 246, 0.2);
    text-transform: uppercase;
    letter-spacing: 0.3px;
    white-space: nowrap;
    text-align: center;
}

input[type="button"].myButton:hover {
    background: linear-gradient(135deg, #32cd32 0%, #2eb82e 100%); /* Parrot green shades */
    box-shadow: 0 4px 12px rgba(50, 205, 50, 0.3);
    transform: translateY(-1px);
}
</style>

<script type="text/javascript">
    $(document).ready(function() {
        $('#branchid').val(window.parent.branchid.value); 
    });
    
    function getConfig() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                items = items.split('####');
                
                if (items[0] == 1) {
                    $('#btncompanysetup').show();
                    $('#btnbankdetails').show();
                } else {
                    $('#btncompanysetup').hide();
                    $('#btnbankdetails').hide();
                }
                
                if(items[1] == 0){
                    $('#btnterminationsetup').hide();
                }
            } 
        }
        x.open("GET", "getConfig.jsp", true);
        x.send();
    }    
</script> 
</head>

<body onload="getConfig();">

<input type="hidden" id="formName" name="formName" value='000'/>
<input type="hidden" id="formCode" name="formCode" value='HRM'/>
<input type="hidden" id="branchid" name="branchid" value=''/>
<input type="hidden" id="mode" name="mode" />

<div class="layout-wrapper">

    <div class="sidebar">
        <input type="button" class="myButton" value="GENERAL" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/hrsetupgeneral/hrsetupgeneralmaster.jsp";'>
        <input type="button" class="myButton" value="DESIGNATION" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/designation.jsp";'>
        <input type="button" class="myButton" value="DEPARTMENT" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/department.jsp";'>
        <input type="button" class="myButton" value="PAYROLL CATEGORY" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/payrollcategory.jsp";'>
        <input type="button" class="myButton" value="DOCUMENT" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/document.jsp";'>
        <input type="button" class="myButton" value="LEAVE" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/leave.jsp";'>
        <input type="button" class="myButton" value="ALLOWANCES" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/allowances.jsp";'>
        <input type="button" class="myButton" value="STATUTORY DEDUCTIONS" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/statutorydeductions.jsp";'>
        <input type="button" class="myButton" value="AGENT" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/agent.jsp";'>
        <input type="button" class="myButton" value="LEAVE SETUP" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/leavesetup/leavesetupmaster.jsp";'>
        
        <!-- These IDs matter for your getConfig() function -->
        <input type="button" id="btncompanysetup" class="myButton" value="COMPANY SETUP" style="display:none;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/companysetup/companysetup.jsp";'>
        <input type="button" id="btnbankdetails" class="myButton" value="BANK DETAILS" style="display:none;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/bankdetails/bankdetails.jsp";'>
        <input type="button" id="btnterminationsetup" class="myButton" value="TERMINATION SETUP" style="display:none;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/terminationsetup/terminationsetupmaster.jsp";'>
    </div>

    <div class="content-area">
        <iframe id="iframe2" scrolling="yes" src="<%=contextPath%>/com/humanresource/setup/hrsetup/hrsetupgeneral/hrsetupgeneralmaster.jsp"></iframe>
    </div>

</div>

</body>
</html>