<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page
	import="com.dashboard.projectexecution.assignmentfollowup.ClsAssignmentFollowupDAO"%>
<%
ClsAssignmentFollowupDAO sd=new ClsAssignmentFollowupDAO();
%>

 <% String date =request.getParameter("date")==null?"0":request.getParameter("date").toString();
 String chkfromdate = request.getParameter("chkfromdate")==null?"0":request.getParameter("chkfromdate").trim();
 String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
%>
<% String branch =request.getParameter("barchval")==null?"0":request.getParameter("barchval").toString();%>
 <% String clientid =request.getParameter("clientid")==null?"0":request.getParameter("clientid").toString();%>
 <% int id =request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id").toString());%>
 <% int priority =request.getParameter("isprior")==null?0:Integer.parseInt(request.getParameter("isprior").toString());
 String grp =request.getParameter("grp")==null?"0":request.getParameter("grp").toString();
 String emp =request.getParameter("emp")==null?"0":request.getParameter("emp").toString();
 String mem =request.getParameter("mem")==null?"0":request.getParameter("mem").toString();
 String area =request.getParameter("area")==null?"0":request.getParameter("area").toString();
 %>
<style type="text/css">
.vioClass {
	/* background-color: #FECBE6; */
	background-color: #D8D8FF;
}
</style> 
<script type="text/javascript">

var schedata;
		 schedata= '<%=sd.serCountgrid(session,date,branch,clientid,id,priority,grp,emp,mem,area,chkfromdate)%>'; 

$(document).ready(function () {
	var rendererstring=function (aggregates){
     	var value=aggregates['sum'];
     	
     	if(typeof(value)=='undefined'){
     		value=0;
     	}
     	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + "" + ' ' + value + '</div>';
	}
     	var rendererstring1=function (aggregates){
     	var value1=aggregates['sum1'];
     	return '<div style="float: left; margin: 4px;font-size:10px; overflow: hidden;">' + " Total" + '</div>';
     }
     	
			
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                 	{name : 'status', type: 'string'  },
					{name : 'doc_no', type: 'string'  },
                 	{name : 'count', type: 'string'  }	
						],
				    localdata: schedata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    var cellclassname = function (row, column, value, schedata) {
     	
    	if(typeof(schedata.status) != "undefined" && typeof(schedata.status) != "NaN" && schedata.status != "" && schedata.status=="ALL"){
              return "vioClass";
          };           	   
       };
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#jqxSerCount").jqxGrid(
    {
        width: '100%',
        height: 175,
        source: dataAdapter,
        rowsheight:16,
        showaggregates:true,
        showstatusbar:false,
        statusbarheight: 17,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						{ text: 'Status', datafield: 'status', width: '70%' ,cellclassname:cellclassname,aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
						{ text: 'Count', datafield: 'count', width: '30%',cellclassname:cellclassname, cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'Doc No', datafield: 'doc_no', hidden: true,width: '30%',cellclassname:cellclassname,aggregates: ['sum'],aggregatesrenderer:rendererstring},
					]
    
    });
   
    $('#jqxSerCount').on('rowdoubleclick', function (event) 
    		{ 
    	
    		    var rowindex = event.args.rowindex;
    		    var clientid=$('#clientid').val();
    		    
    			 var date=$('#todate').val();
    			 var barchval = document.getElementById("cmbbranch").value;
    		     var assignstatus=$('#jqxSerCount').jqxGrid('getcellvalue', rowindex, "doc_no");
    		     var id=1;
    		    $("#overlay, #PleaseWait").show();
    		   var isprior=document.getElementById("isprior").value;
    		    
    		   
    			 var grp=document.getElementById("sergroupid").value;
    			 var emp=document.getElementById("grpserempid").value;
    			 var mem=document.getElementById("grpsermemberid").value;
    			 var area=document.getElementById("txtareaid").value;
    		     var bttnview=document.getElementById("bttnview").value;
    		   
    		$("#overlay, #PleaseWait").show();
    		var id=1;
    		$("#serschedulediv").load("serScheduleDetails.jsp?clientid="+clientid+"&date="+date+"&barchval="+barchval+"&assignstatus="+assignstatus+"&id="+id+"&isprior="+isprior+"&grp="+grp+"&emp="+emp+"&mem="+mem+"&area="+area+"&bttnview="+bttnview+"&chkfromdate="+'<%=chkfromdate%>'+"&fromdate="+'<%=fromdate%>');
    				  
    				
    		});
});

function toDate(dateStr) {
    var parts = dateStr.split("-");
    return new Date(parts[2], parts[1] - 1, parts[0]);
}
	
</script>
<div id="jqxSerCount"></div>