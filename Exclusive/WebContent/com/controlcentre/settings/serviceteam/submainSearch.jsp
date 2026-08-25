<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.settings.serviceteam.ClsServiceTeamDAO"%>
<%ClsServiceTeamDAO DAO= new ClsServiceTeamDAO();
System.out.println("123456789"+request.getParameter("stype"));
String stype = request.getParameter("stype")==null?"0":request.getParameter("stype").toString();
 
 
%> 
 <script type="text/javascript">
 
  var searchdata;
  searchdata='<%=DAO.mainSrearch(stype)%>'; 
 
        $(document).ready(function () { 
         
            var source = 
            {
                datatype: "json",
                datafields: [
                             
              
     						{name : 'grpcode', type: 'String'  },
     						{name : 'desc1', type: 'String'  },
      						{name : 'docno', type: 'String'  },
      						{name : 'ismulemp', type: 'String'  },
      						{name : 'teamuserlinkid', type: 'String'  },
                          	{name : 'teamuserlinkname', type: 'String'  },
      						
                          	],
                          	localdata: searchdata,
                          
          
				
                
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
                height: 277,
                source: dataAdapter,
                columnsresize: true,
               
           
                selectionmode: 'singlerow',
             
               
                //Add row method
	
     						
     					
     					
                columns: [
					{ text: 'Group Code', datafield: 'grpcode', width: '35%' },
					{ text: 'Description', datafield: 'desc1', width: '50%' },
					{ text: 'Docno', datafield: 'docno', width: '15%'},
					{ text: 'ismulemp', datafield: 'ismulemp', width: '15%',hidden:true},
					{ text: 'Team User Link',datafield:'teamuserlinkname',width:'20%',hidden:true},
					{ text: 'Team User Link Id',datafield:'teamuserlinkid',width:'60%',hidden:true}
					
					]
            });
    
          /*   $("#jqxmainsearch").jqxGrid('addrow', null, {}); */
      
				            
				          $('#jqxmainsearch').on('rowdoubleclick', function (event) 
				            		{ 
				        	  var rowindex1=event.args.rowindex;
				            	
				         document.getElementById("docno").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "docno");
				         document.getElementById("txtgpcode").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "grpcode");
				         document.getElementById("txtdesc").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "desc1");
				         document.getElementById("txtteamuserlinkid").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "teamuserlinkid");
		                 document.getElementById("txtteamuserlinkname").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "teamuserlinkname");
		                	
				         var ismulemp=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "ismulemp");
				         if(ismulemp==1){
				        	 document.getElementById("ismemp").checked=true;
				        	 document.getElementById("ismultiemp").value=1;
				         }
				         var docno=$('#docno').val();
				         $("#searviceteamdiv").load("serviceteamGrid.jsp?docno="+docno);
				     	 
				     	 $('#frmServiceteam input').attr('disabled', false );
				                  
				                $('#window').jqxWindow('close');
				               
				            
				            		 });	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="jqxmainsearch"></div>
    
