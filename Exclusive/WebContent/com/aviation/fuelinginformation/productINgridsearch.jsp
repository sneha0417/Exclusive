<%@page import="com.aviation.fuelinginformation.ClsfuelingInformationDAO" %>

<%ClsfuelingInformationDAO fuelinfoDAO=new ClsfuelingInformationDAO(); %>
 <script type="text/javascript">
			 
		  	 var barnddata='<%=fuelinfoDAO.searchProduct()%>';
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                             
                            {name : 'product', type: 'string'  },
                            {name : 'part_no', type: 'string'  },
                            {name : 'doc_no', type: 'string'  }
     						
                        ],
                		
                		//  url: url1,
                 localdata: barnddata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#Jqxproductsearch").jqxGrid(
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
							
							 
                          
                              { text: 'DOC NO', datafield: 'doc_no', width: '20%',hidden:true},
                              { text: 'PART NO ', datafield: 'part_no', width: '40%' },
                              { text: 'PRODUCT ', datafield: 'product', width: '60%' }
						
			
	             
						]
            });
            
          $('#Jqxproductsearch').on('rowdoubleclick', function (event) {
            	var rowindex1 =$('#rowindex').val();
            	// alert(rowindex1);
                var rowindex2 = event.args.rowindex;
                $('#jqxFuelInfo').jqxGrid('setcellvalue', rowindex1, "product" ,$('#Jqxproductsearch').jqxGrid('getcellvalue', rowindex2, "product"));
                $('#jqxFuelInfo').jqxGrid('setcellvalue', rowindex1, "productid" ,$('#Jqxproductsearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
                
                
//                 var rows = $('#jqxFuelInfo').jqxGrid('getrows');
//                 var rowlength= rows.length;
//                 if(rowindex1==rowlength-1)
//                 {
//                 	  $("#jqxFuelInfo").jqxGrid('addrow', null, {});	
//                 }
              
//                 document.getElementById("errormsg").innerText="";
                
                
              $('#productsearch1').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="Jqxproductsearch"></div>