    <%-- <jsp:include page="../../includes.jsp"></jsp:include>  --%> 
    
  <%@page import="com.dashboard.procurment.reservedproduct.ClsReservedProductDAO" %>
<%
ClsReservedProductDAO sd=new ClsReservedProductDAO();
%>
    
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>


 <% String fromdate =request.getParameter("froms")==null?"0":request.getParameter("froms").toString();%>
 <% String todate =request.getParameter("tos")==null?"0":request.getParameter("tos").toString();%>
 <% String rds =request.getParameter("rds")==null?"0":request.getParameter("rds").toString();%>
 <% String barchval =request.getParameter("barchval")==null?"0":request.getParameter("barchval").toString();%>
 <% String contrctid =request.getParameter("contrctid")==null?"0":request.getParameter("contrctid").toString();%>
  <% String clientid =request.getParameter("clientid")==null?"0":request.getParameter("clientid").toString();%>
  <% String productid =request.getParameter("productid")==null?"0":request.getParameter("productid").toString();%>
  <% String brandid =request.getParameter("brandid")==null?"0":request.getParameter("brandid").toString();%>

 <% String type =request.getParameter("type")==null?"0":request.getParameter("type").toString();%>
  <% String cldocno =request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").toString();%>

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
 data= '<%= sd.loadGridData(fromdate,todate,rds,barchval,contrctid,clientid,brandid,productid,cldocno,type)%>';
 servicereportlistexcel= '<%= sd.loadGridExcel(fromdate,todate,rds,barchval,contrctid,clientid,brandid,productid,cldocno,type)%>';
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
                             {name : 'cldocno', type: 'String'  },
     						{name : 'clientname', type: 'String'  },
     						{name : 'dtype', type: 'String' },
     						{name : 'doc_no', type: 'String' },
     						{name : 'site', type: 'String' },
     						{name : 'rsrvqty', type: 'String' },
     						{name : 'isuqty', type: 'String' },
     						{name : 'sl', type: 'number' },
     						{name : 'prdname', type: 'String' },
     						{name : 'brdname', type: 'String' },
     						{name : 'code', type: 'String' },
     						{name : 'name', type: 'String' },
     						{name : 'tr_no', type: 'String' }
     					     						
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
                height: 545,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                showaggregates:true,
                showstatusbar:true,
                statusbarheight: 25,
                sortable: true,
                //Add row method
                columns: [
                    { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '4%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }   
                    },	
                    { text: 'Code', datafield: 'code', width: '8%' },
                    { text: 'Product Name', datafield: 'prdname', width: '15%' },
					{ text: 'Brand Name', datafield: 'brdname', width: '15%' },
					{ text: 'Cldocno', datafield: 'cldocno', width: '5%' ,hidden:true},
					{ text: 'Customer',  datafield: 'clientname', width: '18%' },
					{ text: 'Contract Type', datafield: 'dtype', width: '8%' },
					{ text: 'Contract No.', datafield: 'tr_no', width: '7%' },
					{ text: 'Area', datafield: 'site', width: '11%' },
					{ text: 'Reserved Qty', datafield: 'rsrvqty', width: '7%' },
					{ text: 'Issue Qty', datafield: 'isuqty', width: '7%' },
					
					
					
					
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
