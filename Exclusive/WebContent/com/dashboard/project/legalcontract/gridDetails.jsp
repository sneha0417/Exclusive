    <%-- <jsp:include page="../../includes.jsp"></jsp:include>  --%> 
    
  <%@page import="com.dashboard.project.legalcontract.legalContractDAO" %>
<%
legalContractDAO sd=new legalContractDAO();
%>
    
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>


<% String fromdate =request.getParameter("froms")==null?"0":request.getParameter("froms").toString();%>
 <% String todate =request.getParameter("tos")==null?"0":request.getParameter("tos").toString();%>
 <% String rds =request.getParameter("rds")==null?"0":request.getParameter("rds").toString();%>
 <% String branchval =request.getParameter("barchval")==null?"0":request.getParameter("barchval").toString();%>

 <script type="text/javascript">
 var data,legalcontractexcel;
 
 var rendererstring=function (aggregates){
	  	var value=aggregates['sum'];
	  	
	  	if(typeof(value)=='undefined'){
	  		value=0;
	  	}
	  	return '<div style="float: left; margin: 4px;font-size:12px; overflow: hidden;">' + "" + ' ' + value + '</div>';
		}
	  	var rendererstring1=function (aggregates){
	  	var value1=aggregates['sum1'];
	  	return '<div style="float: left; margin: 4px;font-size:12px; overflow: hidden;">' + " Total" + '</div>';
	  }
 
 var bb='<%=branchval%>';
	if(bb!='0'){
 data= '<%= sd.loadGridData(fromdate,todate,rds,branchval)%>';
 legalcontractexcel= '<%= sd.loadGridExcel(fromdate,todate,rds,branchval)%>';
	}
	else{
		bb=5;
	}
    //alert("==================loadSalikData");
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'String'  },
     						{name : 'dtype', type: 'String'  },
     						{name : 'apprdate', type: 'String'  },
     						{name : 'grpcode', type: 'String'  },
     						{name : 'status', type: 'String'  },
     						{name : 'client', type: 'String' },
     						{name : 'cperson', type: 'String' },
     						{name : 'refdtype', type: 'String' },
     						{name : 'refno', type: 'String' },
     						{name : 'sdate', type: 'date' },
     						{name : 'edate', type: 'date' },
     						{name : 'cval', type: 'String' },
     						{name : 'site', type: 'String' },
     						{name : 'lfee', type: 'String' },
     						
     					     						
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
            $("#jqxloaddataGrid").jqxGrid(
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
                showaggregates:true,
                showstatusbar:true,
                statusbarheight: 25,
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
					{ text: 'Doc No', datafield: 'doc_no', width: '4%' },
					{ text: 'Type',  datafield: 'dtype', width: '4%' },
					{ text: 'Appr. Date',  datafield: 'apprdate', width: '8%' },
					{ text: 'Client', datafield: 'client', width: '15%' },
					{ text: 'Contact Person', datafield: 'cperson', width: '10%' },
					{ text: 'Site', datafield: 'site', width: '9%' },
					{ text: 'Servce Team',  datafield: 'grpcode', width: '7%' },
					{ text: 'Ref Dtype', datafield: 'refdtype', width: '5%' },
					{ text: 'Ref No', datafield: 'refno', width: '5%' },
					{ text: 'Start Date', datafield: 'sdate', width: '6%',cellsformat:'dd.MM.yyyy' },
					{ text: 'End Date', datafield: 'edate', width: '6%',cellsformat:'dd.MM.yyyy',aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
					{ text: 'Contract Value',  datafield: 'cval', width: '6%',aggregates: ['sum'],aggregatesrenderer:rendererstring },
					{ text: 'Legal Fees',  datafield: 'lfee', width: '6%',aggregates: ['sum'],aggregatesrenderer:rendererstring },
					{ text: 'Status',  datafield: 'status', width: '8%' },					
					
					
	              ]
            });
            if(bb==5)
        	{
        	 $("#jqxloaddataGrid").jqxGrid('addrow', null, {});
        	}

                 $("#overlay, #PleaseWait").hide();
                 
                
        });
    </script>
    <div id="jqxloaddataGrid"></div>
