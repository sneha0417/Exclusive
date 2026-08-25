
 <%@page import="com.dashboard.audit.salesinvoiceaudit.ClsSalesInvoiceAuditDAO"%>
 <% ClsSalesInvoiceAuditDAO searchDAO = new ClsSalesInvoiceAuditDAO(); 
 
    String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  
  	String acno = request.getParameter("acno")==null?"NA":request.getParameter("acno").trim();
  	
  	String statusselect = request.getParameter("statusselect")==null?"0":request.getParameter("statusselect").trim();
  	
  	
  	String aa = request.getParameter("aa")==null?"0":request.getParameter("aa").trim();
  	String type = request.getParameter("type")==null?"0":request.getParameter("type").trim();
 %> 
       
 
<script type="text/javascript">
 var temp4='<%=barchval%>';
var datas;

 if(temp4!='NA')
{ 
	
	 datas='<%=searchDAO.saleauditsearch(barchval,fromdate,todate,statusselect,acno,type,aa)%>';
	 
 
	 
		// alert(enqdata); --%>
} 
else
{ 
	
	datas;
	 
	
	}  

$(document).ready(function () {
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
                     
                     {name : 'doc_no', type: 'int'  },
                        {name : 'voc_no', type: 'int'  },
						{name : 'date', type: 'date'  },
					 
						{name : 'refno', type: 'String'  },
						
					 
						 
	 
						{name : 'nettotal', type: 'number'  },
						
						{name : 'account', type: 'String'  },      
						{name : 'acname', type: 'String'  }, 
					 
						
						
				 
			 
						
						],
				    localdata: datas,
        
        
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
    
    
   
   
    
    $("#invlist").jqxGrid(
    {
        width: '98%',
        height: 560,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        
        showaggregates:true,
        showstatusbar:true,
        
        statusbarheight: 21,
        
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '5%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },	
          
  
                     { text: 'Doc No',datafield: 'voc_no', width: '10%' },
         			 { text: 'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy'},
         			 { text: 'Ref No',datafield: 'ref_no', width: '15%' },
        
         		     { text: 'Account', datafield: 'account',  width: '10%'  },
                     { text: 'Account Name', datafield: 'acname'   },
     		   { text: 'Total Amount', datafield: 'nettotal',  width: '12%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
							
 
					
					]
   
    });
    $("#overlay, #PleaseWait").hide();
    
    if(temp4=='NA')
    {
   	 $("#invlist").jqxGrid("addrow", null, {});
    }
    	
    	
    
    
    $('#invlist').on('rowdoubleclick', function (event) {
        var rowindex1 = event.args.rowindex;
        $("#btnaudit").attr('disabled', false ); 
        document.getElementById("docnos").value = $('#invlist').jqxGrid('getcellvalue', rowindex1, "doc_no");
       
    });
});


</script>
<div id="invlist"></div>