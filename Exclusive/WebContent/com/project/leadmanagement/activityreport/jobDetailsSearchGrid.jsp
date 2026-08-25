<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.project.leadmanagement.activityreport.ClsActivityReportDAO"%> 
<% ClsActivityReportDAO DAO=new ClsActivityReportDAO(); %> 
 <%
 String typedocno=request.getParameter("docno")==null?"0":request.getParameter("docno");
 String refnames=request.getParameter("refnames")==null?"0":request.getParameter("refnames");
 String dtype=request.getParameter("dtype")==null?"0":request.getParameter("dtype");
 String cldocno=request.getParameter("cldocno")==null?"0":request.getParameter("cldocno");
 String check=request.getParameter("check")==null?"0":request.getParameter("check");
%>
 
<script type="text/javascript">

    $(document).ready(function () { 	
        	var jobdata;

        	var temps='<%=check%>';

        	if(parseInt(temps)==1)
        		{
        		jobdata='<%=DAO.jobSearchGridLoading(session,typedocno,refnames,check,dtype,cldocno) %>'; 
        		temps="";
        		}
        	else
        		{
        		jobdata; 
        		}


 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                             {name : 'tr_no', type: 'int'},   
                             {name : 'doc_no', type: 'int'},  
     		 				 {name : 'customer', type: 'string'},
     						 {name : 'prjname', type: 'string'   },
     						 {name : 'cldocno', type: 'string'   },
     						 {name : 'site', type: 'string'   },
     						 {name : 'siteid', type: 'string'   },
			                ],
			                localdata: jobdata,
                
                
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

            
            
            $("#jobSearchDetailsGridID").jqxGrid(
            {
                width: '99%',
                height: 303,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlerow',
                       
                columns: [      
                         
							{ text: 'DocNo', datafield: 'doc_no', width: '10%', editable: false },	
							{ text: 'Customer', datafield: 'customer', width: '50%' , editable: false},
							{ text: 'Project Name', datafield: 'prjname', width: '40%', editable: false },
							{ text: 'cldocno', datafield: 'cldocno', width: '40%', editable: false ,hidden:true },
							{ text: 'site', datafield: 'site', width: '40%', editable: false ,hidden:true   },
							{ text: 'siteid', datafield: 'siteid', width: '40%', editable: false ,hidden:true  },
							{ text: 'tr_no', datafield: 'tr_no', width: '40%', editable: false,hidden:true  },	
			              ]
            
            });
            
            
            $('#jobSearchDetailsGridID').on('rowdoubleclick', function (event) {
         	   
         	      var rowindex1 = event.args.rowindex;  
         	      var rowindex2=$('#rowindex').val();
                  $('#activityReportGridID').jqxGrid('setcellvalue', rowindex2, "jobno",$('#jobSearchDetailsGridID').jqxGrid('getcellvalue', rowindex1, "doc_no"));
             	   
                  var rows = $('#activityReportGridID').jqxGrid('getrows');
              	  var rowlength= rows.length;
              	  var rowindex1 = rowlength - 1;
            	  var intime=$("#activityReportGridID").jqxGrid('getcellvalue', rowindex1, "intime");
            	  if(typeof(intime) != "undefined"){
                  	$("#activityReportGridID").jqxGrid('addrow', null, {});
            	  }
            	    
                  $('#jobDetailsWindow').jqxWindow('close'); 
             });  
            
        });
    </script>
    <div id=jobSearchDetailsGridID></div>
 