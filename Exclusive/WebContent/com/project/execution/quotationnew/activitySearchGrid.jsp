<%@page import="com.project.execution.serviceReport.ClsServiceReportDAO"%>
<% ClsServiceReportDAO DAO= new ClsServiceReportDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String activity = request.getParameter("activity")==null?"0":request.getParameter("activity");
   String check = request.getParameter("check")==null?"0":request.getParameter("check"); %>
<script type="text/javascript">
        
        var data3= '<%=DAO.activityGridSearchLoading(activity,check)%>';  
        $(document).ready(function () { 
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'activity', type: 'string'   },
     						{name : 'docno', type: 'int'   }
                        ],
                		 localdata: data3,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#activityDetailsSearch").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Activity', datafield: 'activity', width: '100%' },
							{ text: 'Doc No',  datafield: 'docno', hidden: true, width: '5%' },
						]
            });
            
             $('#activityDetailsSearch').on('rowdoubleclick', function (event) {
            	 var rowindex1 =$('#rowindex').val();
            	 var rowindex2 = event.args.rowindex;
                 $('#activityDetailsGridID').jqxGrid('setcellvalue', rowindex1, "activity" ,$('#activityDetailsSearch').jqxGrid('getcellvalue', rowindex2, "activity"));
	             $('#activityDetailsGridID').jqxGrid('setcellvalue', rowindex1, "activityid" ,$('#activityDetailsSearch').jqxGrid('getcellvalue', rowindex2, "docno"));
    	       	
            	$('#activityGridWindow').jqxWindow('close'); 
            });  
        });
 
</script>
<div id="activityDetailsSearch"></div>
 