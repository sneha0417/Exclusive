<%-- <%@page import="com.operations.clientrelations.clientreview.ClsClientReviewDAO" %>
<% ClsClientReviewDAO DAO=new ClsClientReviewDAO(); %> --%>
<% String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno"); 
   String detailed = request.getParameter("detailed")==null?"0":request.getParameter("detailed"); %>  

<script type="text/javascript">

	    <%-- var data2= '<%=DAO.operationLoading(cldocno,detailed) %>'; --%>
	    var data2;
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
     						{name : 'refno', type: 'int' },
     						{name : 'flname', type: 'string'   },
     						{name : 'clstatus', type: 'string'  },
     						{name : 'activities', type: 'string'  },
     						{name : 'rentaltype', type: 'string'  },
     						{name : 'total', type: 'number'  },
     						{name : 'profitperc', type: 'number'  },
     						{name : 'net', type: 'number'  }
                 ],
                 localdata: data2, 
                
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

            
            
            $("#labourDetailsGridID").jqxGrid(
            {
            	width: '99%',
                height: 150,
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
							{ text: 'Code No', datafield: 'refno', width: '5%' },	
							{ text: 'Description', datafield: 'rentaltype', width: '20%' },
							{ text: 'Hrs', datafield: 'flname', width: '20%' },	
							{ text: 'Mins', datafield: 'clstatus', width: '10%' },	
							{ text: 'Rate/Hr', datafield: 'activities', width: '10%', aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
							{ text: 'Total', datafield: 'total', cellsformat: 'd2', width: '10%', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Profit %', datafield: 'profitperc', cellsformat: 'd2', width: '10%', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Net', datafield: 'net', cellsformat: 'd2', width: '10%', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
						 ]
            });
            
            
        });

</script>

<div id="labourDetailsGridID"></div>