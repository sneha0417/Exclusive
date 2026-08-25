 
 

<%@page import="com.project.execution.templates.ClsTemplateDAO"%> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsTemplateDAO DAO= new ClsTemplateDAO(); %>

 <script type="text/javascript">
 
 var sectiondata;


 
 sectiondata='<%=DAO.sectionSearch(session)%>';
 
 
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'sdocno', type: 'String'  },
     						{name : 'section', type: 'String'  },
     						
     						
     						
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
            $("#jqxsectionsearch").jqxGrid(
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
					{ text: 'Doc No', datafield: 'sdocno', width: '21%' },
					{ text: 'SECTION', datafield: 'section', width: '75%' }
					
					 
					
					]
            });
    
            //$("#jqxsectionsearch").jqxGrid('addrow', null, {});
      
				            
				           $('#jqxsectionsearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				            	 
				            	  
				              	$('#txtsectionname').val($('#jqxsectionsearch').jqxGrid('getcellvalue', rowindex1, "section"));
				              	$('#txtsectionid').val($('#jqxsectionsearch').jqxGrid('getcellvalue', rowindex1, "sdocno"));
				              
				                $('#sectioninfowindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 

        function addsection(){
        	
        	var formname='Service Settings';
        	var formcode='SERS';
        	var lblname='Service section Settings';
        	var lbldrp='section';
        	var detName='Service Settings';
        	
        	 var url=document.URL;
		     var reurl=url.split("com");
		     var path1='com/controlcentre/settings/ServiceSettings/serviceSettings.jsp';
        	var path= path1+"?formname="+formname+"&formcode="+formcode+"&lblname="+lblname+"&lbldrp="+lbldrp+"&mode=A";
			  
			   top.addTab( detName,reurl[0]+""+path);
        	
        	<%-- window.open("<%=contextPath%>/com/controlcentre/settings/ServiceSettings/serviceSettings.jsp?formname="+formname+"&formcode="+formcode+"&lblname="+lblname+"&lbldrp="+lbldrp+"","Service Settings","menubar=0,resizable=1,width=1000,height=580 ,top=100, left=260"); --%>
      
        }
        
                       
    </script>
   <!--  <div style="text-align:right;padding-right:25px;padding-bottom:5px;"><input type="button" name="btnnewsection" id="btnnewsection" value="Add" onclick="addsection()";  class="myButton"></div> -->
    <div id="jqxsectionsearch"></div>
    
    </body>
</html>