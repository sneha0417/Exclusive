<%@page import="com.realestate.tenantrequest.ClsTenantRequestDAO" %> 
<%@page import="javax.servlet.http.HttpServletRequest" %>    
<%@page import="javax.servlet.http.HttpSession" %>        
<%
	 ClsTenantRequestDAO cud=new ClsTenantRequestDAO(); 
	 String unitno = request.getParameter("unitno")==null || request.getParameter("unitno")==""?"0":request.getParameter("unitno");
	 String property = request.getParameter("property")==null ?"":request.getParameter("property");
	 String tenant = request.getParameter("tenant")==null ?"":request.getParameter("tenant");
	 String docno = request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno");
	 String date = request.getParameter("date")==null || request.getParameter("date")==""?"0":request.getParameter("date");
	 String id = request.getParameter("id")==null ?"":request.getParameter("id");  
 %>      
<script type="text/javascript">
  
	var  data1= '<%= cud.requestMainSearch(session,property,tenant,docno,date,id,unitno) %>'; 
        
  		$(document).ready(function (){ 	
            var source =  
            {
                datatype: "json",
                datafields: [
                          	{name : 'address' , type: 'String' },
     						{name : 'tenant', type: 'String'  },
     						{name : 'job', type: 'String'  },
     						{name : 'amount', type: 'String'  }, 
     						{name : 'pdocno', type: 'int'  },
     						{name : 'tdoc_no', type: 'int'  },
     						{name : 'voc_no', type: 'int'  },
     						{name : 'doc_no', type: 'int'  },
     						{name : 'date', type: 'date'  },
     						{name : 'reimbursement', type: 'String'  },    
     						{name : 'unitno', type: 'String'  },
     						{name : 'sourceid', type: 'String'  },   
     						{name : 'txtsource', type: 'String'  },   
     						{name : 'brhid', type: 'String'  },   
                 ],
               localdata: data1,
               
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
            $("#jqxrequestSearch").jqxGrid(
            {
            	width: '100%',
                height: 300,
                source: dataAdapter,
                selectionmode: 'singlerow',
                editable: false,
                columnsresize: true,
                
                columns: [
					{ text: 'Doc No',  datafield: 'voc_no', width: '10%' },
					{ text: 'Date',  datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
					{ text: 'Unit No', datafield: 'unitno', width: '5%' },
					{ text: 'Property', datafield: 'address' },
					{ text: 'Tenant', datafield: 'tenant', width: '15%' },     
					{ text: 'Job', datafield: 'job', width: '40%' , hidden: true},
					{ text: 'Amount', datafield: 'amount', width: '10%', hidden: true },
					{ text: 'sourceid', datafield: 'sourceid', width: '10%', hidden: true },
					{ text: 'txtsource', datafield: 'txtsource', width: '10%', hidden: true },
					{ text: 'reimbursement', datafield: 'reimbursement', width: '10%', hidden: true },
					{ text: 'brhid', datafield: 'brhid', width: '10%', hidden: true },
					{ text: 'Pdoc No', hidden: true, datafield: 'pdocno', width: '5%' },
					{ text: 'Tdoc No', hidden: true, datafield: 'tdoc_no', width: '5%' },
					{ text: 'doc no', hidden: true, datafield: 'doc_no', width: '7%' },
	              ]
            });
            
            $('#jqxrequestSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("sourceid").value= $('#jqxrequestSearch').jqxGrid('getcellvalue', rowindex1, "sourceid");
                document.getElementById("txtsource").value= $('#jqxrequestSearch').jqxGrid('getcellvalue', rowindex1, "txtsource");
                document.getElementById("hidbrhid").value= $('#jqxrequestSearch').jqxGrid('getcellvalue', rowindex1, "brhid");
				$('#frmMaintenanceRequest select').attr('disabled', false);  
			    $('#jqxDate').val($('#jqxrequestSearch').jqxGrid('getcellvalue', rowindex1, "date"));
			    document.getElementById("hidchkrbsmnt").value= $('#jqxrequestSearch').jqxGrid('getcellvalue', rowindex1, "reimbursement");
			    document.getElementById("txtproperty").value= $('#jqxrequestSearch').jqxGrid('getcellvalue', rowindex1, "address");
                document.getElementById("txtpropertydocno").value= $('#jqxrequestSearch').jqxGrid('getcellvalue', rowindex1, "pdocno");
                document.getElementById("txttenant").value= $('#jqxrequestSearch').jqxGrid('getcellvalue', rowindex1, "tenant");
                document.getElementById("txttenantdocno").value= $('#jqxrequestSearch').jqxGrid('getcellvalue', rowindex1, "tdoc_no");
                document.getElementById("vdocno").value= $('#jqxrequestSearch').jqxGrid('getcellvalue', rowindex1, "voc_no");  
                document.getElementById("docno").value= $('#jqxrequestSearch').jqxGrid('getcellvalue', rowindex1, "voc_no");
            /*  $('#jqxDate').jqxDateTimeInput({disabled: false});   
                $('#jqxBirthDate').jqxDateTimeInput({disabled: false});
                $('#jqxexpiryDate').jqxDateTimeInput({disabled: false}); */
                 
				setValues();
            
                $('#window').jqxWindow('close');
               // document.getElementById("frmMaintenanceRequest").submit();
            }); 
        });
  		
</script>

<div id="jqxrequestSearch"></div>
