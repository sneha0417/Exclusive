<%@page import="com.humanresource.transactions.leaveopening.ClsLeaveOpeningDAO"%>
<% ClsLeaveOpeningDAO DAO= new ClsLeaveOpeningDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<% String docNo = request.getParameter("docno")==null?"0":request.getParameter("docno");%> 
<script type="text/javascript">
		 var data;  
        $(document).ready(function () { 
           
            var temp='<%=docNo%>';
             
             if(temp>0){   
            	  data='<%=DAO.leaveOpeningGridReloading(docNo)%>';      
           	 }
                                
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'employeedocno', type: 'int' },
                            {name : 'employeeid', type: 'string' },
     						{name : 'employeename', type: 'string' }, 
     						{name : 'leaveid', type: 'int' },
     						{name : 'leave', type: 'string' },
     						{name : 'opnleaves', type: 'number' }
                        ],
                         localdata: data,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
       
             var dataAdapter = new $.jqx.dataAdapter(source,{
           		loadError: function (xhr, status, error) {
                   alert(error);    
                   }
		         });
            
            $("#leaveOpeningGridID").jqxGrid(
            {
                width: '98%',
                height: 450,
                source: dataAdapter,
                editable: true,
                showaggregates: true,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                
 				handlekeyboardnavigation: function (event) {
                	
                    //Search Pop-Up
                    var cell1 = $('#leaveOpeningGridID').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'employeeid') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {    
                        	EmployeeSearchContent('employeeDetailsSearch.jsp'); 
                          }
                    }
                    
                    var cell2 = $('#leaveOpeningGridID').jqxGrid('getselectedcell');
                    if (cell2 != undefined && cell2.datafield == 'leave') {
                    	var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {    
                        	LaeaveSearchContent('leaveSearchGrid.jsp');
                          }
                    	}
                },
                
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              columngroup:'Blank', cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Doc No', datafield: 'employeedocno', hidden: true,  width: '5%' },
							{ text: 'Employee ID', datafield: 'employeeid',  editable: false, width: '20%' },	
							{ text: 'Employee', datafield: 'employeename',  editable: false, width: '35%' },	
							{ text: 'LeaveID', datafield: 'leaveid', hidden: true, width: '7%' },	
							{ text: 'Leave', datafield: 'leave',  editable: false, width: '20%' },
							{ text: 'Opening Leave', datafield: 'opnleaves', width: '20%' },
						]
            });
            
            //Add empty row
            if(temp==0){   
         	   $("#leaveOpeningGridID").jqxGrid('addrow', null, {});
          	 }
         	  
            if($('#mode').val()=="view"){
            	$("#leaveOpeningGridID").jqxGrid('disabled', true);
            }
            
            $('#leaveOpeningGridID').on('celldoubleclick', function (event) {
            	 
          	     if(event.args.columnindex == 2) {
          			var rowindextemp = event.args.rowindex;
          			$('#rowindex').val(rowindextemp);
          			EmployeeSearchContent('employeeDetailsSearch.jsp'); 
                 } 
          	  
          	     if(event.args.columnindex == 5) {
          			var rowindextemp = event.args.rowindex;
          			$('#rowindex').val(rowindextemp);
                    LaeaveSearchContent('leaveSearchGrid.jsp');
                 } 
                 
                 if(event.args.columnindex == 0) {
	       			var rowindexestemp = event.args.rowindex;
	       			$('#leaveOpeningGridID').jqxGrid('setcellvalue', rowindexestemp, "employeedocno" ,'');
	       			$('#leaveOpeningGridID').jqxGrid('setcellvalue', rowindexestemp, "employeeid" ,'');	
	   	   			$('#leaveOpeningGridID').jqxGrid('setcellvalue', rowindexestemp, "employeename" ,'');
	   	   			$('#leaveOpeningGridID').jqxGrid('setcellvalue', rowindexestemp, "leaveid" ,'');
	   	   			$('#leaveOpeningGridID').jqxGrid('setcellvalue', rowindexestemp, "leave" ,'');
	   	   			$('#leaveOpeningGridID').jqxGrid('setcellvalue', rowindexestemp, "opnleaves" ,'');
                 }
              });
     
});
        
</script>
<div id="leaveOpeningGridID"></div>
<input type="hidden" id="rowindex"/> 