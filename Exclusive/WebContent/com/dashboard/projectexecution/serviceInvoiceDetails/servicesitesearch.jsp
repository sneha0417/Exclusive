
<%@page import="com.dashboard.projectexecution.serviceInvoiceDetails.ClsServiceInvoiceDetails" %> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsServiceInvoiceDetails DAO= new ClsServiceInvoiceDetails(); %>


 <script type="text/javascript">
 
 var servicesite;
 
   servicesite='<%=DAO.serviceSite(session)%>';
        $(document).ready(function () { 
 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

							{name : 'site', type: 'String'  },
     						
     						
                          	],
                          	localdata: servicesite,
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
            $("#jqxsitesearch").jqxGrid(
            {
                width: '95%',
                height: 420,
                source: dataAdapter,
                columnsresize: true,
                filterable:true,
                showfilterrow:true,
                selectionmode: 'checkbox',
               
            
            
     					
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Service Site', datafield: 'site', width: '95%' }
					
					 
					
					]
            });
    		            
$( "#btnSite" ).click(function() {
            	
            	var rows = $("#jqxsitesearch").jqxGrid('selectedrowindexes');
            	
            		/* alert("id one"); */
            	if(rows!=""){
            		if(document.getElementById("searchdetails").value==""){
                		document.getElementById("searchdetails").value="Site";
                		document.getElementById("searchdetails").value+="\n---------------------------";
                		document.getElementById("hidsite").value="Site";
                	}
                	else{
                		document.getElementById("searchdetails").value+="\n\nSite";
                		document.getElementById("searchdetails").value+="\n---------------------------";
                		document.getElementById("hidsite").value+="\nSite";
                	}	
            	}
            	
        		document.getElementById("hidsiteid").value="";
            	
            	for(var i=0;i<rows.length;i++){
            		var dummy=$('#jqxsitesearch').jqxGrid('getcellvalue',rows[i],'site');
            		var docno=$('#jqxsitesearch').jqxGrid('getcellvalue',rows[i],'site');
            		document.getElementById("searchdetails").value+="\n"+dummy;
            		document.getElementById("hidsite").value+="\n"+dummy;
            		if(i==0){
            			document.getElementById("hidsiteid").value=docno;
            		}
            		else{
            			document.getElementById("hidsiteid").value+=","+docno;
            		}
            	}
         
            	$('#siteinfowindow').jqxWindow('close');
        	});	 
        
                  }); 

        
                       
    </script>
    <div align="center" style="padding-bottom:4px;"><button type="button" id="btnSite" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel" name="btncancel" class="myButton" >Cancel</button></div>
    <div id="jqxsitesearch"></div>
    
    </body>
</html>