<%@page import="com.dashboard.marketing.quotationdetail.ClsQuotationDetailDAO"%> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<%ClsQuotationDetailDAO DAO= new ClsQuotationDetailDAO(); %>
<% String docno=request.getParameter("docno")==null?"0":request.getParameter("docno").trim().toString(); %>
    <script type="text/javascript">
    var sitedata;
    var docno='<%=docno%>';
    
    $(document).ready(function () { 
    	
    	 if(parseInt(docno)>0){
    		sitedata='<%=DAO.siteGridLoad(session,docno)%>';
    		
    	} 
            
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'rowno' , type: 'number' },
     						{name : 'site', type: 'String'  },
                          	{name : 'area', type: 'String'  },
                          	{name : 'amount', type: 'String'  },
                          	{name : 'areaid', type: 'String'  },
                          	],
                 localdata: sitedata,
                
                
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
            $("#siteGridID").jqxGrid(
            {
                width: '100%',
                height: 130,
                source: dataAdapter,
                columnsresize: true,
                sortable: true,
                selectionmode: 'singlecell',
                sortable: true,
                editable:true,
	
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '5%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Site', datafield: 'site', width: '50%' },
					{text: 'Area',datafield:'area',width:'45%',editable: false},
					{text: 'Areaid',datafield:'areaid',width:'25%',editable: false,hidden: true},
					{text: 'rowno',datafield:'rowno',width:'25%',editable: false,hidden: true},
					]
            });
            
            $('#siteGridID').on('celldoubleclick', function(event) 
            		{
            	var rowBoundIndex = event.args.rowindex;    
            	var datafield = event.args.datafield;
            	
 		      
 		      if((datafield=="area"))
	    	   {
 		    	 getareas(rowBoundIndex);
	    	   }
 		     /* if((datafield=="site"))
	    	   {
 		    	getsite(rowBoundIndex);
	    	   } */
		     
            			
            		});
            
            if($('#mode').val()=='view'){
                
          		 $("#siteGridID").jqxGrid({ disabled: true});
              }
            
                 
            $("#siteGridID").jqxGrid('addrow', null, {});
        });
    </script>
    
    <div id="siteGridID"></div>
