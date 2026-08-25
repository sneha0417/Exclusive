<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.realestate.inspectionmanagement.ClsInspectionManagementDAO"%>
<%       
String docno = request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno").trim();
	ClsInspectionManagementDAO DAO= new ClsInspectionManagementDAO();           
%>
<style type="text/css">
    .redClass
    {
        background-color: #FFEBEB;
    }
    
    .yellowClass
    {
        background-color: #FFFFD1;
    }
    
     .orangeClass
    {
        background-color: #FFEBC2;
    }
    
</style>
<script type="text/javascript">        
     
       var padata,dataexcel;  
	  padata='<%=DAO.getSchedulehistory(docno)%>';           
	   

$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [                    
				{name : 'date', type: 'date'  },
				{name : 'user', type: 'String'  },	 
				{name : 'created_date', type: 'String'  },	
				
				],  
		    localdata: padata,        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    var cellclassname = function (row, column, value, data) {
		 if (data.isqty !=0) {
            return "yellowClass";
        }else{
        	return "orangeClass";
        };
    };

    
    var dataAdapter = new $.jqx.dataAdapter(source,
	 {
   		loadError: function (xhr, status, error) {
           alert(error);    
           }         
        }		
    );
    
    $("#schedulehistorygrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    });
   
    $("#schedulehistorygrid").jqxGrid(
    {
        width: '100%',
        height: 200,
        source: dataAdapter,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        columnsresize: true,
       	selectionmode: 'singlerow',                 
       	showfilterrow: true,
        sortable:true,
        enabletooltips:true,                          
        pagermode: 'default',   
        editable:false,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,       
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '5%' ,
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },             
           	   { text: 'Inspection Date', datafield: 'date',  width: '30%',cellsformat:'dd.MM.yyyy' }, 
           	   { text: 'Entered By', datafield: 'user',  width: '35%'},  
           	   { text:  'Entered Date', datafield: 'created_date',  width: '30%'},  
           	  
    ]		 
    });
    $("#overlay, #PleaseWait").hide();
          
});
</script>		
<div id="schedulehistorygrid"></div>