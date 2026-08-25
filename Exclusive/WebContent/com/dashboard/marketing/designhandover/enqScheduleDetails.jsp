<%@page import="com.dashboard.marketing.designhandover.ClsDesignHandoverDAO"%>
<%ClsDesignHandoverDAO cmd= new ClsDesignHandoverDAO();%>
<% String date =request.getParameter("date")==null?"0":request.getParameter("date").toString();%>
<% String branch =request.getParameter("barchval")==null?"0":request.getParameter("barchval").toString();%>
<% String clientid =request.getParameter("clientid")==null?"0":request.getParameter("clientid").toString();%>
<% String area =request.getParameter("area")==null?"0":request.getParameter("area").toString();%>
<% int id =request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id").toString());%>
<script type="text/javascript">
var temp4='<%=id%>';
var enqdata,enqlistexcel;

 if(temp4==1)
{ 
	 enqdata='<%=cmd.enquirySchedulerdata(date,branch,clientid,area,session)%>'; 
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
                     /* String sql="select e.voc_no,e.brhid, e.doc_no, e.date, e.remarks, e.cldocno, e.name,ms.sal_name salm,
                     e.mob, if(e.enqtype=0,'General','Client') type,"
            				+ "	ce.txtname source,'VIEW' as view,mu.func path,round(timestampdiff(minute,e.survdatetime,now())/60,2) age " */
                        {name : 'doc_no', type: 'String'  },
                        {name : 'brhid', type: 'String'  },
                        {name : 'voc_no', type: 'String'  },
						{name : 'date', type: 'date'  },
						{name : 'remarks', type: 'String'  },
						{name : 'cldocno', type: 'String'  },
						{name : 'name', type: 'String'  },
						{name : 'salm', type: 'String'  },
						{name : 'mob', type: 'String'},
						{name : 'type', type: 'String'  },
						{name : 'source', type: 'String'  },
						{name : 'view', type: 'String' },
						{name : 'path', type: 'String' },
						{name : 'age', type: 'String' },
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
   
    $("#enqschedulegrid").jqxGrid(
    {
        width: '99%',
        height: 380,
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
           	         { text: 'Type', datafield: 'type',  width: '6%' }, 
           	      { text: '',  datafield: 'view',columntype: 'button', width: '5%' },
					 { text: 'Date', datafield: 'date', width: '7%',cellsformat:'dd.MM.yyyy'},
				     { text: 'Doc No',datafield: 'voc_no', width: '6%' },
				     { text: 'hidDoc No',datafield: 'doc_no', width: '6%',hidden:true },
				     { text: 'Client',datafield: 'name', width: '18%' },
				     { text: 'cldocno',datafield: 'cldocno', width: '6%',hidden:true },
				     { text: 'Salesman', datafield: 'salm', width: '18%'},
					 { text: 'MOB', datafield: 'mob', width: '10%' },
					 { text: 'Age', datafield: 'age', width: '7%'},
					 { text: 'Remarks', datafield: 'remarks', width: '19%'},
					 { text: 'Source', datafield: 'source', width: '12%'},
  					 { text: 'Branch',datafield: 'brhid', width: '6%',hidden:true },
					 { text: 'Path',  datafield: 'path', width: '5%', hidden: true },
					]
   
    });
    $("#overlay, #PleaseWait").hide();
    
    $('#enqschedulegrid').on('rowdoubleclick', function (event) { 
    	  var rowindex1=event.args.rowindex;
    	  $('#cmbprocess').attr("disabled",false);
    	  $("#rowindex").val(rowindex1);
    	  $("#hiddocno").val($('#enqschedulegrid').jqxGrid('getcellvalue', rowindex1, 'doc_no'));
    	  $("#sitediv").load("siteGrid.jsp?sitedocno="+$('#enqschedulegrid').jqxGrid('getcellvalue', rowindex1, 'doc_no'));
			
       }); 
    
    
    $('#enqschedulegrid').on('cellclick', function (event) 
    		{ 
            	var rowindex1=event.args.rowindex;
            	var datafield = event.args.datafield;
            	if(datafield=="view"){
		       		  var docno= $('#enqschedulegrid').jqxGrid('getcellvalue', rowindex1, "voc_no");
		       		  var path1=$("#enqschedulegrid").jqxGrid('getcellvalue', rowindex1, "path");
					  var brch=$("#enqschedulegrid").jqxGrid('getcellvalue', rowindex1, "brhid");
					  var name="Enquiry";
					  var url=document.URL;
		  			  var reurl=url.split("com");
					  window.parent.formName.value="Enquiry";
					  window.parent.formCode.value="ENQ";
					  var detName="Enquiry";
					  var path= path1+"?modes=view&enqdocno="+docno+"&brhid="+brch;
					  top.addTab( detName,reurl[0]+""+path);
                }
    		 });
});


</script>
<div id="enqschedulegrid"></div>