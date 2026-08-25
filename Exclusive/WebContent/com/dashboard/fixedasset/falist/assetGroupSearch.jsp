<%-- <%
String item = request.getParameter("item")==null?"NA":request.getParameter("item");

%> --%>
<%@page import="com.dashboard.fixedasset.falist.ClsFaListDAO" %>
<%ClsFaListDAO cfld=new ClsFaListDAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%--  <%
 String branch = request.getParameter("branch")==null?"0":request.getParameter("branch");
%> 
 --%>
 <script type="text/javascript">

  var assetdata='<%=cfld.getAssetGroup()%>'; 
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'doc_no', type: 'String'  },
     						{name : 'grp_name', type: 'String'  },
     						 {name : 'grp_code', type: 'String'  }
      					
     						
                          	],
                          	localdata: assetdata,
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
            $("#assetGroupGrid").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
            
            
     					
                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
					{ text: 'Group Code', datafield: 'grp_code', width: '30%' },
					{ text: 'Group Name', datafield: 'grp_name', width: '60%' }
					
					]
            });

				            
				           $('#assetGroupGrid').on('rowdoubleclick', function (event) 
				            		{ 
				        		var rowindex1=event.args.rowindex;
				            	document.getElementById("assetgrp").value=$('#assetGroupGrid').jqxGrid('getcellvalue', rowindex1, "grp_name"); 
				            	document.getElementById("hidassetgrp").value=$('#assetGroupGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
				              $('#assetwindow').jqxWindow('close');
				            		 }); 	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="assetGroupGrid"></div>