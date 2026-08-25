<%@page import="com.project.execution.surveyDetails.ClsSurveyDetailsDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsSurveyDetailsDAO DAO= new ClsSurveyDetailsDAO(); %>
 <%
 String docno=request.getParameter("docno")==null?"0":request.getParameter("docno").trim().toString();
String gridload=request.getParameter("gridload")==null?"0":request.getParameter("gridload").trim().toString(); 

 String trno=request.getParameter("trno")==null?"0":request.getParameter("trno").trim().toString();
 
 %>
    <script type="text/javascript">
    var sitedata;
    var docno='<%=docno%>';
     var gridload='<%=gridload%>';
    var trno='<%=trno%>';
    $(document).ready(function () { 
    	if(gridload=="1" && trno>0){
    		
    		sitedata = '<%=DAO.siteRefGridLoad(session,trno) %>';
        
        }
    	if(docno>0){
    		sitedata='<%=DAO.siteGridLoad(session,docno)%>';
    	}	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'srno' , type: 'number' },
     						{name : 'site', type: 'String'  },
                          	{name : 'area', type: 'String'  },
                          	{name : 'areaid', type: 'String'  },
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
                width: '100%',
                height: 140,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlecell',
                sortable: true,
                editable:true,
                //Add row method
	
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '10%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Site', datafield: 'site', width: '30%' },
					{text: 'Area',datafield:'area',width:'60%',editable:false},
					{text: 'Areaid',datafield:'areaid',width:'25%',editable:false,hidden:true}
					]
            });
            
            $('#siteGrid').on('celldoubleclick', function(event) 
            		{
            	var rowBoundIndex = event.args.rowindex;
            	var datafield = event.args.datafield;
            	
 		      
 		      if((datafield=="area"))
	    	   {
 		    	 getareas(rowBoundIndex);
	    	   }
 		     
            			
            		});
            
            if($('#mode').val()=='view'){
                
          		 $("#siteGrid").jqxGrid({ disabled: true});
              }
                 
            $("#siteGrid").jqxGrid('addrow', null, {});
        });
    </script>
    <div id="siteGrid"></div>
