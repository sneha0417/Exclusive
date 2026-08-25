<%@page import="com.project.execution.serviceReport.ClsServiceReportDAO"%>
<% ClsServiceReportDAO DAO= new ClsServiceReportDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String clientname = request.getParameter("clientname")==null?"0":request.getParameter("clientname");
 String clientid = request.getParameter("clientid")==null?"0":request.getParameter("clientid");
 String contactno = request.getParameter("contactno")==null?"0":request.getParameter("contactno");
 String check = request.getParameter("check")==null?"0":request.getParameter("check"); %>
<script type="text/javascript">
        
       var data5= '<%=DAO.customerDetailsSearch(clientid, clientname, contactno, check)%>';  
        $(document).ready(function () { 
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'codeno', type: 'int'   },
     						{name : 'name', type: 'string'   },
     						{name : 'mobile', type: 'string'  },
     						{name : 'address', type: 'string'  },
     						{name : 'tele', type: 'string'  },
     						{name : 'mail', type: 'string'  },
     						{name : 'doc_no', type: 'int'   },
     						{name : 'acno', type: 'int'   }
                        ],
                		 localdata: data5,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#customerDetailsSearchGridID").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Client Id', datafield: 'codeno', width: '20%' },
							{ text: 'Client Name', datafield: 'name', width: '60%' },
							{ text: 'Contact', datafield: 'mobile', width: '20%' },
							{ text: 'Address',  datafield: 'address', hidden: true, width: '15%' },
							{ text: 'Tele',  datafield: 'tele', hidden: true, width: '5%' },
							{ text: 'Mail',  datafield: 'mail', hidden: true, width: '10%' },
							{ text: 'Doc No',  datafield: 'doc_no', hidden: true, width: '5%' },
							{ text: 'Acc No',  datafield: 'acno', hidden: true, width: '5%' },
						]
            });
            
             $('#customerDetailsSearchGridID').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("txtcustomerdocno").value = $('#customerDetailsSearchGridID').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("txtcustomeracno").value = $('#customerDetailsSearchGridID').jqxGrid('getcellvalue', rowindex1, "acno");
                document.getElementById("txtcustomer").value = $('#customerDetailsSearchGridID').jqxGrid('getcellvalue', rowindex1, "name");
            	document.getElementById("txtcustomerdetails").value = $('#customerDetailsSearchGridID').jqxGrid('getcellvalue', rowindex1, "address");
    	       	
            	$('#customerDetailsWindow').jqxWindow('close'); 
            });  
        });
    </script>
    <div id="customerDetailsSearchGridID"></div>
 