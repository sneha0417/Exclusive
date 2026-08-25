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
		var temp='<%=check%>';
		
		var data;
		var dataExcelExport=[];
		
        $(document).ready(function () { 	
        	
        	if(temp!='NA'){
        		data='<%=DAO.deductionScheduleGridLoading(cmbtype,empId,check)%>';
        		dataExcelExport='<%=DAO.deductionScheduleExcelExport(cmbtype,empId,check)%>'; 
        	 }
        	
        	
        	
        	var rendererstring=function (aggregates){
    	     	var value=aggregates['sum'];
    	     	/* if(typeof(value) == "undefined" || typeof(value) == "NAN"){
               		value=0.00;
               	}
    	     	value=(parseFloat(value)/parseFloat(2)).toFixed(2); */
    	     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "" + ' ' + value + '</div>';
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
                		 localdata: data, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
       /*      $("#leaveDetailsGridID").on("bindingcomplete", function (event) {
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
             */
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
		showfilterrow: true,
                sortable :true,
                selectionmode: 'singlerow',
                enabletooltips : true,
                showaggregates:true,
                showstatusbar:true,
                statusbarheight: 20,
              //  localization: {thousandsSeparator: ""},
                
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
							{ text: 'Ref No', datafield: 'refno', editable: false, width: '22%', editable: false },
							{ text: 'Employee', datafield: 'empname', editable: false, width: '25%', editable: false },
							{ text: 'EmpId', datafield: 'empid', editable: false, width: '5%' },
							{ text: 'Designation', datafield: 'designation', editable: false,  width: '16%' },
							{ text: 'Department', datafield: 'department', editable: false,  width: '15%'},
							{ text: 'Description', datafield: 'description', editable: false,  width: '35%'},
							{ text: 'InstNo.', datafield: 'instno', editable: false,  width: '5%'},
							{ text: 'Start Date', datafield: 'startdate', editable: false,  width: '6%',cellsformat:'dd.MM.yyyy' },
							{ text: 'End Date', datafield: 'enddate', editable: false,  width: '6%',cellsformat:'dd.MM.yyyy' },
							{ text: 'Total Amount', datafield: 'totalamt', editable: false,  width: '7%', cellsalign: 'right',cellsformat:'d2',aggregates: ['sum'], aggregatesrenderer:rendererstring  },
							{ text: 'Paid', datafield: 'paid', editable: false,  width: '7%', cellsalign: 'right',cellsformat:'d2',aggregates: ['sum'], aggregatesrenderer:rendererstring  },
							{ text: 'balance', datafield: 'balance', editable: false,  width: '7%', cellsalign: 'right',cellsformat:'d2',aggregates: ['sum'], aggregatesrenderer:rendererstring  },
						
							
								],
            });
            $("#overlay, #PleaseWait").hide();
        });  
        		  
        
    </script>
    <div id="leaveDetailsGridID"></div>
 