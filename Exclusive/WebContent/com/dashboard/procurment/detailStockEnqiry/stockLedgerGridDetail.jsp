<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.procurment.stockLedger.ClsStockLedger" %>
<%   
	String hidbrand = request.getParameter("hidbrand")==null?"0":request.getParameter("hidbrand").trim();
	String hidtype = request.getParameter("hidtype")==null?"0":request.getParameter("hidtype").trim();
	String hidproduct = request.getParameter("hidproduct")==null?"0":request.getParameter("hidproduct").trim();
	String hidcat = request.getParameter("hidcat")==null?"0":request.getParameter("hidcat").trim();
	String hidsubcat = request.getParameter("hidsubcat")==null?"0":request.getParameter("hidsubcat").trim();
	String branchid = request.getParameter("branchid")==null?"0":request.getParameter("branchid").trim();
	String hidept = request.getParameter("hidept")==null?"0":request.getParameter("hidept").trim();
	String fromDate = request.getParameter("frmdate")==null?"0":request.getParameter("frmdate").trim();
	String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
	String type = request.getParameter("type")==null?"0":request.getParameter("type").trim();
	 
	 String aa = request.getParameter("aa")==null?"0":request.getParameter("aa").trim();
	ClsStockLedger dao= new ClsStockLedger();
%>
<style type="text/css">
    .redClass
    {
        background-color: #FFEBEB;
    }
    
    .greyClass
    {
        background-color: #e6e6e6;
    }
    
     .orangeClass
    {
        background-color: #FFEBC2;
    }
    
</style>
<script type="text/javascript">
    
       var detdata;
       var type='<%=type%>';
    	 
	   
	  		detdata='<%=dao.stockLedgerDetail(session,hidbrand,fromDate,toDate,hidtype,hidcat,hidsubcat,hidproduct,branchid,hidept,aa)%>';  
	  	

$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
                     
                     
                  
                     
                        {name : 'pno', type: 'String'  },
                        {name : 'pname', type: 'String'  },
                        {name : 'date', type: 'String'  },
                        {name : 'docno', type: 'String'  },
                        {name : 'trans_type', type: 'String'  },
						{name : 'inqty', type: 'number'  },
						{name : 'inval', type: 'number'  },
						{name : 'isqty', type: 'number'  },
						{name : 'isval', type: 'number'  },
						{name : 'balqty', type: 'number'  },
						{name : 'balval', type: 'number'  },
						{name : 'stv', type: 'number'  },
						{name : 'cpu', type: 'number'  },
						{name : 'cpu', type: 'number'  },
						{name : 'sl', type: 'String'},
						{name : 'specid', type: 'String'},
						{name : 'trtype', type: 'String'},
						{name : 'desc1', type: 'String'},
						
						
						],
				    localdata: detdata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    var cellclassname = function (row, column, value, data) {
    	
		 if (data.trtype==0) {
            return "greyClass";
        };
    };

    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
   
   
    
    $("#jqxStockDetailGrid").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        columns: [   
                  /* { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '4%', cellclassname: cellclassname,
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    } */
                    { text: 'SL#',datafield: 'sl', columntype: 'string', width: '4%', cellclassname: cellclassname  
                      },
                    { text: 'Branch', datafield: 'branch',  width: '10%',hidden:true },
           	         { text: 'DATE', datafield: 'date',  width: '6%', cellclassname: cellclassname }, 
           	         { text: 'TYPE', datafield: 'trans_type',  width: '4%', cellclassname: cellclassname},
					 { text: 'DOCNO', datafield: 'docno',  width: '8%', cellclassname: cellclassname},
					 { text: 'CLIENT/VENDOR', datafield: 'desc1',  width: '24%', cellclassname: cellclassname},
					 { text: 'QUANTITY',datafield: 'inqty', width: '8%', cellsalign: 'right', cellsformat: 'd2',columngroup:'in', cellclassname: cellclassname },
					 { text: 'VALUE',datafield: 'inval', width: '8%', cellsalign: 'right', cellsformat: 'd2',columngroup:'in', cellclassname: cellclassname },
				     { text: 'QUANTITY',datafield: 'isqty', width: '8%', cellsalign: 'right', cellsformat: 'd2',columngroup:'issued', cellclassname: cellclassname },
				     { text: 'VALUE',datafield: 'isval', width: '8%', cellsalign: 'right', cellsformat: 'd2',columngroup:'issued', cellclassname: cellclassname },
					 { text: 'QUANTITY', datafield: 'balqty', width: '8%', cellsalign: 'right', cellsformat: 'd2',columngroup:'balance', cellclassname: cellclassname },
					 { text: 'VALUE', datafield: 'balval', width: '8%', cellsalign: 'right', cellsformat: 'd2',columngroup:'balance', cellclassname: cellclassname },
					 { text: 'COST PER UNIT', datafield: 'cpu', cellsalign: 'right', width: '6%', cellsformat: 'd2', cellclassname: cellclassname},
					 { text: 'psrno', datafield: 'psrno', width: '10%',hidden:true},
					 { text: 'trtype', datafield: 'trtype', width: '10%',hidden:true},
					
					], columngroups: 
	                     [
	                      
	                       { text: 'IN STOCK', align: 'center', name: 'in',width: '20%' },
	                       { text: 'ISSUED STOCK', align: 'center', name: 'issued',width: '20%' },
	                       { text: 'BALANCE STOCK', align: 'center', name: 'balance',width: '20%' }
	                     ]
   
    });

    $("#overlay, #PleaseWait").hide();
});


</script>
<div id="jqxStockDetailGrid"></div>