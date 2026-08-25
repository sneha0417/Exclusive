<%@page import="com.dashboard.marketing.surveyschedulerlist.ClssurveyschedulerlistDAO" %>
<% ClssurveyschedulerlistDAO sd=new ClssurveyschedulerlistDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String salesmanid =request.getParameter("salesmanid")==null?"0":request.getParameter("salesmanid").toString();
   String clientid =request.getParameter("clientid")==null?"0":request.getParameter("clientid").toString();
   String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
   String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
   String rds =request.getParameter("rds")==null?"0":request.getParameter("rds").toString();
   String barchval =request.getParameter("barchval")==null?"0":request.getParameter("barchval").toString();%>

 <script type="text/javascript">
 var data,dataExcelExport;
 
 var bb='<%=rds%>';
	
 	if(bb!='0'){
 		data= '<%= sd.loadGridData(fromDate,toDate,salesmanid,clientid,barchval)%>';
 		dataExcelExport='<%=sd.loadGridExcel(fromDate,toDate,salesmanid,clientid,barchval)%>';
	}
	
        $(document).ready(function () { 	
            
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'String'  },
     						{name : 'date', type: 'date'  },
     						{name : 'name', type: 'String' },
     						{name : 'groups', type: 'String' },
     						{name : 'empid', type: 'String' },
     						{name : 'grpmem', type: 'String' },
     						{name : 'asgmeth', type: 'String' },
     						{name : 'plannedon', type: 'date' },
     						{name : 'pltime', type: 'String' },
     						{name : 'description', type: 'string'    },
                    		{name : 'mob', type: 'number'    },
     						{name : 'remarks', type: 'String'    },
     						{name : 'source', type: 'String'    },
     						{name : 'salm', type: 'String'    },
     						{name : 'specid', type: 'number'    },  
     						{name : 'stypeid', type: 'number'    },
     						
     						{name : 'brandid', type: 'number'    }, 
     						
     					     						
                 ],
                 localdata: data,
                
                
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
            $("#jqxEstPriceGrid").jqxGrid(
            {
                width: '99%',
                height: 540,
                source: dataAdapter,
                columnsresize: true,
                sortable: true,
                selectionmode: 'checkbox',
                filtermode:'excel',
                filterable: true,
                sortable: true,
                
                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '6%' },
					{ text: 'Date',  datafield: 'date', cellsformat: 'dd.MM.yyyy', width: '6%' },
					{ text: 'Client', datafield: 'name', width: '18%' },
					{ text: 'Assign group', datafield: 'groups', width: '15%' },
					{ text: 'Group member', datafield: 'grpmem', width: '14%' },
					{ text: 'Assign method', datafield: 'asgmeth', width: '10%' },
					{ text: 'Planned date', datafield: 'plannedon', cellsformat: 'dd.MM.yyyy', width: '8%'  },
					{ text: 'Planned time',  datafield: 'pltime', width: '8%' },
					{ text: 'Description', datafield: 'description', width: '10%'}, 
					{ text: 'Mobile no ', datafield: 'mob', width: '10%'},
					{ text: 'Remarks', datafield: 'remarks', width: '10%'},
					{ text: 'Source', datafield: 'source', width: '10%'},
					{ text: 'Salesman', datafield: 'salm', width: '10%'},
					{ text: 'empid', datafield: 'empid', width: '10%',hidden: true },
					{ text: 'specid', datafield: 'specid', width: '10%',hidden: true}, 
					{ text: 'brandid', datafield: 'brandid', width: '10%',hidden: true},
					{ text: 'stypeid', datafield: 'stypeid', width: '10%',hidden: true},
					
					
	              ]
            });
            

                 $("#overlay, #PleaseWait").hide();
        });
    </script>
    <div id="jqxEstPriceGrid"></div>
