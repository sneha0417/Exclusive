<%@page import="com.controlcentre.settings.userrolebi.ClsUserRoleBIDAO" %>
<%ClsUserRoleBIDAO urb=new ClsUserRoleBIDAO(); %>

<script type="text/javascript">
        
   var data= '<%=urb.userRoleSearch()%>'; 
        $(document).ready(function () { 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int'   },
     						{name : 'user_role', type: 'string'   }
                        ],
                		localdata: data, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxRoleSearch").jqxGrid(
            {
                width: '100%',
                height: 375,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                
                columns: [
                            { text: 'Role Id', datafield: 'doc_no', width: '20%' },
							{ text: 'User Role', datafield: 'user_role', width: '80%' },
						]
            });
            
             $('#jqxRoleSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("txtroleid").value = $('#jqxRoleSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("txtrolename").value = $('#jqxRoleSearch').jqxGrid('getcellvalue', rowindex1, "user_role");

              $('#userRoleDetailsWindow').jqxWindow('close');  
            });  
        });
    </script>
    <div id="jqxRoleSearch"></div>
 