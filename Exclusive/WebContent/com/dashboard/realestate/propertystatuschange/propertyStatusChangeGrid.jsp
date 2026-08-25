<%@page import="com.dashboard.realestate.propertystatuschange.ClspropertyStatusChange" %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
     String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();
     ClspropertyStatusChange dao= new ClspropertyStatusChange();
%>
<script type="text/javascript">
    
       var data;
       var temp='<%=branchval%>';
    	 
	  	if(temp!='NA'){ 
	  		 data='<%=dao.propertyStatusChange(branchval, fromDate, toDate,check)%>';
	  	} 

	  	  
	  	        $(document).ready(function () { 	
	  	        
	  	            // prepare the data
	  	            var source =
	  	            {
	  	                datatype: "json",
	  	                datafields: [
	  								{name : 'doc_no', type: 'number'  },
	  								
	  								{name : 'voc_no', type: 'number'  },
	  								
	  								{name : 'prop_name', type: 'string'   },
	  	     						{name : 'prop_owner', type: 'string'  },
	  	     						{name : 'address', type: 'string'   },
	  	     						{name : 'landmark', type: 'string'  },
	  	     						{name : 'area', type: 'number'   },
	  	     						{name : 'description', type: 'string'   },
	  	     						{name : 'sr_no', type: 'int'  }
	  	     						
	  	     											
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
	  				            
	  			            }		
	  	            );

	  	            
	  	            
	  	            $("#propertyStatusChangeGridID").jqxGrid(
	  	            {
	  	            	width: '98%',
	  	                height: 490,
	  	                source: dataAdapter,
	  	                rowsheight:25,
	  	                filtermode:'excel',
	  	                filterable: true,
	  	                sortable: true,
	  	                selectionmode: 'singlerow',
	  	                editable: false,
	  	                       
	  	                columns: [
	  								 { text: 'SL#', sortable: false, filterable: false, editable: false,
	  	                              groupable: false, draggable: false, resizable: false,
	  	                              datafield: 'sl', columntype: 'number', width: '4%',
	  	                              cellsrenderer: function (row, column, value) {
	  	                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
	  	                              }
	  	                            },	
	  	                            { text: '', datafield: 'doc_no', width: '10%' , editable: false,hidden:true},	
	  	                          { text: 'Doc_No', datafield: 'voc_no', width: '10%' , editable: false},	
	  	                            { text: 'Property Name', datafield: 'prop_name', width: '10%' , editable: false },
	  								{ text: 'Property Owner', datafield: 'prop_owner', width: '16%', editable: false },	
	  								{ text: 'Address', datafield: 'address', width: '16%', editable: false },
	  								{ text: 'Landmark', datafield: 'landmark', width: '16%' , editable: false},
	  								{ text: 'Area', datafield: 'area', width: '16%' , editable: false },
	  								{ text: 'Property description', datafield: 'description', width: '16%', editable: false },	
	  								{ text: 'srno', datafield: 'sr_no', width: '9%',hidden:true}
	  				              ]
	  	               
	  	            });
	  	          $("#overlay, #PleaseWait").hide();  
	  	          
	  	        $('#propertyStatusChangeGridID').on('rowdoubleclick', function (event) {
	  	        	var rowindex1 = event.args.rowindex;
	  	          $('#update').attr("disabled",false);
	  	        	document.getElementById("doc_no").value= $('#propertyStatusChangeGridID').jqxGrid('getcellvalue', rowindex1, "doc_no");
	  	        });
	  	           
	});
</script>
<div id="propertyStatusChangeGridID"></div>
