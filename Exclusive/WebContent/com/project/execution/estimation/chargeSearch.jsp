
<%@page import="com.project.execution.estimation.ClsEstimationDAO"%> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsEstimationDAO DAO= new ClsEstimationDAO(); %>
<%int rowIndex=request.getParameter("rowBoundIndex")==null?0:Integer.parseInt(request.getParameter("rowBoundIndex").trim()); %>
 <script type="text/javascript">
 
 var sectiondata;

 var rowIndex='<%=rowIndex%>';
 
 sectiondata='<%=DAO.lchrgeSearch(session)%>';
 
 
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'docno', type: 'String'  },
     						{name : 'name', type: 'String'  },
     						{name : 'code', type: 'String'  },
     						{name : 'rate', type: 'String'  },
     						
     						
     						
                          	],
                          	localdata: sectiondata,
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
            $("#jqxlchargesearch").jqxGrid(
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
					{ text: 'Code', datafield: 'code', width: '20%' },
					{ text: 'Name', datafield: 'name', width: '50%' },
					{ text: 'Rate', datafield: 'rate', width: '25%' },
					{ text: 'doc_no', datafield: 'docno', width: '75%',hidden:true }
					
					 
					
					]
            });
    
            //$("#jqxlchargesearch").jqxGrid('addrow', null, {});
      
				            
				           $('#jqxlchargesearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				            	 
				            	  
				              	$('#labourDetailsGridID').jqxGrid('setcellvalue', rowIndex, "docno",$('#jqxlchargesearch').jqxGrid('getcellvalue', rowindex1, "docno"));
		               			$('#labourDetailsGridID').jqxGrid('setcellvalue', rowIndex, "codeno",$('#jqxlchargesearch').jqxGrid('getcellvalue', rowindex1, "code"));
		               			$('#labourDetailsGridID').jqxGrid('setcellvalue', rowIndex, "desc1",$('#jqxlchargesearch').jqxGrid('getcellvalue', rowindex1, "name"));
		               			$('#labourDetailsGridID').jqxGrid('setcellvalue', rowIndex, "rate",$('#jqxlchargesearch').jqxGrid('getcellvalue', rowindex1, "rate"));
				              
		               			$("#labourDetailsGridID").jqxGrid('addrow', null, {});
		               			
				                $('#lchargeinfowindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 

        function addlcharge(){
        	
        	var formname='Service Settings';
        	var formcode='SERS';
        	var lblname='Service lcharge Settings';
        	var lbldrp='lcharge';
        	var detName='Service Settings';
        	
        	 var url=document.URL;
		     var reurl=url.split("com");
		     var path1='com/controlcentre/settings/ServiceSettings/serviceSettings.jsp';
        	var path= path1+"?formname="+formname+"&formcode="+formcode+"&lblname="+lblname+"&lbldrp="+lbldrp+"&mode=A";
			  
			   top.addTab( detName,reurl[0]+""+path);
        	
        	<%-- window.open("<%=contextPath%>/com/controlcentre/settings/ServiceSettings/serviceSettings.jsp?formname="+formname+"&formcode="+formcode+"&lblname="+lblname+"&lbldrp="+lbldrp+"","Service Settings","menubar=0,resizable=1,width=1000,height=580 ,top=100, left=260"); --%>
      
        }
        
                       
    </script>
   <!--  <div style="text-align:right;padding-right:25px;padding-bottom:5px;"><input type="button" name="btnnewlcharge" id="btnnewlcharge" value="Add" onclick="addlcharge()";  class="myButton"></div> -->
    <div id="jqxlchargesearch"></div>
    
    </body>
</html>