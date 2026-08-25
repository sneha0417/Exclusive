<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.finance.posting.prePayment.ClsPrePaymentDAO"%>
<% ClsPrePaymentDAO DAO= new ClsPrePaymentDAO(); %>
<% String trNo = request.getParameter("txttrno")==null?"0":request.getParameter("txttrno");
   String value = request.getParameter("value")==null?"0":request.getParameter("value");
   String startdate = request.getParameter("sdate")==null?"0":request.getParameter("sdate");
   String enddate = request.getParameter("tdate")==null?"0":request.getParameter("tdate");
   String temp = request.getParameter("temp")==null?"0":request.getParameter("temp");
   String check = request.getParameter("check")==null?"0":request.getParameter("check"); %>
<script type="text/javascript">
		
		var data2;  
        $(document).ready(function () { 
            
            var temp='<%=trNo%>';
            var value='<%=value%>';
            
            if (parseInt(value)==3){
       			 data2='<%=DAO.applyingInvoiceGridLoading3(session,temp,startdate,enddate,check)%>';
       	    }
            
            <%--  if(temp>0)
           	 {     
            
            	  data2='<%=DAO.applyingInvoiceGridLoading(trNo)%>';    
             } --%> 
             
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'int' },
     						{name : 'atype', type: 'string' }, 
     						{name : 'account', type: 'string'   },
     						{name : 'accountname', type: 'string'  },
     						{name : 'costtype', type: 'string'    },
							{name : 'costgroup', type: 'string'    },
							{name : 'costcode', type: 'number'    },
							{name : 'costcde', type: 'number'    },
     						{name : 'debit', type: 'number'   },
     						{name : 'credit', type: 'number'   },
     						{name : 'description', type: 'string' },
     						{name : 'currencyid', type: 'int'   },
     						{name : 'rate', type: 'number'   },
     						{name : 'ref_row', type: 'int'  },
     						{name : 'sr_no', type: 'int'  },
     						{name : 'id', type: 'int'  }
                        ],
                           localdata: data2,   
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxJournalVoucherApplying").jqxGrid(
            {
                width: '99%',
                height: 200,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlecell',
                       
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Doc No', hidden: true, datafield: 'doc_no',  width: '5%' },
							{ text: 'Type',   datafield: 'atype', editable: false,  width: '7%' },
							{ text: 'Account', datafield: 'account', editable: false, width: '7%' },	
							{ text: 'Account Name', datafield: 'accountname', editable: false, width: '20%' },
							{ text: 'Cost Type', datafield: 'costgroup', width: '8%',editable: false },
							{ text: 'Cost Id', datafield: 'costtype', width: '8%',hidden: true },
							{ text: 'Cost Code', datafield: 'costcde', width: '5%',editable: false },
							{ text: 'Debit', datafield: 'debit', width: '10%', editable: false, cellsformat: 'd2', cellsalign: 'right', align: 'right'},
							{ text: 'Credit', datafield: 'credit', width: '10%', editable: false, cellsformat: 'd2', cellsalign: 'right', align: 'right'},
							{ text: 'Description', datafield: 'description', width: '28%' },
							{ text: 'Currency Id', hidden: true, datafield: 'currencyid', editable: false, width: '10%' },
							{ text: 'Rate', hidden: true, datafield: 'rate', editable: false, width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Ref Row', hidden: true, datafield: 'ref_row', editable: false, width: '10%' },
							{ text: 'Sr No', hidden: true, datafield: 'sr_no', editable: false, width: '10%' },
							{ text: 'Id',  hidden: true, datafield: 'id', editable: false, width: '10%' },
							{ text: 'CostCode',  hidden: true, datafield: 'costcode', editable: false, width: '10%' }
						]
            });
            
            /* if(temp==0)
          	 {   
              //Add empty row
         	   $("#jqxJournalVoucherApplying").jqxGrid('addrow', null, {});
         	   $("#jqxJournalVoucherApplying").jqxGrid('addrow', null, {});
          	  } */ 
        });
    </script>
    <div id="jqxJournalVoucherApplying"></div>
    <input type="hidden" id="rowindex"/> 