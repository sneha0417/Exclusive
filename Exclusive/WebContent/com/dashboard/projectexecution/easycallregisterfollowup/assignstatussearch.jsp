<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<%@page
	import="com.dashboard.projectexecution.easycallregisterfollowup.ClsCallRegisterFollowupDAO"%>
<%
ClsCallRegisterFollowupDAO sd=new ClsCallRegisterFollowupDAO();
String typeid =request.getParameter("typeid")==null?"0":request.getParameter("typeid").toString().trim();
%> 

 <script type="text/javascript">
 
 var assignmode;

 
 assignmode='<%=sd.getassignstatus(typeid)%>';
 
        $(document).ready(function () { 
         
            var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                             
     						{name : 'assignstatus', type: 'String'},
     						{name : 'doc_no', type: 'String'},   						
                          	],
                          	localdata: assignmode,
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
            $("#jqxassignsearch").jqxGrid(
            {
                width: '100%',
                height: 390,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
            
            
     					
                columns: [
				
					{ text: 'DocNo', datafield: 'doc_no', width: '40%',hidden:true },
					{ text: 'Assign status', datafield: 'assignstatus', width: '100%' }
					]
            });
    
            $('#jqxassignsearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				              	document.getElementById("txtstatus").value=$('#jqxassignsearch').jqxGrid('getcellvalue', rowindex1, "assignstatus");
				              	document.getElementById("txtstatusid").value=$('#jqxassignsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
				             
				                $('#assigninfowindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 

    
        
                       
    </script>
    <!-- <div style="text-align:right;padding-right:25px;padding-bottom:5px;"><input type="button" name="btnnewarea" id="btnnewarea" value="Add" onclick="addArea()";  class="myButton"></div> -->
    <div id="jqxassignsearch"></div>
    
   