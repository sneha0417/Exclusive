<%@page import="com.dashboard.realestate.maintenancemanagement.ClsMaintenanceManagementDAO"%>
<% ClsMaintenanceManagementDAO DAO= new ClsMaintenanceManagementDAO();   %> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %> 
<%
 int rowindex =request.getParameter("rowindex")==null?0:Integer.parseInt(request.getParameter("rowindex").trim()); 
%>

 <script type="text/javascript">
	var cadata;  
	var rowindex1 = '<%=rowindex%>'; 
	vdata='<%=DAO.vendorSearch(session) %>';
	
    $(document).ready(function () { 
      
		var num = 0; 
		var source = 
		{
			datatype: "json",
			datafields: [
						{name : 'accname', type: 'String'  },  
						{name : 'acno', type: 'String'  },
						{name : 'doc_no', type: 'int'  } 
						],
						localdata: vdata,
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
		$("#jqxvendorSearch").jqxGrid(
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
						  datafield: '', columntype: 'number', width: '4%',
						  cellsrenderer: function (row, column, value) {
							  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						  }
				},
				{ text: 'Acc No', datafield: 'acno', width: '16%' },
				{ text: 'Vendor', datafield: 'accname', width: '78%' }, 
				{ text: 'doc_no', datafield: 'doc_no', width: '2%' ,hidden:true},
			] 
		});
	   $('#jqxvendorSearch').on('rowdoubleclick', function (event) 
		{ 
			var rowindex2=event.args.rowindex;		
			$('#jqxRequestGrid').jqxGrid('setcellvalue', rowindex1, "vendor_acno",$('#jqxvendorSearch').jqxGrid('getcellvalue', rowindex2, "acno"));				
			$('#jqxRequestGrid').jqxGrid('setcellvalue', rowindex1, "vendor_name",$('#jqxvendorSearch').jqxGrid('getcellvalue', rowindex2, "accname"));		
			$('#jqxRequestGrid').jqxGrid('setcellvalue', rowindex1, "vendor_docno",$('#jqxvendorSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
			$('#vendoracwindow').jqxWindow('close');  
		});    	     
	}); 
    </script>
    <div id="jqxvendorSearch"></div>
    </body>
</html>