<%-- <%
String item1 = request.getParameter("item1")==null?"NA":request.getParameter("item1");

%> --%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.client.ClsClientDAO" %>
 <%
 ClsClientDAO DAO=new ClsClientDAO();
String sclname = request.getParameter("sclname")==null?"0":request.getParameter("sclname");
 String smob = request.getParameter("smob")==null?"0":request.getParameter("smob");
 String rno = request.getParameter("rno")==null?"0":request.getParameter("rno");
 String contact =request.getParameter("contact")==null?"0":request.getParameter("contact");
%> 
 <script type="text/javascript">
 
  var loaddata;
  <%--if('NA' != '<%=item1%>')  {
	 loaddata = '<%=item1%>';
 }
 alert("radata"+loaddata); --%>
 
 loaddata='<%=DAO.mainSrearch(session,sclname,smob,rno,contact)%>';
               
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
					{ text: 'NAME', datafield: 'refname', width: '40%' }, 
					{ text: 'MOB', datafield: 'com_mob', width: '30%' },
					 { text: 'Cldoc', datafield: 'cldocno', width: '15%',hidden:true },
					 { text: 'CONTACT', datafield: 'contact', width: '30%' }
					 
					]
            });
    
            //$("#jqxmainsearch").jqxGrid('addrow', null, {});
      
				            
				          $('#jqxmainsearch').on('rowdoubleclick', function (event) 
				            		{ 
				        	  var rowindex1=event.args.rowindex;
				            	
				            	
				        
				               document.getElementById("txtcode").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
				                     document.getElementById("txtclient_name").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "refname");
				                     
				              
				        
				                $('#window').jqxWindow('close');
				                $('#frmClientMaster txtcode').attr('disabled', false);
				                $('#frmClientMaster txtclient_name').attr('disabled', false);
				                
				                funSetlabel();
				                $('#frmClientMaster input').attr('disabled', false ); 
				                
				                document.getElementById("frmClientMaster").submit();
				            	
				               
				            
				            		 });	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="jqxmainsearch"></div>
    
