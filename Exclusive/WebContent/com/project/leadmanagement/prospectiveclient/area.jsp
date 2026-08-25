 
 

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@page import="com.project.leadmanagement.prospectiveclient.ClsProspectiveClientDAO" %>
 
<%ClsProspectiveClientDAO DAO=new ClsProspectiveClientDAO();%>
 <script type="text/javascript">


  var radata;
  var value = '<%=request.getParameter("getarea")%>';
  var rowIndex = '<%=request.getParameter("rowBoundIndex")%>';
  radata='<%=DAO.areaSearch(session)%>';
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'areadocno', type: 'String'  },
     						{name : 'area', type: 'String'  },
     						{name : 'city_name', type: 'String'  },
     						{name : 'country_name', type: 'String'  },
     						{name : 'region_name', type: 'String'  }
     						
     						
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
            $("#jqxareasearchpros").jqxGrid(
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
					{ text: 'AREA', datafield: 'area', width: '25%' },
					{ text: 'State', datafield: 'city_name', width: '25%' },
					{ text: 'Country', datafield: 'country_name', width: '25%' },
					{ text: 'Region', datafield: 'region_name', width: '20%' }
					
					 
					
					]
            });
    
            //$("#jqxareasearchpros").jqxGrid('addrow', null, {});
      
				            
				           $('#jqxareasearchpros').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				            	  var temp="";
				            	  temp=temp+$('#jqxareasearchpros').jqxGrid('getcellvalue', rowindex1, "country_name");
				                temp=temp+","+$('#jqxareasearchpros').jqxGrid('getcellvalue', rowindex1, "region_name");
				                //temp=temp+","+$('#jqxareasearchpros').jqxGrid('getcellvalue', rowindex1, "region_name");
				                
				                if(value==0)
				            	   {
				                	
						            	document.getElementById("txtareadet").value=temp; 
						                document.getElementById("txtareaid").value=$('#jqxareasearchpros').jqxGrid('getcellvalue', rowindex1, "areadocno");
						               document.getElementById("txtarea").value=$('#jqxareasearchpros').jqxGrid('getcellvalue', rowindex1, "area");
				            	   }
				              
				              /*  
				               
				               if(value==1)
				            	   {
				            	  
				               			$('#cpDetailsGrid').jqxGrid('setcellvalue', rowIndex, "area",$('#jqxareasearchpros').jqxGrid('getcellvalue', rowindex1, "area"));
				               			$('#cpDetailsGrid').jqxGrid('setcellvalue', rowIndex, "areaid",$('#jqxareasearchpros').jqxGrid('getcellvalue', rowindex1, "areadocno"));
				            	   }
				               */
				                $('#areainfowindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="jqxareasearchpros"></div>
    
    </body>
</html>