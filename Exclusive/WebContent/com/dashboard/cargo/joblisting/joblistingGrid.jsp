<%@page import="com.dashboard.cargo.joblisting.ClsJobListing"%>
<%
ClsJobListing jobDAO=new ClsJobListing();
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
		griddata='<%=jobDAO.gridDataLoad(cldocno,jobno,id,barchval)%>';
	}
    var source =
    {
        datatype: "json",
        datafields: [   
						{name : 'doc_no', type: 'String'  },
						{name : 'qotno', type: 'String'  },
						{name : 'jobno', type: 'String'  },
						{name : 'date', type: 'date'  },
						{name : 'client', type: 'String'  },
						{name : 'refno', type: 'String'  },
						{name : 'remarks', type: 'number'  },
						{name : 'attach', type: 'number'  },
						{name : 'branch', type: 'String'  },
						{name : 'mawb', type: 'String'  },
						{name : 'mbl', type: 'String'  },
						{name : 'hawb', type: 'String'  },
						{name : 'hbl', type: 'String'  },
						{name : 'shipper', type: 'String'  },
						{name : 'consignee', type: 'String'  },
						{name : 'carrier', type: 'String'  },
						{name : 'flightno', type: 'String'  },
						{name : 'voage', type: 'String'  },
						{name : 'etd', type: 'String'  },
						{name : 'eta', type: 'String'  },
						{name : 'ttime', type: 'String'  },
						{name : 'boe', type: 'String'  },
						{name : 'contno', type: 'String'  },
						{name : 'truckno', type: 'String'  },
						{name : 'tr_no', type: 'String'  }
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
    
    $("#jqxJobListingGrid").jqxGrid(
    {
        width: '100%',
        height: 320,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        showfilterrow: true,
        sortable:true,
        columnsresize: true,
        
        selectionmode: 'singlerow',
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
         			 { text: 'QUOTATION NO', datafield: 'qotno', width: '7%'},
         			 { text: 'DATE',datafield: 'date', width: '6%',cellsformat:'dd.MM.yyyy' },
         			 { text: 'CLIENT', datafield: 'client',  width: '16%'}, 
         			 { text: 'REF NO', datafield: 'refno', width: '5%'},
         			 { text: 'REMARKS',datafield: 'remarks', width: '10%' },

         			 { text: 'doc_no', datafield: 'doc_no',  width: '6%', hidden: true},
         			{ text: 'tr_no', datafield: 'tr_no',  width: '6%', hidden: true},
           	      	 { text: 'branch',  datafield: 'branch', width: '7%',hidden : true },
           	      
		           	{ text: 'MAWB', datafield: 'mawb', width: '5%'},
		           	{ text: 'MBL', datafield: 'mbl', width: '5%'},
		           	{ text: 'HAWB', datafield: 'hawb', width: '5%'},
		           	{ text: 'HBL', datafield: 'hbl', width: '5%'},
		           	{ text: 'Shipper', datafield: 'shipper', width: '5%'},
		           	{ text: 'Consignee', datafield: 'consignee', width: '5%'},
		           	{ text: 'Carrier', datafield: 'carrier', width: '5%'},
		           	{ text: 'Flight No.', datafield: 'flightno', width: '5%'},
		           	{ text: 'Voage', datafield: 'voage', width: '5%'},
		           	{ text: 'ETD', datafield: 'etd', width: '5%'},
		           	{ text: 'ETA', datafield: 'eta', width: '5%'},
		           	{ text: 'Transit Time', datafield: 'ttime', width: '6%'},
		           	{ text: 'BoE', datafield: 'boe', width: '5%'},
		           	{ text: 'Container No.', datafield: 'contno', width: '6%'},
		           	{ text: 'Truck No.', datafield: 'truckno', width: '5%'},
		           	
		           	{ text: 'ATTACH',  datafield: 'attach',columntype: 'button', width: '5%' },
					]
   
    });
    $("#overlay, #PleaseWait").hide();
    $('#jqxJobListingGrid').on('rowdoubleclick', function (event){
    	var rowindextemp = event.args.rowindex;
    	var docno=$('#jqxJobListingGrid').jqxGrid('getcellvalue',rowindextemp,'doc_no');
    	var trno=$('#jqxJobListingGrid').jqxGrid('getcellvalue',rowindextemp,'tr_no');
    	$("#enquirydiv").load("enquiryGrid.jsp?docno="+trno);
    	$("#srvcdiv").load("estmgrid.jsp?docno="+trno);
    });
    $('#jqxJobListingGrid').on('cellclick', function (event){
	    var datafield=event.args.datafield;
	    var rowindex1=event.args.rowindex;
    	if(datafield=="attach"){
			var brchid=$("#jqxJobListingGrid").jqxGrid('getcellvalue', rowindex1, "branch"); 
			var docno=$("#jqxJobListingGrid").jqxGrid('getcellvalue', rowindex1, "jobno");
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
<div id="jqxJobListingGrid"></div>