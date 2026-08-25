<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.projectexecution.materialissue.ClsMaterialIssueDAO"%>
<% ClsMaterialIssueDAO searchDAO = new ClsMaterialIssueDAO(); %> 


 

 <%
 String aa = request.getParameter("aa")==null?"NA":request.getParameter("aa"); 
   
     String branchval =request.getParameter("branchval")==null?"0":request.getParameter("branchval").toString();
  /*    String fromdate =request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").toString();
     String todate =request.getParameter("todate")==null?"0":request.getParameter("todate").toString(); */
   String cldocno=request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").toString(); 
     String docnoss=request.getParameter("docnoss")==null?"0":request.getParameter("docnoss").toString();
    
     %>
     <style type="text/css">
    
    .colorClass
    {
        background-color: #F9E79F;
    }
 
    
</style>
 <script type="text/javascript">
 var dataas;
 
  
 dataas= '<%= searchDAO.listsearch(session,branchval,aa,cldocno,docnoss)%>';
 
 dataas1= '<%= searchDAO.listsearchex(session,branchval,aa,cldocno,docnoss)%>';
 
 
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'String'  },
     						{name : 'tr_no', type: 'String'  },
     						{name : 'client', type: 'String' },
     						{name : 'brhid', type: 'String' },
     						 	{name : 'locid', type: 'String' },
     						
     						
     						
     						{name : 'userid', type: 'String' },
     						{name : 'tr_no', type: 'String' },
     						{name : 'fdate', type: 'date' },
     						{name : 'date', type: 'date' },    
     						{name : 'view', type: 'String' },
     						{name : 'rowcolor',type:'number'}, 
     						{name : 'material',type:'String'},
     						{name : 'labour',type:'String'},
     						{name : 'machine',type:'String'},
     						{name : 'nettotal',type:'String'},
     						{name : 'path', type: 'String' },
     						{name : 'menuname', type: 'String' },
     						{name : 'dtype', type: 'String'  },
     						 {name : 'address' , type: 'String'},
     	                    {name : 'reftrno' , type: 'String' },
     	                   	{name : 'cldocno' , type: 'String' },
     	                	{name : 'reviseno' , type: 'String' },
     	                    {name : 'ref_type' , type: 'String'}, 
     	                    {name : 'refdocno' , type: 'String'}, 
     	                   {name : 'refdet', type: 'String'  },
     	                  {name : 'qotno', type: 'String'  },
     	                 {name : 'contrno', type: 'String'  },
     	                {name : 'contrtype', type: 'String'  },
     	               {name : 'contracttrno', type: 'String'  },
     	                   
                 ],
                 localdata: dataas,
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var cellclassname = function (row, column, value, data) {
            
           
                  };
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxProcFolGrid").jqxGrid(
            {
                width: '99.5%',
                height: 250,
                source: dataAdapter,
                columnsresize: true,
                columnsresize: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                //pagermode: 'default',
                sortable: true,
                //Add row method
                columns: [ 
{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
    groupable: false, draggable: false, resizable: false,datafield: '',
    columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',cellclassname: cellclassname,
    cellsrenderer: function (row, column, value) {
  	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
    }  
	},
	    
	{ text: 'Doc No', datafield: 'doc_no', width: '10%',cellclassname:cellclassname },
	
	{ text: 'locid', datafield: 'locid', width: '10%',cellclassname:cellclassname,hidden:true },
	
	
	 
	{ text: 'Ref Details',  datafield: 'refdet', width: '10%',cellclassname:cellclassname,hidden:true },
	{ text: 'Date', datafield: 'date', width: '10%' ,cellclassname:cellclassname,cellsformat:'dd.MM.yyyy'},
	{ text: 'Quotation No.', datafield: 'qotno', width: '10%',cellclassname:cellclassname },
	{ text: 'Contract No.', datafield: 'contrno', width: '10%',cellclassname:cellclassname },
	{ text: 'Contract Type', datafield: 'contrtype', width: '10%',cellclassname:cellclassname },
//	{ text: 'Site', datafield: 'site', width: '12%',cellclassname:cellclassname },
	
	{ text: 'Client Name', datafield: 'client' ,cellclassname:cellclassname },
	{ text: 'Material Total', datafield: 'material', width: '10%',cellclassname:cellclassname,hidden:true },
	{ text: 'Labour Total', datafield: 'labour', width: '10%',cellclassname:cellclassname,hidden:true },
	{ text: 'Machine Total', datafield: 'machine', width: '10%',cellclassname:cellclassname,hidden:true },
 
 
  
					{ text: 'Tr No',  datafield: 'tr_no', width: '10%' ,hidden:true},
					{ text: 'Brnch Id',  datafield: 'brhid', width: '10%' ,hidden:true}, 
					{ text: 'User Id',  datafield: 'userid', width: '10%' ,hidden:true},
					{ text: 'Path',  datafield: 'path', hidden: true, width: '5%' },
					{ text: 'name',  datafield: 'menuname', hidden: true, width: '5%' },
					{ text: 'Doc Type',  datafield: 'dtype', width: '5%', hidden: true },
					{ text: 'RefType', datafield: 'ref_type', width: '15%',hidden:true },
					{ text: 'RefDocNo', datafield: 'refdocno', width: '20%',hidden:true},
					{ text: 'cldocno', datafield: 'cldocno', width: '15%',hidden:true },
					{ text: 'reviseno', datafield: 'reviseno', width: '20%',hidden:true },
					{ text: 'refdocno', datafield: 'reftrno', width: '17%',hidden:true  },
					{ text: 'address', datafield: 'address', width: '17%',hidden:true },
					{ text: 'contracttrno', datafield: 'contracttrno', width: '17%',hidden:true },
	              ]
            });
      
            
            $('#jqxProcFolGrid').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
           	 $("#updatdata").attr('disabled', false );
        	 var barchval = $('#jqxProcFolGrid').jqxGrid('getcellvalue', rowindex1, "brhid");
        	 
        	 var locid = $('#jqxProcFolGrid').jqxGrid('getcellvalue', rowindex1, "locid");
        	 var tr_no=$('#jqxProcFolGrid').jqxGrid('getcellvalue', rowindex1, "tr_no");
        	 var docno=0;
        	 document.getElementById("masterdocno").value=tr_no;
        	 
        	 
        	 
        	
        	  
        	   $("#overlay, #PleaseWait").show(); 
         	  $("#sublistdiv").load("sublistGrid.jsp?barchvals="+barchval+"&docno="+docno+"&locid="+locid+"&tr_no="+tr_no);
                
                
            }); 
             
            
               $("#overlay, #PleaseWait").hide();
               
               
 
            
                
        });
    </script>
    <div id="jqxProcFolGrid"></div>
