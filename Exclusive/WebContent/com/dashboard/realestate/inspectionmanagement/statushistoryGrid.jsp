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
	   padata='<%=DAO.getStatushistory(docno)%>';              
	  	 
$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [                   
                {name : 'status', type: 'String'  }, 
                {name : 'user', type: 'String'  }, 
				{name : 'created_date', type: 'date'  },
				{name : 'remarks', type: 'String'  },	 
			 
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
    
    $("#statushistorygrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    });
   
    $("#statushistorygrid").jqxGrid(
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
               { text: 'Status', datafield: 'status' ,  width: '25%'}, 
               { text: 'Remarks', datafield: 'remarks',  width: '30%'  }, 
               { text: 'Entered By', datafield: 'user',  width: '25%'  },           	  
           	   { text: 'Entered Date', datafield: 'created_date',  width: '15%' ,cellsformat:'dd.MM.yyyy'  }, 
           	   
           	 
    ]		 
    });
    $("#overlay, #PleaseWait").hide();
         
});
</script>
<div id="statushistorygrid"></div>