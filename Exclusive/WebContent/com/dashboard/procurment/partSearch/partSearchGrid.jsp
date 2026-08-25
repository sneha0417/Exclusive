<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.procurment.partSearch.ClsPartSearchDAO"%>
<%ClsPartSearchDAO DAO= new ClsPartSearchDAO();%>
 <%
    String type = request.getParameter("type")==null?"0":request.getParameter("type").trim();
	String hidsmodel = request.getParameter("hidsmodel")==null?"0":request.getParameter("hidsmodel").trim();
	String hidsbrand = request.getParameter("hidsbrand")==null?"0":request.getParameter("hidsbrand").trim();
  	String hidyom = request.getParameter("hidyom")==null?"0":request.getParameter("hidyom").trim();
  	String hidspec1 = request.getParameter("hidspec1")==null?"0":request.getParameter("hidspec1").trim();
	String hidspec2 = request.getParameter("hidspec2")==null?"0":request.getParameter("hidspec2").trim();
  	String hidspec3 = request.getParameter("hidspec3")==null?"0":request.getParameter("hidspec3").trim();
  	String hidbrand = request.getParameter("hidbrand")==null?"0":request.getParameter("hidbrand").trim();
  	String hidtype = request.getParameter("hidtype")==null?"0":request.getParameter("hidtype").trim();
	String hidproduct = request.getParameter("hidproduct")==null?"0":request.getParameter("hidproduct").trim();
  	String hidcat = request.getParameter("hidcat")==null?"0":request.getParameter("hidcat").trim();
  	String hidsubcat = request.getParameter("hidsubcat")==null?"0":request.getParameter("hidsubcat").trim();
  	String branchid = request.getParameter("branchid")==null?"0":request.getParameter("branchid").trim();
  	String hidept = request.getParameter("hidept")==null?"0":request.getParameter("hidept").trim();
  	String suitid = request.getParameter("suitid")==null?"0":request.getParameter("suitid").trim();
  	String hidsubmodel = request.getParameter("hidsubmodel")==null?"0":request.getParameter("hidsubmodel").trim();
 %> 
           	  
 
<script type="text/javascript">
 var temp4='<%=type%>';
var partdata;

	if(temp4!="0"){
	  partdata='<%=DAO.partSearch(session,type,hidsbrand,hidsmodel,hidyom,hidspec1,hidspec2,hidspec3,hidbrand,hidtype,hidcat,hidsubcat,hidproduct,branchid,hidept,suitid,hidsubmodel)%>';
	}
	else{
		partdata;
	}

$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
                     
                     
                  
                     
                        {name : 'product', type: 'String'  },
                        {name : 'pdesc', type: 'String'  },
                        {name : 'type', type: 'String'  },
						{name : 'brand', type: 'String'  },
						{name : 'unit', type: 'String'  },
						{name : 'cat', type: 'String'  },
						{name : 'scat', type: 'String'  },
						{name : 'dept', type: 'String'  },
						{name : 'sbrand', type: 'String'},
						{name : 'smodel', type: 'String'},
						{name : 'submodel', type: 'String'},
						{name : 'branch', type: 'String'},
						{name : 'yomfrm', type: 'String' },
						{name : 'yomto', type: 'String' },
						{name : 'esize', type: 'string'   },
						{name : 'bsize1', type: 'string'   },
						{name : 'bsize2', type: 'string'   },
						{name : 'bsize3', type: 'string'   },
						{name : 'csize1', type: 'string'   },
						{name : 'csize2', type: 'string'   },
						{name : 'csize3', type: 'string'   }

						
						
						],
				    localdata: partdata,
        
        
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
    
    
   
   
    
    $("#partSearchgrid").jqxGrid(
    {
        width: '98%',
        height: 420,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '4%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },
                    { text: 'Branch', datafield: 'branch',  width: '10%' },
           	         { text: 'Product Code', datafield: 'product',  width: '10%' }, 
					 { text: 'Description', datafield: 'pdesc',  width: '20%'},
					 { text: 'Type',datafield: 'type', width: '10%' },
					 { text: 'Department',datafield: 'dept', width: '10%' },
				     { text: 'Brand',datafield: 'brand', width: '10%' },
					 { text: 'Category', datafield: 'cat', width: '10%' },
					 { text: 'SubCategory', datafield: 'scat', width: '10%'},
					 { text: 'Suit.Brand', datafield: 'sbrand', width: '10%'},
					 { text: 'Suit.Model', datafield: 'smodel', width: '10%'},
					 { text: 'YOM(From)', datafield: 'yomfrm', width: '5%'},
					 { text: 'YOM(To)', datafield: 'yomto', width: '5%'},
					 { text: 'Sub Model', datafield: 'submodel', editable: false, width: '15%',cellsalign: 'center', align: 'center' },
					 { text: 'EngineSize', datafield: 'esize', editable: false, width: '10%',cellsalign: 'center', align: 'center' },
					 { text: 'BedSize1', datafield: 'bsize1', editable: false, width: '10%',cellsalign: 'center', align: 'center' },
					 { text: 'BedSize2', datafield: 'bsize2', editable: false, width: '10%',cellsalign: 'center', align: 'center' },
					 { text: 'BedSize3', datafield: 'bsize3', editable: false, width: '10%',cellsalign: 'center', align: 'center' },
					 { text: 'CabinSize1', datafield: 'csize1', editable: false, width: '10%',cellsalign: 'center', align: 'center' },
					 { text: 'CabinSize2', datafield: 'csize2', editable: false, width: '10%',cellsalign: 'center', align: 'center' },
					 { text: 'CabinSize3', datafield: 'csize3', editable: false, width: '10%',cellsalign: 'center', align: 'center' },
					]
   
    });

    $("#overlay, #PleaseWait").hide();
});


</script>
<div id="partSearchgrid"></div>