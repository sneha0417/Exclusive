<%@page import="com.controlcentre.settings.serviceteam.ClsServiceTeamDAO"%>
<%ClsServiceTeamDAO DAO= new ClsServiceTeamDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String teamusername = request.getParameter("teamusername")==null?"0":request.getParameter("teamusername");
 String rownindex = request.getParameter("rownindex")==null?"0":request.getParameter("rownindex");
 String id = request.getParameter("id")==null?"0":request.getParameter("id");
 %>
<script type="text/javascript">
        
       var data2= '<%=DAO.userDetailsSearch(teamusername)%>';
       
       var rownindex="<%=rownindex%>";
       var searchtype="<%=id%>";
       
        $(document).ready(function () { 
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'user_name', type: 'string'   },
     						{name : 'doc_no', type: 'int'   }
                        ],
                		 localdata: data2,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#userDetailsSearch").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'User Name', datafield: 'user_name', width: '100%' },
							{ text: 'Doc No',  datafield: 'doc_no', hidden: true, width: '5%' },
						]
            });
            
             $('#userDetailsSearch').on('rowdoubleclick', function (event) {

                var rowindex1 = event.args.rowindex;
                
                if(parseInt(searchtype)==1){
                	$('#serviceteamGrid').jqxGrid('setcellvalue', rownindex, "teamuserlinkid", $('#userDetailsSearch').jqxGrid('getcellvalue', rowindex1, "doc_no"));
                    $('#serviceteamGrid').jqxGrid('setcellvalue', rownindex, "teamuserlinkname", $('#userDetailsSearch').jqxGrid('getcellvalue', rowindex1, "user_name"));
                } else {
                	document.getElementById("txtteamuserlinkid").value=$('#userDetailsSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                	document.getElementById("txtteamuserlinkname").value=$('#userDetailsSearch').jqxGrid('getcellvalue', rowindex1, "user_name");
                }
                
                if(document.getElementById("ismemp").checked==true){
	                var rows = $('#serviceteamGrid').jqxGrid('getrows');
	            	var rowlength= rows.length;
	            	var rowindex1 = rowlength - 1;
	          	    var empId=$("#serviceteamGrid").jqxGrid('getcellvalue', rowindex1, "empid");
	          	    if(typeof(empId) != "undefined"){
	                $("#serviceteamGrid").jqxGrid('addrow', null, {});
	          	    }
            	}
                
            	$('#userDetailsWindow').jqxWindow('close'); 
           
            	
            });  
        });
    </script>
    <div id="userDetailsSearch"></div>
 