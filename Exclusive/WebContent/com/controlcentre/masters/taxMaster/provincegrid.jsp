<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.taxMaster.ClstaxMasterDAO"%>
<%ClstaxMasterDAO DAO= new ClstaxMasterDAO();%>
<script type="text/javascript">

     var prvsearch= '<%=DAO.provincetypesearch() %>';     
     
		$(document).ready(function () { 	
           
			var source =
            {
                datatype: "json",  
                datafields: [
                              {name : 'doc_no', type: 'int'  },
                              {name : 'ptype', type: 'string'  },
                              
                            ],
                       localdata: prvsearch,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#provincegrid").jqxGrid(
            {
                width: '100%',
                height: 355,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
                              { text: 'Doc_no', datafield: 'doc_no', width: '40%',hidden:true},
                              { text: 'Province Type', datafield: 'ptype', width: '100%' },
                              
						]
            });
            
           
           
            
          $('#provincegrid').on('rowdoubleclick', function (event) {
        	
                var rowindex1= event.args.rowindex;
                
            document.getElementById("txtprovince").value=$('#provincegrid').jqxGrid('getcellvalue', rowindex1, "ptype");
                document.getElementById("txtprovinceid").value=$('#provincegrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
                
                 
                
               
              $('#provincewindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id=provincegrid></div> 