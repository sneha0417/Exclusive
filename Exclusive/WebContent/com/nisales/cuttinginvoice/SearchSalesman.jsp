 <%@page import="com.nisales.cuttinginvoice.ClsCuttingInvoiceDAO"%>
<% ClsCuttingInvoiceDAO  sDAO = new ClsCuttingInvoiceDAO();%>   
 <script type="text/javascript">

 
   // alert(data);
        $(document).ready(function () { 	
        	var	 saldata= '<%=sDAO.searchsalesman()%>';
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'String'  },    
     					 
     						{name : 'sal_name', type: 'String'  }
     						
     					
     					
                          	
                          	],
                 localdata: saldata,
          
				
                
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
            $("#jqxSalesmansearch").jqxGrid(
            {
                width: '100%',
                height: 325,
                source: dataAdapter,
                columnsresize: true,
               filterable:true,
               showfilterrow:true,
               
               
                selectionmode: 'singlerow',
                pagermode: 'default',
                //sortable: true,
                //Add row method
	
     						
     					
     					
                columns: [
					{ text: 'ID', datafield: 'doc_no',   columntype: 'textbox', filtertype: 'input',width: '20%',hidden:true},
					{ text: 'NAME', datafield: 'sal_name',  columntype: 'textbox', filtertype: 'input', width: '100%' }
					
					
					
					]
            });
    
           
      
            
           $('#jqxSalesmansearch').on('rowdoubleclick', function (event) 
            		{ 
              
                var rowindex1=event.args.rowindex;
            
            	
               
               document.getElementById("salesmanname").value=$('#jqxSalesmansearch').jqxGrid('getcellvalue', rowindex1, "sal_name");
               document.getElementById("salid").value=$('#jqxSalesmansearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
              
                $('#Salesmanwindow').jqxWindow('close');
               
            
            		 }); 
      
        });
    </script>
    <div id="jqxSalesmansearch"></div>