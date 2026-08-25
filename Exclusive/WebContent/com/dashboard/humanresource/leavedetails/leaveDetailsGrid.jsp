<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.humanresource.leavedetails.ClsLeaveDetailsDAO"%>
<%ClsLeaveDetailsDAO DAO= new ClsLeaveDetailsDAO(); %>
<% 
   String year = request.getParameter("year")==null?"2016":request.getParameter("year");
   String month = request.getParameter("month")==null?"01":request.getParameter("month");
   String department = request.getParameter("department")==null?"0":request.getParameter("department");
   String category = request.getParameter("category")==null?"0":request.getParameter("category");
   String empId = request.getParameter("empId")==null?"0":request.getParameter("empId");
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
		
		var data;
		
        $(document).ready(function () { 	
        	
        	if(temp!='NA'){
        		data='<%=DAO.leaveDetailsGridLoading(year,month,department,category,empId,check)%>';
        		dataExcelExport='<%=DAO.leaveDetailsExcelExport(year,month,department,category,empId,check)%>'; 
        	 }
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'employeeid', type: 'string' },
     						{name : 'employeename', type: 'string' },
     						{name : 'designation', type: 'String' },
     						{name : 'department', type: 'String' },
     						{name : 'category', type: 'String' },
     						{name : 'leave1', type: 'string' },
     						{name : 'leave2', type: 'string' },
     						{name : 'leave3', type: 'string' },
     						{name : 'leave4', type: 'string' },
     						{name : 'leave5', type: 'string' },
     						{name : 'leave6', type: 'string' },
     						{name : 'leave7', type: 'string' },
     						{name : 'leave8', type: 'string' },
     						{name : 'leave9', type: 'string' },
     						{name : 'leave10', type: 'string' },
     						{name : 'leavetotal', type: 'String' },
     						{name : 'totleavesavailable', type: 'int' }
                        ],
                		 localdata: data, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            $("#leaveDetailsGridID").on("bindingcomplete", function (event) {
            	var totleavesavailable = $('#leaveDetailsGridID').jqxGrid('getcellvalue', 0, "totleavesavailable");
            	
            	if(totleavesavailable=='1'){
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'leave2');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'leave3');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'leave4');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'leave5');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'leave6');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'leave7');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'leave8');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'leave9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'leave10');
				 } else if(totleavesavailable=='2'){
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'leave3');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'leave4');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'leave5');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'leave6');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'leave7');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'leave8');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'leave9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'leave10');
				 } else if(totleavesavailable=='3'){
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'leave4');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'leave5');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'leave6');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'leave7');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'leave8');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'leave9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'leave10');
				 } else if(totleavesavailable=='4'){
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'leave5');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'leave6');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'leave7');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'leave8');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'leave9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'leave10');
				 } else if(totleavesavailable=='5'){
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'leave6');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'leave7');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'leave8');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'leave9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'leave10');
				 } else if(totleavesavailable=='6'){
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'leave7');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'leave8');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'leave9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'leave10');
				 } else if(totleavesavailable=='7'){
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'leave8');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'leave9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'leave10');
				 } else if(totleavesavailable=='8'){
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'leave9');
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'leave10');
				 } else if(totleavesavailable=='9'){
					    $("#leaveDetailsGridID").jqxGrid('hidecolumn', 'leave10');
				 } else{
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'leave1');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'leave2');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'leave3');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'leave4');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'leave5');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'leave6');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'leave7');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'leave8');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'leave9');
					    $("#leaveDetailsGridID").jqxGrid('showcolumn', 'leave10');
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
                columnsresize: true,
                filtermode:'excel',
                filterable: true,
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
							{ text: 'Emp. ID', datafield: 'employeeid', editable: false, width: '6%' },
							{ text: 'Employee Name', datafield: 'employeename', editable: false },
							{ text: 'Designation', datafield: 'designation', editable: false, width: '7%', editable: false },
							{ text: 'Department', datafield: 'department', editable: false, width: '7%', editable: false },
							{ text: 'Category', datafield: 'category', editable: false, width: '7%' },
							{ text: ''+$('#txtleavename1').val(), datafield: 'leave1', editable: false,  width: '7%', cellsalign: 'center', align: 'center'  },
							{ text: ''+$('#txtleavename2').val(), datafield: 'leave2', editable: false,  width: '7%', cellsalign: 'center', align: 'center' },
							{ text: ''+$('#txtleavename3').val(), datafield: 'leave3', editable: false,  width: '7%', cellsalign: 'center', align: 'center' },
							{ text: ''+$('#txtleavename4').val(), datafield: 'leave4', editable: false,  width: '7%', cellsalign: 'center', align: 'center' },
							{ text: ''+$('#txtleavename5').val(), datafield: 'leave5', editable: false,  width: '7%', cellsalign: 'center', align: 'center' },
							{ text: ''+$('#txtleavename6').val(), datafield: 'leave6', editable: false,  width: '7%', cellsalign: 'center', align: 'center' },
							{ text: ''+$('#txtleavename7').val(), datafield: 'leave7', editable: false,  width: '7%', cellsalign: 'center', align: 'center' },
							{ text: ''+$('#txtleavename8').val(), datafield: 'leave8', editable: false,  width: '7%', cellsalign: 'center', align: 'center' },
							{ text: ''+$('#txtleavename9').val(), datafield: 'leave9', editable: false,  width: '7%', cellsalign: 'center', align: 'center' },
							{ text: ''+$('#txtleavename10').val(), datafield: 'leave10', editable: false,  width: '7%',  cellsalign: 'center', align: 'center' },
							{ text: 'Total', datafield: 'leavetotal', editable: false, width: '5%', editable: false, cellsalign: 'center', align: 'center' },
							{ text: 'Total Leave Available', datafield: 'totleavesavailable', editable: false, hidden: true, width: '5%', cellsalign: 'center', align: 'center' },
							
								],
            });
            $("#overlay, #PleaseWait").hide();
        });  
        		  
        
    </script>
    <div id="leaveDetailsGridID"></div>
 