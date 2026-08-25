<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.projectexecution.deploytechnician.ClsDeployTechnicianDAO"%> 
<% ClsDeployTechnicianDAO DAO=new ClsDeployTechnicianDAO(); %>
<% String empname =request.getParameter("empname")==null?"0":request.getParameter("empname").toString().trim();
   String empid = request.getParameter("empid")==null?"0":request.getParameter("empid").trim();
   String id =request.getParameter("id")==null?"0":request.getParameter("id").toString().trim();
   String check =request.getParameter("check")==null?"0":request.getParameter("check").toString().trim();
%>
<script type="text/javascript">

        $(document).ready(function () { 	
        	var empacount;

        	var temps='<%=check%>';
        	var tempid='<%=id%>';

        	if(temps=="1")
        		{
        		empacount='<%=DAO.employeeDetailsSearch(empid,empname,check) %>'; 
        		temps="";
        		}
        	else
        		{
        		empacount; 
        		}
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                             {name : 'doc_no', type: 'int'},  
     		 				 {name : 'codeno', type: 'string'},
     		 				 {name : 'name', type: 'string'},
     		 				 {name : 'costperhour', type: 'string'},
                 ],
                 localdata: empacount,
                
                
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
            
            $("#employeeDetailsSearchGridId").jqxGrid(
            {
                width: '99%',
                height: 303,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                       
                columns: [   
							{ text: 'Sr. No.',datafield: '',columntype:'number', width: '5%', cellsrenderer: function (row, column, value) {
    								return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
								}   },
							{ text: 'DocNo', datafield: 'doc_no', width: '10%', editable: false,hidden:true },
							{ text: 'Code', datafield: 'codeno', width: '10%', editable: false },
							{ text: 'Name', datafield: 'name' , editable: false,width:'85%'},
							{ text: 'Cost Per Hour', datafield: 'costperhour' , hidden: true,width:'85%'},
			              ]
            });
            $('#employeeDetailsSearchGridId').on('rowdoubleclick', function (event) {
            	    var rowindex2 = event.args.rowindex;
            	
            	    if(parseInt(tempid)==1) {
	         	   		var rowindex1 = $('#rowindex').val();
	         	   	    
	         	   	    $('#manPowerAssignedGridID').jqxGrid('setcellvalue', rowindex1, "empid",$('#employeeDetailsSearchGridId').jqxGrid('getcellvalue', rowindex2, "codeno"));
	         	   	    $('#manPowerAssignedGridID').jqxGrid('setcellvalue', rowindex1, "empname",$('#employeeDetailsSearchGridId').jqxGrid('getcellvalue', rowindex2, "name"));
	         	        $('#manPowerAssignedGridID').jqxGrid('setcellvalue', rowindex1, "empdocno",$('#employeeDetailsSearchGridId').jqxGrid('getcellvalue', rowindex2, "doc_no"));
	         	        $('#manPowerAssignedGridID').jqxGrid('setcellvalue', rowindex1, "stdcost",$('#employeeDetailsSearchGridId').jqxGrid('getcellvalue', rowindex2, "costperhour"));
	             	 
	         	       var rows = $('#manPowerAssignedGridID').jqxGrid('getrows');
	               	   var rowlength= rows.length;
	               	   var rowindex1 = rowlength - 1;
	             	   var empid=$("#manPowerAssignedGridID").jqxGrid('getcellvalue', rowindex1, "empid");
	             	   if(typeof(empid) != "undefined"){
	                   	$("#manPowerAssignedGridID").jqxGrid('addrow', null, {"consumed":"View"});
	             	   }
            	    } else if(parseInt(tempid)==0) {
            	    	document.getElementById("txtemployee").value=$('#employeeDetailsSearchGridId').jqxGrid('getcellvalue', rowindex2, "name");
            	    	document.getElementById("txtemployeedocno").value=$('#employeeDetailsSearchGridId').jqxGrid('getcellvalue', rowindex2, "doc_no");
            	    }
             	    
                 $('#manPowerGridWindow').jqxWindow('close'); 
             });  
            
        });
    </script>
    <div id=employeeDetailsSearchGridId></div>
 