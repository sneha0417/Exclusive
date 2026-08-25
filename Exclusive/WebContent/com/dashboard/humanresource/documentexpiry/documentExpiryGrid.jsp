<%@page import="com.dashboard.humanresource.documentexpiry.ClsDocumentExpiryDAO"%>
<%ClsDocumentExpiryDAO DAO= new ClsDocumentExpiryDAO(); %>
<% String contextPath=request.getContextPath();%>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String upToDate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate").trim();
     String check = request.getParameter("check")==null?"0":request.getParameter("check").trim(); %>
<style>
 		.redClass { background-color: #FFEBEB; }
 		
        .yellowClass { background-color: #FFFFD1; }
        
        .orangeClass { background-color: #FFEBC2; }
        
        .lightGreenClass { background-color: #F1F8E0; }
	    
	    .lightBlueClass { background-color: #CEECF5; }
        
        .creamClass { background-color: #FFFAFA; }
        
        .violetClass { background-color: #F8E0F7; }
        
        .lightBrownClass { background-color: #F7F2E0; }
        
        .whiteClass { background-color: #fff; }
        
        .folllowUpClass { background-color: #E0F8F1; }
</style>
        
<script type="text/javascript">
      var data;
      var temp='<%=branchval%>';
      
	  	if(temp!='NA'){ 
	  		    data='<%=DAO.documentsExpiryGridLoading(branchval, upToDate,check)%>'; 
				var dataExcelExport='<%=DAO.documentsExpiryExcelExport(branchval, upToDate,check)%>';
	  	}
  	
        $(document).ready(function () {
        	
        	var source =
            {
                datatype: "json",
                datafields: [
					{name : 'empid', type: 'String'  },
					{name : 'empname', type: 'String'  },
					{ name: 'designation', type: 'string' },
	                { name: 'department', type: 'string' },
				    {name : 'pmmob' , type: 'String' },
				    {name : 'document' , type: 'String' },
				    {name : 'expirydate', type: 'date'  },
				    {name : 'followupdate', type: 'date'  },
				    {name : 'empdocno', type: 'int'  },
				    {name : 'brhid', type: 'int'  },
				    {name : 'docid', type: 'int'  },
				    {name : 'empinfo', type: 'string'  },
				    {name : 'view', type: 'string'  },
				    {name : 'attach', type: 'string'  }
	            ],
                localdata: data,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
        	
        	var cellclassname = function (row, column, value, data) {
        		if (data.docid == 1) {
                    return "redClass";
                } else if (data.docid == 2) {
                    return "yellowClass";
                } else if (data.docid == 3) {
                    return "lightGreenClass";
                } else if (data.docid == 4) {
                    return "lightBlueClass";
                } else if (data.docid == 5) {
                    return "creamClass";
                } else if (data.docid == 6) {
                    return "violetClass";
                } else if (data.docid == 7) {
                    return "lightBrownClass";
                }  else if (data.docid == 8) {
                   return "orangeClass";
                } else{
                	return "whiteClass";
                };
            };
        	
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#documentsExpiry").jqxGrid(
            {
                width: '98%',
                height: 400,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                rowsheight:25,
                selectionmode: 'singlerow',
                editable: false,
                
                columns: [
						{ text: 'Emp. ID', datafield: 'empid', width: '8%' },
						{ text: 'Employee', datafield: 'empname', width: '25%' },
						{ text: 'Designation', datafield: 'designation', width: '12%' },
						{ text: 'Department', datafield: 'department', width: '10%' },
						{ text: 'Mobile No.', datafield: 'pmmob', width: '10%' },
						{ text: 'Document', datafield: 'document', cellclassname: cellclassname,  width: '15%' },
						{ text: 'Expiry Date', datafield: 'expirydate', cellclassname: cellclassname,  cellsformat: 'dd.MM.yyyy' , width: '10%' },
						{ text: 'Follow-Up Date', datafield: 'followupdate', cellclassname: 'folllowUpClass',  cellsformat: 'dd.MM.yyyy' , width: '10%' },
						{ text: 'View', datafield: 'view', width: '6%',columntype:'button' },
						{ text: 'Attach', datafield: 'attach', width: '6%',columntype:'button' },
						{ text: 'Emp. DocNo', datafield: 'empdocno', hidden: true, width: '10%' },
						{ text: 'Branch Id', datafield: 'brhid', hidden: true, width: '10%' },
						{ text: 'Document Id', datafield: 'docid', hidden: true, width: '10%' },
						{ text: 'Employee Info', datafield: 'empinfo', hidden: true, width: '10%' },
					 ]
            });
            
            if(temp=='NA'){
                $("#documentsExpiry").jqxGrid("addrow", null, {});
            }
        
            $("#overlay, #PleaseWait").hide();
            
            $('#documentsExpiry').on('rowdoubleclick', function (event) { 
        	  var rowindex1=event.args.rowindex;
        	  $('#cmbprocess').val('');$('#date').val(new Date());$('#txtbranch').val('');$('#txtempdocno').val('');$('#expiryDate').val(new Date());$('#txtremarks').val('');
			  $('#txtempid').val('');$('#txtdocument').val('');$('#txtdocumentid').val('');
        	  
              $('#cmbprocess').attr("disabled",false);$('#txtremarks').attr("readonly",false);
              $('#date').jqxDateTimeInput({disabled: false});$('#btnupdate').attr("disabled",false);
        		 
        	  document.getElementById("txtempdocno").value=$('#documentsExpiry').jqxGrid('getcellvalue', rowindex1, "empdocno"); 
        	  document.getElementById("txtempid").value=$('#documentsExpiry').jqxGrid('getcellvalue', rowindex1, "empid");
        	  document.getElementById("txtbranch").value=$('#documentsExpiry').jqxGrid('getcellvalue', rowindex1, "brhid");
        	  document.getElementById("txtdocument").value=$('#documentsExpiry').jqxGrid('getcellvalue', rowindex1, "document");
        	  document.getElementById("txtdocumentid").value=$('#documentsExpiry').jqxGrid('getcellvalue', rowindex1, "docid");
        	  $('#expiryDate').val($('#documentsExpiry').jqxGrid('getcellvalue', rowindex1, "expirydate")) ; 
        	  
        	  var values= $('#documentsExpiry').jqxGrid('getcellvalue',rowindex1, "empinfo");
              
              var sum2 = values.toString().replace(/\*/g, '\n');
           
              document.getElementById("empinfo").value=sum2;
			  
              $("#detailDiv").load("detailGrid.jsp?empdocno="+$('#documentsExpiry').jqxGrid('getcellvalue', rowindex1, 'empdocno')+'&document='+$('#documentsExpiry').jqxGrid('getcellvalue', rowindex1, 'document').replace(/ /g, "%20")+'&processes=Follow-Up'+'&check=1');
           }); 
           $('#documentsExpiry').on('cellclick', function (event) 
           		{ 
           		var rowindex1=event.args.rowindex;
           			 if(event.args.datafield=="view"){
           				var docno = $('#documentsExpiry').jqxGrid('getcellvalue', rowindex1, "empdocno");
           				funEmpView(docno);
           			}else if(event.args.datafield=="attach"){
           				var brchid = $('#documentsExpiry').jqxGrid('getcellvalue', rowindex1, "brhid");
           				var docno = $('#documentsExpiry').jqxGrid('getcellvalue', rowindex1, "empdocno");
           				attachView(docno,brchid);
           			}
           		});
           
           
           function funEmpView(docno){

         	  if(docno==''){
         	    $.messager.alert('Message','Choose a document','warning');
         	    return 0;
         	   }
         	    var url=document.URL;
     		    var reurl=url.split("com/");
     			
     			window.parent.formName.value="Employee Master";
     			window.parent.formCode.value="EMP";
     			
     			var detName= "Employee Master";
     			var path= "com/humanresource/setup/employeemaster/saveEmployeeMaster.action?mode=view&docno="+docno+"&id=2";
     			top.addTab( detName,reurl[0]+""+path);
         	 }
           function attachView(docno,brchid){
				var frmdet="EMP";
        		if (docno!="") {
				   var  myWindow= window.open("<%=contextPath%>/com/common/Attachmaster.jsp?formCode="+frmdet+"&docno="+docno+"&brchid="+brchid,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
						myWindow.focus();
				} else {
					$.messager.alert('Message','Select a Document....!','warning');
					return;
			    }
           }
            
  });
                       
</script>
<div id="documentsExpiry"></div>