<%@ page import="com.dashboard.audit.loginprivilage.ClsLoginPrivilageDAO" %>
<% ClsLoginPrivilageDAO DAO=new ClsLoginPrivilageDAO(); %>
       
<script type="text/javascript">
  
	    var data1='<%=DAO.userDetailsSearchGridLoading()%>';
		
	    $(document).ready(function () { 	
           
            var source =
            {
                datatype: "json",
                datafields: [
                            
                            {name : 'doc_no', type: 'string'  },
                            {name : 'user_name', type: 'string'  },
                            {name : 'user_role', type: 'string'  },
                        ],
                 		localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#usersearch").jqxGrid(
            {
                width: '100%',
                height: 357,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
                          
                              { text: 'Doc No', datafield: 'doc_no', hidden: true, width: '15%'},
                              { text: 'User Name', datafield: 'user_name', width: '60%' },
                              { text: 'Role', datafield: 'user_role', width: '40%' },
						
						]
            });
            
          $('#usersearch').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                document.getElementById("txtusername").value=$('#usersearch').jqxGrid('getcellvalue', rowindex2, "user_name");
                document.getElementById("txtuserdocno").value=$('#usersearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
           
              $('#userDetailsSearchWindow').jqxWindow('close'); 
            }); 
          
        });
	    
    </script>
    <div id="usersearch"></div>