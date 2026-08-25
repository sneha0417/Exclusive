<%@page import="com.aviation.pricemanagement.ClsPriceManagementDAO"%>
<% ClsPriceManagementDAO DAO = new ClsPriceManagementDAO(); %>
 <script type="text/javascript">
			 
		  	 var barnddata='<%=DAO.searchPort()%>';
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                             
                            {name : 'port', type: 'string'  },
                            {name : 'portname', type: 'string'  },
                            {name : 'region', type: 'string'  },
                            {name : 'doc_no', type: 'string'  }
     						
                        ],
                		
                		//  url: url1,
                 localdata: barnddata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#Jqxportsearch").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
             
                selectionmode: 'singlerow',
            
                
            
                       
                columns: [
							
							 
                          
                              { text: 'DOC NO', datafield: 'doc_no', width: '20%',hidden: false},
                              { text: 'PORT ', datafield: 'port', width: '35%' },
                              { text: 'PORT NAME', datafield: 'portname', width: '35%' },
                              { text: 'REGION  ', datafield: 'region', width: '30%' }
						
			
	             
						]
            });
            
          $('#Jqxportsearch').on('rowdoubleclick', function (event) {
            	var rowindex1 =$('#rowindex').val();
            	// alert(rowindex1);
                var rowindex2 = event.args.rowindex;
                $('#jqxPriceMngt').jqxGrid('setcellvalue', rowindex1, "region" ,$('#Jqxportsearch').jqxGrid('getcellvalue', rowindex2, "portname"));
                $('#jqxPriceMngt').jqxGrid('setcellvalue', rowindex1, "port" ,$('#Jqxportsearch').jqxGrid('getcellvalue', rowindex2, "port"));
                $('#jqxPriceMngt').jqxGrid('setcellvalue', rowindex1, "portid" ,$('#Jqxportsearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
                
                
              $('#portSearchwindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="Jqxportsearch"></div>