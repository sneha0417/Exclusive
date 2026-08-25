    
  <%@page import="com.dashboard.projectexecution.procurementfollowupnew.ClsProcurementFollowupnewDAO"%>
<%
ClsProcurementFollowupnewDAO sd=new ClsProcurementFollowupnewDAO();
%>
    
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

 <%

   
     String branchval =request.getParameter("branchval")==null?"0":request.getParameter("branchval").toString();
     String fromdate =request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").toString();
     String todate =request.getParameter("todate")==null?"0":request.getParameter("todate").toString();
     String check=request.getParameter("check")==null?"0":request.getParameter("check").toString();
    
     
     %>
     <style type="text/css">
    
    .colorClass
    {
        background-color: #F9E79F;
    }
 
    
</style>
 <script type="text/javascript">
 var data,procurmentexcel;
 
 var flchk='<%=check%>';

	if(flchk!='0'){
 data= '<%= sd.loadGridData(branchval,fromdate,todate,check)%>';
 procurmentexcel= '<%= sd.loadGridDataexcel(branchval,fromdate,todate,check)%>';  
	}
	else{
		
	}
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
     	              {name : 'remarks', type: 'String'  },
     	              
     	             {name : 'itemdocno', type: 'String'  },
     	            {name : 'costranno', type: 'String'  },
     	           {name : 'prjname', type: 'String'  },
     	          {name : 'hideitemtype', type: 'String'  },
     	              
     	          
     	              
     	               
     	                   
                 ],
                 localdata: data,
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var cellclassname = function (row, column, value, data) {
           
                	if(data.rowcolor=="1"){
                		return "colorClass";
                    }
           
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
                width: '99%',
                height: 300,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlecell',
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
	    
	{ text: 'Doc No', datafield: 'doc_no', width: '6%',cellclassname:cellclassname },
	{ text: 'Ref Details',  datafield: 'refdet', width: '10%',cellclassname:cellclassname },
	{ text: 'Date', datafield: 'date', width: '7%' ,cellclassname:cellclassname,cellsformat:'dd.MM.yyyy'},
	{ text: 'Quotation No.', datafield: 'qotno', width: '7%',cellclassname:cellclassname },
	{ text: 'Contract No.', datafield: 'contrno', width: '7%',cellclassname:cellclassname },
	{ text: 'Contract Type', datafield: 'contrtype', width: '7%',cellclassname:cellclassname },
//	{ text: 'Site', datafield: 'site', width: '12%',cellclassname:cellclassname },
	
	{ text: 'Client Name', datafield: 'client', width: '36%',cellclassname:cellclassname },
	{ text: 'Material Total', datafield: 'material', width: '10%',cellclassname:cellclassname,hidden:true },
	{ text: 'Labour Total', datafield: 'labour', width: '10%',cellclassname:cellclassname,hidden:true },
	{ text: 'Machine Total', datafield: 'machine', width: '10%',cellclassname:cellclassname,hidden:true },
	{ text: 'Net Total', datafield: 'nettotal', width: '10%',cellclassname:cellclassname , cellsalign: 'right',hidden:true, align: 'right'},
	{ text: 'Followup Date', datafield: 'fdate', width: '10%',cellsformat:'dd.MM.yyyy',hidden:true ,cellclassname:cellclassname},
	{ text: '',  datafield: 'view',columntype: 'button', width: '6%',cellclassname:cellclassname },
	 { text: 'Row Color',datafield:'rowcolor',width:'10%',hidden:true,cellclassname:cellclassname},
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
					{ text: 'Remarks ', datafield: 'remarks', width: '36%',cellclassname:cellclassname },
					
					{ text: 'itemdocno ', datafield: 'itemdocno', width: '10%',cellclassname:cellclassname,hidden:true },
					{ text: 'costranno ', datafield: 'costranno', width: '10%',cellclassname:cellclassname ,hidden:true},
					{ text: 'prjname ', datafield: 'prjname', width: '10%',cellclassname:cellclassname ,hidden:true},
					{ text: 'hideitemtype ', datafield: 'hideitemtype', width: '10%',cellclassname:cellclassname,hidden:true },
					
					
					
					
			       
					
	              ]
            });
      
               $("#overlay, #PleaseWait").hide();
               
               
                $('#jqxProcFolGrid').on('celldoubleclick', function (event) { 
                	 var rowindex1=event.args.rowindex;
                	
                				var rows=$('#jqxProcFolGrid').jqxGrid('getrows');
                				for(var i=0;i<rows.length;i++){
                					$('#jqxProcFolGrid').jqxGrid('setcellvalue',i,'rowcolor','0');
                				}
                				$('#jqxProcFolGrid').jqxGrid('setcellvalue',rowindex1,'rowcolor','1');
                	$('#procurementSubGrid').jqxGrid({disabled:false});
                 	 
                       var trno=$('#jqxProcFolGrid').jqxGrid('getcellvalue', rowindex1, "tr_no");
                 	   document.getElementById("txtrdocno").value=$('#jqxProcFolGrid').jqxGrid('getcellvalue', rowindex1, "tr_no"); 
                 	   document.getElementById("txtbrchid").value=$('#jqxProcFolGrid').jqxGrid('getcellvalue', rowindex1, "brhid");
                 	   document.getElementById("txtuserid").value=$('#jqxProcFolGrid').jqxGrid('getcellvalue', rowindex1, "userid");
                 	  document.getElementById("contractdocno").value=$('#jqxProcFolGrid').jqxGrid('getcellvalue', rowindex1, "contrno");
                 	 document.getElementById("contracttrno").value=$('#jqxProcFolGrid').jqxGrid('getcellvalue', rowindex1, "contracttrno");
                 	 
                 	 
                 	 
                 	 document.getElementById("itemdocno").value=$('#jqxProcFolGrid').jqxGrid('getcellvalue', rowindex1, "itemdocno");
                 	 document.getElementById("costranno").value=$('#jqxProcFolGrid').jqxGrid('getcellvalue', rowindex1, "costranno");
                 	 document.getElementById("prjname").value=$('#jqxProcFolGrid').jqxGrid('getcellvalue', rowindex1, "prjname");
                 	  
                 	  document.getElementById("contrtypes").value=$('#jqxProcFolGrid').jqxGrid('getcellvalue', rowindex1, "contrtype");
                 	  
                 	  document.getElementById("hideitemtype").value=$('#jqxProcFolGrid').jqxGrid('getcellvalue', rowindex1, "hideitemtype");
                 	 
                 	   /* document.getElementById("txtcldocno").value=$('#jqxProcFolGrid').jqxGrid('getcellvalue', rowindex1, "cldocno");
                 	 	  */ 
                     $("#detailDiv").load("procurementFollowupSubGrid.jsp?trno="+trno+"&loadid=2");
                     }); 
                
                $('#jqxProcFolGrid').on('cellclick', function (event) 
                		{ 
    		            	var rowindex1=event.args.rowindex;
    		            	var datafield = event.args.datafield;
    		            	
    		            	 if(datafield=="view"){
    		            		 
    		            		 

    		                     var docno= $('#jqxProcFolGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
    		                     var trno=$('#jqxProcFolGrid').jqxGrid('getcellvalue', rowindex1, "tr_no");
    		                     var reviseno=$('#jqxProcFolGrid').jqxGrid('getcellvalue', rowindex1, "reviseno");
    		                     var date=$('#jqxProcFolGrid').jqxGrid('getcellvalue', rowindex1, "date");
    		                     var client=$('#jqxProcFolGrid').jqxGrid('getcellvalue', rowindex1, "client");
    		                     var cldocno=$('#jqxProcFolGrid').jqxGrid('getcellvalue', rowindex1, "cldocno");
    		                     var ref_type=$('#jqxProcFolGrid').jqxGrid('getcellvalue', rowindex1, "ref_type");
    		                     var refdocno=$('#jqxProcFolGrid').jqxGrid('getcellvalue', rowindex1, "refdocno");
    		                     var reftrno=$('#jqxProcFolGrid').jqxGrid('getcellvalue', rowindex1, "reftrno");
    		                     var address=$('#jqxProcFolGrid').jqxGrid('getcellvalue', rowindex1, "address");
    		                     var material=$('#jqxProcFolGrid').jqxGrid('getcellvalue', rowindex1, "material");
    		                     var labour=$('#jqxProcFolGrid').jqxGrid('getcellvalue', rowindex1, "labour");
    		                     var machine=parseFloat($('#jqxProcFolGrid').jqxGrid('getcellvalue', rowindex1, "machine"));
    		                     var nettotal=parseFloat($('#jqxProcFolGrid').jqxGrid('getcellvalue', rowindex1, "nettotal"));
    		         			 var path1=$("#jqxProcFolGrid").jqxGrid('getcellvalue', rowindex1, "path");
    		     				 var brch=$("#jqxProcFolGrid").jqxGrid('getcellvalue', rowindex1, "brhid");
    		     				 var doctype=$("#jqxProcFolGrid").jqxGrid('getcellvalue', rowindex1, "dtype");
    		     				 var name=$("#jqxProcFolGrid").jqxGrid('getcellvalue', rowindex1, "menuname");
    		     				 var url=document.URL;
    		       				var reurl=url.split("com");
    		       
    		     			  window.parent.formName.value=$("#jqxProcFolGrid").jqxGrid('getcellvalue', rowindex1, "menuname");
    		     			  window.parent.formCode.value=$("#jqxProcFolGrid").jqxGrid('getcellvalue', rowindex1, "dtype");
    		     			  var detName=$("#jqxProcFolGrid").jqxGrid('getcellvalue', rowindex1, "menuname");
    		     			  
    		     			  var path= path1+"?modes=view&mastertrno="+trno+"&isassign=1&brch="+brch+"&doctype="+doctype+"&name="+name
    		     					  +"&docno="+docno+"&reviseno="+reviseno+"&client="+client.replace("/\s/g","%20").replace('#','%23').replace('&','%26')
    		     					  +"&date="+date+"&cldocno="+cldocno
		                		 +"&ref_type="+ref_type+"&refdocno="+refdocno+"&reftrno="+reftrno+"&address="+address.replace("/\s/g","%20").replace('#','%23').replace('&','%26')
		                		 +"&material="+material+"&labour="+labour
		                		 +"&machine="+machine+"&nettotal="+nettotal;
    		     			 
    		     			   top.addTab( detName,reurl[0]+""+path);
    		     				
    		                 	
    		                 }
     	
    		            	
    		              
                		 });
                
        });
    </script>
    <div id="jqxProcFolGrid"></div>
