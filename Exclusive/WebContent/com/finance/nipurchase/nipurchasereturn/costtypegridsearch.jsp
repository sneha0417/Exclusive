<%@page import="com.finance.nipurchase.nipurchase.ClsnipurchaseDAO" %>
 
<%

ClsnipurchaseDAO viewDAO=new ClsnipurchaseDAO();

%>
       <script type="text/javascript">
  
			 var costtype= '<%=viewDAO.searchCosttype() %>';
		$(document).ready(function () { 	
 
        	
           
           
            var source =
            {
                datatype: "json",  
                datafields: [
                            
                            {name : 'costtype', type: 'string'  },
                            {name : 'costgroup', type: 'string'  }
     						
                        ],
            
                 localdata: costtype,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#costtypeSearch").jqxGrid(
            {
                width: '100%',
                height: 360,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
               // editable:true,
                selectionmode: 'singlecell',
            
                
            
                       
                columns: [
							
							 
                          
                              { text: 'Cost Type', datafield: 'costtype', width: '20%',hidden:true},
                              { text: 'Cost Group', datafield: 'costgroup', width: '100%' },
                           
						
						
	             
						]
            });
            
             
          $('#costtypeSearch').on('celldoubleclick', function (event) {
        	
        	     //$('#nidescdetailsGrid').jqxGrid('clearselection');
        	     $('#nidescdetailsGrid').jqxGrid('setcellvalue', rowindex1, "costtype" ,"");
                 $('#nidescdetailsGrid').jqxGrid('setcellvalue', rowindex1, "costgroup" ,"");
               //  alert($('#costtypeSearch').jqxGrid('getcellvalue', rowindex2, "costtype"));
                // alert($('#costtypeSearch').jqxGrid('getcellvalue', rowindex2, "costgroup"));
            	var rowindex1 =$('#rowindex').val();
       
                var rowindex2 = event.args.rowindex;
               
                $('#nidescdetailsGrid').jqxGrid('setcellvalue', rowindex1, "costtype" ,$('#costtypeSearch').jqxGrid('getcellvalue', rowindex2, "costtype"));
                $('#nidescdetailsGrid').jqxGrid('setcellvalue', rowindex1, "costgroup" ,$('#costtypeSearch').jqxGrid('getcellvalue', rowindex2, "costgroup"));
                $('#nidescdetailsGrid').jqxGrid('setcellvalue', rowindex1, "costcode","");
                
                
              $('#costtpesearchwndow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="costtypeSearch"></div> 