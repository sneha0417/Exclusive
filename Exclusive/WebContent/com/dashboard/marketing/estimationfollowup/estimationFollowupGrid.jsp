   <%@page import="com.dashboard.marketing.estimationfollowup.ClsestimationFollowupDAO"%>
     <%
     ClsestimationFollowupDAO cmd= new ClsestimationFollowupDAO();
     %>
 
 

 <% String fromdate =request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").toString();%>
  <% String todate =request.getParameter("todate")==null?"0":request.getParameter("todate").toString();%>
 <% String branch =request.getParameter("barchval")==null?"0":request.getParameter("barchval").toString();%>
 <% String clientid =request.getParameter("clientid")==null?"0":request.getParameter("clientid").toString();%>

 <% int id =request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id").toString());%>
    <style type="text/css">

.yellowClass {
	background-color: #FCE286;
}


</style>	  
 
<script type="text/javascript">
 var temp4='<%=id%>';
var enqdata,enqlistexcel;

 if(temp4==1)
{ 
	 enqdata='<%=cmd.estFollowupdata(fromdate,todate,branch,clientid)%>'; 
	 enqlistexcel='<%=cmd.estFollowupExcel(fromdate,todate,branch,clientid)%>';
		
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
                     
                        {name : 'doc_no', type: 'String'  },
                        {name : 'voc_no', type: 'String'  },
						{name : 'date', type: 'date'  },
						{name : 'ftype', type: 'String'  },
						{name : 'name', type: 'String'  },
						{name : 'remarks', type: 'String'  },
						{name : 'mob', type: 'String'},
						{name : 'salm', type: 'String'  },
						{name : 'site', type: 'String' },
						{name : 'asnuser', type: 'String'  },
						{name : 'asnuserid', type: 'String'  },
						
 						{name : 'brhid', type: 'String'},
 						
 						{name : 'schtrno', type: 'String' },
 						{name : 'surdoc', type: 'String' },
 						{name : 'address', type: 'String' },
 						{name : 'cldocno', type: 'String' },
 						
						{name : 'pertel', type: 'String'},
 						
 						{name : 'per_mob', type: 'String' },
 						{name : 'mail1', type: 'String' },
 						{name : 'salname', type: 'String' },
 						{name : 'salid', type: 'String' },
 						{name : 'surtrno', type: 'number' },
 						{name : 'status', type: 'String' },
 						{name : 'enqstatus', type: 'String' },
 						{name : 'contrtype', type: 'String' },
 						{name : 'cpersonid', type: 'int' },
 						{name : 'cperson', type: 'String' },
 						{name : 'contactdet', type: 'String' },
 						{name : 'sjobtype', type: 'int' },
 						{name : 'esttrno', type: 'number' },
 						{name : 'taxper', type: 'number' },
 						
						],
				    localdata: enqdata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    var cellclassname = function (row, column, value, data) {
    	
    	
  		 if (data.enqstatus==2) {
              return "yellowClass";
          };
         
      };

    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
   
    $("#estfollowupgrid").jqxGrid(
    {
        width: '99%',
        height: 540,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filterable: true,
		showfilterrow: true,
        sortable:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        columnsresize: true,
        
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,cellclassname:cellclassname,
                      datafield: 'sl', columntype: 'number', width: '4%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },	
           	         { text: 'Type', datafield: 'ftype',  width: '4%' ,cellclassname:cellclassname}, 
					 { text: 'Date', datafield: 'date', width: '6%',cellsformat:'dd.MM.yyyy',cellclassname:cellclassname},
				     { text: 'Doc No',datafield: 'voc_no', width: '4%',cellclassname:cellclassname },
				     { text: 'hidDoc No',datafield: 'doc_no', width: '6%',hidden:true },
				     { text: 'Client',datafield: 'name', width: '15%',cellclassname:cellclassname },
				     { text: 'Salesman', datafield: 'salm', width: '15%',cellclassname:cellclassname},
					 { text: 'MOB', datafield: 'mob', width: '8%',cellclassname:cellclassname },
					 { text: 'Con. Type', datafield: 'contrtype',width: '6%',cellclassname:cellclassname },
					 { text: 'Remarks', datafield: 'remarks', width: '16%',cellclassname:cellclassname},
					 { text: 'Assigned User', datafield: 'asnuser', width: '9%',cellclassname:cellclassname},
					 { text: 'Site', datafield: 'site', width: '10%',cellclassname:cellclassname},
					 { text: 'Status', datafield: 'status', width: '9%',cellclassname:cellclassname},
						 { text: 'Branch',datafield: 'brhid', width: '6%',hidden:true },
			
							{ text: 'asnuserid', datafield: 'asnuserid',width: '10%', hidden: true },
							{ text: 'schtrno', datafield: 'schtrno',width: '10%', hidden: true },
							{ text: 'surdoc', datafield: 'surdoc',width: '10%', hidden: true },
							{ text: 'address', datafield: 'address',width: '10%', hidden: true },
							{ text: 'cldocno', datafield: 'cldocno',width: '10%', hidden: true },
							
							{ text: 'pertel', datafield: 'pertel',width: '10%', hidden: true },
							{ text: 'per_mob', datafield: 'per_mob',width: '10%', hidden: true },
							{ text: 'mail1', datafield: 'mail1',width: '10%', hidden: true },
							{ text: 'salname', datafield: 'salname',width: '10%', hidden: true },
							{ text: 'salid', datafield: 'salid',width: '10%', hidden: true },
							{ text: 'surtrno', datafield: 'surtrno',width: '10%', hidden: true },
							{ text: 'enqstatus', datafield: 'enqstatus',width: '10%', hidden: true },
							
							{ text: 'Contact Person Id', datafield: 'cpersonid',width: '10%', hidden: true },
							{ text: 'Contact Person', datafield: 'cperson',width: '10%', hidden: true },
							{ text: 'Contact Person Details', datafield: 'contactdet',width: '10%', hidden: true },
							{ text: 'sjobtype', datafield: 'sjobtype',width: '10%', hidden: true },
							{ text: 'esttrno', datafield: 'esttrno',width: '10%', hidden: true },
							{ text: 'Tax Per', datafield: 'taxper',width: '10%', cellsformat: 'd2', hidden: true },
					]
   
    });
    $("#overlay, #PleaseWait").hide();
    
    $('#estfollowupgrid').on('rowdoubleclick', function (event) { 
    	  var rowindex1=event.args.rowindex;
    	  var ftype=$('#estfollowupgrid').jqxGrid('getcellvalue', rowindex1, "ftype");
    	  var enqstat=$('#estfollowupgrid').jqxGrid('getcellvalue', rowindex1, "enqstatus");
    	
    	  if(ftype=="ENQ"){
    	  $('#btnenquiry').attr("disabled",false);
 		 $('#btnsurvey').attr("disabled",false);
 		 $('#btnservicereport').attr("disabled",true);
    	  }
    	  if(ftype=="SRVE"){
 		 $('#btnservicereport').attr("disabled",false);
 		 $('#btnenquiry').attr("disabled",true);
 		 $('#btnsurvey').attr("disabled",true);
    	  }
    	  var status=$('#estfollowupgrid').jqxGrid('getcellvalue', rowindex1, "status");
    	  if(status=="To be Estimated"){
 			 $('#btnestimation').attr("disabled",false);
    	  }
    	  else{
    		  $('#btnestimation').attr("disabled",true);
    	  }
    	  $('#btnqotation').attr("disabled",false);
	   
    		
    		 document.getElementById("surveydocno").value=$('#estfollowupgrid').jqxGrid('getcellvalue', rowindex1, "surdoc"); 
       	  document.getElementById("reportdocno").value=$('#estfollowupgrid').jqxGrid('getcellvalue', rowindex1, "voc_no"); 
       	document.getElementById("enqdocno").value=$('#estfollowupgrid').jqxGrid('getcellvalue', rowindex1, "voc_no"); 
    	
        document.getElementById("reftrno").value=$('#estfollowupgrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
        document.getElementById("surtrno").value=$('#estfollowupgrid').jqxGrid('getcellvalue', rowindex1, "surtrno");
        document.getElementById("esttrno").value=$('#estfollowupgrid').jqxGrid('getcellvalue', rowindex1, "esttrno");
        document.getElementById("refdtype").value=$('#estfollowupgrid').jqxGrid('getcellvalue', rowindex1, "ftype");
    	  document.getElementById("brhid1").value=$('#estfollowupgrid').jqxGrid('getcellvalue', rowindex1, "brhid");
    	  
    	  document.getElementById("client").value=$('#estfollowupgrid').jqxGrid('getcellvalue', rowindex1, "name");
    	  document.getElementById("cldocno").value=$('#estfollowupgrid').jqxGrid('getcellvalue', rowindex1, "cldocno");
    	  document.getElementById("address").value=$('#estfollowupgrid').jqxGrid('getcellvalue', rowindex1, "address");
    	
    	  document.getElementById("pertel").value=$('#estfollowupgrid').jqxGrid('getcellvalue', rowindex1, "pertel");
    	  document.getElementById("per_mob").value=$('#estfollowupgrid').jqxGrid('getcellvalue', rowindex1, "per_mob");
    	  
    	  document.getElementById("mail1").value=$('#estfollowupgrid').jqxGrid('getcellvalue', rowindex1, "mail1");
    	  document.getElementById("salname").value=$('#estfollowupgrid').jqxGrid('getcellvalue', rowindex1, "salname");
    	  document.getElementById("salid").value=$('#estfollowupgrid').jqxGrid('getcellvalue', rowindex1, "salid"); 
    	  document.getElementById("contrtype").value=$('#estfollowupgrid').jqxGrid('getcellvalue', rowindex1, "contrtype");
    	  document.getElementById("txtcpersonid").value=$('#estfollowupgrid').jqxGrid('getcellvalue', rowindex1, "cpersonid");
    	  document.getElementById("txtcperson").value=$('#estfollowupgrid').jqxGrid('getcellvalue', rowindex1, "cperson");
    	  document.getElementById("txtcpersondet").value=$('#estfollowupgrid').jqxGrid('getcellvalue', rowindex1, "contactdet");
    	  document.getElementById("txtsjobtype").value=$('#estfollowupgrid').jqxGrid('getcellvalue', rowindex1, "sjobtype");
    	  document.getElementById("txtclienttaxper").value=$('#estfollowupgrid').jqxGrid('getcelltext', rowindex1, "taxper");
    	  
    	  var vocno=$('#estfollowupgrid').jqxGrid('getcellvalue', rowindex1, "voc_no");
    	  var test='Document No: '+vocno;
          
			document.getElementById("test").innerText=test;
    	
       }); 
    
   
});


</script>
<div id="estfollowupgrid"></div>