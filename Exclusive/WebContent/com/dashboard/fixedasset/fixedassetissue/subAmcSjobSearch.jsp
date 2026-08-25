<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.fixedasset.fixedassetissue.ClsFixedAssetIssueDAO"%>
<% ClsFixedAssetIssueDAO searchDAO = new ClsFixedAssetIssueDAO(); %> 
 <%
 String typedocno=request.getParameter("docnoss")==null?"0":request.getParameter("docnoss");
 String check=request.getParameter("check")==null?"1":request.getParameter("check");
 String refnames=request.getParameter("refnames")==null?"0":request.getParameter("refnames");
 String dtype=request.getParameter("dtype")==null?"0":request.getParameter("dtype");
 System.out.println("dtype="+dtype+"check="+check);
%>
 
<script type="text/javascript">

    $(document).ready(function () { 	
        	var costunit;

        	var temps='<%=check%>';

        	if(temps=="1")
        		{
        		costunit='<%=searchDAO.amcSjobSearch(session,typedocno,refnames,check,dtype) %>'; 
        		temps="";
        		}
        	else
        		{
        		costunit; 
        		}


 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                             {name : 'tr_no', type: 'int'},   
                             {name : 'doc_no', type: 'int'},  
     		 				 {name : 'customer', type: 'string'},
     						 {name : 'prjname', type: 'string'   },
     						 {name : 'cldocno', type: 'string'   },
     						 {name : 'site', type: 'string'   },
     						 {name : 'siteid', type: 'string'   },
                 ],
                 localdata: costunit,
                
                
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

            
            
            $("#amcsjobsearch").jqxGrid(
            {
                width: '100%',
                height: 320,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
             
                
          
          

                       
                columns: [      
                         
							{ text: 'DocNo', datafield: 'doc_no', width: '10%', editable: false },	
							{ text: 'Customer', datafield: 'customer', width: '50%' , editable: false},
							{ text: 'Project Name', datafield: 'prjname', width: '40%', editable: false },
							
				
							{ text: 'cldocno', datafield: 'cldocno', width: '40%', editable: false ,hidden:true },
							{ text: 'site', datafield: 'site', width: '40%', editable: false ,hidden:true   },
							{ text: 'siteid', datafield: 'siteid', width: '40%', editable: false ,hidden:true  },
		 
							
							{ text: 'tr_no', datafield: 'tr_no', width: '40%', editable: false,hidden:true  },	
							
							
							
			              ]
            
            
            });
            
            
            $('#amcsjobsearch').on('rowdoubleclick', function (event) {
         	   
         	      var rowindex1 = event.args.rowindex;      
                  document.getElementById("txtjobno").value=$('#amcsjobsearch').jqxGrid('getcellvalue', rowindex1, "customer");
             	  document.getElementById("txtjobid").value=$('#amcsjobsearch').jqxGrid('getcellvalue', rowindex1, "tr_no");
             	   
                  $('#jobDetailsWindow').jqxWindow('close'); 
             });  
            
        });
    </script>
    <div id=amcsjobsearch></div>
 