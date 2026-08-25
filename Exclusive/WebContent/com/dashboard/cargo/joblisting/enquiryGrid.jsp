<%@page import="com.dashboard.cargo.joblisting.ClsJobListing"%>
<%String docno = request.getParameter("docno")==null?"0":request.getParameter("docno").trim();%>
<%ClsJobListing DAO = new ClsJobListing(); %>
<script type="text/javascript">
     	 var temp1='<%=docno%>';
         var reqdata1;
         
     $(document).ready(function () { 
    	 if(temp1>0)
       	 {
            reqdata1='<%=DAO.enqryDataLoad(docno) %>';
       	 } 
         else
       	 { 
         	reqdata1=[];
       	 }
        	var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'enqdoc', type: 'string'},
							{name : 'mode', type: 'string'  },
							{name : 'modeid', type: 'int'   },
     						{name : 'submode', type: 'string'  },
     						{name : 'smodeid', type: 'int'   },
     						{name : 'shipment', type: 'string'  },
     						{name : 'shipid', type: 'string'  },
     						{name : 'terms', type: 'string'   },
     						{name : 'termid', type: 'int'   },
     						{name : 'origin', type: 'string'  },
     						{name : 'pol', type: 'string'   },
     						{name : 'pod', type: 'string'   },
     						{name : 'commodity', type: 'string'   },
     						{name : 'weight', type: 'string'   },
     						{name : 'noofpacks', type: 'number'  },
     						{ name: 'dimension', type: 'int' },
     						{name : 'volume', type: 'number' },
     						{ name: 'remarks', type: 'string' },
     						{name : 'qty', type: 'int'  }
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

            
            
            $("#jqxEnquiry").jqxGrid(
            {
                width: '100%',
                height: 65,
                source: dataAdapter,
                disabled: false,
                editable: false,
                altRows: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                theme: 'energyblue',
                columns: [
							 { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '3%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
                            },
                            { text: 'enqdoc', datafield: 'enqdoc', width: '2%',hidden:true },
                            { text: 'Mode', datafield: 'mode', width: '7%' },
                            { text: 'modeid', datafield: 'modeid', width: '2%',hidden:true },
							{ text: 'Submode', datafield: 'submode', width: '7%' },	
							{ text: 'Submodeid', datafield: 'smodeid', width: '2%',hidden:true },
							{ text: 'Shipment', datafield: 'shipment', width: '7%' },
							{ text: 'Shipid', datafield: 'shipid', width: '2%',hidden:true },
							{ text: 'Terms', datafield: 'terms', width: '7%' },	
							{ text: 'Termid', datafield: 'termid', width: '2%',hidden:true },
							{ text: 'Origin', datafield: 'origin', width: '9%' },	
							{ text: 'Pol', datafield: 'pol', width: '6%'},
							{ text: 'PoD', datafield: 'pod', width: '6%'},	
							{ text: 'Commodity', datafield: 'commodity', width: '8%'},
							{ text: 'Weight', datafield: 'weight', width: '7%'},
							{ text: 'No of Packs', datafield: 'noofpacks', width: '7%' },	
							{ text: 'Dimension', datafield: 'dimension', width: '6%' },
							{ text: 'Volume', datafield: 'volume', width: '6%' },	
							{ text: 'Remarks', datafield: 'remarks', width: '9%' },	
							{ text: 'Qty', datafield: 'qty', width: '5%'},
			              ]
               
            });
           
            /* $('#jqxEnquiry').on('celldoubleclick', function (event){
            	var rowindextemp = event.args.rowindex;
            	
            }); */ 
        });
    </script>
    <div id="jqxEnquiry"></div>