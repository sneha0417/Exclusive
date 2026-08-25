<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.taxMaster.ClstaxMasterDAO"%>
<%ClstaxMasterDAO DAO= new ClstaxMasterDAO();%>
<script type="text/javascript">

     var accsearch= '<%=DAO.accounttypesearch() %>';
     
		$(document).ready(function () { 	
           
			var source =
            {
                datatype: "json",  
                datafields: [
                              {name : 'doc_no', type: 'int'  },
                              {name : 'account', type: 'string'  },
                              {name : 'description', type: 'string'  },
                              
                            ],
                       localdata: accsearch,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#accountgrid").jqxGrid(
            {
                width: '100%',
                height: 355,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
                              { text: 'Doc_no', datafield: 'doc_no', width: '40%',hidden:true},
                              { text: 'Description', datafield: 'description', width: '50%' },
                              { text: 'Account', datafield: 'account', width: '50%' },
                              
						]
            });
            
           
           
            
          $('#accountgrid').on('rowdoubleclick', function (event) {
        	
                var rowindex1= event.args.rowindex;
                
                document.getElementById("txtaccname").value=$('#accountgrid').jqxGrid('getcellvalue', rowindex1, "description");
                document.getElementById("txtaccno").value=$('#accountgrid').jqxGrid('getcellvalue', rowindex1, "account");
                document.getElementById("accdocno").value=$('#accountgrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
                
                 
                
               
              $('#accountwindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id=accountgrid></div> 