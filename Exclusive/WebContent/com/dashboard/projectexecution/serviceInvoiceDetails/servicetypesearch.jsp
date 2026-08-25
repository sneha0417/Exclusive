
<%@page import="com.dashboard.projectexecution.serviceInvoiceDetails.ClsServiceInvoiceDetails" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsServiceInvoiceDetails DAO= new ClsServiceInvoiceDetails(); %>


 <script type="text/javascript">
 
 var serviceType;
 
   serviceType='<%=DAO.serviceType(session)%>';
 
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

							{name : 'docno', type: 'String'  },
							{name : 'stype', type: 'String'  },
     						
     						
                          	],
                          	localdata: serviceType,
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
            $("#jqxstypesearch").jqxGrid(
            {
                width: '100%',
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
					{ text: 'Doc No', datafield: 'docno', width: '19%' },
					{ text: 'Service Type', datafield: 'stype', width: '75%' }
					
					 
					
					]
            });
    		            
$( "#btnserType" ).click(function() {
            	
            	var rows = $("#jqxstypesearch").jqxGrid('selectedrowindexes');
            	
            		/* alert("id one"); */
            	if(rows!=""){
            		if(document.getElementById("searchdetails").value==""){
                		document.getElementById("searchdetails").value="Service Type";
                		document.getElementById("searchdetails").value+="\n---------------------------";
                		document.getElementById("hidsertype").value="Service Type";
                	}
                	else{
                		document.getElementById("searchdetails").value+="\n\nService Type";
                		document.getElementById("searchdetails").value+="\n---------------------------";
                		document.getElementById("hidsertype").value+="\nService Type";
                	}	
            	}
            	
        		document.getElementById("hidsertypeid").value="";
            	
            	for(var i=0;i<rows.length;i++){
            		var dummy=$('#jqxstypesearch').jqxGrid('getcellvalue',rows[i],'stype');
            		var docno=$('#jqxstypesearch').jqxGrid('getcellvalue',rows[i],'docno');
            		document.getElementById("searchdetails").value+="\n"+dummy;
            		document.getElementById("hidsertype").value+="\n"+dummy;
            		if(i==0){
            			document.getElementById("hidsertypeid").value=docno;
            		}
            		else{
            			document.getElementById("hidsertypeid").value+=","+docno;
            		}
            	}
         
            	$('#sertypefowindow').jqxWindow('close');
        	});	 
				           
        
                  }); 

                    
    </script>
     <div align="center" style="padding-bottom:4px;"><button type="button" id="btnserType" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel" name="btncancel" class="myButton" >Cancel</button></div>
    <div id="jqxstypesearch"></div>
    
    </body>
</html>