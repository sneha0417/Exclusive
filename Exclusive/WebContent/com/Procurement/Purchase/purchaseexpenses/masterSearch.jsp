<%@page import="com.procurement.purchase.purchaseexpenses.ClsExpDAO"%>
<% ClsExpDAO viewDAO = new ClsExpDAO(); %> 
<script type="text/javascript">
 

 var masterdata='<%=viewDAO.mastersearchFrom()%>';

  $(document).ready(function () { 	
     
      var num = 0; 
     var source =
     {
    		
    		// doc_no,date,frmdate,todate,ptlchg,deslchg
    		 
         datatype: "json",
         datafields: [
                   	{name : 'doc_no' , type: 'int' },
                    {name : 'account' , type: 'string' },
                   	{name : 'accname' , type: 'string' },
                   	{name : 'acno' , type: 'number' },
                   	{name : 'desc1' , type: 'string' },
                 
                 	
                  	
                 	
						
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
     $("#mastersearch").jqxGrid(
     {
         width: '100%',
         height: 356,
         source: dataAdapter,
         columnsresize: true,
         filterable: true,
         showfilterrow:true,
         altRows: true,
 
         filterable: true, 
         selectionmode: 'singlerow',
         pagermode: 'default',
      

         columns: [
              
			
                  //Petrol  Charge   Diesel Fuel Charge   deccharge  
                  
                  
          
                 
				{ text: 'Doc No', datafield: 'doc_no', width: '8%' },   
				{ text: 'Account', datafield: 'account', width: '12%' },
				{ text: 'Account Name', datafield: 'accname', width: '25%'   },
				{ text: 'Description', datafield: 'desc1', width: '55%' },
				{ text: 'hideaccdocno', datafield: 'acno', width: '20%',hidden:true },
 
				
				]
     });
     $('#mastersearch').on('rowdoubleclick', function (event) {


 	  var rowindex1=event.args.rowindex;

 
 
             
              document.getElementById("docno").value= $('#mastersearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
            document.getElementById("accdocno").value=$('#mastersearch').jqxGrid('getcelltext', rowindex1, "acno");  
            document.getElementById("desc1").value=$('#mastersearch').jqxGrid('getcelltext', rowindex1, "desc1"); 
             
            
            document.getElementById("acno").value=$('#mastersearch').jqxGrid('getcelltext', rowindex1, "account");  
            document.getElementById("accname").value=$('#mastersearch').jqxGrid('getcelltext', rowindex1, "accname"); 
     
              funSetlabel();
 
         $('#window').jqxWindow('close');
     	 
        
     
     		 });	 
     
     
    
    
 

 });
</script>
<div id="mastersearch"></div>

    