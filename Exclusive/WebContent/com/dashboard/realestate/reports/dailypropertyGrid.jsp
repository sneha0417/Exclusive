<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.realestate.reports.ClsReportsDAO"%>
<% ClsReportsDAO DAO= new ClsReportsDAO(); %>
<%   
	String id = request.getParameter("id")==null || request.getParameter("id")==""?"0":request.getParameter("id").trim();
%>

<script type="text/javascript">
       var dprodata;  
       var id='<%=id%>';
       if(id=="1"){
    	   dprodata='<%=DAO.dproData(id)%>';   
       }else{
    	   dprodata = '[{"columns":[{"text":"","datafield":"name","width":"64%"},{"text":"","datafield":"month1","width":"6%"},{"text":"","datafield":"month2","width":"6%"},{"text":"","datafield":"month3","width":"6%"},{"text":"","datafield":"month4","width":"6%"},{"text":"","datafield":"month5","width":"6%"},{"text":"","datafield":"month6","width":"6%"}]},{"rows":[{"name":"","month1":"","month2":"","month3":"","month4":"","month5":"","month6":""}]}]';
       }
       var obj = $.parseJSON(dprodata);
       var columns = obj[0].columns;
       var rows = obj[1].rows; 
$(document).ready(function () {   
	
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
							{name : 'month1', type: 'String'  },
							{name : 'month2', type: 'String'  },
							{name : 'month3', type: 'String'  },
							{name : 'month4', type: 'String'  },
							{name : 'month5', type: 'String'  },
							{name : 'month6', type: 'String'  }, 
							{name : 'name', type: 'String'  }, 
						],
				    localdata: rows,   
        
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
    
    $("#jqxdprogrid").jqxGrid(
    {
        width: '100%',
        height: 252,    
        columns: columns,
        source: dataAdapter,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        columnsresize: true,
       	selectionmode: 'singlecell',                      
       	showfilterrow: true,
        sortable:true,                                
        pagermode: 'default',   
     });
    $('#jqxdprogrid').on('celldoubleclick', function (event){ 
       	var rowindex=event.args.rowindex;
       	var datafield = event.args.datafield;  
       	var name=$('#jqxdprogrid').jqxGrid('getcellvalue', rowindex, "name");
       	if(datafield=="month1"){   
	       		var mtype="M1";
	       		activityselection(name,mtype);  
   	    }
       	if(datafield=="month2"){           
	       		var mtype="M2";
	       		activityselection(name,mtype);  
       	    }
       	if(datafield=="month3"){   
	       		var mtype="M3";
	       		activityselection(name,mtype);  
       	    }
       	if(datafield=="month4"){   
	       		var mtype="M4";
	       		activityselection(name,mtype);  
       	    }
       	if(datafield=="month5"){   
	       		var mtype="M5";
	       		activityselection(name,mtype);  
       	    }
       	if(datafield=="month6"){              
	       		var mtype="M6";     
	       		activityselection(name,mtype);     
          }
	}); 
});
function activityselection(name,mtype){      
	if(name=="New property added"){
		    $("#hidestatistics1").show();$("#hidestatistics2").hide();$("#hidestatistics3").hide(); 
	        $("#hidestatistics4").hide();$("#hidestatistics5").hide();$("#hidestatistics6").hide();
	   		var type="PRO"; 
	        fundailyactivitydetails(type,mtype);      
	   }else if(name=="Contracted New"){ 
		    $("#hidestatistics1").hide();$("#hidestatistics2").show();$("#hidestatistics3").hide(); 
		    $("#hidestatistics4").hide();$("#hidestatistics5").hide();$("#hidestatistics6").hide();
	   		var type="CON"; 
	        fundailyactivitydetails(type,mtype);      
	   }else if(name=="Tenancy Renewal"){ 
		    $("#hidestatistics1").hide();$("#hidestatistics2").hide();$("#hidestatistics3").show(); 
		    $("#hidestatistics4").hide();$("#hidestatistics5").hide();$("#hidestatistics6").hide();
	   		var type="TNR"; 
	        fundailyactivitydetails(type,mtype);      
	   }else if(name=="Tenant Requested"){  
		    $("#hidestatistics1").hide();$("#hidestatistics2").hide();$("#hidestatistics3").hide(); 
		    $("#hidestatistics4").show();$("#hidestatistics5").hide();$("#hidestatistics6").hide();
	   		var type="TRQ"; 
	        fundailyactivitydetails(type,mtype);      
	   }else if(name=="Tenant Requested Completed"){
		    $("#hidestatistics1").hide();$("#hidestatistics2").hide();$("#hidestatistics3").hide(); 
		    $("#hidestatistics4").hide();$("#hidestatistics5").show();$("#hidestatistics6").hide();
	   		var type="TRC"; 
	        fundailyactivitydetails(type,mtype);      
	   }else if(name=="Inspected"){
		    $("#hidestatistics1").hide();$("#hidestatistics2").hide();$("#hidestatistics3").hide(); 
		    $("#hidestatistics4").hide();$("#hidestatistics5").hide();$("#hidestatistics6").show();    
	   		var type="INS"; 
	        fundailyactivitydetails(type,mtype);      
	   }else if(name=="Scheduled(Not executed)"){
		    $("#hidestatistics1").hide();$("#hidestatistics2").hide();$("#hidestatistics3").hide(); 
		    $("#hidestatistics4").hide();$("#hidestatistics5").hide();$("#hidestatistics6").hide();    
	   }else if(name=="Skipped"){  
		    $("#hidestatistics1").hide();$("#hidestatistics2").hide();$("#hidestatistics3").hide(); 
		    $("#hidestatistics4").hide();$("#hidestatistics5").hide();$("#hidestatistics6").show();    
	   		var type="SKP"; 
	        fundailyactivitydetails(type,mtype);         
	   }else{}                 
}
</script>
<div id="jqxdprogrid"></div>  