<%@page import="com.operations.marketing.enquirynew.ClsEnquiryDAO" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsEnquiryDAO DAO= new ClsEnquiryDAO(); %>
 <%
 String sitedocno=request.getParameter("sitedocno")==null?"0":request.getParameter("sitedocno").trim().toString();
 
 %>
    <script type="text/javascript">
    var sitedata;
    var sitedocno='<%=sitedocno%>';
    
    $(document).ready(function () { 
    	
    	if(sitedocno>0){
    		sitedata='<%=DAO.siteGridLoad(session,sitedocno)%>';
    	}	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'srno' , type: 'number' },
     						{name : 'site', type: 'String'  },
                          	{name : 'area', type: 'String'  },
                          	{name : 'areaid', type: 'String'  },
                          	{name : 'remarks', type: 'String'  },
                          	{name : 'surtype', type: 'String'  },
                          	{name : 'surid', type: 'String'  },
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
            $("#siteGrid").jqxGrid(
            {
                width: '100%',
                height: 130,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlecell',
                sortable: true,
                editable:true,
                //Add row method
	
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '5%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Site', datafield: 'site', width: '15%' },
					{text: 'Area',datafield:'area',width:'15%',editable:false},
					{ text: 'Remarks', datafield: 'remarks', width: '35%' },
					{ text: 'Survey Type', datafield: 'surtype', width: '30%' ,editable:false},
					
					{text: 'Areaid',datafield:'areaid',width:'25%',editable:false,hidden:true},
					{text: 'surveyid',datafield:'surid',width:'25%',editable:false,hidden:true}
					]
            });
            
            $('#siteGrid').on('celldoubleclick', function(event) 
            		{
            	var rowBoundIndex = event.args.rowindex;
            	var datafield = event.args.datafield;
            	
 		      
 		      if((datafield=="area"))
	    	   {
 		    	 getareas(rowBoundIndex);
	    	   }
 		     if((datafield=="surtype"))
	    	   {
 		    	 
 		    	getsertype(rowBoundIndex);
	    	   }
 		     
            			
            		});
            
            if($('#mode').val()=='view'){
                
          		 $("#siteGrid").jqxGrid({ disabled: true});
              }
                 
            $("#siteGrid").jqxGrid('addrow', null, {});
        });
    </script>
    <div id="siteGrid"></div>
