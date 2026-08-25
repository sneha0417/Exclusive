<%@page import="com.controlcentre.settings.usermaster.ClsUserMasterDAO" %>
<%ClsUserMasterDAO cud=new ClsUserMasterDAO(); %>

 <script type="text/javascript">
 

 var masterdata='<%=cud.searchMaster(session)%>';

  $(document).ready(function () { 	
     
      var num = 0; 
     var source =
     {
    		
    		 
    		 
         datatype: "json",
         datafields: [
                   	{name : 'doc_no' , type: 'number' },
                   	{name : 'user_id' , type: 'string' },
                    {name : 'user_name' , type: 'String' },
                   	{name : 'role_id' , type: 'String' },
                   	{name : 'email' , type: 'String' },
                   	{name : 'permission' , type: 'String' },
                 	{name : 'lang' , type: 'String' },
                 	{name : 'user_role' , type: 'string' },
                	{name : 'pass' , type: 'string' },
                	{name : 'date' , type: 'date'},
                 	{name : 'ulevel' , type: 'number'},
                 	{name : 'mailpass' , type: 'string' },
                	{name : 'signature' , type: 'string' }
                  	
                 	
						
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
     $("#usermasterSearch").jqxGrid(
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
              
			
	
                 
				{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
				{ text: 'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
				{ text: 'User ID', datafield: 'user_id', width: '20%' },
				{ text: 'User Name', datafield: 'user_name', width: '25%' },
				{ text: 'User Role', datafield: 'user_role', width: '35%' },
				{ text: 'Email', datafield: 'email', width: '20%',hidden:true},
				{ text: 'role_id', datafield: 'role_id', width: '15%',hidden:true },
				{ text: 'permission', datafield: 'permission', width: '20%',hidden:true },
				{ text: 'pass', datafield: 'pass', width: '20%',hidden:true },
				{ text: 'lang', datafield: 'lang', width: '20%',hidden:true },
				{ text: 'ulevel', datafield: 'ulevel', width: '20%',hidden:true },
				
				]
     });
     $('#usermasterSearch').on('rowdoubleclick', function (event) {


 	  var rowindex1=event.args.rowindex;
       $('#cmpermission').attr('disabled',false);
       $('#cmblanguage').attr('disabled',false);
       $('#levels').attr('disabled',false);
       
      
      	$('#jqxUserMasterDate').jqxDateTimeInput({ disabled: false});
        $('#jqxUserMasterDate').val($("#usermasterSearch").jqxGrid('getcellvalue', rowindex1, "date")) ; 
             
              document.getElementById("docno").value= $('#usermasterSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
              //document.getElementById("txtuser").value=$('#usermasterSearch').jqxGrid('getcellvalue', rowindex1, "user_id");
            /*  
            document.getElementById("txtusername").value=$('#usermasterSearch').jqxGrid('getcellvalue', rowindex1, "user_name"); 
              document.getElementById("txtbrole").value= $('#usermasterSearch').jqxGrid('getcellvalue', rowindex1, "user_role");
                       
              document.getElementById("txtroleid").value=$('#usermasterSearch').jqxGrid('getcellvalue', rowindex1, "role_id");
      
              document.getElementById("txtusermail").value=$('#usermasterSearch').jqxGrid('getcellvalue', rowindex1, "email");
              
              document.getElementById("txtuserpassword").value=$('#usermasterSearch').jqxGrid('getcellvalue', rowindex1, "pass");
              document.getElementById("txtpasswordconfirm").value=$('#usermasterSearch').jqxGrid('getcellvalue', rowindex1, "pass");
              
              document.getElementById("cmpermission").value=$('#usermasterSearch').jqxGrid('getcellvalue', rowindex1, "permission");
              document.getElementById("cmblanguage").value=$('#usermasterSearch').jqxGrid('getcellvalue', rowindex1, "lang");
              document.getElementById("levels").value=$('#usermasterSearch').jqxGrid('getcellvalue', rowindex1, "ulevel"); */
              document.getElementById("frmUserMaster").submit();
              funSetlabel();
 
         $('#window').jqxWindow('close');
     	/* $('#EnquiryDate').jqxDateTimeInput({ disabled: false}); */
     	
         document.getElementById("frmUserMaster").submit();
        
        
     
     		 });	 
     
     
    
    
 

 });
</script>
<div id="usermasterSearch"></div>

    