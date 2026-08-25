<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.taxMaster.ClstaxMasterDAO"%>
<%ClstaxMasterDAO DAO= new ClstaxMasterDAO();%>
<script type="text/javascript">

     var typesearch= '<%=DAO.producttypesearch() %>';
     
     
     
     
     
     
     
		$(document).ready(function () 
		{ 	
           
			var source =
            {
                datatype: "json",  
                datafields: [
                              {name : 'doc_no', type: 'int'  },
                              {name : 'ptype', type: 'string'  },
                              
                            ],
                       localdata: typesearch,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#productgrid").jqxGrid(
            {
                width: '100%',
                height: 355,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
                              { text: 'Doc_no', datafield: 'doc_no', width: '40%',hidden:true},
                              { text: 'Product Type', datafield: 'ptype', width: '100%' },
                              
						]
            });
            
             
          $('#productgrid').on('rowdoubleclick', function (event)
          {
        	
                var rowindex1= event.args.rowindex;
                
            	document.getElementById("txtprotype").value=$('#productgrid').jqxGrid('getcellvalue', rowindex1, "ptype");
                document.getElementById("txttypeid").value=$('#productgrid').jqxGrid('getcellvalue', rowindex1, "doc_no");               
               
           	    $('#productwindow').jqxWindow('close'); 
           }); 
        });
    </script>
    <div id=productgrid></div> 