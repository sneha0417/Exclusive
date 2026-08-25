   <%@page import="com.dashboard.marketing.enquiryScheduler.ClsenquirySchedulerDAO"%>
     <%
     	ClsenquirySchedulerDAO cmd= new ClsenquirySchedulerDAO();
     %>
 
 

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
	 enqdata='<%=cmd.enquirySchedulerdata(date,branch,clientid,area)%>'; 
	  enqlistexcel='<%=cmd.enquirySchedulerExcel(date,branch,clientid,area)%>'; 
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
                        {name : 'doc_no', type: 'String'  },
                        {name : 'voc_no', type: 'String'  },
						{name : 'date', type: 'date'  },
						{name : 'type', type: 'String'  },
						{name : 'name', type: 'String'  },
						{name : 'remarks', type: 'String'  },
						{name : 'mob', type: 'String'},
						{name : 'salm', type: 'String'  },
					
						{name : 'source', type: 'String'  },
						{name : 'empgroupid', type: 'String' },
 						{name : 'empid', type: 'String'},
 						{name : 'asgnmode', type: 'String'},
 						{name : 'plannedon' , type : 'date'},
 						{name : 'pltime', type: 'String'},
 						{name : 'description', type: 'String'},
 						{name : 'groups', type: 'String'},
 						{name : 'grpmem', type: 'String'},
 						{name : 'asgmeth', type: 'String'},
 						{name : 'brhid', type: 'String'},
 						{name : 'teampid', type: 'String' },
 						{name : 'schtrno', type: 'String' },
 						{name : 'view', type: 'String' },
 						{name : 'path', type: 'String' },
 					
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
        columnsresize:true,
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
				     { text: 'Site',datafield: 'site', width: '18%' },   
				     { text: 'Salesman', datafield: 'salm', width: '18%'},
					 { text: 'MOB', datafield: 'mob', width: '10%' },
					 { text: 'Remarks', datafield: 'remarks', width: '19%'},
					 { text: 'Source', datafield: 'source', width: '12%'},
					 { text: 'Assign Group', datafield: 'groups', width: '10%'},
						{ text: 'Group Member', datafield: 'grpmem', width: '10%' },
						{ text: 'Assign Method', datafield: 'asgmeth', width: '10%'},	
						{ text: 'Planned Date', datafield: 'plannedon', width: '7%',cellsformat:'dd.MM.yyyy' },
						{ text: 'Planned Time', datafield: 'pltime', width: '7%' },
						{ text: 'Description', datafield: 'description', width: '18%' },
						 { text: 'Branch',datafield: 'brhid', width: '6%',hidden:true },
						 { text: 'Assign Group', datafield: 'empgroupid', width: '10%',hidden:true},
							{ text: 'Group Member', datafield: 'empid', width: '10%',hidden:true },
							{ text: 'Assign Method', datafield: 'asgnmode', width: '10%',hidden:true},	
							{ text: 'teampid', datafield: 'teampid',width: '10%', hidden: true },
							{ text: 'schtrno', datafield: 'schtrno',width: '10%', hidden: true },
							{ text: 'Path',  datafield: 'path', hidden: true, width: '5%' },
							
					]
   
    });
    $("#overlay, #PleaseWait").hide();
    
    $('#enqschedulegrid').on('rowdoubleclick', function (event) { 
    	  var rowindex1=event.args.rowindex;
    	  $('#cmbprocess').attr("disabled",false);
    	  document.getElementById("txtassign").value=$('#enqschedulegrid').jqxGrid('getcellvalue', rowindex1, "asgmeth");
        	document.getElementById("assignid").value=$('#enqschedulegrid').jqxGrid('getcellvalue', rowindex1, "asgnmode");

        	document.getElementById("txtgroup").value=$('#enqschedulegrid').jqxGrid('getcellvalue', rowindex1, "groups");
	        document.getElementById("groupid").value=$('#enqschedulegrid').jqxGrid('getcellvalue', rowindex1, "empgroupid");
			
	        document.getElementById("txtgrpmember").value=$('#enqschedulegrid').jqxGrid('getcellvalue', rowindex1, "grpmem");
        	document.getElementById("grpmemberid").value=$('#enqschedulegrid').jqxGrid('getcellvalue', rowindex1, "teampid");
        	document.getElementById("grpempid").value=$('#enqschedulegrid').jqxGrid('getcellvalue', rowindex1, "empid");
        	var srno=$('#enqschedulegrid').jqxGrid('getcellvalue', rowindex1, "schtrno");
        	
        	if(srno=="" || srno=="undefined" || srno==null || srno=="0")
        		{
        		$('#adate').jqxDateTimeInput('setDate', new Date());
        	     $('#atime').jqxDateTimeInput('setDate', new Date());
        		}
        	else{
        		$('#adate').jqxDateTimeInput('val',$('#enqschedulegrid').jqxGrid('getcellvalue', rowindex1, "plannedon"));
                $('#atime').jqxDateTimeInput('val',$('#enqschedulegrid').jqxGrid('getcellvalue', rowindex1, "pltime"));
        	}
        
            document.getElementById("schtrno").value=$('#enqschedulegrid').jqxGrid('getcellvalue', rowindex1, "schtrno"); 
    	  document.getElementById("rowindex").value=rowindex1;
    	  document.getElementById("brhid1").value=$('#enqschedulegrid').jqxGrid('getcellvalue', rowindex1, "brhid");
    	  document.getElementById("trno").value=$('#enqschedulegrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
    	  var vocno=$('#enqschedulegrid').jqxGrid('getcellvalue', rowindex1, "voc_no");
    	  var test='Document No: '+vocno;
          
			document.getElementById("test").innerText=test;
    	
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