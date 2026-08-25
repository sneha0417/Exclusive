
<%@page import="com.project.execution.quotation.ClsQuotationDAO"%> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsQuotationDAO DAO= new ClsQuotationDAO(); %>
 <%int rowIndex=request.getParameter("rowIndex")==null?0:Integer.parseInt(request.getParameter("rowIndex").trim()); %>

 <script type="text/javascript">
 
 var assignfrm;

 var rowIndex='<%=rowIndex%>';
 
 assignfrm='<%=DAO.assignfrm(session)%>';
 
 
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'doc_no', type: 'String'  },
     						{name : 'grpcode', type: 'String'  },
     						
     						
     						
                          	],
                          	localdata: assignfrm,
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
            $("#jqxgrpsearch").jqxGrid(
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
					{ text: 'Doc No', datafield: 'doc_no', width: '21%' },
					{ text: 'Assign Group', datafield: 'grpcode', width: '75%' }
					
					 
					
					]
            });
    
            //$("#jqxgrpsearch").jqxGrid('addrow', null, {});
      
				            
				           $('#jqxgrpsearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				            	 
				            	  
				               			$('#servscGrid').jqxGrid('setcellvalue', rowIndex, "assigngrp",$('#jqxgrpsearch').jqxGrid('getcellvalue', rowindex1, "grpcode"));
				               			$('#servscGrid').jqxGrid('setcellvalue', rowIndex, "assigngrpid",$('#jqxgrpsearch').jqxGrid('getcellvalue', rowindex1, "doc_no"));
				               			$("#servscGrid").jqxGrid('addrow', null, {});
				              
				                $('#grpinfowindow').jqxWindow('close');
				               
				            
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
        
                       
    </script>
    <!-- <div style="text-align:right;padding-right:25px;padding-bottom:5px;"><input type="button" name="btnnewarea" id="btnnewarea" value="Add" onclick="addArea()";  class="myButton"></div> -->
    <div id="jqxgrpsearch"></div>
    
    </body>
</html>