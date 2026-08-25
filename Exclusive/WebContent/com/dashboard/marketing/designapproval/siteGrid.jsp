<%@page import="com.dashboard.marketing.designapproval.ClsDesignApprovalDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsDesignApprovalDAO DAO= new ClsDesignApprovalDAO(); %>
 <%
 String sitedocno=request.getParameter("sitedocno")==null?"0":request.getParameter("sitedocno").trim().toString();
 
 %>
    <script type="text/javascript">
    var sitedata;
    var sitedocno='<%=sitedocno%>';
    
    $(document).ready(function () { 
    	
    	if(sitedocno>0){
    		sitedata='<%=DAO.siteGridLoad(session,sitedocno)%>';
    	}	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'date', type:'date'  },
                          	{name : 'description',type: 'String'},
                          	],
                 localdata: sitedata,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#siteGrid").jqxGrid(
            {
                width: '99%',
                height: 150,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                sortable: true,
                editable:true,
                //Add row method
	
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '5%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Date', datafield: 'date', width: '30%',cellsformat:'dd.MM.yyyy' },
					{text: 'Description',datafield:'description',width:'65%',editable:false},
					]
            });
            
           
        });
    </script>
    <div id="siteGrid"></div>
