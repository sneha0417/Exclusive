<%@page import="com.dashboard.audit.datalog.ClsDataLogDAO"%>
<%ClsDataLogDAO logdao=new ClsDataLogDAO();%>

       <script type="text/javascript">
  
	    var userdata='<%=logdao.getUser()%>';
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            
                            {name : 'user', type: 'string'  },
                            {name : 'doc_no', type: 'string'  }
     						
                        ],
                		
                		//  url: url1,
                 localdata: userdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#userSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 357,
                source: dataAdapter,
                columnsresize: true,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
                              { text: 'DOC NO', datafield: 'doc_no', width: '20%',hidden:true},
                              { text: 'Name', datafield: 'user', width: '100%' },
						]
            });
            
          $('#userSearchGrid').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                document.getElementById("user").value=$('#userSearchGrid').jqxGrid('getcellvalue', rowindex2, "user");
                document.getElementById("hiduser").value=$('#userSearchGrid').jqxGrid('getcellvalue', rowindex2, "doc_no");
                
               $('#userwindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="userSearchGrid"></div>