<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.realestate.maintenancemanagement.ClsMaintenanceManagementDAO"%>
<%   
	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();    
	String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
	ClsMaintenanceManagementDAO DAO= new ClsMaintenanceManagementDAO();           
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
    
       var type='<%=id%>';
       var padata,dataexcel;
    	 
	  	if(type=='1'){ 
	  		<%-- padata='<%=DAO.getPropertyData(fromdate,todate,id)%>';  
	  		dataexcel='<%=DAO.getPropertyExcel(fromdate,todate,id)%>';  --%>            
	  	} 
		else{
			padata;
	}

$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
                
                        {name : 'accno', type: 'String'  },
                        {name : 'accname', type: 'String'  },
                        {name : 'debit', type: 'String'  },
                        {name : 'credit', type: 'String'  },
                        {name : 'trno', type: 'String'  },
                        {name : 'save', type: 'String'  },
                       
						],  
				    localdata: padata,
        
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
    
   
   
    $("#acgrid").jqxGrid(
    {
        width: '100%',
        height: 180,
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
                      datafield: 'sl', columntype: 'number', width: '4%' ,
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },
               { text: 'Account No', datafield: 'accno',  width: '10%'},       
               { text: 'Description', datafield: 'accname'},
               { text: 'Debit', datafield: 'debit',width: '15%',align:'right',cellsalign:'right',cellsformat:'d2'},                
               { text: 'Credit', datafield: 'credit' ,  width: '15%',align:'right',cellsalign:'right',cellsformat:'d2'},
              
               
                 
    ]		 
    });
    $("#overlay, #PleaseWait").hide();
     $('#acgrid').on('rowdoubleclick', function (event) {    
           
            /* document.getElementById("hiddocno").value=$('#pagrid').jqxGrid('getcellvalue', rowindex2, "doc_no");  
            $('.textpanel p').text('Doc No '+$('#pagrid').jqxGrid('getcellvalue',rowindex2,'voc_no')+' - '+$('#pagrid').jqxGrid('getcellvalue', rowindex2, "property"));
            $('.comments-container').html(''); */
        });  
     $('#acgrid').on('cellclick', function (event) { 
    	 var rowindex2 = event.args.rowindex;
         var datafield=event.args.datafield;
         
        /*  if(datafield=="save"){
         	var trno=$('#pagrid').jqxGrid('getcellvalue', rowindex2, "trno");
         	funSave(trno);
         }  */
    	 
    	 
     });
      
});
    
</script>
<div id="acgrid"></div>