<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.projectexecution.deploytechnician.ClsDeployTechnicianDAO"%> 
<% ClsDeployTechnicianDAO DAO=new ClsDeployTechnicianDAO(); %> 
 <%
 String typedocno=request.getParameter("docnoss")==null?"0":request.getParameter("docnoss");
 String check=request.getParameter("check")==null?"0":request.getParameter("check");
 String refnames=request.getParameter("refnames")==null?"0":request.getParameter("refnames");
 String dtype=request.getParameter("dtype")==null?"0":request.getParameter("dtype");
%>
 
<script type="text/javascript">

    $(document).ready(function () { 	
        	var costunit;

        	var temps='<%=check%>';
        	
        	if(parseInt(temps)==1)
        		{
        		costunit='<%=DAO.jobSearchGridLoading(session,typedocno,refnames,check,dtype) %>'; 
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
                width: '99%',
                height: 303,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlerow',

                       
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
                  document.getElementById("txtjobno").value=$('#amcsjobsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
             	  document.getElementById("txtjobid").value=$('#amcsjobsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
             	   
                  $('#jobDetailsWindow').jqxWindow('close'); 
             });  
            
        });
    </script>
    <div id=amcsjobsearch></div>
 