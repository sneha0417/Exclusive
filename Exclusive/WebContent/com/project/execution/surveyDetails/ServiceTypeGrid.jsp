<%@page import="com.project.execution.surveyDetails.ClsSurveyDetailsDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsSurveyDetailsDAO DAO= new ClsSurveyDetailsDAO(); %>
 <%
 String gridload=request.getParameter("gridload")==null?"0":request.getParameter("gridload").trim().toString(); 
 String docno=request.getParameter("docno")==null?"0":request.getParameter("docno").trim().toString();
 String sid=request.getParameter("sid")==null?"0":request.getParameter("sid").trim().toString();
 %>
    <script type="text/javascript">
    var sertypedatas;
    var gridload='<%=gridload%>';
    var docno='<%=docno%>';
    
        $(document).ready(function () { 	
            
        	if(gridload>0){
        		sertypedatas='<%=DAO.ServiceType(session,sid)%>';
        	}
        	if(docno>0){
        		sertypedatas='<%=DAO.ServiceTypeGridReLaod(session,docno,sid)%>';
        		
        	}
        	
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'srno' , type: 'number' },
                          	{name : 'servtypeid', type: 'String'  },
                          	{name : 'servtype', type: 'String'  },
     						{name : 'specid', type: 'String'  },
                          	{name : 'sepc', type: 'String'  },
     						{name : 'desc1', type: 'String'  },
     						{name : 'details', type: 'String'  },
                          	],
                 localdata: sertypedatas,
                
                
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
            $("#sertypeGrid").jqxGrid(
            {
                width: '100%',
                height: 380,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                editable:true,
                sortable: true,
                //Add row method
	
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Service Type', datafield: 'servtype', width: '21%',editable:false },
					{ text: 'servtypeid', datafield: 'servtypeid', width: '15%',hidden:true },
					{ text: 'Spec', datafield: 'sepc', width: '21%',editable:false },
					{ text: 'Specid', datafield: 'specid', width: '15%',hidden:true },
					{ text: 'Value', datafield: 'details', width: '25%' },
					{text: 'Description',datafield:'desc1',width:'30%'}
					]
            });
            
            if($('#mode').val()=='view'){
           
        		 $("#sertypeGrid").jqxGrid({ disabled: true});
            }
            
            $("#sertypeGrid").jqxGrid('addrow', null, {});
      
        });
    </script>
    <div id="sertypeGrid"></div>
