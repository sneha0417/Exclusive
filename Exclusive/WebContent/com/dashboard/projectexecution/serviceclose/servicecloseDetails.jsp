
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="com.dashboard.projectexecution.serviceclose.ServiceCloseDAO"%>
<%
ServiceCloseDAO sd=new ServiceCloseDAO();

String dtype = request.getParameter("contracttype")==null?"0":request.getParameter("contracttype");
String clientid = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno"); 
String contractno = request.getParameter("contractno")==null?"0":request.getParameter("contractno"); 
String todate = request.getParameter("date")==null?"0":request.getParameter("date");
String frmdate = request.getParameter("frmdate")==null?"0":request.getParameter("frmdate");
int id=request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
String status = request.getParameter("status")==null?"0":request.getParameter("status");
String barchval = request.getParameter("barchval")==null?"0":request.getParameter("barchval");

%>


<style type="text/css">
.redClass {
	background-color: #FFEBEB;
}

.yellowClass {
	background-color: #FFFFD1;
}

.orangeClass {
	background-color: #FFEBC2;
}
</style>
<script type="text/javascript">
 var data;
 var excelsrvclosedata;
 
  data= '<%= sd.serviceCloseGridLoad(session,dtype,frmdate,todate,contractno,clientid,id,status,barchval) %>';
  excelsrvclosedata= '<%= sd.ExcelserviceCloseGridLoad(session,dtype,frmdate,todate,contractno,clientid,id,status,barchval) %>';
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'dtype', type: 'String'  },
     						{name : 'refdocno', type: 'String'  },
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
     						{name : 'contracttrno', type: 'String' },
     						{name : 'contractdetails', type: 'String' },
     						{name : 'siteid', type: 'String' },
     						{name : 'areaid', type: 'String' },
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
     						{name : 'stat', type: 'String' }
     						
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
                height: 550,
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
					{ text: 'CLIENT NAME',columntype: 'textbox',  datafield: 'refname', width: '14%',cellclassname:cellclassname },
					{ text: 'SCH.NO',columntype: 'textbox', datafield: 'tr_no', width: '6%',cellclassname:cellclassname },
					{ text: 'END DATE',columntype: 'textbox',  datafield: 'validupto', hidden: true, width: '6%',cellclassname:cellclassname },
					{ text: 'AREA',columntype: 'textbox', datafield: 'groupname', width: '10%',cellclassname:cellclassname },
					{ text: 'SITE NAME',columntype: 'textbox', width: '10%', datafield: 'site',cellclassname:cellclassname },
					{ text: 'SERVICE TYPE',columntype: 'textbox', width: '10%', datafield: 'sertype',cellclassname:cellclassname },
					{ text: 'ASSIGN.GROUP',columntype: 'textbox', datafield: 'asgngrp', width: '8%',cellclassname:cellclassname },
					{ text: 'EMPLOYEE',columntype: 'textbox', datafield: 'emp', width: '10%',cellclassname:cellclassname },
					{ text: 'ASSIGN.MODE',columntype: 'textbox', datafield: 'asgnmode', width: '8%',cellclassname:cellclassname },
					{ text: 'STATUS',columntype: 'textbox', datafield: 'stat', width: '8%',cellclassname:cellclassname },
					{ text: 'teampid',columntype: 'textbox', datafield: 'teampid',cellclassname:cellclassname, hidden: true },
					{ text: 'grpid',columntype: 'textbox', datafield: 'grpid',cellclassname:cellclassname, hidden: true },
					{ text: 'empid',columntype: 'textbox', datafield: 'empid',cellclassname:cellclassname, hidden: true },
					{ text: 'asignid',columntype: 'textbox', datafield: 'asignid',cellclassname:cellclassname, hidden: true },
					{ text: 'PLANNED DATE',columntype: 'textbox', hidden: false,  datafield: 'pldate', width: '8%',cellclassname:cellclassname },
					{ text: 'APPR.DATE',columntype: 'textbox',  datafield: 'apprdate', hidden: true, width: '6%',cellclassname:cellclassname },
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
				//	{ text: 'Main Trno',  datafield: 'maintrno', hidden: true, width: '5%' }
					
		
	              ]
            });
          
             $('#jqxloaddataGrid').on('rowdoubleclick', function (event) 
            		{ 
		            	var rowindex1=event.args.rowindex;
		            	
		            
		                var schtrno=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "tr_no");
		                var trno=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "refdocno");
		                var dtype=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "dtype");
		                
		                document.getElementById("rowindex").value=rowindex1;
		                document.getElementById("schtrno").value=schtrno;
		                
		                var test=dtype+ ' No: '+trno+'  Schedule No :'+schtrno;
		                
		                document.getElementById("test").innerText=test;
		                
		               
		              
            		 });
            $("#overlay, #PleaseWait").hide();
        });
    </script>
<div id="jqxloaddataGrid"></div>
