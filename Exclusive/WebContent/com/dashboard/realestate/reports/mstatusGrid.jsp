<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.realestate.reports.ClsReportsDAO"%>
<% ClsReportsDAO DAO= new ClsReportsDAO(); %>
<%   
	String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
%>

<script type="text/javascript">
       var msdata;
	   	msdata='<%=DAO.mstatusData(id)%>';      

$(document).ready(function () {
	
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
							{name : 'status', type: 'String'  },
							{name : 'count', type: 'number'  },
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
               { text: 'Count', datafield: 'count',  width: '9%',cellsalign:'right',align:'right',cellsformat:'d2'},  
    ]		 
    });
    $("#overlay, #PleaseWait").hide();
    $('#jqxmsgrid').on('rowdoubleclick', function (event){            
       	var rowindex1=event.args.rowindex;
       	var status=$('#jqxmsgrid').jqxGrid('getcellvalue', rowindex1, "statusid");
        $("#hidemain").show();   
        loadmaindata(status)
	}); 
});
</script>
<div id="jqxmsgrid"></div>