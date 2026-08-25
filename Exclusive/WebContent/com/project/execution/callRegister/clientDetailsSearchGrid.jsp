<%@page import="com.project.execution.callRegister.ClsCallRegisterDAO"%>
<% ClsCallRegisterDAO DAO= new ClsCallRegisterDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String clientname = request.getParameter("clientname")==null?"0":request.getParameter("clientname");
 String clientid = request.getParameter("clientid")==null?"0":request.getParameter("clientid");
 String contactno = request.getParameter("contactno")==null?"0":request.getParameter("contactno");
 String check = request.getParameter("check")==null?"0":request.getParameter("check"); %>
<script type="text/javascript">
        
       var data4= '<%=DAO.clientDetailsSearch(clientid, clientname, contactno, check)%>';  
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
                		 localdata: data4,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#clientDetailsSearch").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Client Id', datafield: 'codeno', width: '20%' },
							{ text: 'Client Name', datafield: 'name', width: '60%' },
							{ text: 'Contact', datafield: 'mobile', width: '20%' },
							{ text: 'Address',  datafield: 'address', hidden:true, width: '15%' },
							{ text: 'Tele',  datafield: 'tele', hidden:true, width: '5%' },
							{ text: 'Mail',  datafield: 'mail', hidden:true, width: '10%' },
							{ text: 'Doc No',  datafield: 'doc_no', hidden:true, width: '5%' },
							{ text: 'Acc No',  datafield: 'acno', hidden:true, width: '5%' },
						]
            });
            
             $('#clientDetailsSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("txtclientdocno").value = $('#clientDetailsSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("txtclientacno").value = $('#clientDetailsSearch').jqxGrid('getcellvalue', rowindex1, "acno");
                document.getElementById("txtclientname").value = $('#clientDetailsSearch').jqxGrid('getcellvalue', rowindex1, "name");
            	document.getElementById("txtclientdetails").value = $('#clientDetailsSearch').jqxGrid('getcellvalue', rowindex1, "address");
            	document.getElementById("txtclienttele").value = $('#clientDetailsSearch').jqxGrid('getcellvalue', rowindex1, "tele");
            	document.getElementById("txtclientmobile").value = $('#clientDetailsSearch').jqxGrid('getcellvalue', rowindex1, "mobile");
            	document.getElementById("txtclientmail").value = $('#clientDetailsSearch').jqxGrid('getcellvalue', rowindex1, "mail");
    	       	
	       		getAccountBalance($('#clientDetailsSearch').jqxGrid('getcellvalue', rowindex1, "acno"),$('#clientDetailsSearch').jqxGrid('getcellvalue', rowindex1, "doc_no"));
	       		
	       		$("#contractDetailsDiv").load("contractDetailsGrid.jsp?cldocno="+$('#clientDetailsSearch').jqxGrid('getcellvalue', rowindex1, "doc_no"));
	       		
            	$('#clientDetailsWindow').jqxWindow('close'); 
            });  
        });
    </script>
    <div id="clientDetailsSearch"></div>
 