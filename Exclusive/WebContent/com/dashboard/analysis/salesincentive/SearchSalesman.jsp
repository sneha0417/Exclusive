<%@page import="com.dashboard.analysis.salesincentive.ClsSalesIncentive" %>
 <%
 ClsSalesIncentive DAO=new ClsSalesIncentive();%>
 
 <script type="text/javascript">

 var datasal= '<%=DAO.SalesgentSearch()%>';
   // alert(data);
        $(document).ready(function () { 	
            
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'String'  },    
     						{name : 'sal_name', type: 'String'  }
     						
     					
     					
                          	
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
            $("#jqxSalagentsearch").jqxGrid(
            {
                width: '100%',
                height: 325,
                source: dataAdapter,
                columnsresize: true,
                filterable:true,
                /* showfilterrow:true, */
                altRows: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                		
     			columns: [
					{ text: 'DocNo', datafield: 'doc_no',   columntype: 'textbox', filtertype: 'input',width: '20%'},
					{ text: 'SalesMan', datafield: 'sal_name',  columntype: 'textbox', filtertype: 'input', width: '80%' }
					
					
					
					]
            });
    
           
      
            
           $('#jqxSalagentsearch').on('rowdoubleclick', function (event) 
            		{ 
              
                var rowindex1=event.args.rowindex;
            
               document.getElementById("txtsalman").value=$('#jqxSalagentsearch').jqxGrid('getcellvalue', rowindex1, "sal_name");
               document.getElementById("salid").value=$('#jqxSalagentsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
              
                $('#Salesagentinfowindow').jqxWindow('close');
               
            
            		 }); 
      
        });
    </script>
    <div id="jqxSalagentsearch"></div>