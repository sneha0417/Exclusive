<%@page import="com.dashboard.projectexecution.easycallregisterfollowup.ClsCallRegisterFollowupDAO"%> 
<% ClsCallRegisterFollowupDAO DAO=new ClsCallRegisterFollowupDAO(); %>
<% 
   String branch =request.getParameter("branchval")==null?"0":request.getParameter("branchval").toString().trim();
   String todate = request.getParameter("date")==null?"0":request.getParameter("date").toString().trim(); 
   int check =request.getParameter("check")==null?0:Integer.parseInt(request.getParameter("check").toString());
   String clientid =request.getParameter("clientid")==null?"0":request.getParameter("clientid").toString();
   String assignstatus =request.getParameter("assignstatus")==null?"0":request.getParameter("assignstatus").toString();
%>
<style type="text/css">
.redClass {
	background-color: #FFEBEB;
}

.greenClass {
	background-color: #DAF7A6;
}

.violetClass {
	background-color: #D59FFD;
}
</style>        
<script type="text/javascript">
var data,dataexcel;
            data= '<%= DAO.detailgrid(session,todate,branch,clientid,assignstatus,check) %>';
        	dataexcel= '<%= DAO.detailExcel(session,todate,branch,clientid,assignstatus,check) %>';
        $(document).ready(function () { 	
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'tr_no', type: 'String'  },
							{name : 'cregno', type: 'String'  },
							{name : 'date', type: 'date' },
							{name : 'user', type: 'String'  },
							
     						{name : 'status', type: 'String' },
     						{name : 'statusid', type: 'String' },
     						
     						{name : 'assigngrp', type: 'String' },
     						{name : 'grpid', type: 'String' },
     						
     						{name : 'assignmembr', type: 'String' },
     						{name : 'grpempid', type: 'String' },
     						
     						{name : 'type', type: 'String' },
     						{name : 'typeid', type: 'String' },
     						{name : 'remarks', type: 'String' },
     						{name : 'repeated', type: 'String' },
     						{name : 'vehicle', type: 'String' },
     						{name : 'client', type: 'String' },
     						{name : 'callby', type: 'String' },
     						{name : 'mob', type: 'String' },
     						{name : 'brhid', type: 'String' },
     						{name : 'tottime', type: 'String' },
     						{name : 'overdue', type: 'String' }
                 ],
                 localdata: data,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
          var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
          var cellclassname = function (row, column, value, data) {
          	
          	
        		 if (data.overdue!=0) {
                    return "violetClass";
                };
               
            };
            $("#jqxloaddataGrid").jqxGrid(
            {
                width: '99.5%',
                height: 390,
                source: dataAdapter,
                columnsresize: true,
                sortable: true,
                selectionmode: 'singlerow',
                filtermode:'excel',
		        showfilterrow: true,
                filterable: true,
                //pagermode: 'default',
                sortable: true,
                enabletooltips:true,
                //Add row method
                columns: [
                     { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '4%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },
					{ text: 'trno',width: '8%', datafield: 'tr_no', hidden : true ,cellclassname:cellclassname },
                    { text: 'CREG NO',width: '6%', datafield: 'cregno' ,cellclassname:cellclassname },
                    { text: 'DATE',width: '6%', datafield: 'date',cellsformat:'dd.MM.yyyy',cellclassname:cellclassname },
                    { text: 'STATUS',width: '10%', datafield: 'status',cellclassname:cellclassname },
                    { text: 'VEHICLE',width: '20%', datafield: 'vehicle',cellclassname:cellclassname },
                    { text: 'CLIENT',width: '20%', datafield: 'client',cellclassname:cellclassname },
                    { text: 'CALLED BY',width: '12%', datafield: 'callby',cellclassname:cellclassname },
                    { text: 'statusid',width: '10%', datafield: 'statusid', hidden : true },
                    { text: 'brhId',width: '8%', datafield: 'brhid', hidden : true},
                    { text: 'MOBILE NO',width: '9%', datafield: 'mob',cellclassname:cellclassname }, 
                    { text: 'REMARKS',width: '20%', datafield: 'remarks',cellclassname:cellclassname },
                    { text: 'REPEATED',width: '8%', datafield: 'repeated',cellclassname:cellclassname },
                    { text: 'TYPE',width: '8%', datafield: 'type',cellclassname:cellclassname },
                    { text: 'TYPEID',width: '8%', datafield: 'typeid', hidden : true,cellclassname:cellclassname },
                    { text: 'ASSIGN GROUP',width: '14%', datafield: 'assigngrp',cellclassname:cellclassname },
                    { text: 'grpid',width: '10%', datafield: 'grpid', hidden : true },
                    { text: 'ASSIGN MEMBER',width: '15%', datafield: 'assignmembr',cellclassname:cellclassname },
                    { text: 'grpempid',width: '10%', datafield: 'grpempid', hidden : true },
                    { text: 'USER',width: '17%', datafield: 'user',cellclassname:cellclassname },
                    { text: 'Total time',width: '7%', datafield: 'tottime' , cellsalign:"right",cellclassname:cellclassname },
                    { text: 'Overdue',width: '7%', datafield: 'overdue' , cellsalign:"right" ,cellclassname:cellclassname },
                    
                  ]
            });
            $('#jqxloaddataGrid').on('rowdoubleclick', function (event) 
            		{ 
            	
            		    var rowindex = event.args.rowindex;
            		     $("#hidtypeid").val($('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex, "typeid"));
            		     
            		     $("#txtgroup").val($('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex, "assigngrp"));
            		     $("#txtgrpmember").val($('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex, "assignmembr"));
            		     $("#txtstatus").val($('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex, "status"));
            		     
            		     $("#groupid").val($('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex, "grpid"));
            		     $("#grpmemberid").val($('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex, "grpempid"));
            		     $("#txtstatusid").val($('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex, "statusid"));
            		     $("#hidstatusid").val($('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex, "statusid"));
            		     
            		     $("#trno").val($('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex, "tr_no"));
            		     $("#assignSubDiv").load("assignSubGrid.jsp?docno="+$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex, "tr_no")+"&brchid="+$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex, "brhid"));
            		     $("#assignDiv input").attr('disabled', false);
            		     $("#assignDiv button").attr('disabled', false);
            		});  
            
        });
        
    </script>
<div id="jqxloaddataGrid"></div>
