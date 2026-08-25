<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.projectexecution.deploytechniciandetails.ClsDeployTechnicianDetailsDAO"%>
<% ClsDeployTechnicianDetailsDAO DAO=new ClsDeployTechnicianDetailsDAO(); %>
<%
 String jobno=request.getParameter("jobno")==null?"0":request.getParameter("jobno");
 String id=request.getParameter("id")==null?"0":request.getParameter("id");
 String frmdate=request.getParameter("frmdate")==null?"0":request.getParameter("frmdate").trim();
 String todate=request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
%> 
<script type="text/javascript">

    $(document).ready(function () {   	 
        	var data4;    

        var id='<%=id %>'
        if(id=="1")  
        		{
              	  	 data4='<%=DAO.jobGridLoading(jobno,frmdate,todate,id) %>';   
              	  Exceldata1='<%=DAO.jobExcelLoading(jobno,frmdate,todate,id) %>';  
        		}
        else{
        	data4;
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
                             {name : 'dtype', type: 'String'},   
                             {name : 'refdocno', type: 'String'},  
     		 				 {name : 'sname', type: 'string'},
     						 {name : 'clname', type: 'string' },
     						 {name : 'cperson', type: 'string' },
     						 {name : 'mob', type: 'string' },
     						 {name : 'bdgt', type: 'number' },
     						 {name : 'cnsmd', type: 'number' },
     						 {name : 'balance', type: 'number' },
                 ],
                 localdata: data4,
                
                
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
            
            $("#jqxjobGrid").jqxGrid(
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
							{ text: 'DocNo', datafield: 'refdocno', width: '10%', editable: false },	
							{ text: 'DType', datafield: 'dtype', width: '10%' , editable: false},
							{ text: 'Client Name', datafield: 'clname', width: '15%', editable: false },
							{ text: 'Site Name', datafield: 'sname', width: '15%', editable: false },
							{ text: 'Contact Person', datafield: 'cperson', width: '15%', editable: false  },
							{ text: 'Mobile', datafield: 'mob', width: '10%', editable: false },
							{ text: 'Job Budget', datafield: 'bdgt', width: '8%', editable: false,cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring  },
							{ text: 'Consumed', datafield: 'cnsmd', width: '8%', editable: false,cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},	
							{ text: 'Balance', datafield: 'balance', width: '9%', editable: false,cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
							
			              ]
            
            });
            $("#overlay, #PleaseWait").hide();   
            $('#jqxjobGrid').on('rowdoubleclick', function (event) { 
          	  var rowindex1=event.args.rowindex;
          	  
        		 /*  $("#deployTechnicianDetailsGridId").jqxGrid('clear');
        		  $("#manPowerConsumedGridId").jqxGrid('clear'); */
        		  
        		  var costtype =$('#jqxjobGrid').jqxGrid('getcellvalue', rowindex1, "dtype");
        		  var costcode =$('#jqxjobGrid').jqxGrid('getcellvalue', rowindex1, "refdocno");
        		 
        		  $("#deployTechnicianDetailsGridDiv").load("deployTechnicianDetailsGrid.jsp?costtype="+costtype+'&costcode='+costcode+'&check=1');
        		  $("#manPowerConsumedDiv").load("manPowerConsumedGrid.jsp?costtype="+costtype+'&costcode='+costcode+'&check=1');
        
		    }); 
          
            
        });
    </script>
    <div id=jqxjobGrid></div>
 