<%@page import="com.dashboard.analysis.activityanalysis.ClsActivityAnalysisDAO" %>
<% ClsActivityAnalysisDAO aa=new ClsActivityAnalysisDAO(); %>
<% int id =request.getParameter("test")==null?0:Integer.parseInt(request.getParameter("test").toString());
   String userid =request.getParameter("user")==null?"0":request.getParameter("user").toString();
   String highlight =request.getParameter("high")==null?"0":request.getParameter("high").toString();%>
<style type="text/css">
        .blueClass
        {
            background-color: #EBF5FB;
        }
        .whiteClass
        {
           background-color: #FFFFFF;
        }
</style>
<script type="text/javascript">
	
	 var data4;
	 var check='<%= id%>';
	 var userid='<%= userid%>';
	 var highlight='<%= highlight%>';
	if(check==1){
	  data4= '<%= aa.countGridData(userid,highlight)%>';
	 } 
	 else{
		 data4;
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
                    
                 	    {name : 'user_name', type: 'string'  },
                 		{name : 'userid', type: 'string'  },
                 		{name : 'submitted', type: 'string'  },
                 		],
				    localdata: data4,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    var cellclassname = function (row, column, value, data) {
		if (data.user_name == 'ALL') {
            return "blueClass";
        } else{
        	return "whiteClass";
        };
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
        showaggregates:false,
        showstatusbar:false,
        statusbarheight: 20,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						{ text: 'User Name', datafield: 'user_name', width: '70%', cellclassname: cellclassname,aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
						{ text: 'Submitted', datafield: 'submitted', width: '30%', cellclassname: cellclassname,aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'User ID', datafield: 'userid', width: '30%',hidden:true},
						
					]
    
    });
    $('#jqxCount').on('rowdoubleclick', function (event) 
    		{ 
    	var boundIndex = event.args.rowindex;
	  
    	$("#overlay, #PleaseWait").show();
	    
    	var userid=$('#jqxCount').jqxGrid('getcelltext',boundIndex, "userid");   
	    var submitted=$('#jqxCount').jqxGrid('getcelltext',boundIndex, "submitted");	
	    $("#activitygrid1").load("activityGrid.jsp?user="+userid+"&val="+submitted+"&test="+1);
	   
    });
   
});


	
</script>
<div id="jqxCount"></div>