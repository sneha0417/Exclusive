
<%@page import="com.project.execution.jobContract.ClsJobContractDAO"%>  
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsJobContractDAO DAO= new ClsJobContractDAO(); %>
 <%
 int rowIndex=request.getParameter("rowBoundIndex")==null?0:Integer.parseInt(request.getParameter("rowBoundIndex").trim()); 
 %>

 <script type="text/javascript">
 
 var servicesite;

 var rowIndex='<%=rowIndex%>';
 
   <%-- servicesite='<%=DAO.serviceSite(session)%>'; --%>
 
        $(document).ready(function () { 
        	servicesite=getSte();
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

							{name : 'docno', type: 'String'  },
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
                selectionmode: 'singlerow',
            
            
     					
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Doc No', datafield: 'docno', width: '19%' },
					{ text: 'Service Site', datafield: 'site', width: '75%' }
					
					 
					
					]
            });
    		            
				           $('#jqxsitesearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				            	 		$('#serviceGrid').jqxGrid('setcellvalue', rowIndex, "site",$('#jqxsitesearch').jqxGrid('getcellvalue', rowindex1, "site"));
				               			$('#serviceGrid').jqxGrid('setcellvalue', rowIndex, "siteid",$('#jqxsitesearch').jqxGrid('getcellvalue', rowindex1, "docno"));
				               			//$("#serviceGrid").jqxGrid('addrow', null, {});
				              
				                $('#siteinfowindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 

        function addArea(){
        	
        	var formname='Service Settings';
        	var formcode='SERS';
        	var lblname='Service Area Settings';
        	var lbldrp='area';
        	var detName='Service Settings';
        	
        	 var url=document.URL;
		     var reurl=url.split("com");
		     var path1='com/controlcentre/settings/ServiceSettings/serviceSettings.jsp';
        	var path= path1+"?formname="+formname+"&formcode="+formcode+"&lblname="+lblname+"&lbldrp="+lbldrp+"&mode=A";
			  
			   top.addTab( detName,reurl[0]+""+path);
        	
        	<%-- window.open("<%=contextPath%>/com/controlcentre/settings/ServiceSettings/serviceSettings.jsp?formname="+formname+"&formcode="+formcode+"&lblname="+lblname+"&lbldrp="+lbldrp+"","Service Settings","menubar=0,resizable=1,width=1000,height=580 ,top=100, left=260"); --%>
      
        }
        
        
        
        function getSte(){
        	
        	 var rows1 = $("#siteGrid").jqxGrid('getrows');
        	 var jasond = '{"theTeam":[]}';
        	 for(var i=0 ; i < rows1.length ; i++){
					
        		 if(typeof(rows1[i].site) != "undefined" && typeof(rows1[i].site) != "NaN" && rows1[i].site != ""){
				  
        		 var obj = JSON.parse(jasond);
        		 obj['theTeam'].push({"site":rows1[i].site,"docno":i+1});
        		 jasond = JSON.stringify(obj);
				 
        		 }
						}	 
			 
        	return jasond;
        }
        
                       
    </script>
    <!-- <div style="text-align:right;padding-right:25px;padding-bottom:5px;"><input type="button" name="btnnewarea" id="btnnewarea" value="Add" onclick="addArea()";  class="myButton"></div> -->
    <div id="jqxsitesearch"></div>
    
    </body>
</html>