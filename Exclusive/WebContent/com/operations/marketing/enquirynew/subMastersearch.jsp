<%-- <%
String item = request.getParameter("item")==null?"NA":request.getParameter("item");

%> --%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %> 
<%@page import="com.operations.marketing.enquirynew.ClsEnquiryDAO"%> 
<%
ClsEnquiryDAO DAO= new ClsEnquiryDAO();
String msdocno = request.getParameter("msdocno")==null?"0":request.getParameter("msdocno");
String Cl_names = request.getParameter("Cl_names")==null?"0":request.getParameter("Cl_names");
 String Cl_mobno = request.getParameter("Cl_mobno")==null?"0":request.getParameter("Cl_mobno");
 String enqdate = request.getParameter("enqdate")==null?"0":request.getParameter("enqdate");
 
 String enqtype = request.getParameter("enqtype")==null?"0":request.getParameter("enqtype").trim(); 

 String cntrtype = request.getParameter("cntrtype")==null?"0":request.getParameter("cntrtype");
 String Cl_site = request.getParameter("Cl_site")==null?"0":request.getParameter("Cl_site");
 String Cl_area = request.getParameter("Cl_area")==null?"0":request.getParameter("Cl_area");

%> 

 <script type="text/javascript">
 
 var enqmasterdata; 
 

  enqmasterdata='<%=DAO.searchMaster(session,msdocno,Cl_names,Cl_mobno,enqdate,enqtype,Cl_site,Cl_area,cntrtype)%>' ;

  $(document).ready(function () { 	
     
      var num = 0; 
     var source =
     {
     		
         datatype: "json",
         datafields: [
                   	{name : 'doc_no' , type: 'number' },
                   	{name : 'date' , type: 'date' },
                    {name : 'cldocno' , type: 'String' },
                   	{name : 'name' , type: 'String' },
                   	{name : 'email' , type: 'String' },
                   	{name : 'com_add1' , type: 'String' },
                 	{name : 'mob' , type: 'String' },
                 	{name : 'enqtype' , type: 'Int' },
                    {name : 'remarks' , type: 'String'},  
                    {name : 'sourceid' , type: 'String'},
                    {name : 'source' , type: 'String'},
                    {name : 'cpersonid' , type: 'String'},
                    {name : 'cperson' , type: 'String'},  
                    {name : 'telno' , type: 'String'},
                    {name : 'contrmode' , type: 'String'},
                    {name : 'voc_no' , type: 'number'},  	
                    {name : 'sjobtype' , type: 'number'},
                    {name : 'surveyed' , type: 'number'},
                    {name : 'enqstatus' , type: 'number'},
			  {name : 'site' , type: 'String'},
                    {name : 'area' , type: 'String'},			
                   	],
          localdata: enqmasterdata,
         
         
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
     $("#subEnqirySearch").jqxGrid(
     {
         width: '100%',
         height: 280,
         source: dataAdapter,
         columnsresize: true,
       
         altRows: true,
        
         selectionmode: 'singlerow',
         pagermode: 'default',
      

         columns: [
              
                 { text: 'Doc No', datafield: 'voc_no', width: '10%' },
				{ text: 'Date', datafield: 'date', width: '15%',cellsformat:'dd.MM.yyyy' },
				{ text: 'Cldocno', datafield: 'cldocno', width: '20%',hidden:true },
				{ text: 'Name', datafield: 'name', width: '25%' },
				{ text: 'Address', datafield: 'com_add1', width: '35%' },
				{ text: 'Email', datafield: 'email', width: '20%',hidden:true },
				{ text: 'MOB', datafield: 'mob', width: '15%' },
				{ text: 'Contract Type', datafield: 'contrmode', width: '15%'},
				{ text: 'Site', datafield: 'site', width: '15%' },
				{ text: 'Area', datafield: 'area', width: '15%' },
				{ text: 'enqtype', datafield: 'enqtype', width: '20%',hidden:true },
				{ text: 'Remarks', datafield: 'remarks', width: '20%',hidden:true },
				{ text: 'telno', datafield: 'telno', width: '20%',hidden:true },
				{ text: 'docno', datafield: 'doc_no', width: '20%',hidden:true },
				{ text: 'sourceid', datafield: 'sourceid', width: '20%',hidden:true },
				
				{ text: 'source', datafield: 'source', width: '20%',hidden:true },
				{ text: 'sjobtype', datafield: 'sjobtype', width: '20%',hidden:true },  
				{ text: 'surveyed', datafield: 'surveyed', width: '20%',hidden:false},
				{ text: 'enqstatus', datafield: 'enqstatus', width: '20%',hidden:true },		
				]
     });
     

     $('#subEnqirySearch').on('rowdoubleclick', function (event) 
     		{ 
 	  var rowindex1=event.args.rowindex;
     	
     	
 	 var cldocnval=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "enqtype");
      
   	$('#EnquiryDate').jqxDateTimeInput({ disabled: false});
       $('#EnquiryDate').val($("#subEnqirySearch").jqxGrid('getcellvalue', rowindex1, "date")) ;
              document.getElementById("txtaddress").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "com_add1"); 
              document.getElementById("masterdoc_no").value= $('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
              document.getElementById("docno").value= $('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "voc_no");
              
              
              document.getElementById("cmbclient").value= $('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
                       
              document.getElementById("txtclientname").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "name");
              document.getElementById("hidradio").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "contrmode");
              document.getElementById("txtemail").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "email");
              document.getElementById("txtmobile").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "mob");
              document.getElementById("txtRemarks").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "remarks");
              document.getElementById("txttelno").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "telno");
              document.getElementById("txtsource").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "source");
              document.getElementById("sourceid").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "sourceid");
              document.getElementById("txtcontact").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "cperson");
              document.getElementById("cpersonid").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "cpersonid");
              document.getElementById("hidsurvey").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "surveyed");
              var rdo=document.getElementById("hidradio").value;
              var sjobtype=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "sjobtype");
             
      		if(rdo=='AMC'){
      			document.getElementById("c1").checked=true;
      			
      		}
      		if(rdo=='SJOB'){
      			document.getElementById("c2").checked=true;
      			if(sjobtype>0){
         			 document.getElementById("hidcmbprocess").value=sjobtype;
         			}
      		}
              
              document.getElementById("gridval").value=1;
       
              var enqstatus= $('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "enqstatus");
              
              if(enqstatus>0)
           	   {
             
           	   document.getElementById("hidenqedit").value="1";
         
           	   }
              else
       	   {
            
       	   document.getElementById("hidenqedit").value="0";
       	   }
              
              
         $('#window').jqxWindow('close');
     	$('#EnquiryDate').jqxDateTimeInput({ disabled: false});
     	
     	
     	
         document.getElementById("frmEnquiry").submit();
        
        
     
     		 });	 
     
     
    
    
 

 });
</script>
<div id="subEnqirySearch"></div>

    
    </body>
</html>
