<%@page import="com.dashboard.marketing.quotationfollowup.quotationFollowupDAO"%>
     <%
     quotationFollowupDAO sd= new quotationFollowupDAO();
     %>
    
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>


<% 
String branchval = request.getParameter("branchval")==null?"0":request.getParameter("branchval").trim();
String fromdate = request.getParameter("froms")==null?"0":request.getParameter("froms").trim();
	String todate = request.getParameter("tos")==null?"0":request.getParameter("tos").trim();
	 String chkfollowup = request.getParameter("chkfollowup")==null?"0":request.getParameter("chkfollowup").trim();
	 String salid = request.getParameter("salid")==null?"0":request.getParameter("salid").trim();
     String followupdate = request.getParameter("followupdate")==null?"0":request.getParameter("followupdate").trim();
 
 %>

 <script type="text/javascript">
 var data,qotfollowupexcel;
 
 var bb='<%=branchval%>';
	if(bb!='0'){
		 data='<%=sd.qotlistsearch(branchval,fromdate,todate,chkfollowup,followupdate,salid) %>'; 
		  qotfollowupexcel='<%=sd.quotlistExcel(branchval,fromdate,todate,chkfollowup,followupdate,salid)%>'; 
 
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
     						{name : 'path', type: 'String'  },
     						{name : 'client', type: 'String' },
     						{name : 'cperson', type: 'String' },
     						{name : 'refdtype', type: 'String' },
     						{name : 'refno', type: 'String' },
     					//	{name : 'amount', type: 'String' },
     						{name : 'amount', type: 'string' },
     						{name : 'discount', type: 'String' },
     						{name : 'contr', type: 'String' },
     						{name : 'tax', type: 'String' },
     						{name : 'netamt', type: 'string' },
     						{name : 'date', type: 'date' },
     						{name : 'tr_no', type: 'string' },
     						{name : 'brch', type: 'string' },
     						{name : 'name', type: 'string' },
     						{name : 'fdate', type: 'date' },
     						
     					     						
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
					{ text: 'Doc No', datafield: 'doc_no', width: '5%' },
					{ text: 'Contract Type',  datafield: 'dtype', width: '7%' },
					 { text: 'Date', datafield: 'date', width: '7%',cellsformat:'dd.MM.yyyy'},
					{ text: 'Client', datafield: 'client', width: '12%' },
					{ text: 'Contact Person', datafield: 'cperson', width: '12%' },
					{ text: 'Ref Type', datafield: 'refdtype', width: '5%' },
					{ text: 'Ref No', datafield: 'refno', width: '10%' },
					{ text: 'Gr. Total', datafield: 'amount', width: '8%' },
					{ text: 'Discount',  datafield: 'discount', width: '8%' },
					{ text: 'Tax',  datafield: 'tax', width: '6%' },
					{ text: 'Total',  datafield: 'netamt', width: '8%' },
					{ text: 'Followup Date', datafield: 'fdate', width: '8%',cellsformat:'dd.MM.yyyy' },
					{ text: '',  datafield: 'contr',columntype: 'button', width: '4%' },
					{ text: 'TR_NO',  datafield: 'tr_no', width: '8%',hidden:true },
					{ text: 'Branch',  datafield: 'brch', width: '8%',hidden:true },
					{ text: 'path',  datafield: 'path', width: '8%',hidden:true },
					{ text: 'name',  datafield: 'name', width: '8%',hidden:true },
					
					
					
	              ]
            });
           /*  if(bb==5)
        	{
        	 $("#jqxloaddataGrid").jqxGrid('addrow', null, {});
        	} */

                 $("#overlay, #PleaseWait").hide();
        	
        	
        	   $('#jqxloaddataGrid').on('cellclick', function (event) 
               		{ 
   		            	var rowindex1=event.args.rowindex;
   		            	var datafield = event.args.datafield;
   		            	
   		            	 if(datafield=="contr"){
   		                	 
   		     				
   		     				 var path1=$("#jqxloaddataGrid").jqxGrid('getcellvalue', rowindex1, "path");
   		     				 var brch=$("#jqxloaddataGrid").jqxGrid('getcellvalue', rowindex1, "brch");
   		     				 var doctype=$("#jqxloaddataGrid").jqxGrid('getcellvalue', rowindex1, "dtype");
   		     				 var  doc_no=0;
   		     				
   		     					  doc_no=$("#jqxloaddataGrid").jqxGrid('getcellvalue', rowindex1, "doc_no");
   		     				
   		     				 var name=$("#jqxloaddataGrid").jqxGrid('getcellvalue', rowindex1, "name");
   		     				
   		     				 var url=document.URL;
   		       				var reurl=url.split("com");
   		       
   		     			  window.parent.formName.value=$("#jqxloaddataGrid").jqxGrid('getcellvalue', rowindex1, "name");
   		     			  window.parent.formCode.value=$("#jqxloaddataGrid").jqxGrid('getcellvalue', rowindex1, "dtype");
   		     			  var detName=$("#jqxloaddataGrid").jqxGrid('getcellvalue', rowindex1, "name");
   		     			  
   		     			  var path= path1+"?modes=view&mastertrno="+doc_no+"&isassign=1&brch="+brch+"&doctype="+doctype+"&name="+name;
   		     			 
   		     			   top.addTab( detName,reurl[0]+""+path);
   		     				
   		                 	
   		                 }
    	
   		              
   		              
               		 });
        	
                 
                 $('#jqxloaddataGrid').on('rowdoubleclick', function (event) { 
                  	  var rowindex1=event.args.rowindex;
                  		
                  	 
                        $('#cmbprocess').attr("disabled",false);$('#txtremarks').attr("readonly",false);
                 	     
                        $('#date').jqxDateTimeInput({disabled: false});$('#btnupdate').attr("disabled",false);
                      
                  		 
                        document.getElementById("info").value="Doc No : "+$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "doc_no")+"\n"+
                    	 "Client : "+$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "client")+"";
                  	 document.getElementById("txtbranch").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "brch");
                  	 document.getElementById("txtdocno").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "tr_no");
                  	document.getElementById("conttype").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "dtype");
                  	 	
                      $("#detailDiv").load("detailGrid.jsp?doc="+$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, 'tr_no'));
                      
                     }); 
                  
                 
                
        });
    </script>
    <div id="jqxloaddataGrid"></div>
