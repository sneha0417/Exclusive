<%@page import="com.dashboard.audit.approvalRemove.ClsApprovalRemoveDAO" %>
<% ClsApprovalRemoveDAO card=new ClsApprovalRemoveDAO();%>

 <%

   String barchval = request.getParameter("brhid")==null?"NA":request.getParameter("brhid");
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  	String doc_no = request.getParameter("doc_no")==null?"NA":request.getParameter("doc_no").trim();
  	String dtype = request.getParameter("dtype")==null?"NA":request.getParameter("dtype").trim();
 
 %> 
 
 <style type="text/css">
    .redClass
    {
        background-color: #FFEBEB;
    }
    
    .yellowClass
    {
        background-color: #FFFFD1;
    }
    
    .greyClass
    {
        background-color: #D8D8D8;
    }
        

        
</style>
 
 
 <script type="text/javascript">
 var temp4='<%=barchval%>';
 var apprdata;
 
 
	  apprdata='<%=card.detailsgrid(barchval,fromdate,todate,doc_no,dtype)%>';

        $(document).ready(function () { 
         
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

                             
                 			{name : 'doc_no', type: 'String'  },
     						{name : 'userid', type: 'String'},
     						 {name : 'brhid', type: 'String'}, 
     						 {name : 'user_name', type: 'String'}, 
     						{name : 'branchname', type: 'String'  },
     						{name : 'dtype', type: 'String'  },
     						{name : 'remarks', type: 'String'  },
     						{name : 'apprlevel', type: 'String'  },
     						{name : 'apprtype', type: 'String'  },
     						{name : 'adate', type: 'String'  },
     						{name : 'apprstatus', type: 'String'  },
     						
                          	],
                          	localdata: apprdata,
                          	       
          
				
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var cellclassname = function (row, column, value, data) {
          		if (data.apprlevel==1) {
                      return "redClass";
                  } else if (data.apprlevel==2) {
                      return "yellowClass";
                  }
                  else{
                  	return "greyClass";
                  };
              };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }
            );
            $("#detailsgrid").jqxGrid(
            { 
            	
            	
            	width: '100%',
                height: 500,
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
							    datafield: 'sl', columntype: 'number', width: '3%',cellclassname: cellclassname,
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
							  },
							  { text: 'userid', datafield: 'userid', width: '4%',hidden:true },
							  { text: 'brhid', datafield: 'brhid', width: '4%',hidden:true },
							  { text: 'apprstatus', datafield: 'apprstatus', width: '4%',hidden:true },
							{ text: 'Branch', datafield: 'branchname', width: '15%',cellclassname: cellclassname },
							{ text: 'Dtype', datafield: 'dtype', width: '6%',cellclassname: cellclassname },
							{ text: 'DocNo', datafield: 'doc_no', width: '8%',cellclassname: cellclassname },
							{ text: 'Approval User', datafield: 'user_name', width: '15%',cellclassname: cellclassname },
							{ text: 'Approval Level', datafield: 'apprlevel', width: '12%',cellclassname: cellclassname},
							{ text: 'Approved Date', datafield: 'adate', width: '10%',cellclassname: cellclassname},
							{ text: 'Remarks', datafield: 'remarks', width: '20%',cellclassname: cellclassname },
							{ text: 'Status', datafield: 'apprtype', width: '12%',cellclassname: cellclassname },
							//{ text: 'Transaction Status', datafield: 'remarks', width: '12%'},
				
					
					]
            });
            
            $("#overlay, #PleaseWait").hide(); 
       
            $('#detailsgrid').on('rowdoubleclick', function (event) {
                
                var rowindex3 = event.args.rowindex;
                //document.getElementById("doctype").value=$('#docsearch').jqxGrid('getcellvalue', rowindex2, "dtype");
                document.getElementById("doc_no").value=$('#detailsgrid').jqxGrid('getcellvalue', rowindex3, "doc_no");
                document.getElementById("brhid").value=$('#detailsgrid').jqxGrid('getcellvalue', rowindex3, "brhid");
                document.getElementById("doctype").value=$('#detailsgrid').jqxGrid('getcellvalue', rowindex3, "dtype");
            }); 
            
            
        });
                     
    </script>
    <div id="detailsgrid"></div>