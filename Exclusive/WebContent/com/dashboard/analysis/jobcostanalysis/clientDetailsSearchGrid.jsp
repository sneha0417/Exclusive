<%@page import="com.dashboard.analysis.jobcostanalysis.ClsJobCostAnalysisDAO" %>
<% ClsJobCostAnalysisDAO DAO=new ClsJobCostAnalysisDAO(); %>  
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.analysis.pendingcontract.ClsPendingContract" %>
<%
 String clname = request.getParameter("clname")==null?"0":request.getParameter("clname");
 String mob = request.getParameter("mob")==null?"0":request.getParameter("mob");
 int id=request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
%> 

 <script type="text/javascript">
 
 		var cldata='<%=DAO.clientDetailsSearch(session,clname,mob,id)%>';
        
		$(document).ready(function () { 

        	var source = 
            {
                datatype: "json",
                datafields: [
                         
     						{name : 'cldocno', type: 'String'  },
     						{name : 'refname', type: 'String'  },
     						 {name : 'address', type: 'String'  }, 
     						{name : 'per_mob', type: 'String'  },
     						 {name : 'mail1', type: 'String'  },
     						 {name : 'pertel', type: 'String'  },
     						
                          	],
                          	localdata: cldata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );

            $("#clientDetailsSearchGridID").jqxGrid(
            {
                width: '100%',
                height: 285,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
     					
                columns: [
							{ text: 'Doc No', datafield: 'cldocno', width: '10%' },
							{ text: 'Name', datafield: 'refname', width: '30%' },
							{ text: 'Address', datafield: 'address', width: '60%' }, 
							{ text: 'Tel', datafield: 'pertel', width: '10%' ,hidden:true}, 
							{ text: 'Mob', datafield: 'per_mob', width: '15%' ,hidden:true},
							{ text: 'Mail', datafield: 'mail1', width: '20%',hidden:true },
						 ]
            });
    
           
			   $('#clientDetailsSearchGridID').on('rowdoubleclick', function (event)  { 
				              	
				   var rowindex1=event.args.rowindex;

				   document.getElementById("txtclientdocno").value= $('#clientDetailsSearchGridID').jqxGrid('getcellvalue', rowindex1, "cldocno");
				   document.getElementById("txtclient").value=$('#clientDetailsSearchGridID').jqxGrid('getcellvalue', rowindex1, "refname");
				                
				   $('#clientDetailsWindow').jqxWindow('close');
				            		 
			   }); 	 
                  
		}); 
				       
                       
    </script>
    <div id="clientDetailsSearchGridID"></div>
    