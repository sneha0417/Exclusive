<%@page import="com.controlcentre.masters.taxMasterSub.ClsTaxSubDAO"%>
<%ClsTaxSubDAO taxdao=new ClsTaxSubDAO();%>
    <script type="text/javascript">

    var taxsubdata= '<%=taxdao.taxsearch()%>';

        $(document).ready(function () { 	
        	
        	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
                          	{name : 'tdate', type:'date'},
     						{name : 'provid', type: 'number'  },
                          	
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
                          	{name : 'hidtaxid', type:'String'},
                          	{name : 'hidtype', type:'number'},
                          	{name : 'hidseqno', type:'number'},
                          	],
                 localdata: taxsubdata,
                
                
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
            $("#jqxtaxsubsearch").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                //altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                //pagermode: 'default',
               // sortable: true,
                filtermode:'excel',
                filterable: true,
                showfilterrow: true,
                //Add row method
	
                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '10%'},
					{ text: 'Date', datafield: 'tdate', width: '20%',cellsformat:'dd.MM.yyyy',hidden:true},
					{ text: 'Province id', datafield: 'provid', width: '30%',hidden:true },
					
					{ text: 'Tax name', datafield: 'tax_name', width: '20%' },
					{ text: 'Tax code', datafield: 'tax_code', width: '20%' },
					{ text: 'Province name', datafield: 'provname', width: '25%',hidden:true  },
					
					{ text: 'Percentage', datafield: 'per', width: '20%',hidden:true },
					{ text: 'CST %', datafield: 'cstper', width: '20%',hidden:true },
					{ text: 'Applied on', datafield: 'value', width: '20%',hidden:true },
					{ text: 'From  date', datafield: 'fromdate', width: '20%',hidden:true,cellsformat:'dd.MM.yyyy'},
					{ text: 'To date', datafield:'todate', width: '20%',hidden:true,cellsformat:'dd.MM.yyyy'},
					{ text: 'Document account  no', datafield:'docacno', width: '20%',hidden:true },	
					{ text: 'Account  no', datafield:'account', width: '20%',hidden:true },
					{ text: 'Account description', datafield: 'accdescription', width: '30%'},
					{ text: 'Tax id', datafield: 'hidtaxid', width: '20%' },
					{ text: 'Type', datafield: 'hidtype', width: '20%',hidden:true },
					{ text: 'Sequnce No', datafield: 'hidseqno', width: '20%',hidden:true },
					

					]
            });
           
            $('#jqxtaxsubsearch').on('rowdoubleclick', function (event)
            {
            	 
            	 $('#date_coun').jqxDateTimeInput({ disabled: false}); 
            	 $('#fromdate').jqxDateTimeInput({ disabled: false}); 
         		 $('#todate').jqxDateTimeInput({ disabled: false}); 
            	
            	var rowindex1=event.args.rowindex;
            	
                document.getElementById("docno").value= $('#jqxtaxsubsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                $('#date_coun').val($('#jqxtaxsubsearch').jqxGrid('getcellvalue', rowindex1, "tdate"));
                document.getElementById("txtprovince").value=$('#jqxtaxsubsearch').jqxGrid('getcellvalue', rowindex1, "provname");
                document.getElementById("txtprovinceid").value=$('#jqxtaxsubsearch').jqxGrid('getcellvalue', rowindex1, "provid");
              
               
                document.getElementById("txttaxname").value=$('#jqxtaxsubsearch').jqxGrid('getcellvalue', rowindex1, "tax_name");
                document.getElementById("txttaxcode").value=$('#jqxtaxsubsearch').jqxGrid('getcellvalue', rowindex1, "tax_code");
                document.getElementById("txtpercentage").value=$('#jqxtaxsubsearch').jqxGrid('getcellvalue', rowindex1, "per");
                document.getElementById("txtcst").value=$('#jqxtaxsubsearch').jqxGrid('getcellvalue', rowindex1, "cstper");
                document.getElementById("txtappliedon").value=$('#jqxtaxsubsearch').jqxGrid('getcellvalue', rowindex1, "hidtaxid"); 
                document.getElementById("hidtaxdocid").value=$('#jqxtaxsubsearch').jqxGrid('getcellvalue', rowindex1, "value"); 
                
                $('#fromdate').val($('#jqxtaxsubsearch').jqxGrid('getcellvalue', rowindex1, "fromdate"));
                $('#todate').val($('#jqxtaxsubsearch').jqxGrid('getcellvalue', rowindex1, "todate"));
                document.getElementById("txtaccno").value=$('#jqxtaxsubsearch').jqxGrid('getcellvalue', rowindex1, "docacno");
                document.getElementById("txtaccname").value=$('#jqxtaxsubsearch').jqxGrid('getcellvalue', rowindex1, "accdescription");
                
               var type=$('#jqxtaxsubsearch').jqxGrid('getcellvalue', rowindex1, "hidtype");
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
               
                document.getElementById("cmbseqno").value=$('#jqxtaxsubsearch').jqxGrid('getcellvalue', rowindex1, "hidseqno");

		 $('#date_coun').jqxDateTimeInput({ disabled: true}); 
          	 	 $('#fromdate').jqxDateTimeInput({ disabled: true}); 
        		 $('#todate').jqxDateTimeInput({ disabled: true}); 
                 
                $('#window').jqxWindow('close');
            });  
            
      
        });
    </script>
    <div id="jqxtaxsubsearch"></div>