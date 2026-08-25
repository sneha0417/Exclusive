
<%@page import="com.dashboard.projectexecution.serviceInvoiceDetails.ClsServiceInvoiceDetails" %> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsServiceInvoiceDetails DAO= new ClsServiceInvoiceDetails(); %>


 <script type="text/javascript">
 
 var servicestat;
 
   servicestat='<%=DAO.serviceStatus(session)%>';
        $(document).ready(function () { 
 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

							{name : 'doc_no', type: 'String'  },
							{name : 'stat', type: 'String'  },
     						
     						
                          	],
                          	localdata: servicestat,
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
            $("#jqxstatusearch").jqxGrid(
            {
                width: '100%',
                height: 200,
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
					{ text: 'doc_no', datafield: 'doc_no', width: '5%',hidden:true },
					{ text: 'Service Status', datafield: 'stat', width: '90%' }
					
					 
					
					]
            });
    		            
$( "#btnStatus" ).click(function() {
            	
            	var rows = $("#jqxstatusearch").jqxGrid('selectedrowindexes');
            	
            		/* alert("id one"); */
            	if(rows!=""){
            		if(document.getElementById("searchdetails").value==""){
                		document.getElementById("searchdetails").value="Status";
                		document.getElementById("searchdetails").value+="\n---------------------------";
                		document.getElementById("hidstatus").value="Status";
                	}
                	else{
                		document.getElementById("searchdetails").value+="\n\nStatus";
                		document.getElementById("searchdetails").value+="\n---------------------------";
                		document.getElementById("hidstatus").value+="\nStatus";
                	}	
            	}
            	
        		document.getElementById("hidstatusid").value="";
            	
            	for(var i=0;i<rows.length;i++){
            		var dummy=$('#jqxstatusearch').jqxGrid('getcellvalue',rows[i],'stat');
            		var docno=$('#jqxstatusearch').jqxGrid('getcellvalue',rows[i],'doc_no');
            		document.getElementById("searchdetails").value+="\n"+dummy;
            		document.getElementById("hidstatus").value+="\n"+dummy;
            		if(i==0){
            			document.getElementById("hidstatusid").value=docno;
            		}
            		else{
            			document.getElementById("hidstatusid").value+=","+docno;
            		}
            	}
         
            	$('#statusinfowindow').jqxWindow('close');
        	});	 
        
                  }); 

        
                       
    </script>
    <div align="center" style="padding-bottom:4px;"><button type="button" id="btnStatus" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel" name="btncancel" class="myButton" >Cancel</button></div>
    <div id="jqxstatusearch"></div>
    
    </body>
</html>