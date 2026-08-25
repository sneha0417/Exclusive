<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.humanresource.deductionschedule.*"%>
<%ClsDeductionScheduleDAO DAO= new ClsDeductionScheduleDAO(); %>
<% 
   String cmbtype = request.getParameter("cmbtype")==null?"2016":request.getParameter("cmbtype");
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
		var temp1='<%=check%>';
		
		var data1;
		var dataExcelExport1=[];
		
        $(document).ready(function () { 	
        	
        	if(temp1!='NA'){
        		data1='<%=DAO.deductionScheduleDetailedGridLoading(cmbtype,empId,check)%>';
        		dataExcelExport1='<%=DAO.deductionScheduleDetailedExcelExport(cmbtype,empId,check)%>';
        	 }
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'date', type: 'date' },
     						{name : 'docno', type: 'string' },
     						{name : 'refno', type: 'String' },
     						{name : 'empname', type: 'String' },
     						{name : 'empid', type: 'String' },
     						{name : 'designation', type: 'string' },
     						{name : 'description', type: 'string' },
     						{name : 'department', type: 'string' },
     						{name : 'instno', type: 'string' },
     						{name : 'startdate', type: 'date' },
     						{name : 'enddate', type: 'date' },
     						{name : 'totalamt', type: 'number' },
     						{name : 'paid', type: 'number' },
     						{name : 'balance', type: 'number' }
                        ],
                		 localdata: data1, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,{
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			         });

            
            $("#leaveDetailsDetailedGridID").jqxGrid(
            {
            	width: '98%',
                height: 518,
                source: dataAdapter,
                editable: false,
                columnsresize: true,
                filtermode:'excel',
                enabletooltips : true,
                filterable: true,
		showfilterrow: true,
                sortable :true,
                selectionmode: 'singlerow',
               // localization: {thousandsSeparator: ""},
                
                columns: [
							{ text: 'Sl No', pinned: true, sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '3%',cellsalign: 'center', align: 'center', cellclassname: 'whiteClass',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }    
							},
							{ text: 'Date', datafield: 'date', editable: false, width: '6%',cellsformat:'dd.MM.yyyy' },
							{ text: 'Doc No', datafield: 'docno', editable: false,width:'4%' },
							{ text: 'Ref No', datafield: 'refno', editable: false, width: '20%', editable: false },
							{ text: 'EmpId', datafield: 'empid', editable: false, width: '5%' },
							{ text: 'Employee', datafield: 'empname', editable: false, width: '25%', editable: false },
							{ text: 'Designation', datafield: 'designation', editable: false,  width: '20%'},
							{ text: 'Department', datafield: 'department', editable: false,  width: '20%'},
							{ text: 'InstNo.', datafield: 'instno', editable: false,  width: '4%'},
							{ text: 'Start Date', datafield: 'startdate', editable: false,  width: '6%',cellsformat:'dd.MM.yyyy' },
							{ text: 'End Date', datafield: 'enddate', editable: false,  width: '6%',cellsformat:'dd.MM.yyyy' },
							{ text: 'Amount', datafield: 'totalamt', editable: false,  width: '7%', cellsalign: 'right',cellsformat:'d2'},
							{ text: 'Paid', datafield: 'paid', editable: false,  width: '7%', cellsalign: 'right',cellsformat:'d2'},
							{ text: 'balance', datafield: 'balance', editable: false,  width: '7%', cellsalign: 'right',cellsformat:'d2'},
						    ],
            });
            $("#overlay, #PleaseWait").hide();
        });  
        		  
        
    </script>
    <div id="leaveDetailsDetailedGridID"></div>
 