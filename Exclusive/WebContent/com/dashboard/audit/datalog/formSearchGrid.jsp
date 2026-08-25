<%@page import="com.dashboard.audit.datalog.ClsDataLogDAO"%>
<%ClsDataLogDAO logdao=new ClsDataLogDAO();%>

       <script type="text/javascript">
  
	    var formdata='<%=logdao.getForm()%>'; 
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            
                            {name : 'menu', type: 'string'  },
                            {name : 'mno', type: 'string'  }
     						
                        ],
                		
                		//  url: url1,
                 localdata: formdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#formSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 357,
                source: dataAdapter,
                columnsresize: true,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
                              { text: 'DOC NO', datafield: 'mno', width: '20%',hidden:true},
                              { text: 'Form', datafield: 'menu', width: '100%' },
						]
            });
            
          $('#formSearchGrid').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                document.getElementById("form").value=$('#formSearchGrid').jqxGrid('getcellvalue', rowindex2, "menu");
                document.getElementById("hidform").value=$('#formSearchGrid').jqxGrid('getcellvalue', rowindex2, "mno");
               $('#formwindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="formSearchGrid"></div>