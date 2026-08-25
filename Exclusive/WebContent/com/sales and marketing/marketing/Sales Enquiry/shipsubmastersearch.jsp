<%@page import="com.sales.marketing.salesenquiry.ClsSalesEnquiryDAO"%>
<%
	ClsSalesEnquiryDAO DAO = new ClsSalesEnquiryDAO();
%>


<%

String clname = request.getParameter("clname")==null?"0":request.getParameter("clname");
String mob = request.getParameter("mob")==null?"0":request.getParameter("mob");

%>


<script type="text/javascript">
 

 var masterdata='<%=DAO.shipsearchFrom(clname,mob)%>';

  $(document).ready(function () { 	
     
      var num = 0; 
     var source =
     {
    		
    		 
    		 
         datatype: "json",
         datafields: [
                     	{name : 'doc_no' , type: 'int' },
                        {name : 'type' ,type: 'int' },
                       	{name : 'cldocno' , type: 'int' },
                       	{name : 'clname' , type: 'string' },
                       	{name : 'claddress' , type: 'string' },
                     
                       	{name : 'tel' , type: 'string' },
                      	{name : 'contactperson' , type: 'string' },
                      	{name : 'mob' , type: 'string' },
                    	{name : 'email' , type: 'string' },
                    	{name : 'fax' , type: 'string' },
             
						
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
         height: 278,
         source: dataAdapter,
         columnsresize: true,
          
         altRows: true,
        
         selectionmode: 'singlerow',
         pagermode: 'default',
      

         columns: [
              
			
                  //Petrol  Charge   Diesel Fuel Charge   deccharge  
                  
   
                  
    				{ text: 'Doc No', datafield: 'doc_no', width: '10%' },   
    				{ text: 'Name', datafield: 'clname', width: '25%' },
    				{ text: 'Address', datafield: 'claddress', width: '45%'   },
    				{ text: 'Mob', datafield: 'mob', width: '20%' },
    				 
  				 
 
				
				]
     });
     $('#mastersearch').on('rowdoubleclick', function (event) {


 	  var rowindex1=event.args.rowindex;

 
 	  
 	   
 	 
 	/*         if($('#mastersearch').jqxGrid('getcellvalue', rowindex1, "type")>0)
 	        	{
 	        	$('#chkcllient').attr('disabled', false );
 	        	$('#cldocno').attr('disabled', false );
 	        	 document.getElementById("chkcllient").checked=true;
 	        	 document.getElementById("chkcllient").value=1;
 	           	 document.getElementById("cldocno").value=$('#mastersearch').jqxGrid('getcelltext', rowindex1, "cldocno"); 
 	          	 document.getElementById("hidechkcllient").value=1; 
 	           
 	            
 	           $('#chkcllient').attr('disabled', true );
 	          $('#cldocno').attr('disabled', true );
 	        	}
 	        else
 	        	{
 	        	$('#cldocno').attr('disabled', false );
 	       	 document.getElementById("chkcllient").checked=false;
 	       	 document.getElementById("hidechkcllient").value=0; 
 	     	 document.getElementById("chkcllient").value=0;
 	    	 document.getElementById("cldocno").value=""; 
 	    	$('#cldocno').attr('disabled', true );
 	     	 
 	        	} */
 	 
              document.getElementById("shipdocno").value= $('#mastersearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
         
              
            
              
            document.getElementById("shipto").value=$('#mastersearch').jqxGrid('getcelltext', rowindex1, "clname"); 
             
            
            document.getElementById("shipaddress").value=$('#mastersearch').jqxGrid('getcelltext', rowindex1, "claddress");  
            document.getElementById("contactperson").value=$('#mastersearch').jqxGrid('getcelltext', rowindex1, "contactperson"); 
            
            document.getElementById("shipemail").value=$('#mastersearch').jqxGrid('getcelltext', rowindex1, "email"); 
            document.getElementById("shiptelephone").value=$('#mastersearch').jqxGrid('getcelltext', rowindex1, "tel"); 
            document.getElementById("shipmob").value=$('#mastersearch').jqxGrid('getcelltext', rowindex1, "mob"); 
            document.getElementById("shipfax").value=$('#mastersearch').jqxGrid('getcelltext', rowindex1, "fax"); 
            			     
           
 
 
         $('#accountSearchwindow').jqxWindow('close');
     	 
        
     
     		 });	 
     
     
    
    
 

 });
</script>
<div id="mastersearch"></div>

    