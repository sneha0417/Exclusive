<%-- <%
String item = request.getParameter("item")==null?"NA":request.getParameter("item");

%> --%>
<%@page import="com.dashboard.analysis.salesinvoice.ClsSalesInvoiceDAO" %>
<% ClsSalesInvoiceDAO csd=new ClsSalesInvoiceDAO();%>


<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 
String clname = request.getParameter("clname")==null?"0":request.getParameter("clname");
 String mob = request.getParameter("mob")==null?"0":request.getParameter("mob");
 String lcno = request.getParameter("lcno")==null?"0":request.getParameter("lcno");
 String passno = request.getParameter("passno")==null?"0":request.getParameter("passno");
 String nation = request.getParameter("nation")==null?"0":request.getParameter("nation");
 String dob = request.getParameter("dob")==null?"0":request.getParameter("dob");
 String branch = request.getParameter("branch")==null?"0":request.getParameter("branch");
%> 

 <script type="text/javascript">
 
 var radata;
<%--  if('NA' != '<%=item%>')  {
	 radata = '<%=item%>';
 } 
  --%>
  
  radata='<%=csd.getClient(branch,clname,mob,lcno,passno,nation,dob)%>';
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'cldocno', type: 'String'  },
     						{name : 'refname', type: 'String'  },
     						 {name : 'address', type: 'String'  }, 
     						{name : 'per_mob', type: 'String'  },
     						 {name : 'acno', type: 'String'  }, 
      						{name : 'codeno', type: 'String'  },
     						{name : 'sal_name', type: 'String'  },
     						{name : 'doc_no', type: 'String'  },
     						
     						{name : 'contactperson', type: 'String'},
     						{name : 'mail1', type: 'String'  },
     						{name : 'per_tel', type: 'String'  },
     						{name : 'dob', type: 'date' },
     						{name : 'dlno', type: 'String'  }, 
      						{name : 'nation', type: 'String' },
      						{name : 'drname', type: 'String' },
     						
      					
     						
                          	],
                          	localdata: radata,
                          //	 url: url1,
          
				
                
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
            $("#jqxclientsearch").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'checkbox',

                columns: [
					{ text: 'CLIENT NO', datafield: 'cldocno', width: '7%' },
					{ text: 'NAME', datafield: 'refname', width: '25%' },
					{ text: 'DRIVER NAME', datafield: 'drname', width: '14%',hidden:true },
					 { text: 'DOB', datafield: 'dob', width: '7%', cellsformat: 'dd.MM.yyyy' },
						{ text: 'MOB', datafield: 'per_mob', width: '9%' },
						 { text: 'TEL', datafield: 'per_tel', width: '8%' },
					 { text: 'LICENCE', datafield: 'dlno', width: '9%' },
					 { text: 'NATION', datafield: 'nation', width: '9%' },
					{ text: 'ADDRESS', datafield: 'address', width: '21%' }, 
					 { text: 'Acno', datafield: 'acno', width: '20%',hidden:true },
					 { text: 'Codeno', datafield: 'codeno', width: '20%',hidden:true },
					 { text: 'SALESMAN', datafield: 'sal_name', width: '20%',hidden:true },
					 { text: 'SAL_ID', datafield: 'doc_no', width: '20%',hidden:true },
					 { text: 'contactPerson', datafield: 'contactperson', width: '20%',hidden:true },
					 { text: 'mail1', datafield: 'mail1', width: '20%',hidden:true },
			
					
					 

					
					]
            });
				         
				           
				           
				           
				           
				           
                  }); 
				       
                       
    </script>
    <div id="jqxclientsearch"></div>
    
    </body>
</html>