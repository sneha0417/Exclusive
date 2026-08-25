<%@page import="com.finance.nipurchase.vendormaster.ClsVendorDetailsDAO"%> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsVendorDetailsDAO DAO= new ClsVendorDetailsDAO(); %>
 <% String chk=request.getParameter("check")==null||request.getParameter("check")==""?"0":request.getParameter("check");%>
<% String id=request.getParameter("id")==null || request.getParameter("id")==""?"0":request.getParameter("id");%>
 
     <script type="text/javascript">
   
        $(document).ready(function () { 
        	
        	 var srvTypeData;   
        	           var temp= '<%=id %>';
        	             var tempchk= '<%=chk %>';
        	           //alert("temp====="+temp+"====="+tempchk);
           if(temp==1){ 
          srvTypeData = '<%=DAO.serviceTypeSearch(session,id,chk) %>';
          }
        	
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [ 
                          	{name : 'service_type' , type: 'String' },
     						{name : 'servid', type: 'String'  },
     						
                          	],
                 localdata: srvTypeData,
                
                
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
            $("#servTypeGrid").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'checkbox',
                editable:true,
                sortable: true,
                //Add row method--mm:ss
	
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '5%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
	                {text: 'Service Type',datafield:'service_type',width:'95%',editable:false},
	           	    {text: 'Service Id',datafield:'servid',width:'20%',editable:false,hidden:true},
	           	  
					]
            });
           /*   if($('#mode').val()=='view'){
       		 $("#servTypeGrid").jqxGrid({ disabled: true});
       		
           } */
		/*  if(docno>0){
        		
			$('#servTypeGrid').jqxGrid('showcolumn','site');
        		
          } */
            
            /* $('#servTypeGrid').on('cellValueChanged', function (event) 
            		{ 
            	
              	 var rowBoundIndex=event.args.rowindex;
              	 $('#servTypeGrid').jqxGrid('setcellvalue', rowBoundIndex, "pltime" ,new Date());
            
           });
             */
           /*  $('#servTypeGrid').on('celldoubleclick', function(event) 
            		{
            	var rowBoundIndex = event.args.rowindex;
            	var datafield = event.args.datafield;
            	
 		      
 		     if((datafield=="site"))
	    	   {
 		    	 $('#siteinfowindow').jqxWindow('open');
 		    	     var type=2;
 		    	      siteSearchContent('servicesitesearch.jsp?rowBoundIndex='+rowBoundIndex+'&type='+type);
	    	   }
 		    if((datafield=="service"))
	    	   {
 		    	var sert=3;
 		    	getserType(rowBoundIndex,sert);
	    	   }
 		    
            			
            		}); */
            
           
           /* $("#servTypeGrid").jqxGrid('addrow', null, {}); */
      
        });
    </script>
    <div id="servTypeGrid"></div>