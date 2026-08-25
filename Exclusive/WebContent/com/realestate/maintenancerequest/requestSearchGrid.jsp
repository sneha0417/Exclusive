<%@page import="com.realestate.maintenancerequest.ClsMaintenanceRequestDAO" %>
<%
 ClsMaintenanceRequestDAO cud=new ClsMaintenanceRequestDAO(); 
 String property = request.getParameter("property")==null ?"":request.getParameter("property");
 String tenant = request.getParameter("tenant")==null ?"":request.getParameter("tenant");
 String id = request.getParameter("id")==null ?"":request.getParameter("id");
 %>
<script type="text/javascript">
  
	var  data1= '<%= cud.requestMainSearch(property,tenant,id) %>'; 
        
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
     						{name : 'doc_no', type: 'int'  }
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
					{ text: 'Address', datafield: 'address', width: '30%' },
					{ text: 'Job Provider', datafield: 'tenant', width: '20%' },
					{ text: 'Job', datafield: 'job', width: '40%' },
					{ text: 'Amount', datafield: 'amount', width: '10%' },
					{ text: 'Pdoc No', hidden: true, datafield: 'pdocno', width: '5%' },
					{ text: 'Tdoc No', hidden: true, datafield: 'tdoc_no', width: '5%' },
					{ text: 'voc no', hidden: true, datafield: 'voc_no', width: '5%' },
					{ text: 'doc no', hidden: true, datafield: 'doc_no', width: '5%' }
	              ]
            });
            
            $('#jqxrequestSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
				
				$('#frmMaintenanceRequest select').attr('disabled', false);
			
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
