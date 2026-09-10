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

.filter-card-title {
    font-size: 13px;
    font-weight: 600;
    color: #334155;
    margin-bottom: 12px;
    border-bottom: 1px solid #e1e8ed;
    padding-bottom: 6px;
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

/* Readonly / disabled look */
input[readonly], input:disabled, select:disabled,
.filter-table input[readonly], .filter-table input:disabled, .filter-table select:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    border-color: #e1e8ed;
    cursor: not-allowed;
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

.btn-primary {
    background: #10b981; /* Green color for positive action like Update/Credit */
}
.btn-primary:hover { background: #059669; }

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
    $(document).ready(function () {
        $('#employeeDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Employee Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
        $('#employeeDetailsWindow').jqxWindow('close');
        
        $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
        $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
        
        $('#txtemployeeid').attr('readonly', true);
        $('#txtemployeename').attr('readonly', true);
        $('#cmbleavetype').attr('disabled', true);
            
        $('#txtemployeeid').dblclick(function(){
            employeeSearchContent("employeeDetailsSearch.jsp");
        });
    });
    
    function employeeSearchContent(url) {
        $('#employeeDetailsWindow').jqxWindow('open');
        $.get(url).done(function (data) {
            $('#employeeDetailsWindow').jqxWindow('setContent', data);
            $('#employeeDetailsWindow').jqxWindow('bringToFront');
        }); 
    }

    function getDepartment() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                items = items.split('####');
                var departmentItems = items[0].split(",");
                var departmentIdItems = items[1].split(",");
                var optionsdepartment = '<option value="">--Select--</option>';
                for (var i = 0; i < departmentItems.length; i++) {
                    optionsdepartment += '<option value="' + departmentIdItems[i] + '">' + departmentItems[i] + '</option>';
                }
                $("select#cmbempdepartment").html(optionsdepartment);
            }
        }
        x.open("GET", "getDepartment.jsp", true);
        x.send();
    }

    function getYear() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                items = items.split('####');
                var yearItems = items[0].split(",");
                var yearIdItems = items[1].split(",");
                var optionsyear = '<option value="">--Select--</option>';
                for (var i = 0; i < yearItems.length; i++) {
                    optionsyear += '<option value="' + yearIdItems[i] + '">' + yearItems[i] + '</option>';
                }
                $("select#cmbyear").html(optionsyear);
            }
        }
        x.open("GET", "getYear.jsp", true);
        x.send();
    }
    
    function getPayrollCategory() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                items = items.split('####');
                var payrollcategoryItems = items[0].split(",");
                var payrollcategoryIdItems = items[1].split(",");
                var optionspayrollcategory = '<option value="">--Select--</option>';
                for (var i = 0; i < payrollcategoryItems.length; i++) {
                    optionspayrollcategory += '<option value="' + payrollcategoryIdItems[i] + '">' + payrollcategoryItems[i] + '</option>';
                }
                $("select#cmbempcategory").html(optionspayrollcategory);
            }
        }
        x.open("GET", "getPayrollCategory.jsp", true);
        x.send();
    }
    
    function getLeaveType() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                items = items.split('####');
                var leavetypeItems = items[0].split(",");
                var leavetypeIdItems = items[1].split(",");
                var optionsleavetype = '<option value="">--Select--</option>';
                for (var i = 0; i < leavetypeItems.length; i++) {
                    optionsleavetype += '<option value="' + leavetypeIdItems[i] + '">' + leavetypeItems[i] + '</option>';
                }
                $("select#cmbleavetype").html(optionsleavetype);
            }
        }
        x.open("GET", "getLeaveType.jsp", true);
        x.send();
    }

    function getLType() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                items = items.split('####');
                var leavetypeItems = items[0].split(",");
                var leavetypeIdItems = items[1].split(",");
                var optionsleavetype = '<option value="">--Select--</option>';
                for (var i = 0; i < leavetypeItems.length; i++) {
                    optionsleavetype += '<option value="' + leavetypeIdItems[i] + '">' + leavetypeItems[i] + '</option>';
                }
                $("select#cmbltype").html(optionsleavetype);
            }
        }
        x.open("GET", "getLeaveType.jsp", true);
        x.send();
    }

    function getEmployeeId(event){
        var x = event.keyCode;
        if(x == 114){
            employeeSearchContent("employeeDetailsSearch.jsp");
        }
    }
    
    function funleavestype() {
        var leavetype = $('#cmbleavetype').children("option").length;
        for(var k=1; k <= leavetype; k++){
            $('#txtleavename'+k).val($('#cmbleavetype option').eq(k).text().trim());
        } 
    }
    
    function funClearInfo(){
        $('#cmbbranch').val('a');
        $('#cmbyear').val('');
        $('#cmbempdepartment').val('');
        $('#cmbempcategory').val('');
        $('#txtemployeeid').val('');
        $('#txtemployeedocno').val('');
        $('#txtemployeename').val('');
        $("#leaveDetailsGridID").jqxGrid('clear');
        $("#leaveDetailsGridID").jqxGrid('addrow', null, {});
        $('#cmbltype').val('');
        $('#hidempdocno').val('');
        $('#txtdays').val('');
        document.getElementById("hidlabel").innerHTML="";        
    }
    
    function funClearYearInfo(){
        $('#cmbempdepartment').val('');
        $('#cmbempcategory').val('');
        $('#txtemployeeid').val('');
        $('#txtemployeedocno').val('');
        $('#txtemployeename').val('');
        $("#leaveDetailsGridID").jqxGrid('clear');
        $("#leaveDetailsGridID").jqxGrid('addrow', null, {});
    }
    
    function funExportBtn(){
        $("#leaveDetailsDiv").excelexportjs({
            containerid: "leaveDetailsDiv", 
            datatype: 'json', 
            dataset: null, 
            gridId: "leaveDetailsGridID", 
            columns: getColumns("leaveDetailsGridID"),     
            worksheetName:"Leave Details"
        });
    }
    
    function funreload(event){  
        var year = $('#cmbyear').val();
        var department = $('#cmbempdepartment').val();
        var category = $('#cmbempcategory').val();
        var empId = $('#txtemployeedocno').val();
        
        funleavestype(); 
        $("#overlay, #PleaseWait").show();
        $("#leaveDetailsDiv").load("leaveDetailsGrid.jsp?year="+year+"&department="+department+"&category="+category+"&empId="+empId+"&check=1");
    }
    
    function funUpdate(){     
        var leaveid = $("#cmbltype").val();  
        var days = $("#txtdays").val();  
        var empdocno = $("#hidempdocno").val();
        
        if(empdocno == ""){        
            $("#overlay, #PleaseWait").hide();
            $.messager.alert('Warning','Please select a document!!!');   
            return false;
        }
        if(days == ""){        
            $("#overlay, #PleaseWait").hide();
            $.messager.alert('Warning','Please enter no of days!!!');   
            return false;
        }
        if(leaveid == ""){        
            $("#overlay, #PleaseWait").hide();
            $.messager.alert('Warning','Please select leave type!!!');      
            return false;
        }
        
        $.messager.confirm('Confirm', 'Do you want to save changes ?', function(r){   
            if (r){
                $("#overlay, #PleaseWait").show();  
                saveGridData(leaveid, empdocno, days);      
            }
        });  
    }

    function saveGridData(leaveid, empdocno, days){                    
        var x = new XMLHttpRequest();
        x.onreadystatechange = function(){
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                if(parseInt(items) > 0){
                    $('#cmbbranch').val('a');
                    $('#cmbltype').val('');
                    $('#hidempdocno').val('');
                    $('#txtdays').val('');     
                    $.messager.alert('Message', '  Successfully Updated ', function(r){});
                    funreload(event);
                } else {
                    $.messager.alert('Message', '  Not Updated ', function(r){});
                    $("#overlay, #PleaseWait").hide();
                } 
            }
        }
        x.open("GET","saveData.jsp?leaveid="+leaveid+"&empdocno="+empdocno+"&days="+days, true);          
        x.send();
    }   

    function isNumberKey(evt){
        var charCode = (evt.which) ? evt.which : event.keyCode
        if (charCode > 31 && ((charCode < 48) || (charCode > 57)))          
            return false;
        return true;
    }
</script>
</head>

<body onload="getBranch();getYear();getDepartment();getPayrollCategory();getLeaveType();getLType();">                  
<div id="mainBG">
    <div class="master-container">

        <!-- LEFT SIDEBAR -->
        <div class="sidebar-filters">
            <div class="sidebar-scroll-content">

                <!-- Primary Filters Card -->
                <div class="filter-card">
                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">Year</td>
                            <td>
                                <select name="cmbyear" id="cmbyear" onchange="funClearYearInfo();" value='<s:property value="cmbyear"/>'></select>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Department</td>
                            <td>
                                <select id="cmbempdepartment" name="cmbempdepartment" value='<s:property value="cmbempdepartment"/>'>
                                    <option value="">--Select--</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Category</td>
                            <td>
                                <select id="cmbempcategory" name="cmbempcategory" value='<s:property value="cmbempcategory"/>'>
                                    <option value="">--Select--</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Leaves</td>
                            <td>
                                <select id="cmbleavetype" name="cmbleavetype" value='<s:property value="cmbleavetype"/>' disabled>   
                                    <option value="">--Select--</option>
                                </select>
                            </td>
                        </tr>
                    </table>
                    
                    <table class="filter-table" style="margin-top: 10px;">
                        <tr>
                            <td class="label-cell">Employee</td>
                            <td>
                                <input type="text" id="txtemployeeid" name="txtemployeeid" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtemployeeid"/>' onkeydown="getEmployeeId(event);"/>
                                <input type="hidden" id="txtemployeedocno" name="txtemployeedocno" value='<s:property value="txtemployeedocno"/>'/>
                                <input type="hidden" id="hidempdocno" name="hidempdocno" value='<s:property value="hidempdocno"/>'/>
                            </td>
                        </tr> 
                        <tr>
                            <td class="label-cell"></td>
                            <td>
                                <input type="text" id="txtemployeename" name="txtemployeename" readonly="readonly" placeholder="Employee Name" tabindex="-1" value='<s:property value="txtemployeename"/>'/>
                            </td>
                        </tr>
                    </table>
                </div>

                <!-- Credit Leaves Action Card -->
                <div class="filter-card">
                    <div class="filter-card-title">Credit Leaves</div>
                    
                    <!-- Dynamic Label holder -->
                    <div id="hidlabel" style="text-align: center; font-weight: 600; color: #2563eb; margin-bottom: 10px; font-size: 12px;"></div>
                    
                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">Leave Type</td>
                            <td>
                                <select id="cmbltype" name="cmbltype" value='<s:property value="cmbltype"/>'>
                                    <option value="">--Select--</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Days</td>
                            <td>
                                <input type="text" id="txtdays" name="txtdays" onkeypress="return isNumberKey(event)" value='<s:property value="txtdays"/>'/>
                            </td>
                        </tr> 
                    </table>
                    
                    <div style="margin-top: 15px;">
                        <input type="button" class="btn-submit btn-primary" name="update" id="update" value="Update" onclick="funUpdate();">
                    </div>
                </div>

                <!-- General Actions -->
                <div class="action-buttons">
                    <input type="button" class="btn-submit" name="clear" id="clear" value="Clear" onclick="funClearInfo();">
                </div>

                <!-- Hidden Inputs for Leave Types -->
                <div style="display:none;">
                    <input type="hidden" id="txtleavename1" name="txtleavename1" value='<s:property value="txtleavename1"/>'/>
                    <input type="hidden" id="txtleavename2" name="txtleavename2" value='<s:property value="txtleavename2"/>'/>
                    <input type="hidden" id="txtleavename3" name="txtleavename3" value='<s:property value="txtleavename3"/>'/>
                    <input type="hidden" id="txtleavename4" name="txtleavename4" value='<s:property value="txtleavename4"/>'/>
                    <input type="hidden" id="txtleavename5" name="txtleavename5" value='<s:property value="txtleavename5"/>'/>
                    <input type="hidden" id="txtleavename6" name="txtleavename6" value='<s:property value="txtleavename6"/>'/>
                    <input type="hidden" id="txtleavename7" name="txtleavename7" value='<s:property value="txtleavename7"/>'/>
                    <input type="hidden" id="txtleavename8" name="txtleavename8" value='<s:property value="txtleavename8"/>'/>
                    <input type="hidden" id="txtleavename9" name="txtleavename9" value='<s:property value="txtleavename9"/>'/>
                    <input type="hidden" id="txtleavename10" name="txtleavename10" value='<s:property value="txtleavename10"/>'/>
                </div>

            </div>
        </div>

        <!-- MAIN CONTENT AREA -->
        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                <div id="leaveDetailsDiv">
                    <jsp:include page="leaveDetailsGrid.jsp"></jsp:include>
                </div>
            </div>

        </div>
    </div>
</div>      

<!-- JQX Windows -->
<div id="employeeDetailsWindow">
    <div></div><div></div>
</div>

</body>
</html>