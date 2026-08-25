<%@page import="com.project.execution.surveyDetails.ClsSurveyDetailsDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%ClsSurveyDetailsDAO DAO= new ClsSurveyDetailsDAO(); %>
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
		  data4= '<%=DAO.serTypeReLoad(session,trno)%>';
	  }
	  else{
		  data4= '<%=DAO.loadSertype(session,aid,sid,pid)%>';
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
                    
					{name : 'doc_no', type: 'int'},
					{name : 'servtype', type: 'string'  },
						
					],
				    localdata: data4,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    $("#servtypeDetailsGridID").on("bindingcomplete", function (event) {
     	
    	if(trno>0){
    	$("#servtypeDetailsGridID").jqxGrid('selectallrows');
    	var rowlen = $("#servtypeDetailsGridID").jqxGrid('selectedrowindexes');
    	 if(rowlen.length>0){
    		 
    	 var aid=0;
    	 for(var i=0 ; i < rowlen.length; i++){
    		 
    	  var row = $("#servtypeDetailsGridID").jqxGrid('getrowdata', rowlen[i]);
    		 
    		 aid=aid+row.doc_no+",";
   
  		}
    	 aid=aid.replace(/,(?=[^,]*$)/, '');
 	    document.getElementById("sertypeids").value=aid;
 	   $("#sertypeDiv").load("ServiceTypeGrid.jsp?docno="+docno+"&sid="+aid);
 	   
 	  loadSubmit();
    	 }
    	}
         });
  
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#servtypeDetailsGridID").jqxGrid(
    {
        width: '100%',
        height: 250,
        source: dataAdapter,
        rowsheight:20,
        //selectionmode: 'singlerow',
        selectionmode: 'checkbox',
        pagermode: 'default',
       
        columns: [
						   { text: 'Service Type', datafield: 'servtype', width: '92%'},
    						{ text: 'doc_no', datafield: 'doc_no', width: '10%',hidden:true}
					]
    
    });
    
    $("#overlay, #PleaseWait").hide();    
    		
    /* $('#servtypeDetailsGridID').on('rowdoubleclick', function (event) {
    	var boundIndex = event.args.rowindex;
    	
    	var dtype = $('#servtypeDetailsGridID').jqxGrid('getcelltext',boundIndex, "dtype");
	    
    	$("#overlay, #PleaseWait").show();
    	
	    $("#workOrderStatusDiv").load("workOrderStatusGrid.jsp?fromdate="+from+"&todate="+to+"&branchval="+temp1+"&dtype="+dtype);
       	
    });  */
    
});

	
	
</script>
<div id="servtypeDetailsGridID"></div>