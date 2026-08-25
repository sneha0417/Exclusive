 
 <%@page import="com.cargo.enquiry.ClscargoEnquiryDAO" %>

<%ClscargoEnquiryDAO cargoEnquiryDAO=new ClscargoEnquiryDAO(); %>

       <script type="text/javascript">
       <%	String modeval=request.getParameter("modeval")==null?"0":request.getParameter("modeval");%>
			
		  	 
			var tdata='<%=cargoEnquiryDAO.searchterm(modeval)%>';
			
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            
                            {name : 'term', type: 'string'  },
                            {name : 'doc_no', type: 'string'  }
     						
                        ],
                		
                		//  url: url1,
                 localdata: tdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#enqtermSearch").jqxGrid(
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
                              { text: 'TERM', datafield: 'term', width: '100%' },
                           
						
						
	             
						]
            });
            
          $('#enqtermSearch').on('rowdoubleclick', function (event) {
            	var rowindex1 =$('#rowindex').val();
            	// alert(rowindex1);
                var rowindex2 = event.args.rowindex;
                $('#jqxEnquiry').jqxGrid('setcellvalue', rowindex1, "terms" ,$('#enqtermSearch').jqxGrid('getcellvalue', rowindex2, "term"));
                $('#jqxEnquiry').jqxGrid('setcellvalue', rowindex1, "termid" ,$('#enqtermSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
                
                
              $('#termsearchwndow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="enqtermSearch"></div>