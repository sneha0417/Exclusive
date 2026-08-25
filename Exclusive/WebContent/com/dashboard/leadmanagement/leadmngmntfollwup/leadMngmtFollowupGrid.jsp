    <%-- <jsp:include page="../../includes.jsp"></jsp:include>  --%> 
    
  <%@page import="com.dashboard.leadmanagement.leadmngmntfollwup.ClsLeadMngmntFollwUpDAO"%>
<%
ClsLeadMngmntFollwUpDAO sd=new ClsLeadMngmntFollwUpDAO();
%>
    
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

 <%

     String chkfollowup = request.getParameter("chkfollowup")==null?"0":request.getParameter("chkfollowup").trim();
     String followupdate = request.getParameter("followupdate")==null?"0":request.getParameter("followupdate").trim();
     String branchval =request.getParameter("branchval")==null?"0":request.getParameter("branchval").toString();
     String fromdate =request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").toString();
     String todate =request.getParameter("todate")==null?"0":request.getParameter("todate").toString();
     String check=request.getParameter("check")==null?"0":request.getParameter("check").toString();
     String salesmanid=request.getParameter("salesmanid")==null?"0":request.getParameter("salesmanid").toString();
     
     %>
 <script type="text/javascript">
 var data,amcrenewalexcel;
 
 var flchk='<%=check%>';

	if(flchk!='0'){
 data= '<%= sd.loadGridData(branchval,chkfollowup,followupdate,fromdate,todate,salesmanid)%>';
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
     						{name : 'tel_no', type: 'String'  },
     						{name : 'email', type: 'String' },
     						{name : 'desc1', type: 'String' },
     						{name : 'brhid', type: 'String' },
     						{name : 'userid', type: 'String' },
     						{name : 'tr_no', type: 'String' },
     						{name : 'salesman', type: 'String' },
     						{name : 'name', type: 'String' },
     						{name : 'date', type: 'date' },    					
     						{name : 'fdate', type: 'date' },
     						{name : 'leadstatus', type: 'String' },
     						{name : 'view', type: 'String' },
     						{name : 'dtype', type: 'String' },
     						{name : 'path', type: 'String' },
     						{name : 'menuname', type: 'String' }
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
					{ text: 'Doc No', datafield: 'doc_no', width: '6%' },
					{ text: '',  datafield: 'view',columntype: 'button', width: '5%' },
					{ text: 'Name', datafield: 'name', width: '19%', },
					{ text: 'Mob No', datafield: 'mob_no', width: '9%' },
					{ text: 'Tel No', datafield: 'tel_no', width: '9%' },
					{ text: 'Email', datafield: 'email', width: '12%' },
					{ text: 'Date', datafield: 'date', width: '7%',cellsformat:'dd.MM.yyyy' },
					{ text: 'Description', datafield: 'desc1', width: '15%' },
					{ text: 'Salesman',  datafield: 'salesman', width: '12%' },
					{ text: 'Lead Status',  datafield: 'leadstatus', width: '6%' },
					{ text: 'Followup Date', datafield: 'fdate', width: '9%',cellsformat:'dd.MM.yyyy' },
					
					{ text: 'Tr No',  datafield: 'tr_no', width: '10%' ,hidden:true},
					{ text: 'Brnch Id',  datafield: 'brhid', width: '10%' ,hidden:true}, 
					{ text: 'User Id',  datafield: 'userid', width: '10%' ,hidden:true},
					{ text: 'Path',  datafield: 'path', hidden: true, width: '5%' },
					{ text: 'name',  datafield: 'menuname', hidden: true, width: '5%' },
					{ text: 'dtype',  datafield: 'dtype', hidden: true, width: '5%' },
					
	              ]
            });
      
               $("#overlay, #PleaseWait").hide();
                $('#jqxloaddataGrid').on('rowdoubleclick', function (event) { 
                	$('#amcfollowupGrid').jqxGrid({disabled:false});
                 	  var rowindex1=event.args.rowindex;
                 	   $('#cmbprocess').val('');
                 	   $('#cmbpriority').val(''); 
                       $('#cmbprocess').attr("disabled",false);
                       $('#txtremarks').attr("readonly",false);
                       $('#date').jqxDateTimeInput({disabled: false});
                       $('#btnupdate').attr("disabled",false);   
                 	   document.getElementById("txtrdocno").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "tr_no"); 
                 	   document.getElementById("txtbrchid").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "brhid");
                 	   document.getElementById("txtuserid").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "userid");
                 	  /* document.getElementById("txtdocno").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "tr_no");
                 	   document.getElementById("txtcldocno").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "cldocno");
                 	 	  */
                     $("#detailDiv").load("leadMngmtDetailGrid.jsp?trdocno="+$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, 'tr_no'));
                     }); 
                
                $('#jqxloaddataGrid').on('cellclick', function (event) 
                		{ 
    		            	var rowindex1=event.args.rowindex;
    		            	var datafield = event.args.datafield;
    		            	
    		            	 if(datafield=="view"){
    		         			 var path1=$("#jqxloaddataGrid").jqxGrid('getcellvalue', rowindex1, "path");
    		     				 var brch=$("#jqxloaddataGrid").jqxGrid('getcellvalue', rowindex1, "brhid");
    		     				 var doctype=$("#jqxloaddataGrid").jqxGrid('getcellvalue', rowindex1, "dtype");
    		     				 var  doc_no=0;
    		     				 var  trno=0;
    		     					  trno=$("#jqxloaddataGrid").jqxGrid('getcellvalue', rowindex1, "tr_no");
    		     					 doc_no=$("#jqxloaddataGrid").jqxGrid('getcellvalue', rowindex1, "doc_no");
    		     				 var name=$("#jqxloaddataGrid").jqxGrid('getcellvalue', rowindex1, "menuname");
    		     				
    		     				 var url=document.URL;
    		       				var reurl=url.split("com");
    		       
    		     			  window.parent.formName.value=$("#jqxloaddataGrid").jqxGrid('getcellvalue', rowindex1, "menuname");
    		     			  window.parent.formCode.value=$("#jqxloaddataGrid").jqxGrid('getcellvalue', rowindex1, "dtype");
    		     			  var detName=$("#jqxloaddataGrid").jqxGrid('getcellvalue', rowindex1, "menuname");
    		     			  
    		     			  var path= path1+"?modes=view&mastertrno="+trno+"&masterdocno="+doc_no+"&isassign=1&brch="+brch+"&doctype="+doctype+"&name="+name;
    		     			
    		     			   top.addTab( detName,reurl[0]+""+path);
    		     				
    		                 	
    		                 }
     	
    		            	
    		              
                		 });
                
        });
    </script>
    <div id="jqxloaddataGrid"></div>
