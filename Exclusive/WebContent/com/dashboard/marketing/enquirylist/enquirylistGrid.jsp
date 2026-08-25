   <%@page import="com.dashboard.marketing.enquirylist.ClsEnqiryListDAO"%>
     <%
     ClsEnqiryListDAO cmd= new ClsEnqiryListDAO();
     %>
 
 
 <%
    String barchval = request.getParameter("barchval")==null?"0":request.getParameter("barchval").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  	String clientname = request.getParameter("clientname")==null?"0":request.getParameter("clientname").trim();
	String srcno = request.getParameter("srcno")==null?"0":request.getParameter("srcno").trim();
	String salid = request.getParameter("salid")==null?"0":request.getParameter("salid").trim();
   String rds =request.getParameter("rds")==null?"0":request.getParameter("rds").toString();
   String areaid =request.getParameter("areaid")==null?"0":request.getParameter("areaid").toString();
  	
  	
 %> 
           	  
 
<script type="text/javascript">
 var temp4='<%=barchval%>';
var enqdata,enqlistexcel;

 if(temp4!='0')
{ 
	
	 enqdata='<%=cmd.enquirylistsearch(barchval,fromdate,todate,clientname,srcno,salid,rds,areaid) %>'; 
	 enqlistexcel='<%=cmd.enquirylistExcel(barchval,fromdate,todate,clientname,srcno,salid,rds,areaid)%>';
		// alert(enqdata);
} 
else
{ 
	
	enqdata;
	
	}  

$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
                     
                        {name : 'doc_no', type: 'String'  },
                        {name : 'voc_no', type: 'String'  },
						{name : 'date', type: 'date'  },
						{name : 'type', type: 'String'  },
						{name : 'name', type: 'String'  },
						{name : 'remarks', type: 'String'  },
						{name : 'mob', type: 'String'},
						{name : 'salm', type: 'String'  },
					
						{name : 'source', type: 'String'  },
						{name : 'status', type: 'String'  },
					
						
						],
				    localdata: enqdata,
        
        
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
   
    $("#enqlistgrid").jqxGrid(
    {
        width: '99%',
        height: 500,
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
           	         { text: 'Type', datafield: 'type',  width: '6%' }, 
					 { text: 'Date', datafield: 'date', width: '7%',cellsformat:'dd.MM.yyyy'},
				     { text: 'Doc No',datafield: 'voc_no', width: '6%' },
				     { text: 'hidDoc No',datafield: 'doc_no', width: '6%',hidden:true },
				     { text: 'Client',datafield: 'name', width: '18%' },
				     { text: 'Salesman', datafield: 'salm', width: '18%'},
					 { text: 'MOB', datafield: 'mob', width: '10%' },
					 { text: 'Remarks', datafield: 'remarks', width: '19%'},
					 { text: 'Source', datafield: 'source', width: '12%'},
					 { text: 'Status', datafield: 'status', width: '12%'},
					]
   
    });
    $("#overlay, #PleaseWait").hide();
    
   
});


</script>
<div id="enqlistgrid"></div>