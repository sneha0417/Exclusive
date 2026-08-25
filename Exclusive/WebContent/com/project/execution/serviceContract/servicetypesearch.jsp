
<%@page import="com.project.execution.serviceContract.ClsServiceContractDAO"%> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsServiceContractDAO DAO= new ClsServiceContractDAO(); %>
 <%
 int rowIndex=request.getParameter("rowBoundIndex")==null?0:Integer.parseInt(request.getParameter("rowBoundIndex").trim()); 
 int sertype=request.getParameter("sert")==null?0:Integer.parseInt(request.getParameter("sert").trim()); 
 %>

 <script type="text/javascript">
 
 var serviceType;

 var rowIndex='<%=rowIndex%>';
 var sertype='<%=sertype%>';
 
      if(sertype==1){
    	  serviceType='<%=DAO.serviceType(session)%>';
	  
		}
      if(sertype==2 || sertype==3){
    	  serviceType=getSer();
      }
   
	
   
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
                selectionmode: 'singlerow',
            
            
     					
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Doc No', datafield: 'docno', width: '21%' },
					{ text: 'Service Type', datafield: 'stype', width: '75%' }
					
					 
					
					]
            });
    		            
				           $('#jqxstypesearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				              	if(sertype==1){
				            	 		$('#serviceGrid').jqxGrid('setcellvalue', rowIndex, "stype",$('#jqxstypesearch').jqxGrid('getcellvalue', rowindex1, "stype"));
				               			$('#serviceGrid').jqxGrid('setcellvalue', rowIndex, "stypeid",$('#jqxstypesearch').jqxGrid('getcellvalue', rowindex1, "docno"));
				               			$("#serviceGrid").jqxGrid('addrow', null, {});
				              	}
				              	else if(sertype==2){
				              		document.getElementById("srvser").value=$('#jqxstypesearch').jqxGrid('getcellvalue', rowindex1, "stype");
				              		document.getElementById("srvid").value=$('#jqxstypesearch').jqxGrid('getcellvalue', rowindex1, "docno");
				              	}
				              	else if(sertype==3){
				              		$('#servserGrid').jqxGrid('setcellvalue', rowIndex, "service",$('#jqxstypesearch').jqxGrid('getcellvalue', rowindex1, "stype"));
			               			$('#servserGrid').jqxGrid('setcellvalue', rowIndex, "serviceid",$('#jqxstypesearch').jqxGrid('getcellvalue', rowindex1, "docno"));
			               			$("#servserGrid").jqxGrid('addrow', null, {});
				              	}
				               			
				              
				                $('#sertypefowindow').jqxWindow('close');
				               
				            
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
        
      
        }
        
        function getSer(){
        	
       	 var rows1 = $("#serviceGrid").jqxGrid('getrows');
       	 var jasond = '{"theServ":[]}';
       	 for(var i=0 ; i < rows1.length ; i++){
					
       		 if(typeof(rows1[i].stype) != "undefined" && typeof(rows1[i].stype) != "NaN" && rows1[i].stype != ""){
				  
       		 var obj = JSON.parse(jasond);
       		 obj['theServ'].push({"stype":rows1[i].stype,"srno":i+1,"docno":rows1[i].stypeid});
       		 jasond = JSON.stringify(obj);
				 
       		 }
			}	 
			 
       	return jasond;
       }
        
                       
    </script>
    <!-- <div style="text-align:right;padding-right:25px;padding-bottom:5px;"><input type="button" name="btnnewarea" id="btnnewarea" value="Add" onclick="addArea()";  class="myButton"></div> -->
    <div id="jqxstypesearch"></div>
    
    </body>
</html>