<%@page import="com.project.execution.projectInvoicereturn.ClsProjectInvoiceReturnDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsProjectInvoiceReturnDAO DAO= new ClsProjectInvoiceReturnDAO(); %>
 <%
 String gridload=request.getParameter("gridload")==null?"0":request.getParameter("gridload").trim().toString(); 
 String trno=request.getParameter("trno")==null?"0":request.getParameter("trno").trim().toString();
 String pjinvtrno=request.getParameter("pjinvtrno")==null?"0":request.getParameter("pjinvtrno").trim().toString();
 
 %>
    <script type="text/javascript">
    var expdata;
    var gridload='<%=gridload%>';
    
    if(gridload>0){
    	expdata = '<%=DAO.expenseGridLoading(session,pjinvtrno) %>';
    }
    if(gridload<=0){
    	expdata = '<%=DAO.expenseGridReloading(session,trno) %>';
    }
    
    
        $(document).ready(function () { 
        	
        	var rendererstring=function (aggregates){
               	var value=aggregates['sum'];
               	if(typeof(value) == "undefined"){
               		value=0.00;
               	}
               	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
               }
        	
        	var rendererstring1=function (aggregates){
                var value1=aggregates['sum1'];
                return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total : " + '</div>';
               }
        	
        	
         var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                             
                          	{name : 'qty', type: 'number'},
     						{name : 'amount', type: 'number'},
     						{name : 'total', type: 'number'},
     						{name : 'desc1', type: 'String'},
     						{name : 'psrno', type: 'String'},
     						{name : 'prdid', type: 'String'},
                          	],
                 localdata: expdata,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            $("#expenseGrid").on("bindingcomplete", function (event) {
             	
              	 var rowlength=$("#expenseGrid").jqxGrid('rows').records.length;
              	 
              	if(rowlength>0){
              		var summary= $("#expenseGrid").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
              		
            		  document.getElementById("txtexptotal").value=summary.sum; 
					//.replace(/,/g,'');
            		 var txtlegalamt=document.getElementById("txtlegalamt").value;
              		 var txtseramt=document.getElementById("txtseramt").value;
              		 var txtexptotal=document.getElementById("txtexptotal").value;
              		 var grtotal=(parseFloat(txtexptotal)+parseFloat(txtlegalamt)+parseFloat(txtseramt));
              		 document.getElementById("txtnettotal").value=grtotal;
              		
              	}
              	 
                 });
           
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#expenseGrid").jqxGrid(
            {
                width: '100%',
                height: 200,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                editable:false,
                showaggregates: true,
             	showstatusbar:true,
             	statusbarheight:20,
                rowsheight:25,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
	
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Description', datafield: 'desc1', width: '40%',editable:false },
					{ text: 'Qty', datafield: 'qty', width: '10%',editable:false},
					{ text: 'prdid', datafield: 'prdid', width: '10%',hidden:true},
					{ text: 'psrno', datafield: 'psrno', width: '10%',hidden:true},
					{ text: 'Unit price', datafield: 'amount', cellsalign: 'right', cellsformat: 'd2', align: 'right',aggregates: ['sum1'],aggregatesrenderer:rendererstring1 ,editable:false },
					{text: 'Total',datafield:'total',width:'40%',cellsalign: 'right', cellsformat: 'd2', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable:false},
					
					
					]
            });
            if($('#mode').val()=='view'){
       		 $("#expenseGrid").jqxGrid({ disabled: true});
       		
           }
            $('#expenseGrid').on('celldoubleclick', function(event) 
            		{
            	var rowBoundIndex = event.args.rowindex;
            	var datafield = event.args.datafield;
            	
 		      
 		      if((datafield=="stype"))
	    	   {
 		    	 getserType(rowBoundIndex);
	    	   }
 		    			
            		});
            
            $("#expenseGrid").jqxGrid('addrow', null, {});
      
        });
    </script>
    <div id="expenseGrid"></div>
