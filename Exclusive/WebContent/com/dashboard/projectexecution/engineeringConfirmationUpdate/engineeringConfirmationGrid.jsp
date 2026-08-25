    <%-- <jsp:include page="../../includes.jsp"></jsp:include>  --%> 
    
  <%@page import="com.dashboard.projectexecution.engineeringconfirmationupdate.ClsEngineeringConfirmationDAO"%>
<%
ClsEngineeringConfirmationDAO sd=new ClsEngineeringConfirmationDAO();
%>
    
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

 <%

     String chkfollowup = request.getParameter("chkfollowup")==null?"0":request.getParameter("chkfollowup").trim();
     String followupdate = request.getParameter("followupdate")==null?"0":request.getParameter("followupdate").trim();
     String branchval =request.getParameter("branchval")==null?"0":request.getParameter("branchval").toString();
     String fromdate =request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").toString();
     String todate =request.getParameter("todate")==null?"0":request.getParameter("todate").toString();
     String check=request.getParameter("check")==null?"0":request.getParameter("check").toString();
    
     
     %>
     <style type="text/css">
  
   
    
    .orangeClass
    {
        background-color: #FAD7A0;
    }
 
     .whiteClass
    {
        background-color: #FFFFFF;
    }
</style>
 <script type="text/javascript">
 var data,dataexcel;
 
 var flchk='<%=check%>';

	if(flchk!='0'){
 data= '<%= sd.loadGridData(branchval,chkfollowup,followupdate,fromdate,todate)%>';
 engineeringconfexcel= '<%= sd.loadGridDataexcel(branchval,chkfollowup,followupdate,fromdate,todate)%>' ;
<%--  dataexcel= '<%= sd.loadGridExcel(branchval,chkfollowup,followupdate,fromdate,todate,salesmanid) %>'; --%>  
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
     						{name : 'date', type: 'String' },    
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
     	                  {name : 'ecmno', type: 'String'  },
     	                 {name : 'qotno',type:'number'},
     	                {name : 'contrno',type:'number'},
     	               {name : 'surtrno',type:'number'},
     	              {name : 'enqmtrno',type:'number'}, 
     	             {name : 'contracttrno',type:'number'}, 
     	            {name : 'doctype', type: 'String'  },
                 ],
                 localdata: data,
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var cellclassname = function (row, column, value, data) {
           
                	if(data.rowcolor=="1"){
                    	return "orangeClass";
                    }
           
                  };
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxEngConfGrid").jqxGrid(
            {
                width: '99%',
                height: 180,
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
					{ text: 'Doc type', datafield: 'doctype', width: '6%',cellclassname:cellclassname},
					{ text: 'Ref Details',  datafield: 'refdet', width: '9%',cellclassname:cellclassname },
					{ text: 'Date', datafield: 'date', width: '8%' ,cellclassname:cellclassname},
					{ text: 'Quotation No.', datafield: 'qotno', width: '7%',cellclassname:cellclassname },
					{ text: 'Contract No.', datafield: 'contrno', width: '7%',cellclassname:cellclassname },
					{ text: 'Client Name', datafield: 'client', width: '37%',cellclassname:cellclassname },
					{ text: 'Material Total', datafield: 'material', width: '10%',cellclassname:cellclassname,hidden:true },
					{ text: 'Labour Total', datafield: 'labour', width: '10%',cellclassname:cellclassname,hidden:true },
					{ text: 'Machine Total', datafield: 'machine', width: '10%',cellclassname:cellclassname,hidden:true },
					{ text: 'Net Total', datafield: 'nettotal', width: '15%',cellclassname:cellclassname, hidden:true  },
					{ text: 'Followup Date', datafield: 'fdate', width: '10%',cellsformat:'dd.MM.yyyy' ,cellclassname:cellclassname},
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
					{ text: 'ecmno', datafield: 'ecmno', width: '17%',hidden:true },
					{ text: 'surtrno', datafield: 'surtrno', width: '17%',hidden:true },
					{ text: 'enqmtrno', datafield: 'enqmtrno', width: '17%',hidden:true },
					{ text: 'contracttrno', datafield: 'contracttrno', width: '17%',hidden:true },
					
	              ]
            });
      
               $("#overlay, #PleaseWait").hide();
               
               
                $('#jqxEngConfGrid').on('celldoubleclick', function (event) { 
                	 var rowindex1=event.args.rowindex;
                	
                				var rows=$('#jqxEngConfGrid').jqxGrid('getrows');
                				for(var i=0;i<rows.length;i++){
                					$('#jqxEngConfGrid').jqxGrid('setcellvalue',i,'rowcolor','0');
                				}
                				$('#jqxEngConfGrid').jqxGrid('setcellvalue',rowindex1,'rowcolor','1');
                	 $('#materialEstPriceGrid').jqxGrid({disabled:false});
                	
                	$('#engconfirmsubgrid').jqxGrid({disabled:false});
                 	   $('#cmbprocess').val('');
                 	  
                       $('#cmbprocess').attr("disabled",false);
                       $('#txtremarks').attr("readonly",false);
                       $('#date').jqxDateTimeInput({disabled: false});
                       $('#btnupdate').attr("disabled",false);   
                 	   document.getElementById("txtrdocno").value=$('#jqxEngConfGrid').jqxGrid('getcellvalue', rowindex1, "tr_no"); 
                 	   document.getElementById("txtbrchid").value=$('#jqxEngConfGrid').jqxGrid('getcellvalue', rowindex1, "brhid");
                 	   document.getElementById("txtuserid").value=$('#jqxEngConfGrid').jqxGrid('getcellvalue', rowindex1, "userid");
                 	  document.getElementById("hidcontracttrno").value=$('#jqxEngConfGrid').jqxGrid('getcellvalue', rowindex1, "contracttrno");
                 	 /*  document.getElementById("txtcldocno").value=$('#jqxEngConfGrid').jqxGrid('getcellvalue', rowindex1, "cldocno");
                 	 	  */
                 	 	  
                 	 	  document.getElementById("hidsurtrno").value=$('#jqxEngConfGrid').jqxGrid('getcellvalue', rowindex1, "surtrno");
                 	   	  document.getElementById("hidenqtrno").value=$('#jqxEngConfGrid').jqxGrid('getcellvalue', rowindex1, "enqmtrno");
                 	 	  
                 	 	  var esttrno=$('#jqxEngConfGrid').jqxGrid('getcellvalue', rowindex1, 'tr_no');
                 	 	var cldoc=$('#jqxEngConfGrid').jqxGrid('getcellvalue', rowindex1, 'cldocno');
                 	 	var estdate=$('#jqxEngConfGrid').jqxGrid('getcellvalue', rowindex1, 'date');
                 	 	var ecmno=$('#jqxEngConfGrid').jqxGrid('getcellvalue', rowindex1, 'ecmno');
                 	 	 $("#EstDiv").load("EstDetailGrid.jsp?enqtrno="+esttrno+"&cldocno="+cldoc+"&estdate="+estdate+"&ecmno="+ecmno);
                     $("#detailDiv").load("engineeringConfirmationSubGrid.jsp?trdocno="+$('#jqxEngConfGrid').jqxGrid('getcellvalue', rowindex1, 'tr_no'));
                     }); 
                
                $('#jqxEngConfGrid').on('cellclick', function (event) 
                		{ 
    		            	var rowindex1=event.args.rowindex;
    		            	var datafield = event.args.datafield;
    		            	
    		            	 if(datafield=="view"){
    		            		 
    		            		 var docno= $('#jqxEngConfGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
    		                     var trno=$('#jqxEngConfGrid').jqxGrid('getcellvalue', rowindex1, "tr_no");
    		                     var reviseno=$('#jqxEngConfGrid').jqxGrid('getcellvalue', rowindex1, "reviseno");
    		                     var date=$('#jqxEngConfGrid').jqxGrid('getcellvalue', rowindex1, "date");
    		                     var client=$('#jqxEngConfGrid').jqxGrid('getcellvalue', rowindex1, "client");
    		                     var cldocno=$('#jqxEngConfGrid').jqxGrid('getcellvalue', rowindex1, "cldocno");
    		                     var ref_type=$('#jqxEngConfGrid').jqxGrid('getcellvalue', rowindex1, "ref_type");
    		                     var refdocno=$('#jqxEngConfGrid').jqxGrid('getcellvalue', rowindex1, "refdocno");
    		                     var reftrno=$('#jqxEngConfGrid').jqxGrid('getcellvalue', rowindex1, "reftrno");
    		                     var address=$('#jqxEngConfGrid').jqxGrid('getcellvalue', rowindex1, "address");
    		                     var material=$('#jqxEngConfGrid').jqxGrid('getcellvalue', rowindex1, "material");
    		                     var labour=$('#jqxEngConfGrid').jqxGrid('getcellvalue', rowindex1, "labour");
    		                     var machine=parseFloat($('#jqxEngConfGrid').jqxGrid('getcellvalue', rowindex1, "machine"));
    		                     var nettotal=parseFloat($('#jqxEngConfGrid').jqxGrid('getcellvalue', rowindex1, "nettotal"));
    		         			 var path1=$("#jqxEngConfGrid").jqxGrid('getcellvalue', rowindex1, "path");
    		     				 var brch=$("#jqxEngConfGrid").jqxGrid('getcellvalue', rowindex1, "brhid");
    		     				 var doctype=$("#jqxEngConfGrid").jqxGrid('getcellvalue', rowindex1, "dtype");
    		     				 var name=$("#jqxEngConfGrid").jqxGrid('getcellvalue', rowindex1, "menuname");
    		     				 var url=document.URL;
    		       				var reurl=url.split("com");
    		       
    		     			  window.parent.formName.value=$("#jqxEngConfGrid").jqxGrid('getcellvalue', rowindex1, "menuname");
    		     			  window.parent.formCode.value=$("#jqxEngConfGrid").jqxGrid('getcellvalue', rowindex1, "dtype");
    		     			  var detName=$("#jqxEngConfGrid").jqxGrid('getcellvalue', rowindex1, "menuname");
    		     			  
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
    <div id="jqxEngConfGrid"></div>
