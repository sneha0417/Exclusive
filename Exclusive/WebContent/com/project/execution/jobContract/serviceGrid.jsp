<%@page import="com.project.execution.jobContract.ClsJobContractDAO"%> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsJobContractDAO DAO= new ClsJobContractDAO(); %>
 <%
 String gridload=request.getParameter("gridload")==null?"0":request.getParameter("gridload").trim().toString(); 
 String docno=request.getParameter("docno")==null?"0":request.getParameter("docno").trim().toString();
 String trno=request.getParameter("trno")==null?"0":request.getParameter("trno").trim().toString();
 %>
    <script type="text/javascript">
    var servdata;
    var gridload='<%=gridload%>';
    var docno='<%=docno%>';
    var trno='<%=trno%>';
    
    if(gridload=="1" && trno>0){
    	servdata = '<%=DAO.serRefGridLoad(session,trno) %>';
    
    }
    
    if(docno>0){
		
    	servdata = '<%=DAO.serviceGridLoad(session,docno) %>';
    	
  }
    
    
        $(document).ready(function () { 	
         var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'stype' , type: 'String' },
                          	{name : 'stypeid' , type: 'String' },
     						{name : 'item', type: 'String'  },
                          	{name : 'qty', type: 'number'  },
     						{name : 'amount', type: 'number'  },
     						{name : 'total', type: 'number'  },
     						{name : 'desc1', type: 'String'  },
     						{name : 'trno', type: 'String'  },
     						{name : 'srno', type: 'String'  },
                          	],
                 localdata: servdata,
                
                
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
            $("#serviceGrid").jqxGrid(
            {
                width: '100%',
                height: 200,
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
					{ text: 'Service.Type', datafield: 'stype', width: '16%',editable:false },
					{ text: 'stypeid', datafield: 'stypeid', width: '10%',hidden:true},
					{ text: 'Item', datafield: 'item', width: '27%'},
					{ text: 'Qty', datafield: 'qty', width: '8%', cellsformat: 'd2' },
					{text: 'Amount',datafield:'amount',width:'8%', cellsformat: 'd2', cellsalign: 'right', align: 'right'},
					{text: 'Total',datafield:'total',width:'10%',editable:false, cellsformat: 'd2', cellsalign: 'right', align: 'right'},
					{text: 'Description',datafield:'desc1',width:'27%'},
					{text: 'trno',datafield:'trno',width:'10%',hidden:true},
					{text: 'srno',datafield:'srno',width:'40%',hidden:true}
					]
            });
            if($('#mode').val()=='view'){
       		 $("#serviceGrid").jqxGrid({ disabled: true});
       		
           }
            $('#serviceGrid').on('celldoubleclick', function(event) 
            		{
            	var rowBoundIndex = event.args.rowindex;
            	var datafield = event.args.datafield;
            	
 		      
 		      if((datafield=="stype"))
	    	   {
 		    	 getserType(rowBoundIndex,1);
	    	   }
 		    			
            		});
            $("#serviceGrid").on('cellvaluechanged', function (event) 
                    {
            	
            	var datafield = event.args.datafield;
        		
    		    var rowBoundIndex = event.args.rowindex;
    		    
    		            	   
    		    if(datafield=="qty" || datafield=="amount" )
    		  {
    		    	
    		    	var qty= $('#serviceGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");	
               	    var amount= $('#serviceGrid').jqxGrid('getcellvalue', rowBoundIndex, "amount");
               		var total;
    		    	if(!(qty==""||typeof(qty)=="undefined"|| typeof(qty)=="NaN" || typeof(amount)=="" || typeof(amount)=="undefined" || typeof(amount)=="NaN"))
           		   {
    		    		total=parseFloat(qty)*parseFloat(amount);
             			$('#serviceGrid').jqxGrid('setcellvalue', rowBoundIndex, "total",total);
           		   }
    		  
    		  }
            	
                    });
           
            $("#serviceGrid").jqxGrid('addrow', null, {});
      
        });
    </script>
    <div id="serviceGrid"></div>
