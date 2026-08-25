    <%-- <jsp:include page="../../includes.jsp"></jsp:include>  --%> 
    
  <%@page import="com.dashboard.projectexecution.jobonholdcancel.jobonHoldCancelDAO" %>
<%
jobonHoldCancelDAO sd=new jobonHoldCancelDAO();
%>
    
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>


 <% String fromdate =request.getParameter("froms")==null?"0":request.getParameter("froms").toString();%>
 <% String todate =request.getParameter("tos")==null?"0":request.getParameter("tos").toString();%>
 <% String process =request.getParameter("process")==null?"0":request.getParameter("process").toString();%>
 <% String barchval =request.getParameter("barchval")==null?"0":request.getParameter("barchval").toString();%>

 <script type="text/javascript">
 var data,jobholdcancelexcel;
 
 var bb='<%=process%>';
	if(bb!='0'){
 data= '<%= sd.loadGridData(fromdate,todate,process,barchval)%>';
 jobholdcancelexcel= '<%= sd.loadGridExcel(fromdate,todate,process,barchval) %>';
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
     						{name : 'client', type: 'String' },
     						{name : 'cperson', type: 'String' },
     						{name : 'mobno', type: 'String' },
     						{name : 'sdate', type: 'date' },
     						{name : 'edate', type: 'date' },
     						{name : 'cval', type: 'String' },
     						{name : 'site', type: 'String' },
     						{name : 'lfee', type: 'String' },
     						{name : 'tr_no', type: 'String' }
     					     						
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
					{ text: 'Doc No', datafield: 'doc_no', width: '8%' },
					{ text: 'Doc Type',  datafield: 'dtype', width: '8%' },
					{ text: 'Client', datafield: 'client', width: '15%' },
					{ text: 'Contact Person', datafield: 'cperson', width: '15%' },
					{ text: 'Mobile No', datafield: 'mobno', width: '10%' },
					{ text: 'Start Date', datafield: 'sdate', width: '8%',cellsformat:'dd.MM.yyyy' },
					{ text: 'End Date', datafield: 'edate', width: '8%',cellsformat:'dd.MM.yyyy' },
					{ text: 'Contract Value',  datafield: 'cval', width: '10%' },
					{ text: 'Site',  datafield: 'site', width: '8%' },
					{ text: 'Legal Fees',  datafield: 'lfee', width: '10%' },
					{ text: 'tr No',  datafield: 'tr_no', width: '10%',hidden:true },
					
					
					
	              ]
            });
         /*   if(bb==5)
        	{
        	 $("#jqxloaddataGrid").jqxGrid('addrow', null, {});
        	}
	*/
                 $("#overlay, #PleaseWait").hide();
                 
                 $('#jqxloaddataGrid').on('rowdoubleclick', function (event) 
                 		{ 
             	  var rowindex1=event.args.rowindex;
             	  
             	  document.getElementById("info").value="Doc No : "+$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "doc_no")+"\n"+
             	 "Doc Type : "+$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "dtype")+"\n"+
             	  "Client  : "+$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "client")+"";
             	 document.getElementById("doc").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
             	document.getElementById("dtyp").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "dtype");
             	document.getElementById("trno").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "tr_no");
                 		 });	 
                 
        });
    </script>
    <div id="jqxloaddataGrid"></div>
