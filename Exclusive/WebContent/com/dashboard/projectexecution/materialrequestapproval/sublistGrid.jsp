<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.projectexecution.materialrequestapproval.ClsMaterialRequestApprovalDAO"%>
<% ClsMaterialRequestApprovalDAO searchDAO = new ClsMaterialRequestApprovalDAO(); %> 


<% 

String docno=request.getParameter("docno")==null?"0":request.getParameter("docno").trim();

 
String barchval=request.getParameter("barchvals")==null?"0":request.getParameter("barchvals").trim();
String locid=request.getParameter("locid")==null?"0":request.getParameter("locid").trim();

 


%>

 

<script type="text/javascript">
var prddata;
$(document).ready(function () {
 
 
var temp='<%=docno%>';
 

 if(temp>0)
{
 prddata='<%=searchDAO.sublistGridReload(barchval,docno,locid)%>';   
	


} 
 
else
 
{   
	prddata;

 } 
             

 
 
	  var cellclassname = function (row, column, value, data) {
   
  		
  		 var ss= $('#prdgrid').jqxGrid('getcellvalue', row, "issueqty");
         if(parseInt(ss)<=0)
 		{
 		
 		return "redClass";
 	
 		}
     
         

  		};
 
 
            var source =
            {
                datatype: "json",
                
                datafields: [
                             
                        	{name : 'rowno', type: 'string' }, 
							{name : 'psrno', type: 'string' }, 
     						{name : 'productid', type: 'string' }, 
     						{name : 'productname', type: 'string'},
     						{name : 'unit', type: 'string'  },
     						{name : 'qty', type: 'number'   },
     					    {name : 'brandname', type: 'string'  },
     					    {name : 'stockqty', type: 'number'  },
     					 	{name : 'issueqty', type: 'number'  },
     					   
                        ],
                        
                         localdata: prddata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            		
            		
         		 
            		
            		
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#prdgrid").jqxGrid(
            {
                width: '99.5%',
                height: 300,
                source: dataAdapter,
                columnsresize: true,
                editable: true,
                
               
                selectionmode: 'checkbox',
 
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',cellclassname: cellclassname,
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'rowno', datafield: 'rowno' ,cellclassname: cellclassname,hidden:true, editable: false},
							{ text: 'Product', datafield: 'productid' ,cellclassname: cellclassname, editable: false },
						    { text: 'Product Name', datafield: 'productname'  ,cellclassname: cellclassname , editable: false },	
							{text: 'Brand Name', datafield: 'brandname', width: '10%' , editable:false,cellclassname: cellclassname, editable: false  },
							{ text: 'Unit', datafield: 'unit', width: '6%',editable:false,cellclassname: cellclassname , editable: false},	
							{ text: 'Qty', datafield: 'qty', width: '10%',cellclassname: cellclassname, editable: false ,  cellsalign: 'left', align:'left',cellclassname: cellclassname,cellsformat:'d2'},
							{ text: 'Issue Qty', datafield: 'issueqty', width: '10%',cellclassname: cellclassname,editable:true ,  cellsalign: 'left', align:'left',cellclassname: cellclassname,cellsformat:'d2',hidden:true},
							{ text: 'Stock Qty', datafield: 'stockqty', width: '10%', editable: false,cellclassname: cellclassname ,  cellsalign: 'left', align:'left',cellclassname: cellclassname,cellsformat:'d2',hidden:true},
							{text: 'psrno', datafield: 'psrno', width: '10%',cellclassname: cellclassname,hidden:true},
						]
            });
            
            $("#overlay, #PleaseWait").hide(); 
 
 
  
            
});

            
            
 
 
       
</script>
<div id="prdgrid"></div>
 
 
