<%@page import="com.controlcentre.masters.taxMaster.ClstaxMasterDAO"%>
<%ClstaxMasterDAO taxdao=new ClstaxMasterDAO();%>
    <script type="text/javascript">
    var taxdata= '<%=taxdao.taxsearch()%>';
        $(document).ready(function () { 	
        	
        	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
                          	{name : 'tdate', type:'date'},
     						{name : 'provid', type: 'number'  },
                          	{name : 'typeid', type: 'number'  },
                          	{name : 'tax_name',type:'String'},
                          	{name : 'tax_code', type:'String'},
                          	{name : 'per', type:'number'},
                          	{name : 'cstper', type:'number'},
                          	{name : 'value', type:'String'},
                          	{name : 'fromdate', type:'date'},
                          	{name : 'todate', type:'date'},
                          	{name : 'docacno', type:'String'},
                          	{name : 'provname', type:'String'},      	
                          	{name : 'account', type:'String'},
                          	{name : 'accdescription', type:'String'},
                          	{name : 'prodtype', type:'String'},
                          	{name : 'aliace', type:'String'},
                          	{name : 'hidtype', type:'number'}
                          	
                          	],
                 localdata: taxdata,
                
                
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
            $("#jqxtaxsearch").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
               // sortable: true,
                showfilterrow: true,
                selectionmode: 'singlerow',
                //pagermode: 'default',
                sortable: true,
                filtermode:'excel',
                filterable: true,
                //Add row method
	
                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
					{ text: 'Date', datafield: 'tdate', width: '20%',cellsformat:'dd.MM.yyyy'},
					{ text: 'Province id', datafield: 'provid', width: '30%',hidden:true },
					{ text: 'Province name', datafield: 'provname', width: '20%' },
					{text: 'Product id',datafield:'typeid',width:'60%',hidden:true},
					{ text: 'Product type', datafield: 'prodtype', width: '20%'},
					{ text: 'Tax name', datafield: 'tax_name', width: '20%' },
					{ text: 'Tax code', datafield: 'tax_code', width: '20%' },
					{ text: 'Percentage', datafield: 'per', width: '20%',hidden:true },
					{ text: 'CST %', datafield: 'cstper', width: '20%',hidden:true },
					{ text: 'Applied on', datafield: 'value', width: '20%' ,hidden:true},
					{ text: 'From  date', datafield: 'fromdate', width: '20%',hidden:true,cellsformat:'dd.MM.yyyy'},
					{ text: 'To date', datafield:'todate', width: '20%',hidden:true,cellsformat:'dd.MM.yyyy'},
					{ text: 'Document account  no', datafield:'docacno', width: '20%',hidden:true },	
					{ text: 'Account  no', datafield:'account', width: '20%',hidden:true },
					{ text: 'Account description', datafield: 'accdescription', width: '20%'},
					{ text: 'Aliace', datafield:'aliace', width: '20%'},
					{ text: 'Type', datafield: 'hidtype', width: '20%',hidden:true },
					

					]
            });
           
            $('#jqxtaxsearch').on('rowdoubleclick', function (event)
            {
            	 
            	 $('#date_coun').jqxDateTimeInput({ disabled: false}); 
            	 $('#fromdate').jqxDateTimeInput({ disabled: false}); 
         		 $('#todate').jqxDateTimeInput({ disabled: false}); 
            	
            	var rowindex1=event.args.rowindex;
            	
                document.getElementById("docno").value= $('#jqxtaxsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                $('#date_coun').val($('#jqxtaxsearch').jqxGrid('getcellvalue', rowindex1, "tdate"));
                document.getElementById("txtprovince").value=$('#jqxtaxsearch').jqxGrid('getcellvalue', rowindex1, "provname");
                document.getElementById("txtprovinceid").value=$('#jqxtaxsearch').jqxGrid('getcellvalue', rowindex1, "provid");
                document.getElementById("txttypeid").value=$('#jqxtaxsearch').jqxGrid('getcellvalue', rowindex1, "typeid");
                document.getElementById("txtprotype").value=$('#jqxtaxsearch').jqxGrid('getcellvalue', rowindex1, "prodtype");
                document.getElementById("txttaxname").value=$('#jqxtaxsearch').jqxGrid('getcellvalue', rowindex1, "tax_name");
                document.getElementById("txttaxcode").value=$('#jqxtaxsearch').jqxGrid('getcellvalue', rowindex1, "tax_code");
                document.getElementById("txtpercentage").value=$('#jqxtaxsearch').jqxGrid('getcellvalue', rowindex1, "per");
                document.getElementById("txtcst").value=$('#jqxtaxsearch').jqxGrid('getcellvalue', rowindex1, "cstper");
                document.getElementById("txtappliedon").value=$('#jqxtaxsearch').jqxGrid('getcellvalue', rowindex1, "value");
                $('#fromdate').val($('#jqxtaxsearch').jqxGrid('getcellvalue', rowindex1, "fromdate"));
                $('#todate').val($('#jqxtaxsearch').jqxGrid('getcellvalue', rowindex1, "todate"));
                document.getElementById("txtaccno").value=$('#jqxtaxsearch').jqxGrid('getcellvalue', rowindex1, "docacno");
                document.getElementById("txtaccname").value=$('#jqxtaxsearch').jqxGrid('getcellvalue', rowindex1, "accdescription");
                document.getElementById("txtalice").value=$('#jqxtaxsearch').jqxGrid('getcellvalue', rowindex1, "aliace"); 
                
                var type=$('#jqxtaxsearch').jqxGrid('getcellvalue', rowindex1, "hidtype");
                if(type==1)
             	  {
             	  		 document.getElementById("prdt").checked = true;
 						/*  $('#hidtype').val("1"); */
             	  }
                else if(type==2)
          	  {
       	  		 	document.getElementById("serv").checked = true;
 					/*  $('#hidtype').val("1"); */
       	  		}
		 $('#date_coun').jqxDateTimeInput({ disabled: true}); 
          	 	 $('#fromdate').jqxDateTimeInput({ disabled: true}); 
        		 $('#todate').jqxDateTimeInput({ disabled: true}); 
             
                $('#window').jqxWindow('close');
            });  
            
      
        });
    </script>
    <div id="jqxtaxsearch"></div>