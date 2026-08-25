
  <%@page import="com.dashboard.procurment.reservedproduct.ClsReservedProductDAO" %>
<%ClsReservedProductDAO DAO= new ClsReservedProductDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String partyname = request.getParameter("partyname")==null?"0":request.getParameter("partyname");
 String accNo = request.getParameter("accNo")==null?"0":request.getParameter("accNo");
 String contactNo = request.getParameter("contactNo")==null?"0":request.getParameter("contactNo");
 String load = request.getParameter("load")==null?"0":request.getParameter("load");
 String atype = request.getParameter("atype")==null?"0":request.getParameter("atype"); %>
<script type="text/javascript">
        
       var data1= '<%=DAO.accountDetails(atype, accNo, partyname, contactNo,load)%>';  
        $(document).ready(function () { 
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'int'   },
     						{name : 'account', type: 'string'   },
     						{name : 'refname', type: 'string'  },
     						{name : 'per_mob', type: 'int'   },
     						{name : 'cldocno',type:'String'},
                        ],
                		 localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#clientAccountSearch").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Doc No',  datafield: 'doc_no', hidden:true, width: '5%' },
							{ text: 'Client Name', datafield: 'refname', width: '60%' },
							{ text: 'Account No', datafield: 'account', width: '20%' },
							
							{ text: 'Contact', datafield: 'per_mob', width: '20%' },
						]
            });
            
             $('#clientAccountSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("txtclientaccountdocno").value = $('#clientAccountSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                
            	document.getElementById("txtclientname").value = $('#clientAccountSearch').jqxGrid('getcellvalue', rowindex1, "refname");
            	document.getElementById("hidcldocno").value = $('#clientAccountSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
    	       	
            	$('#accountDetailsWindow').jqxWindow('close'); 
            });  
        });
    </script>
    <div id="clientAccountSearch"></div>
 