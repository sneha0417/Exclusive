<%@page import="com.dashboard.cargo.invoiceprocessing.ClsInvoiceProcessing"%>
<%
ClsInvoiceProcessing DAO=new ClsInvoiceProcessing();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String cldocno=request.getParameter("client")==null?"0":request.getParameter("client");
String jobno=request.getParameter("jobno")==null?"0":request.getParameter("jobno");
String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
%>
<% String contextPath=request.getContextPath();%>
<script type="text/javascript">
var griddata;
var id='<%=id%>';
var temp4='<%=barchval%>';
$(document).ready(function () {
	if(id=='1'){
		griddata='<%=DAO.gridData(cldocno,barchval)%>';
	}
	var rendererstring1=function (aggregates){
       	var value=aggregates['sum1'];
       	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Net Total" + '</div>';
       }
 
	var rendererstring=function (aggregates){
		var value=aggregates['sum'];
		return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">'  + value + '</div>';
	}
    var source =
    {
        datatype: "json",
        datafields: [   
						{name : 'doc_no', type: 'String'  },
						{name : 'cdifdno', type: 'String'  },
						{name : 'jobno', type: 'String'  },
						{name : 'client', type: 'String'  },
						{name : 'qotno', type: 'String'  },
						{name : 'pol', type: 'String'  },
						{name : 'pod', type: 'String'  },
						{name : 'description', type: 'String'  },
						
						{name : 'type', type: 'string'  },
						{name : 'account', type: 'string'    },
						{name : 'accname', type: 'string'    },
						{name : 'qty', type: 'int'    },
						{name : 'unitprice', type: 'number'    },
						{name : 'total', type: 'number'    },
						{name : 'discount', type: 'number'    },
						{name : 'nettotal', type: 'number'    },
						{name : 'costtype', type: 'string'    },
						{name : 'costgroup', type: 'string'    },
						
						{name : 'costcode', type: 'number'    },
						{name : 'nuprice', type: 'number'    },
						{name : 'remarks', type: 'string'    },
						
						
						{name : 'headdoc', type: 'number'    },
						{name : 'qutval', type: 'number'    },
						{name : 'grtype', type: 'number'    },
						 {name : 'taxper', type: 'number'  },  
    					 {name : 'taxamount', type: 'number'  },
    					{name : 'taxperamt', type: 'number'  },
    					
    					
    					{name : 'idno', type: 'number'  },
						],
				    localdata: griddata,
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
    
    $("#jqxInvProcessing").jqxGrid(
    {
        width: '100%',
        height: 530,
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
         			 { text: 'JOB NO', datafield: 'jobno', width: '5%'},
         			 { text: 'CLIENT', datafield: 'client',  width: '22%'},
         			 { text: 'QUOTATION NO', datafield: 'qotno', width: '8%'},
         			 { text: 'POL', datafield: 'pol', width: '11%'},
         			 { text: 'POD',datafield: 'pod', width: '11%' },
         			 { text: 'Description', datafield: 'description',  width: '22%'},
         			 { text: 'Qty', datafield: 'qty', width: '3%', cellsalign: 'left', align:'left',editable: true},
         			 { text: 'Unit Price', datafield: 'unitprice', width: '5%',cellsalign: 'right', align:'right',cellsformat:'d2',editable: true },
         			 { text: 'doc_no', datafield: 'doc_no',  width: '4%', hidden: true},
         			 { text: 'cdifdno', datafield: 'cdifdno',  width: '4%', hidden: true},
					/* { text: 'Total', datafield: 'total', width: '5%',cellsformat:'d2',cellsalign: 'right', align:'right', editable:false},
					{ text: 'Discount', datafield: 'discount', width: '4%',cellsalign: 'right', align:'right',cellsformat:'d2',editable: true ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
					{ text: 'Net Total', datafield: 'nettotal', width: '5%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,editable:false},
					{ text: 'Tax %', datafield: 'taxper', width: '3%', cellsformat: 'd2', cellsalign: 'right', align: 'right'  ,editable: true},
					{ text: 'Tax Amount', datafield: 'taxperamt', width: '6%', cellsformat: 'd2'  , cellsalign: 'right', align: 'right'  ,editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring}, */
					{ text: 'Net Total', datafield: 'taxamount', width: '6%', cellsformat: 'd2', cellsalign: 'right', align: 'right'  ,aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable:false },
					
					/* { text: 'Type', datafield: 'type', width: '6%', cellsalign: 'center',align: 'center'}, 
					{ text: 'Account', datafield: 'account', width: '4%' ,editable: false,cellsalign: 'center', align:'center'},
					{ text: 'Account Name', datafield: 'accname'  ,editable: false},
					{ text: 'Remarks', datafield: 'remarks', width: '19%' ,editable: true}, */
					]
   
    });
    $("#overlay, #PleaseWait").hide();
    $('#jqxInvProcessing').on('rowdoubleclick', function (event){
    	var rowindextemp = event.args.rowindex;
    	var docno=$('#jqxInvProcessing').jqxGrid('getcellvalue',rowindextemp,'doc_no');
    	var trno=$('#jqxInvProcessing').jqxGrid('getcellvalue',rowindextemp,'tr_no');
    	$("#enquirydiv").load("enquiryGrid.jsp?docno="+trno);
    	$("#srvcdiv").load("estmgrid.jsp?docno="+trno);
    });
    $('#jqxInvProcessing').on('cellclick', function (event){
	    var datafield=event.args.datafield;
	    var rowindex1=event.args.rowindex;
    	if(datafield=="attach"){
			var brchid=$("#jqxInvProcessing").jqxGrid('getcellvalue', rowindex1, "branch"); 
			var docno=$("#jqxInvProcessing").jqxGrid('getcellvalue', rowindex1, "jobno");
			var frmdet="SJOB";
			if ($("#docno").val()!="") {
		   		var  myWindow= window.open("<%=contextPath%>/com/common/Attachmaster.jsp?formCode="+frmdet+"&docno="+docno+"&brchid="+brchid,
				   "_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
				myWindow.focus();
		
			} else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
		    }
			 
	    }
    });
   
});


</script>
<div id="jqxInvProcessing"></div>