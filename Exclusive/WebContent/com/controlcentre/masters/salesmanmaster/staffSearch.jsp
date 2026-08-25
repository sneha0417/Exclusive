<%@page import="com.controlcentre.masters.salesmanmaster.staff.ClsStaffAction" %>
<%ClsStaffAction csa=new ClsStaffAction(); %>
<script type="text/javascript">
  		
  		var data= '<%=csa.searchDetails() %>';
        
  		$(document).ready(function () { 	
             
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'DOC_NO' , type: 'number' },
     						{name : 'sal_code', type: 'String'  },
                          	{name : 'sal_name', type: 'String'  },
                          	{name : 'date', type: 'String'  },
                          	{name : 'acc_no', type: 'String'  },
                          	{name : 'mail',type:'String'},
                          	{name : 'description', type: 'String'  }
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
            $("#jqxStaffSearch").jqxGrid(
            {
            	width: '100%',
                height: 340,
                source: dataAdapter,
                sortable: true,
                filtermode:'excel',
                filterable: true,
                selectionmode: 'singlerow',
                columnsresize: true,
                showfilterrow:true,
                
                columns: [
					{ text: 'Doc No', datafield: 'DOC_NO', width: '10%' },
					{ text: 'Code', datafield: 'sal_code', width: '15%' },
					{ text: 'Name', datafield: 'sal_name', width: '40%' },
					{ text: 'Acc No', datafield: 'acc_no', width: '40%',hidden:true },
					{ text: 'Account Name', datafield: 'description', width: '35%' },
					{ text: 'Mail',datafield:'mail',width:'35%',hidden:true}

					]
            });
            $('#jqxStaffSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxStaffSearch').jqxGrid('getcellvalue', rowindex1, "DOC_NO"); 
                document.getElementById("txtaccno").value = $("#jqxStaffSearch").jqxGrid('getcellvalue', rowindex1, "acc_no");
                document.getElementById("txtaccname").value = $("#jqxStaffSearch").jqxGrid('getcellvalue', rowindex1, "description");
                document.getElementById("code").value = $("#jqxStaffSearch").jqxGrid('getcellvalue', rowindex1, "sal_code");
                document.getElementById("name").value = $("#jqxStaffSearch").jqxGrid('getcellvalue', rowindex1, "sal_name");
                document.getElementById("mail").value = $("#jqxStaffSearch").jqxGrid('getcellvalue', rowindex1, "mail");
                var code=$('#formdetailcode').val().trim();
                var doc=document.getElementById("docno").value;
                if(document.getElementById("docno").value>0){
                	$('#staffdiv').load("driver2.jsp?docno="+doc+"&dtype="+code);
                }

                $("#staffdate").jqxDateTimeInput('val', $("#jqxStaffSearch").jqxGrid('getcellvalue', rowindex1, "date"));
                
                $('#window').jqxWindow('hide');
            }); 
         
        });
</script>
<div id="jqxStaffSearch"></div>
