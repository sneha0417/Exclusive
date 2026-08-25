<%@page import="com.dashboard.marketing.salesuserlink.ClsSalesUserLink" %>
<% ClsSalesUserLink DAO=new ClsSalesUserLink();%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
 String username = request.getParameter("usersname")==null?"0":request.getParameter("usersname");
 String userrole = request.getParameter("usersrole")==null?"0":request.getParameter("usersrole");
 String chk = request.getParameter("chk")==null?"0":request.getParameter("chk");%>
<script type="text/javascript">
        
       var data1= '<%=DAO.userDetails(username, userrole, chk)%>';  
       $(document).ready(function () { 

    	   // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'int'   },
     						{name : 'user_name', type: 'string'   },
     						{name : 'user_role', type: 'string'  }
                        ],
                		 localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#userDetailsSearchGridID").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Doc No',  datafield: 'doc_no', hidden: true, width: '5%' },
							{ text: 'User Name', datafield: 'user_name', width: '40%' },
							{ text: 'User Role', datafield: 'user_role', width: '60%' },
						]
            });
            
             $('#userDetailsSearchGridID').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                
                document.getElementById("txtuserdocno").value = $('#userDetailsSearchGridID').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("txtusername").value = $('#userDetailsSearchGridID').jqxGrid('getcellvalue', rowindex1, "user_name");
    	       	
            	$('#userDetailsWindow').jqxWindow('close'); 
            });  
        });
    </script>
    <div id="userDetailsSearchGridID"></div>
 