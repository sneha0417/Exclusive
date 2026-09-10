<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
    String contextPath=request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="../../../../css/body.css">

<!-- Modern UI Styles for Header, Buttons, and Dropdown -->
<style>
    :root {
        --primary-color: #2563eb;
        --primary-hover: #1d4ed8;
        --bg-color: #f8fafc;
        --border-color: #e2e8f0;
        --text-main: #1e293b;
        --text-muted: #64748b;
        --btn-hover-bg: #eff6ff;
    }

    body {
        margin: 0;
        padding: 16px;
        background-color: var(--bg-color);
        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
    }

    /* Flexbox Header Wrapper with wrap enabled */
    .dashboard-header-wrapper {
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 16px;
        background: #ffffff;
        padding: 14px 24px;
        border-radius: 8px;
        box-shadow: 0 1px 3px rgba(0,0,0,0.05), 0 1px 2px rgba(0,0,0,0.1);
        margin-bottom: 20px;
        border: 1px solid var(--border-color);
    }

    /* Title Section */
    .page-title-section {
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .page-title-section .detail {
        font-size: 18px;
        font-weight: 600;
        color: var(--text-main);
    }

    .page-title-section .separator {
        color: var(--border-color);
        font-weight: 300;
    }

    .page-title-section .details {
        font-size: 16px;
        color: var(--text-muted);
        font-weight: 500;
    }

    /* Actions Section (Buttons & Dropdown) */
    .header-actions-section {
        display: flex;
        align-items: center;
        flex-wrap: wrap;
        gap: 16px;
    }

    .action-buttons-group {
        display: flex;
        align-items: center;
        gap: 6px;
    }

    /* Custom Button Styles */
    .nbtn {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 36px;
        height: 36px;
        background: transparent;
        border: 1px solid var(--border-color);
        border-radius: 6px;
        cursor: pointer;
        color: var(--text-muted);
        transition: all 0.2s ease-in-out;
        padding: 0;
    }

    .nbtn svg {
        width: 18px;
        height: 18px;
        fill: none;
        stroke: currentColor;
        stroke-width: 2;
        stroke-linecap: round;
        stroke-linejoin: round;
    }

    .nbtn:hover:not(:disabled) {
        background: var(--btn-hover-bg);
        color: var(--primary-color);
        border-color: #bfdbfe;
    }

    .nbtn:disabled {
        opacity: 0.4;
        cursor: not-allowed;
    }

    /* Modern Select Dropdown */
    .branch-select-container {
        display: flex;
        align-items: center;
        gap: 10px;
        padding-left: 16px;
        border-left: 1px solid var(--border-color);
    }

    .branch-label {
        font-size: 14px;
        font-weight: 500;
        color: var(--text-muted);
    }

    .modern-select {
        padding: 8px 36px 8px 12px;
        border: 1px solid var(--border-color);
        border-radius: 6px;
        font-size: 14px;
        color: var(--text-main);
        background-color: #fff;
        background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 24 24' stroke='%2364748b'%3E%3Cpath stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M19 9l-7 7-7-7'%3E%3C/path%3E%3C/svg%3E");
        background-repeat: no-repeat;
        background-position: right 10px center;
        background-size: 16px;
        appearance: none;
        outline: none;
        min-width: 160px;
        transition: border-color 0.2s, box-shadow 0.2s;
        cursor: pointer;
    }

    .modern-select:focus {
        border-color: var(--primary-color);
        box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
    }

    .modern-select:disabled {
        background-color: #f1f5f9;
        cursor: not-allowed;
    }
</style>
<script type="text/javascript">
$(document).ready(function () {
    $("body").prepend('<div id="overlay1" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait1' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
        
            <%String main2=request.getParameter("main")==null?"":request.getParameter("main");%>
            <%String name2=request.getParameter("name")==null?"":request.getParameter("name");%>
            <%String docno=request.getParameter("docno")==null?"":request.getParameter("docno");%>
            
            if($('#detailname').val()==""){
                document.getElementById("lbldetailname").innerText='<%=name2%>';
                document.getElementById("lbldetail").innerText='<%=main2.equalsIgnoreCase("0")?"Project":main2%>';
                $('#detailname').val(document.getElementById("lbldetail").innerText);
                document.getElementById("txtdetailpermissiondocno").value='<%=docno%>';
            }
            else{
                document.getElementById("lbldetailname").innerText=$('#detailname').val();
                document.getElementById("lbldetail").innerText=$('#detail').val();
                document.getElementById("txtdetailpermissiondocno").value='<%=docno%>';
            }
            
            $('#windowattach').jqxWindow({width: '51%', height: '61%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Attach',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
            $('#windowattach').jqxWindow('close');
            
            $('#windowguideline').jqxWindow({width: '78%', height: '85%',  maxHeight: '85%' ,maxWidth: '78%' , title: 'Guideline',position: { x: 280, y: 10 } , theme: 'energyblue', showCloseButton: true, showCollapseButton: true});
            $('#windowguideline').jqxWindow('close');
            
            $("input").click(function (evt) {
                this.placeholder = '' ;
            });
            
            funChkHeaderButton();
});

function funDateInPeriod(value){
    var styear = new Date(window.parent.txtaccountperiodfrom.value);
    var edyear = new Date(window.parent.txtaccountperiodto.value);
    var mclose = new Date(window.parent.monthclosed.value);
    mclose.setHours(0,0,0,0);
    edyear.setHours(0,0,0,0);
    styear.setHours(0,0,0,0);
    var currentDate = new Date(new Date());
    if(value<styear || value>edyear){
        $.messager.alert('Warning',"Transaction prior or after Account Period is not valid.");
     $('#txtvalidation').val(1);
     return 0;
    }
     if(value>currentDate){
         $.messager.alert('Warning',"Future Date, Transaction Restricted. ");
     $('#txtvalidation').val(1);
     return 0;
    } 
    if(value<=mclose){
        $.messager.alert('Warning',"Closing Done, Transaction Restricted. ");
        $('#txtvalidation').val(1);
        return 0;
    }
    var tempdtype=document.getElementById("lbldetailname").innerText;
     var taxDate=new Date(window.parent.taxdateval.value);
     taxDate.setHours(0,0,0,0);
    if(tempdtype=='Invoice Processing'){
        if(value<=taxDate){
            $.messager.alert('Warning',"Tax Closing Done, Transaction Restricted. ");
            $('#txtvalidation').val(1);
            return 0;
           }
       }
    
    
    $('#txtvalidation').val(0);
     return 1;
 }
 
function JSONToCSVCon(JSONData, ReportTitle, ShowLabel) {
    var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
    var CSV = '';    
    CSV += ReportTitle + '\r\n\n';
    if (ShowLabel) {
        var row = "";
        for (var index in arrData[0]) {
            row += index + ',';
        }
        row = row.slice(0, -1);
        CSV += row + '\r\n';
    }
    
    for (var i = 0; i < arrData.length; i++) {
        var row = "";
        for (var index in arrData[i]) {
            row += '"' + arrData[i][index] + '",';
        }
        row.slice(0, row.length - 1);
        CSV += row + '\r\n';
    }

    if (CSV == '') {        
        alert("Invalid data");
        return;
    }   
    
    var fileName = "";
    fileName += ReportTitle.replace(/ /g,"_");   
    
    var temp = CSV;
    blob = new Blob([temp],{type: 'text/csv'});
    var bigcsv= window.webkitURL.createObjectURL(blob);
   
    var link = document.createElement("a");    
      link.href = bigcsv;
    
    link.style = "visibility:hidden";
    link.download = fileName + ".csv";
    
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
}

function JSONToSIFCon(JSONData,ReportTitle, ShowLabel) {
    var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
    var SIF = '';    

    for (var i = 0; i < arrData.length; i++) {
        var row = "";
        for (var index in arrData[i]) {
            row += '' + arrData[i][index] + ',';
        }
        row.slice(0, row.length - 1);
        SIF += row.slice(0, -1) + '\r\n';
    }

    if (SIF == '') {        
        alert("Invalid data");
        return;
    }   
    
    var fileName = "";
    fileName += ReportTitle.replace(/ /g,"_");   
    
    var uri = 'data:text/csv;charset=utf-8,' + escape(SIF);
    var link = document.createElement("a");    
    link.href = uri;
    
    link.style = "visibility:hidden";
    link.download = fileName + ".sif";
    
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
}

 function funDateInPeriodNew(value){
    var styear = new Date(window.parent.txtaccountperiodfrom.value);
    var edyear = new Date(window.parent.txtaccountperiodto.value);
    var mclose = new Date(window.parent.monthclosed.value);
    mclose.setHours(0,0,0,0);
    edyear.setHours(0,0,0,0);
    styear.setHours(0,0,0,0);
    var currentDate = new Date(new Date());
    if(value<styear || value>edyear){
        $.messager.alert('Warning',"Transaction prior or after Account Period is not valid.");
     $('#txtvalidation').val(1);
     return 0;
    }
    
    if(value<=mclose){
        $.messager.alert('Warning',"Closing Done, Transaction Restricted. ");
     $('#txtvalidation').val(1);
     return 0;
    }
    
    $('#txtvalidation').val(0);
     return 1;
 }
 
 function funIBDateInPeriod(date,branch){
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                 items = items.split('***');
                 var monthCloseDate = items[0];
                 var monthClose = items[1];
                 var Date = items[2].trim();
               
               if(parseInt(monthClose)==1){
                 $.messager.alert('Message','Closing Done on '+Date+' For Inter-Branch, Transaction Restricted. ','warning');
                 $('#txtibvalidation').val(1);$('#txtibbranchid').val('');$('#txtibbranch').val('');
                
                 if (document.getElementById("txtibbranch").value == "") {
                        $('#txtibbranch').attr('placeholder', 'Press F3 to Search'); 
                  }
                 
                 return 0;
           }
               
             $('#txtibvalidation').val(0);
             return 1;
       }
    }
    x.open("GET", "<%=contextPath%>/com/dashboard/getIBMonthClose.jsp?date="+date+"&branch="+branch, true);
    x.send();
}

function funChkHeaderButton() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            items = items.split('##');
                
                var email  = items[0].split(",");
                var excel  = items[1].split(",");

                    if(parseInt(email)==0)  {
                        $("#btnSendingEmail").attr('disabled', true );
                 } else {
                         $("#btnSendingEmail").attr('disabled', false );
                    }

                    if(parseInt(excel)==0) {
                        $("#btnExcel").attr('disabled', true );
                 } else {
                     $("#btnExcel").attr('disabled', false );
                 }
                    
            
         } else {}
    }
    
    x.open("GET","<%=contextPath%>/com/dashboard/chkheaderbuttons.jsp?docno="+$('#txtdetailpermissiondocno').val().trim(),true);
    x.send();

}

    function getMessengerCount() {
        var x=new XMLHttpRequest();
        var msgcnt;
        var user;
        x.onreadystatechange=function(){
            
            if (x.readyState==4 && x.status==200)
                {
                
                    items= x.responseText;
                
                    items=items.trim().split('####');
                    user=items[0];
                    msgcnt=items[1];
        
                        if(msgcnt>0){
                            window.parent.document.getElementById("iconnm").style.display = 'none';
                            window.parent.document.getElementById("iconym").style.display = 'inline-block';
                        }
                        else{
                            window.parent.document.getElementById("iconym").style.display = 'none';
                            window.parent.document.getElementById("iconnm").style.display = 'inline-block';
        
                        }
                    
                }
            else
                {
                }
        }
        x.open("GET",<%=contextPath+"/"%>+"com/messenger/getMsgCount.jsp",true);
        x.send();
    }

    function changeDashBoardAttachContent(url) {
        $.get(url).done(function (data) {
            $('#windowattach').jqxWindow('open');
            $('#windowattach').jqxWindow('setContent',data);
            $('#windowattach').jqxWindow('bringToFront');
    }); 
    }
    
    function changeDashBoardGuidelineContent(url) {
         $('#windowguideline').jqxWindow('focus'); 
         $.get(url).done(function (data) {
         $('#windowguideline').jqxWindow('setContent', data);
    }); 
    }

function getBranch() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                items = items.split('####');
                
                var branchIdItems  = items[0].split(",");
                var branchItems = items[1].split(",");
                var perm = items[2];
                 mcloseItems=items[3].split(",");
                 taxdate=items[4].split(",");
                var optionsbranch;
                if(perm==0){
                 optionsbranch = '<option value="a" selected>All</option>';
                }
                else{
                    
                }
                for (var i = 0; i < branchItems.length; i++) {
                    optionsbranch += '<option value="' + branchIdItems[i].trim() + '">'
                            + branchItems[i] + '</option>';
                }
                $("select#cmbbranch").html(optionsbranch);
                
                window.parent.monthclosed.value=mcloseItems[0];
                window.parent.taxdateval.value=taxdate[0];
            } else {
            }
        }
        x.open("GET","<%=contextPath%>/com/dashboard/getBranch.jsp", true);
        x.send();
    }
function funRoundAmt(value,id){
    var res=parseFloat(value).toFixed(window.parent.amtdec.value);
    var res1=(res=='NaN'?"0":res);
    document.getElementById(id).value=res1;  
   }
   
 function funRoundRate(value,id){
    var res=parseFloat(value).toFixed(window.parent.curdec.value);
    var res1=(res=='NaN'?"0":res);
   document.getElementById(id).value=res1;  
 }
 
 function funGuideline() {
        
     $('#windowguideline').jqxWindow('setContent', '');
     $('#windowguideline').jqxWindow('open'); 
    
     changeDashBoardGuidelineContent("<%=contextPath%>/com/dashboard/viewDashBoardGuideline.action?formDetail="+document.getElementById("lbldetail").innerText+"&formDetailName="+document.getElementById("lbldetailname").innerText);
}

function funMclose(value){
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText.trim();
                items=items.split('####');
                if(items!='null'){
                    
                    window.parent.monthclosed.value=items[0];
                    window.parent.taxdateval.value=items[1];
                }
                else{
                    window.parent.monthclosed.value=window.parent.txtaccountperiodfrom.value;  
                }

            } else {
            }
        }
        x.open("GET","<%=contextPath%>/com/dashboard/getMclose.jsp?branch="+value, true);
        x.send();
 }
 
 function getformbranch(){
    $('#cmbbranch').attr('disabled',false);
    var branchval=document.getElementById('cmbbranch').value;
    if($('#cmbbranch').val()!=null && $('#cmbbranch').val()!='a'){
        window.parent.branchid.value=$('#cmbbranch').val();  
    }
    
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
    if (x.readyState==4 && x.status==200)
        {
            var items= x.responseText.trim();
            if(parseInt(items)==0)
            {
            $.messager.confirm('Confirm', 'Your Secure Session Has Expired ,Please Login Again.....!', function(r){
                if (r){
                    window.parent.location.href=<%=contextPath+"/"%>+"login.jsp";
                }
            });
            Exit();
            return 0;
            }
     }
    }
      x.open("GET", "<%=contextPath%>/com/dashboard/sessionset.jsp?sessionbrch="+branchval,true);
     x.send();
  
   }
 
</script>

</head>
<body onload="getformbranch();" onclick="getMessengerCount();">

    <!-- Replaced legacy <tr><td> structure with Flexbox Dashboard Header Wrapper -->
    <div class="dashboard-header-wrapper">
        
        <!-- Left Side: Title -->
        <div class="page-title-section">
            <span class="detail" name="lbldetail" id="lbldetail"></span>
            <span class="separator">-</span>
            <span class="details" name="lbldetailname" id="lbldetailname"></span>
        </div>

        <!-- Right Side: Actions & Dropdown -->
        <div class="header-actions-section">
            
            <div class="action-buttons-group">
                <!-- Guideline Button -->
                <button type="button" class="nbtn" id="btnGuideline" title="Guideline" onclick="funGuideline();">
                    <svg viewBox="0 0 24 24"><path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"></path><path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"></path></svg>
                </button>
                
                <!-- Send Email Button -->
                <button type="button" class="nbtn" id="btnSendingEmail" title="Send Email" onclick="funSendingEmail();">
                    <svg viewBox="0 0 24 24"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path><polyline points="22,6 12,13 2,6"></polyline></svg>
                </button>
                
                <!-- Export Excel Button -->
                <button type="button" class="nbtn" id="btnExcel" title="Export to Excel" onclick="funExportBtn();">
                    <svg viewBox="0 0 24 24"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline><line x1="8" y1="13" x2="16" y2="13"></line><line x1="8" y1="17" x2="16" y2="17"></line><polyline points="10 9 9 9 8 9"></polyline></svg>
                </button>
                
                <!-- Calculate Button -->
                <button type="button" class="nbtn" id="btnCalculate" title="Calculate" onclick="funCalculate();">
                    <svg viewBox="0 0 24 24"><rect x="4" y="2" width="16" height="20" rx="2" ry="2"></rect><line x1="8" y1="6" x2="16" y2="6"></line><line x1="16" y1="14" x2="16" y2="14.01"></line><line x1="16" y1="18" x2="16" y2="18.01"></line><line x1="12" y1="14" x2="12" y2="14.01"></line><line x1="12" y1="18" x2="12" y2="18.01"></line><line x1="8" y1="14" x2="8" y2="14.01"></line><line x1="8" y1="18" x2="8" y2="18.01"></line></svg>
                </button>
                
                <!-- Submit Button -->
                <button type="button" class="nbtn" id="btnSubmit" title="Submit" onclick="funreload(event)">
                    <svg viewBox="0 0 24 24"><path d="M22 2L11 13"></path><polygon points="22 2 15 22 11 13 2 9 22 2"></polygon></svg>
                </button>
            </div>

            <!-- Branch Dropdown Selection -->
            <div class="branch-select-container" id="branchdiv">
                <label class="branch-label" id="branchlabel">Branch</label>
                <select class="modern-select" id="cmbbranch" name="cmbbranch" value='<s:property value="cmbbranch"/>' onchange="funMclose(this.value);getformbranch();">
                    <option value="">--Select--</option>
                </select>
                <input type="hidden" id="hidcmbbranch" name="hidcmbbranch" value='<s:property value="hidcmbbranch"/>'/>
            </div>

        </div>
    </div>
    
    <!-- Hidden Fields & JQX Windows -->
    <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'/>
    <input type="hidden" name="detail" id="detail" value="<s:property value="detail"/>" />
    <input type="hidden" name="detailname" id="detailname" value="<s:property value="detailname"/>" />
    <input type="hidden" name="txtdetailpermissiondocno" id="txtdetailpermissiondocno" value="<s:property value="txtdetailpermissiondocno"/>" />
    
    <div id="windowattach">
        <div></div>
    </div>
    
    <div id="windowguideline">
        <div></div>
    </div>

</body>
</html>