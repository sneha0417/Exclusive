<%@page import="com.dashboard.analysis.callregisteranalysis.ClscallregisterAnalysisDAO" %>
 <%
 ClscallregisterAnalysisDAO DAO=new ClscallregisterAnalysisDAO();%>
 
 <script type="text/javascript">

 var datasal= '<%=DAO.VehSearch()%>';
   // alert(data);
        $(document).ready(function () { 	
            
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'String'  },    
     						{name : 'regno', type: 'String'  }
     						
     					
     					
                          	
                          	],
                 localdata: datasal,
          
				
                
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
            $("#jqxVehsearch").jqxGrid(
            {
                width: '100%',
                height: 325,
                source: dataAdapter,
                columnsresize: true,
                filterable:true,
                 showfilterrow:true, 
                altRows: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                		
     			columns: [
					{ text: 'DocNo', datafield: 'doc_no',width: '20%',hidden:true},
					{ text: 'Register no', datafield: 'regno', width: '100%' }
					
					
					
					]
            });
    
           
      
            
           $('#jqxVehsearch').on('rowdoubleclick', function (event) 
            		{ 
              
                var rowindex1=event.args.rowindex;
            
               document.getElementById("txtvehicle").value=$('#jqxVehsearch').jqxGrid('getcellvalue', rowindex1, "regno");
               document.getElementById("txtvehicleno").value=$('#jqxVehsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
              
                $('#vehicleWindow').jqxWindow('close');
               
            
            		 }); 
      
        });
    </script>
    <div id="jqxVehsearch"></div>