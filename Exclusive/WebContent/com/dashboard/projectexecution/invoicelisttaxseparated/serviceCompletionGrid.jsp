<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.projectexecution.invoicelisttaxseparated.ClsInvoiceListDAO"%>
<%
ClsInvoiceListDAO DAO=new ClsInvoiceListDAO(); 
  String todate =request.getParameter("date")==null?"0":request.getParameter("date").toString();
  String fmdate =request.getParameter("fmdate")==null?"0":request.getParameter("fmdate").toString();
  String branchval =request.getParameter("barchval")==null?"0":request.getParameter("barchval").toString();
  String clientid =request.getParameter("clientid")==null?"0":request.getParameter("clientid").toString(); 
  int id =request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id").toString());
  String type =request.getParameter("type")==null?"0":request.getParameter("type").toString();
  String contract =request.getParameter("contract")==null?"0":request.getParameter("contract").toString();
%>

 <script type="text/javascript">
 var perdata;
 var invoicelistexcel;
 var rendererstring=function (aggregates){
  	var value=aggregates['sum'];
  	
  	if(typeof(value)=='undefined'){
  		value=0;
  	}
  	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "" + ' ' + value + '</div>';
	}
  	var rendererstring1=function (aggregates){
  	var value1=aggregates['sum1'];
  	return '<div style="float: left; margin: 4px;font-size:12px; overflow: hidden;">' + " Total" + '</div>';
  }
 
      perdata= '<%=DAO.loadContractData(todate, branchval, clientid,id,type,contract,fmdate)%>';
      invoicelistexcel= '<%=DAO.loadContractDataExcel(todate, branchval, clientid,id,type,contract,fmdate)%>';
	
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'String'  },
							{name : 'date', type: 'date' },
						//	{name : 'pdate', type: 'date' },
							{name : 'refno', type: 'String' },
     						{name : 'contrtype', type: 'String'  },
     						{name : 'contrno', type: 'String'  },
     						{name : 'client', type: 'String' },
     						{name : 'desc1', type: 'String' },
     						{name : 'invamt', type: 'number' },
     						{name : 'lfee', type: 'number' },
     						{name : 'total', type: 'number' },
     						{name : 'site', type: 'String' },
     						{name : 'siteadd', type: 'String' },
     						{name : 'igstamt', type: 'number' },
     						{name : 'cgstamt', type: 'number' },
     						{name : 'sgstamt', type: 'number' },
     						{name : 'taxamt', type: 'number' },
     				     						
                 ],
                 localdata: perdata,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed...tobeinvamt
                }
            };
            $("#jqxpinvGrid").on("bindingcomplete", function (event) {
            	
            	var taxconfig=document.getElementById("hidtaxconfig").value;
            //	alert(taxconfig);
            if(taxconfig>0){
            	$('#jqxpinvGrid').jqxGrid('setcolumnproperty','taxamt','hidden',false);
                        	
            }	
            });  
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxpinvGrid").jqxGrid(
            {
                width: '99%',
                height: 540,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                showaggregates:true,
                showstatusbar:true,
                statusbarheight: 25,
                selectionmode: 'singlerow',
                filtermode:'excel',
               //filterable: true,
             //   pagermode: 'default',
                columns: [
                          
					{ text: 'InvNo', datafield: 'doc_no', width: '4%' },
					{ text: 'Date',  datafield: 'date', width: '6%',cellsformat:'dd.MM.yyyy' },
				//	{ text: 'Planned Date',  datafield: 'pdate', width: '7%',cellsformat:'dd.MM.yyyy' },
					{ text: 'RefNo', datafield: 'refno', width: '8%' },
					{ text: 'Site', datafield: 'site', width: '10%' },
				//	{ text: 'Site Details', datafield: 'siteadd', width: '15%' },
					{ text: 'Contract Type',  datafield: 'contrtype', width: '7%' },
					{ text: 'Contract No',  datafield: 'contrno', width: '6%' },
					{ text: 'Name', datafield: 'client', width: '10%' },
					{ text: 'Description',  datafield: 'desc1', width: '15%',aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
					{ text: 'IGST Amount',  datafield: 'igstamt', width: '8%',cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
					{ text: 'CGST Amount',  datafield: 'cgstamt', width: '8%',cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
					{ text: 'SGST Amount',  datafield: 'sgstamt', width: '8%',cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
					{ text: 'Amount',  datafield: 'invamt', width: '9%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
					{ text: 'Legal Amount',  datafield: 'lfee', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
					{ text: 'Total Amount',  datafield: 'total', width: '9%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
					
					
				 ]
            });
            
            $('#jqxpinvGrid').on('rowdoubleclick', function (event) 
            		{ 
            	
            		    var rowindex = event.args.rowindex;
            		    
            		    
        				$("#jqxpinvDetGrid").jqxGrid('clear');
        				$("#jqxpsrvDetGrid").jqxGrid('clear'); 
        				hidcolumn(0);
        				
            		    var clientid=$('#clientid').val();
            			 var date=$('#todate').val();
            			 var barchval =$('#jqxpinvGrid').jqxGrid('getcellvalue', rowindex, "brch");
            		     var dtype=$('#jqxpinvGrid').jqxGrid('getcellvalue', rowindex, "rdtype");
            		     var tr_no=$('#jqxpinvGrid').jqxGrid('getcellvalue', rowindex, "tr_no");
            		     var doc_no=$('#jqxpinvGrid').jqxGrid('getcellvalue', rowindex, "doc_no");
            		     var iserv=$('#jqxpinvGrid').jqxGrid('getcellvalue', rowindex, "iserv");
            		     var id=1;
            		     
            		     $('#dtype').val(dtype);
            		     $('#trno').val(tr_no);
            		     $('#docno').val(doc_no);
            		     $('#brch').val(barchval);
            		   
            		    $("#overlay, #PleaseWait").show();
            		    
            		    
            		    
            		 $("#profserdetdiv").load("serviceDetGrid.jsp?barchval="+barchval+"&date="+date+"&clientid="+clientid+"&id="+id+"&type="+dtype+"&tr_no="+tr_no+"&doc_no="+doc_no+"&iserv="+iserv);
            		 if( dtype!='CREG' ){
            		 $("#profinvdetdiv").load("invDetGrid.jsp?barchval="+barchval+"&date="+date+"&clientid="+clientid+"&id="+id+"&type="+dtype+"&tr_no="+tr_no+"&doc_no="+doc_no);
            		 }		  
            				
            		});
           

                 $("#overlay, #PleaseWait").hide();
                 
                
        });
    </script>
    <div id="jqxpinvGrid"></div>
