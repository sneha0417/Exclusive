<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 
<%@page import="com.dashboard.fixedasset.fixedassetissuelist.ClsFixedAssetIssueListDAO"%>
<% ClsFixedAssetIssueListDAO searchDAO = new ClsFixedAssetIssueListDAO(); %> 
 
 <%
 String check=request.getParameter("check")==null?"0":request.getParameter("check");
%>
<script type="text/javascript">



            	
        $(document).ready(function () { 	
        	var empacount;

        	var temps='<%=check%>';

        	if(temps=="1")
        		{
        		empacount='<%=searchDAO.accountSearch() %>'; 
        		temps="";
        		}
        	else
        		{
        		empacount; 
        		}


 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                             {name : 'doc_no', type: 'int'},  
     		 				 {name : 'description', type: 'string'},
     		 				 {name : 'account', type: 'string'},
                 ],
                 localdata: empacount,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			            
		            }		
            );

            
            
            $("#empaccountsearch").jqxGrid(
            {
                width: '100%',
                height: 366,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                       
                columns: [   
							{ text: 'Sr. No.',datafield: '',columntype:'number', width: '5%', cellsrenderer: function (row, column, value) {
    								return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
								}   },
							{ text: 'DocNo', datafield: 'doc_no', width: '10%', editable: false,hidden:true },
							{ text: 'Account No', datafield: 'account', width: '10%', editable: false,hidden: false },
							{ text: 'Description', datafield: 'description' , editable: false,width:'85%'},
			              ]
            });
            $('#empaccountsearch').on('rowdoubleclick', function (event) {
         	   
         	   		var rowindex1 = event.args.rowindex;       
                	document.getElementById("txtemployee").value=$('#empaccountsearch').jqxGrid('getcellvalue', rowindex1, "description");
             	    document.getElementById("txtemployeedocno").value=$('#empaccountsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
             	 
             	 
                 $('#accountDetailsWindow').jqxWindow('close'); 
             });  
            
               
         
            
            
        
        
      
   
        });
    </script>
    <div id=empaccountsearch></div>
 