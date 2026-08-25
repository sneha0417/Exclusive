<%@page import="com.project.execution.ServiceSale.ClsServiceSaleDAO" %>



	
<%

ClsServiceSaleDAO viewDAO=new ClsServiceSaleDAO();
%>
 
<%-- 
 <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
 <script type="text/javascript">
 
 


	 var descdata1='<%=viewDAO.termssearch()%>'; 
	
        $(document).ready(function () { 	
       
            
       
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						
							    {name : 'atype', type: 'string'  },
								{name : 'acno', type: 'number'    },
								{name : 'account', type: 'string'    },
								{name : 'description', type: 'string'    },
								{name : 'desc1', type: 'string'    },
							 
								{name : 'idno', type: 'number'    },
								{name : 'grtype', type: 'int'  },
								
     						
     						
                 ],
              
                 localdata: descdata1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			            
		            }		
            );

            
            
            $("#slnosearch").jqxGrid(
            {
            	 width: '100%',
                 height: 355,
                 source: dataAdapter,
             
                 editable: false,
                 showfilterrow: true, 
                 filterable: true, 
                 selectionmode: 'singlerow',
                 pagermode: 'default',
                
                         
                
                columns: [
                

                            { text: 'SR NO', datafield: 'idno', width: '10%' },
                      	    { text: 'Type', datafield: 'atype', width: '10%' ,hidden:true},
                      	    
                      		{ text: 'Description', datafield: 'desc1', width: '25%' },
                      	    
							{ text: 'Account', datafield: 'account', width: '10%' },
							{ text: 'Account Name', datafield: 'description' },
							 
							{ text: 'grtype', datafield: 'grtype', width: '8%',hidden:true  }
						
	              ]
            });
           
  
            
 			
            
            $('#slnosearch').on('rowdoubleclick', function (event) {
                
           	 var  rowindex2=event.args.rowindex;
 
           	
           $('#nidescdetailsGrid').jqxGrid('setcellvalue',$('#rowindex1').val(), "type",$('#slnosearch').jqxGrid('getcellvalue', rowindex2, "atype"));
           
          $('#nidescdetailsGrid').jqxGrid('setcellvalue',$('#rowindex1').val(), "idno",$('#slnosearch').jqxGrid('getcellvalue', rowindex2, "idno"));  
             $('#nidescdetailsGrid').jqxGrid('setcellvalue',$('#rowindex1').val(), "account",$('#slnosearch').jqxGrid('getcellvalue', rowindex2, "account"));
             $('#nidescdetailsGrid').jqxGrid('setcellvalue',$('#rowindex1').val(), "accname",$('#slnosearch').jqxGrid('getcellvalue', rowindex2, "description")); 
             $('#nidescdetailsGrid').jqxGrid('setcellvalue',$('#rowindex1').val(), "description",$('#slnosearch').jqxGrid('getcellvalue', rowindex2, "desc1"));
             
             $('#nidescdetailsGrid').jqxGrid('setcellvalue',$('#rowindex1').val(), "headdoc",$('#slnosearch').jqxGrid('getcellvalue', rowindex2, "acno"));
             
             $('#nidescdetailsGrid').jqxGrid('setcellvalue',$('#rowindex1').val(), "grtype",$('#slnosearch').jqxGrid('getcellvalue', rowindex2, "grtype"));
           
         	var rowindex1 =$('#rowindex1').val();
            
          var rows = $('#nidescdetailsGrid').jqxGrid('getrows');
            var rowlength= rows.length;
            if(rowindex1 == rowlength - 1)
            	{  
            $("#nidescdetailsGrid").jqxGrid('addrow', null, {});
            	} 
             
             
             $('#nipurchslnosearch').jqxWindow('close');
           }); 
           

 
        });
    </script>
    <div id="slnosearch"></div>
   <input type="hidden" id="rowindex"/> 