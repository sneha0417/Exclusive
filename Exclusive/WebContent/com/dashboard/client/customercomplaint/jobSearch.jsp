<%@ page import="com.dashboard.client.customercomplaint.ClsCustomerComplaintDAO" %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %> 
<% ClsCustomerComplaintDAO DAO=new ClsCustomerComplaintDAO();%>

 <script type="text/javascript">
	var cadata;

	cadata='<%=DAO.jobSearch(session) %>';
	
    $(document).ready(function () { 
      
		var num = 0; 
		var source = 
		{
			datatype: "json",
			datafields: [
						{name : 'doc_no', type: 'int'  },
						{name : 'job_desc', type: 'String'  } 
						],
						localdata: cadata,
					  //	 url: url1, 
			 
			pager: function (pagenum, pagesize, oldpagenum) {
			   
			}
		};
		
		var dataAdapter = new $.jqx.dataAdapter(source,
				 {
					loadError: function (xhr, status, error) {
					alert(error);    
					}
				}		
		);
		$("#jqxjobSearch").jqxGrid(
		{
			width: '100%',
			height: 400,
			source: dataAdapter,
			columnsresize: true,
			selectionmode: 'singlerow',
			showfilterrow:true,
			filterable:true,
			columns: [
				{ text: 'SL#', sortable: false, filterable: false, editable: false,
						  groupable: false, draggable: false, resizable: false,
						  datafield: '', columntype: 'number', width: '5%',
						  cellsrenderer: function (row, column, value) {
							  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						  }
				}, 
				{ text: 'Job', datafield: 'job_desc', width: '95%' }, 
				{ text: 'doc_no', datafield: 'doc_no',hidden:true},
			] 
		});
	   $('#jqxjobSearch').on('rowdoubleclick', function (event) 
		{ 
			var rowindex2=event.args.rowindex;
			   $('#cmbjob').val($('#jqxjobSearch').jqxGrid('getcellvalue', rowindex2, "job_desc"));
			   $('#hidcmbjob').val($('#jqxjobSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
			    	
			$('#jobsearchwindow').jqxWindow('close');  
		});    	     
	}); 
    </script>
    <div id="jqxjobSearch"></div>
    </body>
</html>