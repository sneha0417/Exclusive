<%@page import="com.operations.marketing.enquirynew.ClsEnquiryDAO" %>
<% ClsEnquiryDAO DAO=new ClsEnquiryDAO(); %>  
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.analysis.pendingcontract.ClsPendingContract" %>
<%
 String slname = request.getParameter("slname")==null?"0":request.getParameter("slname");
 String mob = request.getParameter("mob")==null?"0":request.getParameter("mob");
 int id=request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
%> 

 <script type="text/javascript">
 
 		var sldata='<%=DAO.salesManDetailsSearch(session,slname,mob,id)%>';
        
		$(document).ready(function () { 

        	var source = 
            {
                datatype: "json",
                datafields: [
                         
     						{name : 'doc_no', type: 'String'  },
     						{name : 'sal_name', type: 'String'  },
     						{name : 'mob_no', type: 'String'  }
     						
                          	],
                          	localdata: sldata,
                
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

            $("#salesManDetailsSearchGridID").jqxGrid(
            {
                width: '100%',
                height: 285,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
     					
                columns: [
							{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
							{ text: 'Name', datafield: 'sal_name', width: '60%' },
							{ text: 'Mobile', datafield: 'mob_no', width: '30%' }, 
						 ]
            });
    
           
			   $('#salesManDetailsSearchGridID').on('rowdoubleclick', function (event)  { 
				              	
				   var rowindex1=event.args.rowindex;

				   document.getElementById("txtsalesmandocno").value= $('#salesManDetailsSearchGridID').jqxGrid('getcellvalue', rowindex1, "doc_no");
				   document.getElementById("txtsalesman").value=$('#salesManDetailsSearchGridID').jqxGrid('getcellvalue', rowindex1, "sal_name");
				                
				   $('#salesManDetailsWindow').jqxWindow('close');
				            		 
			   }); 	 
                  
		}); 
				       
                       
    </script>
    <div id="salesManDetailsSearchGridID"></div>
    