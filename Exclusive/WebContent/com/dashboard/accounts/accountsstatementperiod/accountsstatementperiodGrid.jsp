<%@ page import="com.dashboard.accounts.accountsstatementperiod.ClsAccountsStatementPeriodDAO" %>  
<%ClsAccountsStatementPeriodDAO DAO=new ClsAccountsStatementPeriodDAO(); %>   
 <%
   String id = request.getParameter("id")==null?"0":request.getParameter("id");
   String fromdate = request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
   String todate = request.getParameter("todate")==null?"":request.getParameter("todate");
   String fromacno = request.getParameter("fromacno")==null?"":request.getParameter("fromacno");
   String toacno = request.getParameter("toacno")==null?"":request.getParameter("toacno");
 %>
 <script type="text/javascript">    
      var data; 
	  data='<%=DAO.accountDetails(fromdate,todate,fromacno,toacno,id)%>';           
	  $(document).ready(function () {      
            var num = 0; 
            var source = 
            {
                datatype: "json", 
                datafields: [
	                 			{name : 'acno', type: 'String'  },
	                 			{name : 'name', type: 'String'  },
	                 			{name : 'primary_owner', type: 'String'  },
	     						{name : 'mobno', type: 'String'  },  
	     						{name : 'mail', type: 'String'  },
	     						{name : 'doc_no', type: 'String'  },  
                          	],
                          	localdata: data,  
                pager: function (pagenum, pagesize, oldpagenum) {
                }
            };
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }
            );
            $("#jqxaccountgrid").jqxGrid(
            { 
            	width: '100%',
                height: 550,
                source: dataAdapter,
                showaggregates:true,
                enableAnimations: true,
                filtermode:'excel',
                filterable: true,
                showfilterrow: true,
                sortable:true,
                selectionmode: 'checkbox',
                pagermode: 'default',
                editable:true,
                columns: [
                          { text: 'SL#', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,
							    datafield: 'sl', columntype: 'number', width: '3%',
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
							  },
                            
                            { text: 'Doc No', datafield: 'doc_no', width: '7%',hidden:true}, 
                            { text: 'Acno', datafield: 'acno', width: '8%', editable: false},
                            
                            { text: 'Owner Name', datafield: 'primary_owner', editable: false},
                            { text: 'Account Name', datafield: 'name', editable: false},
                            { text: 'Phone', datafield: 'mobno', width: '16%', editable: false},
                            { text: 'Email', datafield: 'mail', width: '24%', editable: false},                
					]
            });
            $("#overlay, #PleaseWait").hide(); 
        });
    </script>
    <div id="jqxaccountgrid"></div>