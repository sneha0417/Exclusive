<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.operations.marketing.enquiry.ClsEnquiryDAO"%>
<% ClsEnquiryDAO searchDAO = new ClsEnquiryDAO(); %> 

 
<script type="text/javascript">


var locdata= '<%=searchDAO.searchSource(session) %>';   
        $(document).ready(function () { 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [


                             {name : 'doc_no', type: 'String'  },    
      						{name : 'txtname', type: 'String'  },
      				 
                             
                             
                        ],
                		localdata: locdata, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#sourceGrid").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
           
                selectionmode: 'singlerow',
                
                columns: [
                          
          				{ text: 'ID', datafield: 'doc_no', width: '20%',hidden:true},
    					{ text: 'NAME', datafield: 'txtname', width: '100%' }
										
						]
            });
            
             $('#sourceGrid').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
 
              //   txtlocationid
                 document.getElementById("errormsg").innerText="";
                document.getElementById("sourceid").value = $('#sourceGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("txtsource").value = $('#sourceGrid').jqxGrid('getcellvalue', rowindex1, "txtname");

              $('#sourcesearchwndow').jqxWindow('close');  
        
            }); 
             
        });
    </script>
    <div id="sourceGrid"></div>