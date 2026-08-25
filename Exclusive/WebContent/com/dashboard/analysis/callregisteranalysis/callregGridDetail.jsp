 <%@ page import="com.dashboard.analysis.callregisteranalysis.ClscallregisterAnalysisDAO" %>
 
 <%
    String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  	
  	ClscallregisterAnalysisDAO cab=new ClscallregisterAnalysisDAO();
  	
 %> 
    <% String clientid =request.getParameter("clientid")==null?"0":request.getParameter("clientid").toString();%>
 <% String type =request.getParameter("type")==null?"0":request.getParameter("type").toString();%>
 <% String summtype =request.getParameter("summtype")==null?"0":request.getParameter("summtype").toString();%>
 
 <% String repeat =request.getParameter("repeated")==null?"0":request.getParameter("repeated").toString();%>
 <% String vehno =request.getParameter("vehno")==null?"0":request.getParameter("vehno").toString();%>
         	  
 
<script type="text/javascript">
 var temp4='<%=barchval%>';
 var summtype='<%=summtype%>';
 //alert(summtype);
var datas21,exceldata;

 if(temp4!='NA')
{ 
	 datas21='<%=cab.detgridload(barchval,fromdate,todate,clientid,vehno,type,repeat,summtype)%>'; 
	 exceldata='<%=cab.detgridloadexcel(barchval,fromdate,todate,clientid,vehno,type,repeat)%>';
	 
	 
	// alert(datas21);
} 
else
{ 
	
	datas21;
	
	} 
$(document).ready(function () {
	
    var source =   
    {
        datatype: "json",
        datafields: [   
						{name : 'tr_no', type: 'number'  },
						{name : 'brhid', type: 'number'  },
                 	    {name : 'cregno', type: 'number'  },
					    {name : 'date', type: 'date' },
					    {name : 'user', type: 'String'  },
						{name : 'type', type: 'String' },
						{name : 'remarks', type: 'String' },
						{name : 'repeated', type: 'String' },
						{name : 'vehicle', type: 'String' },
						{name : 'client', type: 'String' },
						{name : 'status', type: 'String' },
						{name : 'callby', type: 'String' },
						{name : 'mob', type: 'String' },
						{name : 'groupname', type: 'String' },
						{name : 'member', type: 'String' },
						{name : 'tottime', type: 'number' },
						{name : 'overdue', type: 'number' }
						],
				    localdata: datas21,
        
        
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
    $("#callregisterDetGridID").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filterable: true,
        showfilterrow: true,
        sortable:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        columns: [   
                  { text: 'Creg No',width: '5%', datafield: 'cregno'},
                  { text: 'TR_NO',width: '8%', datafield: 'tr_no',hidden:true},
                  { text: 'brhid',width: '8%', datafield: 'brhid',hidden:true},
                  { text: 'Date',width: '6%', datafield: 'date',cellsformat:'dd.MM.yyyy'},
                  { text: 'User',width: '6%', datafield: 'user'},
                  { text: 'Type',width: '8%', datafield: 'type'},
                  { text: 'Remarks',width: '25%', datafield: 'remarks'},
                  { text: 'Repeated',width: '5%', datafield: 'repeated'},
                  { text: 'Vehicle',width: '7%', datafield: 'vehicle'},
                  { text: 'Client',width: '20%', datafield: 'client'},
                  { text: 'Called By',width: '8%', datafield: 'callby'},
                  { text: 'Mobile No',width: '7%', datafield: 'mob'},
                  { text: 'Status',width: '8%', datafield: 'status'},
                  { text: 'Group',width: '7%', datafield: 'groupname'},
                  { text: 'Member',width: '15%', datafield: 'member'},
                  { text: 'Time Taken',width: '6%', datafield: 'tottime'},
                  { text: 'Over Due Hrs',width: '7%', datafield: 'overdue'},
					]
   
    });
    $("#overlay, #PleaseWait").hide();
    
    
    
    
});
</script>
<div id="callregisterDetGridID"></div>  