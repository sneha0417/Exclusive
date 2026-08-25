    <%-- <jsp:include page="../../includes.jsp"></jsp:include>  --%> 
 <%@page import="com.dashboard.analysis.leadAnalysis.ClsLeadAnalysisDAO" %>
<%
ClsLeadAnalysisDAO sd=new ClsLeadAnalysisDAO();
%>


 <% String fromdate =request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").toString();%>
 <% String todate =request.getParameter("todate")==null?"0":request.getParameter("todate").toString();%>
 
 <% String branchval =request.getParameter("branchval")==null?"0":request.getParameter("branchval").toString();%>
 
 <% String filtval =request.getParameter("filtval")==null?"0":request.getParameter("filtval").toString();%>
 <% String grpval =request.getParameter("grpval")==null?"0":request.getParameter("grpval").toString();
%>
 <% String id =request.getParameter("id")==null?"0":request.getParameter("id").toString();
 String docarray=request.getParameter("docarray")==null?"":request.getParameter("docarray");
 String docs=request.getParameter("docs")==null?"":request.getParameter("docs");
 %>
 <script type="text/javascript">
 var data;
 
 var id='<%=id%>';

	if(id==2){
 data= '<%= sd.loadGridData(fromdate,todate,branchval,filtval,grpval,docarray,docs)%>';
<%--  dataexcel= '<%= sd.loadGridExcel(branchval,chkfollowup,followupdate,fromdate,todate,salesmanid) %>'; --%>  
	}
	else{
		
	}
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'String'  },
     						{name : 'mob_no', type: 'String'  },
     						{name : 'email', type: 'String' },
     						{name : 'desc', type: 'String' },
     						{name : 'brhid', type: 'String' },
     						{name : 'userid', type: 'String' },
     						{name : 'tr_no', type: 'String' },
     						{name : 'salesman', type: 'String' },
     						{name : 'name', type: 'String' },
     						{name : 'date', type: 'date' },    					
     						
     						{name : 'leadstatus', type: 'String' },
     						
     						{name : 'dtype', type: 'String' },
     						{name : 'cltype', type: 'String' },
     						
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
            $("#jqxleaddataGrid").jqxGrid(
            {
                width: '99%',
                height: 520,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                //pagermode: 'default',
                sortable: true,
                //Add row method
                columns: [
{ text: 'SL#', sortable: false, filterable: false, editable: false,
    groupable: false, draggable: false, resizable: false,
    datafield: 'sl', columntype: 'number', width: '4%',
    cellsrenderer: function (row, column, value) {
        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
    }  
  },	
					{ text: 'Doc No', datafield: 'doc_no', width: '6%' },
					
					{ text: 'Name', datafield: 'name', width: '19%', },
					{ text: 'Mob No', datafield: 'mob_no', width: '9%' },
					{ text: 'Email', datafield: 'email', width: '12%' },
					{ text: 'Date', datafield: 'date', width: '7%',cellsformat:'dd.MM.yyyy' },
					{ text: 'Description', datafield: 'desc', width: '15%' },
					{ text: 'Salesman',  datafield: 'salesman', width: '12%' },
					{ text: 'Lead Status',  datafield: 'leadstatus', width: '6%' },
					{ text: 'Type',  datafield: 'cltype', width: '10%' },
					{ text: 'Tr No',  datafield: 'tr_no', width: '10%' ,hidden:true},
					{ text: 'Brnch Id',  datafield: 'brhid', width: '10%' ,hidden:true}, 
					{ text: 'User Id',  datafield: 'userid', width: '10%' ,hidden:true},
					
					{ text: 'dtype',  datafield: 'dtype', hidden: true, width: '5%' },
					
	              ]
            });
      
               $("#overlay, #PleaseWait").hide();
              
                
        });
    </script>
    <div id="jqxleaddataGrid"></div>
