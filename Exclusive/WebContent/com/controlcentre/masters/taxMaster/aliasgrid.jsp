<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.taxMaster.ClstaxMasterDAO"%>
<%ClstaxMasterDAO DAO= new ClstaxMasterDAO();%>
<script type="text/javascript">

     var aliassearch= '<%=DAO.aliassearch() %>';    
     
		$(document).ready(function () { 	
           
			var source =
            {
                datatype: "json",  
                datafields: [
                              {name : 'doc_no', type: 'int'  },
                              {name : 'alias', type: 'string'  },
                              
                            ],
                       localdata: aliassearch,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#aliasgrid").jqxGrid(
            {
                width: '100%',
                height: 355,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
                              { text: 'Doc_no', datafield: 'doc_no', width: '40%',hidden:true},
                              { text: 'Alias', datafield: 'alias', width: '100%' },
                              
						]
            });
            
           
           
            
          $('#aliasgrid').on('rowdoubleclick', function (event)
          {
        	  
                var rowindex1= event.args.rowindex;
                
            	document.getElementById("txtappliedon").value=$('#aliasgrid').jqxGrid('getcellvalue', rowindex1, "alias");            
                document.getElementById("hidaliasid").value=$('#aliasgrid').jqxGrid('getcellvalue', rowindex1, "doc_no");                
                $('#aliaswindow').jqxWindow('close');
               
            }); 
        });
	
    </script>
    <div id=aliasgrid></div> 