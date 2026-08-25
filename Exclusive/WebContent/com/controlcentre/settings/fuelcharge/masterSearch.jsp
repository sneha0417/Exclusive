
 <%@page import="com.controlcentre.settings.fuelcharge.ClsFuelChargeDAO"%>
 <%ClsFuelChargeDAO cfd=new ClsFuelChargeDAO(); %>
<script type="text/javascript">
 

 var masterdata='<%=cfd.masterSearch()%>';

  $(document).ready(function () { 	
     
      var num = 0; 
     var source =
     {
    		
    		// doc_no,date,frmdate,todate,ptlchg,deslchg
    		 
         datatype: "json",
         datafields: [
                   	{name : 'doc_no' , type: 'number' },
                   	{name : 'date' , type: 'date' },
                    {name : 'frmdate' , type: 'date' },
                   	{name : 'todate' , type: 'date' },
                   	{name : 'ptlchg' , type: 'number' },
                   	{name : 'deslchg' , type: 'number' }
                 	
                  	
                 	
						
                   	],
          localdata: masterdata,
         
         
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
     $("#fuelsearch").jqxGrid(
     {
         width: '100%',
         height: 356,
         source: dataAdapter,
         columnsresize: true,
         filterable: true,
         showfilterrow:true,
         altRows: true,
        
         selectionmode: 'singlerow',
         pagermode: 'default',
      

         columns: [
              
			
                  //Petrol  Charge   Diesel Fuel Charge   deccharge  
                 
				{ text: 'Doc No', datafield: 'doc_no', width: '15%' },
				{ text: 'Date', datafield: 'date', width: '15%',cellsformat:'dd.MM.yyyy' },
				{ text: 'From Date', datafield: 'frmdate', width: '15%' ,cellsformat:'dd.MM.yyyy' },
				{ text: 'To Date', datafield: 'todate', width: '15%' ,cellsformat:'dd.MM.yyyy' },
				{ text: 'Petrol Charge', datafield: 'ptlchg', width: '20%',cellsformat:'d2',cellsalign: 'right', align:'right' },
				{ text: 'Diesel Charge', datafield: 'deslchg', width: '20%',cellsformat:'d2',cellsalign: 'right', align:'right' },
				
				]
     });
     $('#fuelsearch').on('rowdoubleclick', function (event) {


 	  var rowindex1=event.args.rowindex;

       
      
      	// $('#jqxUserMasterDate').jqxDateTimeInput({ disabled: false});
        $('#fromdate').val($("#fuelsearch").jqxGrid('getcellvalue', rowindex1, "frmdate")) ; 
        $('#masterdate').val($("#fuelsearch").jqxGrid('getcellvalue', rowindex1, "date")) ;
        $('#todate').val($("#fuelsearch").jqxGrid('getcellvalue', rowindex1, "todate")) ;
             
              document.getElementById("docno").value= $('#fuelsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
            document.getElementById("petrolcharge").value=$('#fuelsearch').jqxGrid('getcelltext', rowindex1, "ptlchg"); 
            document.getElementById("deccharge").value=$('#fuelsearch').jqxGrid('getcelltext', rowindex1, "deslchg"); 
             
          
              funSetlabel();
 
         $('#window').jqxWindow('close');
     	/* $('#EnquiryDate').jqxDateTimeInput({ disabled: false}); */
     	
       // document.getElementById("frmUserMaster").submit();
        
        
     
     		 });	 
     
     
    
    
 

 });
</script>
<div id="fuelsearch"></div>

    