 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@page import="com.dashboard.analysis.pendingcontract.ClsPendingContract" %>
<%ClsPendingContract sd=new ClsPendingContract(); %>
     

 <% String date =request.getParameter("date")==null?"0":request.getParameter("date").toString();%>
 <% String branch =request.getParameter("barchval")==null?"0":request.getParameter("barchval").toString();%>
 <% String clientid =request.getParameter("clientid")==null?"0":request.getParameter("clientid").toString();%>
 <% String dtype =request.getParameter("dtype")==null?"0":request.getParameter("dtype").toString();%>
 <% int id =request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id").toString());%>
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
 var pcdata;
 var pendingdataexcel;
 var id='<%=id%>'; 
 
 var rendererstring=function (aggregates){
	  	var value=aggregates['sum'];
	  	
	  	if(typeof(value)=='undefined'){
	  		value=0;
	  	}
	  	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "" + ' ' + value + '</div>';
		}
	  	var rendererstring1=function (aggregates){
	  	var value1=aggregates['sum1'];
	  	return '<div style="float: left; margin: 4px;font-size:12px; overflow: hidden;">' + " Total" + '</div>';
	  }
 
 if(id>0){
	 pcdata= '<%= sd.pendingContractGridLoad(session, dtype, date,branch,clientid,id,cstatus) %>'; 
	 pendingdataexcel= '<%= sd.pendingContractGridLoadExcel(session, dtype, date,branch,clientid,id,cstatus) %>';
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
     						{name : 'dueno', type: 'String' },
     						{name : 'cntramt',type: 'number' },
     						{name : 'dueamt',type: 'number' },
     						{name : 'site',type: 'number' },
     						
     						
     			  ],
                 localdata: pcdata,
                
                
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
            $("#jqxpendcontrGrid").jqxGrid(
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
                          
					{ text: 'CONTR.TYPE',columntype: 'textbox', datafield: 'dtype', width: '8%',cellclassname:cellclassname },
					{ text: 'CONTRACT NO',columntype: 'textbox',  datafield: 'docno', width: '8%',cellclassname:cellclassname },
					{ text: 'CONTRACT AMOUNT',columntype: 'textbox',  datafield: 'cntramt', width: '10%',cellclassname:cellclassname, cellsformat: 'd2', cellsalign: 'right', align: 'right' },
					{ text: 'STATUS',columntype: 'textbox',  datafield: 'status', width: '7%',cellclassname:cellclassname },
					{ text: 'CLIENT NAME',columntype: 'textbox',  datafield: 'client', width: '16%',cellclassname:cellclassname },
					{ text: 'SITE',columntype: 'textbox',  datafield: 'site', width: '15%',cellclassname:cellclassname },
				//	{ text: 'SITE DETAILS',columntype: 'textbox',  datafield: 'siteadd', width: '12%',cellclassname:cellclassname },
					{ text: 'START DATE',columntype: 'textbox',  datafield: 'sdate', width: '8%',cellclassname:cellclassname },
					{ text: 'END DATE',columntype: 'textbox',  datafield: 'edate', width: '8%',cellclassname:cellclassname },
					{ text: 'PENDING DUES',columntype: 'textbox',  datafield: 'dueno', width: '8%',cellclassname:cellclassname,aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
					{ text: 'PENDING DUE AMOUNT',columntype: 'textbox',  datafield: 'dueamt', width: '12%',cellclassname:cellclassname, cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
					
		
	              ]
            });

             $('#jqxpendcontrGrid').on('rowdoubleclick', function (event) 
            		{ 
		            	var rowindex1=event.args.rowindex;
		            	
		           
            		 });
            $("#overlay, #PleaseWait").hide();
        });
    </script>
    <div id="jqxpendcontrGrid"></div>
