<%@page import="com.controlcentre.masters.salesmanmaster.salesagent.ClsSalesAgentAction" %>
<%ClsSalesAgentAction csa =new ClsSalesAgentAction(); %>
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
                          	{name : 'description', type: 'String'  },
                          	{name : 'mobile',type:'String'},
                          	{name : 'mail',type:'String'},
							{name : 'active',type:'String'},
							{name : 'hidactive',type:'String'}
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
            
            $("#jqxSalesAgentSearch").jqxGrid(
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
					{ text: 'Name', datafield: 'sal_name', width: '35%' },
					{ text: 'Acc No', datafield: 'acc_no', width: '40%',hidden:true },
					{ text: 'Account Name', datafield: 'description' },
					{ text: 'Mobile',datafield:'mobile', width: '40%',hidden:true },
					{ text: 'Mail',datafield:'mail', width: '40%',hidden:true },
					{ text: 'Status',columntype: 'textbox', filtertype: 'input', datafield: 'active', width: '10%' },
					{ text: 'hidactive', datafield: 'hidactive',hidden:true },

					]
            });
            
            $('#jqxSalesAgentSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxSalesAgentSearch').jqxGrid('getcellvalue', rowindex1, "DOC_NO"); 
                document.getElementById("txtaccno").value = $("#jqxSalesAgentSearch").jqxGrid('getcellvalue', rowindex1, "acc_no");
                document.getElementById("txtaccname").value = $("#jqxSalesAgentSearch").jqxGrid('getcellvalue', rowindex1, "description");
                document.getElementById("code").value = $("#jqxSalesAgentSearch").jqxGrid('getcellvalue', rowindex1, "sal_code");
                document.getElementById("name").value = $("#jqxSalesAgentSearch").jqxGrid('getcellvalue', rowindex1, "sal_name");
                document.getElementById("mobile").value = $("#jqxSalesAgentSearch").jqxGrid('getcellvalue', rowindex1, "mobile");
                document.getElementById("mail").value = $("#jqxSalesAgentSearch").jqxGrid('getcellvalue', rowindex1, "mail");
                $("#salesagentdate").jqxDateTimeInput('val', $("#jqxSalesAgentSearch").jqxGrid('getcellvalue', rowindex1, "date"));
				document.getElementById("cmbactivestatus").value = $("#jqxSalesAgentSearch").jqxGrid('getcellvalue', rowindex1, "hidactive");
            
                $('#window').jqxWindow('close');
            }); 
         
        });
    </script>
    <div id="jqxSalesAgentSearch"></div>
