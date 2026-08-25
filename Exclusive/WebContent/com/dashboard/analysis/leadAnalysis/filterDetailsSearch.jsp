
<%@page import="com.dashboard.analysis.leadAnalysis.ClsLeadAnalysisDAO" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsLeadAnalysisDAO DAO= new ClsLeadAnalysisDAO(); %>
 <%
 String branchval =request.getParameter("branchval")==null?"0":request.getParameter("branchval").toString();
 String fromdate =request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").toString();
 String todate =request.getParameter("todate")==null?"0":request.getParameter("todate").toString();
 
     String val=request.getParameter("val")==null?"0":request.getParameter("val").toString();
 String grpval=request.getParameter("grpval")==null?"0":request.getParameter("grpval").toString();
     %>

 <script type="text/javascript">
 
 var salmData;
var value='<%=val%>';
var groupval='<%=grpval%>';
   salmData='<%=DAO.salmData(session,val)%>' ;
 
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

							{name : 'doc', type: 'String'  },
							{name : 'stat', type: 'String'  },
     						
     						
                          	],
                          	localdata: salmData,
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
            $("#jqxfiltersearch").jqxGrid(
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
					{ text: 'Doc No', datafield: 'doc', width: '19%' },
					{ text: 'Ref. Name', datafield: 'stat', width: '75%' }
					
					 
					
					]
            });
    		            
$( "#btnserType" ).click(function() {
	 $("#jqxleaddataGrid").jqxGrid('clear'); 
	$("#overlaysub, #PleaseWaitsub").show();
	var docarray=new Array();
	var docstring="";
	var rows = $("#jqxfiltersearch").jqxGrid('getrows'); 
            	
            	 var selectedrows=$("#jqxfiltersearch").jqxGrid('selectedrowindexes');
            	    
            		if(selectedrows.length>0){
            						var i=0;
	                
				    for (i = 0; i < rows.length; i++) {
						for(var j=0;j<selectedrows.length;j++){
							
							if(selectedrows[j]==i){
								var rowno=rows[i].doc;
								
								docarray.push(rowno);
							}
						
							}
						
						}
				  
				   
					
						if(i==rows.length){
							
							docstring=docarray;
							 $("#Countgrid").load("Countgrid.jsp?branchval="+'<%=branchval%>'+"&fromdate="+'<%=fromdate%>'+"&todate="+'<%=todate%>'+"&filtval="+'<%=val%>'+"&grpval="+'<%=grpval%>'+"&docarray="+docstring+"&id=1");
						}
			
            			
            		}
            		else{
            			//alert("no data");
            		} 
         
            	$('#filterSearchwindow').jqxWindow('close');
        	});	 
				           
        
                  }); 

                    
    </script>
     <div align="center" style="padding-bottom:4px;"><button type="button" id="btnserType" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel" name="btncancel" class="myButton" >Cancel</button></div>
    <div id="jqxfiltersearch"></div>
    
    </body>
</html>