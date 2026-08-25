<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.projectexecution.serviceCompletion.ClsServiceCompletionDAO"%>
<%
ClsServiceCompletionDAO DAO=new ClsServiceCompletionDAO(); 
String uptodate =request.getParameter("date")==null?"0":request.getParameter("date").toString();
String branchval =request.getParameter("barchval")==null?"0":request.getParameter("barchval").toString();
String clientid =request.getParameter("clientid")==null?"0":request.getParameter("clientid").toString(); 
int id =request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id").toString());
String type =request.getParameter("type")==null?"0":request.getParameter("type").toString();
String trno =request.getParameter("tr_no")==null?"0":request.getParameter("tr_no").toString();

System.out.println("==branchval===="+branchval);

String docno =request.getParameter("docno")==null?"0":request.getParameter("docno").toString();
%>

 <script type="text/javascript">
 var perdata3;
 var id='<%= id%>';
 if(id==1){
	 perdata3= '<%=DAO.payGridLoad(session,trno,branchval)%>';
 }
 else{
	 perdata3; 
 }
	
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'duedate', type: 'date'  },
							{name : 'amount', type: 'number'  },
							{name : 'runtotal', type: 'number'  },
							{name : 'dueser', type: 'String'  },
							{name : 'desc1', type: 'String'  },
							{name : 'terms', type: 'String'  },
							{name : 'termsid', type: 'String'  },
							{name : 'service', type: 'String'  },
							{name : 'invno', type: 'String'  },
							{name : 'invdate', type: 'date'  },
     					     						
                 ],
                 localdata: perdata3,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed...tobeinvamt
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxpinvDetGrid").jqxGrid(
            {
                width: '100%',
                height: 200,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                //sortable: true,
                selectionmode: 'singlerow',
                filtermode:'excel',
                //filterable: true,
                //pagermode: 'default',
                columns: [
                          
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '8%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Due Date', datafield: 'duedate', width: '20%' , editable: false,columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy'},
					{ text: 'Amount', datafield: 'amount', width: '20%',editable:false, cellsformat: 'd2', cellsalign: 'right', align: 'right' },
					{text: 'Terms',datafield:'terms', width: '25%',editable:false},
					{text: 'Service',datafield:'service',width:'10%',editable:false,hidden:true},
					{text: 'termsid',datafield:'termsid',width:'8%',editable:false,hidden:true},
					{text: 'InvNo',datafield:'invno',width:'12%',editable:false},
					{text: 'Inv Date',datafield:'invdate',width:'15%',editable:false,columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy'},
					
				 ]
            });
           

                 $("#overlay, #PleaseWait").hide();
                 
                
        });
    </script>
    <div id="jqxpinvDetGrid"></div>
