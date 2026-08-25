 


 <%@page import="com.realestate.propertyrelated.propertyrelatedmaster.ClsPropertyRelatedMasterDAO"%>
<%ClsPropertyRelatedMasterDAO DAO= new ClsPropertyRelatedMasterDAO();%> 
 
 
<script type="text/javascript">



            	
        $(document).ready(function () { 	
        	var Reqmaster='<%=DAO.searchptypr() %>'; 
        		 

        	
 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                                
                             {name : 'prtype', type: 'string'},  
     		 				 
     						{name : 'doc_no', type: 'int'   },
     						 
                 ],
                 localdata: Reqmaster,
                
                
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

            
            
            $("#qtysearchgrid").jqxGrid(
            {
                width: '100%',
                height: 300,
                source: dataAdapter,
                editable: false,
                selectionmode: 'singlecell',
                pagermode: 'default',
             
                
          
          

                       
                columns: [      
                           
                            
                          
                            { text: 'Type', datafield: 'prtype', width: '100%'   },	
						 
							{ text: 'doc_no', datafield: 'doc_no', width: '10%' , hidden: true},
 
											
							
							
			              ]
               
            });
            
            
            
        
            $("#qtysearchgrid").on('celldoubleclick', function (event) 
            		{
            	 
           	 var rowindextemp = event.args.rowindex;
    
         	document.getElementById("prtypeid").value=$('#qtysearchgrid').jqxGrid('getcellvalue', rowindextemp, "doc_no");
            document.getElementById("prtype").value=$('#qtysearchgrid').jqxGrid('getcellvalue', rowindextemp, "prtype");
            	
            	             $('#unitwindow').jqxWindow('close'); 
            	
            	 
            		    
            		});  
            
            
            
            
            
      
   
        });
    </script>
    <div id=qtysearchgrid></div>
 