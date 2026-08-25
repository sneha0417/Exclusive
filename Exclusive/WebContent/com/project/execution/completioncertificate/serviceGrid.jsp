<%@page import="com.project.execution.completioncertificate.ClsCompletionCertificateDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<% ClsCompletionCertificateDAO DAO= new ClsCompletionCertificateDAO(); %>
<% String trno=request.getParameter("ctrno")==null?"0":request.getParameter("ctrno").trim().toString(); %>

<script type="text/javascript">
    var servdata;
    var value2=0;
    var trno='<%=trno%>';
    var bb;
    
    if(trno>0){
    	servdata = '<%=DAO.serviceGridLoad(session,trno)%>';
    	bb=3;
  	 } else{
    	 bb=5;
     }
    
     var rendererstring=function (aggregates){
         	value2=aggregates['sum'];
        	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value2 + '</div>';
        }
    
        $(document).ready(function () { 	

            var source =
            {
                datatype: "json",
                datafields: [
                          
     						{name : 'date', type: 'date'  },
     						{name : 'docno', type: 'String'  },
     						{name : 'amount', type: 'String'  },
     						{name : 'invoiced', type: 'String'  },
     						{name : 'percentage', type: 'String'  },
     						{name : 'retention', type: 'String'  },
     						{name : 'retnper', type: 'String'  },
                          	],
                 localdata: servdata,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            $("#serviceGrid").on("bindingcomplete", function (event) {
            	
            	
             	 
                });
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#serviceGrid").jqxGrid(
            {
                width: '100%',
                height: 180,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                editable:true,
                sortable: true,
                //Add row method
	
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Doc No', datafield: 'docno', width: '10%',editable:false},
					{ text: 'Date', datafield: 'date', width: '10%',editable:false,cellsformat:'dd.MM.yyyy' },
					
					{text: 'Amount',datafield:'amount',width:'15%', cellsformat: 'd2', cellsalign: 'right', align: 'right',editable:false},
					{text: 'Percentage',datafield:'percentage',width:'15%', cellsformat: 'd2', cellsalign: 'right', align: 'right',editable:false},
					{text: 'Invoiced',datafield:'invoiced',width:'15%', cellsformat: 'd2', cellsalign: 'right', align: 'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
					{text: 'Retention Percentage',datafield:'retnper',width:'15%', cellsformat: 'd2', cellsalign: 'right', align: 'right',editable:false},
					{text: 'Retention',datafield:'retention',width:'16%', cellsformat: 'd2', cellsalign: 'right', align: 'right',editable:false},
					
					
					]
            });
            
            
            
            if($('#mode').val()=='view'){
            	
       		 $("#serviceGrid").jqxGrid({ disabled: true});
            	if(trno>0)
            		{
            	$('#contrtotinv').attr('disabled',false);
            	var summaryData3= $("#serviceGrid").jqxGrid('getcolumnaggregateddata', 'invoiced', ['sum'],true);
	         	document.getElementById("contrtotinv").value=summaryData3.sum.replace(/,/g,''); 
            		}
   
       		
           }
             	 
      
        });
    </script>
    <div id="serviceGrid"></div>
