<%@page import="com.dashboard.marketing.estimationanalysis.ClsEstimationAnalysisDAO" %>
<% ClsEstimationAnalysisDAO DAO=new ClsEstimationAnalysisDAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String partyname = request.getParameter("partyname")==null?"0":request.getParameter("partyname");
 String contactNo = request.getParameter("contactNo")==null?"0":request.getParameter("contactNo");
 String chk = request.getParameter("chk")==null?"0":request.getParameter("chk");%>
<script type="text/javascript">
        
       var data1= '<%=DAO.clientDetails(partyname, contactNo, chk)%>';  
       $(document).ready(function () { 

    	   // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
						{name : 'cldocno', type: 'String'  },
						{name : 'refname', type: 'String'  },
	 					{name : 'address', type: 'String'  }, 
						{name : 'per_mob', type: 'String'  },
	 					{name : 'mail1', type: 'String'  },
	 					{name : 'pertel', type: 'String'  }
                        ],
                		 localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#clientDetailsSearchGridId").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'CLIENT NO', datafield: 'cldocno', width: '10%' },
							{ text: 'NAME', datafield: 'refname', width: '30%' },
							{ text: 'ADDRESS', datafield: 'address', width: '60%' }, 
							{ text: 'TEL', datafield: 'pertel', width: '10%' ,hidden: true}, 
							{ text: 'MOB', datafield: 'per_mob', width: '15%' ,hidden: true},
							{ text: 'Mail', datafield: 'mail1', width: '20%',hidden: true },
						]
            });
            
             $('#clientDetailsSearchGridId').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("txtclientdocno").value = $('#clientDetailsSearchGridId').jqxGrid('getcellvalue', rowindex1, "cldocno");
            	document.getElementById("txtclient").value = $('#clientDetailsSearchGridId').jqxGrid('getcellvalue', rowindex1, "refname");
            	
            	$('#clientDetailsWindow').jqxWindow('close'); 
            });  
        });
    </script>
    <div id="clientDetailsSearchGridId"></div>
 