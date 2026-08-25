<%@page import="com.controlcentre.settings.companysettings.company.ClsCompanyDAO"%>
<%ClsCompanyDAO companydao=new ClsCompanyDAO();%>
    <script type="text/javascript">
    var data= '<%=companydao.getSearchData()%>';
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'comp_id', type: 'String'  },
                          	{name : 'company', type: 'String'  },
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
                          	{name : 'pbno', type:'String'},
                          	{name : 'timezoneid',type:'string'}
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
            $("#jqxCompanySearch").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                //pagermode: 'default',
                sortable: true,
                //Add row method
	
                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
					{ text: 'Company', datafield: 'comp_id', width: '30%' },
					{text: 'Company Name',datafield:'company',width:'60%'},
					{ text: 'Address', datafield: 'address', width: '20%',hidden:true },
					{ text: 'Tel', datafield: 'tel', width: '20%',hidden:true },
					{ text: 'Fax', datafield: 'fax', width: '20%',hidden:true },
					{ text: 'Ac period 1', datafield: 'accyear_f', width: '20%',hidden:true },
					{ text: 'Ac period 2', datafield: 'accyear_t', width: '20%' ,hidden:true},
					{ text: 'Email', datafield: 'email', width: '20%',hidden:true },
					{ text: 'Currency', datafield: 'curid', width: '20%',hidden:true },
					{ text: 'Tel 2', datafield: 'tel2', width: '20%',hidden:true },
					{ text: 'Fax 2', datafield: 'fax2', width: '20%' ,hidden:true},
					{ text: 'Web', datafield: 'web', width: '20%' ,hidden:true},
					{ text: 'Pbno', datafield: 'pbno', width: '20%',hidden:true },
					{ text: 'Timezone', datafield: 'timezoneid', width: '20%',hidden:true },

					]
            });
           
            $('#jqxCompanySearch').on('rowdoubleclick', function (event) {
                
            	var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxCompanySearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("txtcompid").value=$('#jqxCompanySearch').jqxGrid('getcellvalue', rowindex1, "comp_id");
                document.getElementById("txtcompname").value=$('#jqxCompanySearch').jqxGrid('getcellvalue', rowindex1, "company");
                document.getElementById("txtaddress").value=$('#jqxCompanySearch').jqxGrid('getcellvalue', rowindex1, "address");
                document.getElementById("txttel1").value=$('#jqxCompanySearch').jqxGrid('getcellvalue', rowindex1, "tel");
                document.getElementById("txtfax1").value=$('#jqxCompanySearch').jqxGrid('getcellvalue', rowindex1, "fax");
                document.getElementById("txtemail1").value=$('#jqxCompanySearch').jqxGrid('getcellvalue', rowindex1, "email");
                document.getElementById("txttel2").value=$('#jqxCompanySearch').jqxGrid('getcellvalue', rowindex1, "tel2");
                document.getElementById("txtfax2").value=$('#jqxCompanySearch').jqxGrid('getcellvalue', rowindex1, "fax2");
                document.getElementById("txtwebsite").value=$('#jqxCompanySearch').jqxGrid('getcellvalue', rowindex1, "web");
                document.getElementById("txtpbno").value=$('#jqxCompanySearch').jqxGrid('getcellvalue', rowindex1, "pbno");
                $('#cmbcurr').val($("#jqxCompanySearch").jqxGrid('getcellvalue', rowindex1, "curid")) ;
                $('#cmbtimezone').val($("#jqxCompanySearch").jqxGrid('getcellvalue', rowindex1, "timezoneid"));
                $("#compaccdate1").jqxDateTimeInput('val',$("#jqxCompanySearch").jqxGrid('getcellvalue', rowindex1, "accyear_f"));
                $("#compaccdate2").jqxDateTimeInput('val',$("#jqxCompanySearch").jqxGrid('getcellvalue', rowindex1, "accyear_t"));
                $('#window').jqxWindow('close');
            }); 
            
      
        });
    </script>
    <div id="jqxCompanySearch"></div>
