
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="com.dashboard.projectexecution.serviceupdate.ServiceUpdateDAO" %> 
<%
ServiceUpdateDAO sd=new ServiceUpdateDAO();
%>


<% String date =request.getParameter("date")==null?"0":request.getParameter("date").toString();
String chkfromdate = request.getParameter("chkfromdate")==null?"0":request.getParameter("chkfromdate").trim();
String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();


%>
<% String bttnview =request.getParameter("bttnview")==null?"0":request.getParameter("bttnview").toString();%>
<% String branch =request.getParameter("barchval")==null?"0":request.getParameter("barchval").toString();%>
<% String clientid =request.getParameter("clientid")==null?"0":request.getParameter("clientid").toString();%>
<% String dtype =request.getParameter("dtype")==null?"0":request.getParameter("dtype").toString();%>
<% int id =request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id").toString());%>
<% int priority =request.getParameter("isprior")==null?0:Integer.parseInt(request.getParameter("isprior").toString());
 
String grp =request.getParameter("grp")==null?"0":request.getParameter("grp").toString();
String emp =request.getParameter("emp")==null?"0":request.getParameter("emp").toString();
String mem =request.getParameter("mem")==null?"0":request.getParameter("mem").toString();
String area =request.getParameter("area")==null?"0":request.getParameter("area").toString();
 System.out.println("dtype=="+dtype);
 %>
<style type="text/css">
.redClass {
	background-color: #FFEBEB;
}

.yellowClass {
	background-color: #FFFFD1;
}

.orangeClass {
	background-color: #ffa366;
}
.greenClass {
	background-color: #33ffad;
}

</style>
<script type="text/javascript">
var dtypeval='<%=dtype%>';
var bttnview='<%=bttnview%>';
 var data;
 var exceldata;
 
  data= '<%= sd.serviceScheduleGridLoad(session,dtype,date,branch,clientid,id,priority,grp,emp,mem,area,chkfromdate,fromdate) %>';
  
   exceldata= '<%= sd.serviceScheduleGridLoadExcel(session,dtype,date,branch,clientid,id,priority,grp,emp,mem,area,chkfromdate,fromdate) %>'; 

        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'dtype', type: 'String'  },
     						{name : 'refdocno', type: 'int'  },
     						{name : 'tr_no', type: 'String' },
     						{name : 'site', type: 'String' },
     						{name : 'groupname', type: 'String' },
     						{name : 'refname', type: 'String' },
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
     						
     						{name : 'contractdetails', type: 'String' },
     						{name : 'siteid', type: 'String' },
     						{name : 'areaid', type: 'String' },
     						
     						{name : 'view', type: 'String' },
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
     						{name : 'srtrno', type: 'String' },
     						{name : 'srdocno', type: 'String' },
     						{name : 'branch', type: 'String' },
     						{name : 'workper', type: 'String' },
     						{name : 'srno', type: 'String' },
     						
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
            	
            	
       		 if (data.workper==100) {
                   return "greenClass";
               };
               if (data.gridrow==1) {
                   return "orangeClass";
               };
           };
           
           $("#jqxloaddataGrid").on("bindingcomplete", function (event) {
        	     if(bttnview=='1'){
        	         $('#jqxloaddataGrid').jqxGrid('hidecolumn', 'view');
        	     }else{
        	         $("#jqxloaddataGrid").jqxGrid('showcolumn', 'view');
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
                height: 510,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                //pagermode: 'default',
                sortable: true,
                //Add row method
                columns: [
					{ text: 'PRIORITY',  datafield: 'priority', columntype:'checkbox', width: '5%',cellclassname:cellclassname },     
					{ text: 'DTYPE',columntype: 'textbox', datafield: 'dtype', width: '4%',cellclassname:cellclassname },
					{ text: 'DOC NO',columntype: 'textbox',  datafield: 'refdocno', width: '5%',cellclassname:cellclassname },
					{ text: '',  datafield: 'view',columntype: 'button', width: '4%',cellclassname:cellclassname },
					{ text: 'Sr No.',columntype: 'textbox', datafield: 'srno', width: '4%',cellclassname:cellclassname },
					{ text: 'SCH.NO',columntype: 'textbox', datafield: 'tr_no', width: '4%',cellclassname:cellclassname },
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
					{ text: 'END DATE',columntype: 'textbox',  datafield: 'validupto', width: '6%',cellclassname:cellclassname },
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
					{ text: 'Service Report trno',  datafield:'srtrno', hidden: true, width: '5%' },
					{ text: 'Service Report docno',  datafield: 'srdocno', hidden: true, width: '5%' },
					{ text: 'branch',  datafield:'branch', hidden: true, width: '5%' },
					{ text: 'workper',  datafield:'workper', hidden: true, width: '5%' },
		
	              ]
            });
            $('#jqxloaddataGrid').on('cellclick', function (event) 
            		{ 
		            	var rowindex1=event.args.rowindex;
		            	var datafield = event.args.datafield;
		          
		            	
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
 	
		              
		              
            		 });
             $('#jqxloaddataGrid').on('rowdoubleclick', function (event) 
            		{ 
		            	var rowindex1=event.args.rowindex;
		            	document.getElementById("txtper").value="";
		            	 var srdocno= $('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "srdocno");
		            	 var workper= $('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "workper");
		            	 var schtrno=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "tr_no");
		            	     if(srdocno>0)
			                	{
			                	var test='Service Report No: '+srdocno;
				                
				                document.getElementById("test").innerText=test;
				                document.getElementById("txtper").value=workper;
			                	}
		            	     else{
		            	    	 var test='Schedule No: '+schtrno;
					                
					                document.getElementById("test").innerText=test;
					                document.getElementById("txtper").value="";
		            	     }
		            	     if(workper!=0)
	            	    	 {
	        				 	$('#btnattach').attr("disabled",false);
	            	    	 }
	            	     	 else{
	        				 	$('#btnattach').attr("disabled",true);
	            	     	 }
		            	     if(workper==100)
		            	    	 {
		            	    	 $('#txtper').attr("readonly",true);
		            	    	
		            	    	 $('#btnsave').attr("disabled",true);
		        				 $('#btnconfirm').attr("disabled",false);
		            	    	 }
		            	     else{
		            	    	 $('#txtper').attr("readonly",false);
		            	    	 $('#btnsave').attr("disabled",false);
		        				 $('#btnconfirm').attr("disabled",true);
		            	     }
		            	     var brch=$("#jqxloaddataGrid").jqxGrid('getcellvalue', rowindex1, "branch");
		            
		            	     
		            	     document.getElementById("srdocno").value=srdocno;
				              	document.getElementById("srbrhid").value=brch;

				              	 document.getElementById("rowindex").value=rowindex1;        
		                
		                document.getElementById("txtcustomerdocno").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "docno2");
		              	document.getElementById("txtcustomeracno").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "acno");

		              	document.getElementById("cmbcontracttype").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "dtype");
              	        document.getElementById("txtcontracttrno").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "doctrno");
              			
              	        document.getElementById("txtsiteid").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "siteid");
		              	document.getElementById("txtareaid").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "areaid");
		              	document.getElementById("txtscheduleno").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "tr_no"); 
		              	document.getElementById("servicetype").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "serdocno");	
		              	
		            	document.getElementById("txtsrtrno").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "srtrno"); 
		              	document.getElementById("txtsrdocno").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "srdocno");	
		              
		              	
            		 });
            $("#overlay, #PleaseWait").hide();
            
            
            
        });
    </script>
<div id="jqxloaddataGrid"></div>
