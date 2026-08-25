<%@page import="com.realestate.tenantrequest.ClsTenantRequestDAO" %> 
<%@page import="javax.servlet.http.HttpServletRequest" %>    
<%@page import="javax.servlet.http.HttpSession" %>

<% String contextPath=request.getContextPath();%>
<%  ClsTenantRequestDAO DAO=new ClsTenantRequestDAO(); 
String vocno=request.getParameter("vocno")==null || request.getParameter("vocno")==""?"0":request.getParameter("vocno").toString();
String id=request.getParameter("id")==null || request.getParameter("id")==""?"0":request.getParameter("id").toString();
String brhid=request.getParameter("brhid")==null || request.getParameter("brhid")==""?"0":request.getParameter("brhid").toString();     
%>
<script type="text/javascript">  
	var mdata;		 
	mdata='<%=DAO.requestSearch(session,vocno,brhid,id)%>';           
 
      $(document).ready(function () {         	                       
          // prepare the data
          var source =
          {
              datatype: "json",
              datafields: [
						{name : 'doc_no', type: 'int'  }, 
						{name : 'job', type: 'string'  }, 
						{name : 'job_docno', type: 'int'  }, 
						{name : 'vendor_acno', type: 'string'  },
						{name : 'vendor_name', type: 'string'  },
						{name : 'vendor_docno', type: 'int'  },
						{name : 'priority', type: 'string'  },
						{name : 'est_cost', type: 'string'  },
						{name : 'notify_owner', type: 'bool'  },
						{name : 'comments', type: 'string'  }
                      ],
                       localdata: mdata,  
              
              pager: function (pagenum, pagesize, oldpagenum) {
                  // callback called when a page or page size is changed.
              }
          };
         
          $('#jqxRequestGrid').on('bindingcomplete', function (event) {
          	if ($("#mode").val() == "A" || $("#mode").val() == "E" ) {			 
      			$("#jqxRequestGrid").jqxGrid('addrow', null, {});		 
      		}
      	});
          
          var dataAdapter = new $.jqx.dataAdapter(source);
          
          $("#jqxRequestGrid").jqxGrid(
          {
              width: '100%',
              height: 325,
              source: dataAdapter,
              editable: true,
              altRows:true,
              showaggregates: true,
              selectionmode: 'singlecell',  
              handlekeyboardnavigation: function (event) {
                  var rows = $('#jqxRequestGrid').jqxGrid('getrows');
                  var rowlength= rows.length;
        	       var rowindex1=0;
                  var cell = $('#jqxRequestGrid').jqxGrid('getselectedcell');
    				if (cell != undefined && cell.datafield == 'chk' ) {
                      var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                      if (key == 13 || key == 9) { 
                      	$("#jqxRequestGrid").jqxGrid('addrow', null, {});		    
                      }
                  }
              },
              columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
					    groupable: false, draggable: false, resizable: false,
					    datafield: 'sl', columntype: 'number', width: '3%',
					    cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>"; 
					}  
					},
					{ text: 'doc_no', datafield: 'doc_no', width: '10%',hidden:true },
					{ text: 'job', datafield: 'job', width: '50%', editable: false },		
					{ text: 'job_docno', datafield: 'job_docno', width: '10%',hidden:true },     
					{text: 'Provider Acc.No',datafield:'vendor_acno',width:'8%', editable: false,hidden:true },
					{ text: 'Provider Name', datafield: 'vendor_name', width: '25%', editable: true,hidden:true  },
					{ text: 'vendor_docno', datafield: 'vendor_docno', width: '10%',hidden:true }, 
					{ text: 'Priority', datafield: 'priority', width:'5%',editable: true,hidden:true ,columntype:'dropdownlist',
						createeditor: function (row, column, editor) {									
	                        billlist = ["H","M","L"];   		                      
								editor.jqxDropDownList({ autoDropDownHeight: true, source: billlist });								
							},
					 	 initeditor: function (row, cellvalue, editor) {		                       
							var terms = $('#jqxRequestGrid').jqxGrid('getcellvalue', row, "priority");								
								editor.jqxDropDownList({ autoDropDownHeight: true, source: billlist });								
	                     },  
	                 },		
					{ text: 'Estimated Cost', datafield: 'est_cost', width: '10%',hidden:true , editable: true,validation: function (cell, value) {
                      	if (value >0) {
                            return { result: true, message: "Enter Numbers Only" };
                        	}
                        	return false;
     						} },		
					{ text: 'Notify Owner', datafield: 'notify_owner',hidden:true , width:'5%',columntype:'checkbox', 				                
					},
					{ text: 'Comments', datafield: 'comments', editable: true }		,
					{ text: '', datafield: 'chk', width: '2%' }
					 
				]
          });
          $("#jqxRequestGrid").jqxGrid('addrow', null, {});		
          $('#jqxRequestGrid').on('celldoubleclick', function(event) 
           {
              	var rowBoundIndex = event.args.rowindex;  
              	var datafield = event.args.datafield; 
              	if((datafield=="vendor_acno"))
  	    	   {
   		    	getvendorac(rowBoundIndex);
  	    	   } 
             	if(datafield=="job"){
    		    	getjob(rowBoundIndex);   
   	    	   } 
            });
      
      	
          if($('#mode').val()=='view')
       {          
          	$("#jqxRequestGrid").jqxGrid({
   			disabled : true
   		});
       }
          else
         	{
          	$("#jqxRequestGrid").jqxGrid({
     			disabled : false
     			});
         	}
          
      });
</script>
<div id="jqxRequestGrid"></div>
