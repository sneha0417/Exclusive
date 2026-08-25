<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.humanresource.leavedetailsnew.ClsLeaveDetailsNewDAO"%>
<%ClsLeaveDetailsNewDAO DAO= new ClsLeaveDetailsNewDAO(); %>    
<% 
   String year = request.getParameter("year")==null?"2016":request.getParameter("year");
   String department = request.getParameter("department")==null?"0":request.getParameter("department");
   String category = request.getParameter("category")==null?"0":request.getParameter("category");
   String empId = request.getParameter("empId")==null?"0":request.getParameter("empId");
   String check = request.getParameter("check")==null || request.getParameter("check")==""?"0":request.getParameter("check"); %> 
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
		
		var data;
		
        $(document).ready(function () { 	
        	
        	if(parseInt(temp)!=0){    
        		data='<%=DAO.leaveDetailsGridLoading(year,department,category,empId,check)%>';
        	 }
        	
            // prepare the data
            var source =  
            {
                datatype: "json",
                datafields: [
							{name : 'empid', type: 'string' },          
							{name : 'employeeid', type: 'string' },
     						{name : 'employeename', type: 'string' },
     						{name : 'designation', type: 'String' },
     						{name : 'department', type: 'String' },
     						{name : 'category', type: 'String' },
     						{name : 'leavetotal', type: 'String' },
     						{name : 'totleavesavailable', type: 'int' },
     						{name : 'takenleave1', type: 'string' },  
     						{name : 'eligible1', type: 'string' },
     						{name : 'creditleave1', type: 'string' },
     						{name : 'balleave1', type: 'string' },
     						{name : 'openleave1', type: 'string' },  
     						{name : 'takenleave2', type: 'string' }, 
     						{name : 'eligible2', type: 'string' },
     						{name : 'creditleave2', type: 'string' },
     						{name : 'balleave2', type: 'string' },
     						{name : 'openleave2', type: 'string' }, 
     						{name : 'takenleave3', type: 'string' }, 
     						{name : 'eligible3', type: 'string' },
     						{name : 'creditleave3', type: 'string' },
     						{name : 'balleave3', type: 'string' },
     						{name : 'openleave3', type: 'string' }, 
     						{name : 'takenleave4', type: 'string' },
     						{name : 'eligible4', type: 'string' },
     						{name : 'creditleave4', type: 'string' },
     						{name : 'balleave4', type: 'string' },
     						{name : 'openleave4', type: 'string' }, 
     						{name : 'takenleave5', type: 'string' },  
     						{name : 'eligible5', type: 'string' },
     						{name : 'creditleave5', type: 'string' },
     						{name : 'balleave5', type: 'string' },
     						{name : 'openleave5', type: 'string' }, 
     						{name : 'takenleave6', type: 'string' },
     						{name : 'eligible6', type: 'string' },  
     						{name : 'creditleave6', type: 'string' },
     						{name : 'balleave6', type: 'string' },
     						{name : 'openleave6', type: 'string' }, 
     						{name : 'takenleave7', type: 'string' }, 
     						{name : 'eligible7', type: 'string' },
     						{name : 'creditleave7', type: 'string' },
     						{name : 'balleave7', type: 'string' },
     						{name : 'openleave7', type: 'string' }, 
     						{name : 'takenleave8', type: 'string' },  
     						{name : 'eligible8', type: 'string' },
     						{name : 'creditleave8', type: 'string' },
     						{name : 'balleave8', type: 'string' },
     						{name : 'openleave8', type: 'string' }, 
     						{name : 'takenleave9', type: 'string' },
     						{name : 'eligible9', type: 'string' },
     						{name : 'creditleave9', type: 'string' },
     						{name : 'balleave9', type: 'string' },
     						{name : 'openleave9', type: 'string' }, 
     						{name : 'takenleave10', type: 'string' },  
     						{name : 'eligible10', type: 'string' },
     						{name : 'creditleave10', type: 'string' },  
     						{name : 'balleave10', type: 'string' },
     						{name : 'openleave10', type: 'string' },       
                        ],
                		 localdata: data, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
          $("#leaveDetailsGridID").on("bindingcomplete", function (event) {
        	  if(parseInt(temp)!=0){
        	    var totleavesavailable = $('#leaveDetailsGridID').jqxGrid('getcellvalue', 0, "totleavesavailable");
            	if(totleavesavailable=='1'){
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'takenleave2');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'takenleave3');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'takenleave4');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'takenleave5');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'takenleave6');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'takenleave7');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'takenleave8');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'takenleave9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'takenleave10'); 
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'balleave2');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'balleave3');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'balleave4');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'balleave5');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'balleave6');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'balleave7');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'balleave8');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'balleave9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'balleave10'); 
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'openleave2');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'openleave3');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'openleave4');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'openleave5');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'openleave6');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'openleave7');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'openleave8');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'openleave9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'openleave10'); 
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'eligible2');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'eligible3');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'eligible4');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'eligible5');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'eligible6');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'eligible7');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'eligible8');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'eligible9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'eligible10');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'creditleave2');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'creditleave3');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'creditleave4');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'creditleave5');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'creditleave6');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'creditleave7');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'creditleave8');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'creditleave9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'creditleave10');
				 } else if(totleavesavailable=='2'){
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'takenleave3');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'takenleave4');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'takenleave5');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'takenleave6');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'takenleave7');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'takenleave8');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'takenleave9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'takenleave10'); 
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'balleave3');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'balleave4');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'balleave5');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'balleave6');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'balleave7');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'balleave8');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'balleave9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'balleave10'); 
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'openleave3');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'openleave4');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'openleave5');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'openleave6');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'openleave7');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'openleave8');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'openleave9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'openleave10'); 
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'eligible3');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'eligible4');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'eligible5');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'eligible6');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'eligible7');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'eligible8');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'eligible9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'eligible10');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'creditleave3');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'creditleave4');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'creditleave5');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'creditleave6');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'creditleave7');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'creditleave8');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'creditleave9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'creditleave10');
				 } else if(totleavesavailable=='3'){
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'takenleave4');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'takenleave5');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'takenleave6');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'takenleave7');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'takenleave8');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'takenleave9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'takenleave10'); 
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'balleave4');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'balleave5');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'balleave6');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'balleave7');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'balleave8');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'balleave9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'balleave10'); 
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'openleave4');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'openleave5');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'openleave6');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'openleave7');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'openleave8');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'openleave9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'openleave10'); 
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'eligible4');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'eligible5');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'eligible6');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'eligible7');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'eligible8');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'eligible9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'eligible10');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'creditleave4');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'creditleave5');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'creditleave6');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'creditleave7');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'creditleave8');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'creditleave9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'creditleave10');
				 } else if(totleavesavailable=='4'){
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'takenleave5');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'takenleave6');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'takenleave7');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'takenleave8');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'takenleave9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'takenleave10'); 
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'balleave5');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'balleave6');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'balleave7');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'balleave8');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'balleave9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'balleave10'); 
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'openleave5');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'openleave6');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'openleave7');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'openleave8');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'openleave9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'openleave10'); 
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'eligible5');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'eligible6');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'eligible7');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'eligible8');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'eligible9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'eligible10');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'creditleave5');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'creditleave6');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'creditleave7');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'creditleave8');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'creditleave9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'creditleave10');
				 } else if(totleavesavailable=='5'){
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'takenleave6');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'takenleave7');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'takenleave8');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'takenleave9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'takenleave10'); 
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'balleave6');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'balleave7');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'balleave8');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'balleave9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'balleave10'); 
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'openleave6');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'openleave7');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'openleave8');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'openleave9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'openleave10'); 
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'eligible6');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'eligible7');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'eligible8');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'eligible9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'eligible10');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'creditleave6');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'creditleave7');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'creditleave8');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'creditleave9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'creditleave10');
				 } else if(totleavesavailable=='6'){
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'takenleave7');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'takenleave8');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'takenleave9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'takenleave10'); 
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'balleave7');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'balleave8');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'balleave9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'balleave10'); 
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'openleave7');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'openleave8');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'openleave9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'openleave10'); 
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'eligible7');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'eligible8');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'eligible9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'eligible10');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'creditleave7');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'creditleave8');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'creditleave9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'creditleave10');
				 } else if(totleavesavailable=='7'){
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'takenleave8');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'takenleave9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'takenleave10'); 
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'balleave8');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'balleave9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'balleave10'); 
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'openleave8');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'openleave9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'openleave10'); 
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'eligible8');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'eligible9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'eligible10');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'creditleave8');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'creditleave9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'creditleave10');
				 } else if(totleavesavailable=='8'){
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'takenleave9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'takenleave10'); 
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'balleave9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'balleave10'); 
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'openleave9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'openleave10'); 
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'eligible9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'eligible10');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'creditleave9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'creditleave10');
				 } else if(totleavesavailable=='9'){
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'takenleave10'); 
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'balleave10'); 
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'openleave10'); 
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'eligible10');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'creditleave10');     
				 } else{
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'takenleave1');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'takenleave2');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'takenleave3');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'takenleave4');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'takenleave5');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'takenleave6');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'takenleave7');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'takenleave8');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'takenleave9');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'takenleave10');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'balleave1');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'balleave2');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'balleave3');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'balleave4');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'balleave5');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'balleave6');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'balleave7');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'balleave8');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'balleave9');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'balleave10'); 
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'openleave1');  
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'openleave2');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'openleave3');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'openleave4');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'openleave5');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'openleave6');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'openleave7');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'openleave8');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'openleave9');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'openleave10');  
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'eligible1');  
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'eligible2');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'eligible3');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'eligible4');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'eligible5');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'eligible6');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'eligible7');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'eligible8');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'eligible9');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'eligible10'); 
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'creditleave1');    
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'creditleave2');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'creditleave3');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'creditleave4');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'creditleave5');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'creditleave6');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'creditleave7');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'creditleave8');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'creditleave9');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'creditleave10');
			     }
        	  }            	
            });
            
            var dataAdapter = new $.jqx.dataAdapter(source,{
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			         });

            
            $("#leaveDetailsGridID").jqxGrid(
            {
            	width: '98%',
                height: 518,
                source: dataAdapter,
                editable: true,
                enabletooltips: true,
                columnsresize: true,
                filterable: true,
                showfilterrow:true,
                sortable :true,
                selectionmode: 'singlerow',
                localization: {thousandsSeparator: ""},    
                
                columns: [
							{ text: 'Sl No', pinned: true, sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '3%',cellsalign: 'center', align: 'center', cellclassname: 'whiteClass',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }    
							},
							{ text: 'Emp. docno', datafield: 'empid', editable: false, width: '6%',hidden:true },
							{ text: 'Emp. ID', datafield: 'employeeid', editable: false, width: '6%' },
							{ text: 'Employee Name', datafield: 'employeename', editable: false, width: '16%'  },   
							{ text: 'Designation', datafield: 'designation', editable: false, width: '7%', editable: false },
							{ text: 'Department', datafield: 'department', editable: false, width: '7%', editable: false },
							{ text: 'Category', datafield: 'category', editable: false, width: '7%' },     
							
							{ text: 'Opening Leave', datafield: 'openleave1', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv1' },
							{ text: 'Eligible', datafield: 'eligible1', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv1' },
							{ text: 'Taken', datafield: 'takenleave1', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv1' },
							{ text: 'Credit Leave', datafield: 'creditleave1', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv1' },
							{ text: 'Balance', datafield: 'balleave1', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv1' },
							
							{ text: 'Opening Leave', datafield: 'openleave2', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv2' },
							{ text: 'Eligible', datafield: 'eligible2', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv2' },
							{ text: 'Taken', datafield: 'takenleave2', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv2' },
							{ text: 'Credit Leave', datafield: 'creditleave2', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv2' },
							{ text: 'Balance', datafield: 'balleave2', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv2' },
							
							{ text: 'Opening Leave', datafield: 'openleave3', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv3' },
							{ text: 'Eligible', datafield: 'eligible3', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv3' },
							{ text: 'Taken', datafield: 'takenleave3', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv3' },
							{ text: 'Credit Leave', datafield: 'creditleave3', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv3' },
							{ text: 'Balance', datafield: 'balleave3', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv3' },
							
							{ text: 'Opening Leave', datafield: 'openleave4', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv4' },
							{ text: 'Eligible', datafield: 'eligible4', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv4' },
							{ text: 'Taken', datafield: 'takenleave4', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv4' },
							{ text: 'Credit Leave', datafield: 'creditleave4', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv4' },
							{ text: 'Balance', datafield: 'balleave4', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv4' },
							
							{ text: 'Opening Leave', datafield: 'openleave5', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv5' },
							{ text: 'Eligible', datafield: 'eligible5', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv5' },
							{ text: 'Taken', datafield: 'takenleave5', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv5' },
							{ text: 'Credit Leave', datafield: 'creditleave5', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv5' },
							{ text: 'Balance', datafield: 'balleave5', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv5' },
							
							{ text: 'Opening Leave', datafield: 'openleave6', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv6' },
							{ text: 'Eligible', datafield: 'eligible6', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv6' },
							{ text: 'Taken', datafield: 'takenleave6', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv6' },
							{ text: 'Credit Leave', datafield: 'creditleave6', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv6' },
							{ text: 'Balance', datafield: 'balleave6', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv6' },
							
							{ text: 'Opening Leave', datafield: 'openleave7', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv7' },
							{ text: 'Eligible', datafield: 'eligible7', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv7' },
							{ text: 'Taken', datafield: 'takenleave7', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv7' },
							{ text: 'Credit Leave', datafield: 'creditleave7', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv7' },
							{ text: 'Balance', datafield: 'balleave7', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv7' },
							
							{ text: 'Opening Leave', datafield: 'openleave8', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv8' },
							{ text: 'Eligible', datafield: 'eligible8', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv8' },
							{ text: 'Taken', datafield: 'takenleave8', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv8' },
							{ text: 'Credit Leave', datafield: 'creditleave8', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv8' },
							{ text: 'Balance', datafield: 'balleave8', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv8' },
							
							{ text: 'Opening Leave', datafield: 'openleave9', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv9' },
							{ text: 'Eligible', datafield: 'eligible9', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv9' },
							{ text: 'Taken', datafield: 'takenleave9', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv9' },
							{ text: 'Credit Leave', datafield: 'creditleave9', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv9' },
							{ text: 'Balance', datafield: 'balleave9', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv9' },
							
							{ text: 'Opening Leave', datafield: 'openleave10', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv10' },
							{ text: 'Eligible', datafield: 'eligible10', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv10' },
							{ text: 'Taken', datafield: 'takenleave10', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv10' },
							{ text: 'Credit Leave', datafield: 'creditleave10', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv10' },
							{ text: 'Balance', datafield: 'balleave10', editable: false, width: '7%', cellsalign: 'center', align: 'center',columngroup:'lv10' },    
							
							{ text: 'Total', datafield: 'leavetotal', editable: false, width: '5%', editable: false, cellsalign: 'center', align: 'center' },
							{ text: 'Total Leave Available', datafield: 'totleavesavailable', editable: false, hidden: true, width: '5%', cellsalign: 'center', align: 'center' },
						],
						columngroups: [     
							{ text: ''+$('#txtleavename1').val(), name: 'lv1',  align: 'center'},
							{ text: ''+$('#txtleavename2').val(), name: 'lv2',  align: 'center'},
							{ text: ''+$('#txtleavename3').val(), name: 'lv3',  align: 'center'},
							{ text: ''+$('#txtleavename4').val(), name: 'lv4',  align: 'center'},
							{ text: ''+$('#txtleavename5').val(), name: 'lv5',  align: 'center'},
							{ text: ''+$('#txtleavename6').val(), name: 'lv6',  align: 'center'},
							{ text: ''+$('#txtleavename7').val(), name: 'lv7',  align: 'center'},
							{ text: ''+$('#txtleavename8').val(), name: 'lv8',  align: 'center'},
							{ text: ''+$('#txtleavename9').val(), name: 'lv9',  align: 'center'},
							{ text: ''+$('#txtleavename10').val(), name: 'lv10',  align: 'center'},        
                    ],
            });
            $("#overlay, #PleaseWait").hide();
            $('#leaveDetailsGridID').on('rowdoubleclick', function (event) {
          		 var rowIndex = event.args.rowindex;
          		 $("#hidempdocno").val($('#leaveDetailsGridID').jqxGrid('getcellvalue',rowIndex, "empid")); 
          		 document.getElementById("hidlabel").innerHTML=$('#leaveDetailsGridID').jqxGrid('getcellvalue',rowIndex, "employeeid")+" - "+$('#leaveDetailsGridID').jqxGrid('getcellvalue',rowIndex, "employeename"); 
          	});       
        });  
        		  
        
    </script>
    <div id="leaveDetailsGridID"></div>
 