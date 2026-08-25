<%@page import="com.dashboard.gwinternal.changesdone.ClsChangesDoneDAO" %>
<% ClsChangesDoneDAO DAO=new ClsChangesDoneDAO();%>
<% String contextPath=request.getContextPath();%>
<%   String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim(); 
     String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String cldocno = request.getParameter("cldocno")==null || request.getParameter("cldocno").trim().equalsIgnoreCase("")?"0":request.getParameter("cldocno").trim();
     String project = request.getParameter("project")==null?"0":request.getParameter("project").trim();
     String rptType = request.getParameter("rpttype")==null?"0":request.getParameter("rpttype");
     String check = request.getParameter("check")==null?"0":request.getParameter("check").trim(); %>
<script type="text/javascript">
      var data;
      var temp='<%=branchval%>';
      
	  	if(temp!='NA'){ 
	  		   data='<%=DAO.changesDoneGridLoading(rptType,branchval,fromDate,toDate,cldocno,project,check)%>';  
	  	}
	  	
        $(document).ready(function () {
        	
         	
        	var source =
            {
                datatype: "json",
                datafields: [
							{ name: 'doc_no', type: 'int' },
							{ name: 'date', type: 'date' },
							{ name: 'project', type: 'string' },
							{ name: 'form_name', type: 'string' },
							{ name: 'files_tobecopied', type: 'string' },
		                    { name: 'file_path', type: 'string' },
		                    { name: 'query_file', type: 'string' },
		                    { name: 'description', type: 'string' },
							{ name: 'employee', type: 'string' },
							{name : 'attachbtn', type: 'String'  }
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
            $("#changesDoneGridID").jqxGrid(
            {
                width: '98%',
                height: 500,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                columnsresize: true,
                editable: true,
                
                columns: [
						{ text: 'Doc No', datafield: 'doc_no', editable:false, width: '7%' },
						{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , editable:false, width: '7%' },
						{ text: 'Project', datafield: 'project', editable:false, width: '10%'},
						{ text: 'Form Name', datafield: 'form_name', editable:false, width: '16%' },
						{ text: 'File to be Copied', datafield: 'files_tobecopied', editable:false, width: '20%' },
	                    { text: 'File Path', datafield: 'file_path', width: '15%' },
	                    { text: 'Query File', datafield: 'query_file', editable:false, width: '10%'},
	                    { text: 'Description', datafield: 'description', editable:false, width: '15%' },
	                    { text: 'Employee', datafield: 'employee', editable:false, width: '10%'},
						{ text: ' ', datafield: 'attachbtn', width: '6%', columntype: 'button', editable:false, filterable: false},
					 ]
            });
            
            if(temp=='NA'){
                $("#changesDoneGridID").jqxGrid("addrow", null, {});
            }
            
            if(document.getElementById("rdtobecopied").checked==true){
				 $('#changesDoneGridID').jqxGrid({ selectionmode: 'checkbox'}); 
			 } else if(document.getElementById("rdcopied").checked==true){
				 $('#changesDoneGridID').jqxGrid({ selectionmode: 'singlerow'}); 
			 }
            
            $("#overlay, #PleaseWait").hide();

			$("#changesDoneGridID").on('cellclick', function (event) {
          		 
            	  var datafield = event.args.datafield;
            	  var rowBoundIndex = event.args.rowindex;   
          			  
          			 if(datafield=="attachbtn"){

                    		 $("#windowattach").jqxWindow('setTitle', "CHNG - "+$('#changesDoneGridID').jqxGrid('getcellvalue',rowBoundIndex, "doc_no"));
                    		 changeDashBoardAttachContent("<%=contextPath%>/com/common/Attachgridmaster.jsp?formc=CHNG&docno="+$('#changesDoneGridID').jqxGrid('getcellvalue',rowBoundIndex, 'doc_no'));
          			 }
            		   
            }); 
			
        });

</script>
<div id="changesDoneGridID"></div>
