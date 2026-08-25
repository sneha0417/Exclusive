<%@page import="com.fixedassets.assets.assetmaster.ClsAssetmasterDAO" %>
<%ClsAssetmasterDAO amd=new ClsAssetmasterDAO(); %>

<%--  <jsp:include page="../../../../includes.jsp"></jsp:include>   --%>


<%

//String docnos=re

String docnos = request.getParameter("docno")==null?"0":request.getParameter("docno");
//System.out.println("----docnos------"+docnos);

%>


       <script type="text/javascript">

       var docnoss='<%=docnos%>';
    	   
    	   if(docnoss>0)
    		   {
    		var barnddata='<%=amd.subdetails(session,docnos)%>';
    		   }
			 var barnddata;
			 
			 
		$(document).ready(function () { 	
    
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'sr_no', type: 'string'  },
                            {name : 'desc1', type: 'string'  },
                            {name : 'qty', type: 'number'  },
                      
     						
                        ],
                		
                		//  url: url1,
                 localdata: barnddata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxsubdetails").jqxGrid(
            {
                width: '83%',
                height: 102,
                source: dataAdapter,
                //columnsresize: true,
                altRows: true,
                editable: true,
             
                selectionmode: 'singlecell',
            
                
            
                       
                columns: [
							

                          { text: 'SL No', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '10%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },	
                            
                            
                              { text: 'Description', datafield: 'desc1', width: '70%' ,
                            		cellbeginedit: function (row) {
    									var temp=$('#mode').val();
    									 if (temp =="view")
    										 {
    									       return false;
    										 }
    								    
    								  }},
                              { text: 'Qty', datafield: 'qty', width: '20%',
                            		cellbeginedit: function (row) {
    									var temp=$('#mode').val();
    									 if (temp =="view")
    										 {
    									       return false;
    										 }
    								    
    								  }},
                         
	             
						]
            });
            
            
            
            if(docnoss>0)
 		   {
            	
 		   }
            else
            	{
            	
            $("#jqxsubdetails").jqxGrid('addrow', null, {});
            $("#jqxsubdetails").jqxGrid('addrow', null, {});
            $("#jqxsubdetails").jqxGrid('addrow', null, {});
            	}
            
            
            
            $("#jqxsubdetails").on('cellvaluechanged', function (event) 
		            {
            	 var rowindex1 = event.args.rowindex;
		
		 var rows = $('#jqxsubdetails').jqxGrid('getrows');
         var rowlength= rows.length;
         if (rowindex1 == rowlength - 1) {
             
             $("#jqxsubdetails").jqxGrid('addrow', null, {});	
             
             }	
		            });
          
        });
		
		
		  
		
    </script>
    <div id="jqxsubdetails"></div>