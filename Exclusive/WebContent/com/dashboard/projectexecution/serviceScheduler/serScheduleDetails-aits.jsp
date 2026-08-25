 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@page import="com.dashboard.projectexecution.serviceScheduler.ServiceSchedulerDAO" %>
<%ServiceSchedulerDAO sd=new ServiceSchedulerDAO(); %>
    
 <% String date =request.getParameter("date")==null?"0":request.getParameter("date").toString();%>
 <% String branch =request.getParameter("barchval")==null?"0":request.getParameter("barchval").toString();%>
 <% String clientid =request.getParameter("clientid")==null?"0":request.getParameter("clientid").toString();%>
 <% String site =request.getParameter("site")==null?"0":request.getParameter("site").toString();%>
 <% String area =request.getParameter("area")==null?"0":request.getParameter("area").toString();%>
 <% String dtype =request.getParameter("dtype")==null?"0":request.getParameter("dtype").toString();%>
 <% int id =request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id").toString());%>
 <% int priority =request.getParameter("isprior")==null?0:Integer.parseInt(request.getParameter("isprior").toString()); %>
 <% String bttnview =request.getParameter("bttnview")==null?"0":request.getParameter("bttnview").toString();%>
<style type="text/css">
    .redClass
    {
        background-color: #FFEBEB;
    }
    
    .yellowClass
    {
        background-color: #FFFF00;
    }
    
     .orangeClass
    {
        background-color: #FFEBC2;
    }
    
</style>
 <script type="text/javascript">
 var dtypeval='<%=dtype%>';
 var bttnview='<%=bttnview%>';
 var data;
 var exceldata;
 
  data= '<%= sd.serviceScheduleGridLoad(session,dtype,date,branch,clientid,id,priority,site,area) %>';
  
  exceldata= '<%= sd.serviceScheduleGridExcel(session,dtype,date,branch,clientid,id,priority,site,area) %>';
   
    
        $(document).ready(function () { 	
             
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'dtype', type: 'String'  },
     						{name : 'refdocno', type: 'number'  },
     						{name : 'tr_no', type: 'String' },
     						{name : 'sr_no', type: 'String' },
     						{name : 'site', type: 'String' },
     						{name : 'profomadate', type: 'String' },
     						{name : 'profomarecievedate', type: 'date' },
     						{name : 'sertype', type: 'String' },
     						{name : 'groupname', type: 'String' },
     						{name : 'refname', type: 'String' },
     						{name : 'pldate', type: 'String' },
     						{name : 'pltime', type: 'String' },
     						{name : 'pldte', type: 'String' },
     						{name : 'contr', type: 'String' },
     						{name : 'apprdate', type: 'String' },
     						{name : 'validupto', type: 'String' },
     						{name : 'description', type: 'String' },
     						{name : 'complaint', type: 'String' },
     						{name : 'priority', type: 'String' },
     						{name : 'gridrow', type: 'String' },
     						{name : 'path', type: 'String' },
     						{name : 'name', type: 'String' },
     						{name : 'doctrno', type: 'String' },
     						{name : 'dates', type: 'String' },
     						{name : 'compl', type: 'String' },
     						{name : 'sitecont', type: 'String' },
     						{name : 'branch', type: 'String' },
							{name : 'asngroup', type: 'String' },
     						{name : 'grpid', type: 'String' },
     						
     						
     						 
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
                   return "orangeClass";
               };
               
               if(typeof(data.pldate) != "undefined" && typeof(data.pldate) != "NaN" && data.pldate != ""){
	               var currentdate= new Date(new Date());
	               var planneddate=(data.pldate).split("-");
	               
	               if (parseInt(planneddate[2])==parseInt(currentdate.getFullYear())){
		                if (parseInt(planneddate[1])==parseInt(currentdate.getMonth()+1)) { 
		                   return "yellowClass";
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
                height: 540,
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
                          { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },	
					{ text: 'PRIORITY',  datafield: 'priority', columntype:'checkbox', width: '5%',cellclassname:cellclassname },     
					{ text: 'DTYPE',columntype: 'textbox', datafield: 'dtype', width: '5%',cellclassname:cellclassname },
					{ text: 'DOC NO',columntype: 'textbox',  datafield: 'refdocno', width: '5%',cellclassname:cellclassname },
					{ text: '',  datafield: 'contr',columntype: 'button', width: '4%' },
					{ text: 'SCH.NO',columntype: 'textbox', datafield: 'tr_no', width: '5%',cellclassname:cellclassname,hidden:true },
					{ text: 'SRNO',columntype: 'textbox', datafield: 'sr_no', width: '5%',cellclassname:cellclassname },
					{ text: 'SERVICE TYPE',columntype: 'textbox', width: '10%', datafield: 'sertype',cellclassname:cellclassname },
					{ text: 'COMPLAINT',columntype: 'textbox', width: '10%', datafield: 'compl',cellclassname:cellclassname , hidden: true},
					{ text: 'SITE NAME',columntype: 'textbox', datafield: 'site',cellclassname:cellclassname },
					{ text: 'AREA',columntype: 'textbox', datafield: 'groupname', width: '10%',cellclassname:cellclassname },
					{ text: 'CLIENT NAME',columntype: 'textbox',  datafield: 'refname', width: '18%',cellclassname:cellclassname },
					{ text: 'ASSIGN GROUP',columntype: 'textbox',  datafield: 'asngroup', width: '12%',cellclassname:cellclassname },
					{ text: 'PLAN DATE',columntype: 'textbox',  datafield: 'pldate', width: '7%',cellclassname:cellclassname },
					
					{ text: 'DOC APPROVE DATE',columntype: 'textbox',  datafield: 'apprdate', width: '7%',cellclassname:cellclassname },
					{ text: 'PROFORMA DATE',columntype: 'textbox',  datafield: 'profomadate', width: '6%',cellclassname:cellclassname },
					{ text: 'PROFORMA RECIEVED DATE',columntype: 'textbox',  datafield: 'profomarecievedate', width: '6%',cellclassname:cellclassname, cellsformat: 'dd.MM.yyyy' },
					{ text: 'CONTR. END DATE',columntype: 'textbox',  datafield: 'validupto', width: '7%',cellclassname:cellclassname },
					{ text: 'DESCRIPTION',  datafield: 'description', width: '30%' },
					{ text: 'CALL REGISTER  DATE',columntype: 'textbox',  datafield: 'dates', width: '10%',cellclassname:cellclassname,hidden:true },
					{ text: 'COMPLAINT',columntype: 'textbox',  datafield: 'complaint',cellclassname:cellclassname,hidden:true },
					{ text: 'cmpldate',columntype: 'textbox',  datafield: 'pldte', width: '10%',hidden:true,cellclassname:cellclassname },
					{ text: 'gridrow',columntype: 'textbox',  datafield: 'gridrow', width: '10%',hidden:true,cellclassname:cellclassname },
					{ text: 'Path',  datafield: 'path', hidden: true, width: '5%' },
					{ text: 'name',  datafield: 'name', hidden: true, width: '5%' },
					{ text: 'doctrno',  datafield: 'doctrno', hidden: true, width: '5%' },
					{ text: 'SITE CONTACT',  datafield: 'sitecont', hidden: true, width: '5%' },
					{ text: 'branch',  datafield:'branch', hidden: true, width: '5%' },
					{ text: 'grpid',columntype: 'textbox', datafield: 'grpid',cellclassname:cellclassname, hidden: true },
					
		
	              ]
            });
            
            
            $('#jqxloaddataGrid').on('cellclick', function (event) 
            		{ 
		            	var rowindex1=event.args.rowindex;
		            	var datafield = event.args.datafield;
		            	
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

             $('#jqxloaddataGrid').on('rowdoubleclick', function (event) 
            		{ 
		            	var rowindex1=event.args.rowindex;
			document.getElementById("txtgroup").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "asngroup");
              	        document.getElementById("groupid").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "grpid");		            	

		                var dtime= $('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "pldate").split(' ');
		                var trno= $('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "refdocno");
		                var srno= $('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "tr_no");
		                var dtype= $('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "dtype");
		                var pldte=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "pldte");
		                

		                var pldate=dtime[0];
		                var pltime=dtime[1];
		                
		                //document.getElementById("txtpdate").value=pldate;
		                 if(dtype!='CREG'){
		                	 $('#adate').val(new Date());
				             $('#atime').val(new Date());
		                	 /* $('#adate').jqxDateTimeInput('val',pldte);
		                	 $('#atime').jqxDateTimeInput('val',pltime); */
		                 }
		                //document.getElementById("txtptime").value=pltime;
		                document.getElementById("trno").value=trno;
		                document.getElementById("rowindex").value=rowindex1;
		                document.getElementById("srno").value=srno;
		                document.getElementById("dtype").value=dtype;
		                document.getElementById("doccno").value=trno;
		                var test=dtype+ ' No: '+trno+'  Schedule No :'+srno;
		                
		    			document.getElementById("test").innerText=test;
		               
		              
            		 });
            	$("#overlay, #PleaseWait").hide();
        });
    </script>
    <div id="jqxloaddataGrid"></div>
