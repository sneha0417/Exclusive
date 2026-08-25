 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.sales.InventoryTransfer.materialrequest.ClsMaterialrequestDAO"%>
<% ClsMaterialrequestDAO searchDAO = new ClsMaterialrequestDAO(); 

String typedocno = request.getParameter("typedocno")==null?"0":request.getParameter("typedocno").trim();
String tr_no = request.getParameter("tr_no")==null?"0":request.getParameter("tr_no").trim();
%>  


 
<script type="text/javascript">


var sitedata= '<%=searchDAO.sitesearch(session,typedocno,tr_no) %>';   
        $(document).ready(function () { 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [


                             {name : 'siteid', type: 'String'  },    
      						{name : 'site', type: 'String'  },
      				 
                             
                             
                        ],
                		localdata: sitedata, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#sitegrid").jqxGrid(
            {
                width: '100%',
                height: 335,
                source: dataAdapter,
           
                selectionmode: 'singlerow',
                
                columns: [
                          
          				{ text: 'ID', datafield: 'siteid', width: '20%',hidden:true},
    					{ text: 'NAME', datafield: 'site', width: '100%' }
										
						]
            });
            
             $('#sitegrid').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
 
 
                document.getElementById("errormsg").innerText="";
                document.getElementById("siteid").value = $('#sitegrid').jqxGrid('getcellvalue', rowindex1, "siteid");
                
                document.getElementById("site").value = $('#sitegrid').jqxGrid('getcellvalue', rowindex1, "site");

              $('#sitewindow').jqxWindow('close');  
        
            }); 
             
        });
    </script>
    <div id="sitegrid"></div>