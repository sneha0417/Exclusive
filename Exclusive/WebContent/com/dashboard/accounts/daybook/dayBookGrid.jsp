<%@page import="com.dashboard.accounts.daybook.ClsDayBook" %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
     String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();
 	 ClsDayBook dao= new ClsDayBook();
%>
<script type="text/javascript">
    
       var data;
       var temp='<%=branchval%>';
    	 
	  	if(temp!='NA'){  
	  		 data='<%=dao.dayBook(branchval, fromDate, toDate,check)%>';
	  		 <%-- dataExcel='<%=dao.dayBookExcel(branchval, fromDate, toDate,check)%>'; --%>
	  		 var exceldata='<%=dao.dayBookExcel(branchval, fromDate, toDate)%>'; 
	  	} 
	  	     
        $(document).ready(function (){    
        	 
        	/*$("#btnExcel").click(function() {
    			$("#dayBook").jqxGrid('exportdata', 'xls', 'DayBook');
    		});*/
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'transno', type: 'string'   },
							{name : 'date', type: 'date'   },
                            {name : 'dtype', type: 'string'   },
     						{name : 'doc_no', type: 'string'   },
     						{name : 'ref', type: 'string'  },
     						{name : 'acno', type: 'string' }, 
     						{name : 'description', type: 'string' },
     						{name : 'total', type: 'number' },
     						{name : 'tr_no', type: 'string'   },
     						{name : 'account', type: 'string'   },
     						{name : 'currency', type: 'string' },
     						{name : 'rate', type: 'number'   },
     						{name : 'dr', type: 'number' },
     		     		    {name : 'cr', type: 'number'   },
     						{name : 'drcur', type: 'number'   },
     						{name : 'crcur', type: 'number'   },
     						
	                      ],
                          localdata: data,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
        	if(temp!='NA'){ 
            	var datas='<%=dao.dayBookGrid(branchval, fromDate, toDate)%>';
            	
        	}
            
            $("#dayBook").jqxGrid(
            {
                width: '98%',
                height: 490,
                source: dataAdapter,
                rowsheight:25,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
                editable: false,
                showaggregates: true,
                showstatusbar:true,
                showfilterrow:true,
             	statusbarheight:25,
             	enabletooltips: true,
               
                columns: [
                          { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },
                            { text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '6%' },
                            { text: 'Doc No', datafield: 'transno', width: '5%' },
                            { text: 'Doc. Type', datafield: 'dtype', width: '3%' },
                            { text: 'Doc No', datafield: 'doc_no', width: '5%', hidden:true },
                            
							{ text: 'Ref No', datafield: 'ref', width: '6%' },
							{ text: 'Ac.No', datafield: 'acno', width: '4%' },
							
							{ text: 'Total', datafield: 'total', width: '7%',cellsformat: 'd2',cellsalign: 'right', align: 'right',hidden:true },
							{ text: 'Tr No', hidden: true, datafield: 'tr_no',  width: '5%' },
							{ text: 'Account', datafield: 'account', width: '18%' },
							{ text: 'Currency', datafield: 'currency', width: '4%' },
							{ text: 'Rate', datafield: 'rate', width: '3%', cellsformat: 'd2' },
							{ text: 'Dr', datafield: 'dr', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Cr', datafield: 'cr', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Dr. base Amount', datafield: 'drcur',  width: '6%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Cr. base Amount' , datafield: 'crcur',  width: '6%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Description', datafield: 'description', width: '21%' },
								
						]
            });
            
            if(temp=='NA'){ 
               $("#dayBook").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();
             
        });
    </script>
    <div id="dayBook"></div>
 