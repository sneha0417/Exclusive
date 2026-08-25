 <%--  <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@page import="com.dashboard.projectexecution.materialvariance.ClsMaterialVarianceDAO"%>
<%
ClsMaterialVarianceDAO DAO=new ClsMaterialVarianceDAO();
%>
<%

String clname = request.getParameter("clname")==null?"0":request.getParameter("clname");
 String doc = request.getParameter("doc")==null?"0":request.getParameter("doc");
%> 

 <script type="text/javascript">
 
 var cldata;

 cldata='<%=DAO.searchProject(session,clname,doc)%>';
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                         
     						{name : 'docno', type: 'String'  },
     						{name : 'refname', type: 'String'  },
     						 {name : 'trno', type: 'String'  }, 
     						
     						
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
            $("#Jqxprojectsearch").jqxGrid(
            {
                width: '100%',
                height: 285,
                source: dataAdapter,
                columnsresize: true,
               
           
                selectionmode: 'singlerow',
             
               
                //Add row method
	
     						
     					
     					
                columns: [
					{ text: 'Doc No', datafield: 'docno', width: '20%' },
					{ text: 'NAME', datafield: 'refname', width: '80%' },
					//{ text: 'ADDRESS', datafield: 'address', width: '60%' }, 
					{ text: 'trno', datafield: 'trno', width: '10%' ,hidden:true}, 
					
					
					
					]
            });
    
           
          /*   $("#Jqxprojectsearch").jqxGrid('addrow', null, {}); */
				            
				           $('#Jqxprojectsearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				            	
				              	 
				                document.getElementById("txtproject").value= $('#Jqxprojectsearch').jqxGrid('getcellvalue', rowindex1, "docno");
				               document.getElementById("hidtrno").value=$('#Jqxprojectsearch').jqxGrid('getcellvalue', rowindex1, "trno");
				             
				               $("#GridData").jqxGrid('clear'); 
				   			
				                $('#projectsearch').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="Jqxprojectsearch"></div>
    