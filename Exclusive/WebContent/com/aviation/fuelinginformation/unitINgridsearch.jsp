<%@page import="com.aviation.fuelinginformation.ClsfuelingInformationDAO" %>

<%ClsfuelingInformationDAO fuelinfoDAO=new ClsfuelingInformationDAO(); %>
 <script type="text/javascript">
			 
		  	 var barnddata='<%=fuelinfoDAO.searchUnit()%>';
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                             
                            {name : 'unit', type: 'string'  },
                            {name : 'unit_desc', type: 'string'  },
                            {name : 'doc_no', type: 'string'  }
     						
                        ],
                		
                		//  url: url1,
                 localdata: barnddata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#Jqxunitsearch").jqxGrid(
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
                              { text: 'UNIT ', datafield: 'unit', width: '40%' },
                              { text: 'UNIT NAME ', datafield: 'unit_desc', width: '60%' }
						
			
	             
						]
            });
            
          $('#Jqxunitsearch').on('rowdoubleclick', function (event) {
            	var rowindex1 =$('#rowindex').val();
            	// alert(rowindex1);
                var rowindex2 = event.args.rowindex;
                $('#jqxFuelInfo').jqxGrid('setcellvalue', rowindex1, "unit" ,$('#Jqxunitsearch').jqxGrid('getcellvalue', rowindex2, "unit"));
                $('#jqxFuelInfo').jqxGrid('setcellvalue', rowindex1, "unitid" ,$('#Jqxunitsearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
                
                
//                 var rows = $('#jqxFuelInfo').jqxGrid('getrows');
//                 var rowlength= rows.length;
//                 if(rowindex1==rowlength-1)
//                 {
//                 	  $("#jqxFuelInfo").jqxGrid('addrow', null, {});	
//                 }
              
//                 document.getElementById("errormsg").innerText="";
                
                
              $('#unitsearch1').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="Jqxunitsearch"></div>