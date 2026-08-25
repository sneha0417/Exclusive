<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.analysis.activityanalysis.ClsActivityAnalysisDAO"%>
<%
ClsActivityAnalysisDAO DAO= new ClsActivityAnalysisDAO(); 
int id=request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
%> 
<script type="text/javascript">
var data;
var id='<%= id%>';
if(id==1){
 data='<%=DAO.searchUser()%>';
}else{
	data;
}
 $(document).ready(function () { 
            var source = 
            {
                datatype: "json",
                datafields: [
                         
     						{name : 'userid', type: 'String'  },
     						{name : 'user_name', type: 'String'  },
     					],
                          	localdata: data,
                
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
            $("#Jqxusernamesearch").jqxGrid(
            {
                width: '100%',
                height: 285,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
     					
                columns: [
					{ text: 'User ID', datafield: 'userid', width: '20%',hidden:true },
					{ text: 'User', datafield: 'user_name', width: '100%' },
				]
            });
    
              $('#Jqxusernamesearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				            	document.getElementById("txtuser").value= $('#Jqxusernamesearch').jqxGrid('getcellvalue', rowindex1, "user_name");
				                document.getElementById("txtuserid").value=$('#Jqxusernamesearch').jqxGrid('getcellvalue', rowindex1, "userid");
				                $('#usersearch').jqxWindow('close');
			 }); 	 
				          
        
    }); 
				       
                       
    </script>
    <div id="Jqxusernamesearch"></div>
    