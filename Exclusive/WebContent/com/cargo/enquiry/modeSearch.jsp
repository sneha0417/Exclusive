<%@page import="com.cargo.enquiry.ClscargoEnquiryDAO" %>

<%ClscargoEnquiryDAO cargoEnquiryDAO=new ClscargoEnquiryDAO(); %>
 <script type="text/javascript">
			 
		  	 var barnddata='<%=cargoEnquiryDAO.searchmode()%>';
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                             
                            {name : 'modename', type: 'string'  },
                            {name : 'doc_no', type: 'string'  }
     						
                        ],
                		
                		//  url: url1,
                 localdata: barnddata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxmodeSearch").jqxGrid(
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
							
							 
                          
                              { text: 'DOC NO', datafield: 'doc_no', width: '10%',hidden:true},
                            
                              { text: 'MODE ', datafield: 'modename', width: '100%' }
						
			
	             
						]
            });
            
          $('#jqxmodeSearch').on('rowdoubleclick', function (event) {
            	var rowindex1 =$('#rowindex').val();
            	// alert(rowindex1);
                var rowindex2 = event.args.rowindex;
                $('#jqxEnquiry').jqxGrid('setcellvalue', rowindex1, "mode" ,$('#jqxmodeSearch').jqxGrid('getcellvalue', rowindex2, "modename"));
                $('#jqxEnquiry').jqxGrid('setcellvalue', rowindex1, "modeid" ,$('#jqxmodeSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
                $('#jqxEnquiry').jqxGrid('setcellvalue', rowindex1, "submode" ,'');

                $('#jqxEnquiry').jqxGrid('setcellvalue', rowindex1, "smodeid" ,''); 
                $('#jqxEnquiry').jqxGrid('setcellvalue', rowindex1, "terms" ,'');
                $('#jqxEnquiry').jqxGrid('setcellvalue', rowindex1, "termid" ,'');
                
                var rows = $('#jqxEnquiry').jqxGrid('getrows');
                var rowlength= rows.length;
                if(rowindex1==rowlength-1)
                {
                	  $("#jqxEnquiry").jqxGrid('addrow', null, {});	
                }
              
                document.getElementById("errormsg").innerText="";
                
                
              $('#modesearchwndow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="jqxmodeSearch"></div>