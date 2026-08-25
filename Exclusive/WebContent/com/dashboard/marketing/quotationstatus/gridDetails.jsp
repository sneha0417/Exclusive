   <%-- <jsp:include page="../../includes.jsp"></jsp:include>  --%> 

<%@page import="com.dashboard.marketing.quotationstatus.quotationStatusDAO" %>
<%
quotationStatusDAO sd=new quotationStatusDAO();
%>
    
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>


<% String fromdate =request.getParameter("froms")==null?"0":request.getParameter("froms").toString();%>
 <% String todate =request.getParameter("tos")==null?"0":request.getParameter("tos").toString();%>
 <% String rds =request.getParameter("rds")==null?"0":request.getParameter("rds").toString();%>
 <% String branchval =request.getParameter("barchval")==null?"0":request.getParameter("barchval").toString();
 
 
 %>

 <script type="text/javascript">
 var data,quotstatusexcel;
 
 var bb='<%=branchval%>';
	if(bb!='0'){
 data= '<%= sd.loadGridData(fromdate,todate,rds,branchval)%>';  
 quotstatusexcel= '<%= sd.loadGridExcel(fromdate,todate,rds,branchval)%>';
 
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
                         	{name : 'site', type: 'String'  },
							{name : 'doc_no', type: 'String'  },
     						{name : 'dtype', type: 'String'  },
     						{name : 'client', type: 'String' },
     						{name : 'cperson', type: 'String' },
     						{name : 'refdtype', type: 'String' },
     						{name : 'refno', type: 'String' },
     					//	{name : 'amount', type: 'String' },
     						{name : 'sal_name', type: 'string' },
							{name : 'amount', type: 'string' },
     						{name : 'discount', type: 'String' },
     						
     						{name : 'tax', type: 'String' },
     						{name : 'netamt', type: 'string' },
     						{name : 'date', type: 'date' }
     						
     					     						
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
                height: 545,
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
					{ text: 'Doc No', datafield: 'doc_no', width: '7%' },
					{ text: 'Contract Type',  datafield: 'dtype', width: '10%' },
					{ text: 'Date', datafield: 'date', width: '7%',cellsformat:'dd.MM.yyyy'},
					{ text: 'Client', datafield: 'client', width: '15%' },
					{ text: 'Site', datafield: 'site', width: '15%' },  
					{ text: 'Contact Person', datafield: 'cperson', width: '13%' },
					{ text: 'Ref Type', datafield: 'refdtype', width: '7%' },
					{ text: 'Ref No', datafield: 'refno', width: '11%' },
					{ text: 'Salesman', datafield: 'sal_name', width: '12%' },
					{ text: 'Gr. Total', datafield: 'amount', width: '8%',align: 'right',cellsalign: 'right',cellsformat: 'd2' },
					{ text: 'Discount',  datafield: 'discount', width: '7%',align: 'right',cellsalign: 'right',cellsformat: 'd2' },
					{ text: 'Tax',  datafield: 'tax', width: '6%',align: 'right',cellsalign: 'right',cellsformat: 'd2' },
					{ text: 'Total',  datafield: 'netamt', width: '8%',align: 'right',cellsalign: 'right',cellsformat: 'd2' },
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
