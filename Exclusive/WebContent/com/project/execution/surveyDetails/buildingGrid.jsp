<%@page import="com.project.execution.surveyDetails.ClsSurveyDetailsDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsSurveyDetailsDAO DAO= new ClsSurveyDetailsDAO(); %>
 <%
 String gridload=request.getParameter("gridload")==null?"0":request.getParameter("gridload").trim().toString(); 
 String docno=request.getParameter("docno")==null?"0":request.getParameter("docno").trim().toString();
 
 %>
    <script type="text/javascript">
    var buildata;
    var gridload='<%=gridload%>';
    var docno='<%=docno%>';
    
        $(document).ready(function () { 	
            
        	if(gridload>0){
        		buildata='<%=DAO.buildAMC(session)%>';
        	}
        	if(docno>0){
        		buildata='<%=DAO.buildAMCGridLoad(session,docno)%>';
        	}
        	
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'srno' , type: 'number' },
     						{name : 'specid', type: 'String'  },
                          	{name : 'sepc', type: 'String'  },
     						{name : 'desc1', type: 'String'  },
     						{name : 'details', type: 'String'  },
                          	],
                 localdata: buildata,
                
                
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
            $("#buildingGrid").jqxGrid(
            {
                width: '100%',
                height: 200,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlecell',
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
					{ text: 'Spec', datafield: 'sepc', width: '21%' ,editable:false},
					{ text: 'Specid', datafield: 'specid', width: '15%',hidden:true },
					{ text: '', datafield: 'details', width: '25%' },
					{text: 'Description',datafield:'desc1',width:'50%'}
					]
            });
            if($('#mode').val()=='view'){
           	 $("#buildingGrid").jqxGrid({ disabled: true});
       		
           }
            $("#buildingGrid").jqxGrid('addrow', null, {});
      
        });
    </script>
    <div id="buildingGrid"></div>
