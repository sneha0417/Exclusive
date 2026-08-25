<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.projectexecution.deploytechniciandetails.ClsDeployTechnicianDetailsDAO"%>
<% ClsDeployTechnicianDetailsDAO DAO=new ClsDeployTechnicianDetailsDAO(); %>
<%
 String id=request.getParameter("id")==null?"0":request.getParameter("id");
  String empid=request.getParameter("empid")==null?"0":request.getParameter("empid");
%> 
<script type="text/javascript">


    $(document).ready(function () { 	
        	var data3;

      	var id='<%=id%>';

        	if(id=="1")  
        		{
          		 data3='<%=DAO.empSubGridLoading(empid,id) %>'; 
        		}
        	 else{
        		     data3;
        		}

 var rendererstring=function (aggregates){
	  	var value=aggregates['sum'];
	  	
	  	if(typeof(value)=='undefined'){
	  		value=0;
	  	}
	  	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "" + ' ' + value + '</div>';
		}
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            
                             {name : 'date', type: 'String' },
				             {name : 'jobtype', type: 'String' },
				             {name : 'jobno', type: 'String' },
				             {name : 'site', type: 'string' },
				             {name : 'client', type: 'String' },
				             {name : 'frmtime', type: 'String' },
				             {name : 'totime', type: 'String' },
				             {name : 'hrs', type: 'string' },
				             {name : 'rate', type: 'number' },
				             {name : 'val', type: 'number' }
                 ],
                 localdata: data3,
                
                
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
            
            $("#jqxemp2Grid").jqxGrid(
            {  
                width: '100%',
                height: 250,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlerow',
                filterable: true,      
                showfilterrow: true,
                columnsresize: true,
                showaggregates:true,  
                showstatusbar:true,
                statusbarheight: 25,
                       
                columns: [      
                         
							{ text: 'Date', datafield: 'date', width: '10%', editable: false },
							{ text: 'Job Type', datafield: 'jobtype', width: '8%', editable: false },	
							{ text: 'Job No', datafield: 'jobno', width: '8%', editable: false },
						    { text: 'Site', datafield: 'site', width: '20%', editable: false },
							{ text: 'Client', datafield: 'client', width: '12%', editable: false },
							{ text: 'From Time', datafield: 'frmtime', width: '8%', editable: false },	
							{ text: 'To Time', datafield: 'totime', width: '8%', editable: false },
							{ text: 'No of Hrs', datafield: 'hrs', width: '8%', editable: false ,cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
							{ text: 'Rate', datafield: 'rate', width: '9%', editable: false },	
							{ text: 'Value', datafield: 'val', width: '9%', editable: false,cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring}	
			              ]
            
            });
            $("#overlay, #PleaseWait").hide(); 
        });
    </script>
    <div id=jqxemp2Grid></div>
 