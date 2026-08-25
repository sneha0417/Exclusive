 
   <%@page import="com.cargo.enquiry.ClscargoEnquiryDAO" %>
 <%ClscargoEnquiryDAO cargoEnquiryDAO=new ClscargoEnquiryDAO(); %>
   
	  <script type="text/javascript">
  
	  <%	String modeval=request.getParameter("modeval")==null?"0":request.getParameter("modeval");%>
			
		  	 
			var modeldata='<%=cargoEnquiryDAO.searchsubmode(modeval)%>';
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'submode1', type: 'string'  },
                           {name : 'doc_no', type: 'string'  }
     						
                        ],
                		
                		//  url: url1,
                 localdata: modeldata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxsubmodeSearch").jqxGrid(
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
                              { text: 'SUBMODE', datafield: 'submode1', width: '100%' }
                             
						
						
	             
						]
            });
            
          $('#jqxsubmodeSearch').on('rowdoubleclick', function (event) {
            	var rowindex3 =$('#rowindex').val();
            	// alert("ggggggg"+rowindex3);
                var rowindex2 = event.args.rowindex;
                $('#jqxEnquiry').jqxGrid('setcellvalue', rowindex3, "submode" ,$('#jqxsubmodeSearch').jqxGrid('getcellvalue', rowindex2, "submode1"));

                $('#jqxEnquiry').jqxGrid('setcellvalue', rowindex3, "smodeid" ,$('#jqxsubmodeSearch').jqxGrid('getcellvalue', rowindex2, "doc_no")); 
              $('#submodesearchwndow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="jqxsubmodeSearch"></div>