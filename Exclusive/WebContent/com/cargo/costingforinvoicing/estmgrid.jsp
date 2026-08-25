<%@page import="com.cargo.costingforinvoicing.ClsCostingForInvoicingDAO"%>
<% ClsCostingForInvoicingDAO DAO = new ClsCostingForInvoicingDAO();  
String rdocno = request.getParameter("rdocno")==null?"0":request.getParameter("rdocno").trim();
 System.out.println("=====rdocno==aaaaaaaaaa==="+rdocno);
%>

<script type="text/javascript">
var reqdata1;
 
 
$(document).ready(function () {
	var id='<%=rdocno%>';
	if(id>0){
 	 
		reqdata1='<%=DAO.estmDataLoad(rdocno)%>';
		
 
	}
	
	  var rendererstring1=function (aggregates){
       	var value=aggregates['sum1'];
       	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total" + '</div>';
       }    
    
 var rendererstring=function (aggregates){
 	var value=aggregates['sum'];
 	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
 }
	var source =
	{
			datatype: "json",
			datafields: [
			             {name : 'sertype', type: 'string'},
			             {name : 'srvdocno', type: 'int'},
			             {name : 'currency', type: 'string'},
			             {name : 'rate', type: 'number'},
			             {name : 'price', type: 'number'},
			             {name : 'qty', type: 'number'},
			             {name : 'uom', type: 'stringt'},
			             {name : 'basetotal', type: 'number'},
			             {name : 'total', type: 'number'},
			             {name : 'billing', type: 'string'},
			             {name : 'vendor', type: 'string'},
			             {name : 'unitid', type: 'string'},
			             {name : 'vndid', type: 'string'},
			             {name : 'curid', type: 'string'},
			             {name : 'status', type: 'string'},
			             
			             
			             {name : 'name', type: 'string'},
			             {name : 'atype', type: 'string'},
			             
			             
			             {name : 'actype', type: 'string'},
			             {name : 'description', type: 'string'},
			             {name : 'account', type: 'string'},
			             {name : 'gr_type', type: 'string'},
			             
			             {name : 'acno', type: 'string'},
			             
			             
			           
			             
			              
                 ],
                 localdata: reqdata1,
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

 
            
            $("#jqxEstimation").jqxGrid(
            {
                width: '100%',
                height: 200,
                source: dataAdapter,
                editable: false,
                disabled:true,
                showaggregates:true,
                showstatusbar:true,
                
                statusbarheight: 21,
                pagermode: 'default',
               
                columns: [
                          
                          { text: 'SL#', sortable: false, filterable: false, editable: false,  
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },	
                          { text: 'Service Type', datafield: 'sertype', width: '12%', editable: false },	
      					  { text: 'Currency', datafield: 'currency', width: '5%', editable: false },	
      					  { text: 'Rate', datafield: 'rate', width: '8%', editable: false,cellsformat: 'd2', align: 'right', cellsalign: 'right',aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
      					  { text: 'Price', datafield: 'price', width: '8%',cellsformat: 'd2', align: 'right', cellsalign: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
						  { text: 'QTY', datafield: 'qty', width: '5%',cellsformat: 'd2' },	
						  { text: 'UOM', datafield: 'uom', width: '5%', editable: false },
						  { text: 'Total', datafield: 'total', width: '10%',cellsformat: 'd2', align: 'right', cellsalign: 'right' , editable: false,aggregates: ['sum'],aggregatesrenderer:rendererstring},	
						  { text: 'Base Total', datafield: 'basetotal', width: '10%',cellsformat: 'd2', align: 'right', cellsalign: 'right', editable: false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
						  { text: 'Billing', datafield: 'billing' , width: '8%'  },
						  
						  { text: 'Assigned Type ', datafield: 'atype', width: '8%'   },	
						  { text: 'Asign To', datafield: 'name'   },	
						  
						  
						  { text: 'actype', datafield: 'actype' , width: '8%'  ,hidden:true  },	
						  { text: 'description', datafield: 'description' , width: '8%'  ,hidden:true    },	
						  { text: 'account', datafield: 'account'  , width: '8%' ,hidden:true    },	
						  { text: 'gr_type', datafield: 'gr_type'  , width: '8%'  ,hidden:true   },	
						  
						  { text: 'acno', datafield: 'acno'  , width: '8%',hidden:true     },	
						   
						  
						  
						  
						   
				             
						  
						 /*  { text: 'Vendor', datafield: 'vendor', width: '14%', editable: false},
						  { text: 'srvdocno', datafield: 'srvdocno', width: '12%',hidden: true },
						  { text: 'unitid', datafield: 'unitid', width: '12%',hidden: true },
						  { text: 'vndid', datafield: 'vndid', width: '12%',hidden: true },
						  { text: 'curid', datafield: 'curid', width: '12%',hidden: true },
						  { text: 'status', datafield: 'status', width: '12%',hidden: true }, */
			              ]
               
            });
           
            
            if(($('#mode').val()=='A')||($('#mode').val()=='E'))
    		{
    		  $("#jqxEstimation").jqxGrid({ disabled: false}); 
    		}
            
            
            
     
        	
 
            
         		  
}); 
 
    </script>
    <div id="jqxEstimation"></div>
  <input type="hidden" id="rowindex"/> 