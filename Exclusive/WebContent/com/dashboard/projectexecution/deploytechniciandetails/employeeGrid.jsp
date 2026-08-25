<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.projectexecution.deploytechniciandetails.ClsDeployTechnicianDetailsDAO"%>
<% ClsDeployTechnicianDetailsDAO DAO=new ClsDeployTechnicianDetailsDAO(); %>
<%
 String id=request.getParameter("id")==null?"0":request.getParameter("id");
 String frmdate=request.getParameter("frmdate")==null?"0":request.getParameter("frmdate").trim();
 String sergroupid=request.getParameter("sergroupid")==null?"0":request.getParameter("sergroupid");
 String todate=request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
%> 
<script type="text/javascript">

    $(document).ready(function () { 	
        	var data2;

      var id='<%=id%>';

        	if(id=="1")  
        		{
        		 data2='<%=DAO.empMainGridLoading(sergroupid,frmdate,todate,id) %>'; 
        		 Exceldata2='<%=DAO.empMainExcelLoading(sergroupid,frmdate,todate,id) %>'; 
        		}else{
        			data2;
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
                            
                             {name : 'steam', type: 'String'},   
                             {name : 'empid', type: 'String'},  
 				             {name : 'name', type: 'string'},
				             {name : 'tothr', type: 'string' },
				             {name : 'totval', type: 'number' },
				             {name : 'avgrate', type: 'number' }
				           
                 ],
                 localdata: data2,
                
                
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
            
            $("#jqxempGrid").jqxGrid(
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
                            { text: 'Employee ID', datafield: 'empid', width: '10%' , editable: false},
							{ text: 'Service Team', datafield: 'steam', width: '25%', editable: false },	
							{ text: 'Name', datafield: 'name', editable: false },
							{ text: 'Total hrs', datafield: 'tothr', width: '10%', editable: false },
							{ text: 'Avg Rate Per hr', datafield: 'avgrate', width: '10%', editable: false ,cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
							{ text: 'Total Value', datafield: 'totval', width: '10%', editable: false ,cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring }
							]
            
            });
            $("#overlay, #PleaseWait").hide(); 
            $('#jqxempGrid').on('rowdoubleclick', function (event) { 
            	  var rowindex1=event.args.rowindex;
            	  var empid=$('#jqxempGrid').jqxGrid('getcellvalue', rowindex1, "empid");
            	  $("#overlay, #PleaseWait").show();
          		 $("#emp2Div").load("employeeGrid2.jsp?empid="+empid+'&id=1');
  		    }); 
            
        });
    </script>
    <div id=jqxempGrid></div>
 