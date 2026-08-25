<%@page import="com.controlcentre.settings.companysettings.location.ClsLocationDAO"%>
<% ClsLocationDAO objloc=new ClsLocationDAO();%>
    <script type="text/javascript">
    var data= '<%=objloc.list()%>';
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'loc', type: 'String'  },
                          	{name : 'loc_name', type: 'String'  },
                          	{name : 'address',type:'String'},
                          	{name : 'tel', type:'String'},
                          	{name : 'fax', type:'String'},
                          	{name : 'email', type:'String'},
                          	{name : 'tel2', type:'String'},
                          	{name : 'fax2', type:'String'},
                          	{name : 'web', type:'String'},
                          	{name : 'brhid', type:'String'},
                          	{name : 'pbno', type:'String'},
                          	{name : 'branchname',type:'string'}
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
            $("#jqxLocationSearch").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
               // pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
               // pagermode: 'default',
                sortable: true,
                //Add row method
	
                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
					{ text: 'Location Code', datafield: 'loc', width: '20%' },
					{text: 'Location Name',datafield:'loc_name',width:'35%'},
					{ text: 'Address', datafield: 'address', width: '20%' ,hidden:true},
					{ text: 'Tel 1', datafield: 'tel', width: '20%' ,hidden:true},
					{ text: 'Fax 1', datafield: 'fax', width: '20%' ,hidden:true},
					{ text: 'Email', datafield: 'email', width: '20%' ,hidden:true},
					{ text: 'Tel 2', datafield: 'tel2', width: '20%',hidden:true },
					{ text: 'Fax 2', datafield: 'fax2', width: '20%' ,hidden:true},
					{ text: 'Website', datafield: 'web', width: '20%' ,hidden:true},
					{ text: 'Branch Id', datafield: 'brhid', width: '20%' ,hidden:true},
					{ text: 'PB No', datafield: 'pbno', width: '20%',hidden:true },
					{ text: 'Branch',datafield:'branchname',width:'35%'}

					]
            });
           
            $('#jqxLocationSearch').on('rowdoubleclick', function (event) 
            		{ 
            	var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxLocationSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("txtloccode").value=$('#jqxLocationSearch').jqxGrid('getcellvalue', rowindex1, "loc");
                document.getElementById("txtlocname").value=$('#jqxLocationSearch').jqxGrid('getcellvalue', rowindex1, "loc_name");
                document.getElementById("txtaddress").value=$('#jqxLocationSearch').jqxGrid('getcellvalue', rowindex1, "address");
                document.getElementById("txttel1").value=$('#jqxLocationSearch').jqxGrid('getcellvalue', rowindex1, "tel");
                document.getElementById("txtfax1").value=$('#jqxLocationSearch').jqxGrid('getcellvalue', rowindex1, "fax");
                document.getElementById("txtemail1").value=$('#jqxLocationSearch').jqxGrid('getcellvalue', rowindex1, "email");
                document.getElementById("txttel2").value=$('#jqxLocationSearch').jqxGrid('getcellvalue', rowindex1, "tel2");
                document.getElementById("txtfax2").value=$('#jqxLocationSearch').jqxGrid('getcellvalue', rowindex1, "fax2");
                document.getElementById("txtwebsite").value=$('#jqxLocationSearch').jqxGrid('getcellvalue', rowindex1, "web");
                document.getElementById("txtpbno").value=$('#jqxLocationSearch').jqxGrid('getcellvalue', rowindex1, "pbno");
                $('#cmbbranchname').val($("#jqxLocationSearch").jqxGrid('getcellvalue', rowindex1, "brhid")) ;
                
            	$('#window').jqxWindow('hide');
            		 }); 
      
        });
    </script>
    <div id="jqxLocationSearch"></div>
