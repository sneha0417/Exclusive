<%@page import="com.dashboard.analysis.amcexpirystatus.amcExpiryStatusDAO" %>
<%
	amcExpiryStatusDAO sd=new amcExpiryStatusDAO();
%>


 <% String fromdate =request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").toString();%>
 <% String todate =request.getParameter("todate")==null?"0":request.getParameter("todate").toString();%>
 
 <% String barchval =request.getParameter("barchval")==null?"0":request.getParameter("barchval").toString();%>
 
 
<script type="text/javascript">
	
	 var satdata;
	 var bb='<%=barchval%>';
	if(bb!='0'){
		satdata= '<%=sd.getStatusCount(fromdate,todate,barchval)%>';
	}
	else{
		bb=1;
	}
	

$(document).ready(function () {
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

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                 	{name : 'stat', type: 'string'  },
                 		{name : 'val', type: 'string'  },
                 		{name : 'rds', type: 'string'  }
						
						],
				    localdata: satdata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#jqxCount").jqxGrid(
    {
        width: '100%',
        height: 250,
        source: dataAdapter,
        rowsheight:20,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 20,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						{ text: 'Status', datafield: 'stat', width: '70%' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
						
						{ text: 'Count', datafield: 'val', width: '30%',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'relodestatus', datafield: 'rds', width: '30%',hidden:true},
						
					]
    
    });
   
    $('#jqxCount').on('rowdoubleclick', function (event) 
    		{ 
    	

	    var boundIndex = event.args.rowindex;
	    

	    $("#overlay, #PleaseWait").show();
	    var relodestatus = $('#jqxCount').jqxGrid('getcelltext',boundIndex, "rds");

	    $("#loadgriddata").load("gridDetails.jsp?rds="+relodestatus+"&froms="+'<%=fromdate%>'+"&tos="+'<%=todate%>'+"&barchval="+'<%=barchval%>');
    		    

    		});
});


	
</script>
<div id="jqxCount"></div>