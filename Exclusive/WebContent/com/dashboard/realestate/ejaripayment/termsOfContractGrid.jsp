   

  <%@page import=" com.dashboard.realestate.tenancycontractposting.ClsTenancyContractPostingDAO" %>
<%ClsTenancyContractPostingDAO DAO=new ClsTenancyContractPostingDAO();
 
 
 
 String load = request.getParameter("load")==null?"0":request.getParameter("load"); 
  String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");%> 
 
 
  
<script type="text/javascript">
		 var data1111;  
        $(document).ready(function () { 
           
          
            var docno='<%=docno%>';
            
            
            
               if(docno>0)
            	 {
            	 data1111='<%=DAO.termsloading(docno)%>';  
            	 }
             var rendererstring=function (aggregates){
            	   	var value=aggregates['sum'];
            	   	if(value==""||typeof(value)=="undefined"|| typeof(value)=="NaN")
            		   {
            			value=0.0;
            		   }
            		
            	   	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
            	   }
                                
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'description', type: 'string'   },
     						{name : 'amount', type: 'number' },
     						{name : 'acno', type: 'string'   },
     						{name : 'docno', type: 'string'   },
     						{name : 'ftype', type: 'string'   },
     						
     						{name : 'vatper', type: 'number'   },
     						{name : 'vatvalue', type: 'number'   },
     						{name : 'total', type: 'number'   },
     						
     						{name : 'qty', type: 'number'   },
     						{name : 'atype', type: 'string'   },
     						
     						
                        ],
                         localdata: data1111,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#termsOfContractGridId").jqxGrid(
            {
                width: '99.5%',
                height: 190,
                source: dataAdapter,
                showaggregates:true,
                showstatusbar:true,
                statusbarheight: 21,
                filtermode:'excel',
                filterable: true,
                selectionmode: 'singlecell',
                pagermode: 'default',
                columnsresize:true,
                editable:false ,
              
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '10%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							}, 
							{ text: 'Doc', datafield: 'docno',  editable: false , width: '25%',hidden:true },
							{ text: 'Description', datafield: 'description',  editable: false  },	
							{ text: 'Value', datafield: 'amount', cellsformat: 'd2', width: '15%', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring  },
							{ text: 'Account', datafield: 'acno', editable: false, width: '12%' ,hidden:true },
							{ text: 'qty', datafield: 'qty', editable: false, width: '12%' ,hidden:true },
							{ text: 'ftype', datafield: 'ftype', editable: false, width: '12%' ,hidden:true },
							{ text: 'atype', datafield: 'atype', editable: false, width: '12%' ,hidden:true },
							
							{ text: 'Vat %', datafield: 'vatper', cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right'   },
							{ text: 'Vat Value', datafield: 'vatvalue', cellsformat: 'd2', width: '12%', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring  },
							{ text: 'Total', datafield: 'total', cellsformat: 'd2', width: '15%', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring  },
						]
            });
            
           
          
       
            
          
        });

</script>
<div id="termsOfContractGridId"></div>
    