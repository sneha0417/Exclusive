<%-- <%@page import="com.operations.clientrelations.clientreview.ClsClientReviewDAO" %>
<% ClsClientReviewDAO DAO=new ClsClientReviewDAO(); %> --%>
<% String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno"); 
   String detailed = request.getParameter("detailed")==null?"0":request.getParameter("detailed"); %>  

<script type="text/javascript">

	    <%-- var data= '<%=DAO.operationLoading(cldocno,detailed) %>'; --%>
	    var data;
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
							{name : 'activity', type: 'string'  }, 
							{name : 'description', type: 'string'  },
     						{name : 'product', type: 'int' },
     						{name : 'productname', type: 'string'   },
     						{name : 'unit', type: 'string'  },
     						{name : 'qty', type: 'string'  },
     						{name : 'amount', type: 'number'  },
     						{name : 'total', type: 'number'  },
     						{name : 'invoiced', type: 'bool'  }
                 ],
                 localdata: data, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
        	
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			            
		            } );

            
            
            $("#materialDetailsGridID").jqxGrid(
            {
            	width: '99%',
                height: 148,
                source: dataAdapter,
                columnsresize: true,
                editable: true,
                sortable: true,
                showaggregates: true,
             	showstatusbar:true,
             	rowsheight:25,
             	statusbarheight:25,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                
                columns: [
						  { text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Activity', datafield: 'activity', width: '25%' },
							{ text: 'Description', datafield: 'description', width: '25%' },
							{ text: 'Product', datafield: 'product', width: '15%' },	
							{ text: 'Product Name', datafield: 'productname', width: '20%' },	
							{ text: 'Unit', datafield: 'unit', width: '5%' },
							{ text: 'Qty', datafield: 'qty', width: '5%', aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
							{ text: 'Amount', datafield: 'amount', cellsformat: 'd2', width: '10%', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Total', datafield: 'total', cellsformat: 'd2', width: '10%', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Invoiced', datafield: 'invoiced', columntype: 'checkbox', editable: true, checked: true, width: '5%',cellsalign: 'center', align: 'center' },
						 ]
            });
            
            
        });

</script>

<div id="materialDetailsGridID"></div>