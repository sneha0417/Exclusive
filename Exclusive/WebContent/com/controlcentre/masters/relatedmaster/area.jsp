 
 

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@page import="com.controlcentre.masters.relatedmaster.hoteltype.ClsHotelDAO"%>
<%
ClsHotelDAO cd=new ClsHotelDAO();
%>
 <script type="text/javascript">


  var radata;

  radata='<%=cd.areaSearch(session)%>';
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
                showfilterrow:true,
                filterable:true,
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
					{ text: 'AREA', datafield: 'areadocno', width: '25%' ,hidden:true},
					{ text: 'AREA', datafield: 'area', width: '25%' },
					{ text: 'State', datafield: 'city_name', width: '25%' },
					{ text: 'Country', datafield: 'country_name', width: '25%' },
					{ text: 'Region', datafield: 'region_name', width: '20%' }
					
					 
					
					]
            });
    
      
				            
			    $('#jqxareasearchpros').on('rowdoubleclick', function (event) 
				{ 
			    var rowindex1=event.args.rowindex;
				          
				document.getElementById("txtarea").value= $('#jqxareasearchpros').jqxGrid('getcellvalue', rowindex1, "area"); 
     		    document.getElementById("txtareaid").value= $('#jqxareasearchpros').jqxGrid('getcellvalue', rowindex1, "areadocno"); 
     		                        
				                $('#areainfowindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="jqxareasearchpros"></div>
    
    </body>
</html>