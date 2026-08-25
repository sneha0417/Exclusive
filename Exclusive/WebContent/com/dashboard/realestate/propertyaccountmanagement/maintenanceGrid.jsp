<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.realestate.propertyaccountmanagement.ClsPropertyAccountManagementDAO"%>
<% ClsPropertyAccountManagementDAO DAO= new ClsPropertyAccountManagementDAO();  %>       
<%   
	String pdocno= request.getParameter("pdocno")==null || request.getParameter("pdocno")==""?"0":request.getParameter("pdocno").trim();
	String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();   
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
       var mndata;
    	 
	  	if(type=='1'){ 
	  		mndata='<%=DAO.getMaintenaceData(pdocno,id)%>';          
	  	}     
		else{
			mndata;
	}

$(document).ready(function () {
 var rendererstring=function (aggregates){
               	var value=aggregates['sum'];
               	if(typeof(value) == "undefined"){
               		value=0.00;
               	}
               	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
               }
        	
        	var rendererstring1=function (aggregates){
                var value1=aggregates['sum1'];
                return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total : " + '</div>';
               }  
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [           
	                        {name : 'voc_no', type: 'String'  },
	                        {name : 'tenant', type: 'String'  },
	                        {name : 'job', type: 'String'  },
							{name : 'proname', type: 'String'  },
							{name : 'comments', type: 'date'  },    
							{name : 'date', type: 'date'  },
							{name : 'paytype', type: 'String'  },
							{name : 'status', type: 'String'  },
							{name : 'compremark', type: 'String'  },
							{name : 'amount', type: 'number'  },
							{name : 'total', type: 'number'  },
							{name : 'profit', type: 'number'  },
						    {name : 'confirm', type: 'String'  },
						    {name : 'brhid', type: 'String'  },
						],  
				    localdata: mndata,
            
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    var cellclassname = function (row, column, value, data) {
		 if (data.confirm ==1) {          
            return "yellowClass";
        }
    };

    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
   
    $("#mncgrid").jqxGrid(      
    {
        width: '100%',
        height: 300,
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
        showstatusbar:true,
        showaggregates:true,
        statusbarheight:25,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,cellclassname:cellclassname,       
                      groupable: false, draggable: false, resizable: false,    
                      datafield: 'sl', columntype: 'number', width: '4%' ,
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },
               { text: 'Doc No', datafield: 'voc_no',  width: '6%',cellclassname:cellclassname},
               { text: 'confirm', datafield: 'confirm',  width: '6%',hidden:true,cellclassname:cellclassname}, 
               { text: 'brhid', datafield: 'brhid',  width: '6%',hidden:true,cellclassname:cellclassname},           
               { text: 'Date', datafield: 'date',  width: '5%',cellsformat:'dd.MM.yyyy',cellclassname:cellclassname },    
               { text: 'Tenant', datafield: 'tenant',  width: '12%' ,cellclassname:cellclassname },
           	   { text: 'Job', datafield: 'job',  width: '11%',cellclassname:cellclassname}, 
           	   { text: 'Provider', datafield: 'proname',  width: '11%',cellclassname:cellclassname},      
	           { text: 'Pay type', datafield: 'paytype',  width: '7%' ,cellclassname:cellclassname},   
	           { text: 'Status', datafield: 'status',  width: '8%',cellclassname:cellclassname},
	           { text: 'Completed Remarks', datafield: 'compremark',  width: '15%',cellclassname:cellclassname },  
	           { text: 'Amount', datafield: 'amount',  width: '7%',cellsalign:'right',cellsformat:'d2',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring,cellclassname:cellclassname },
	           { text: 'Profit', datafield: 'profit',  width: '7%' ,cellsalign:'right',cellsformat:'d2',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring,cellclassname:cellclassname},
	           { text: 'Total', datafield: 'total',  width: '7%',cellsalign:'right',cellsformat:'d2',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring,cellclassname:cellclassname},       
    ]		 
    });     
    $("#overlay, #PleaseWait").hide();
});
</script>
<div id="mncgrid"></div>          