<%-- <%@page import="com.operations.clientrelations.clientreview.ClsClientReviewDAO" %>
<% ClsClientReviewDAO DAO=new ClsClientReviewDAO(); %> --%>
<% String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno"); 
   String detailed = request.getParameter("detailed")==null?"0":request.getParameter("detailed"); %>  

<script type="text/javascript">

	    <%-- var data= '<%=DAO.operationLoading(cldocno,detailed) %>'; --%>
	    
	    var data;
	    
        $(document).ready(function () { 
        	
        	// prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							
     						{name : 'refno', type: 'int' },
     						{name : 'flname', type: 'string'   },
     						{name : 'clstatus', type: 'string'  },
     						{name : 'activity', type: 'string'  },
     						{name : 'rentaltype', type: 'string'  }
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

            
            
            $("#equipmentDetailsGridID").jqxGrid(
            {
            	width: '99%',
                height: 120,
                source: dataAdapter,
                columnsresize: true,
                editable: true,
                sortable: true,
                rowsheight:25,
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
							{ text: 'Service Type', datafield: 'refno', width: '15%' },	
							{ text: 'Item', datafield: 'flname', width: '20%' },	
							{ text: 'Nos', datafield: 'clstatus', width: '20%' },	
							{ text: 'Activity', datafield: 'activity', width: '20%' },
							{ text: 'Description', datafield: 'rentaltype', width: '20%' },
						 ]
            });
            
            
        });

</script>

<div id="equipmentDetailsGridID"></div>