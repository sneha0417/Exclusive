<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.realestate.maintenancemanagement.ClsMaintenanceManagementDAO"%>
<% ClsMaintenanceManagementDAO DAO= new ClsMaintenanceManagementDAO();   %>    
<%   
	String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
    String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
    String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();   
%>

<script type="text/javascript">
       var msdata;
	   	msdata='<%=DAO.mstatusData(fromdate,todate,id)%>';        

$(document).ready(function () {
	
    // prepare the data
    var source =
    {   
        datatype: "json",
        datafields: [   
							{name : 'status', type: 'String'  },
							{name : 'count', type: 'String'  },
							{name : 'statusid', type: 'String'  },
						],
				    localdata: msdata,   
        
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
    
    $("#jqxmsgrid").jqxGrid(
    {
        width: '100%',
        height: 240,       
        source: dataAdapter,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        columnsresize: true,
       	selectionmode: 'singlerow',                 
       	showfilterrow: true,
        sortable:true,                                
        pagermode: 'default',   
        editable:false,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '4%' ,
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },
               { text: 'Status', datafield: 'status'},  
               { text: 'Status ID', datafield: 'statusid',hidden:true},           
               { text: 'Count', datafield: 'count',  width: '9%',cellsalign:'right',align:'right'},  
    ]		 
    });
    $("#overlay, #PleaseWait").hide();    
});
</script>
<div id="jqxmsgrid"></div>