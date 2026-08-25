<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.project.execution.serviceReport.ClsServiceReportDAO"%>
<% ClsServiceReportDAO DAO = new ClsServiceReportDAO(); %> 
<% String contextPath=request.getContextPath();%>
<%  
   String trno = request.getParameter("trno")==null?"0":request.getParameter("trno");
  
 %>  

 <script type="text/javascript">
 
 var workstat;

 
 workstat='<%=DAO.workstat(trno)%>';
 
 
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

                          
     						{name : 'user_name', type: 'String'  },
     						{name : 'date', type: 'date'  },
     						{name : 'wrkper', type: 'String'  },
     						
     						
                          	],
                          	localdata: workstat,
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
            $("#jqxwrkstat").jqxGrid(
            {
                width: '100%',
                height: 310,
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
					{ text: 'User Name', datafield: 'user_name', width: '55%' },
					{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '18%' },
					{ text: 'Completion %', datafield: 'wrkper', width: '20%',align:'center',cellsalign:'center' },
					 
					
					]
            });
    
          
                  }); 

    
    </script>
    <!-- <div style="text-align:right;padding-right:25px;padding-bottom:5px;"><input type="button" name="btnnewarea" id="btnnewarea" value="Add" onclick="addArea()";  class="myButton"></div> -->
    <div id="jqxwrkstat"></div>
    
    </body>
</html>