<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.taxMaster.ClstaxMasterDAO"%>
<%ClstaxMasterDAO DAO= new ClstaxMasterDAO();%>
<script type="text/javascript">

     var taxsearch= '<%=DAO.taxsubsearch() %>';    
     
		$(document).ready(function () { 	
           
			var source =
            {
                datatype: "json",  
                datafields: [
                              {name : 'doc_no', type: 'int'  },
                              {name : 'taxcode', type: 'string'  },
                              {name : 'taxname', type: 'string'  },
                              
                            ],
                       localdata: taxsearch,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#taxgrid").jqxGrid(
            {
                width: '100%',
                height: 355,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
                              { text: 'Doc_no', datafield: 'doc_no', width: '40%',hidden:true},
                              { text: 'Tax Code', datafield: 'taxcode', width: '100%',hidden:true },
                              { text: 'Tax Name', datafield: 'taxname', width: '100%' },
                              
						]
            });
            
           
           
            
          $('#taxgrid').on('rowdoubleclick', function (event)
          {
        	  
                var rowindex1= event.args.rowindex;
                
            	document.getElementById("txtappliedon").value=$('#taxgrid').jqxGrid('getcellvalue', rowindex1, "taxname");            
                document.getElementById("hidtaxid").value=$('#taxgrid').jqxGrid('getcellvalue', rowindex1, "taxcode");   
                document.getElementById("hidtaxdocid").value=$('#taxgrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
                $('#taxwindow').jqxWindow('close');
               
            }); 
        });
	
    </script>
    <div id=taxgrid></div> 