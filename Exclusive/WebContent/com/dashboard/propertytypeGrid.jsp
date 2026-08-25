<%@page import="com.dashboard.ClsDashBoardDAO"%>
<%ClsDashBoardDAO DAO= new ClsDashBoardDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String type = request.getParameter("type")==null?"0":request.getParameter("type").trim(); %>

<style type="text/css">
	   .gmClass
	  {
	      background-color: #F1F8E0;
	  }
	  .gaClass
	  {
	      background-color: #FBEFF5;
	  }
	  .gsClass
	  {
	      background-color: #FFFDE0;
	  }
</style>
<script type="text/javascript">
   
        $(document).ready(function () { 	
        	  
        	var temp='<%=type%>';
        	var datas6;
        	
        	
        	 datas6= '<%=DAO.TypewisePropertyLoading()%>'; 	
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'ptype', type: 'string'  },
     						{name : 'total', type: 'number'   },
     						{name : 'available', type: 'number'   },
     						{name : 'contracted', type: 'number'   }
                        ],
                		  localdata: datas6, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };

            var dataAdapter = new $.jqx.dataAdapter(source);
            
            var tooltiprenderer = function (element) {
                $(element).jqxTooltip({position: 'mouse', content: $(element).text() });
            };
            
            $("#brandGarageID").jqxGrid(
            {
                width: '99%',
                height: 190,
                source: dataAdapter,
                columnsresize: true,
                sortable: true,
                altrows: true,
                enabletooltips: true,
                filtermode:'excel',
                filterable: true,
                selectionmode: 'singlerow',
                       
                columns: [
                          
							{ text: 'Property Type', datafield: 'ptype', rendered: tooltiprenderer, width: '40%' },
							{ text: 'Total', datafield: 'total', cellclassname: 'gmClass' ,cellsalign: 'center', align: 'center',rendered: tooltiprenderer, width: '20%' },
							{ text: 'Available', datafield: 'available', cellclassname: 'gaClass' ,cellsalign: 'center', align: 'center',rendered: tooltiprenderer, width: '20%' },
							{ text: 'Contracted', datafield: 'contracted', cellclassname: 'gsClass' ,cellsalign: 'center', align: 'center',rendered: tooltiprenderer, width: '20%' },
						]
            });
            
            	$("#brandGarageID").on("columnclick", function (event) {
            		    
            		  
            		    
            	});
            
            
        });
</script>
<div id="brandGarageID"></div>