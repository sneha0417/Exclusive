   <%@page import="com.dashboard.marketing.enquiryfollowup.enquiryFollowupDAO"%>
     <%
     enquiryFollowupDAO cmd= new enquiryFollowupDAO();
     %>
 
 
 <%
    String salesmanid = request.getParameter("salesmanid")==null?"0":request.getParameter("salesmanid").trim();
 	String branchval = request.getParameter("branchval")==null?"0":request.getParameter("branchval").trim();
	String fromdate = request.getParameter("froms")==null?"0":request.getParameter("froms").trim();
  	String todate = request.getParameter("tos")==null?"0":request.getParameter("tos").trim();
  	 String chkfollowup = request.getParameter("chkfollowup")==null?"0":request.getParameter("chkfollowup").trim();
     String followupdate = request.getParameter("followupdate")==null?"0":request.getParameter("followupdate").trim();
     String areaid =request.getParameter("areaid")==null?"0":request.getParameter("areaid").toString();
     System.out.println(branchval+fromdate+todate+chkfollowup);
 %> 
           	  
 
<script type="text/javascript">
 var temp4='<%=branchval%>';
var enqdata,enqfollowupexcel;

 if(temp4!='0') 
{ 
	 
	 enqdata='<%=cmd.enquirylistsearch(branchval,chkfollowup,followupdate,fromdate,todate,areaid,salesmanid) %>';
	 
	 enqfollowupexcel='<%=cmd.enquirylistExcel(branchval,chkfollowup,followupdate,fromdate,todate,areaid,salesmanid) %>';
	
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
						{name : 'type', type: 'String'  },
						{name : 'name', type: 'String'  },
						{name : 'remarks', type: 'String'  },
						{name : 'mob', type: 'String'},
						{name : 'salm', type: 'String'  },
						{name : 'site', type: 'String' },
						{name : 'fdate', type: 'date' },
						{name : 'source', type: 'String'  },
						{name : 'brch', type: 'String'  },
						{name : 'enqstat', type: 'String'  },
						{name : 'view', type: 'String' },
					
						{name : 'enqtype', type: 'String'  },
						{name : 'telno', type: 'String'  },
						{name : 'sourceid', type: 'String'  },
						{name : 'contrmode', type: 'String' },
						{name : 'sjobtype', type: 'String' },
						
						{name : 'addr', type: 'String'  },
						 {name : 'cpersonid' , type: 'String'},
		                    {name : 'cperson' , type: 'String'},  
		                    {name : 'cldocno' , type: 'String'},  
		                    {name : 'email' , type: 'String'}, 
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
   
    $("#enqlistgrid").jqxGrid(
    {
        width: '99%',
        height: 400,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        columnsresize: true,
        
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '4%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },	
           	         { text: 'Type', datafield: 'type',  width: '6%' }, 
					 { text: 'Date', datafield: 'date', width: '7%',cellsformat:'dd.MM.yyyy'},
				     { text: 'Doc No',datafield: 'voc_no', width: '6%' },
				     { text: '',  datafield: 'view',columntype: 'button', width: '5%' },
				     { text: 'hidDoc No',datafield: 'doc_no', width: '6%',hidden:true },
				     { text: 'Client',datafield: 'name', width: '15%' },
				     { text: 'Salesman', datafield: 'salm', width: '13%'},
					 { text: 'MOB', datafield: 'mob', width: '9%' },
					 { text: 'Remarks', datafield: 'remarks', width: '18%'},
					 { text: 'Source', datafield: 'source', width: '10%'},
					 { text: 'Site', datafield: 'site', width: '10%'},
					 { text: 'Followup Date', datafield: 'fdate', width: '7%',cellsformat:'dd.MM.yyyy' },
					 { text: 'Branch', datafield: 'brch', width: '11%',hidden:true},
					 { text: 'Enq Status', datafield: 'enqstat', width: '10%',hidden:true},
					 
					 { text: 'enqtype', datafield: 'enqtype', width: '20%',hidden:true },
					
						{ text: 'telno', datafield: 'telno', width: '20%',hidden:true },
				
						{ text: 'sourceid', datafield: 'sourceid', width: '20%',hidden:true },
						{ text: 'contrmode', datafield: 'contrmode', width: '20%',hidden:true },
						
						{ text: 'sjobtype', datafield: 'sjobtype', width: '20%',hidden:true },
						{ text: 'address', datafield: 'addr', width: '20%',hidden:true },
						{ text: 'cperson', datafield: 'cperson', width: '20%',hidden:true },
						{ text: 'cpersonid', datafield: 'cpersonid', width: '20%',hidden:true },
						{ text: 'cldocno', datafield: 'cldocno', width: '20%',hidden:true },
						{ text: 'email', datafield: 'email', width: '20%',hidden:true },
					]
   
    });
    $("#overlay, #PleaseWait").hide();
    $('#enqlistgrid').on('rowdoubleclick', function (event) { 
   	  var rowindex1=event.args.rowindex;
   		
   	  var enstat=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "enqstat");
   	 	  if(enstat==0)
   		  {
   	 		$('#cmbprocess').attr("disabled",false);$('#txtremarks').attr("readonly",false);
     	     
            $('#date').jqxDateTimeInput({disabled: false});$('#btnupdate').attr("disabled",false);
            $('#cmbprocess').val('');
   		$('#cmbprocess option[value="87:Follow-Up"]').attr("hidden", false);
   		$('#cmbprocess option[value="87:Dropped"]').attr("hidden", false);
   		$('#cmbprocess option[value="87:Declined"]').attr("hidden", false);
   	  $('#cmbprocess option[value="87:Assigned"]').attr("hidden", false);
   	//	$('#cmbprocess option[value="87:Assigned"]').attr("selected", "selected");
   	$('#date').jqxDateTimeInput({disabled: false});$('#btnupdate').attr("disabled",false);
		 
    document.getElementById("info").value="Doc No : "+$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "voc_no")+"\n"+
	 "Client : "+$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "name")+"";
	 document.getElementById("txtbranch").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "brch");
	 document.getElementById("txtdocno").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
	document.getElementById("txtenqstat").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "enqstat");
	document.getElementById("conttype").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "type");
	 	
  $("#detailDiv").load("detailGrid.jsp?doc="+$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, 'doc_no'));
   	 	
   		  }
   	  else
   		  {
         $('#cmbprocess').attr("disabled",false);$('#txtremarks').attr("readonly",false);
  	     
         $('#date').jqxDateTimeInput({disabled: false});$('#btnupdate').attr("disabled",false);
         $('#cmbprocess').val('');
         $('#cmbprocess option[value="87:Follow-Up"]').attr("hidden", false);
 		$('#cmbprocess option[value="87:Dropped"]').attr("hidden", false);
 		$('#cmbprocess option[value="87:Declined"]').attr("hidden", false);
      $('#cmbprocess option[value="87:Assigned"]').attr("hidden", true);
   		 
         document.getElementById("info").value="Doc No : "+$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "voc_no")+"\n"+
     	 "Client : "+$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "name")+"";
   	 document.getElementById("txtbranch").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "brch");
   	 document.getElementById("txtdocno").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
  	document.getElementById("txtenqstat").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "enqstat");
   	document.getElementById("conttype").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "type");
   	 	
       $("#detailDiv").load("detailGrid.jsp?doc="+$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, 'doc_no'));
       
   		  }
       
      }); 
    
    $('#enqlistgrid').on('cellclick', function (event) 
    		{ 
            	var rowindex1=event.args.rowindex;
            	var datafield = event.args.datafield;
            	
            	 if(datafield=="view"){
            		 var enqdocno=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "voc_no");
            			var brch=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "brch");
            			 var path1="com/operations/marketing/enquirynew/enquiry.jsp";
            				 var name="Enquiry";
            				 var url=document.URL;
            				var reurl=url.split("com");

            			  window.parent.formName.value="Enquiry";
            			  window.parent.formCode.value="ENQ";
            			  var detName="Enquiry";
            			  
            			  var path= path1+"?modes=view&enqdocno="+enqdocno+"&brhid="+brch;
            			 
            			   top.addTab( detName,reurl[0]+""+path);
     				
                 	
                 }

            	
              
    		 });
    
    
   
});


</script>
<div id="enqlistgrid"></div>

