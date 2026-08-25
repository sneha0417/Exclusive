   <%@page import="com.dashboard.analysis.quotationrevisionanalysis.ClsquotationRevisionAnalysisDAO"%>
     <%
     ClsquotationRevisionAnalysisDAO cmd= new ClsquotationRevisionAnalysisDAO();
     %>
 
 

 <% String fromdate =request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").toString();%>
  <% String todate =request.getParameter("todate")==null?"0":request.getParameter("todate").toString();%>
 <% String branch =request.getParameter("barchval")==null?"0":request.getParameter("barchval").toString();%>
 <% String clientid =request.getParameter("clientid")==null?"0":request.getParameter("clientid").toString();%>
 
 <% int id =request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id").toString());%>
    	  
 
<script type="text/javascript">
 var temp4='<%=id%>';
var enqdata,enqlistexcel;

 if(temp4==1)
{ 
	 enqdata='<%=cmd.qotrevisiondata(fromdate,todate,branch,clientid)%>'; 
	<%--  enqlistexcel='<%=cmd.enquirylistExcel(barchval,fromdate,todate,clientname,srcno,salid,rds)%>'; --%>
		// alert(enqdata);
} 
else
{ 
	
	enqdata;
	
	}  

$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   

 						{name : 'doc_no', type: 'String' },
 						{name : 'client', type: 'String' },
 						{name : 'rev0', type: 'String' },
 						{name : 'rev1', type: 'String' },
 						{name : 'rev2', type: 'String' },
 						{name : 'rev3', type: 'String' },
 						{name : 'rev4', type: 'String' },
 						{name : 'rev5', type: 'String' },
 						{name : 'rev6', type: 'String' },
 						{name : 'rev7', type: 'String' },
 						{name : 'tr_no', type: 'String' },
						],
				    localdata: enqdata,
        
        
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
   
    $("#jqxqotGrid").jqxGrid(
    {
        width: '99%',
        height: 290,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '4%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },	
                    
           	         { text: 'Doc No.', datafield: 'doc_no',  width: '6%' }, 
           	     
				     { text: 'Client',datafield: 'client', width: '26%' },
				     { text: 'Revision-0',datafield: 'rev0', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
				     { text: 'Revision-1',datafield: 'rev1', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
				     { text: 'Revision-2',datafield: 'rev2', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
				     { text: 'Revision-3',datafield: 'rev3', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
				     { text: 'Revision-4',datafield: 'rev4', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
				     { text: 'Revision-5',datafield: 'rev5', width: '8%' , cellsformat: 'd2', cellsalign: 'right', align: 'right'},
				     { text: 'Revision-6',datafield: 'rev6', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
				     { text: 'Revision-7',datafield: 'rev7', width: '8%' , cellsformat: 'd2', cellsalign: 'right', align: 'right'},

				     { text: 'tr_no',datafield: 'tr_no', width: '6%',hidden:true },
							
					]
   
    });
    $("#overlay, #PleaseWait").hide();
    
    $('#jqxqotGrid').on('rowdoubleclick', function (event) { 
    	  var rowindex1=event.args.rowindex;
    	     	
			 $("#qotsubdiv").load("quotsubGrid.jsp?trno="+$('#jqxqotGrid').jqxGrid('getcellvalue', rowindex1, 'tr_no')+"&id=1");
			 $("#qotsitediv").load("siteGrid.jsp?trno="+$('#jqxqotGrid').jqxGrid('getcellvalue', rowindex1, 'tr_no')+"&id=1");
			 $("#qotrevisiondiv").load("revisionGrid.jsp?trno="+$('#jqxqotGrid').jqxGrid('getcellvalue', rowindex1, 'tr_no')+"&id=1");
			
       }); 
    
    
    
});


</script>
<div id="jqxqotGrid"></div>