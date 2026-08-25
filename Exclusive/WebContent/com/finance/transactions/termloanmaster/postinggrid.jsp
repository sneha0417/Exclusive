<%@page import="com.finance.transactions.termloanmaster.ClstermloanmasterDAO" %>
<%
ClstermloanmasterDAO cvp1=new ClstermloanmasterDAO();
%>

  <%         
	
    String srno = request.getParameter("srno")==null?"0":request.getParameter("srno").trim();
  String dtype = request.getParameter("dtype")==null?"0":request.getParameter("dtype").trim();
  
  

    %>
    
 
    <script type="text/javascript"> 
    
   
    var temp2='<%=srno%>';

  var postdats;

    var aa="";
    
    if(parseInt(temp2)>0)
    	{
    	aa="";
    	postdats='<%=cvp1.journalVoucherGridReloading(session,srno,dtype)%>';
  
    	}
  
    else
    	{
    	postdats;
    	aa="sssss";
     
    	}
		$(document).ready(function () { 	
        	/* var url=""; */
        	
 
           
            var source =
            {
                datatype: "json",
                datafields: [
					    {name : 'docno', type: 'int' },
						{name : 'type', type: 'string' }, 
						{name : 'accounts', type: 'string'   },
						{name : 'accountname1', type: 'string'  },
						{name : 'costtype', type: 'string'    },
					    {name : 'costgroup', type: 'string'    },
					    {name : 'costcode', type: 'number'    },
						{name : 'debit', type: 'number'   },
						{name : 'credit', type: 'number'   },
						{name : 'baseamount', type: 'number' },
						{name : 'description', type: 'string' },
						{name : 'currencyid', type: 'int'   },
						{name : 'currencytype', type: 'string'   },
						{name : 'rate', type: 'string'   },
						{name : 'grtype', type: 'int'  },
						{name : 'sr_no', type: 'int'  },
						{name : 'id', type: 'int'  },
						{name : 'typevalid', type: 'number'  },
						{name : 'accvalid', type: 'number'  },
						{name : 'grtypevalid', type: 'number'  },
						{name : 'costvalid', type: 'number'  }
                        ],
                		
                		//  url: url1,
                 localdata: postdats,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#postgrid").jqxGrid(
            {
                width: '100%',
                height: 127,
                source: dataAdapter,
                editable: false,
                showaggregates: true,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                columns: [
							
							 
                          
						{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
						    groupable: false, draggable: false, resizable: false,datafield: '',
						    columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
						    cellsrenderer: function (row, column, value) {
						  	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						    }  
							},
							{ text: 'Doc No',  hidden: true, datafield: 'docno',  width: '5%' },
						  { text: 'Type', datafield: 'type',  width: '7%',columntype:'dropdownlist', editable: false,
						      
						  },
						     
							{ text: 'Account', datafield: 'accounts',  editable: false, width: '7%' },	
							{ text: 'Account Name', datafield: 'accountname1', editable: false, width: '20%' },	
							{ text: 'Cost Type', datafield: 'costgroup', width: '7%',editable: false },
							{ text: 'Cost Id', datafield: 'costtype', width: '8%', hidden: true ,editable: true},
							{ text: 'Cost Code', datafield: 'costcode',  width: '5%',editable: false },
							{ text: 'Debit', datafield: 'debit', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregates: ['sum'],
								 
							},
							{ text: 'Credit', datafield: 'credit', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregates: ['sum'],
								 
							},
							{ text: 'Base Amount', datafield: 'baseamount', editable: false, cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right' },
							{ text: 'Description', datafield: 'description', width: '25%' },
							{ text: 'Currency Id', hidden: false, datafield: 'currencyid', editable: false, width: '10%' ,hidden:true},
							{ text: 'Curr Type', hidden: true, datafield: 'currencytype', editable: false, width: '4%' },
							{ text: 'Rate',  hidden: true, datafield: 'rate', editable: false, width: '10%' },
							{ text: 'Group Type', datafield: 'grtype', hidden: true, editable: false, width: '10%' },
							{ text: 'SR No',  hidden: true, datafield: 'sr_no', editable: false, width: '10%' },
							{ text: 'Id',  hidden: true, datafield: 'id', editable: false, width: '10%' },
							{ text: 'Type Valid',  hidden: true, datafield: 'typevalid', editable: false, width: '5%',  cellsformat: 'd2', aggregates: ['sum'] },
							{ text: 'Acc Valid',  hidden: true, datafield: 'accvalid', editable: false, width: '5%',  cellsformat: 'd2', aggregates: ['sum'] },
							{ text: 'Gr-Type Valid',  hidden: true, datafield: 'grtypevalid', editable: false, width: '5%',  cellsformat: 'd2', aggregates: ['sum'] },
							{ text: 'Cost Vaild',  hidden: true, datafield: 'costvalid', editable: false, width: '5%',  cellsformat: 'd2', aggregates: ['sum'] },
												
									
							             
						]
                
                
            
                     
            });
           
            if(aa=="sssss")
        	{
            	
			   	 $("#postgrid").jqxGrid('clear');
             	   $("#postgrid").jqxGrid('addrow', null, {});
             	 
            	   $("#postgrid").jqxGrid({ disabled: true}); 
             	   
             	   
              	  } 
        });
    </script>
    <div id="postgrid"></div>