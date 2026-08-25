<%@page import="com.dashboard.accounts.arprojectallocation.ClsARProjectAllocationDAO"%>
<%ClsARProjectAllocationDAO DAO= new ClsARProjectAllocationDAO(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String fromDate = request.getParameter("fromdate")==null?"":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"":request.getParameter("todate").trim(); 
     String accdocno = request.getParameter("accdocno")==null?"0":request.getParameter("accdocno").trim();
     String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();
     System.out.println("branchval===="+branchval);
     %> 
     
     
     

<script type="text/javascript">
      var data;
      var temp='<%=branchval%>';
      
	  	if(temp!='NA'){ 
	  		   data='<%=DAO.arProjectAllocationGridLoading(branchval, accdocno,fromDate,toDate,check)%>';
	  	}
	  	
  	
        $(document).ready(function () {
        	
        	var source =
            {
                datatype: "json",
                datafields: [
							{name : 'account' , type:'string'},
							{name : 'accountname' , type:'string'},
							{name : 'acno' , type:'int'},
							{name : 'transno' , type:'string'},
							{name : 'transtype',type:'string'},
							{name : 'date' , type: 'date' },
							{name : 'debit' , type:'number'},
							{name : 'credit' , type:'number'},
							{name : 'jobno' , type:'number'},
							{name : 'jobname' , type:'string'},
							{name : 'doc_no' , type:'string'},
							{name : 'tranid' , type:'string'},
							{name : 'savebtn' , type:'string'},
							{name : 'removebtn' , type:'string'}
	                      ],
                          localdata: data,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
        	$("#arProjectAllocationGridId").on("bindingcomplete", function (event) {
        		// your code here.
        		$("#overlay, #PleaseWait").hide();
        	}); 
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#arProjectAllocationGridId").jqxGrid(
            {
                width: '98%',
                height: 480,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                columnsresize: true,
                selectionmode: 'singlecell',
                editable: false,
                
				handlekeyboardnavigation: function (event) {
                	
                    //Search Pop-Up
                    var cell1 = $('#arProjectAllocationGridId').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'jobno') {
	                   var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
	                   if (key == 114) {   
	                	   $('#rowindex').val(cell1.rowindex);
	                	   costCodeSearchContent("costCodeSearchGrid.jsp?check=1");
	                	   $('#arProjectAllocationGridId').jqxGrid('render');
	                   }
        	         
	               }
                },
                
                columns: [
							{ text: 'Account',  datafield: 'account', width: '7%' },
							{ text: 'Account Name',  datafield: 'accountname', width: '22%' },
							{ text: 'Acno',  datafield: 'acno', width: '6%', hidden: true },
							{ text: 'Doc No',  datafield: 'transno', width: '6%' },
							{ text: 'Type', datafield:'transtype', width:'4%' },
							{ text: 'Date', datafield: 'date', width: '6%', cellsformat: 'dd.MM.yyyy' },
							{ text: 'Debit',  datafield: 'debit', width: '8%',cellsformat: 'd2',cellsalign:'right',align:'right' },
							{ text: 'Credit',  datafield: 'credit', width: '8%',cellsformat: 'd2',cellsalign:'right',align:'right' },
							{ text: 'Job No',  datafield: 'jobno', width: '7%' },
							{ text: 'Job Name', datafield:'jobname', width:'20%' },
							{ text: 'Doc No',  datafield: 'doc_no', width: '6%', hidden: true },
							{ text: 'Tranid',  datafield: 'tranid', width: '6%', hidden: true },
							{ text: ' ', datafield: 'savebtn', width: '6%', columntype: 'button', editable:false, filterable: false},
							{ text: ' ', datafield: 'removebtn', width: '6%', columntype: 'button', editable:false, filterable: false},
						 ]
            });
            
            if(temp=='NA'){
                $("#arProjectAllocationGridId").jqxGrid("addrow", null, {});
            }
            
			
			
			$('#arProjectAllocationGridId').on('celldoubleclick', function (event) {
		    		  
		           if(event.args.columnindex == 8)
		            {
			           var rowindextemp = event.args.rowindex;
			           document.getElementById("rowindex").value = rowindextemp;
			           $('#arProjectAllocationGridId').jqxGrid('clearselection');
			           costCodeSearchContent("costCodeSearchGrid.jsp?check=1");
	                 
		            }
			});
			
			$("#arProjectAllocationGridId").on('cellclick', function (event) {
	       		 
	          	  var datafield = event.args.datafield;
	          	  var rowIndex = event.args.rowindex;
	        			  
	   			  if(datafield=="savebtn"){
	   				  
	   				 
	   				 var branch=$('#cmbbranch').val();
			     	//alert("branch=="+branch);	 
	   				 
			     		if(branch=='' || branch=='a'){
		     			 
			     			$.messager.alert('Message', ' Please select branch', function(r){});
			     			return false;
			     		 }
			     		 
			     		
	   					 $.messager.confirm('Message', 'Do you want to save changes?', function(r){
	   				        
	   				     	if(r==false)
	   				     	  {
	   				     		return false; 
	   				     	  }
	   				     	else{
	   				     		
	   				     		 var docno = $('#arProjectAllocationGridId').jqxGrid('getcelltext', rowIndex, "transno");
	   				     		 var dtype = $('#arProjectAllocationGridId').jqxGrid('getcellvalue', rowIndex, "transtype");
	   				     		 var acno = $('#arProjectAllocationGridId').jqxGrid('getcellvalue', rowIndex, "acno");
	   				     		 var tranid = $('#arProjectAllocationGridId').jqxGrid('getcellvalue', rowIndex, "tranid");
	   				     		 var jobno = $('#arProjectAllocationGridId').jqxGrid('getcellvalue', rowIndex, "jobno");
	   				     		
	   				     		 $("#overlay, #PleaseWait").show();
	   				     		 
	   				     	
	   				     		 
	   				     		
	   				     		 saveGridData(docno,dtype,acno,tranid,jobno);	
	   				     	}
	   				 	});
	   			  
	   			  }
	   			  
	   			  
	   			  
	   			  
	   			  
	   			  
	   			  
	   			 if(datafield=="removebtn"){
	   				  
	   					 $.messager.confirm('Message', 'Do you want to remove details ?', function(r){
	   				        
	   				     	if(r==false)
	   				     	  {
	   				     		return false; 
	   				     	  }
	   				     	else{
	   				     		
	   				     		 var docno = $('#arProjectAllocationGridId').jqxGrid('getcelltext', rowIndex, "transno");
	   				     		 var dtype = $('#arProjectAllocationGridId').jqxGrid('getcellvalue', rowIndex, "transtype");
	   				     		 var acno = $('#arProjectAllocationGridId').jqxGrid('getcellvalue', rowIndex, "acno");
	   				     		 var tranid = $('#arProjectAllocationGridId').jqxGrid('getcellvalue', rowIndex, "tranid");
	   				     		 var jobno = $('#arProjectAllocationGridId').jqxGrid('getcellvalue', rowIndex, "jobno");
	   				     		
	   				     		 $("#overlay, #PleaseWait").show();
	   				     		 
	   				     		
	   				     		 removeGridData(docno,dtype,acno,tranid,jobno);	
	   				     	}
	   				 	});
	   			  
	   			  }
	   				   
	          }); 
        });

</script>
<div id="arProjectAllocationGridId"></div>
<input type="hidden" id="rowindex"/> 