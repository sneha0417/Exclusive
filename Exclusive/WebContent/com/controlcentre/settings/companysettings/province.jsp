<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 
  <%@page import="com.controlcentre.masters.client.ClsClientDAO" %>
   <%@page import="com.controlcentre.settings.companysettings.branch.ClsBranchDAO" %>
 
 <%
 
 ClsBranchDAO ClsBranchDAO=new ClsBranchDAO();
 %>

 <script type="text/javascript">
 
 var radata;
<%--  if('NA' != '<%=item%>')  {
	 radata = '<%=item%>';
 } 
  --%>
  var value = '<%=request.getParameter("getprovince")%>';
  var rowIndex = '<%=request.getParameter("rowBoundIndex")%>';
  <%-- radata='<%=ClsBranchDAO.provincesearch(session)%>'; --%>
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'code', type: 'String'  },
     						{name : 'name', type: 'String'  },
     						{name : 'doc_no', type: 'String'  },
     						
     						
     					
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
            $("#jqxareasearch").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
            
            
     					
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Province Code', datafield:'code', width: '50%' },
					{ text: 'Province Name', datafield: 'name', width: '50%' },
					{ text: 'doc no', datafield: 'doc_no', width: '50%',hidden:true },
					
					 
					]
            });
    
          //  $("#jqxareasearch").jqxGrid('addrow', null, {});
      
				            
				          /* $('#jqxareasearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				            	  var temp="";
				            	  temp=temp+$('#jqxareasearch').jqxGrid('getcellvalue', rowindex1, "country_name");
				                temp=temp+","+$('#jqxareasearch').jqxGrid('getcellvalue', rowindex1, "region_name");
				                //temp=temp+","+$('#jqxareasearch').jqxGrid('getcellvalue', rowindex1, "region_name");
				                
				                if(value==0)
				            	   {
				                	
						            	document.getElementById("txtareadet").value=temp; 
						                document.getElementById("txtareaid").value=$('#jqxareasearch').jqxGrid('getcellvalue', rowindex1, "areadocno");
						               document.getElementById("txtarea").value=$('#jqxareasearch').jqxGrid('getcellvalue', rowindex1, "area");
				            	   }
				              
				               
				               
				               if(value==1)
				            	   {
				            	  
				               			$('#cpDetailsGrid').jqxGrid('setcellvalue', rowIndex, "area",$('#jqxareasearch').jqxGrid('getcellvalue', rowindex1, "area"));
				               			$('#cpDetailsGrid').jqxGrid('setcellvalue', rowIndex, "areaid",$('#jqxareasearch').jqxGrid('getcellvalue', rowindex1, "areadocno"));
				            	   }
				              
				                $('#provinceinfowindow').jqxWindow('close');
				               
				            
				            		 }); */
				            		 $('#jqxareasearch').on('rowdoubleclick', function (event) 
				            				 {
				            			 var rowindex1=event.args.rowindex;
				            			 document.getElementById("txtprovince").value=$('#jqxareasearch').jqxGrid('getcellvalue', rowindex1, "name");
				            			 
				            			 document.getElementById("txtdocno").value=$('#jqxareasearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
				            			 
				            			 
				            			 $('#provinceinfowindow').jqxWindow('close');
				            			 			            			 
        });
				           
        
                  }); 
				       
                       
    </script>
    <div id="jqxareasearch"></div>
    
    </body>
</html>