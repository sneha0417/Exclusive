<%@page import="com.dashboard.cargo.assignment.ClsAssignment"%>
<%
ClsAssignment assignment=new ClsAssignment();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String barchval=request.getParameter("barchval")==null?"0":request.getParameter("barchval");



%>
<script type="text/javascript">
var datas;
var id='<%=id%>';
$(document).ready(function () {
	if(id=='1'){
		datas='<%=assignment.gridDataLoad(barchval)%>';
	}
    var source =
    {
        datatype: "json",
        datafields: [   
						{name : 'doc_no', type: 'String'  },
                        {name : 'enqno', type: 'String'  },
						{name : 'jobno', type: 'String'  },
						{name : 'client', type: 'String'  },
						{name : 'billing', type: 'String'  },
						{name : 'vendor', type: 'String'  },
						{name : 'jobno', type: 'String'  },
						{name : 'refno', type: 'String'  },
						{name : 'salesman', type: 'String'  },
						{name : 'desc1', type: 'String'  },
						{name : 'pol', type: 'String'  },
						{name : 'pod', type: 'String'  },
						{name : 'qty', type: 'number'  },
						{name : 'mode', type: 'String'  },
						{name : 'smode', type: 'String'  },
						{name : 'shipment', type: 'String'  },
						{name : 'srvtype', type: 'String'  },
						{name : 'agto', type: 'String'  },
						{name : 'brhid', type: 'String'  },
						{name : 'jobtrno', type: 'String'  },
						{name : 'typeid', type: 'String'  },
						
						
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
        columnsresize: true,
        
        selectionmode: 'checkbox',
        pagermode: 'default',
        editable:false,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '4%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },	
          
                   /// doc_no, voc_no, date, type, expdeldt, qty, brand, model, color  
                     { text: 'ENQUIRY NO',datafield: 'enqno', width: '7%' },
         			 { text: 'JOB NO', datafield: 'jobno', width: '5%'},
         			 { text: 'CLIENT',datafield: 'client', width: '10%' },
         			{ text: 'SERVICE TYPE', datafield: 'srvtype',  width: '8%'}, 
         			{ text: 'QTY', datafield: 'qty',  width: '6%',cellsformat:'d2'  },
         			{ text: 'BILLING',datafield: 'billing', width: '6%' },
         			{ text: 'VENDOR',datafield: 'vendor', width: '10%' },
         			 
         			 { text: 'REF NO', datafield: 'refno', width: '6%'},
         			 { text: 'SALESMAN',datafield: 'salesman', width: '10%' },
         		     { text: 'DESCRIPTION', datafield: 'desc1',  width: '8%'  },
                     { text: 'POL', datafield: 'pol',  width: '7%'  },
                     { text: 'POD', datafield: 'pod',  width: '7%'  },
                     
           	         { text: 'MODE', datafield: 'mode',  width: '8%' }, 
           	         { text: 'SUB MODE', datafield: 'smode',  width: '8%' },
           	         { text: 'SHIPMENT', datafield: 'shipment',  width: '10%' },
           	         
           	      	 { text: 'doc_no', datafield: 'doc_no',  width: '6%' , hidden: true},
           	 	 { text: 'jobtrno', datafield: 'jobtrno',  width: '6%', hidden: true },
           	      	 
           	      
           	      	 
           	         { text: 'agto', datafield: 'agto',  width: '6%', hidden: true},
           	      { text: 'brhid', datafield: 'brhid',  width: '6%', hidden: true},
         	      { text: 'typeid', datafield: 'typeid',  width: '6%' , hidden: true}, 
           	   
           	      
					]
   
    });
    $("#overlay, #PleaseWait").hide();
    $('#jqxAssignmentgrid').on('rowselect', function (event){
    	var rowindextemp = event.args.rowindex;
    	$("#hiddocno").val($('#jqxAssignmentgrid').jqxGrid('getcellvalue', rowindextemp, "doc_no"));
    	$("#hidbrhid").val($('#jqxAssignmentgrid').jqxGrid('getcellvalue', rowindextemp, "brhid"));
    	$("#dat").val(new Date());
    	$('#asgmtdiv select').attr('disabled',false);
        $('#asgmtdiv input').attr('disabled',false);
    });
   
});


</script>
<div id="jqxAssignmentgrid"></div>