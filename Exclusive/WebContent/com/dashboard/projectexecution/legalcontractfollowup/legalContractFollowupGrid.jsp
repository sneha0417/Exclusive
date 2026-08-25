    <%-- <jsp:include page="../../includes.jsp"></jsp:include>  --%> 
    
  <%@page import="com.dashboard.projectexecution.legalcontractfollowup.legalContractFollowupDAO"%>
<%
legalContractFollowupDAO sd=new legalContractFollowupDAO();
%>
    
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>


 <% String uptodate =request.getParameter("uptodate")==null?"0":request.getParameter("uptodate").toString();
 String chkfollowup = request.getParameter("chkfollowup")==null?"0":request.getParameter("chkfollowup").trim();
 String followupdate = request.getParameter("followupdate")==null?"0":request.getParameter("followupdate").trim();
 
 String branchval =request.getParameter("branchval")==null?"0":request.getParameter("branchval").toString();
 
 %>

 <script type="text/javascript">
 var data,legalcontfolwuptexcel;
 
 var bb='<%=branchval%>';
	if(bb!='0'){
 data= '<%= sd.loadGridData(uptodate,chkfollowup,followupdate,branchval) %>';
 legalcontfolwuptexcel= '<%= sd.loadGridExcel(uptodate,chkfollowup,followupdate,branchval) %>';
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
     						{name : 'refdtype', type: 'String' },
     						{name : 'refno', type: 'String' },
     						{name : 'sdate', type: 'date' },
     						{name : 'edate', type: 'date' },
     						{name : 'cval', type: 'String' },
     						
     						{name : 'lfee', type: 'String' },
     						{name : 'fdate', type: 'date' },
     						{name : 'brch', type: 'String' },
     						{name : 'tr_no', type: 'String' },
     						{name : 'site', type: 'String' },
     					     						
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
                height: 400,
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
					{ text: 'Doc Type',  datafield: 'dtype', width: '7%' },
					{ text: 'Client', datafield: 'client', width: '14%' },
					{ text: 'Contact Person', datafield: 'cperson', width: '14%' },
					{ text: 'Ref Dtype', datafield: 'refdtype', width: '9%' },
					{ text: 'Ref No', datafield: 'refno', width: '9%' },
					{ text: 'Start Date', datafield: 'sdate', width: '8%',cellsformat:'dd.MM.yyyy' },
					{ text: 'End Date', datafield: 'edate', width: '8%',cellsformat:'dd.MM.yyyy' },
					{ text: 'Contract Value',  datafield: 'cval', width: '8%' },
					{ text: 'Site',  datafield: 'site', width: '8%' },
					{ text: 'Legal Fees',  datafield: 'lfee', width: '8%' },
					{ text: 'Followup Date', datafield: 'fdate', width: '8%',cellsformat:'dd.MM.yyyy' },
					{ text: 'Branch Id',  datafield: 'brch', width: '10%' ,hidden:true},
					{ text: 'Tr No',  datafield: 'tr_no', width: '10%' ,hidden:true},
					
					
					
	              ]
            });
         /*   if(bb==5)
        	{
        	 $("#jqxloaddataGrid").jqxGrid('addrow', null, {});
        	}
	*/
                 $("#overlay, #PleaseWait").hide();
                 
                 $('#jqxloaddataGrid').on('rowdoubleclick', function (event) { 
                 	  var rowindex1=event.args.rowindex;
                 		  
                       $('#cmbprocess').attr("disabled",false);$('#txtremarks').attr("readonly",false);
                     //  $('#legno').attr("readonly",false);
                       $('#date').jqxDateTimeInput({disabled: false});$('#btnupdate').attr("disabled",false);
                       $('#btnattachments').attr("disabled",false);
                       
                 	document.getElementById("contno").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                 	document.getElementById("conttype").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "dtype");
                 	document.getElementById("txtbranch").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "brch");
                 	document.getElementById("txtdocno").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "tr_no");
                 	 	
                    $("#detailDiv").load("detailGrid.jsp?trno="+$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, 'tr_no'));
                    }); 
        });
    </script>
    <div id="jqxloaddataGrid"></div>
