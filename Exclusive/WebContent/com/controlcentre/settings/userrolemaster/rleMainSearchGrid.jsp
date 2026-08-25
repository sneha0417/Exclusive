<%@page import="com.controlcentre.settings.userrolemaster.ClsUserRoleDAO" %>
<%ClsUserRoleDAO urd=new ClsUserRoleDAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String rolename = request.getParameter("rolename")==null?"0":request.getParameter("rolename");
 String docNo = request.getParameter("docNo")==null?"0":request.getParameter("docNo");
 String date = request.getParameter("date")==null?"0":request.getParameter("date");
%> 

 <script type="text/javascript">
 
 			var data2='<%=urd.rleMainSearch(rolename, docNo, date)%>';
			 $(document).ready(function () { 

        	var source = 
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int' },
     						{name : 'date', type: 'date'  },
     						{name : 'user_role', type: 'String' },
							{name : 'mail', type: 'String' }
                          	],
                          	localdata: data2,
                
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
            $("#jqxUserRoleSearch").jqxGrid(
            {
                width: '99%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
     			editable: false,
     			
                columns: [
					 { text: 'Doc No', datafield: 'doc_no', width: '20%' },
					 { text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '20%' },
					 { text: 'Role Name', datafield: 'user_role', width: '60%' },
					 { text: 'Email', datafield: 'mail', hidden:true, width: '20%' },
					]
            });
            
            //Add empty row
        	$("#jqxUserRoleSearch").jqxGrid('addrow', null, {});   
           
			  $('#jqxUserRoleSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
				funReset();
                document.getElementById("txtrolename").value= $('#jqxUserRoleSearch').jqxGrid('getcellvalue', rowindex1, "user_role");
				document.getElementById("txtemail").value= $('#jqxUserRoleSearch').jqxGrid('getcellvalue', rowindex1, "mail");
                document.getElementById("docno").value= $('#jqxUserRoleSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                
                var indexVal = document.getElementById("docno").value;
  			    if(indexVal>0){
  	              $("#userRoleDiv").load("userRoleGrid.jsp?roleid="+indexVal);
  			    }
  			    
               $('#window').jqxWindow('close');
            });   
				           
}); 
				       
                       
    </script>
    <div id="jqxUserRoleSearch"></div>
    