<%@page import="com.project.execution.callRegister.ClsCallRegisterDAO"%>
<% ClsCallRegisterDAO DAO= new ClsCallRegisterDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String contractdetails = request.getParameter("contractdetails")==null?"0":request.getParameter("contractdetails");
 String contractno = request.getParameter("contractno")==null?"0":request.getParameter("contractno");
 String contracttype = request.getParameter("contracttype")==null?"0":request.getParameter("contracttype");
 String branch = request.getParameter("branch")==null?"0":request.getParameter("branch");
 String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno");
 String check = request.getParameter("check")==null?"0":request.getParameter("check");
 String area = request.getParameter("area")==null?"0":request.getParameter("area");
 String site = request.getParameter("site")==null?"0":request.getParameter("site");
 System.out.println("site=="+site);
 %>
<script type="text/javascript">
        
       var data5= '<%=DAO.contractDetailsSearch (contractno, contractdetails, branch, contracttype, cldocno, check,area,site)%>';  
        $(document).ready(function () { 
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'int'   },
     						{name : 'refno', type: 'string'   },
     						{name : 'tr_no', type: 'int'   },
     						{name : 'site', type: 'string'   },
     						{name : 'area', type: 'string'   },
     						{name : 'rowno', type: 'int'   }
                        ],
                		 localdata: data5,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#contractDetailsSearch").jqxGrid(
            {
                width: '100%',
                height: 285,
                source: dataAdapter,
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Doc No', datafield: 'doc_no', width: '20%' },
							{ text: 'Ref No', datafield: 'refno', width: '20%' },
							{ text: 'Site', datafield: 'site', width: '30%' },
							{ text: 'Area', datafield: 'area', width: '30%' },
							{ text: 'Tr No',  datafield: 'tr_no', hidden: true, width: '5%' },
							{ text: 'Site Id',  datafield: 'rowno', hidden: true, width: '5%' },
						]
            });
            
             $('#contractDetailsSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("txtcontractno").value = $('#contractDetailsSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("txtcontractdetails").value = $('#contractDetailsSearch').jqxGrid('getcellvalue', rowindex1, "refno");
            	document.getElementById("txtcontracttrno").value = $('#contractDetailsSearch').jqxGrid('getcellvalue', rowindex1, "tr_no");
            	document.getElementById("txtsiteid").value = $('#contractDetailsSearch').jqxGrid('getcellvalue', rowindex1, "rowno");
            	document.getElementById("txtsite").value = $('#contractDetailsSearch').jqxGrid('getcellvalue', rowindex1, "site");
            	
            	$("#callRegisterPendingDiv").load("callRegisterPendingGrid.jsp?contractno="+$('#contractDetailsSearch').jqxGrid('getcellvalue', rowindex1, "tr_no"));
            	
            	$('#contractDetailsWindow').jqxWindow('close'); 
            });  
        });
 
</script>
<div id="contractDetailsSearch"></div>
 