<%@page import="com.project.execution.estimation.ClsEstimationDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%ClsEstimationDAO DAO= new ClsEstimationDAO(); %>
<% String aid = request.getParameter("aid")==null?"0":request.getParameter("aid");
   String sid = request.getParameter("sid")==null?"0":request.getParameter("sid");
   String pid = request.getParameter("pid")==null?"0":request.getParameter("pid");
   int trno = request.getParameter("trno")==null?0:Integer.parseInt(request.getParameter("trno").trim());
   %> 
           	  
<style type="text/css">
      
   .greyClass
   {
       background-color: #E0ECF8;
   }
</style>

<script type="text/javascript">
	 var data4;
	 var trno='<%=trno%>';
	
	  if(trno>0){
		  data4= '<%=DAO.activityReLoad(session,trno)%>';
	  }
	  else{
		  data4= '<%=DAO.loadActivity(session,aid,sid,pid)%>';
	  }
		
    
$(document).ready(function () {
	
        var cellclassname = function (row, column, value, data) {
 
            if (value=='All' || value=='') {
                   return "greyClass";
             }
          };
        
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
					{name : 'tr_no', type: 'int'},  
					{name : 'doc_no', type: 'int'},
					{name : 'project', type: 'string'  },
					{name : 'projectid', type: 'string'   },
					{name : 'section', type: 'string'  },
					{name : 'sectionid', type: 'string'   },
					{name : 'activity', type: 'string'  },
					{name : 'activityid', type: 'string'   },
						
					],
				    localdata: data4,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    $("#activityDetailsGridID").on("bindingcomplete", function (event) {
     	
    	$("#activityDetailsGridID").jqxGrid('selectallrows');
    	var rowlen = $("#activityDetailsGridID").jqxGrid('selectedrowindexes');
    	 if(rowlen.length>0){
 
    	 var aid=0;
    	 for(var i=0 ; i < rowlen.length; i++){
    		 
    	  var row = $("#activityDetailsGridID").jqxGrid('getrowdata', rowlen[i]);
    		 
    		 aid=aid+row.tr_no+",";
   
  		}
    	 aid=aid.replace(/,(?=[^,]*$)/, '');
 	    document.getElementById("activitiesid").value=aid;
    	 }
         });
  
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#activityDetailsGridID").jqxGrid(
    {
        width: '100%',
        height: 320,
        source: dataAdapter,
        rowsheight:20,
        //selectionmode: 'singlerow',
        selectionmode: 'checkbox',
        pagermode: 'default',
       
        columns: [
						   { text: 'Activity', datafield: 'activity', width: '35%'},
                            { text: 'Project', datafield: 'project', width: '30%'},
                            { text: 'Projectid', datafield: 'projectid', width: '10%',hidden:true},
    						{ text: 'Section', datafield: 'section', width: '30%'},
    						{ text: 'sectionid', datafield: 'sectionid', width: '10%',hidden:true},
    						{ text: 'tr_no', datafield: 'tr_no', width: '10%',hidden:true}
					]
    
    });
    
    $("#overlay, #PleaseWait").hide();    
    		
    /* $('#activityDetailsGridID').on('rowdoubleclick', function (event) {
    	var boundIndex = event.args.rowindex;
    	
    	var dtype = $('#activityDetailsGridID').jqxGrid('getcelltext',boundIndex, "dtype");
	    
    	$("#overlay, #PleaseWait").show();
    	
	    $("#workOrderStatusDiv").load("workOrderStatusGrid.jsp?fromdate="+from+"&todate="+to+"&branchval="+temp1+"&dtype="+dtype);
       	
    });  */
    
});

	
	
</script>
<div id="activityDetailsGridID"></div>