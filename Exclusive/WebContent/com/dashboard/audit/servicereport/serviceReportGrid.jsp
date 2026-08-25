<!-- barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate -->
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page
	import="com.dashboard.audit.servicereport.ClsServiceReport"%>
<%
	ClsServiceReport sd=new ClsServiceReport();
%>
<% 
String branch =request.getParameter("barchval")==null?"0":request.getParameter("barchval").toString();
String clientid =request.getParameter("clientid")==null?"0":request.getParameter("clientid").toString();
String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
%>

<style type="text/css">
.redClass {
	background-color: #FFEBEB;
}

.yellowClass {
	background-color: #FFFF00;
}

.orangeClass {
	background-color: #FFEBC2;
}
</style>
<script type="text/javascript">
 var data;
 var exceldata;
 data= '<%=sd.serviceScheduleGridLoad(session,clientid,branch,fromdate,todate) %>';
  exceldata= '<%= sd.serviceScheduleGridLoadExcel(session,clientid,branch,fromdate,todate) %>';
   
    
        $(document).ready(function () { 	
             
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'dtype', type: 'String'  },
     						{name : 'refdocno', type: 'String'  },
     						{name : 'tr_no', type: 'String' },
     						{name : 'sr_no', type: 'String' },
     						{name : 'site', type: 'String' },
     						{name : 'profomadate', type: 'String' },
     						{name : 'profomarecievedate', type: 'date' },
     						{name : 'groupname', type: 'String' },
     						{name : 'refname', type: 'String' },
     						{name : 'pldate', type: 'String' },
     						{name : 'contr', type: 'String' },
     						{name : 'pltime', type: 'String' },
     						{name : 'pldte', type: 'String' },
     						{name : 'sertype', type: 'String' },
     						{name : 'serdocno', type: 'String' },
     						{name : 'apprdate', type: 'String' },
     						{name : 'validupto', type: 'String' },
     						{name : 'description', type: 'String' },
     						{name : 'complaint', type: 'String' },
     						{name : 'priority', type: 'String' },
     						{name : 'gridrow', type: 'String' },
     						{name : 'docno2', type: 'int'   },
     						{name : 'claddress', type: 'string'   },
     						{name : 'acno', type: 'string'   },
     						{name : 'contracttrno', type: 'String' },
     						{name : 'contractdetails', type: 'String' },
     						{name : 'siteid', type: 'String' },
     						{name : 'areaid', type: 'String' },
     						{name : 'maintrno', type: 'String' },
     						{name : 'asgngrp', type: 'String' },
     						{name : 'teampid', type: 'String' },
     						{name : 'grpid', type: 'String' },
     						{name : 'emp', type: 'String' },
     						{name : 'empid', type: 'String' },
     						{name : 'asgnmode', type: 'String' },
     						{name : 'asignid', type: 'String' },
     						{name : 'path', type: 'String' },
     						{name : 'name', type: 'String' },
     						{name : 'doctrno', type: 'String' },
     						{name : 'sport', type: 'String' },
     						{name : 'doc_no', type: 'String' },
     						{name : 'compl', type: 'String' },
     						{name : 'sitecont', type: 'String' },
     						{name : 'branch', type: 'String' },
     						{name : 'srvdetmtrno', type: 'String' }
     						
                 ],
                 localdata: data,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
           
 
            var cellclassname = function (row, column, value, data) {
            	
       		 if (data.gridrow==1) {
                   return "orangeClass";
               };
             
            };
			
					
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxloaddataGrid").jqxGrid(
            {
                width: '99.5%',
                height: 530,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'checkbox',
                filtermode:'excel',
                filterable: true,
                //pagermode: 'default',
		       filterable: true,
		       showfilterrow: true,

                sortable: true,
                //Add row method
                columns: [
                          { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },	
					{ text: 'PRIORITY',  datafield: 'priority', columntype:'checkbox', width: '5%',cellclassname:cellclassname },     
					{ text: 'DTYPE',columntype: 'textbox', datafield: 'dtype', width: '4%',cellclassname:cellclassname },
					{ text: 'DOC NO',columntype: 'textbox',  datafield: 'refdocno', width: '5%',cellclassname:cellclassname },
					{ text: '',  datafield: 'contr',columntype: 'button', width: '4%' },
					{ text: 'SCH.NO',columntype: 'textbox', datafield: 'tr_no', width: '4%',cellclassname:cellclassname },
					{ text: 'SRNO',columntype: 'textbox', datafield: 'sr_no', width: '5%',cellclassname:cellclassname },
					{ text: 'SITE NAME',columntype: 'textbox', width: '8%', datafield: 'site',cellclassname:cellclassname },
					{ text: 'SERVICE TYPE',columntype: 'textbox', width: '8%', datafield: 'sertype',cellclassname:cellclassname },
					{ text: 'COMPLAINT',columntype: 'textbox', width: '10%', datafield: 'compl',cellclassname:cellclassname , hidden: true},
					{ text: 'ASSIGN.GROUP',columntype: 'textbox', datafield: 'asgngrp', width: '8%',cellclassname:cellclassname },
					{ text: 'EMPLOYEE',columntype: 'textbox', datafield: 'emp', width: '8%',cellclassname:cellclassname },
					{ text: 'ASSIGN.MODE',columntype: 'textbox', datafield: 'asgnmode', width: '8%',cellclassname:cellclassname },
					{ text: 'teampid',columntype: 'textbox', datafield: 'teampid',cellclassname:cellclassname, hidden: true },
					{ text: 'grpid',columntype: 'textbox', datafield: 'grpid',cellclassname:cellclassname, hidden: true },
					{ text: 'empid',columntype: 'textbox', datafield: 'empid',cellclassname:cellclassname, hidden: true },
					{ text: 'asignid',columntype: 'textbox', datafield: 'asignid',cellclassname:cellclassname, hidden: true },
					
					{ text: 'AREA',columntype: 'textbox', datafield: 'groupname', width: '8%',cellclassname:cellclassname },
					{ text: 'CLIENT NAME',columntype: 'textbox',  datafield: 'refname', width: '15%',cellclassname:cellclassname },
					{ text: 'PLANNED DATE',columntype: 'textbox',  datafield: 'pldate', width: '6%',cellclassname:cellclassname },
					{ text: 'APPR.DATE',columntype: 'textbox',  datafield: 'apprdate', width: '6%',cellclassname:cellclassname },
					{ text: 'PROFORMA DATE',columntype: 'textbox',  datafield: 'profomadate', width: '6%',cellclassname:cellclassname },
					{ text: 'PROFORMA RECIEVED DATE',columntype: 'textbox',  datafield: 'profomarecievedate', width: '6%',cellclassname:cellclassname, cellsformat: 'dd.MM.yyyy' },
					{ text: 'END DATE',columntype: 'textbox',  datafield: 'validupto', width: '6%',cellclassname:cellclassname },
					{ text: 'DESCRIPTION',columntype: 'textbox',  datafield: 'description', width: '10%',cellclassname:cellclassname},
					{ text: 'Service Report',  datafield: 'sport',columntype: 'button', width: '7%' },
					{ text: 'COMPLAINT',columntype: 'textbox',  datafield: 'complaint',cellclassname:cellclassname,hidden:true },
					{ text: 'cmpldate',columntype: 'textbox',  datafield: 'pldte', width: '10%',hidden:true,cellclassname:cellclassname },
					{ text: 'gridrow',columntype: 'textbox',  datafield: 'gridrow', width: '10%',hidden:true,cellclassname:cellclassname },
					{ text: 'Doc No',  datafield: 'docno2', hidden: true, width: '5%' },
					{ text: 'Acc No',  datafield: 'acno', hidden: true, width: '5%' },
					{ text: 'Address',  datafield: 'claddress', hidden: true, width: '15%' },
					{ text: 'serdocno',  datafield: 'serdocno', hidden: true, width: '5%' },
					{ text: 'Contracttrno',  datafield: 'contracttrno', hidden: true, width: '5%' },
					{ text: 'Contractdetails',  datafield: 'contractdetails', hidden: true, width: '5%' },
					{ text: 'Site Id',  datafield: 'siteid', hidden: true, width: '5%' },
					{ text: 'Area Id',  datafield: 'areaid', hidden: true, width: '5%' },
					{ text: 'Path',  datafield: 'path', hidden: true, width: '5%' },
					{ text: 'name',  datafield: 'name', hidden: true, width: '5%' },
					{ text: 'doctrno',  datafield: 'doctrno', hidden: true, width: '5%' },
					{ text: 'cregdoc',  datafield: 'doc_no', hidden: true, width: '5%' },
					{ text: 'SITE CONTACT',  datafield:'sitecont', hidden: true, width: '5%' },
					{ text: 'branch',  datafield:'branch', hidden: true, width: '5%' },
					{ text: 'srvdetmtrno',  datafield:'srvdetmtrno', hidden: true, width: '5%' },
		
	              ]
            });
            $('#jqxloaddataGrid').on('cellclick', function (event) 
            		{ 
		            	var rowindex1=event.args.rowindex;
		            	var datafield = event.args.datafield;
		            	
		            	if(datafield=="sport"  )
		      		  {
		            	
		                   //	var trno =  $('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "tr_no");
		                     var client= $('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "refname");
			            	 var ctype= $('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "dtype");
			                 var cno= $('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "refdocno");
			               //    var cdet= $('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "dtype");
			                  var site=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "site");
		                  //	   var site=site1.replace("/\s/g","%20").replace('#','%23') ;
			                var area= $('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "groupname");
			                var scheduleno= $('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "tr_no");
			                var docno2=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "docno2");
			                var acno= $('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "acno");
			                var claddress= $('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "claddress");
			                 //  var claddress=claddress1.replace("/\s/g","%20").replace('#','%23') ;    
			                var conttrno= $('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "contracttrno");
			                var contdet=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "contractdetails");
			                var siteid= $('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "siteid");
			                var areaid= $('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "areaid");
			                var serdocno= $('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "serdocno");
			               var cregtrno= $('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "doctrno");
			               var cregdoc= $('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
			                 
		        		var url=document.URL;
		        		var reurl=url.split("com/");
		        		var mod="V";
		        		window.parent.formName.value="Service Report";
		        		window.parent.formCode.value="SRVE";
		        		var detName= "Service Report";
		        		 var path1='com/project/execution/serviceReport/serviceReport.jsp';
		                 var path= path1+"?client="+client+"&ctype="+ctype+"&cno="+cno+"&site="+site.replace("/\s/g","%20").replace('#','%23').replace('&','%26')+"&area="+area+"&scheduleno="+scheduleno
		                		 +"&mod="+mod+"&cldocno2="+docno2+"&clacno="+acno+"&claddress2="+claddress.replace("/\s/g","%20").replace('#','%23').replace('&','%26')+"&conttrno="+conttrno+"&contdet="+contdet
		                		 +"&siteid="+siteid+"&areaid="+areaid+"&serdocno="+serdocno+"&cregtrno="+cregtrno+"&cregdoc="+cregdoc;
		                 
		        		top.addTab( detName,reurl[0]+""+path);
		            	
		      		  }
		            	
		            	
		            	 if(datafield=="contr"){
		                	 
		     				
		     				 var path1=$("#jqxloaddataGrid").jqxGrid('getcellvalue', rowindex1, "path");
		     				 var brch=$("#jqxloaddataGrid").jqxGrid('getcellvalue', rowindex1, "branch");
		     				 var doctype=$("#jqxloaddataGrid").jqxGrid('getcellvalue', rowindex1, "dtype");
		     				 var  doc_no=0,masterdoc=0;
		     				 if(doctype=='CREG'){
		     					  doc_no=$("#jqxloaddataGrid").jqxGrid('getcellvalue', rowindex1, "refdocno");
		     				 }
		     				 else{
		     					 doc_no=$("#jqxloaddataGrid").jqxGrid('getcellvalue', rowindex1, "doctrno");
		     					  masterdoc=$("#jqxloaddataGrid").jqxGrid('getcellvalue', rowindex1, "refdocno");
		     				 }
		     				
		     				 var name=$("#jqxloaddataGrid").jqxGrid('getcellvalue', rowindex1, "name");
		     				
		     				 var url=document.URL;
		       				var reurl=url.split("com");
		       
		     			  window.parent.formName.value=$("#jqxloaddataGrid").jqxGrid('getcellvalue', rowindex1, "name");
		     			  window.parent.formCode.value=$("#jqxloaddataGrid").jqxGrid('getcellvalue', rowindex1, "dtype");
		     			  var detName=$("#jqxloaddataGrid").jqxGrid('getcellvalue', rowindex1, "name");
		     			  
		     			  var path= path1+"?modes=view&mastertrno="+doc_no+"&isassign=1&brch="+brch+"&doctype="+doctype+"&name="+name+"&masterdocno="+masterdoc;
		     			 
		     			   top.addTab( detName,reurl[0]+""+path);
		     				
		                 	
		                 }
 	
		              
		              
            		 });
         
             /* $('#jqxloaddataGrid').on('rowdoubleclick', function (event){ 
            	 $('#audit').attr('disabled',false);
	            	var rowindex1=event.args.rowindex;
	            	var srvdetmtrno= $('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "srvdetmtrno").split(' ');
	                document.getElementById("srvdetmtrno").value=srvdetmtrno;
             }); */
             
            $("#overlay, #PleaseWait").hide();
        });
    </script>
<div id="jqxloaddataGrid"></div>
