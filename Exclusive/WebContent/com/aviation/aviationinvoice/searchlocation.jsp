<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.procurement.purchase.goodsreceiptnote.ClsgoodsreceiptnoteDAO"%>
<% ClsgoodsreceiptnoteDAO searchDAO = new ClsgoodsreceiptnoteDAO(); %> 


 
<script type="text/javascript">


var locdata= '<%=searchDAO.locationsearch(session) %>';   
        $(document).ready(function () { 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [


                             {name : 'doc_no', type: 'String'  },    
      						{name : 'loc_name', type: 'String'  },
      				 
                             
                             
                        ],
                		localdata: locdata, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#locgrid").jqxGrid(
            {
                width: '100%',
                height: 335,
                source: dataAdapter,
           
                selectionmode: 'singlerow',
                
                columns: [
                          
          				{ text: 'ID', datafield: 'doc_no', width: '20%',hidden:true},
    					{ text: 'NAME', datafield: 'loc_name', width: '100%' }
										
						]
            });
            
             $('#locgrid').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
 
              //   txtlocationid
                document.getElementById("errormsg").innerText="";
                document.getElementById("txtlocationid").value = $('#locgrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
                
                document.getElementById("txtlocation").value = $('#locgrid').jqxGrid('getcellvalue', rowindex1, "loc_name");

              $('#locationwindow').jqxWindow('close');  
        
            }); 
             
        });
    </script>
    <div id="locgrid"></div>