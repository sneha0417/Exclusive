<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.realestate.reports.ClsReportsDAO"%>
<% ClsReportsDAO DAO= new ClsReportsDAO(); %>
<%   
	String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
%>

<script type="text/javascript">
       var padata;
		padata='<%=DAO.getPropertyData(id)%>'; 

$(document).ready(function () {
	
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
							{name : 'type', type: 'String'  },
							{name : 'total', type: 'number'  },
							{name : 'available', type: 'number'  },
							{name : 'contract', type: 'number'  },
							{name : 'expiry1', type: 'number'  },
							{name : 'expiry2', type: 'number'  },
							{name : 'forsale', type: 'number'  },
						],
				    localdata: padata,   
        
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
    
    $("#pagrid").jqxGrid(
    {
        width: '100%',
        height: 210,           
        source: dataAdapter,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        columnsresize: true,
       	selectionmode: 'singlecell',                 
       	showfilterrow: true,
        sortable:true,                                
        pagermode: 'default',   
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '4%' ,
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },
               { text: 'Type', datafield: 'type'},  //,  width: '40.5%'
               { text: 'Total', datafield: 'total',  width: '9%',cellsalign:'right',align:'right',cellsformat:'d2'},  
               { text: 'Available', datafield: 'available',  width: '9%',cellsalign:'right',align:'right',cellsformat:'d2'},  
               { text: 'Contract', datafield: 'contract',  width: '9%',cellsalign:'right',align:'right',cellsformat:'d2'},  
               { text: 'Expiry 0-30', datafield: 'expiry1',  width: '9%',cellsalign:'right',align:'right',cellsformat:'d2'},  
               { text: '30-60', datafield: 'expiry2',  width: '9%',cellsalign:'right',align:'right',cellsformat:'d2'},          
               { text: 'For Sale', datafield: 'forsale',  width: '9%',cellsalign:'right',align:'right',cellsformat:'d2'},  
    ]		 
    });
    $("#overlay, #PleaseWait").hide();   
    $('#pagrid').on('celldoubleclick', function (event){ 
	           	var rowindex1=event.args.rowindex;
	           	var datafield = event.args.datafield;
	           	var protype=$('#pagrid').jqxGrid('getcellvalue', rowindex1, "type");
	            $("#hideprodetails").show();
	           	if(datafield=="total"){   
		              var type="TO";
		              loadprodet(type,protype);
           	    }
	           	if(datafield=="forsale"){           
		              var type="FO";
		              loadprodet(type,protype);
	           	    }
	           	if(datafield=="available"){   
		              var type="AV";
		              loadprodet(type,protype);
	           	    }
	           	if(datafield=="contract"){   
		              var type="CO";
		              loadprodet(type,protype);
	           	    }
	           	if(datafield=="expiry1"){   
		              var type="E1";
		              loadprodet(type,protype);
	           	    }
	           	if(datafield=="expiry2"){   
		              var type="E2";
		              loadprodet(type,protype);   
	           	    }
       		 }); 
});
</script>
<div id="pagrid"></div>