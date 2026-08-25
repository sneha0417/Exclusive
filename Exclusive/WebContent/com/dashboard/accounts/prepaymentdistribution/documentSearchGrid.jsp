<%@page import="com.dashboard.accounts.prepaymentdistribution.ClsPrePaymentDistributionDAO"%>
<% ClsPrePaymentDistributionDAO DAO= new ClsPrePaymentDistributionDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% 
String branch = request.getParameter("branchval")==null?"NA":request.getParameter("branchval");
String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate");
String todate = request.getParameter("todate")==null?"0":request.getParameter("todate");
String check = request.getParameter("check")==null?"0":request.getParameter("check");
%>
<script type="text/javascript">
  
     	var docdetails= '<%=DAO.documentDetailsSearch(session, fromdate, todate, check) %>';
		
     	$(document).ready(function () { 	
           
			var source =
            {
                datatype: "json",  
                datafields: [
                              {name : 'transno', type: 'string'  },
                              {name : 'transtype', type: 'string'  },
                              {name : 'jvdocno', type: 'string'  }
                            ],
                       localdata: docdetails,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#documentSearchGridID").jqxGrid(
            {
                width: '100%',
                height: 375,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
                              { text: 'Doc No', datafield: 'transno', width: '20%'},
                              { text: 'Doc Type', datafield: 'transtype', width: '100%' },
                              { text: 'jvdocno', datafield: 'jvdocno', width: '100%',hidden:true },
						]
            });
            
             
          $('#documentSearchGridID').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("txtdocumentno").value = $('#documentSearchGridID').jqxGrid('getcellvalue', rowindex1, "transno");
                document.getElementById("txtdocno").value = $('#documentSearchGridID').jqxGrid('getcellvalue', rowindex1, "jvdocno");
                
                $('#documentSearchWindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="documentSearchGridID"></div> 