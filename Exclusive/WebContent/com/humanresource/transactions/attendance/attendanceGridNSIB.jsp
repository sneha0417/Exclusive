<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.humanresource.transactions.attendance.ClsAttendanceDAO"%>
<%ClsAttendanceDAO DAO= new ClsAttendanceDAO(); %> 
<% String mode = request.getParameter("mode")==null?"view":request.getParameter("mode");
   String docNo = request.getParameter("docno")==null?"0":request.getParameter("docno");
   String totDays = request.getParameter("totdays")==null?"0":request.getParameter("totdays");
   String year = request.getParameter("year")==null?"2016":request.getParameter("year");
   String month = request.getParameter("month")==null?"01":request.getParameter("month");
   String day = request.getParameter("day")==null || request.getParameter("day")=="" ?"01":request.getParameter("day");
   String department = request.getParameter("department")==null?"0":request.getParameter("department");
   String category = request.getParameter("category")==null?"0":request.getParameter("category");
   String empId = request.getParameter("empid")==null?"0":request.getParameter("empid");
   String check = request.getParameter("check")==null?"0":request.getParameter("check"); %> 
<style type="text/css">
        .redClass
        {
            background-color: #FFEBEB;
        }
        .yellowClass
        {
            background-color: #FFFFD1;
        }
        .whiteClass
        {
           background-color: #fff;
        }
         .greenClass
        {
           background-color: #BEFF33;
        }
</style>
<script type="text/javascript">
		var temp='<%=check%>';
		var tempDays='<%=totDays%>';
		var tempDocNo='<%=docNo%>';
		
		var data;
		var dataExcelExport;
        $(document).ready(function () { 	
        	
        	if(temp=='1')
        	 { 
        		
        		data='<%=DAO.attendanceGridLoading(session,totDays,year,month,day,department,category,empId)%>';
        		dataExcelExport='<%=DAO.attendanceGridLoadingExcelExport(session,totDays,year,month,day,department,category,empId)%>';
        		
        	 }
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'employeeid', type: 'string' },
     						{name : 'employeename', type: 'string' },
     						{name : 'date1', type: 'string' },
     						{name : 'date2', type: 'string' },
     						{name : 'date3', type: 'string' },
     						{name : 'date4', type: 'string' },
     						{name : 'date5', type: 'string' },
     						{name : 'date6', type: 'string' },
     						{name : 'date7', type: 'string' },
     						{name : 'date8', type: 'string' },
     						{name : 'date9', type: 'string' },
     						{name : 'date10', type: 'string' },
     						{name : 'date11', type: 'string' },
     						{name : 'date12', type: 'string' },
     						{name : 'date13', type: 'string' },
     						{name : 'date14', type: 'string' },
     						{name : 'date15', type: 'string' },
     						{name : 'date16', type: 'string' },
     						{name : 'date17', type: 'string' },
     						{name : 'date18', type: 'string' },
     						{name : 'date19', type: 'string' },
     						{name : 'date20', type: 'string' },
     						{name : 'date21', type: 'string' },
     						{name : 'date22', type: 'string' },
     						{name : 'date23', type: 'string' },
     						{name : 'date24', type: 'string' },
     						{name : 'date25', type: 'string' },
     						{name : 'date26', type: 'string' },
     						{name : 'date27', type: 'string' },
     						{name : 'date28', type: 'string' },
     						{name : 'date29', type: 'string' },
     						{name : 'date30', type: 'string' },
     						{name : 'date31', type: 'string' },
     						{name : 'days', type: 'int' },
     						{name : 'holiday', type: 'number' },
     						{name : 'leave', type: 'number' },
     						{name : 'leave1total', type: 'number' },
     						{name : 'leave2total', type: 'number' },
     						{name : 'leave3total', type: 'number' },
     						{name : 'leave4total', type: 'number' },
     						{name : 'leave5total', type: 'number' },
     						{name : 'leave6total', type: 'number' },
     						{name : 'totalovertime', type: 'string' },
     						{name : 'totalholidayovertime', type: 'string' },
     						{name : 'totalovertimes', type: 'string' },
     						{name : 'totalholidayovertimes', type: 'string' },
     						{name : 'employeedocno', type: 'int' },
     						{name : 'payroll_processed', type: 'int' }
                        ],
                		 localdata: data, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var cellclassname = function (row, column, value, data) {
            	if (data.date1 == 'P') {
                    return "yellowClass";
                } else if (data.date1 == 'H') {
                    return "redClass";
                } else if (data.date1 == 'A') {
                    return "redClass";
                } else if (data.date1 == 'S') {
                    return "redClass";
                } else if (data.date1 == 'C') {
                    return "redClass";
                } else if (data.date1 == 'T') {
                    return "redClass";
                } else if (data.date1 == 'M') {
                    return "redClass";
                } else if (data.date1 == 'U') {
                    return "redClass";
                } else if (data.date1 == 'A2') {
                    return "redClass";
                } else if (data.date1 == 'S2') {
                    return "redClass";
                } else if (data.date1 == 'C2') {
                    return "redClass";
                } else if (data.date1 == 'T2') {
                    return "redClass";
                } else if (data.date1 == 'M2') {
                    return "redClass";
                } else if (data.date1 == 'U2') {
                    return "redClass";
                } else if (data.date1 == 'LH') {
                    return "redClass";
                } else if (data.date1 == 'NA') {
                    return "whiteClass";
                } else if (data.date1 != null && data.date1 != 'P' && data.date1 != 'H' && data.date1 != 'A' && data.date1 != 'S' && data.date1 != 'C' && data.date1 != 'T' && data.date1 != 'M' && data.date1 != 'U' && data.date1 != 'A2' && data.date1 != 'S2' && data.date1 != 'C2' && data.date1 != 'T2' && data.date1 != 'M2' && data.date1 != 'U2' && data.date1 != 'LH') {
                    return "greenClass";
                } else {
                	return "whiteClass";
                };
            };
            
            var cellclassname1 = function (row, column, value, data) {
            	if (data.date2 == 'P') {
                    return "yellowClass";
                } else if (data.date2 == 'H') {
                    return "redClass";
                } else if (data.date2 == 'A') {
                    return "redClass";
                } else if (data.date2 == 'S') {
                    return "redClass";
                } else if (data.date2 == 'C') {
                    return "redClass";
                } else if (data.date2 == 'T') {
                    return "redClass";
                } else if (data.date2 == 'M') {
                    return "redClass";
                } else if (data.date2 == 'U') {
                    return "redClass";
                } else if (data.date2 == 'A2') {
                    return "redClass";
                } else if (data.date2 == 'S2') {
                    return "redClass";
                } else if (data.date2 == 'C2') {
                    return "redClass";
                } else if (data.date2 == 'T2') {
                    return "redClass";
                } else if (data.date2 == 'M2') {
                    return "redClass";
                } else if (data.date2 == 'U2') {
                    return "redClass";
                } else if (data.date2 == 'LH') {
                    return "redClass";
                } else if (data.date2 == 'NA') {
                    return "whiteClass";
                } else if (data.date2 != null && data.date2 != 'P' && data.date2 != 'H' && data.date2 != 'A' && data.date2 != 'S' && data.date2 != 'C' && data.date2 != 'T' && data.date2 != 'M' && data.date2 != 'U' && data.date2 != 'A2' && data.date2 != 'S2' && data.date2 != 'C2' && data.date2 != 'T2' && data.date2 != 'M2' && data.date2 != 'U2' && data.date2 != 'LH') {
                    return "greenClass";
                } else{
                	return "whiteClass";
                };
            };
            
            var cellclassname2 = function (row, column, value, data) {
            	if (data.date3 == 'P') {
                    return "yellowClass";
                } else if (data.date3 == 'H') {
                    return "redClass";
                } else if (data.date3 == 'A') {
                    return "redClass";
                } else if (data.date3 == 'S') {
                    return "redClass";
                } else if (data.date3 == 'C') {
                    return "redClass";
                } else if (data.date3 == 'T') {
                    return "redClass";
                } else if (data.date3 == 'M') {
                    return "redClass";
                } else if (data.date3 == 'U') {
                    return "redClass";
                } else if (data.date3 == 'A2') {
                    return "redClass";
                } else if (data.date3 == 'S2') {
                    return "redClass";
                } else if (data.date3 == 'C2') {
                    return "redClass";
                } else if (data.date3 == 'T2') {
                    return "redClass";
                } else if (data.date3 == 'M2') {
                    return "redClass";
                } else if (data.date3 == 'U2') {
                    return "redClass";
                } else if (data.date3 == 'LH') {
                    return "redClass";
                } else if (data.date3 == 'NA') {
                    return "whiteClass";
                } else if (data.date3 != null && data.date3 != 'P' && data.date3 != 'H' && data.date3 != 'A' && data.date3 != 'S' && data.date3 != 'C' && data.date3 != 'T' && data.date3 != 'M' && data.date3 != 'U' && data.date3 != 'A2' && data.date3 != 'S2' && data.date3 != 'C2' && data.date3 != 'T2' && data.date3 != 'M2' && data.date3 != 'U2' && data.date3 != 'LH') {
                    return "greenClass";
                } else{
                	return "whiteClass";
                };
            };
            
            var cellclassname3 = function (row, column, value, data) {
            	if (data.date4 == 'P') {
                    return "yellowClass";
                } else if (data.date4 == 'H') {
                    return "redClass";
                } else if (data.date4 == 'A') {
                    return "redClass";
                } else if (data.date4 == 'S') {
                    return "redClass";
                } else if (data.date4 == 'C') {
                    return "redClass";
                } else if (data.date4 == 'T') {
                    return "redClass";
                } else if (data.date4 == 'M') {
                    return "redClass";
                } else if (data.date4 == 'U') {
                    return "redClass";
                } else if (data.date4 == 'A2') {
                    return "redClass";
                } else if (data.date4 == 'S2') {
                    return "redClass";
                } else if (data.date4 == 'C2') {
                    return "redClass";
                } else if (data.date4 == 'T2') {
                    return "redClass";
                } else if (data.date4 == 'M2') {
                    return "redClass";
                } else if (data.date4 == 'U2') {
                    return "redClass";
                } else if (data.date4 == 'LH') {
                    return "redClass";
                } else if (data.date4 == 'NA') {
                    return "whiteClass";
                } else if (data.date4 != null && data.date4 != 'P' && data.date4 != 'H' && data.date4 != 'A' && data.date4 != 'S' && data.date4 != 'C' && data.date4 != 'T' && data.date4 != 'M' && data.date4 != 'U' && data.date4 != 'A2' && data.date4 != 'S2' && data.date4 != 'C2' && data.date4 != 'T2' && data.date4 != 'M2' && data.date4 != 'U2' && data.date4 != 'LH') {
                    return "greenClass";
                } else{
                	return "whiteClass";
                };
            };
            
            var cellclassname4 = function (row, column, value, data) {
            	if (data.date5 == 'P') {
                    return "yellowClass";
                } else if (data.date5 == 'H') {
                    return "redClass";
                } else if (data.date5 == 'A') {
                    return "redClass";
                } else if (data.date5 == 'S') {
                    return "redClass";
                } else if (data.date5 == 'C') {
                    return "redClass";
                } else if (data.date5 == 'T') {
                    return "redClass";
                } else if (data.date5 == 'M') {
                    return "redClass";
                } else if (data.date5 == 'U') {
                    return "redClass";
                } else if (data.date5 == 'A2') {
                    return "redClass";
                } else if (data.date5 == 'S2') {
                    return "redClass";
                } else if (data.date5 == 'C2') {
                    return "redClass";
                } else if (data.date5 == 'T2') {
                    return "redClass";
                } else if (data.date5 == 'M2') {
                    return "redClass";
                } else if (data.date5 == 'U2') {
                    return "redClass";
                } else if (data.date5 == 'LH') {
                    return "redClass";
                } else if (data.date5 == 'NA') {
                    return "whiteClass";
                } else if (data.date5 != null && data.date5 != 'P' && data.date5 != 'H' && data.date5 != 'A' && data.date5 != 'S' && data.date5 != 'C' && data.date5 != 'T' && data.date5 != 'M' && data.date5 != 'U' && data.date5 != 'A2' && data.date5 != 'S2' && data.date5 != 'C2' && data.date5 != 'T2' && data.date5 != 'M2' && data.date5 != 'U2' && data.date5 != 'LH') {
                    return "greenClass";
                } else{
                	return "whiteClass";
                };
            };
            
            var cellclassname5 = function (row, column, value, data) {
            	if (data.date6 == 'P') {
                    return "yellowClass";
                } else if (data.date6 == 'H') {
                    return "redClass";
                } else if (data.date6 == 'A') {
                    return "redClass";
                } else if (data.date6 == 'S') {
                    return "redClass";
                } else if (data.date6 == 'C') {
                    return "redClass";
                } else if (data.date6 == 'T') {
                    return "redClass";
                } else if (data.date6 == 'M') {
                    return "redClass";
                } else if (data.date6 == 'U') {
                    return "redClass";
                } else if (data.date6 == 'A2') {
                    return "redClass";
                } else if (data.date6 == 'S2') {
                    return "redClass";
                } else if (data.date6 == 'C2') {
                    return "redClass";
                } else if (data.date6 == 'T2') {
                    return "redClass";
                } else if (data.date6 == 'M2') {
                    return "redClass";
                } else if (data.date6 == 'U2') {
                    return "redClass";
                } else if (data.date6 == 'LH') {
                    return "redClass";
                } else if (data.date6 == 'NA') {
                    return "whiteClass";
                } else if (data.date6 != null && data.date6 != 'P' && data.date6 != 'H' && data.date6 != 'A' && data.date6 != 'S' && data.date6 != 'C' && data.date6 != 'T' && data.date6 != 'M' && data.date6 != 'U' && data.date6 != 'A2' && data.date6 != 'S2' && data.date6 != 'C2' && data.date6 != 'T2' && data.date6 != 'M2' && data.date6 != 'U2' && data.date6 != 'LH') {
                    return "greenClass";
                } else{
                	return "whiteClass";
                };
            };
            
            var cellclassname6 = function (row, column, value, data) {
            	if (data.date7 == 'P') {
                    return "yellowClass";
                } else if (data.date7 == 'H') {
                    return "redClass";
                } else if (data.date7 == 'A') {
                    return "redClass";
                } else if (data.date7 == 'S') {
                    return "redClass";
                } else if (data.date7 == 'C') {
                    return "redClass";
                } else if (data.date7 == 'T') {
                    return "redClass";
                } else if (data.date7 == 'M') {
                    return "redClass";
                } else if (data.date7 == 'U') {
                    return "redClass";
                } else if (data.date7 == 'A2') {
                    return "redClass";
                } else if (data.date7 == 'S2') {
                    return "redClass";
                } else if (data.date7 == 'C2') {
                    return "redClass";
                } else if (data.date7 == 'T2') {
                    return "redClass";
                } else if (data.date7 == 'M2') {
                    return "redClass";
                } else if (data.date7 == 'U2') {
                    return "redClass";
                } else if (data.date7 == 'LH') {
                    return "redClass";
                } else if (data.date7 == 'NA') {
                    return "whiteClass";
                } else if (data.date7 != null && data.date7 != 'P' && data.date7 != 'H' && data.date7 != 'A' && data.date7 != 'S' && data.date7 != 'C' && data.date7 != 'T' && data.date7 != 'M' && data.date7 != 'U' && data.date7 != 'A2' && data.date7 != 'S2' && data.date7 != 'C2' && data.date7 != 'T2' && data.date7 != 'M2' && data.date7 != 'U2' && data.date7 != 'LH') {
                    return "greenClass";
                } else{
                	return "whiteClass";
                };
            };
            
            var cellclassname7 = function (row, column, value, data) {
            	if (data.date8 == 'P') {
                    return "yellowClass";
                } else if (data.date8 == 'H') {
                    return "redClass";
                } else if (data.date8 == 'A') {
                    return "redClass";
                } else if (data.date8 == 'S') {
                    return "redClass";
                } else if (data.date8 == 'C') {
                    return "redClass";
                } else if (data.date8 == 'T') {
                    return "redClass";
                } else if (data.date8 == 'M') {
                    return "redClass";
                } else if (data.date8 == 'U') {
                    return "redClass";
                } else if (data.date8 == 'A2') {
                    return "redClass";
                } else if (data.date8 == 'S2') {
                    return "redClass";
                } else if (data.date8 == 'C2') {
                    return "redClass";
                } else if (data.date8 == 'T2') {
                    return "redClass";
                } else if (data.date8 == 'M2') {
                    return "redClass";
                } else if (data.date8 == 'U2') {
                    return "redClass";
                } else if (data.date8 == 'LH') {
                    return "redClass";
                } else if (data.date8 == 'NA') {
                    return "whiteClass";
                } else if (data.date8 != null && data.date8 != 'P' && data.date8 != 'H' && data.date8 != 'A' && data.date8 != 'S' && data.date8 != 'C' && data.date8 != 'T' && data.date8 != 'M' && data.date8 != 'U' && data.date8 != 'A2' && data.date8 != 'S2' && data.date8 != 'C2' && data.date8 != 'T2' && data.date8 != 'M2' && data.date8 != 'U2' && data.date8 != 'LH') {
                    return "greenClass";
                } else{
                	return "whiteClass";
                };
            };
            
            var cellclassname8 = function (row, column, value, data) {
            	if (data.date9 == 'P') {
                    return "yellowClass";
                } else if (data.date9 == 'H') {
                    return "redClass";
                } else if (data.date9 == 'A') {
                    return "redClass";
                } else if (data.date9 == 'S') {
                    return "redClass";
                } else if (data.date9 == 'C') {
                    return "redClass";
                } else if (data.date9 == 'T') {
                    return "redClass";
                } else if (data.date9 == 'M') {
                    return "redClass";
                } else if (data.date9 == 'U') {
                    return "redClass";
                } else if (data.date9 == 'A2') {
                    return "redClass";
                } else if (data.date9 == 'S2') {
                    return "redClass";
                } else if (data.date9 == 'C2') {
                    return "redClass";
                } else if (data.date9 == 'T2') {
                    return "redClass";
                } else if (data.date9 == 'M2') {
                    return "redClass";
                } else if (data.date9 == 'U2') {
                    return "redClass";
                } else if (data.date9 == 'LH') {
                    return "redClass";
                } else if (data.date9 == 'NA') {
                    return "whiteClass";
                } else if (data.date9 != null && data.date9 != 'P' && data.date9 != 'H' && data.date9 != 'A' && data.date9 != 'S' && data.date9 != 'C' && data.date9 != 'T' && data.date9 != 'M' && data.date9 != 'U' && data.date9 != 'A2' && data.date9 != 'S2' && data.date9 != 'C2' && data.date9 != 'T2' && data.date9 != 'M2' && data.date9 != 'U2' && data.date9 != 'LH') {
                    return "greenClass";
                } else{
                	return "whiteClass";
                };
            };
            
            var cellclassname9 = function (row, column, value, data) {
            	if (data.date10 == 'P') {
                    return "yellowClass";
                } else if (data.date10 == 'H') {
                    return "redClass";
                } else if (data.date10 == 'A') {
                    return "redClass";
                } else if (data.date10 == 'S') {
                    return "redClass";
                } else if (data.date10 == 'C') {
                    return "redClass";
                } else if (data.date10 == 'T') {
                    return "redClass";
                } else if (data.date10 == 'M') {
                    return "redClass";
                } else if (data.date10 == 'U') {
                    return "redClass";
                } else if (data.date10 == 'A2') {
                    return "redClass";
                } else if (data.date10 == 'S2') {
                    return "redClass";
                } else if (data.date10 == 'C2') {
                    return "redClass";
                } else if (data.date10 == 'T2') {
                    return "redClass";
                } else if (data.date10 == 'M2') {
                    return "redClass";
                } else if (data.date10 == 'U2') {
                    return "redClass";
                } else if (data.date10 == 'LH') {
                    return "redClass";
                } else if (data.date10 == 'NA') {
                    return "whiteClass";
                } else if (data.date10 != null && data.date10 != 'P' && data.date10 != 'H' && data.date10 != 'A' && data.date10 != 'S' && data.date10 != 'C' && data.date10 != 'T' && data.date10 != 'M' && data.date10 != 'U' && data.date10 != 'A2' && data.date10 != 'S2' && data.date10 != 'C2' && data.date10 != 'T2' && data.date10 != 'M2' && data.date10 != 'U2' && data.date10 != 'LH') {
                    return "greenClass";
                } else{
                	return "whiteClass";
                };
            };
            
            var cellclassname10 = function (row, column, value, data) {
            	if (data.date11 == 'P') {
                    return "yellowClass";
                } else if (data.date11 == 'H') {
                    return "redClass";
                } else if (data.date11 == 'A') {
                    return "redClass";
                } else if (data.date11 == 'S') {
                    return "redClass";
                } else if (data.date11 == 'C') {
                    return "redClass";
                } else if (data.date11 == 'T') {
                    return "redClass";
                } else if (data.date11 == 'M') {
                    return "redClass";
                } else if (data.date11 == 'U') {
                    return "redClass";
                } else if (data.date11 == 'A2') {
                    return "redClass";
                } else if (data.date11 == 'S2') {
                    return "redClass";
                } else if (data.date11 == 'C2') {
                    return "redClass";
                } else if (data.date11 == 'T2') {
                    return "redClass";
                } else if (data.date11 == 'M2') {
                    return "redClass";
                } else if (data.date11 == 'U2') {
                    return "redClass";
                } else if (data.date11 == 'LH') {
                    return "redClass";
                } else if (data.date11 == 'NA') {
                    return "whiteClass";
                } else if (data.date11 != null && data.date11 != 'P' && data.date11 != 'H' && data.date11 != 'A' && data.date11 != 'S' && data.date11 != 'C' && data.date11 != 'T' && data.date11 != 'M' && data.date11 != 'U' && data.date11 != 'A2' && data.date11 != 'S2' && data.date11 != 'C2' && data.date11 != 'T2' && data.date11 != 'M2' && data.date11 != 'U2' && data.date11 != 'LH') {
                    return "greenClass";
                } else{
                	return "whiteClass";
                };
            };
            
            var cellclassname11 = function (row, column, value, data) {
            	if (data.date12 == 'P') {
                    return "yellowClass";
                } else if (data.date12 == 'H') {
                    return "redClass";
                } else if (data.date12 == 'A') {
                    return "redClass";
                } else if (data.date12 == 'S') {
                    return "redClass";
                } else if (data.date12 == 'C') {
                    return "redClass";
                } else if (data.date12 == 'T') {
                    return "redClass";
                } else if (data.date12 == 'M') {
                    return "redClass";
                } else if (data.date12 == 'U') {
                    return "redClass";
                } else if (data.date12 == 'A2') {
                    return "redClass";
                } else if (data.date12 == 'S2') {
                    return "redClass";
                } else if (data.date12 == 'C2') {
                    return "redClass";
                } else if (data.date12 == 'T2') {
                    return "redClass";
                } else if (data.date12 == 'M2') {
                    return "redClass";
                } else if (data.date12 == 'U2') {
                    return "redClass";
                } else if (data.date12 == 'LH') {
                    return "redClass";
                } else if (data.date12 == 'NA') {
                    return "whiteClass";
                } else if (data.date12 != null && data.date12 != 'P' && data.date12 != 'H' && data.date12 != 'A' && data.date12 != 'S' && data.date12 != 'C' && data.date12 != 'T' && data.date12 != 'M' && data.date12 != 'U' && data.date12 != 'A2' && data.date12 != 'S2' && data.date12 != 'C2' && data.date12 != 'T2' && data.date12 != 'M2' && data.date12 != 'U2' && data.date12 != 'LH') {
                    return "greenClass";
                } else{
                	return "whiteClass";
                };
            };
            
            var cellclassname12 = function (row, column, value, data) {
            	if (data.date13 == 'P') {
                    return "yellowClass";
                } else if (data.date13 == 'H') {
                    return "redClass";
                } else if (data.date13 == 'A') {
                    return "redClass";
                } else if (data.date13 == 'S') {
                    return "redClass";
                } else if (data.date13 == 'C') {
                    return "redClass";
                } else if (data.date13 == 'T') {
                    return "redClass";
                } else if (data.date13 == 'M') {
                    return "redClass";
                } else if (data.date13 == 'U') {
                    return "redClass";
                } else if (data.date13 == 'A2') {
                    return "redClass";
                } else if (data.date13 == 'S2') {
                    return "redClass";
                } else if (data.date13 == 'C2') {
                    return "redClass";
                } else if (data.date13 == 'T2') {
                    return "redClass";
                } else if (data.date13 == 'M2') {
                    return "redClass";
                } else if (data.date13 == 'U2') {
                    return "redClass";
                } else if (data.date13 == 'LH') {
                    return "redClass";
                } else if (data.date13 == 'NA') {
                    return "whiteClass";
                } else if (data.date13 != null && data.date13 != 'P' && data.date13 != 'H' && data.date13 != 'A' && data.date13 != 'S' && data.date13 != 'C' && data.date13 != 'T' && data.date13 != 'M' && data.date13 != 'U' && data.date13 != 'A2' && data.date13 != 'S2' && data.date13 != 'C2' && data.date13 != 'T2' && data.date13 != 'M2' && data.date13 != 'U2' && data.date13 != 'LH') {
                    return "greenClass";
                } else{
                	return "whiteClass";
                };
            };
            
            var cellclassname13 = function (row, column, value, data) {
            	if (data.date14 == 'P') {
                    return "yellowClass";
                } else if (data.date14 == 'H') {
                    return "redClass";
                } else if (data.date14 == 'A') {
                    return "redClass";
                } else if (data.date14 == 'S') {
                    return "redClass";
                } else if (data.date14 == 'C') {
                    return "redClass";
                } else if (data.date14 == 'T') {
                    return "redClass";
                } else if (data.date14 == 'M') {
                    return "redClass";
                } else if (data.date14 == 'U') {
                    return "redClass";
                } else if (data.date14 == 'A2') {
                    return "redClass";
                } else if (data.date14 == 'S2') {
                    return "redClass";
                } else if (data.date14 == 'C2') {
                    return "redClass";
                } else if (data.date14 == 'T2') {
                    return "redClass";
                } else if (data.date14 == 'M2') {
                    return "redClass";
                } else if (data.date14 == 'U2') {
                    return "redClass";
                } else if (data.date14 == 'LH') {
                    return "redClass";
                } else if (data.date14 == 'NA') {
                    return "whiteClass";
                } else if (data.date14 != null && data.date14 != 'P' && data.date14 != 'H' && data.date14 != 'A' && data.date14 != 'S' && data.date14 != 'C' && data.date14 != 'T' && data.date14 != 'M' && data.date14 != 'U' && data.date14 != 'A2' && data.date14 != 'S2' && data.date14 != 'C2' && data.date14 != 'T2' && data.date14 != 'M2' && data.date14 != 'U2' && data.date14 != 'LH') {
                    return "greenClass";
                } else{
                	return "whiteClass";
                };
            };
            
            var cellclassname14 = function (row, column, value, data) {
            	if (data.date15 == 'P') {
                    return "yellowClass";
                } else if (data.date15 == 'H') {
                    return "redClass";
                } else if (data.date15 == 'A') {
                    return "redClass";
                } else if (data.date15 == 'S') {
                    return "redClass";
                } else if (data.date15 == 'C') {
                    return "redClass";
                } else if (data.date15 == 'T') {
                    return "redClass";
                } else if (data.date15 == 'M') {
                    return "redClass";
                } else if (data.date15 == 'U') {
                    return "redClass";
                } else if (data.date15 == 'A2') {
                    return "redClass";
                } else if (data.date15 == 'S2') {
                    return "redClass";
                } else if (data.date15 == 'C2') {
                    return "redClass";
                } else if (data.date15 == 'T2') {
                    return "redClass";
                } else if (data.date15 == 'M2') {
                    return "redClass";
                } else if (data.date15 == 'U2') {
                    return "redClass";
                } else if (data.date15 == 'LH') {
                    return "redClass";
                } else if (data.date15 == 'NA') {
                    return "whiteClass";
                } else if (data.date15 != null && data.date15 != 'P' && data.date15 != 'H' && data.date15 != 'A' && data.date15 != 'S' && data.date15 != 'C' && data.date15 != 'T' && data.date15 != 'M' && data.date15 != 'U' && data.date15 != 'A2' && data.date15 != 'S2' && data.date15 != 'C2' && data.date15 != 'T2' && data.date15 != 'M2' && data.date15 != 'U2' && data.date15 != 'LH') {
                    return "greenClass";
                } else{
                	return "whiteClass";
                };
            };
            
            var cellclassname15 = function (row, column, value, data) {
            	if (data.date16 == 'P') {
                    return "yellowClass";
                } else if (data.date16 == 'H') {
                    return "redClass";
                } else if (data.date16 == 'A') {
                    return "redClass";
                } else if (data.date16 == 'S') {
                    return "redClass";
                } else if (data.date16 == 'C') {
                    return "redClass";
                } else if (data.date16 == 'T') {
                    return "redClass";
                } else if (data.date16 == 'M') {
                    return "redClass";
                } else if (data.date16 == 'U') {
                    return "redClass";
                } else if (data.date16 == 'A2') {
                    return "redClass";
                } else if (data.date16 == 'S2') {
                    return "redClass";
                } else if (data.date16 == 'C2') {
                    return "redClass";
                } else if (data.date16 == 'T2') {
                    return "redClass";
                } else if (data.date16 == 'M2') {
                    return "redClass";
                } else if (data.date16 == 'U2') {
                    return "redClass";
                } else if (data.date16 == 'LH') {
                    return "redClass";
                } else if (data.date16 == 'NA') {
                    return "whiteClass";
                } else if (data.date16 != null && data.date16 != 'P' && data.date16 != 'H' && data.date16 != 'A' && data.date16 != 'S' && data.date16 != 'C' && data.date16 != 'T' && data.date16 != 'M' && data.date16 != 'U' && data.date16 != 'A2' && data.date16 != 'S2' && data.date16 != 'C2' && data.date16 != 'T2' && data.date16 != 'M2' && data.date16 != 'U2' && data.date16 != 'LH') {
                    return "greenClass";
                } else{
                	return "whiteClass";
                };
            };
            
            var cellclassname16 = function (row, column, value, data) {
            	if (data.date17 == 'P') {
                    return "yellowClass";
                } else if (data.date17 == 'H') {
                    return "redClass";
                } else if (data.date17 == 'A') {
                    return "redClass";
                } else if (data.date17 == 'S') {
                    return "redClass";
                } else if (data.date17 == 'C') {
                    return "redClass";
                } else if (data.date17 == 'T') {
                    return "redClass";
                } else if (data.date17 == 'M') {
                    return "redClass";
                } else if (data.date17 == 'U') {
                    return "redClass";
                } else if (data.date17 == 'A2') {
                    return "redClass";
                } else if (data.date17 == 'S2') {
                    return "redClass";
                } else if (data.date17 == 'C2') {
                    return "redClass";
                } else if (data.date17 == 'T2') {
                    return "redClass";
                } else if (data.date17 == 'M2') {
                    return "redClass";
                } else if (data.date17 == 'U2') {
                    return "redClass";
                } else if (data.date17 == 'LH') {
                    return "redClass";
                } else if (data.date17 == 'NA') {
                    return "whiteClass";
                } else if (data.date17 != null && data.date17 != 'P' && data.date17 != 'H' && data.date17 != 'A' && data.date17 != 'S' && data.date17 != 'C' && data.date17 != 'T' && data.date17 != 'M' && data.date17 != 'U' && data.date17 != 'A2' && data.date17 != 'S2' && data.date17 != 'C2' && data.date17 != 'T2' && data.date17 != 'M2' && data.date17 != 'U2' && data.date17 != 'LH') {
                    return "greenClass";
                } else{
                	return "whiteClass";
                };
            };
            
            var cellclassname17 = function (row, column, value, data) {
            	if (data.date18 == 'P') {
                    return "yellowClass";
                } else if (data.date18 == 'H') {
                    return "redClass";
                } else if (data.date18 == 'A') {
                    return "redClass";
                } else if (data.date18 == 'S') {
                    return "redClass";
                } else if (data.date18 == 'C') {
                    return "redClass";
                } else if (data.date18 == 'T') {
                    return "redClass";
                } else if (data.date18 == 'M') {
                    return "redClass";
                } else if (data.date18 == 'U') {
                    return "redClass";
                } else if (data.date18 == 'A2') {
                    return "redClass";
                } else if (data.date18 == 'S2') {
                    return "redClass";
                } else if (data.date18 == 'C2') {
                    return "redClass";
                } else if (data.date18 == 'T2') {
                    return "redClass";
                } else if (data.date18 == 'M2') {
                    return "redClass";
                } else if (data.date18 == 'U2') {
                    return "redClass";
                } else if (data.date18 == 'LH') {
                    return "redClass";
                } else if (data.date18 == 'NA') {
                    return "whiteClass";
                } else if (data.date18 != null && data.date18 != 'P' && data.date18 != 'H' && data.date18 != 'A' && data.date18 != 'S' && data.date18 != 'C' && data.date18 != 'T' && data.date18 != 'M' && data.date18 != 'U' && data.date18 != 'A2' && data.date18 != 'S2' && data.date18 != 'C2' && data.date18 != 'T2' && data.date18 != 'M2' && data.date18 != 'U2' && data.date18 != 'LH') {
                    return "greenClass";
                } else{
                	return "whiteClass";
                };
            };
            
            var cellclassname18 = function (row, column, value, data) {
            	if (data.date19 == 'P') {
                    return "yellowClass";
                } else if (data.date19 == 'H') {
                    return "redClass";
                } else if (data.date19 == 'A') {
                    return "redClass";
                } else if (data.date19 == 'S') {
                    return "redClass";
                } else if (data.date19 == 'C') {
                    return "redClass";
                } else if (data.date19 == 'T') {
                    return "redClass";
                } else if (data.date19 == 'M') {
                    return "redClass";
                } else if (data.date19 == 'U') {
                    return "redClass";
                } else if (data.date19 == 'A2') {
                    return "redClass";
                } else if (data.date19 == 'S2') {
                    return "redClass";
                } else if (data.date19 == 'C2') {
                    return "redClass";
                } else if (data.date19 == 'T2') {
                    return "redClass";
                } else if (data.date19 == 'M2') {
                    return "redClass";
                } else if (data.date19 == 'U2') {
                    return "redClass";
                } else if (data.date19 == 'LH') {
                    return "redClass";
                } else if (data.date19 == 'NA') {
                    return "whiteClass";
                } else if (data.date19 != null && data.date19 != 'P' && data.date19 != 'H' && data.date19 != 'A' && data.date19 != 'S' && data.date19 != 'C' && data.date19 != 'T' && data.date19 != 'M' && data.date19 != 'U' && data.date19 != 'A2' && data.date19 != 'S2' && data.date19 != 'C2' && data.date19 != 'T2' && data.date19 != 'M2' && data.date19 != 'U2' && data.date19 != 'LH') {
                    return "greenClass";
                } else{
                	return "whiteClass";
                };
            };
            
            var cellclassname19 = function (row, column, value, data) {
            	if (data.date20 == 'P') {
                    return "yellowClass";
                } else if (data.date20 == 'H') {
                    return "redClass";
                } else if (data.date20 == 'A') {
                    return "redClass";
                } else if (data.date20 == 'S') {
                    return "redClass";
                } else if (data.date20 == 'C') {
                    return "redClass";
                } else if (data.date20 == 'T') {
                    return "redClass";
                } else if (data.date20 == 'M') {
                    return "redClass";
                } else if (data.date20 == 'U') {
                    return "redClass";
                } else if (data.date20 == 'A2') {
                    return "redClass";
                } else if (data.date20 == 'S2') {
                    return "redClass";
                } else if (data.date20 == 'C2') {
                    return "redClass";
                } else if (data.date20 == 'T2') {
                    return "redClass";
                } else if (data.date20 == 'M2') {
                    return "redClass";
                } else if (data.date20 == 'U2') {
                    return "redClass";
                } else if (data.date20 == 'LH') {
                    return "redClass";
                } else if (data.date20 == 'NA') {
                    return "whiteClass";
                } else if (data.date20 != null && data.date20 != 'P' && data.date20 != 'H' && data.date20 != 'A' && data.date20 != 'S' && data.date20 != 'C' && data.date20 != 'T' && data.date20 != 'M' && data.date20 != 'U' && data.date20 != 'A2' && data.date20 != 'S2' && data.date20 != 'C2' && data.date20 != 'T2' && data.date20 != 'M2' && data.date20 != 'U2' && data.date20 != 'LH') {
                    return "greenClass";
                } else{
                	return "whiteClass";
                };
            };
            
            var cellclassname20 = function (row, column, value, data) {
            	if (data.date21 == 'P') {
                    return "yellowClass";
                } else if (data.date21 == 'H') {
                    return "redClass";
                } else if (data.date21 == 'A') {
                    return "redClass";
                } else if (data.date21 == 'S') {
                    return "redClass";
                } else if (data.date21 == 'C') {
                    return "redClass";
                } else if (data.date21 == 'T') {
                    return "redClass";
                } else if (data.date21 == 'M') {
                    return "redClass";
                } else if (data.date21 == 'U') {
                    return "redClass";
                } else if (data.date21 == 'A2') {
                    return "redClass";
                } else if (data.date21 == 'S2') {
                    return "redClass";
                } else if (data.date21 == 'C2') {
                    return "redClass";
                } else if (data.date21 == 'T2') {
                    return "redClass";
                } else if (data.date21 == 'M2') {
                    return "redClass";
                } else if (data.date21 == 'U2') {
                    return "redClass";
                } else if (data.date21 == 'LH') {
                    return "redClass";
                } else if (data.date21 == 'NA') {
                    return "whiteClass";
                } else if (data.date21 != null && data.date21 != 'P' && data.date21 != 'H' && data.date21 != 'A' && data.date21 != 'S' && data.date21 != 'C' && data.date21 != 'T' && data.date21 != 'M' && data.date21 != 'U' && data.date21 != 'A2' && data.date21 != 'S2' && data.date21 != 'C2' && data.date21 != 'T2' && data.date21 != 'M2' && data.date21 != 'U2' && data.date21 != 'LH') {
                    return "greenClass";
                } else{
                	return "whiteClass";
                };
            };
            
            var cellclassname21 = function (row, column, value, data) {
            	if (data.date22 == 'P') {
                    return "yellowClass";
                } else if (data.date22 == 'H') {
                    return "redClass";
                } else if (data.date22 == 'A') {
                    return "redClass";
                } else if (data.date22 == 'S') {
                    return "redClass";
                } else if (data.date22 == 'C') {
                    return "redClass";
                } else if (data.date22 == 'T') {
                    return "redClass";
                } else if (data.date22 == 'M') {
                    return "redClass";
                } else if (data.date22 == 'U') {
                    return "redClass";
                } else if (data.date22 == 'A2') {
                    return "redClass";
                } else if (data.date22 == 'S2') {
                    return "redClass";
                } else if (data.date22 == 'C2') {
                    return "redClass";
                } else if (data.date22 == 'T2') {
                    return "redClass";
                } else if (data.date22 == 'M2') {
                    return "redClass";
                } else if (data.date22 == 'U2') {
                    return "redClass";
                } else if (data.date22 == 'LH') {
                    return "redClass";
                } else if (data.date22 == 'NA') {
                    return "whiteClass";
                } else if (data.date22 != null && data.date22 != 'P' && data.date22 != 'H' && data.date22 != 'A' && data.date22 != 'S' && data.date22 != 'C' && data.date22 != 'T' && data.date22 != 'M' && data.date22 != 'U' && data.date22 != 'A2' && data.date22 != 'S2' && data.date22 != 'C2' && data.date22 != 'T2' && data.date22 != 'M2' && data.date22 != 'U2' && data.date22 != 'LH') {
                    return "greenClass";
                } else{
                	return "whiteClass";
                };
            };
            
            var cellclassname22 = function (row, column, value, data) {
            	if (data.date23 == 'P') {
                    return "yellowClass";
                } else if (data.date23 == 'H') {
                    return "redClass";
                } else if (data.date23 == 'A') {
                    return "redClass";
                } else if (data.date23 == 'S') {
                    return "redClass";
                } else if (data.date23 == 'C') {
                    return "redClass";
                } else if (data.date23 == 'T') {
                    return "redClass";
                } else if (data.date23 == 'M') {
                    return "redClass";
                } else if (data.date23 == 'U') {
                    return "redClass";
                } else if (data.date23 == 'A2') {
                    return "redClass";
                } else if (data.date23 == 'S2') {
                    return "redClass";
                } else if (data.date23 == 'C2') {
                    return "redClass";
                } else if (data.date23 == 'T2') {
                    return "redClass";
                } else if (data.date23 == 'M2') {
                    return "redClass";
                } else if (data.date23 == 'U2') {
                    return "redClass";
                } else if (data.date23 == 'LH') {
                    return "redClass";
                } else if (data.date23 == 'NA') {
                    return "whiteClass";
                } else if (data.date23 != null && data.date23 != 'P' && data.date23 != 'H' && data.date23 != 'A' && data.date23 != 'S' && data.date23 != 'C' && data.date23 != 'T' && data.date23 != 'M' && data.date23 != 'U' && data.date23 != 'A2' && data.date23 != 'S2' && data.date23 != 'C2' && data.date23 != 'T2' && data.date23 != 'M2' && data.date23 != 'U2' && data.date23 != 'LH') {
                    return "greenClass";
                } else{
                	return "whiteClass";
                };
            };
            
            var cellclassname23 = function (row, column, value, data) {
            	if (data.date24 == 'P') {
                    return "yellowClass";
                } else if (data.date24 == 'H') {
                    return "redClass";
                } else if (data.date24 == 'A') {
                    return "redClass";
                } else if (data.date24 == 'S') {
                    return "redClass";
                } else if (data.date24 == 'C') {
                    return "redClass";
                } else if (data.date24 == 'T') {
                    return "redClass";
                } else if (data.date24 == 'M') {
                    return "redClass";
                } else if (data.date24 == 'U') {
                    return "redClass";
                } else if (data.date24 == 'A2') {
                    return "redClass";
                } else if (data.date24 == 'S2') {
                    return "redClass";
                } else if (data.date24 == 'C2') {
                    return "redClass";
                } else if (data.date24 == 'T2') {
                    return "redClass";
                } else if (data.date24 == 'M2') {
                    return "redClass";
                } else if (data.date24 == 'U2') {
                    return "redClass";
                } else if (data.date24 == 'LH') {
                    return "redClass";
                } else if (data.date24 == 'NA') {
                    return "whiteClass";
                } else if (data.date24 != null && data.date24 != 'P' && data.date24 != 'H' && data.date24 != 'A' && data.date24 != 'S' && data.date24 != 'C' && data.date24 != 'T' && data.date24 != 'M' && data.date24 != 'U' && data.date24 != 'A2' && data.date24 != 'S2' && data.date24 != 'C2' && data.date24 != 'T2' && data.date24 != 'M2' && data.date24 != 'U2' && data.date24 != 'LH') {
                    return "greenClass";
                } else{
                	return "whiteClass";
                };
            };
            
            var cellclassname24 = function (row, column, value, data) {
            	if (data.date25 == 'P') {
                    return "yellowClass";
                } else if (data.date25 == 'H') {
                    return "redClass";
                } else if (data.date25 == 'A') {
                    return "redClass";
                } else if (data.date25 == 'S') {
                    return "redClass";
                } else if (data.date25 == 'C') {
                    return "redClass";
                } else if (data.date25 == 'T') {
                    return "redClass";
                } else if (data.date25 == 'M') {
                    return "redClass";
                } else if (data.date25 == 'U') {
                    return "redClass";
                } else if (data.date25 == 'A2') {
                    return "redClass";
                } else if (data.date25 == 'S2') {
                    return "redClass";
                } else if (data.date25 == 'C2') {
                    return "redClass";
                } else if (data.date25 == 'T2') {
                    return "redClass";
                } else if (data.date25 == 'M2') {
                    return "redClass";
                } else if (data.date25 == 'U2') {
                    return "redClass";
                } else if (data.date25 == 'LH') {
                    return "redClass";
                } else if (data.date25 == 'NA') {
                    return "whiteClass";
                } else if (data.date25 != null && data.date25 != 'P' && data.date25 != 'H' && data.date25 != 'A' && data.date25 != 'S' && data.date25 != 'C' && data.date25 != 'T' && data.date25 != 'M' && data.date25 != 'U' && data.date25 != 'A2' && data.date25 != 'S2' && data.date25 != 'C2' && data.date25 != 'T2' && data.date25 != 'M2' && data.date25 != 'U2' && data.date25 != 'LH') {
                    return "greenClass";
                } else{
                	return "whiteClass";
                };
            };
            
            var cellclassname25 = function (row, column, value, data) {
            	if (data.date26 == 'P') {
                    return "yellowClass";
                } else if (data.date26 == 'H') {
                    return "redClass";
                } else if (data.date26 == 'A') {
                    return "redClass";
                } else if (data.date26 == 'S') {
                    return "redClass";
                } else if (data.date26 == 'C') {
                    return "redClass";
                } else if (data.date26 == 'T') {
                    return "redClass";
                } else if (data.date26 == 'M') {
                    return "redClass";
                } else if (data.date26 == 'U') {
                    return "redClass";
                } else if (data.date26 == 'A2') {
                    return "redClass";
                } else if (data.date26 == 'S2') {
                    return "redClass";
                } else if (data.date26 == 'C2') {
                    return "redClass";
                } else if (data.date26 == 'T2') {
                    return "redClass";
                } else if (data.date26 == 'M2') {
                    return "redClass";
                } else if (data.date26 == 'U2') {
                    return "redClass";
                } else if (data.date26 == 'LH') {
                    return "redClass";
                } else if (data.date26 == 'NA') {
                    return "whiteClass";
                } else if (data.date26 != null && data.date26 != 'P' && data.date26 != 'H' && data.date26 != 'A' && data.date26 != 'S' && data.date26 != 'C' && data.date26 != 'T' && data.date26 != 'M' && data.date26 != 'U' && data.date26 != 'A2' && data.date26 != 'S2' && data.date26 != 'C2' && data.date26 != 'T2' && data.date26 != 'M2' && data.date26 != 'U2' && data.date26 != 'LH') {
                    return "greenClass";
                } else{
                	return "whiteClass";
                };
            };
            
            var cellclassname26 = function (row, column, value, data) {
            	if (data.date27 == 'P') {
                    return "yellowClass";
                } else if (data.date27 == 'H') {
                    return "redClass";
                } else if (data.date27 == 'A') {
                    return "redClass";
                } else if (data.date27 == 'S') {
                    return "redClass";
                } else if (data.date27 == 'C') {
                    return "redClass";
                } else if (data.date27 == 'T') {
                    return "redClass";
                } else if (data.date27 == 'M') {
                    return "redClass";
                } else if (data.date27 == 'U') {
                    return "redClass";
                } else if (data.date27 == 'A2') {
                    return "redClass";
                } else if (data.date27 == 'S2') {
                    return "redClass";
                } else if (data.date27 == 'C2') {
                    return "redClass";
                } else if (data.date27 == 'T2') {
                    return "redClass";
                } else if (data.date27 == 'M2') {
                    return "redClass";
                } else if (data.date27 == 'U2') {
                    return "redClass";
                } else if (data.date27 == 'LH') {
                    return "redClass";
                } else if (data.date27 == 'NA') {
                    return "whiteClass";
                } else if (data.date27 != null && data.date27 != 'P' && data.date27 != 'H' && data.date27 != 'A' && data.date27 != 'S' && data.date27 != 'C' && data.date27 != 'T' && data.date27 != 'M' && data.date27 != 'U' && data.date27 != 'A2' && data.date27 != 'S2' && data.date27 != 'C2' && data.date27 != 'T2' && data.date27 != 'M2' && data.date27 != 'U2' && data.date27 != 'LH') {
                    return "greenClass";
                } else{
                	return "whiteClass";
                };
            };
            
            var cellclassname27 = function (row, column, value, data) {
            	if (data.date28 == 'P') {
                    return "yellowClass";
                } else if (data.date28 == 'H') {
                    return "redClass";
                } else if (data.date28 == 'A') {
                    return "redClass";
                } else if (data.date28 == 'S') {
                    return "redClass";
                } else if (data.date28 == 'C') {
                    return "redClass";
                } else if (data.date28 == 'T') {
                    return "redClass";
                } else if (data.date28 == 'M') {
                    return "redClass";
                } else if (data.date28 == 'U') {
                    return "redClass";
                } else if (data.date28 == 'A2') {
                    return "redClass";
                } else if (data.date28 == 'S2') {
                    return "redClass";
                } else if (data.date28 == 'C2') {
                    return "redClass";
                } else if (data.date28 == 'T2') {
                    return "redClass";
                } else if (data.date28 == 'M2') {
                    return "redClass";
                } else if (data.date28 == 'U2') {
                    return "redClass";
                } else if (data.date28 == 'LH') {
                    return "redClass";
                } else if (data.date28 == 'NA') {
                    return "whiteClass";
                } else if (data.date28 != null && data.date28 != 'P' && data.date28 != 'H' && data.date28 != 'A' && data.date28 != 'S' && data.date28 != 'C' && data.date28 != 'T' && data.date28 != 'M' && data.date28 != 'U' && data.date28 != 'A2' && data.date28 != 'S2' && data.date28 != 'C2' && data.date28 != 'T2' && data.date28 != 'M2' && data.date28 != 'U2' && data.date28 != 'LH') {
                    return "greenClass";
                } else{
                	return "whiteClass";
                };
            };
            
            var cellclassname28 = function (row, column, value, data) {
            	if (data.date29 == 'P') {
                    return "yellowClass";
                } else if (data.date29 == 'H') {
                    return "redClass";
                } else if (data.date29 == 'A') {
                    return "redClass";
                } else if (data.date29 == 'S') {
                    return "redClass";
                } else if (data.date29 == 'C') {
                    return "redClass";
                } else if (data.date29 == 'T') {
                    return "redClass";
                } else if (data.date29 == 'M') {
                    return "redClass";
                } else if (data.date29 == 'U') {
                    return "redClass";
                } else if (data.date29 == 'A2') {
                    return "redClass";
                } else if (data.date29 == 'S2') {
                    return "redClass";
                } else if (data.date29 == 'C2') {
                    return "redClass";
                } else if (data.date29 == 'T2') {
                    return "redClass";
                } else if (data.date29 == 'M2') {
                    return "redClass";
                } else if (data.date29 == 'U2') {
                    return "redClass";
                } else if (data.date29 == 'LH') {
                    return "redClass";
                } else if (data.date29 == 'NA') {
                    return "whiteClass";
                } else if (data.date29 != null && data.date29 != 'P' && data.date29 != 'H' && data.date29 != 'A' && data.date29 != 'S' && data.date29 != 'C' && data.date29 != 'T' && data.date29 != 'M' && data.date29 != 'U' && data.date29 != 'A2' && data.date29 != 'S2' && data.date29 != 'C2' && data.date29 != 'T2' && data.date29 != 'M2' && data.date29 != 'U2' && data.date29 != 'LH') {
                    return "greenClass";
                } else{
                	return "whiteClass";
                };
            };
            
            var cellclassname29 = function (row, column, value, data) {
            	if (data.date30 == 'P') {
                    return "yellowClass";
                } else if (data.date30 == 'H') {
                    return "redClass";
                } else if (data.date30 == 'A') {
                    return "redClass";
                } else if (data.date30 == 'S') {
                    return "redClass";
                } else if (data.date30 == 'C') {
                    return "redClass";
                } else if (data.date30 == 'T') {
                    return "redClass";
                } else if (data.date30 == 'M') {
                    return "redClass";
                } else if (data.date30 == 'U') {
                    return "redClass";
                } else if (data.date30 == 'A2') {
                    return "redClass";
                } else if (data.date30 == 'S2') {
                    return "redClass";
                } else if (data.date30 == 'C2') {
                    return "redClass";
                } else if (data.date30 == 'T2') {
                    return "redClass";
                } else if (data.date30 == 'M2') {
                    return "redClass";
                } else if (data.date30 == 'U2') {
                    return "redClass";
                } else if (data.date30 == 'LH') {
                    return "redClass";
                } else if (data.date30 == 'NA') {
                    return "whiteClass";
                } else if (data.date30 != null && data.date30 != 'P' && data.date30 != 'H' && data.date30 != 'A' && data.date30 != 'S' && data.date30 != 'C' && data.date30 != 'T' && data.date30 != 'M' && data.date30 != 'U' && data.date30 != 'A2' && data.date30 != 'S2' && data.date30 != 'C2' && data.date30 != 'T2' && data.date30 != 'M2' && data.date30 != 'U2' && data.date30 != 'LH') {
                    return "greenClass";
                } else{
                	return "whiteClass";
                };
            };
            
            var cellclassname30 = function (row, column, value, data) {
        		if (data.date31 == 'P') {
                    return "yellowClass";
                } else if (data.date31 == 'H') {
                    return "redClass";
                } else if (data.date31 == 'A') {
                    return "redClass";
                } else if (data.date31 == 'S') {
                    return "redClass";
                } else if (data.date31 == 'C') {
                    return "redClass";
                } else if (data.date31 == 'T') {
                    return "redClass";
                } else if (data.date31 == 'M') {
                    return "redClass";
                } else if (data.date31 == 'U') {
                    return "redClass";
                } else if (data.date31 == 'A2') {
                    return "redClass";
                } else if (data.date31 == 'S2') {
                    return "redClass";
                } else if (data.date31 == 'C2') {
                    return "redClass";
                } else if (data.date31 == 'T2') {
                    return "redClass";
                } else if (data.date31 == 'M2') {
                    return "redClass";
                } else if (data.date31 == 'U2') {
                    return "redClass";
                } else if (data.date31 == 'LH') {
                    return "redClass";
                } else if (data.date31 == 'NA') {
                    return "whiteClass";
                } else if (data.date31 != null && data.date31 != 'P' && data.date31 != 'H' && data.date31 != 'A' && data.date31 != 'S' && data.date31 != 'C' && data.date31 != 'T' && data.date31 != 'M' && data.date31 != 'U' && data.date31 != 'A2' && data.date31 != 'S2' && data.date31 != 'C2' && data.date31 != 'T2' && data.date31 != 'M2' && data.date31 != 'U2' && data.date31 != 'LH') {
                    return "greenClass";
                } else{
                	return "whiteClass";
                };
            };
            
            $("#attendanceGridID").on("bindingcomplete", function (event) {
					 if(tempDays=='28'){
						    $('#attendanceGridID').jqxGrid('hidecolumn', 'date29');
							$("#attendanceGridID").jqxGrid('hidecolumn', 'date30');
			    			$("#attendanceGridID").jqxGrid('hidecolumn', 'date31');
					 }else if(tempDays=='29'){
							$("#attendanceGridID").jqxGrid('hidecolumn', 'date30');
			    			$("#attendanceGridID").jqxGrid('hidecolumn', 'date31');
					 }else if(tempDays=='30'){
			    			$("#attendanceGridID").jqxGrid('hidecolumn', 'date31');
					 }else{
						    $("#attendanceGridID").jqxGrid('showcolumn', 'date29');
						    $("#attendanceGridID").jqxGrid('showcolumn', 'date30');
						    $("#attendanceGridID").jqxGrid('showcolumn', 'date31');
					 }
					 
					 var leavetype=$('#cmbleavetype').children("option").length;
					 for(var k=0 ; k < leavetype ; k++){
						 if($('#cmbleavetype option').eq(k).val()==''){
							    $('#attendanceGridID').jqxGrid('hidecolumn', 'leave1total');
							    $('#attendanceGridID').jqxGrid('hidecolumn', 'leave2total');
							    $('#attendanceGridID').jqxGrid('hidecolumn', 'leave3total');
							    $('#attendanceGridID').jqxGrid('hidecolumn', 'leave4total');
							    $('#attendanceGridID').jqxGrid('hidecolumn', 'leave5total');
							    $('#attendanceGridID').jqxGrid('hidecolumn', 'leave6total');
						 }
						 if($('#cmbleavetype option').eq(k).text().trim()=='Sick Leave'){
							    $('#attendanceGridID').jqxGrid('showcolumn', 'leave1total');
						 }
						 if($('#cmbleavetype option').eq(k).text().trim()=='Annual Leave'){
							    $('#attendanceGridID').jqxGrid('showcolumn', 'leave2total');
						 }
						 if($('#cmbleavetype option').eq(k).text().trim()=='LWP'){
							    $('#attendanceGridID').jqxGrid('showcolumn', 'leave3total');
						 }
						 if($('#cmbleavetype option').eq(k).text().trim()=='EMERGENCY LEAVE'){
							    $('#attendanceGridID').jqxGrid('showcolumn', 'leave4total');
						 }
						 if($('#cmbleavetype option').eq(k).text().trim()=='Maternity Leave'){
							    $('#attendanceGridID').jqxGrid('showcolumn', 'leave5total');
						 }
					 }
					 
					 getLeavesGridTotal("1");   
            });
            
            
            var dataAdapter = new $.jqx.dataAdapter(source,{
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			         });

            
            $("#attendanceGridID").jqxGrid(
            {
            	width: '100%',
                height: 460,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                
                columns: [
							{ text: 'S#', pinned: true, sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '3%',cellsalign: 'center', align: 'center', cellclassname: 'whiteClass',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }    
							},
							{ text: 'Emp. ID', pinned: true, datafield: 'employeeid', editable: false, cellclassname: 'whiteClass', width: '7%' },
							{ text: 'Emp. Name', pinned: true, datafield: 'employeename', editable: false, cellclassname: 'whiteClass', width: '17%' },			
							{ text: '1', datafield: 'date1', editable: false,  width: '2%', cellclassname: cellclassname, cellsalign: 'center', align: 'center'  },
							{ text: '2', datafield: 'date2', editable: false,  width: '2%', cellclassname: cellclassname1, cellsalign: 'center', align: 'center' },
							{ text: '3', datafield: 'date3', editable: false,  width: '2%', cellclassname: cellclassname2, cellsalign: 'center', align: 'center' },
							{ text: '4', datafield: 'date4', editable: false,  width: '2%', cellclassname: cellclassname3, cellsalign: 'center', align: 'center' },
							{ text: '5', datafield: 'date5', editable: false,  width: '2%', cellclassname: cellclassname4, cellsalign: 'center', align: 'center' },
							{ text: '6', datafield: 'date6', editable: false,  width: '2%', cellclassname: cellclassname5, cellsalign: 'center', align: 'center' },
							{ text: '7', datafield: 'date7', editable: false,  width: '2%', cellclassname: cellclassname6, cellsalign: 'center', align: 'center' },
							{ text: '8', datafield: 'date8', editable: false,  width: '2%', cellclassname: cellclassname7, cellsalign: 'center', align: 'center' },
							{ text: '9', datafield: 'date9', editable: false,  width: '2%', cellclassname: cellclassname8, cellsalign: 'center', align: 'center' },
							{ text: '10', datafield: 'date10', editable: false,  width: '2%', cellclassname: cellclassname9, cellsalign: 'center', align: 'center' },
							{ text: '11', datafield: 'date11', editable: false,  width: '2%', cellclassname: cellclassname10, cellsalign: 'center', align: 'center' },
							{ text: '12', datafield: 'date12', editable: false,  width: '2%', cellclassname: cellclassname11, cellsalign: 'center', align: 'center' },
							{ text: '13', datafield: 'date13', editable: false,  width: '2%', cellclassname: cellclassname12, cellsalign: 'center', align: 'center' },
							{ text: '14', datafield: 'date14', editable: false,  width: '2%', cellclassname: cellclassname13, cellsalign: 'center', align: 'center' },
							{ text: '15', datafield: 'date15', editable: false,  width: '2%', cellclassname: cellclassname14, cellsalign: 'center', align: 'center' },
							{ text: '16', datafield: 'date16', editable: false,  width: '2%', cellclassname: cellclassname15, cellsalign: 'center', align: 'center' },
							{ text: '17', datafield: 'date17', editable: false,  width: '2%', cellclassname: cellclassname16, cellsalign: 'center', align: 'center' },
							{ text: '18', datafield: 'date18', editable: false,  width: '2%', cellclassname: cellclassname17, cellsalign: 'center', align: 'center' },
							{ text: '19', datafield: 'date19', editable: false,  width: '2%', cellclassname: cellclassname18, cellsalign: 'center', align: 'center' },
							{ text: '20', datafield: 'date20', editable: false,  width: '2%', cellclassname: cellclassname19, cellsalign: 'center', align: 'center' },
							{ text: '21', datafield: 'date21', editable: false,  width: '2%', cellclassname: cellclassname20, cellsalign: 'center', align: 'center' },
							{ text: '22', datafield: 'date22', editable: false,  width: '2%', cellclassname: cellclassname21, cellsalign: 'center', align: 'center' },
							{ text: '23', datafield: 'date23', editable: false,  width: '2%', cellclassname: cellclassname22, cellsalign: 'center', align: 'center' },
							{ text: '24', datafield: 'date24', editable: false,  width: '2%', cellclassname: cellclassname23, cellsalign: 'center', align: 'center' },
							{ text: '25', datafield: 'date25', editable: false,  width: '2%', cellclassname: cellclassname24, cellsalign: 'center', align: 'center' },
							{ text: '26', datafield: 'date26', editable: false,  width: '2%', cellclassname: cellclassname25, cellsalign: 'center', align: 'center' },
							{ text: '27', datafield: 'date27', editable: false,  width: '2%', cellclassname: cellclassname26, cellsalign: 'center', align: 'center' },
							{ text: '28', datafield: 'date28', editable: false,  width: '2%', cellclassname: cellclassname27, cellsalign: 'center', align: 'center' },
							{ text: '29', datafield: 'date29', editable: false,  width: '2%', cellclassname: cellclassname28, cellsalign: 'center', align: 'center' },
							{ text: '30', datafield: 'date30', editable: false,  width: '2%', cellclassname: cellclassname29, cellsalign: 'center', align: 'center' },
							{ text: '31', datafield: 'date31', editable: false,  width: '2%', cellclassname: cellclassname30, cellsalign: 'center', align: 'center' },
							{ text: 'Days', datafield: 'days', editable: false, width: '3%', editable: false, cellsalign: 'center', align: 'center' },
							{ text: 'H', datafield: 'holiday', editable: false, width: '3%', editable: false, cellsalign: 'center', align: 'center' },
							{ text: 'L', datafield: 'leave', editable: false, width: '3%', cellsalign: 'center', align: 'center' },
							{ text: 'Sick Leave', datafield: 'leave1total', width: '7%', cellsalign: 'center', align: 'center', cellbeginedit: function (row) {
									if ($('#attendanceGridID').jqxGrid('getcellvalue', row, "leave1total")>=0) { 
								         if(parseInt($('#txtattendanceleaveseditgrid').val())==0) {
								              return false;
								         }}}
							},
							{ text: 'Annual Leave', datafield: 'leave2total', width: '10%', cellsalign: 'center', align: 'center', cellbeginedit: function (row) {
						         	if ($('#attendanceGridID').jqxGrid('getcellvalue', row, "leave2total")>=0) { 
							         	if(parseInt($('#txtattendanceleaveseditgrid').val())==0) {
							              	return false;
							         	}}}
							},
							{ text: 'LWP', datafield: 'leave3total', width: '7%', cellsalign: 'center', align: 'center', cellbeginedit: function (row) {
									if ($('#attendanceGridID').jqxGrid('getcellvalue', row, "leave3total")>=0) { 
							         	if(parseInt($('#txtattendanceleaveseditgrid').val())==0) {
							              	return false;
							         	}}}
							},
							{ text: 'EMERGENCY LEAVE', datafield: 'leave4total', width: '8%', cellsalign: 'center', align: 'center', cellbeginedit: function (row) {
									if ($('#attendanceGridID').jqxGrid('getcellvalue', row, "leave4total")>=0) { 
							         	if(parseInt($('#txtattendanceleaveseditgrid').val())==0) {
							              	return false;
							         	}}}
						    },
							{ text: 'Maternity Leave', datafield: 'leave5total', width: '8%', cellsalign: 'center', align: 'center', cellbeginedit: function (row) {
									if ($('#attendanceGridID').jqxGrid('getcellvalue', row, "leave5total")>=0) { 
							         	if(parseInt($('#txtattendanceleaveseditgrid').val())==0) {
							            	  return false;
							         	}}}
						    },
						    { text: ' Leave', datafield: 'leave6total', width: '8%', cellsalign: 'center', align: 'center', cellbeginedit: function (row) {
								if ($('#attendanceGridID').jqxGrid('getcellvalue', row, "leave5total")>=0) { 
						         	if(parseInt($('#txtattendanceleaveseditgrid').val())==0) {
						            	  return false;
						         	}}}
					    },
							{ text: 'Total Over-Time', datafield: 'totalovertime', editable: false, width: '7%', hidden: true },
							{ text: 'Total Holiday Over-Time', datafield: 'totalholidayovertime', editable: false, width: '7%', hidden: true },
							{ text: 'Total OT', datafield: 'totalovertimes', editable: false, width: '6%' },
							{ text: 'Total HOT', datafield: 'totalholidayovertimes', editable: false, width: '6%' },
							{ text: 'Emp. ID', datafield: 'employeedocno', editable: false, width: '7%', hidden: true },
							{ text: 'Payroll Processed', datafield: 'payroll_processed', editable: false, width: '7%', hidden: true },
						],
            });
            $("#overlay, #PleaseWait").hide();
            
         	 $("#attendanceGridID").on('cellvaluechanged', function (event){
         		var dataField = event.args.datafield;
         		var rowIndex=event.args.rowindex;
                
                if(dataField!='employeeid' || dataField!='employeename' || dataField!='days' || dataField!='holiday' || dataField!='leave1total' || dataField!='leave2total' || dataField!='leave3total' || dataField!='leave4total' || dataField!='leave5total' || dataField!='leave6total') {
                
                var holiday=0,leave=0,leave1total=0,leave2total=0,leave3total=0,leave4total=0,leave5total=0,leave6total=0,overtime=0,holidayovertime=0;
                var totdays = $('#attendanceGridID').jqxGrid('getcellvalue', rowIndex, "days");
                for(var i=1;i<=parseInt(totdays);i++)
         		{
                	
                	var value = $('#attendanceGridID').jqxGrid('getcellvalue', rowIndex, "date"+i+"");
                	
                	if(value=='H' || value=='LH'){
                		holiday=holiday+1;
                	}
                	if(value=='A' || value=='S' || value=='C' || value=='T' || value=='M' || value=='U'){
                		leave=leave+1;
                	}
                	if(value=='A2' || value=='S2' || value=='C2' || value=='T2' || value=='M2' || value=='U2'){
                		leave=leave+(0.5);
                	}
                	if(value=='S'){leave1total=leave1total+1;} 
                	if(value=='A'){leave2total=leave2total+1;}
                	if(value=='C'){leave3total=leave3total+1;}
                	if(value=='T'){leave4total=leave4total+1;}
                	if(value=='M'){leave5total=leave5total+1;}
                	if(value=='U'){leave6total=leave6total+1;}

                	if(value=='S2'){leave1total=leave1total+(0.5);} 
                	if(value=='A2'){leave2total=leave2total+(0.5);}
                	if(value=='C2'){leave3total=leave3total+(0.5);}
                	if(value=='T2'){leave4total=leave4total+(0.5);}
                	if(value=='M2'){leave5total=leave5total+(0.5);}
                	if(value=='U2'){leave6total=leave6total+(0.5);}

                	if(value.indexOf(':')>0) { 
                		
                		var weekoff = $('#txtholidaysofmonth').val();
                		var weekoff1 = weekoff.split(",");
                		var weekoffcount = (weekoff.match(/,/g) || []).length;
                		
                		var checking='0';
                		
                		for(var k=0;k<parseInt(weekoffcount);k++) {
	                	
                			if(weekoff1[k]==i){
                				checking='1';
	                		} 
	                		
	                		if(checking=='1'){
	                			var value1 = value.split(":");
		                		var value2 = ((parseInt(value1[0])*60)+parseInt(value1[1]));
		                		holidayovertime=holidayovertime+value2;
		                		break;
	                		} 
		         		}
                		
                		if(checking=='0'){
                			var value1 = value.split(":");
	                		var value2 = ((parseInt(value1[0])*60)+parseInt(value1[1]));
	                		overtime=overtime+value2;
                		} 
                    }
                	
         		}
                $('#attendanceGridID').jqxGrid('setcellvalue', rowIndex, "holiday",holiday);
                $('#attendanceGridID').jqxGrid('setcellvalue', rowIndex, "leave",leave);
                $('#attendanceGridID').jqxGrid('setcellvalue', rowIndex, "totalovertime",overtime);
                $('#attendanceGridID').jqxGrid('setcellvalue', rowIndex, "totalholidayovertime",holidayovertime);                
                $('#attendanceGridID').jqxGrid('setcellvalue', rowIndex, "totalovertimes", (((overtime-(overtime % 60))/60).toString() + ":" + ((overtime % 60)<10?"0":"") + (overtime % 60).toString()));
                $('#attendanceGridID').jqxGrid('setcellvalue', rowIndex, "totalholidayovertimes", (((holidayovertime-(holidayovertime % 60))/60).toString() + ":" + ((holidayovertime % 60)<10?"0":"") + (holidayovertime % 60).toString()));
                
                	if(parseInt($('#txtattendanceleaveseditgrid').val())==0){
		                $('#attendanceGridID').jqxGrid('setcellvalue', rowIndex, "leave1total",leave1total);
		                $('#attendanceGridID').jqxGrid('setcellvalue', rowIndex, "leave2total",leave2total);
		                $('#attendanceGridID').jqxGrid('setcellvalue', rowIndex, "leave3total",leave3total);
		                $('#attendanceGridID').jqxGrid('setcellvalue', rowIndex, "leave4total",leave4total);
		                $('#attendanceGridID').jqxGrid('setcellvalue', rowIndex, "leave5total",leave5total);
		                $('#attendanceGridID').jqxGrid('setcellvalue', rowIndex, "leave6total",leave6total);
	                }
	                
                }
                
                   $('#txtselectedcellleave1totalvalue').val($('#attendanceGridID').jqxGrid('getcellvalue', rowIndex, "leave1total"));
                   $('#txtselectedcellleave2totalvalue').val($('#attendanceGridID').jqxGrid('getcellvalue', rowIndex, "leave2total"));
	   			   $('#txtselectedcellleave3totalvalue').val($('#attendanceGridID').jqxGrid('getcellvalue', rowIndex, "leave3total"));
	   			   $('#txtselectedcellleave4totalvalue').val($('#attendanceGridID').jqxGrid('getcellvalue', rowIndex, "leave4total"));
	   			   $('#txtselectedcellleave5totalvalue').val($('#attendanceGridID').jqxGrid('getcellvalue', rowIndex, "leave5total"));
	   			   $('#txtselectedcellleave6totalvalue').val($('#attendanceGridID').jqxGrid('getcellvalue', rowIndex, "leave6total"));
	   			   $('#txtselectedcellovertimevalue').val($('#attendanceGridID').jqxGrid('getcellvalue', rowIndex, "totalovertime"));
	   			   $('#txtselectedcellholidayovertimevalue').val($('#attendanceGridID').jqxGrid('getcellvalue', rowIndex, "totalholidayovertime"));
	   			   $('#txtmonthlypayrollprocessed').val($('#attendanceGridID').jqxGrid('getcellvalue', rowIndex, "payroll_processed"));
               
             }); 
      	
	         	$("#attendanceGridID").on("cellclick", function (event) {
	         			   
	   			   var rowIndex = event.args.rowindex;
	   			   var columnIndex = event.args.columnindex;
	   			   var applytype = "";
	   			   var employeedocno = $('#attendanceGridID').jqxGrid('getcellvalue', rowIndex, "employeedocno");
	   			   $('#txtselectedemployee').val(employeedocno);
	   			   $('#txtselectedcellcolumn').val("date"+(columnIndex-2));
	   			   $('#txtselectedcellrow').val(rowIndex);
	   			   $('#txtselectedcelltextvalue').val($('#attendanceGridID').jqxGrid('getcellvalue', rowIndex, "date"+(columnIndex-2)));
	   			   if(parseInt($('#txtattendanceleaveseditgrid').val())==0){
		   			   $('#txtselectedcellleave1totalvalue').val($('#attendanceGridID').jqxGrid('getcellvalue', rowIndex, "leave1total"));
		   			   $('#txtselectedcellleave2totalvalue').val($('#attendanceGridID').jqxGrid('getcellvalue', rowIndex, "leave2total"));
		   			   $('#txtselectedcellleave3totalvalue').val($('#attendanceGridID').jqxGrid('getcellvalue', rowIndex, "leave3total"));
		   			   $('#txtselectedcellleave4totalvalue').val($('#attendanceGridID').jqxGrid('getcellvalue', rowIndex, "leave4total"));
		   			   $('#txtselectedcellleave5totalvalue').val($('#attendanceGridID').jqxGrid('getcellvalue', rowIndex, "leave5total"));
		   			   $('#txtselectedcellleave6totalvalue').val($('#attendanceGridID').jqxGrid('getcellvalue', rowIndex, "leave6total"));
	   			   }
	   			   $('#txtselectedcellovertimevalue').val($('#attendanceGridID').jqxGrid('getcellvalue', rowIndex, "totalovertime"));
	   			   $('#txtselectedcellholidayovertimevalue').val($('#attendanceGridID').jqxGrid('getcellvalue', rowIndex, "totalholidayovertime"));
	   			   $('#txtmonthlypayrollprocessed').val($('#attendanceGridID').jqxGrid('getcellvalue', rowIndex, "payroll_processed"));
	   			   
	   			   if(document.getElementById("rdovertime").checked==true){ applytype= "OVERTIME";}else if(document.getElementById("rdleavetype").checked==true){applytype= "LEAVE";}else if(document.getElementById("rdtotalleaves").checked==true){applytype= "TOTAL LEAVE";}else{applytype= "HOLIDAY";}	 
	   			   document.getElementById("savemsg").innerText="Emp. ID : "+$('#attendanceGridID').jqxGrid('getcellvalue', rowIndex, "employeeid")+" - "+$('#cmbmonth option:selected').text().slice(0,3).toUpperCase()+" "+(columnIndex-2)+" - "+applytype;
	   			   
	           });  
	         	
	         	
        });
        
        function getLeavesGridTotal(checktype){
        	var rows = $("#attendanceGridID").jqxGrid('getrows');
		    for(var i=0 ; i < rows.length ; i++){
		    	
		    var holiday=0,leave=0,leave1total=0,leave2total=0,leave3total=0,leave4total=0,leave5total=0,leave6total=0,overtime=0,holidayovertime=0;
		    var totdays = $('#attendanceGridID').jqxGrid('getcellvalue', 0, "days");
            for(var j=1;j<=parseInt(totdays);j++)
     		{
            	var value = $('#attendanceGridID').jqxGrid('getcellvalue', i, "date"+j+"");
            	
            	if(value=='H' || value=='LH'){
            		holiday=holiday+1;
            	}
            	if(value=='A' || value=='S' || value=='C' || value=='T' || value=='M' || value=='U'){
            		leave=leave+1;
            	}
            	if(value=='A2' || value=='S2' || value=='C2' || value=='T2' || value=='M2' || value=='U2'){
            		leave=leave+(0.5);
            	}
            	if(value=='S'){leave1total=leave1total+1;} 
            	if(value=='A'){leave2total=leave2total+1;}
            	if(value=='C'){leave3total=leave3total+1;}
            	if(value=='T'){leave4total=leave4total+1;}
            	if(value=='M'){leave5total=leave5total+1;}
            	if(value=='U'){leave6total=leave6total+1;}
            	if(value=='S2'){leave1total=leave1total+(0.5);} 
            	if(value=='A2'){leave2total=leave2total+(0.5);}
            	if(value=='C2'){leave3total=leave3total+(0.5);}
            	if(value=='T2'){leave4total=leave4total+(0.5);}
            	if(value=='M2'){leave5total=leave5total+(0.5);}
            	if(value=='U2'){leave6total=leave6total+(0.5);}
            	
            	if(value.indexOf(':')>0){ 
            		var weekoff = $('#txtholidaysofmonth').val();
            		var weekoff1 = weekoff.split(",");
            		var weekoffcount = (weekoff.match(/,/g) || []).length;
            		
            		var checking='0';
            		
            		for(var k=0;k<parseInt(weekoffcount);k++) {
                	
            			if(weekoff1[k]==j){
            				checking='1';
                		} 
                		
                		if(checking=='1'){
                			var value1 = value.split(":");
	                		var value2 = ((parseInt(value1[0])*60)+parseInt(value1[1]));
	                		holidayovertime=(holidayovertime+value2);
                			break;
                		}  
	         		}
            		
            		if(checking=='0'){
            			var value1 = value.split(":");
                		var value2 = ((parseInt(value1[0])*60)+parseInt(value1[1]));
                		overtime   = overtime+value2;
            		} 
            		
                }
     		}
            
            $('#attendanceGridID').jqxGrid('setcellvalue', i, "holiday",holiday);
            $('#attendanceGridID').jqxGrid('setcellvalue', i, "leave",leave);
            $('#attendanceGridID').jqxGrid('setcellvalue', i, "totalovertime",overtime);
            $('#attendanceGridID').jqxGrid('setcellvalue', i, "totalholidayovertime",holidayovertime);
            
            if(parseInt($('#txtattendanceleaveseditgrid').val())==0){
                $('#attendanceGridID').jqxGrid('setcellvalue', i, "leave1total",leave1total);
                $('#attendanceGridID').jqxGrid('setcellvalue', i, "leave2total",leave2total);
                $('#attendanceGridID').jqxGrid('setcellvalue', i, "leave3total",leave3total);
                $('#attendanceGridID').jqxGrid('setcellvalue', i, "leave4total",leave4total);
                $('#attendanceGridID').jqxGrid('setcellvalue', i, "leave5total",leave5total);
                $('#attendanceGridID').jqxGrid('setcellvalue', i, "leave6total",leave6total);
            }
		 }
					 
		if(checktype=="2"){
	
			var year = $('#cmbyear').val();
			var month = $('#cmbmonth').val();
			var recheckemptotalleavesarray="";
			var recheckemptotalleavesgridlength="0";
			var recheckrows = $("#attendanceGridID").jqxGrid('getrows');
			
			var rc=0;var temprecheckemptotalleaves="",temprecheckemptotalleaves1="";
			$('#txtrecheckemptotalleavesgridlength').val(recheckrows.length);
			for (rc = 0; rc < recheckrows.length; rc++) {
				if(rc==0){
					temprecheckemptotalleaves=recheckrows[rc].employeedocno+"::"+recheckrows[rc].leave1total+"::"+recheckrows[rc].leave2total+"::"+recheckrows[rc].leave3total+"::"+recheckrows[rc].leave4total+"::"+recheckrows[rc].leave5total+"::"+recheckrows[rc].leave6total+"::"+recheckrows[rc].totalovertime+"::"+recheckrows[rc].totalholidayovertime;
				}
				else{
					temprecheckemptotalleaves=temprecheckemptotalleaves+","+recheckrows[rc].employeedocno+"::"+recheckrows[rc].leave1total+"::"+recheckrows[rc].leave2total+"::"+recheckrows[rc].leave3total+"::"+recheckrows[rc].leave4total+"::"+recheckrows[rc].leave5total+"::"+recheckrows[rc].leave6total+"::"+recheckrows[rc].totalovertime+"::"+recheckrows[rc].totalholidayovertime;
				}
				temprecheckemptotalleaves1=temprecheckemptotalleaves+",";
			}
			$('#txtrecheckemptotalleaves').val(temprecheckemptotalleaves1);
			recheckemptotalleavesarray=$('#txtrecheckemptotalleaves').val();
			recheckemptotalleavesgridlength=$('#txtrecheckemptotalleavesgridlength').val();
			
			updateAttendanceData(year,month,recheckemptotalleavesarray,recheckemptotalleavesgridlength);
		}
	}
    </script>
    <div id="attendanceGridID"></div>
 