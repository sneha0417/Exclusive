<%@page import="com.dashboard.cargo.joblisting.*" %>
<% ClsJobListing DAO=new ClsJobListing(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String clientname = request.getParameter("clientname")==null?"":request.getParameter("clientname");
 String mob = request.getParameter("mob")==null?"":request.getParameter("mob");
 String check = request.getParameter("check")==null?"0":request.getParameter("check");%>
<script type="text/javascript">
   var check='<%=check%>';  
   if(check == 1){
	   var data1= '<%=DAO.clientData(clientname,mob, check)%>';
   }
   else{
	   var data1=[];
   }
   	$(document).ready(function () { 
    	   // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'cldocno', type: 'int'},
     						{name : 'clientname', type: 'string'}
                        ],
                		 localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#clientSearchGridID").jqxGrid(
            {
                width: '100%',
                height: 315,
                source: dataAdapter,
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Doc No',  datafield: 'cldocno', width: '20%' },
							{ text: 'Client', datafield: 'clientname', width: '80%' }
						]
            });
            
             $('#clientSearchGridID').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("hidcldocno").value = $('#clientSearchGridID').jqxGrid('getcellvalue', rowindex1, "cldocno");
                document.getElementById("clientname").value = $('#clientSearchGridID').jqxGrid('getcellvalue', rowindex1, "clientname");
				
            	$('#clientSearchWindow').jqxWindow('close'); 
            });   
        });
    </script>
 <div id="clientSearchGridID"></div>