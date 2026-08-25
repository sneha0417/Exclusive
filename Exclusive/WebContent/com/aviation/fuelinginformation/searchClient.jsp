 
  <%--  <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.aviation.fuelinginformation.ClsfuelingInformationDAO" 

 
%>

 
<%
ClsfuelingInformationDAO fuelinfoDAO=new ClsfuelingInformationDAO();
String clname = request.getParameter("clname")==null?"0":request.getParameter("clname");
 String mob = request.getParameter("mob")==null?"0":request.getParameter("mob");
 String aa = request.getParameter("aa")==null?"0":request.getParameter("aa");
 String dtypes = request.getParameter("dtypes")==null?"0":request.getParameter("dtypes");
 
 

%> 

 <script type="text/javascript">
 var dtype='<%=dtypes%>';
 var cldata='<%=fuelinfoDAO.searchClient(session,clname,mob,aa,dtypes)%>'; 
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
     						 {name : 'mail1', type: 'String'  }
      						
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
					{ text: 'MOB', datafield: 'per_mob', width: '15%' ,hidden:true},
					 { text: 'Mail', datafield: 'mail1', width: '20%',hidden:true },
					
					
					
					]
            });
    
           
   /*          $("#Jqxclientsearch").jqxGrid('addrow', null, {}); */
				            
				           $('#Jqxclientsearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				            	
				              	if(dtype=="CRM") 
				              		{
				              		 document.getElementById("cmbclient").value= $('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
						               document.getElementById("txtclientname").value=$('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "refname");
						            
				              		}
				              	else if(dtype=="VND")
				              		{
				              		document.getElementById("vendor").value= $('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
						            document.getElementById("txtvendorname").value=$('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "refname");
						            
				              		}
				               
				               
				               
				               /*  document.getElementById("txtaddress").value=$('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "address");
				         
				               
				               document.getElementById("txtmobile").value=$('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "per_mob");
				               document.getElementById("txtemail").value=$('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "mail1");
				               */
				                $('#clientsearch1').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="Jqxclientsearch"></div>
    