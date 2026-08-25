<%@page import="com.operations.crm.callregister.ClsCallRegisterDAO"%>
<% ClsCallRegisterDAO DAO= new ClsCallRegisterDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 
 String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno");
 System.out.println("cldocno===="+cldocno);
// String check = request.getParameter("check")==null?"0":request.getParameter("check"); %>
<script type="text/javascript">
        
        var data6= '<%=DAO.calledbyDetailsSearch(cldocno)%>';  
      
        $(document).ready(function () { 
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'cperson', type: 'string'   },
     						{name : 'mob', type: 'string'   },
     						{name : 'email', type: 'string'   },
                        ],
                		 localdata: data6,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#calledbyDetailsSearch").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Contact Person', datafield: 'cperson', width: '60%' },
							{ text: 'Mobile No.',  datafield: 'mob',  width: '40%' },
							{ text: 'email',  datafield: 'email', hidden: true, width: '15%' },
						]
            });
            
             $('#calledbyDetailsSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("txtcontactperson").value = $('#calledbyDetailsSearch').jqxGrid('getcellvalue', rowindex1, "cperson");
                document.getElementById("txtmobile").value = $('#calledbyDetailsSearch').jqxGrid('getcellvalue', rowindex1, "mob");
            	$('#calledbyWindow').jqxWindow('close'); 
            });  
        });
 
</script>
<div id="calledbyDetailsSearch"></div>
 