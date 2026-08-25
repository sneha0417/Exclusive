<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<%@page import="com.dashboard.realestate.propertyaccountmanagement.ClsPropertyAccountManagementDAO"%>
<%ClsPropertyAccountManagementDAO DAO= new ClsPropertyAccountManagementDAO(); %>
<% 
String ownid=request.getParameter("ownid")==null || request.getParameter("ownid")==""?"0":request.getParameter("ownid").toString();
String id=request.getParameter("id")==null || request.getParameter("id")==""?"0":request.getParameter("id").toString();
String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
%>
<script type="text/javascript">              
	var smdata;	  	 
	smdata='<%=DAO.loadsummaryGrid(ownid,id,toDate)%>';                          
     
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
          // prepare the data
          var source =
          {
              datatype: "json",
              datafields: [
						{name : 'acno', type: 'string'  },
						{name : 'mrfacno', type: 'string'  },
						{name : 'accname', type: 'string'  }, 
	                    {name : 'pcredit', type: 'number'  },
	                    {name : 'pdebit', type: 'number'  },
	                    {name : 'mcredit', type: 'number'  },
	                    {name : 'mdebit', type: 'number'  },
	                    {name : 'nettotal', type: 'number'  },   
                      ],
                       localdata: smdata,  
              
              pager: function (pagenum, pagesize, oldpagenum) {
                  // callback called when a page or page size is changed.
              }
          };
          
          var dataAdapter = new $.jqx.dataAdapter(source);
          $("#jqxsummaryGrid").jqxGrid(    
          {
              width: '100%',  
              height: 210,
              source: dataAdapter,
              altRows:true,
              showaggregates: true,   
              showstatusbar:true,
              statusbarheight:25,
              columnsresize:true,
              enabletooltips:true,
              selectionmode: 'singlecell',       
              columns: [  
					{ text: 'SL#', sortable: false, filterable: false,
					    groupable: false, draggable: false, resizable: false,
					    datafield: 'sl', columntype: 'number', width: '3%',
					    cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>"; 
					}  
					},
					{ text: 'Account Name', datafield: 'accname'}, 
					{ text: 'Debit', datafield: 'pdebit', width: '7%',columngroup:'pro',cellsalign:'right',cellsformat:'d2',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
				    { text: 'Credit', datafield: 'pcredit', width: '7%',columngroup:'pro',cellsalign:'right',cellsformat:'d2',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },  
				    { text: 'Debit', datafield: 'mdebit', width: '7%',columngroup:'mrf',cellsalign:'right',cellsformat:'d2',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
					{ text: 'Credit', datafield: 'mcredit', width: '7%',columngroup:'mrf',cellsalign:'right',cellsformat:'d2',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },  
					{ text: 'Total', datafield: 'nettotal', width: '7%',cellsalign:'right',cellsformat:'d2',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring }, 
					{ text: 'proacno', datafield: 'acno',hidden:true,width:'5%'},
					{ text: 'mrfacno', datafield: 'mrfacno',hidden:true,width:'5%'},
				], columngroups: 
                    [
                     { text: 'Property', align: 'center', name: 'pro',width: '20%' },
                     { text: 'MRF', align: 'center', name: 'mrf',width: '10%' },
                   ]  
          });  
          $("#overlay, #PleaseWait").hide();
          $('#jqxsummaryGrid').on('celldoubleclick', function(event){       
              	var rowindex2 = event.args.rowindex;  
              	var datafield = event.args.datafield; 
              	if(datafield=="pcredit" || datafield=="pdebit"){
	   		    	var acno=$('#jqxsummaryGrid').jqxGrid('getcellvalue', rowindex2, "acno");
	   		    	loadsummaryASGrid(acno);
	  	    	}
              	if(datafield=="mcredit" || datafield=="mdebit"){
	   		    	var acno=$('#jqxsummaryGrid').jqxGrid('getcellvalue', rowindex2, "mrfacno");
	   		    	loadsummaryASGrid(acno);       
	  	    	}
            });     
      });
</script>      
   <div id="jqxsummaryGrid"></div> 