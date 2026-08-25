<%@page import="com.controlcentre.settings.companysettings.branch.ClsBranchAction"%>
<%ClsBranchAction cba=new ClsBranchAction();%>

    <script type="text/javascript">
    var data= '<%=cba.searchDetails() %>';
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'branch', type: 'String'  },
                          	{name : 'branchname', type: 'String'  },
                          	{name : 'address',type:'String'},
                          	{name : 'tel', type:'String'},
                          	{name : 'fax', type:'String'},
                          	{name : 'accyear_f', type:'String'},
                          	{name : 'accyear_t', type:'String'},
                          	{name : 'email', type:'String'},
                          	{name : 'curid', type:'String'},
                          	{name : 'tel2', type:'String'},
                          	{name : 'fax2', type:'String'},
                          	{name : 'web', type:'String'},
                          	{name : 'cmpid', type:'String'},
                          	{name : 'pbno', type:'String'},
                          	{name : 'stcno', type:'String'},
                          	{name : 'cstno', type:'String'},
                          	{name : 'tinno', type:'String'}
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
            $("#jqxBranchSearch").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
              //  pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
              //  pagermode: 'default',
                sortable: true,
                //Add row method
	
                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
					{ text: 'Branch', datafield: 'branch', width: '30%' },
					{text: 'Branch Name',datafield:'branchname',width:'60%'},
					{ text: 'Date', datafield: 'address', width: '20%' },
					{ text: 'Date', datafield: 'tel', width: '20%' },
					{ text: 'Date', datafield: 'fax', width: '20%' },
					{ text: 'Date', datafield: 'accyear_f', width: '20%' },
					{ text: 'Date', datafield: 'accyear_t', width: '20%' },
					{ text: 'Date', datafield: 'email', width: '20%' },
					{ text: 'Date', datafield: 'curid', width: '20%' },
					{ text: 'Date', datafield: 'tel2', width: '20%' },
					{ text: 'Date', datafield: 'fax2', width: '20%' },
					{ text: 'Date', datafield: 'web', width: '20%' },
					{ text: 'Date', datafield: 'cmpid', width: '20%' },
					{ text: 'Date', datafield: 'pbno', width: '20%' },
					{ text: 'Date', datafield: 'stcno', width: '20%' },
					{ text: 'Date', datafield: 'cstno', width: '20%' },
					{ text: 'Date', datafield: 'tinno', width: '20%' }

					]
            });
           $("#jqxBranchSearch").jqxGrid('hidecolumn', 'address'); 
           $("#jqxBranchSearch").jqxGrid('hidecolumn', 'tel');
           $("#jqxBranchSearch").jqxGrid('hidecolumn', 'fax');
           $("#jqxBranchSearch").jqxGrid('hidecolumn', 'accyear_f');
           $("#jqxBranchSearch").jqxGrid('hidecolumn', 'accyear_t');
           $("#jqxBranchSearch").jqxGrid('hidecolumn', 'email');
           $("#jqxBranchSearch").jqxGrid('hidecolumn', 'curid');
           $("#jqxBranchSearch").jqxGrid('hidecolumn', 'tel2');
           $("#jqxBranchSearch").jqxGrid('hidecolumn', 'fax2');
           $("#jqxBranchSearch").jqxGrid('hidecolumn', 'web');
           $("#jqxBranchSearch").jqxGrid('hidecolumn', 'cmpid');
           $("#jqxBranchSearch").jqxGrid('hidecolumn', 'pbno');
           $("#jqxBranchSearch").jqxGrid('hidecolumn', 'stcno');
           $("#jqxBranchSearch").jqxGrid('hidecolumn', 'cstno');
           $("#jqxBranchSearch").jqxGrid('hidecolumn', 'tinno');
           
             $('#jqxBranchSearch').on('rowdoubleclick', function (event) {
                
            	var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxBranchSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("txtbranchid").value=$('#jqxBranchSearch').jqxGrid('getcellvalue', rowindex1, "branch");
                document.getElementById("txtbranchname").value=$('#jqxBranchSearch').jqxGrid('getcellvalue', rowindex1, "branchname");
                document.getElementById("txtaddress").value=$('#jqxBranchSearch').jqxGrid('getcellvalue', rowindex1, "address");
                document.getElementById("txttel1").value=$('#jqxBranchSearch').jqxGrid('getcellvalue', rowindex1, "tel");
                document.getElementById("txtfax1").value=$('#jqxBranchSearch').jqxGrid('getcellvalue', rowindex1, "fax");
                document.getElementById("txtemail1").value=$('#jqxBranchSearch').jqxGrid('getcellvalue', rowindex1, "email");
                document.getElementById("txttel2").value=$('#jqxBranchSearch').jqxGrid('getcellvalue', rowindex1, "tel2");
                document.getElementById("txtfax2").value=$('#jqxBranchSearch').jqxGrid('getcellvalue', rowindex1, "fax2");
                document.getElementById("txtwebsite").value=$('#jqxBranchSearch').jqxGrid('getcellvalue', rowindex1, "web");
                document.getElementById("txtpbno").value=$('#jqxBranchSearch').jqxGrid('getcellvalue', rowindex1, "pbno");
                document.getElementById("txtcstno").value=$('#jqxBranchSearch').jqxGrid('getcellvalue', rowindex1, "cstno");
                document.getElementById("txtstcno").value=$('#jqxBranchSearch').jqxGrid('getcellvalue', rowindex1, "stcno");
                document.getElementById("txttinno").value=$('#jqxBranchSearch').jqxGrid('getcellvalue', rowindex1, "tinno");
                $('#cmbcompname').val($("#jqxBranchSearch").jqxGrid('getcellvalue', rowindex1, "cmpid")) ;
                $('#cmbbranchcurr').val($("#jqxBranchSearch").jqxGrid('getcellvalue', rowindex1, "curid")) ;
                $("#branchaccdate1").jqxDateTimeInput('val',$("#jqxBranchSearch").jqxGrid('getcellvalue', rowindex1, "accyear_f"));
                $("#branchaccdate2").jqxDateTimeInput('val',$("#jqxBranchSearch").jqxGrid('getcellvalue', rowindex1, "accyear_t"));
                $('#window').jqxWindow('hide');
            });
      
        });
    </script>
    <div id="jqxBranchSearch"></div>
