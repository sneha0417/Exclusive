
<%@page import="com.dashboard.cargo.assignmentfolloup.ClsassignmentFolloup" %>
<%ClsassignmentFolloup cfar=new ClsassignmentFolloup();
String id=request.getParameter("check")==null?"0":request.getParameter("check");
%>
<script type="text/javascript">
var datas;
var id='<%=id%>';
$(document).ready(function () {
	if(id=='1'){
		<%-- datas='<%=cfar.gridDataLoad()%>'; --%>
	}
    var source =
    {
        datatype: "json",
        datafields: [   
						{name : 'psrno', type: 'number'  },
                        {name : 'date', type: 'date'  },
						{name : 'productid', type: 'String'  },
						{name : 'name', type: 'String'  },
						{name : 'dtype', type: 'String'  },
						{name : 'stock_qty', type: 'String'  },
						{name : 'sbatchno', type: 'String'  },
						{name : 'expirydate', type: 'date'  },
						{name : 'qty', type: 'String'  },
						{name : 'batchno', type: 'number'  },
						{name : 'expdate', type: 'String'  },
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
    
    $("#jqxAssignmentgrid").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        showfilterrow: true,
        sortable:true,
        
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        columns: [   
                     { text: 'SR',datafield: 'psrno', width: '7%' },
         			 { text: 'DATE', datafield: 'date', width: '6%'},
         			 { text: 'PRODUCT_ID',datafield: 'productid', width: '10%' },
         			 { text: 'PRODUCT NAME', datafield: 'name', width: '13%'},
         			 { text: 'DTYPE',datafield: 'dtype', width: '10%' },
         		     { text: 'STOCK QTY', datafield: 'stock_qty',  width: '8%' ,editable: false },
                     { text: 'BATCH NO', datafield: 'sbatchno',  width: '12%' ,editable: false },
                     { text: 'EXPIRY DATE', datafield: 'expirydate',  width: '12%',editable: false  },
                     { text: 'QTY', datafield: 'qty',  width: '12%',cellsformat: 'd2'  },
           	         { text: 'BATCH NO', datafield: 'batchno',  width: '13%' }, 
           	         { text: 'EXPDATE', datafield: 'expdate',  width: '10%' },
           	         ]
   
    });
    $("#overlay, #PleaseWait").hide();
    $('#jqxAssignmentgrid').on('rowdoubleclick', function (event){
    	var rowindextemp = event.args.rowindex;
    	
    	$("#doc_no").val($('#jqxAssignmentgrid').jqxGrid('getcellvalue', rowindextemp, "doc_no"));
    });
   
});


</script>
<div id="jqxAssignmentgrid"></div>