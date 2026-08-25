<%@page import="com.dashboard.analysis.leadAnalysis.ClsLeadAnalysisDAO" %>
<%
ClsLeadAnalysisDAO sd=new ClsLeadAnalysisDAO();
%>


 <% String fromdate =request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").toString();%>
 <% String todate =request.getParameter("todate")==null?"0":request.getParameter("todate").toString();%>
 
 <% String branchval =request.getParameter("branchval")==null?"0":request.getParameter("branchval").toString();%>
 
 <% String filtval =request.getParameter("filtval")==null?"0":request.getParameter("filtval").toString();%>
 <% String grpval =request.getParameter("grpval")==null?"0":request.getParameter("grpval").toString();
%>
 <% String id =request.getParameter("id")==null?"0":request.getParameter("id").toString();
 String docarray=request.getParameter("docarray")==null?"":request.getParameter("docarray");
 %>
<script type="text/javascript">
	
	 var satdata;
	 var bb='<%=id%>';
	if(bb==1){
		satdata= '<%=sd.getStatusCount(fromdate,todate,branchval,filtval,grpval,docarray)%>';
	}
	else{
		satdata=[];
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
                 		{name : 'doc', type: 'string'  },
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
    
    
    $("#jqxLeadCount").jqxGrid(
    {
        width: '100%',
        height: 280,
        source: dataAdapter,
        rowsheight:20,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 20,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						{ text: 'Ref. Name', datafield: 'stat', width: '70%' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
						
						{ text: 'Count', datafield: 'val', width: '30%',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'Doc', datafield: 'doc', width: '10%',hidden:true},
					]
    
    });
   
    $('#jqxLeadCount').on('rowdoubleclick', function (event) 
    		{ 
     
		    $("#overlay, #PleaseWait").show();
		    var rowindex1=event.args.rowindex;
      	  
      	   var docs=$('#jqxLeadCount').jqxGrid('getcellvalue', rowindex1, "doc"); 
	    $("#leadDiv").load("leadAnalysisGrid.jsp?fromdate="+'<%=fromdate%>'+"&todate="+'<%=todate%>'+"&branchval="+'<%=branchval%>'+"&grpval="+'<%=grpval%>'+"&filtval="+'<%=filtval%>'+"&docarray="+'<%=docarray%>'+"&docs="+docs+"&id=2");
    		    

    		});
	$("#overlaysub, #PleaseWaitsub").hide();
});


	
</script>
<div id="jqxLeadCount"></div>