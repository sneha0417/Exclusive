<%@page import="com.aviation.fuelinginformation.ClsfuelingInformationDAO" %>

<%ClsfuelingInformationDAO fuelinfoDAO=new ClsfuelingInformationDAO(); %>
 <script type="text/javascript">
			 
		  	 var barnddata='<%=fuelinfoDAO.searchPort()%>';
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                             
                            {name : 'port', type: 'string'  },
                            {name : 'portnam', type: 'string'  },
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
							
							 
                          
                              { text: 'DOC NO', datafield: 'doc_no', width: '20%',hidden:true},
                              { text: 'PORT ', datafield: 'port', width: '50%' },
                              { text: 'PORT NAME', datafield: 'portnam', width: '50%' },
                              { text: 'REGION  ', datafield: 'region', width: '60%',hidden:true }
						
			
	             
						]
            });
            
          $('#Jqxportsearch').on('rowdoubleclick', function (event) {
            	var rowindex1 =$('#rowindex').val();
            	// alert(rowindex1);
                var rowindex2 = event.args.rowindex;
                $('#jqxFuelInfo').jqxGrid('setcellvalue', rowindex1, "portname" ,$('#Jqxportsearch').jqxGrid('getcellvalue', rowindex2, "portnam"));
                $('#jqxFuelInfo').jqxGrid('setcellvalue', rowindex1, "port" ,$('#Jqxportsearch').jqxGrid('getcellvalue', rowindex2, "port"));
                
                $('#jqxFuelInfo').jqxGrid('setcellvalue', rowindex1, "portid" ,$('#Jqxportsearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
                
                
                var rows = $('#jqxFuelInfo').jqxGrid('getrows');
            	var rowlength= rows.length;
            	var rowindex1 = rowlength - 1;
          	    var portId=$("#jqxFuelInfo").jqxGrid('getcellvalue', rowindex1, "portid");
          	    if(typeof(portId) != "undefined"){
                $("#jqxFuelInfo").jqxGrid('addrow', null, {});
          	    }
                
                
              $('#portsearch1').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="Jqxportsearch"></div>