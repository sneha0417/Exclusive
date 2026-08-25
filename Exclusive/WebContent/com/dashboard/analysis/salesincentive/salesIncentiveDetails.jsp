 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@page import="com.dashboard.analysis.salesincentive.ClsSalesIncentive" %>
<%ClsSalesIncentive sd=new ClsSalesIncentive(); %>
     

 <% String date =request.getParameter("date")==null?"0":request.getParameter("date").toString();%>
 <% String frmdate =request.getParameter("frmdate")==null?"0":request.getParameter("frmdate").toString();%>
 <% String branch =request.getParameter("barchval")==null?"0":request.getParameter("barchval").toString();%>
 <% String clientid =request.getParameter("clientid")==null?"0":request.getParameter("clientid").toString();%>
 <% String dtype =request.getParameter("dtype")==null?"0":request.getParameter("dtype").toString();%>
 <% int id =request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id").toString());%>
 <% String radval =request.getParameter("radval")==null?"0":request.getParameter("radval").toString();
 String salid =request.getParameter("salid")==null?"0":request.getParameter("salid").toString();
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
 var saldata;
 var id='<%=id%>'; 
 var radval='<%=radval%>';
 
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
	 saldata= '<%= sd.salesIncentiveGridLoad(session, dtype, date,branch,clientid,id,radval,salid,frmdate) %>'; 
 }
    
        $(document).ready(function () {
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                             

							{name : 'dtype', type: 'String'  },
     						{name : 'docno', type: 'String'  },
     						{name : 'client', type: 'String' },
     						{name : 'salname', type: 'String' },
     						{name : 'sdate', type: 'String' },
     						{name : 'edate', type: 'String' },
     						{name : 'dueno', type: 'String' },
     						{name : 'cntramt',type: 'number' },
     						{name : 'invamt',type: 'number' },
     						{name : 'cntrincamt',type: 'number' },
     						{name : 'salincamt',type: 'number' },
     						{name : 'site', type: 'String' },
     						{name : 'siteadd', type: 'String' },
     						
     						
     			  ],
                 localdata: saldata,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            $("#jqxsalincGrid").on("bindingcomplete", function (event) {
            	
            	// your code here.
            if(radval=="2"){
            	$('#jqxsalincGrid').jqxGrid('setcolumnproperty','dtype','hidden',true);
            	$('#jqxsalincGrid').jqxGrid('setcolumnproperty','docno','hidden',true);
            	$('#jqxsalincGrid').jqxGrid('setcolumnproperty','client','hidden',true);
            	$('#jqxsalincGrid').jqxGrid('setcolumnproperty','cntramt','hidden',true);
            	//$('#jqxsalincGrid').jqxGrid('setcolumnproperty','invamt','hidden',true);
            	$('#jqxsalincGrid').jqxGrid('setcolumnproperty','sdate','hidden',true);
            	$('#jqxsalincGrid').jqxGrid('setcolumnproperty','edate','hidden',true);
            	
            }	
            });                       

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
            $("#jqxsalincGrid").jqxGrid(
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
                       
                    { text: 'SALES MAN',columntype: 'textbox',  datafield: 'salname',cellclassname:cellclassname ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
                    { text: 'INCENTIVE AMOUNT',columntype: 'textbox',  datafield: 'salincamt', width: '10%',cellclassname:cellclassname, cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
					{ text: 'CONTR.TYPE',columntype: 'textbox', datafield: 'dtype', width: '8%',cellclassname:cellclassname },
					{ text: 'CONTRACT NO',columntype: 'textbox',  datafield: 'docno', width: '8%',cellclassname:cellclassname },
					{ text: 'CLIENT NAME',columntype: 'textbox',  datafield: 'client', width: '15%',cellclassname:cellclassname },
					{ text: 'SITE',columntype: 'textbox',  datafield: 'site', width: '13%',cellclassname:cellclassname },
				//	{ text: 'SITE DETAILS',columntype: 'textbox',  datafield: 'siteadd', width: '10%',cellclassname:cellclassname },
					{ text: 'CONTRACT AMOUNT',columntype: 'textbox',  datafield: 'cntramt', width: '10%',cellclassname:cellclassname, cellsformat: 'd2', cellsalign: 'right', align: 'right' },
					{ text: 'INVOICE AMOUNT',columntype: 'textbox',  datafield: 'invamt', width: '10%',cellclassname:cellclassname, cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
					{ text: 'START DATE',columntype: 'textbox',  datafield: 'sdate', width: '6%',cellclassname:cellclassname },
					{ text: 'END DATE',columntype: 'textbox',  datafield: 'edate', width: '6%',cellclassname:cellclassname }
					
		
	              ]
            });

             $('#jqxsalincGrid').on('rowdoubleclick', function (event) 
            		{ 
		            	var rowindex1=event.args.rowindex;
		            	
		           
            		 });
            $("#overlay, #PleaseWait").hide();
        });
    </script>
    <div id="jqxsalincGrid"></div>
