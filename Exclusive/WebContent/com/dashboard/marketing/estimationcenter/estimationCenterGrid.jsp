   <%@page import="com.dashboard.marketing.estimationcenter.ClsestimationCenterDAO"%>
     <%
     ClsestimationCenterDAO cmd= new ClsestimationCenterDAO();
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
	 enqdata='<%=cmd.estCenterdata(fromdate,todate,branch,clientid)%>'; 
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
						{name : 'site', type: 'String'  },
                        {name : 'doc_no', type: 'int'  },
                        {name : 'voc_no', type: 'int'  },
						{name : 'date', type: 'date'  },
						{name : 'ftype', type: 'String'  },
						{name : 'name', type: 'String'  },
						{name : 'remarks', type: 'String'  },
						{name : 'mob', type: 'String'},
						{name : 'salm', type: 'String'  },
						{name : 'asnuser', type: 'String'  },
						{name : 'asnuserid', type: 'String'  },
 						{name : 'brhid', type: 'String'},
 						{name : 'schtrno', type: 'String' },
 						{name : 'surdoc', type: 'String' },
 						{name : 'amount', type: 'String' },
 						{name : 'remark', type: 'String' },
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
   
    $("#estcentergrid").jqxGrid(
    {
        width: '99%',
        height: 540,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        showfilterrow: true,
        filterable: true,
        columnsresize: true,    
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
           	         { text: 'Type', datafield: 'ftype',  width: '6%' }, 
					 { text: 'Date', datafield: 'date', width: '7%',cellsformat:'dd.MM.yyyy'},
				     { text: 'Doc No',datafield: 'voc_no', width: '6%' },
				     { text: 'hidDoc No',datafield: 'doc_no', width: '6%',hidden:true },
				     { text: 'Client',datafield: 'name', width: '18%' },
				     { text: 'Site', datafield: 'site',  width: '16%' },
				     { text: 'Salesman', datafield: 'salm', width: '18%'},
					 { text: 'MOB', datafield: 'mob', width: '10%' },
					 { text: 'Remarks', datafield: 'remarks', width: '19%'},
					 { text: 'Assigned User', datafield: 'asnuser', width: '12%'},
					 { text: 'Amount', datafield: 'amount', width: '12%',hidden:true},
					 { text: 'Remarks', datafield: 'remark', width: '19%',hidden:true},
					
						 { text: 'Branch',datafield: 'brhid', width: '6%',hidden:true },
						
							{ text: 'asnuserid', datafield: 'asnuserid',width: '10%', hidden: true },
							{ text: 'schtrno', datafield: 'schtrno',width: '10%', hidden: true },
							{ text: 'surdoc', datafield: 'surdoc',width: '10%', hidden: true },
					]
   
    });
    $("#overlay, #PleaseWait").hide();
    
    $('#estcentergrid').on('rowdoubleclick', function (event) { 
    	  var rowindex1=event.args.rowindex;
    	  var ftype=$('#estcentergrid').jqxGrid('getcellvalue', rowindex1, "ftype");
    	
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
    		 $('#txtuser').attr("disabled",false);
    		 $('#btnsave').attr("disabled",false);
    		 $('#txtamount').attr("disabled",false);
    		 $('#txtremark').attr("disabled",false);
    		
    		 document.getElementById("surveydocno").value=$('#estcentergrid').jqxGrid('getcellvalue', rowindex1, "surdoc"); 
       	  document.getElementById("reportdocno").value=$('#estcentergrid').jqxGrid('getcellvalue', rowindex1, "voc_no"); 
       	document.getElementById("enqdocno").value=$('#estcentergrid').jqxGrid('getcellvalue', rowindex1, "voc_no"); 
    	
        document.getElementById("reftrno").value=$('#estcentergrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
        document.getElementById("refdtype").value=$('#estcentergrid').jqxGrid('getcellvalue', rowindex1, "ftype");
    	  document.getElementById("brhid1").value=$('#estcentergrid').jqxGrid('getcellvalue', rowindex1, "brhid");
    	 
    	  var vocno=$('#estcentergrid').jqxGrid('getcellvalue', rowindex1, "voc_no");
    	  var test='Document No: '+vocno;
          
			document.getElementById("test").innerText=test;
    	
       }); 
    
   
});


</script>
<div id="estcentergrid"></div>