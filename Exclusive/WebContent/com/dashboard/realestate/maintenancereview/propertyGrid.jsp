<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.realestate.maintenancereview.ClsMaintenanceReviewDAO"%>
<% ClsMaintenanceReviewDAO DAO= new ClsMaintenanceReviewDAO();   %>       
<%   
	String pdocno= request.getParameter("pdocno")==null || request.getParameter("pdocno")==""?"0":request.getParameter("pdocno").trim();
	String id = request.getParameter("id")==null?"0":request.getParameter("id").trim(); 
	String unitno = request.getParameter("unitno")==null?"":request.getParameter("unitno").trim(); 
	String frmld = request.getParameter("frmld")==null?"":request.getParameter("frmld").trim();
	String from = request.getParameter("from")==null?"":request.getParameter("from").trim(); 
	String to = request.getParameter("to")==null?"":request.getParameter("to").trim();
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
	  		padata='<%=DAO.getPropertyData(pdocno,id,unitno,frmld,from,to)%>';          
	  	}     
		else{
			padata;
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
						    
						    {name : 'jv_vocno', type: 'String'  },
							{name : 'blockamt', type: 'number'  },
							{name : 'cpuvoc', type: 'string'  },  
							{name : 'invvoc', type: 'string'  }, 
						],  
				    localdata: padata,
            
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
    
    $("#pagrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    });
   
    $("#pagrid").jqxGrid(
    {
        width: '100%',
        height: 480,
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
                  { text: 'SL#', sortable: false, filterable: false, editable: false,cellclassname:cellclassname,       
                      groupable: false, draggable: false, resizable: false,    
                      datafield: 'sl', columntype: 'number', width: '4%' ,
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },
               { text: 'Doc No', datafield: 'voc_no',  width: '5%',cellclassname:cellclassname},
               { text: 'confirm', datafield: 'confirm',  width: '6%',hidden:true,cellclassname:cellclassname}, 
               { text: 'brhid', datafield: 'brhid',  width: '6%',hidden:true,cellclassname:cellclassname},           
               { text: 'Date', datafield: 'date',  width: '5%',cellsformat:'dd.MM.yyyy',cellclassname:cellclassname },    
               { text: 'Tenant', datafield: 'tenant',  width: '8%' ,cellclassname:cellclassname },
           	   { text: 'Job', datafield: 'job',  width: '9%',cellclassname:cellclassname}, 
           	   { text: 'Provider', datafield: 'proname',  width: '10%',cellclassname:cellclassname},      
	           { text: 'Pay type', datafield: 'paytype',  width: '5%' ,cellclassname:cellclassname},   
	           { text: 'Status', datafield: 'status',  width: '6%',cellclassname:cellclassname},
	           { text: 'Completed Remarks', datafield: 'compremark',  width: '9%',cellclassname:cellclassname },  
	           { text: 'Amount', datafield: 'amount',  width: '6%',cellsalign:'right',cellsformat:'d2',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring,cellclassname:cellclassname },
	           { text: 'Profit', datafield: 'profit',  width: '6%' ,cellsalign:'right',cellsformat:'d2',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring,cellclassname:cellclassname},
	           { text: 'JV Docno', datafield: 'jv_vocno',  width: '5%', cellclassname:cellclassname},  
	           { text: 'CPU Doc No', datafield: 'cpuvoc', width: '5%', cellclassname:cellclassname},
			   { text: 'PRIV Doc No', datafield: 'invvoc', width: '5%', cellclassname:cellclassname}, 
			   { text: 'Total', datafield: 'total',  width: '6%',cellsalign:'right',cellsformat:'d2',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring,cellclassname:cellclassname},
			   { text: 'Block Amount', datafield: 'blockamt',  width: '6%', cellclassname:cellclassname,cellsalign:"right",align:"right",cellsformat:"d2", aggregates: ['sum'], aggregatesrenderer:rendererstring},
			   ]   		 
    });     
    $("#overlay, #PleaseWait").hide();
     $('#pagrid').on('rowdoubleclick', function (event) {                 
            var rowindex2 = event.args.rowindex;                      
			document.getElementById("hidbrhid").value=$('#pagrid').jqxGrid('getcellvalue', rowindex2, "brhid");
			document.getElementById("hidvocno").value=$('#pagrid').jqxGrid('getcellvalue', rowindex2, "voc_no");     
            $('.textpanel p').text('Doc No '+$('#pagrid').jqxGrid('getcellvalue',rowindex2,'voc_no')+' - '+$('#pagrid').jqxGrid('getcellvalue', rowindex2, "tenant"));
        });
});
</script>
<div id="pagrid"></div>