<%@page import="com.dashboard.realestate.maintenancemanagement.ClsMaintenanceManagementDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 
<% String contextPath=request.getContextPath();%>
<% ClsMaintenanceManagementDAO DAO= new ClsMaintenanceManagementDAO();   %>  
<%
String docno=request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno").toString();
String id=request.getParameter("id")==null || request.getParameter("id")==""?"0":request.getParameter("id").toString();
%>
<script type="text/javascript">  
var spldata;
spldata='<%=DAO.splInstructionData(session,docno,id)%>';   

     $(document).ready(function () {  
         var source =
         {
             datatype: "json",
             datafields: [
						{name : 'rowno', type: 'int'  },     
  						{name : 'desc1', type: 'string'  },                
                     ],
                        localdata: spldata,  
             
             pager: function (pagenum, pagesize, oldpagenum) {
                 // callback called when a page or page size is changed.
             }
         };
        
         var dataAdapter = new $.jqx.dataAdapter(source);
         
         $("#jqxsplGrid").jqxGrid(
         {
             width: '100%',
             height: 325,
             source: dataAdapter,      
             //editable: true,
             altRows:true,
             showaggregates: true,
             selectionmode: 'singlecell',   
             /* handlekeyboardnavigation: function (event) {
             var rows = $('#jqxsplGrid').jqxGrid('getrows');
             var cell = $('#jqxsplGrid').jqxGrid('getselectedcell');
				if (cell != undefined && cell.datafield == 'desc1' ) {
                 var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                 if (key == 13 || key == 9) { 
                 	$("#jqxsplGrid").jqxGrid('addrow', null, {});	    	    
                 }
             }   
            }, */      
             columns: [    
				{ text: 'SL#', sortable: false, filterable: false,
				    groupable: false, draggable: false, resizable: false,
				    datafield: 'sl', columntype: 'number', width: '5%',
				    cellsrenderer: function (row, column, value) {
				        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>"; 
				}  
				},
				{ text: 'rowno', datafield: 'rowno', width: '10%',hidden:true },	      	
				{ text: 'Description', datafield: 'desc1' },						
			]
         });
     	// $("#jqxsplGrid").jqxGrid('addrow', null, {});
     });
</script>
<div id="jqxsplGrid"></div>
