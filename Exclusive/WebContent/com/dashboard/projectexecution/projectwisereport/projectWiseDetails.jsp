 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@page import="com.dashboard.projectexecution.projectwisereport.ClsProjectwiseReport" %>
<%ClsProjectwiseReport sd=new ClsProjectwiseReport(); %>
     

 <% String date =request.getParameter("date")==null?"0":request.getParameter("date").toString();%>
 <% String frmdate =request.getParameter("frmdate")==null?"0":request.getParameter("frmdate").toString();%>
 <% String branch =request.getParameter("barchval")==null?"0":request.getParameter("barchval").toString();%>
 <% String clientid =request.getParameter("clientid")==null?"0":request.getParameter("clientid").toString();%>
 <% String dtype =request.getParameter("dtype")==null?"0":request.getParameter("dtype").toString();%>
 <% int id =request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id").toString());%>
 <% int check =request.getParameter("check")==null?0:Integer.parseInt(request.getParameter("check").toString());%>
 <% String cstatus =request.getParameter("cstatus")==null?"0":request.getParameter("cstatus").toString();
 
 %>
<style type="text/css">
    .redClass
    {
        background-color: #FFEBEB;
    }
    
    .yellowClass
    {
        background-color: #FFFFD1;
    }
    
     .orangeClass
    {
        background-color: #FFEBC2;
    }
    
</style>
 <script type="text/javascript">
 var pdata,exdata;
 var id='<%=id%>'; 
 
 var rendererstring=function (aggregates){
	  	var value=aggregates['sum'];
	  	
	  	if(typeof(value)=='undefined'){
	  		value=0;
	  	}
	  	return '<div style="float: left; margin: 4px;font-size:12px; overflow: hidden;">' + "" + ' ' + value + '</div>';
		}
	  	var rendererstring1=function (aggregates){
	  	var value1=aggregates['sum1'];
	  	return '<div style="float: left; margin: 4px;font-size:12px; overflow: hidden;">' + " Total" + '</div>';
	  }
 
 if(id>0){
	 pdata= '<%= sd.projectwiseGridLoad(session, dtype, date,branch,clientid,id,cstatus,frmdate,check) %>'; 
	 exdata= '<%= sd.projectwiseExcelLoad(session, dtype, date,branch,clientid,id,cstatus,frmdate,check) %>';
 }
    
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          
							{name : 'dtype', type: 'String'  },
     						{name : 'docno', type: 'String'  },
     						{name : 'trno', type: 'String' },
     						{name : 'client', type: 'String' },
     						{name : 'status', type: 'String' },
     						{name : 'sdate', type: 'String' },
     						{name : 'edate', type: 'String' },
     						{name : 'cntrval', type: 'number' },
     						{name : 'invoiced', type: 'number' },
     						{name : 'collected', type: 'number' },
     						{name : 'balance', type: 'number'},
     						{name : 'blinvamt', type: 'number'},
     						{name : 'site', type: 'String' },
     						{name : 'siteadd', type: 'String' },
     			  ],
                 localdata: pdata,
                
                
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
            $("#jqxprojectwiseGrid").jqxGrid(
            {
                width: '99.5%',
                height: 500,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                showaggregates:true,
                showstatusbar:true,
                statusbarheight: 25,
                sortable: true,
                //Add row method
                columns: [
                          
					{ text: 'CONTR.TYPE',columntype: 'textbox', datafield: 'dtype', width: '7%',cellclassname:cellclassname },
					{ text: 'CONTRACT NO',columntype: 'textbox',  datafield: 'docno', width: '7%',cellclassname:cellclassname },
					{ text: 'STATUS',columntype: 'textbox',  datafield: 'status', width: '6%',cellclassname:cellclassname },
					{ text: 'CLIENT NAME',columntype: 'textbox',  datafield: 'client', width: '12%',cellclassname:cellclassname },
					{ text: 'SITE', datafield: 'site', width: '10%' },
				//	{ text: 'SITE DETAILS', datafield: 'siteadd', width: '12%' },
					{ text: 'START DATE',columntype: 'textbox',  datafield: 'sdate', width: '7%',cellclassname:cellclassname },
					{ text: 'END DATE',columntype: 'textbox',  datafield: 'edate', width: '7%',cellclassname:cellclassname,aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
					{ text: 'CONTRACT AMOUNT',columntype: 'textbox',  datafield: 'cntrval', width: '10%',cellclassname:cellclassname, cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
					{ text: 'INVOICED AMOUNT',columntype: 'textbox',  datafield: 'invoiced', width: '10%',cellclassname:cellclassname, cellsformat: 'd2', cellsalign: 'right', align: 'right' ,aggregates: ['sum'],aggregatesrenderer:rendererstring },
					{ text: 'COLLECTED AMOUNT',columntype: 'textbox',  datafield: 'collected', width: '10%',cellclassname:cellclassname, cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
					{ text: 'INVOICE BALANCE',columntype: 'textbox',  datafield: 'balance', width: '9%',cellclassname:cellclassname, cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
					{ text: 'TO BE INVOICED',columntype: 'textbox',  datafield: 'blinvamt', width: '10%',cellclassname:cellclassname, cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring }
		
	              ]
            });

             $('#jqxprojectwiseGrid').on('rowdoubleclick', function (event) 
            		{ 
		            	var rowindex1=event.args.rowindex;
		            	
		           
            		 });
            $("#overlay, #PleaseWait").hide();
        });
    </script>
    <div id="jqxprojectwiseGrid"></div>
