<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.humanresource.appraisal.ClsAppraisalDAO"%>
<% ClsAppraisalDAO DAO= new ClsAppraisalDAO(); %>
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
        .whiteClass
        {
           background-color: #FFF;
        }
</style>

<script type="text/javascript">
		var temp='<%=check%>';
		
		var data;
		
        $(document).ready(function () { 	
        	
        	if(temp!='NA'){
        		data='<%=DAO.appraisalDetailsGridLoading(year,month,department,category,empId,check)%>';
        		<%-- dataExcelExport='<%=DAO.leaveDetailsExcelExport(year,month,department,category,empId,check)%>'; --%>
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
     						{name : 'basic', type: 'number' },
     						{name : 'allowance1', type: 'number'   },
     						{name : 'allowance2', type: 'number'  },
     						{name : 'allowance3', type: 'number'   },
     						{name : 'allowance4', type: 'number'   },
     						{name : 'allowance5', type: 'number' },
     						{name : 'allowance6', type: 'number'  },
							{name : 'allowance7', type: 'number' },
							{name : 'allowance8', type: 'number'  },
     						{name : 'allowance9', type: 'number' },
     						{name : 'allowance10', type: 'number' },
     						{name : 'totalsalary', type: 'number' },
     						{name : 'dtype', type: 'String' },
     						{name : 'totallowancesavailable', type: 'int' }
                        ],
                		 localdata: data, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            $("#appraisalDetailsGridID").on("bindingcomplete", function (event) {
            	var totleavesavailable = $('#appraisalDetailsGridID').jqxGrid('getcellvalue', 0, "totallowancesavailable");
            	
            	if(totleavesavailable=='1'){
					    $("#appraisalDetailsGridID").jqxGrid('hidecolumn', 'allowance2');
					    $("#appraisalDetailsGridID").jqxGrid('hidecolumn', 'allowance3');
					    $("#appraisalDetailsGridID").jqxGrid('hidecolumn', 'allowance4');
					    $("#appraisalDetailsGridID").jqxGrid('hidecolumn', 'allowance5');
					    $("#appraisalDetailsGridID").jqxGrid('hidecolumn', 'allowance6');
					    $("#appraisalDetailsGridID").jqxGrid('hidecolumn', 'allowance7');
					    $("#appraisalDetailsGridID").jqxGrid('hidecolumn', 'allowance8');
					    $("#appraisalDetailsGridID").jqxGrid('hidecolumn', 'allowance9');
					    $("#appraisalDetailsGridID").jqxGrid('hidecolumn', 'allowance10');
				 } else if(totleavesavailable=='2'){
					    $("#appraisalDetailsGridID").jqxGrid('hidecolumn', 'allowance3');
					    $("#appraisalDetailsGridID").jqxGrid('hidecolumn', 'allowance4');
					    $("#appraisalDetailsGridID").jqxGrid('hidecolumn', 'allowance5');
					    $("#appraisalDetailsGridID").jqxGrid('hidecolumn', 'allowance6');
					    $("#appraisalDetailsGridID").jqxGrid('hidecolumn', 'allowance7');
					    $("#appraisalDetailsGridID").jqxGrid('hidecolumn', 'allowance8');
					    $("#appraisalDetailsGridID").jqxGrid('hidecolumn', 'allowance9');
					    $("#appraisalDetailsGridID").jqxGrid('hidecolumn', 'allowance10');
				 } else if(totleavesavailable=='3'){
					    $("#appraisalDetailsGridID").jqxGrid('hidecolumn', 'allowance4');
					    $("#appraisalDetailsGridID").jqxGrid('hidecolumn', 'allowance5');
					    $("#appraisalDetailsGridID").jqxGrid('hidecolumn', 'allowance6');
					    $("#appraisalDetailsGridID").jqxGrid('hidecolumn', 'allowance7');
					    $("#appraisalDetailsGridID").jqxGrid('hidecolumn', 'allowance8');
					    $("#appraisalDetailsGridID").jqxGrid('hidecolumn', 'allowance9');
					    $("#appraisalDetailsGridID").jqxGrid('hidecolumn', 'allowance10');
				 } else if(totleavesavailable=='4'){
					    $("#appraisalDetailsGridID").jqxGrid('hidecolumn', 'allowance5');
					    $("#appraisalDetailsGridID").jqxGrid('hidecolumn', 'allowance6');
					    $("#appraisalDetailsGridID").jqxGrid('hidecolumn', 'allowance7');
					    $("#appraisalDetailsGridID").jqxGrid('hidecolumn', 'allowance8');
					    $("#appraisalDetailsGridID").jqxGrid('hidecolumn', 'allowance9');
					    $("#appraisalDetailsGridID").jqxGrid('hidecolumn', 'allowance10');
				 } else if(totleavesavailable=='5'){
					    $("#appraisalDetailsGridID").jqxGrid('hidecolumn', 'allowance6');
					    $("#appraisalDetailsGridID").jqxGrid('hidecolumn', 'allowance7');
					    $("#appraisalDetailsGridID").jqxGrid('hidecolumn', 'allowance8');
					    $("#appraisalDetailsGridID").jqxGrid('hidecolumn', 'allowance9');
					    $("#appraisalDetailsGridID").jqxGrid('hidecolumn', 'allowance10');
				 } else if(totleavesavailable=='6'){
					    $("#appraisalDetailsGridID").jqxGrid('hidecolumn', 'allowance7');
					    $("#appraisalDetailsGridID").jqxGrid('hidecolumn', 'allowance8');
					    $("#appraisalDetailsGridID").jqxGrid('hidecolumn', 'allowance9');
					    $("#appraisalDetailsGridID").jqxGrid('hidecolumn', 'allowance10');
				 } else if(totleavesavailable=='7'){
					    $("#appraisalDetailsGridID").jqxGrid('hidecolumn', 'allowance8');
					    $("#appraisalDetailsGridID").jqxGrid('hidecolumn', 'allowance9');
					    $("#appraisalDetailsGridID").jqxGrid('hidecolumn', 'allowance10');
				 } else if(totleavesavailable=='8'){
					    $("#appraisalDetailsGridID").jqxGrid('hidecolumn', 'allowance9');
					    $("#appraisalDetailsGridID").jqxGrid('hidecolumn', 'allowance10');
				 } else if(totleavesavailable=='9'){
					    $("#appraisalDetailsGridID").jqxGrid('hidecolumn', 'allowance10');
				 } else{
					    $("#appraisalDetailsGridID").jqxGrid('showcolumn', 'allowance1');
					    $("#appraisalDetailsGridID").jqxGrid('showcolumn', 'allowance2');
					    $("#appraisalDetailsGridID").jqxGrid('showcolumn', 'allowance3');
					    $("#appraisalDetailsGridID").jqxGrid('showcolumn', 'allowance4');
					    $("#appraisalDetailsGridID").jqxGrid('showcolumn', 'allowance5');
					    $("#appraisalDetailsGridID").jqxGrid('showcolumn', 'allowance6');
					    $("#appraisalDetailsGridID").jqxGrid('showcolumn', 'allowance7');
					    $("#appraisalDetailsGridID").jqxGrid('showcolumn', 'allowance8');
					    $("#appraisalDetailsGridID").jqxGrid('showcolumn', 'allowance9');
					    $("#appraisalDetailsGridID").jqxGrid('showcolumn', 'allowance10');
			     }
            	
            });
            
            var cellclassname = function (row, column, value, data) {
        		if (data.dtype == 'HSAP') {
                    return "redClass";
                }
                else{
                	return "whiteClass";
                };
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,{
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			         });

            
            $("#appraisalDetailsGridID").jqxGrid(
            {
            	width: '98%',
                height: 490,
                source: dataAdapter,
                editable: false,
                columnsresize: true,
                filtermode:'excel',
                filterable: true,
                sortable :true,
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Sl No', pinned: true, sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '3%',cellsalign: 'center', align: 'center', cellclassname: 'whiteClass',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }    
							},
							{ text: 'Emp. ID', datafield: 'employeeid', width: '6%',  cellclassname: cellclassname },
							{ text: 'Employee Name', datafield: 'employeename',  cellclassname: cellclassname },
							{ text: 'Designation', datafield: 'designation', width: '7%',  cellclassname: cellclassname },
							{ text: 'Department', datafield: 'department', width: '7%',  cellclassname: cellclassname },
							{ text: 'Category', datafield: 'category', width: '7%',  cellclassname: cellclassname },
							{ text: 'Basic', datafield: 'basic', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right',  cellclassname: cellclassname },
							{ text: ''+$('#txtallowancetype1').val(), datafield: 'allowance1',  width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right',  cellclassname: cellclassname  },
							{ text: ''+$('#txtallowancetype2').val(), datafield: 'allowance2',  width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right',  cellclassname: cellclassname },
							{ text: ''+$('#txtallowancetype3').val(), datafield: 'allowance3',  width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right',  cellclassname: cellclassname },
							{ text: ''+$('#txtallowancetype4').val(), datafield: 'allowance4',  width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right',  cellclassname: cellclassname },
							{ text: ''+$('#txtallowancetype5').val(), datafield: 'allowance5',  width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right',  cellclassname: cellclassname },
							{ text: ''+$('#txtallowancetype6').val(), datafield: 'allowance6',  width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right',  cellclassname: cellclassname },
							{ text: ''+$('#txtallowancetype7').val(), datafield: 'allowance7',  width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right',  cellclassname: cellclassname },
							{ text: ''+$('#txtallowancetype8').val(), datafield: 'allowance8',  width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right',  cellclassname: cellclassname },
							{ text: ''+$('#txtallowancetype9').val(), datafield: 'allowance9',  width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right',  cellclassname: cellclassname },
							{ text: ''+$('#txtallowancetype10').val(), datafield: 'allowance10',  width: '7%', cellsformat: 'd2',  cellsalign: 'right', align: 'right',  cellclassname: cellclassname },
							{ text: 'Total Salary', datafield: 'totalsalary', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right',  cellclassname: cellclassname },
							{ text: 'Dtype', datafield: 'dtype', hidden: true, width: '5%', cellsalign: 'center', align: 'center' },
							{ text: 'Total Allowances Available', datafield: 'totallowancesavailable', hidden: true, width: '5%', cellsalign: 'center', align: 'center' },
						],
            });
            $("#overlay, #PleaseWait").hide();
        });  
        		  
        
    </script>
    <div id="appraisalDetailsGridID"></div>
 