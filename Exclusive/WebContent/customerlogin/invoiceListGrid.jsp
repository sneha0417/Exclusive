<%@page import="customerlogin.ClsCustomerLoginDAO"%>
<% String contextPath=request.getContextPath();%>
<%
String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
String acno = request.getParameter("acno")==null?"0":request.getParameter("acno").trim();
String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();  
String ownerdocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").trim();  
ClsCustomerLoginDAO cild=new ClsCustomerLoginDAO();
%>
 
<style type="text/css">
	.yellowClass{
    	background-color: #ffc0cb; 
        /*   background-color: #eedd82;  */
    }
</style>
<script type="text/javascript">
var id='<%=id%>';
var invoicedata;
if(id=="1"){
	invoicedata='<%=cild.invoicelist(fromDate,toDate,acno,id,ownerdocno)%>';
}
$(document).ready(function () {
	var rendererstring=function (aggregates){
     	var value=aggregates['sum'];
     	if(value=='' || value=='undefined' || typeof(value)=='undefined'){
     		value='0.00';
     	}
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "" + ' ' + value + '</div>';
	}
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                      	{name : 'docno' , type: 'number' },
                  		{name : 'vocno' , type: 'number' },
						{name : 'branchname', type: 'String'    },
						{name : 'date', type: 'date'  },
						{name : 'reftype', type: 'string'  },
						{name : 'refno', type: 'string'  },
						{name : 'property', type: 'String'  },
						{name : 'owner', type: 'String'  },
						{name : 'desc1', type: 'string'  },
						{name : 'nettotal', type: 'number'  },
						{name : 'taxamount', type: 'number'  },
						{name : 'taxtotal', type: 'number'  },
						{name : 'brhid',type:'number'}
						
						],
				    localdata: invoicedata,
        
        
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
    
    
    $("#invoiceListGrid").jqxGrid(
    {
        width: '100%',
        height: 400,
        source: dataAdapter,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 25,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       	sortable:true,
        columns: [
                  
						{ text: 'SL#', sortable: false, filterable: false, editable: false, 
					    	groupable: false, draggable: false, resizable: false,
					    	datafield: 'sl', columntype: 'number', width: '5%',
					    	cellsrenderer: function (row, column, value) {
					        	return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					    	}  
					  	},
                        { text: 'Doc No', datafield: 'docno', width: '10%',hidden:true},
						{ text: 'Branch', datafield: 'branchname', width: '10%'},  			
						{ text: 'Branch Id', datafield: 'brhid', width: '10%',hidden:true},  						
      					{ text: 'Doc No', datafield: 'vocno', width: '7%' },
      					{ text: 'Date', datafield: 'date', width: '8%',cellsformat:'dd.MM.yyyy'},
						{ text: 'Ref Type', datafield: 'reftype', width: '5%'},
						{ text: 'Ref No', datafield: 'refno', width: '4%'},
						{ text: 'Property', datafield: 'property', width: '10%',hidden:true},
						{ text: 'Owner', datafield: 'owner', width: '10%',hidden:true},
						{ text: 'Remarks', datafield: 'desc1', width: '40%'},
						{ text: 'Total', datafield: 'nettotal', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'Tax', datafield: 'taxamount', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'Net Total', datafield: 'taxtotal', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
					]

    });

    $('.page-loader button').hide();
    
    $("#popupWindow2").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
	// create context menu
 	var contextMenu = $("#Menu2").jqxMenu({ width: 200, height: 50, autoOpenPopup: false, mode: 'popup'});
	$("#invoiceListGrid").on('contextmenu', function () {
   		return false;
	});
	
 	$("#Menu2").on('itemclick', function (event) {
  		var args = event.args;
     	var rowindex = $("#invoiceListGrid").jqxGrid('getselectedrowindex');
     	if ($.trim($(args).text()) == "Print") {
         	var docno=$("#invoiceListGrid").jqxGrid("getcellvalue",rowindex,"docno");
         	var win= window.open("<%=contextPath%>/com/operations/commtransactions/travelinvoice/printtravelinvoice?&docno="+docno,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
			win.focus();
			win.print();
   		}
   		else if($.trim($(args).text()) == "View Attachments"){
   			var dtype="TINV";
   			var frmname=funGetFormname(dtype);
            var docno=$("#invoiceListGrid").jqxGrid("getcellvalue",rowindex,"vocno");
            var brhid=$("#invoiceListGrid").jqxGrid("getcellvalue",rowindex,"brhid");
           	var myWindow=window.open("<%=contextPath%>/com/common/AttachMasterClient.jsp?formCode="+dtype+"&docno="+docno+"&brchid="+brhid+"&frmname="+frmname,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
			myWindow.focus();
        }
	});
	$("#invoiceListGrid").on('rowclick', function (event) {
    	if (event.args.rightclick) {
  			$("#invoiceListGrid").jqxGrid('selectrow', event.args.rowindex);
        	var scrollTop = $(window).scrollTop();
        	var scrollLeft = $(window).scrollLeft();
        	contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
        	return false;
		}
	});
});

	
	
</script>
<div id='jqxWidget2'>
    <div id="invoiceListGrid"></div>
    <div id="popupWindow2">
		<div id='Menu2'>
        	<ul>
            	<li>Print</li>
            	<li>View Attachments</li>
        	</ul>
       	</div>
   	</div>
</div>


