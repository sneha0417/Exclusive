 <%--  <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.sales.Sales.salesInvoice.ClsSalesInvoiceDAO"%>
<%ClsSalesInvoiceDAO DAO= new ClsSalesInvoiceDAO();
String clname = request.getParameter("clname")==null?"0":request.getParameter("clname");
 String mob = request.getParameter("mob")==null?"0":request.getParameter("mob");
 String Cl_clientsale = request.getParameter("Cl_clientsale")==null?"0":request.getParameter("Cl_clientsale");
 
%> 

 <script type="text/javascript">
 
 var cldata;

 cldata='<%=DAO.searchClient(session,clname,mob,Cl_clientsale)%>';
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
     						 
     						 {name : 'catid', type: 'String'  },
     						 {name : 'cat_name', type: 'String'  },
     						 {name : 'pricegroup', type: 'String'  },
     						 
     						 
     						 {name : 'saldocno', type: 'String'  },
     						 {name : 'sal_name', type: 'String'  },
     						  

     						 
     						
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
                height: 305,
                source: dataAdapter,
                columnsresize: true,
               
           
                selectionmode: 'singlerow',
             
               
                //Add row method
	
     						
     					
     					
                columns: [
					{ text: 'CLIENT NO', datafield: 'cldocno', width: '10%' },
					{ text: 'NAME', datafield: 'refname', width: '30%' },
					  
					{ text: 'MOB', datafield: 'per_mob', width: '10%'  },
					{ text: ' Sales Person', datafield: 'sal_name', width: '15%' }, 
					{ text: 'ADDRESS', datafield: 'address', width: '35%' }, 
					
					
					
					{ text: 'TEL', datafield: 'pertel', width: '10%' ,hidden:true}, 
 
					 { text: 'Mail', datafield: 'mail1', width: '20%',hidden:true },
					 
					 
					 { text: 'catid', datafield: 'catid', width: '20%',hidden:true  },
					 { text: 'cat_name', datafield: 'cat_name', width: '20%' ,hidden:true },
					 { text: 'pricegroup', datafield: 'pricegroup', width: '20%',hidden:true },
					
					
					
					]
            });
    
           
          /*   $("#Jqxclientsearch").jqxGrid('addrow', null, {}); */
				            
				           $('#Jqxclientsearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				            	
				              	 
				               document.getElementById("clientid").value=$('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
				               document.getElementById("txtclient").value=$('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "refname");
				               document.getElementById("txtclientdet").value=$('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "address");
				               
				               document.getElementById("txtclientmob").value=$('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "per_mob");
				               
				               
				               document.getElementById("clientcaid").value=$('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "catid");
				               document.getElementById("clientcatname").value=$('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "cat_name");
				               document.getElementById("clientpricegroup").value=$('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "pricegroup");
				               
				         
				         //      document.getElementById("txtsalesperson").value=$('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "sal_name");
				        //       document.getElementById("salespersonid").value=$('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "saldocno"); 
				               
				            /*    document.getElementById("user_namess").value=""; 
				               document.getElementById("pass_wordss").value="";  
				               document.getElementById("dscper").value="";  */
				               
		/* 		               var aa=$('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "pricegroup");
				               if(parseInt(aa)==0)
				            		   {
				            		 $('#user_namess').attr('disabled', false);
									 $('#pass_wordss').attr('disabled', true);
									 $('#dscper').attr('disabled', false);
									 $('#process').attr('disabled', false);
									 
									 $('#changeuser').attr('disabled', false);
									 funcksalesman();
									 
				            		   }   
				               else
				            	   {
				            		 $('#user_namess').attr('disabled', true);
									 $('#pass_wordss').attr('disabled', true);
									 $('#dscper').attr('disabled', true);
									 $('#process').attr('disabled', true);
									 $('#changeuser').attr('disabled', true);
				            	   }
				               
				          
				                */
				         
				               document.getElementById("errormsg").innerText="";
				              /*  document.getElementById("txtmobile").value=$('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "per_mob");
				               document.getElementById("txtemail").value=$('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "mail1");
				               document.getElementById("txttelno").value=$('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "pertel"); */
				               getCurrencyIds();
				               
				               $("#prodsearchtype").val(0);
				               
				               
                               $("#nettotal").val(0); 
				               			               
				               
				               $("#descPercentage").val(0);
				               $("#roundOf").val(0);
				               
				                $('#customerDetailsWindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="Jqxclientsearch"></div>
    