
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page
	import="com.dashboard.projectexecution.assignmentfollowup.ClsAssignmentFollowupDAO"%>
<%
ClsAssignmentFollowupDAO sd=new ClsAssignmentFollowupDAO();
%>
<% String date =request.getParameter("date")==null?"0":request.getParameter("date").toString();
String chkfromdate = request.getParameter("chkfromdate")==null?"0":request.getParameter("chkfromdate").trim();
String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim(); %>
<% String branch =request.getParameter("barchval")==null?"0":request.getParameter("barchval").toString();%>
<% String clientid =request.getParameter("clientid")==null?"0":request.getParameter("clientid").toString();%>
<% String dtype =request.getParameter("dtype")==null?"0":request.getParameter("dtype").toString();%>
<% int id =request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id").toString());%>
<% int priority =request.getParameter("isprior")==null?0:Integer.parseInt(request.getParameter("isprior").toString());
 
String grp =request.getParameter("grp")==null?"0":request.getParameter("grp").toString();
String emp =request.getParameter("emp")==null?"0":request.getParameter("emp").toString();
String mem =request.getParameter("mem")==null?"0":request.getParameter("mem").toString();
String area =request.getParameter("area")==null?"0":request.getParameter("area").toString();
String assignstatus =request.getParameter("assignstatus")==null?"0":request.getParameter("assignstatus").toString();
String bttnview =request.getParameter("bttnview")==null?"0":request.getParameter("bttnview").toString();
 %>
 <% String contextPath=request.getContextPath();%>
<style type="text/css">
.redClass {
	background-color: #FFEBEB;
}

.greenClass {
	background-color: #DAF7A6;
}

.violetClass {
	background-color: #D59FFD;
}
</style>
<script type="text/javascript">
var dtypeval='<%=dtype%>';
var bttnview='<%=bttnview%>';
 var data;
 var exceldata;
 
  data= '<%= sd.serviceScheduleGridLoad(session,dtype,date,branch,clientid,id,priority,grp,emp,mem,area,chkfromdate,fromdate,assignstatus) %>';
  
  exceldata= '<%= sd.serviceScheduleGridLoadExcel(session,dtype,date,branch,clientid,id,priority,grp,emp,mem,area,chkfromdate,fromdate,assignstatus) %>';
   
    
        $(document).ready(function () { 	
             
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'dtype', type: 'String'  },
     						{name : 'refdocno', type: 'String'  },
     						{name : 'tr_no', type: 'String' },
     						{name : 'assignstatus', type: 'String' },
     						{name : 'status', type: 'String' },
     						{name : 'sr_no', type: 'String' },
     						{name : 'site', type: 'String' },
     						{name : 'enuser', type: 'String' },
     						{name : 'attach', type: 'String' },
     						{name : 'view', type: 'String' },
     						{name : 'profomadate', type: 'String' },
     						{name : 'profomarecievedate', type: 'date' },
     						{name : 'groupname', type: 'String' },
     						{name : 'refname', type: 'String' },
     						{name : 'calledby', type: 'String' },
     						{name : 'pldate', type: 'String' },
     						{name : 'pltime', type: 'String' },
     						{name : 'pldte', type: 'String' },
     						{name : 'sertype', type: 'String' },
     						{name : 'serdocno', type: 'String' },
     						{name : 'apprdate', type: 'String' },
     						{name : 'validupto', type: 'String' },
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
     						{name : 'description', type: 'String' },
     						{name : 'sport', type: 'String' },
     						{name : 'contr', type: 'String' },
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
     						{name : 'doc_no', type: 'String' },
     						{name : 'compl', type: 'String' },
     						{name : 'sitecont', type: 'String' },
     						{name : 'branch', type: 'String' }
     						
                 ],
                 localdata: data,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
 $("#jqxloaddataGrid").on("bindingcomplete", function (event) {
            	
            	// your code here.
            if(dtypeval=="CREG"){
            	$('#jqxloaddataGrid').jqxGrid('setcolumnproperty','compl','hidden',false);
            	
            }	
            });           
 
            var cellclassname = function (row, column, value, data) {
            	
       		 if (data.gridrow==1) {
                   return "violetClass";
               };
               
               if(typeof(data.pldate) != "undefined" && typeof(data.pldate) != "NaN" && data.pldate != ""){
	               var currentdate= new Date(new Date());
	               var planneddate=(data.pldate).split("-");
	               
	               if (parseInt(planneddate[2])==parseInt(currentdate.getFullYear())){
		                if (parseInt(planneddate[1])==parseInt(currentdate.getMonth()+1)) { 
		                   return "greenClass";
		                };
	           	   };
               }
           	   
            };
			
			$("#jqxloaddataGrid").on("bindingcomplete", function (event) {
     	      if(bttnview=='1'){
     	          $('#jqxloaddataGrid').jqxGrid('hidecolumn', 'contr');
     	      }else{
     	          $("#jqxloaddataGrid").jqxGrid('showcolumn', 'contr');
     	      }
     	    });
					
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
                height: 390,
                source: dataAdapter,
                columnsresize: true,
                sortable: true,
                selectionmode: 'singlerow',
                filtermode:'excel',
		        showfilterrow: true,
                filterable: true,
                //pagermode: 'default',
                sortable: true,
                //Add row method
                columns: [
                          { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '3%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },	
					{ text: 'SRNO',columntype: 'textbox', datafield: 'sr_no',hidden: true, width: '5%',cellclassname:cellclassname },
					{ text: 'CREG',columntype: 'textbox',  datafield: 'refdocno', width: '4%',cellclassname:cellclassname },
					{ text: 'DATE',columntype: 'textbox',  datafield: 'pldate', width: '9%',cellclassname:cellclassname },
					{ text: 'ENTERED',columntype: 'textbox', datafield: 'enuser', width: '8%',cellclassname:cellclassname },
					{ text: 'STATUS',columntype: 'textbox', width: '12%', datafield: 'status',cellclassname:cellclassname },
					{ text: 'STATUS ID',columntype: 'textbox', width: '8%', datafield: 'assignstatus',hidden: true, cellclassname:cellclassname },
					{ text: 'SERVICE TYPE',columntype: 'textbox', width: '10%', datafield: 'sertype',cellclassname:cellclassname },
					{ text: 'COMPLAINT',columntype: 'textbox', width: '11%', datafield: 'compl',cellclassname:cellclassname },
					{ text: 'DESCRIPTION',  datafield: 'description', width: '29%' },
					{ text: 'EMPLOYEE',columntype: 'textbox', datafield: 'emp', width: '8%',cellclassname:cellclassname },
					{ text: 'ASSIGN GROUP',columntype: 'textbox', datafield: 'asgngrp', width: '10%',cellclassname:cellclassname },
					{ text: 'CLIENT NAME',columntype: 'textbox',  datafield: 'refname', width: '18%',hidden:true,cellclassname:cellclassname },
					{ text: 'CALLED BY',columntype: 'textbox',  datafield: 'calledby', width: '18%',cellclassname:cellclassname },
					{ text: 'CREG',  datafield: 'view',columntype: 'button', width: '7%',hidden: true },
					{ text: 'ATTACH',  datafield: 'attach',columntype: 'button', width: '7%' },
					{ text: 'ASSIGN.MODE',columntype: 'textbox', datafield: 'asgnmode',hidden:true, width: '8%',cellclassname:cellclassname },
					{ text: 'teampid',columntype: 'textbox', datafield: 'teampid',cellclassname:cellclassname, hidden: true },
					{ text: 'grpid',columntype: 'textbox', datafield: 'grpid',cellclassname:cellclassname, hidden: true },
					{ text: 'SITE NAME',columntype: 'textbox',hidden:true, width: '8%', datafield: 'site',cellclassname:cellclassname },
					{ text: 'empid',columntype: 'textbox', datafield: 'empid',cellclassname:cellclassname, hidden: true },
					{ text: 'asignid',columntype: 'textbox', datafield: 'asignid',cellclassname:cellclassname, hidden: true },
					{ text: 'AREA',columntype: 'textbox', datafield: 'groupname',hidden:true, width: '8%',cellclassname:cellclassname },
					{ text: 'PRIORITY',  datafield: 'priority', columntype:'checkbox',hidden:true, width: '5%',cellclassname:cellclassname },     
					{ text: 'DTYPE',columntype: 'textbox', datafield: 'dtype', width: '4%',hidden:true,cellclassname:cellclassname },
					{ text: 'SCH.NO',columntype: 'textbox', datafield: 'tr_no',hidden:true, width: '4%',cellclassname:cellclassname },
					{ text: 'APPR.DATE',columntype: 'textbox',  datafield: 'apprdate',hidden:true, width: '6%',cellclassname:cellclassname },
					{ text: 'PROFORMA DATE',columntype: 'textbox',  datafield: 'profomadate',hidden:true, width: '6%',cellclassname:cellclassname },
					{ text: 'PROFORMA RECIEVED DATE',columntype: 'textbox',  datafield: 'profomarecievedate',hidden:true, width: '6%',cellclassname:cellclassname, cellsformat: 'dd.MM.yyyy' },
					{ text: 'END DATE',columntype: 'textbox',  datafield: 'validupto',hidden:true, width: '6%',cellclassname:cellclassname },
					{ text: 'COMPLAINT',columntype: 'textbox',  datafield: 'complaint',cellclassname:cellclassname,hidden:true },
					{ text: 'cmpldate',columntype: 'textbox',  datafield: 'pldte', width: '10%',hidden:true,cellclassname:cellclassname },
					{ text: 'gridrow',columntype: 'textbox',  datafield: 'gridrow', width: '10%',hidden:true,cellclassname:cellclassname },
					{ text: 'Doc No',  datafield: 'docno2', hidden: true, width: '5%' },
					{ text: 'Acc No',  datafield: 'acno', hidden: true, width: '5%' },
					{ text: 'Address',  datafield: 'claddress', hidden: true, width: '15%' },
					{ text: 'Service Report',  datafield: 'sport',columntype: 'button',hidden:true, width: '7%' },
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
		        		var mod="A";
		        		window.parent.formName.value="Service Report";
		        		window.parent.formCode.value="SRVE";
		        		var detName= "Service Report";
		        		 var path1='com/project/execution/serviceReport/serviceReport.jsp';
		                 var path= path1+"?client="+client+"&ctype="+ctype+"&cno="+cno+"&site="+site.replace("/\s/g","%20").replace('#','%23').replace('&','%26')+"&area="+area+"&scheduleno="+scheduleno
		                		 +"&mod="+mod+"&cldocno2="+docno2+"&clacno="+acno+"&claddress2="+claddress.replace("/\s/g","%20").replace('#','%23').replace('&','%26')+"&conttrno="+conttrno+"&contdet="+contdet
		                		 +"&siteid="+siteid+"&areaid="+areaid+"&serdocno="+serdocno+"&cregtrno="+cregtrno+"&cregdoc="+cregdoc;
		                 
		        		top.addTab( detName,reurl[0]+""+path);
		            	
		      		  }
		            	
		            	
		            	 if(datafield=="view"){
		                	 
		     				
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
		            	 
		            	 if(datafield=="attach"){
			             		var brchid=$("#jqxloaddataGrid").jqxGrid('getcellvalue', rowindex1, "branch"); 
			             		var docno=$("#jqxloaddataGrid").jqxGrid('getcellvalue', rowindex1, "refdocno");
			             		var frmdet="CREG";
			             		if ($("#docno").val()!="") {
			   				
			   				   var  myWindow= window.open("http://gate-way.dyndns.org:8889/ServiceDB/com/common/Attachmaster.jsp?formCode="+frmdet
			 							 +"&docno="+docno+"&brchid="+brchid,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
			 							  myWindow.focus();
			 				
			 				} else {
			 					$.messager.alert('Message','Select a Document....!','warning');
			 					return;
			 				    }
			             		 
				                }
		              
            		 });
            
            
             $('#jqxloaddataGrid').on('rowdoubleclick', function (event) 
            		{ 
		            	var rowindex1=event.args.rowindex;
		            	
		            	$('#cmbprocess').val('');$('#date').val(new Date());$('#txtdesc').val('');
		            	  
		                $('#cmbprocess').attr("disabled",false);$('#txtdesc').attr("readonly",false);
		                $('#date').jqxDateTimeInput({disabled: false});$('#btnupdate').attr("disabled",false);
		                  
		            	var dtime= $('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "pldate").split(' ');
		                var trno= $('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "refdocno");
		                var srno= $('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "tr_no");
		                var dtype= $('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "dtype");
		                var pldte=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "pldte");
		                var brch=$("#jqxloaddataGrid").jqxGrid('getcellvalue', rowindex1, "branch");
		            	document.getElementById("brhid1").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "branch");
              	        document.getElementById("docno1").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "refdocno");
              			
		                document.getElementById("txtstatus").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "status");
		              	document.getElementById("txtstatusid").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "assignstatus");
		              	document.getElementById("txtstatusid2").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "assignstatus");
		              	document.getElementById("assignid").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "asignid");
		              	
		              	document.getElementById("txtgroup").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "asgngrp");
              	        document.getElementById("groupid").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "grpid");
              			
              	        document.getElementById("txtgrpmember").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "emp");
		              	document.getElementById("grpmemberid").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "teampid");
		              	document.getElementById("grpempid").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "empid");
		               		
		              	
		                var pldate=dtime[0];
		                var pltime=dtime[1];
		                // alert("==trno=="+trno+"==srno===="+srno);
		                //document.getElementById("txtpdate").value=pldate;
		                $('#adate').val(new Date());
		                $('#atime').val(new Date());
		                /* $('#adate').jqxDateTimeInput('val',pldte);
		                $('#atime').jqxDateTimeInput('val',pltime); */
		                //document.getElementById("txtptime").value=pltime;
		                document.getElementById("trno").value=trno;
		                document.getElementById("rowindex").value=rowindex1;
		                document.getElementById("srno").value=srno;
		                document.getElementById("dtype").value=dtype;
		                document.getElementById("doccno").value=trno;
		                var test=dtype+ ' No: '+trno+'  Schedule No :'+srno;
		                
		                document.getElementById("test").innerText=test;
		                
		                $("#assignSubDiv").load("assignSubGrid.jsp?docno="+trno+"&brchid="+brch);
		              
            		 });
            $("#overlay, #PleaseWait").hide();
        });
        
    </script>
<div id="jqxloaddataGrid"></div>
<input type="hidden" id="hidcregdocno" name="hidcregdocno">