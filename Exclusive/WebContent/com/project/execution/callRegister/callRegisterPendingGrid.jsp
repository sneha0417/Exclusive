<%@page import="com.project.execution.callRegister.ClsCallRegisterDAO"%>
<% ClsCallRegisterDAO DAO= new ClsCallRegisterDAO(); %>
<% String contractno = request.getParameter("contractno")==null?"0":request.getParameter("contractno");
   String docNo = request.getParameter("docno")==null?"0":request.getParameter("docno"); %>  

<script type="text/javascript">

	    var data3;
	    
        $(document).ready(function () { 
        	
			var temp3='<%=docNo%>';
        	
        	data3= '<%=DAO.servicePendingComplaintGridLoading(docNo,contractno) %>';     
        	
        	// prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							
     						{name : 'stypes', type: 'string' },
     						{name : 'items', type: 'string'   },
     						{name : 'complaints', type: 'string'  },
     						{name : 'site', type: 'string'  },
     						{name : 'descriptions', type: 'string'  }
                 ],
                 localdata: data3, 
                
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

            
            
            $("#callRegisterPendingGridID").jqxGrid(
            {
            	width: '99%',
                height: 220,
                source: dataAdapter,
                columnsresize: true,
                editable: false,
                sortable: true,
                rowsheight:25,
                selectionmode: 'singlerow',
                localization: {thousandsSeparator: ""},
                
                columns: [
						  { text: 'No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Service Type', datafield: 'stypes', width: '16%' },	
							{ text: 'Item', datafield: 'items', width: '18%' },	
							{ text: 'Complaint', datafield: 'complaints', width: '18%' },
							{ text: 'Site', datafield: 'site', width: '18%' },	
							{ text: 'Description', datafield: 'descriptions', width: '24%' },
						 ]
            });
            
            if(temp3>0){
            	$("#callRegisterPendingGridID").jqxGrid('disabled', true);
            }
            
            
        });

</script>

<div id="callRegisterPendingGridID"></div>
