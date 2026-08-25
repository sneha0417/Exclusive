<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.project.leadmanagement.activityreport.ClsActivityReportDAO"%> 
<% ClsActivityReportDAO DAO=new ClsActivityReportDAO(); %> 
<% String clname = request.getParameter("clname")==null?"0":request.getParameter("clname");
   String mob = request.getParameter("mob")==null?"0":request.getParameter("mob"); %> 

<script type="text/javascript">
 
 		var cldata='<%=DAO.searchClient(session,clname,mob)%>';
        
 		$(document).ready(function () { 
         
            var source = 
            {
                datatype: "json",
                datafields: [
                         
     						{name : 'cldocno', type: 'String'  },
     						{name : 'refname', type: 'String'  },
     						{name : 'address', type: 'String'  }, 
     						{name : 'per_mob', type: 'String'  },
     						{name : 'mail1', type: 'String'  },
     						{name : 'pertel', type: 'String'  },
                          	],
                          	localdata: cldata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            
            $("#Jqxclientsearch").jqxGrid(
            {
                width: '100%',
                height: 285,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
     					
                columns: [
							{ text: 'Doc No', datafield: 'cldocno', width: '10%' },
							{ text: 'Name', datafield: 'refname', width: '30%' },
							{ text: 'Address', datafield: 'address', width: '60%' }, 
							{ text: 'TEL', datafield: 'pertel', width: '10%' ,hidden:true}, 
							{ text: 'MOB', datafield: 'per_mob', width: '15%' ,hidden:true},
							{ text: 'Mail', datafield: 'mail1', width: '20%',hidden:true },
					
						]
            });
				            
		    $('#Jqxclientsearch').on('rowdoubleclick', function (event)  { 
		              	
		    	var rowindex1=event.args.rowindex;
		        var rowindex2=$('#rowindex').val();
		        
		        $('#activityReportGridID').jqxGrid('setcellvalue', rowindex2, "cldocno",$('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "cldocno"));
		        $('#activityReportGridID').jqxGrid('setcellvalue', rowindex2, "client",$('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "refname"));
		                
		        var rows = $('#activityReportGridID').jqxGrid('getrows');
            	var rowlength= rows.length;
            	var rowindex1 = rowlength - 1;
          	    var intime=$("#activityReportGridID").jqxGrid('getcellvalue', rowindex1, "intime");
          	    if(typeof(intime) != "undefined"){
                	$("#activityReportGridID").jqxGrid('addrow', null, {});
          	    }
          	   
		    	$('#clientDetailsSearchWindow').jqxWindow('close');
		            		 
		    }); 	 
				           
        
                  
 }); 
                       
 </script>
 <div id="Jqxclientsearch"></div>
    