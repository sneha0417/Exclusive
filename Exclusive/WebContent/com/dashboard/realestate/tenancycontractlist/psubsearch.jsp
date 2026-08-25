  

  <%@page import="com.dashboard.realestate.tenancycontractclose.ClsTenancycontractcloseDAO" %>
<%ClsTenancycontractcloseDAO DAO=new ClsTenancycontractcloseDAO();

 
String docnoss = request.getParameter("docnoss")==null?"NA":request.getParameter("docnoss");
String owner = request.getParameter("accountss")==null?"NA":request.getParameter("accountss");
 String ptype = request.getParameter("accnamess")==null?"NA":request.getParameter("accnamess");

 String datess = request.getParameter("datess")==null?"0":request.getParameter("datess");
 

 String aa = request.getParameter("aa")==null?"NA":request.getParameter("aa"); 
 
 String descriptions = request.getParameter("descriptions")==null?"NA":request.getParameter("descriptions"); 
 
 String refnoss = request.getParameter("refnoss")==null?"NA":request.getParameter("refnoss"); 
 
 
%>
<script type="text/javascript">


var datamain1= '<%=DAO.pmaterearch(session,docnoss,owner,ptype,datess,aa,descriptions,refnoss) %>'; 
        $(document).ready(function () {  
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int'   },
                            
                            {name : 'voc_no', type: 'int'   },
                         
                            {name : 'date', type: 'date'   },
     					 
     						{name : 'owner', type: 'string'   },
     						{name : 'desc1', type: 'string'   },
     					 
     						{name : 'name', type: 'string'   },
     						
     						{name : 'type', type: 'string'   },
     						
     						
     					   {name : 'adate', type: 'date'   },
     				 
     					 
     						
     					 
     						
     						
     						
     						//atype code curid rate lpono sal_name sal_id deldate deltime fixdate costtr_no costtype
     						  
                        ],
                		localdata: datamain1, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#searshgrid").jqxGrid(
            {
                width: '100%',
                height: 283,
                source: dataAdapter,
           
                selectionmode: 'singlerow',
                
                columns: [
                
   						
   					 
                         
                            { text: 'Doc No', datafield: 'voc_no', width: '6%' },
							{ text: 'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
							
							{ text: 'Property Name', datafield: 'name', width: '20%'  },
							{ text: 'Owner ', datafield: 'owner', width: '30%'  },
							{ text: 'Status ', datafield: 'type', width: '10%'  },
							{ text: 'Available Date ', datafield: 'adate', width: '12%' ,cellsformat:'dd.MM.yyyy' },
						 { text: 'Description', datafield: 'desc1', width: '20%' },
								 
						]
            });
            
             $('#searshgrid').on('rowdoubleclick', function (event) {         
                var rowindex1 = event.args.rowindex;
                
           	 document.getElementById("prname").value = $('#searshgrid').jqxGrid('getcellvalue',rowindex1, "name");
        	 document.getElementById("prdocno").value = $('#searshgrid').jqxGrid('getcellvalue',rowindex1, "doc_no");
 
        	   $('#accountSearchwindow').jqxWindow('close');  
           	 
          
             
            }); 
             
        });
    </script>
    <div id="searshgrid"></div>