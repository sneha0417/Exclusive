    <%-- <jsp:include page="../../includes.jsp"></jsp:include>  --%> 
    
  <%@page import="com.dashboard.projectexecution.jobclose.jobCloseDAO" %>
<%
jobCloseDAO sd=new jobCloseDAO();
%>
    
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>


 <% String fromdate =request.getParameter("froms")==null?"0":request.getParameter("froms").toString();%>
 <% String todate =request.getParameter("tos")==null?"0":request.getParameter("tos").toString();%>
 <% String rds =request.getParameter("rds")==null?"0":request.getParameter("rds").toString();%>
 <% String barchval =request.getParameter("barchval")==null?"0":request.getParameter("barchval").toString();%>
 <% String check =request.getParameter("check")==null?"0":request.getParameter("check").toString();%>
<style type="text/css">
  .closedateClass
  {
      background-color: #F9E79F  ;
  }
  
</style>
 <script type="text/javascript">
 var data,jobcloseexcel;
 var rad='<%=rds%>';
 data= '<%= sd.loadGridData(fromdate,todate,barchval,rds,check)%>' ;
 jobcloseexcel= '<%= sd.loadGridExcelExport(fromdate,todate,barchval,rds,check)%>' ;

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
     						{name : 'tr_no', type: 'String' },
     						{name : 'cldate', type: 'date' },
     					     						
                 ],
                 localdata: data,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
 $("#jqxjobclosegrid").on("bindingcomplete", function (event) {
            	
            	// your code here.
            if(rad=="CL"){
            	$('#jqxjobclosegrid').jqxGrid('setcolumnproperty','cldate','hidden',false);
                        	
            }	
            });     
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxjobclosegrid").jqxGrid(
            {
                width: '99%',
                height: 530,
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
					{ text: 'Closed Date',  datafield: 'cldate', width: '8%',cellsformat:'dd.MM.yyyy',hidden:true ,cellclassname: 'closedateClass'},
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
        	 $("#jqxjobclosegrid").jqxGrid('addrow', null, {});
        	}
	*/
                 $("#overlay, #PleaseWait").hide();
                 
                 $('#jqxjobclosegrid').on('rowdoubleclick', function (event) 
                 		{ 
             	  var rowindex1=event.args.rowindex;
             	  
             	  document.getElementById("info").value="Doc No : "+$('#jqxjobclosegrid').jqxGrid('getcellvalue', rowindex1, "doc_no")+"\n"+
             	 "Doc Type : "+$('#jqxjobclosegrid').jqxGrid('getcellvalue', rowindex1, "dtype")+"\n"+
             	  "Client  : "+$('#jqxjobclosegrid').jqxGrid('getcellvalue', rowindex1, "client")+"";
             	 document.getElementById("doc").value=$('#jqxjobclosegrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
             	document.getElementById("dtyp").value=$('#jqxjobclosegrid').jqxGrid('getcellvalue', rowindex1, "dtype");
             	document.getElementById("trno").value=$('#jqxjobclosegrid').jqxGrid('getcellvalue', rowindex1, "tr_no");
                 		 });	 
                 
        });
    </script>
    <div id="jqxjobclosegrid"></div>
