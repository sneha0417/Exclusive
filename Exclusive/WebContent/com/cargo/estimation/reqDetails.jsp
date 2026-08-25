<%@page import="javax.servlet.http.HttpSession" %>
<%String enqrdocno = request.getParameter("enqrdocno")==null?"0":request.getParameter("enqrdocno").trim();%> 
<%ClsEstimationDAO DAO = new ClsEstimationDAO(); %>
<%@page import="com.cargo.estimation.ClsEstimationDAO"%>
<script type="text/javascript">
           	var temp1='<%=enqrdocno%>';
            var reqdata1;
            if(temp1!=0||temp1!='')
          	 {
               reqdata1='<%=DAO.enqryDataLoad(session,enqrdocno) %>';
          	 } 
            else
          	 { 
            	var reqdata1;
          	 }
        $(document).ready(function () { 
        	$("#jqxEnquiry").jqxGrid({ disabled: false});
            // prepare the data
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
     						{name : 'qty', type: 'int'  },
     						{ name: 'calculate', type: 'string' },
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
                height: 145,
                source: dataAdapter,
                disabled: false,
                editable: false,
                altRows: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
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
							{ text: 'Weight', datafield: 'weight', width: '5%'},
							{ text: 'No of Packs', datafield: 'noofpacks', width: '6%' },	
							{ text: 'Dimension', datafield: 'dimension', width: '6%' },
							{ text: 'Volume', datafield: 'volume', width: '5%' },	
							{ text: 'Remarks', datafield: 'remarks', width: '9%' },	
							{ text: 'Qty', datafield: 'qty', width: '4%'},
							{ text: 'Calculate', datafield: 'calculate', width: '5%',columntype: 'button'},
			              ]
               
            });
           
            if(($('#mode').val()=='A')||($('#mode').val()=='E'))
    		{
    		  $("#jqxEnquiry").jqxGrid({ disabled: false}); 
    		}
          
            $('#jqxEnquiry').on('celldoubleclick', function (event){
            	var rowindextemp = event.args.rowindex;
            	if($('#mode').val()=='view'){
            		$("#estmdiv").show();
            		funchkforedit();
            	}
            	var modeid=$("#jqxEnquiry").jqxGrid('getcellvalue',rowindextemp,'modeid');
            	var smodeid=$("#jqxEnquiry").jqxGrid('getcellvalue',rowindextemp,'smodeid');
            	var shipid=$("#jqxEnquiry").jqxGrid('getcellvalue',rowindextemp,'shipid');
            	var enqdoc=$("#jqxEnquiry").jqxGrid('getcellvalue',rowindextemp,'enqdoc');
            	$("#enqdoc").val(enqdoc);
            	$("#estdiv").load("estmgrid.jsp?modeid="+modeid+"&shipid="+shipid+"&smodeid="+smodeid+"&enqdocno="+enqdoc+"&docno="+$("#masterdoc_no").val()+"&id=1");
            	funchkforedit();
            }); 
            
            $('#jqxEnquiry').on('cellclick', function (event){ 
	           	var rowindex1=event.args.rowindex;
	           	var datafield = event.args.datafield;
	           	var enqddoc=$("#jqxEnquiry").jqxGrid('getcellvalue',rowindex1,'enqdoc');
	           	var mode = $("#jqxEnquiry").jqxGrid('getcellvalue',rowindex1,'modeid');
	           	if(datafield=="calculate"&&mode!="3"){
	           		funCalculate(rowindex1,enqddoc,mode);
	           	}
		   });
        });
    </script>
    <div id="jqxEnquiry"></div>