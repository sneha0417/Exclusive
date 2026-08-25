
<%@page import="com.procurement.purchase.purchaseorder.ClspurchaseorderDAO"%>
<% ClspurchaseorderDAO purchaseorderDAO = new ClspurchaseorderDAO(); %>  

<%
String reqmasterdocno=request.getParameter("reqmasterdocno")==null?"0":request.getParameter("reqmasterdocno").trim();

//System.out.println("-----reqmasterdocno---"+reqmasterdocno);
%>


       <script type="text/javascript">
  
		<%-- 	 var colorddata1= '<%=purchaseorderDAO.searchreqProduct(reqmasterdocno)%>'; --%>
			 
		 
			 
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [ 
                            
                            {name : 'part_no', type: 'string'  },
                            {name : 'productname', type: 'string'  },
                            {name : 'doc_no', type: 'string'  },
                            {name : 'unit', type: 'string'  },
                            {name : 'munit', type: 'string'  },
                            {name : 'psrno', type: 'string'  },
                            
                            {name : 'qty', type: 'number'  },
                            
                            
                            {name : 'qutval', type: 'number'  },
                            {name : 'pqty', type: 'number'  },
                            {name : 'saveqty', type: 'number'  },
                            {name : 'method', type: 'string'  },
                            
                            
                            //qty qutval pqty saveqty
                            
                            
                       //     munit
     						
                        ],
                		
                		//  url: url1,
                 localdata: colorddata1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#reqprosearch").jqxGrid(
            {
    
                
                width: '100%',
                height: 560,
                source: dataAdapter,
                columnsresize: true,
              
                
                filterable: true, 
    
                selectionmode: 'singlerow',
                
       
                
            
                       
                columns: [
							
							 
                          
                              { text: 'DOC NO', datafield: 'doc_no', width: '10%',hidden:true},
                              { text: 'Product', datafield: 'part_no', width: '30%' },
                              { text: 'Product Name', datafield: 'productname', width: '50%' },
                              { text: 'Quantity', datafield: 'qty', width: '10%' ,cellsformat:'d2'},
                              
                              
                              { text: 'Unit', datafield: 'unit', width: '10%' },
                              { text: 'Unitdoc', datafield: 'munit', width: '10%' ,hidden:true},
                              { text: 'psrno', datafield: 'psrno', width: '10%' ,hidden:true},
                              { text: 'Method', datafield: 'method', width: '10%',hidden:true },
                  			{text: 'qutval', datafield: 'qutval', width: '10%' , ellsformat:'d2'},
							{ text: 'pqty', datafield: 'pqty', width: '9%' ,  cellsformat:'d2' },
							{text: 'saveqty', datafield: 'saveqty', width: '10%', cellsformat:'d2' },
						]
            });
            
          $('#reqprosearch').on('rowdoubleclick', function (event) {
            	var rowindex1 =$('#rowindex').val();
            	// alert(rowindex1);
                var rowindex2 = event.args.rowindex;
                
                
                
                
                
                var prodocs=$('#reqprosearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
                
                if(parseInt($('#reqprosearch').jqxGrid('getcellvalue', rowindex2, "method"))==0)
              	  {
              	  
            		var rows = $("#serviecGrid").jqxGrid('getrows');
          	    var aa=0;
          	    for(var i=0;i<rows.length;i++){
          	 
          	    	
          	    	 
          		   if(parseInt(rows[i].prodoc)==parseInt(prodocs))
          			   {
          			   aa=1;
          			   break;
          			   }
          		   else{
          			   
          			   aa=0;
          		       } 

          	 
          	   
          	                         }
          	   
          	   
          	   
          	   if(parseInt(aa)==1)
          		   {
          		   
          			document.getElementById("errormsg").innerText="You have already select this product";
          		   
          		   return 0;
          		   
          		   }
          	   else
          		   {
          		   document.getElementById("errormsg").innerText="";
          		   }
          	   
            	  
            	  }
              	  
              	  
                
                
                
                
                
                
                
                
                $('#datas1').val(0);
                
                
                $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "qutval" ,$('#reqprosearch').jqxGrid('getcellvalue', rowindex2, "qutval"));
                $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "pqty" ,$('#reqprosearch').jqxGrid('getcellvalue', rowindex2, "pqty"));
                $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "saveqty" ,$('#reqprosearch').jqxGrid('getcellvalue', rowindex2, "saveqty"));
                
                
             	$('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "qty" ,$('#reqprosearch').jqxGrid('getcellvalue', rowindex2, "qty"));
            	
                $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "proid" ,$('#reqprosearch').jqxGrid('getcellvalue', rowindex2, "part_no"));
              $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "proname" ,$('#reqprosearch').jqxGrid('getcellvalue', rowindex2, "productname"));       
                
              
            
              
          //    $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "qty" ,$('#reqprosearch').jqxGrid('getcellvalue', rowindex2, "qty1"));   
                
               $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "productid" ,$('#reqprosearch').jqxGrid('getcellvalue', rowindex2, "part_no"));
                $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "productname" ,$('#reqprosearch').jqxGrid('getcellvalue', rowindex2, "productname"));
                $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "prodoc" ,$('#reqprosearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
                $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "unit" ,$('#reqprosearch').jqxGrid('getcellvalue', rowindex2, "unit"));
                $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "unitdocno" ,$('#reqprosearch').jqxGrid('getcellvalue', rowindex2, "munit"));
                $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "psrno" ,$('#reqprosearch').jqxGrid('getcellvalue', rowindex2, "psrno"));  
                
                $('#datas1').val(1);

              var rows = $('#serviecGrid').jqxGrid('getrows');
                var rowlength= rows.length;
                if(rowindex1 == rowlength - 1)
                	{  
                $("#serviecGrid").jqxGrid('addrow', null, {});
                	} 
                	  
                
              $('#searchwndow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="reqprosearch"></div>