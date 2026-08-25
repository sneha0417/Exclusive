    <%-- <jsp:include page="../../includes.jsp"></jsp:include>  --%> 
    
  <%@page import="com.dashboard.project.servicesalelist.ClsServiceSaleListDAO" %>
<%
ClsServiceSaleListDAO sd=new ClsServiceSaleListDAO();
%>
    
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>


 <% String fromdate =request.getParameter("froms")==null?"0":request.getParameter("froms").toString();%>
 <% String todate =request.getParameter("tos")==null?"0":request.getParameter("tos").toString();%>
 <% String rds =request.getParameter("rds")==null?"0":request.getParameter("rds").toString();%>
 <% String barchval =request.getParameter("barchval")==null?"0":request.getParameter("barchval").toString();%>
 <% String contrctid =request.getParameter("contrctid")==null?"0":request.getParameter("contrctid").toString();%>
  <% String clientid =request.getParameter("clientid")==null?"0":request.getParameter("clientid").toString();%>
  <% String zoneid =request.getParameter("zoneid")==null?"0":request.getParameter("zoneid").toString();%>

 <script type="text/javascript">
 var data,projectlistexcel;
 
 var rendererstring=function (aggregates){
	  	var value=aggregates['sum'];
	  	
	  	if(typeof(value)=='undefined'){
	  		value=0;
	  	}
	  	return '<div style="float: left; margin: 4px;font-size:12px; overflow: hidden;">' + "" + ' ' + value + '</div>';
		}
	  	var rendererstring1=function (aggregates){
	  	var value1=aggregates['sum1'];
	  	return '<div style="float: left; margin: 4px;font-size:12px; overflow: hidden;">' + " Total" + '</div>';
	  }
 
 
 var bb='<%=rds%>';
	if(bb!='0'){
 data= '<%= sd.loadSummaryData(fromdate,todate,clientid,barchval,zoneid)%>';
 projectlistexcel= '<%= sd.loadSummaryExcel(fromdate,todate,clientid,barchval,zoneid)%>';
	}
	else{
		bb=1;
	}
    //alert("==================loadSalikData");
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'voc_no', type: 'String'  },
     						{name : 'client', type: 'String' },
     						{name : 'invno', type: 'number' },
     						{name : 'date', type: 'date' },
     						{name : 'total', type: 'number' },
     						{name : 'desc1', type: 'String' },
     						{name : 'brhid', type: 'String' },
     					
     					     						
                 ],
                 localdata: data,
                
                
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
            $("#jqxloaddataGrid").jqxGrid(
            {
                width: '99%',
                height: 480,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                showfilterrow:true,
                enabletooltips:true,
                filterable: true,
                showaggregates:true,
                showstatusbar:true,
                statusbarheight: 25,
                
                //Add row method
                columns: [
                     { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '4%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },
					{ text: 'Doc No', datafield: 'voc_no', width: '5%' },
					{ text: 'Date', datafield: 'date', width: '8%',cellsformat:'dd.MM.yyyy' },
					{ text: 'Branch', datafield: 'brhid', width: '5%' },
					{ text: 'Po No', datafield: 'invno', width: '5%' },
					{ text: 'Client', datafield: 'client', width: '25%' },
					{ text: 'Description', datafield: 'desc1', },
					{ text: 'Total',  datafield: 'total', width: '8%',cellsalign:'right',align:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring  },
					
					
					
					
	              ]
            });
            if(bb==1)
        	{
        	 $("#jqxloaddataGrid").jqxGrid('addrow', null, {});
        	}

                 $("#overlay, #PleaseWait").hide();
        });
    </script>
    <div id="jqxloaddataGrid"></div>
