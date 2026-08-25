 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.salesandmarketing.Sales.joborder.ClsJobOrderDAO"%>
<%ClsJobOrderDAO DAO= new ClsJobOrderDAO(); 

		 
 
String cldocno=request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").toString();
 

%>
<script type="text/javascript">
		 var vdata;  
        $(document).ready(function () { 
        	var cldocno='<%=cldocno%>';
 
        	
    		if(cldocno>=0){
    			vdata='<%=DAO.vehLoad(session,cldocno)%>'; 
    		}


    		// prepare the data  
            var source =
            {
                datatype: "json",
                datafields: [
     						
{name : 'regno', type: 'string'  },
{name : 'model', type: 'string'  },
{name : 'modelid', type: 'int'   },
{name : 'submodel', type: 'string'  },
{name : 'submodelid', type: 'int'   },
{name : 'brand', type: 'string'   },
{name : 'brandid', type: 'int'   },
{name : 'yom', type: 'string'   },

{name : 'yomid', type: 'int'   },
{name : 'esize', type: 'string'   },
{name : 'esizeid', type: 'int'   },
{name : 'bsize', type: 'string'   },
{name : 'bsizeid', type: 'int'   },

{name : 'csize', type: 'string'   },
{name : 'csizeid', type: 'int'   },

{name : 'forms', type: 'string'   },

{name : 'doc_no', type: 'int'   },


     						
							
                        ],
                         localdata: vdata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#vehdetgrid").jqxGrid(
            {
                width: '100%',
                height: 358,
                source: dataAdapter,
                editable: false,
               
                columnsresize: true,
                selectionmode: 'singlerow',
                handlekeyboardnavigation: function (event) {
                 
   },      
                columns: [
						
                            { text: 'Reg No', datafield: 'regno', editable: true, width: '8%' },
                            { text: 'Yom', datafield: 'yom', width: '7%' , editable: false},
                            { text: 'Yomid', datafield: 'yomid', editable: false,  width: '10%' ,hidden:true},
                          
                            { text: 'modelid', datafield: 'modelid', width: '5%'  ,hidden:true },
                            { text: 'brandid', datafield: 'brandid', width: '5%'  ,hidden:true },
                            { text: 'submodelid', datafield: 'submodelid', width: '5%'  ,hidden:true },
                      
                            { text: 'Brand', datafield: 'brand', editable: false, width: '18%'  },
                            { text: 'Model', datafield: 'model', editable: false, width: '18%'  },
                            { text: 'Sub Model', datafield: 'submodel', editable: false, width: '15%' },
                            { text: 'EngineSize', datafield: 'esize', editable: false, width: '12%' },
                            { text: 'esizeid', datafield: 'esizeid' , width: '11%' ,hidden:true  },
                            { text: 'BedSize', datafield: 'bsize', editable: false, width: '11%' },
                           
                            { text: 'bsizeid', datafield: 'bsizeid' , width: '11%' ,hidden:true },
                          
                            { text: 'CabinSize', datafield: 'csize', editable: false, width: '11%'  },
                            
                            
                            { text: 'csizeid', datafield: 'csizeid'  , width: '12%'  ,hidden:true },
                         

                            { text: 'froms', datafield: 'forms', editable: false, width: '11%'   ,hidden:true  },
	
                            { text: 'doc_no', datafield: 'doc_no', editable: false, width: '11%'   ,hidden:true  },
                            
						

						]
            });
            
 
            $('#vehdetgrid').on('rowdoubleclick', function (event) {
           
           	 var rowindextemp = event.args.rowindex;
 
     		document.getElementById("regno").value=$('#vehdetgrid').jqxGrid('getcellvalue', rowindextemp, "regno");
     		
     		document.getElementById("brand").value=$('#vehdetgrid').jqxGrid('getcellvalue', rowindextemp, "brand");
     		document.getElementById("brandid").value=$('#vehdetgrid').jqxGrid('getcellvalue', rowindextemp, "brandid");
     		
     		document.getElementById("model").value=$('#vehdetgrid').jqxGrid('getcellvalue', rowindextemp, "model");
     		document.getElementById("modelid").value=$('#vehdetgrid').jqxGrid('getcellvalue', rowindextemp, "modelid");
     		
     		document.getElementById("submodel").value=$('#vehdetgrid').jqxGrid('getcellvalue', rowindextemp, "submodel");
     		document.getElementById("submodelid").value=$('#vehdetgrid').jqxGrid('getcellvalue', rowindextemp, "submodelid");
     		
     		document.getElementById("yom").value=$('#vehdetgrid').jqxGrid('getcellvalue', rowindextemp, "yom");
     		document.getElementById("yomid").value=$('#vehdetgrid').jqxGrid('getcellvalue', rowindextemp, "yomid");
     		
     		document.getElementById("esize").value=$('#vehdetgrid').jqxGrid('getcellvalue', rowindextemp, "esize");
     		document.getElementById("esizeid").value=$('#vehdetgrid').jqxGrid('getcellvalue', rowindextemp, "esizeid");
     		
     		
     		document.getElementById("bsize").value=$('#vehdetgrid').jqxGrid('getcellvalue', rowindextemp, "bsize");
     		document.getElementById("bsizeid").value=$('#vehdetgrid').jqxGrid('getcellvalue', rowindextemp, "bsizeid");
     		
     		document.getElementById("csize").value=$('#vehdetgrid').jqxGrid('getcellvalue', rowindextemp, "csize");
     		document.getElementById("csizeid").value=$('#vehdetgrid').jqxGrid('getcellvalue', rowindextemp, "csizeid");
     		
     		
     		document.getElementById("refdocnos").value=$('#vehdetgrid').jqxGrid('getcellvalue', rowindextemp, "doc_no");
     		
     		
     		
           	 
     		 $('#sidesearchwndow1').jqxWindow('close'); 
      /*         	  
           	 regno brand model submodel yom esize  bsize csize  brandid  modelid yomid esizeid bsizeid csizeid */
           	 
           	 
                  }); 
            
          
            
            
          
        });
</script>

<div id="vehdetgrid"></div>




   