<jsp:include page="../../../../includes.jsp"></jsp:include>
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GatewayERP(i)</title>
    <link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />

    <style type="text/css">
    /* ===== MASTER LAYOUT (Modern Flexbox) ===== */
    html, body, #mainBG {
        height: 100%;
        margin: 0;
        overflow: hidden;
        background-color: #f4f7f9;
    }

    .master-container {
        display: flex;
        width: 100%;
        height: 100vh;
        font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    }

    /* ===== LEFT SIDEBAR ===== */
    .sidebar-filters {
        width: 280px; 
        flex: 0 0 280px; 
        background: #fff;
        border-right: 1px solid #e1e8ed;
        display: flex;
        flex-direction: column;
        height: 100%;
        box-shadow: 2px 0 8px rgba(0,0,0,.05);
        z-index: 10;
    }

    .sidebar-scroll-content {
        flex: 1;
        overflow-y: auto;
        padding: 15px 15px 25px; 
    }

    /* Cards */
    .filter-card {
        background: #f8fafc;
        border: 1px solid #e3e8ee;
        border-radius: 12px;
        padding: 15px;
        margin-bottom: 12px;
    }

    /* Tables */
    .filter-table {
        width: 100%;
        border-spacing: 0 10px;
    }

    .filter-table .label-cell {
        text-align: right;
        padding-right: 10px;
        font-size: 12px;
        color: #4e5e71;
        font-weight: 600;
        width: 80px;
    }

    /* ===== UNIFORM 24px INPUTS & SELECTS ===== */
    input[type="text"], select,
    .filter-table input[type="text"],
    .filter-table select {
        width: 100%;
        height: 24px;              
        padding: 2px 8px;          
        border: 1px solid #ccd6e0;
        border-radius: 4px;        
        font-size: 12px;          
        background-color: #ffffff;
        box-sizing: border-box;
        color: #333;
        outline: none;
    }

    /* jqx date/time containers */
    div[id^="fromdate"], div[id^="todate"] {
        width: 100%;
    }

    /* ===== BUTTONS ===== */
    .btn-submit {
        width: 100%;
        height: 30px;            
        padding: 0 12px;         
        background: #2563eb;
        color: #fff;
        border: none;
        border-radius: 4px;      
        font-size: 13px;
        font-weight: 600;
        cursor: pointer;
        line-height: 30px;       
        text-align: center;
        transition: background 0.2s;
    }

    .btn-submit:hover { background: #1d4ed8; }

    .action-buttons {
        display: flex;
        gap: 10px;
        margin-top: 15px;
    }

    /* ===== RIGHT CONTENT AREA ===== */
    .main-content-area {
        flex: 1; 
        display: flex;
        flex-direction: column;
        background: #ffffff;
        height: 100%;
        overflow: hidden;
    }

    .top-toolbar-container {
        width: 100%;
        padding: 10px 15px;
        background: #ffffff;
        border-bottom: 1px solid #e1e8ed;
        box-sizing: border-box;
    }

    .grid-content-container {
        flex: 1;
        padding: 15px;
        overflow: auto; 
        box-sizing: border-box;
    }

    /* Fix for jqx widget overrides */
    .jqx-widget input, .jqx-widget select {
        height: 24px !important;
        line-height: 24px !important;
    }
    </style>

    <script type="text/javascript">
        $(document).ready(function() {
            $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
            $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
            
            // Updated to 100% width and 24px height
            $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
            $("#todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
            
            var fromdates = new Date($('#fromdate').jqxDateTimeInput('getDate'));
            var onemonth = new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
            $('#fromdate').jqxDateTimeInput('setDate', new Date(onemonth));
            
            $('#todate').on('change', function (event) {
                var fromdates = new Date($('#fromdate').jqxDateTimeInput('getDate'));
                var todates = new Date($('#todate').jqxDateTimeInput('getDate'));
                if(fromdates > todates){
                    $.messager.alert('Message','To Date Less Than From Date  ','warning');   
                    return false;
                }   
            }); 
        });

        function funExportBtn() {
            $("#detaildiv").excelexportjs({
                containerid: "detaildiv",
                datatype: 'json',
                dataset: null,
                gridId: "detailGrid",
                columns: getColumns("detailGrid"),
                worksheetName: "Managed Property Income / Expense"
            });
        }

        function funreload(event) {
            var fromdate = $('#fromdate').jqxDateTimeInput('val');
            var todate = $('#todate').jqxDateTimeInput('val');
            var branch = $('#cmbbranch').val();
            
            $("#overlay, #PleaseWait").show();
            $("#detaildiv").load("detailGrid.jsp?fromdate="+fromdate+"&branch="+branch+"&todate="+todate+"&id=1");
        }

        function funcleardata() {
            $('#postdate,#todate').jqxDateTimeInput('setDate',new Date());
            $('#contractGrid,#jqxPaymentGrid,#jvGrid').jqxGrid('clear');
            funreload("");
        }
    </script>
</head>

<body onload="getBranch();">
    <div id="mainBG">
        <div class="master-container">

            <!-- LEFT SIDEBAR -->
            <div class="sidebar-filters">
                <div class="sidebar-scroll-content">

                    <!-- Dates Filter Card -->
                    <div class="filter-card">
                        <table class="filter-table">
                            <tr>
                                <td class="label-cell">From Date</td>
                                <td><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div></td>
                            </tr>
                            <tr>
                                <td class="label-cell">To Date</td>
                                <td><div id='todate' name='todate' value='<s:property value="todate"/>'></div></td>
                            </tr>
                        </table>
                    </div>

                    <!-- Actions -->
                    <div class="action-buttons">
                        <input type="button" class="btn-submit" name="clear" id="clear" value="Clear" onclick="funcleardata();">
                    </div>

                    <!-- Additional Layout Container (Retained from original) -->
                    <div id='paychaaaaa' style="width: 100%; height: 86px; margin-top: 15px;"></div>

                    <!-- Hidden Inputs -->
                    <div style="display:none;">
                        <input type="hidden" id="docno" name="docno" value='<s:property value="docno"/>'>
                    </div>

                </div>
            </div>

            <!-- MAIN CONTENT AREA -->
            <div class="main-content-area">
                
                <div class="top-toolbar-container">
                    <jsp:include page="../../heading.jsp"></jsp:include>
                </div>

                <div class="grid-content-container">
                    <div id="detaildiv">
                        <jsp:include page="detailGrid.jsp"></jsp:include>
                    </div>
                </div>

            </div>
        </div>
    </div>
</body>

</html>