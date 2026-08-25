<%@page import="com.emailnew.ClsEmailDAO" %> 
<%ClsEmailDAO ced=new ClsEmailDAO(); %>
 

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 
 <%int rowIndex=request.getParameter("rowIndex")==null?0:Integer.parseInt(request.getParameter("rowIndex").trim()); %>

 <script type="text/javascript">
    
 var dtype;

 var rowIndex='<%=rowIndex%>';
 
 dtype='<%=ced.dtypeSearch (session)%>';
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

     				
     						{name : 'dtype', type: 'String'  },
     						
     						
     						
                          	],
                          	localdata: dtype,
                          //	 url: url1,
          
				
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxdtypesearch").jqxGrid(
            {
                width: '100%',
                height: 140,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
            
            
     					
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'DTYPE', datafield: 'dtype', width: '88%' }
					
					 
					
					]
            });
    
            //$("#jqxdtypesearch").jqxGrid('addrow', null, {});
      
				            
				           $('#jqxdtypesearch').on('rowdoubleclick', function (event) 
				            		{ 
				        	   
				              	var rowindex1=event.args.rowindex;
				              	document.getElementById("txtdtype").value="";
				              	//alert("=========="+document.getElementById("txtdtype").value);
				               			document.getElementById("txtdtype").value=$('#jqxdtypesearch').jqxGrid('getcellvalue', rowindex1, "dtype");
				               			//alert("dtype====="+document.getElementById("txtdtype").value);
				            	  
				              
				                $('#dtypeinfowindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="jqxdtypesearch"></div>
    
    </body>
</html>