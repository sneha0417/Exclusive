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
  String docno =request.getParameter("docno")==null?"0":request.getParameter("docno").toString();
  String iserv =request.getParameter("iserv")==null?"0":request.getParameter("iserv").toString();
  //System.out.println("==branchval===="+branchval);
  
%>

 <script type="text/javascript">
 var perdata2;
 var iserv='<%=iserv%>'; 
 
      perdata2= '<%=DAO.serviceScheudleGridLoad(session,trno,branchval,type)%>'; 
 
	
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'pldate' , type: 'date' },
     						{name : 'pltime', type: 'String'  },
                          	{name : 'asgngrp', type: 'String'  },
                          	{name : 'assigngrpid', type: 'String'  },
     						{name : 'emp', type: 'String'  },
     						{name : 'assigntoid', type: 'String'  },
     						{name : 'asgnmode', type: 'String'  },
     						{name : 'desc1', type: 'String'  },
     						{name : 'site', type: 'String'  },
     						{name : 'amt', type: 'number'  },
     						{name : 'invno', type: 'String'  },
     						{name : 'days', type: 'String'  },
     						{name : 'service', type: 'String'  },
     						{name : 'serviceid', type: 'String'  },
     						{name : 'siteid', type: 'String'  },
     						{name : 'workper', type: 'String'  },
     						{name : 'priority', type: 'bool'   },
     						
     						{name : 'siteadd', type: 'String' },
     					     						
                 ],
                 localdata: perdata2,
                
                
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
            $("#jqxpsrvDetGrid").jqxGrid(
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
                          
					{ text: 'Planned Date', datafield: 'pldate', width: '15%',editable:true, columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy' },
					{ text: 'Site', datafield: 'site', width: '10%' },
				//	{ text: 'Site Details', datafield: 'siteadd', width: '12%' },
					{text: 'Amount',datafield:'amt',width:'10%',editable:false,hidden:true, cellsformat: 'd2', cellsalign: 'right', align: 'right'},
					{text: 'Inv.No',datafield:'invno',width:'10%',editable:false},
					{ text: 'Assign Group', datafield: 'asgngrp', width: '15%',editable:false,editable:false },
					{ text: 'Assign Group ID', datafield: 'assigngrpid', width: '11%',hidden:true,editable:false },
					{text: 'Assign To',datafield:'emp',width:'25%',editable:false},
					{ text: 'Assign To ID', datafield: 'assigntoid', width: '10%',hidden:true,editable:false },
					{ text: 'AssigEmpid', datafield:'assignempid', width: '10%',hidden:true,editable:false },
					{text: 'Assign Method',datafield:'asgnmode',editable:false},
					{text: 'Work (%)',datafield:'workper',width:'10%',editable:false},
									
				 ]
            });
            hidcolumn(iserv);           
			workper();
                 $("#overlay, #PleaseWait").hide();
                 
                
        });
    </script>
    <div id="jqxpsrvDetGrid"></div>
