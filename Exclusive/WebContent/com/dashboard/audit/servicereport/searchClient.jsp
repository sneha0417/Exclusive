<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.audit.servicereport.ClsServiceReport" %>
<%
ClsServiceReport DAO= new ClsServiceReport();
String clname = request.getParameter("clname")==null?"0":request.getParameter("clname");
 String mob = request.getParameter("mob")==null?"0":request.getParameter("mob");
%> 

 <script type="text/javascript">
 
 var cldata;

 cldata='<%=DAO.searchClient(session,clname,mob)%>';
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
     						 {name : 'mail1', type: 'String'  },
     						 {name : 'pertel', type: 'String'  },
     						
                          	],
                          	localdata: cldata,
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
            $("#Jqxclientsearch").jqxGrid(
            {
                width: '100%',
                height: 285,
                source: dataAdapter,
                columnsresize: true,
               
           
                selectionmode: 'singlerow',
             
               
                //Add row method
	
     						
     					
     					
                columns: [
					{ text: 'CLIENT NO', datafield: 'cldocno', width: '10%' },
					{ text: 'NAME', datafield: 'refname', width: '30%' },
					{ text: 'ADDRESS', datafield: 'address', width: '60%' }, 
					{ text: 'TEL', datafield: 'pertel', width: '10%' ,hidden:true}, 
					{ text: 'MOB', datafield: 'per_mob', width: '15%' ,hidden:true},
					 { text: 'Mail', datafield: 'mail1', width: '20%',hidden:true },
					
					
					
					]
            });
    
           
          /*   $("#Jqxclientsearch").jqxGrid('addrow', null, {}); */
				            
				           $('#Jqxclientsearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				            	
				              	 
				                document.getElementById("clientid").value= $('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
				               document.getElementById("txtclient").value=$('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "refname");
				             
				               $("#jqxloaddataGrid").jqxGrid('clear'); 
				   			   $("#jqxloaddataGrid").jqxGrid('addrow', null, {});
				               $('#clientsearch1').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="Jqxclientsearch"></div>
    