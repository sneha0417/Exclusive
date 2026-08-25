    
  <%@page import="com.dashboard.projectexecution.boqpricefollowup.ClsBoqpriceFollowupDAO"%>
<%
ClsBoqpriceFollowupDAO sd=new ClsBoqpriceFollowupDAO();
%>
    
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

 <%

   
     String branchval =request.getParameter("branchval")==null?"0":request.getParameter("branchval").toString();
     String fromdate =request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").toString();
     String todate =request.getParameter("todate")==null?"0":request.getParameter("todate").toString();
     String check=request.getParameter("check")==null?"0":request.getParameter("check").toString();
    
     
     %>
     <style type="text/css">
    
    .colorClass
    {
        background-color: #F9E79F;
    }
 
    
</style>
 <script type="text/javascript">
 var data,dataexcel;
 
 var flchk='<%=check%>';

	if(flchk!='0'){
		
 data= '<%= sd.loadGridData(fromdate,todate)%>';
<%--  dataexcel= '<%= sd.loadGridExcel(branchval,chkfollowup,followupdate,fromdate,todate,salesmanid) %>'; --%>  
	}
	else{
		
	}
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
	{name : 'stdprice', type: 'String'    }, 
	{name : 'sellprice', type: 'String'    }, 
	{name : 'rowno', type: 'String'    },  						
     						
                 ],
                 localdata: data,
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var cellclassname = function (row, column, value, data) {
           
                	if(data.rowcolor=="1"){
                		return "colorClass";
                    }
           
                  };
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxBOQGrid").jqxGrid(
            {
                width: '99%',
                height: 300,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                //pagermode: 'default',
                sortable: true,
                //Add row method
                columns: [ 
{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
    groupable: false, draggable: false, resizable: false,datafield: '',
    columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',cellclassname: cellclassname,
    cellsrenderer: function (row, column, value) {
  	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
    }  
	},
	{ text: 'Doc No', datafield: 'doc_no', width: '8%' },
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
	{text: 'stdprice', datafield: 'stdprice', width: '10%',hidden:true}, 
	{text: 'sellprice', datafield: 'sellprice', width: '10%',hidden:true}, 
	{text: 'rowno', datafield: 'rowno', width: '10%',hidden:true},               ]
            });
      
               $("#overlay, #PleaseWait").hide();
               $('#jqxBOQGrid').on('rowdoubleclick', function (event) { 
              	 var rowindex1=event.args.rowindex;
              			var rows=$('#jqxBOQGrid').jqxGrid('getrows');
              				
              	$('#boqsubGrid').jqxGrid({disabled:false});
               	 
                     var psrno=$('#jqxBOQGrid').jqxGrid('getcellvalue', rowindex1, "psrno");
               	   document.getElementById("txtstdcost").value=$('#jqxBOQGrid').jqxGrid('getcellvalue', rowindex1, "stdprice"); 
               	   document.getElementById("txtsellprice").value=$('#jqxBOQGrid').jqxGrid('getcellvalue', rowindex1, "sellprice");
               	 document.getElementById("rowno").value=$('#jqxBOQGrid').jqxGrid('getcellvalue', rowindex1, "rowno");
               	document.getElementById("psrno").value=$('#jqxBOQGrid').jqxGrid('getcellvalue', rowindex1, "psrno");
               	 $("#detailDiv").load("boqpriceFollowupSubGrid.jsp?psrno="+psrno+"&loadid=1");
                   }); 
               
              
                
        });
    </script>
    <div id="jqxBOQGrid"></div>
