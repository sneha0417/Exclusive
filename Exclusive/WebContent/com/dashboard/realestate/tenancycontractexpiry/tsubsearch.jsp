 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

  <%@page import="com.dashboard.realestate.tenancycontractclose.ClsTenancycontractcloseDAO" %>
<%ClsTenancycontractcloseDAO DAO=new ClsTenancycontractcloseDAO();
String sclname = request.getParameter("sclname")==null?"0":request.getParameter("sclname");
 String smob = request.getParameter("smob")==null?"0":request.getParameter("smob");
 String rno = request.getParameter("rno")==null?"0":request.getParameter("rno");
 String contact =request.getParameter("contact")==null?"0":request.getParameter("contact");
%> 
 <script type="text/javascript">
 
  var loaddata;
 
 
 loaddata='<%=DAO.clientSrearch(session,sclname,smob,rno,contact)%>';
               
        $(document).ready(function () { 
         
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                             
                             
                         	
                         
     						{name : 'refname', type: 'String'  },
     						{name : 'com_mob', type: 'String'  },
      						{name : 'cldocno', type: 'String'  },
      						{name : 'contact', type: 'String'  }
      						
      						
                          	],
                          	localdata: loaddata,
                          
          
				
                
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
            $("#jqxmainsearch").jqxGrid(
            {
                width: '100%',
                height: 280,
                source: dataAdapter,
                columnsresize: true,
               
           
                selectionmode: 'singlerow',
             
               
                //Add row method
	
     						
     					
     					
                columns: [
                     	 { text: 'Doc No', datafield: 'cldocno', width: '10%'  },
					{ text: 'NAME', datafield: 'refname'  }, 
					{ text: 'MOB', datafield: 'com_mob', width: '20%' },
				
					 { text: 'CONTACT', datafield: 'contact', width: '20%' }
					 
					]
            });
    
            //$("#jqxmainsearch").jqxGrid('addrow', null, {});
      
				            
				          $('#jqxmainsearch').on('rowdoubleclick', function (event) 
				            		{ 
				        	  var rowindex1=event.args.rowindex;   
				          
				               document.getElementById("cldocno").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
				                     document.getElementById("clientname").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "refname");
				                     
				              
				                     $('#accountSearchwindow').jqxWindow('close');  
				               
				            
				            		 });	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="jqxmainsearch"></div>
    
