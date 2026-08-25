<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.project.execution.serviceReport.ClsServiceReportDAO"%>
<% ClsServiceReportDAO DAO = new ClsServiceReportDAO(); %> 
<% String typedocno=request.getParameter("contracttype")==null?"0":request.getParameter("contracttype");
   String scheduleno=request.getParameter("scheduleno")==null?"0":request.getParameter("scheduleno");
   String contractno=request.getParameter("contractno")==null?"0":request.getParameter("contractno");
   String site=request.getParameter("site")==null?"0":request.getParameter("site");
   String cldocno=request.getParameter("customerdocno")==null?"0":request.getParameter("customerdocno");
   String branch=request.getParameter("branch")==null?"0":request.getParameter("branch");
   String search=request.getParameter("search")==null?"0":request.getParameter("search"); 
   String chk=request.getParameter("chk")==null?"0":request.getParameter("chk"); 
%>
 
<script type="text/javascript">

		var data4;

        $(document).ready(function () { 	
        	
        	var temps='<%=search%>';
        	var dtype='<%=typedocno%>';
        	var chkk='<%=chk%>';

        	if(temps=="yes") {
        		data4='<%=DAO.contractDetailsSearch(session,typedocno,scheduleno,contractno,site,cldocno,branch,search) %>'; 
        		temps="";
        	} 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                                
                             {name : 'scheduleno', type: 'int'},  
     						 {name : 'contractdocno', type: 'int'   },
     						 {name : 'contractdetails', type: 'string'   },
     						 {name : 'site', type: 'string'   },
     						 {name : 'area', type: 'string'   },
     						 {name : 'contracttrno', type: 'int'},
     						 {name : 'siteid', type: 'string'   },
     						 {name : 'areaid', type: 'int'}  
		                   ],
		                   localdata: data4,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
$("#contractDetailsSearchGridID").on("bindingcomplete", function (event) {
            	
            	// your code here.
            	
            if(dtype=="CREG"){
            	$('#contractDetailsSearchGridID').jqxGrid('setcolumnproperty','contracttrno','hidden',false); 
            	$('#contractDetailsSearchGridID').jqxGrid('setcolumnproperty','contractdocno','hidden',true);
            	       	
            }
            else{
            	$('#contractDetailsSearchGridID').jqxGrid('setcolumnproperty','contracttrno','hidden',true); 
            	$('#contractDetailsSearchGridID').jqxGrid('setcolumnproperty','contractdocno','hidden',false);
            }
            });      
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			            
		            }		
            );

            
            
            $("#contractDetailsSearchGridID").jqxGrid(
            {
                width: '100%',
                height: 320,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                       
                columns: [      
							{ text: 'Schedule No', datafield: 'scheduleno', width: '10%', editable: false },	
							{ text: 'Contract No', datafield: 'contractdocno', width: '10%',hidden: true, editable: false },
							{ text: 'Contract No', datafield: 'contracttrno', width: '10%' ,hidden: true, editable: false},
							{ text: 'Contract Details', datafield: 'contractdetails', width: '40%', editable: false },
							{ text: 'Site', datafield: 'site', width: '20%', editable: false   },
							{ text: 'Area', datafield: 'area', width: '20%', editable: false   },
							
							{ text: 'Site ID', datafield: 'siteid', width: '10%', hidden: true, editable: false  },
							{ text: 'Area ID', datafield: 'areaid', width: '10%', hidden: true, editable: false  },
			              ]
            
            });
            
            
            $('#contractDetailsSearchGridID').on('rowdoubleclick', function (event) {
	         	  var rowindex1 = event.args.rowindex;   
	         	  
	         	 if(dtype=="CREG"){
         		  document.getElementById("txtcontractno").value=$('#contractDetailsSearchGridID').jqxGrid('getcellvalue', rowindex1, "contracttrno");
	         	 }
	         	 else{
	         		 document.getElementById("txtcontractno").value=$('#contractDetailsSearchGridID').jqxGrid('getcellvalue', rowindex1, "contractdocno"); 
	         	 }
         		  
         		  document.getElementById("txtcontractdetails").value=$('#contractDetailsSearchGridID').jqxGrid('getcellvalue', rowindex1, "contractdetails");
           	      document.getElementById("txtcontracttrno").value=$('#contractDetailsSearchGridID').jqxGrid('getcellvalue', rowindex1, "contracttrno");
           	      document.getElementById("txtsitename").value=$('#contractDetailsSearchGridID').jqxGrid('getcellvalue', rowindex1, "site");
           	      document.getElementById("txtsiteid").value=$('#contractDetailsSearchGridID').jqxGrid('getcellvalue', rowindex1, "siteid");
           	      document.getElementById("txtareaname").value=$('#contractDetailsSearchGridID').jqxGrid('getcellvalue', rowindex1, "area");
           	      document.getElementById("txtareaid").value=$('#contractDetailsSearchGridID').jqxGrid('getcellvalue', rowindex1, "areaid");
           	      document.getElementById("txtscheduleno").value=$('#contractDetailsSearchGridID').jqxGrid('getcellvalue', rowindex1, "scheduleno");
           	      
           	    //  $("#activityDiv").load("activityDetailsGrid.jsp?contractno="+$('#contractDetailsSearchGridID').jqxGrid('getcellvalue', rowindex1, "contracttrno")+"&dtype="+$('#cmbcontracttype').val());
           	      
                 $('#contractDetailsWindow').jqxWindow('close'); 
             });  
            if(chkk=="0")
        	{
        	 $("#contractDetailsSearchGridID").jqxGrid('clear');
 			$("#contractDetailsSearchGridID").jqxGrid('addrow', null, {});
        	}
            
});
        
</script>
<div id=contractDetailsSearchGridID></div>
 