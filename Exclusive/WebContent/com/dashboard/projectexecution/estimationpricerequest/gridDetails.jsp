    <%-- <jsp:include page="../../includes.jsp"></jsp:include>  --%> 
    
  <%@page import="com.dashboard.projectexecution.estimationpricerequest.estimationpricerequestDAO" %>
<%
estimationpricerequestDAO sd=new estimationpricerequestDAO();
%>
    
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>


 <% String fromdate =request.getParameter("froms")==null?"0":request.getParameter("froms").toString();%>
 <% String todate =request.getParameter("tos")==null?"0":request.getParameter("tos").toString();%>
 <% String rds =request.getParameter("rds")==null?"0":request.getParameter("rds").toString();%>
 <% String barchval =request.getParameter("barchval")==null?"0":request.getParameter("barchval").toString();%>

 <script type="text/javascript">
 var data,projectlistexcel;
 

 
 var bb='<%=rds%>';
	if(bb!='0'){
 data= '<%= sd.loadGridData(fromdate,todate)%>';
<%--  projectlistexcel= '<%= sd.loadGridExcel(fromdate,todate,rds,barchval)%>'; --%>
	}
	
    //alert("==================loadSalikData");
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'String'  },
     						{name : 'refdet', type: 'String'  },
     						{name : 'client', type: 'String' },
     						{name : 'productid', type: 'String' },
     						{name : 'productname', type: 'String' },
     					
     						{name : 'brandname', type: 'String' },
     						{name : 'unit', type: 'String' },
     						{name : 'qty', type: 'String' },
     						{name : 'proname', type: 'string'    },
                    		{name : 'prodoc', type: 'number'    },
     						{name : 'unitdocno', type: 'number'    },
     						{name : 'psrno', type: 'number'    },
     						{name : 'proid', type: 'number'    },
     						{name : 'specid', type: 'number'    },  
     						{name : 'stypeid', type: 'number'    },
     						
     						{name : 'brandid', type: 'number'    }, 
     						
     					     						
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
            $("#jqxEstPriceGrid").jqxGrid(
            {
                width: '99%',
                height: 545,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'checkbox',
                filtermode:'excel',
                filterable: true,
                
                sortable: true,
                //Add row method
                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
					{ text: 'Ref Details',  datafield: 'refdet', width: '10%' },
					{ text: 'Client', datafield: 'client', width: '18%' },
					{ text: 'Product', datafield: 'productid', width: '15%' },
					{ text: 'Product Name', datafield: 'productname', width: '14%' },
					{ text: 'Brand', datafield: 'brandname', width: '10%' },
					{ text: 'Unit', datafield: 'unit', width: '10%'  },
					{ text: 'Quantity',  datafield: 'qty', width: '10%' },
					{text: 'pid', datafield: 'proid', width: '10%',hidden:true }, 
						{text: 'pname', datafield: 'proname', width: '10%',hidden:true },
						{text: 'prodoc', datafield: 'prodoc', width: '10%',hidden:true},
					{text: 'unitdocno', datafield: 'unitdocno', width: '10%',hidden:true },
					{text: 'psrno', datafield: 'psrno', width: '10%',hidden:true},
					{text: 'specid', datafield: 'specid', width: '10%',hidden:true}, 
					{text: 'brandid', datafield: 'brandid', width: '10%',hidden:true},
					{text: 'stypeid', datafield: 'stypeid', width: '10%',hidden:true},
					
					
	              ]
            });
            

                 $("#overlay, #PleaseWait").hide();
        });
    </script>
    <div id="jqxEstPriceGrid"></div>
