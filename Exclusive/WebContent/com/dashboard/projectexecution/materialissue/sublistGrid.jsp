<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.projectexecution.materialissue.ClsMaterialIssueDAO"%>
<% ClsMaterialIssueDAO searchDAO = new ClsMaterialIssueDAO(); %> 


<% 

String docno=request.getParameter("docno")==null?"0":request.getParameter("docno").trim();

 
String barchval=request.getParameter("barchvals")==null?"0":request.getParameter("barchvals").trim();
String locid=request.getParameter("locid")==null?"0":request.getParameter("locid").trim();

String tr_no=request.getParameter("tr_no")==null?"0":request.getParameter("tr_no").trim();





%>

 

<script type="text/javascript">
var prddata;
$(document).ready(function () {
 
 
var temp='<%=docno%>';

var temps='<%=tr_no%>';
 

 if(temp>0 || temps>0)
{
 prddata='<%=searchDAO.sublistGridReload(barchval,docno,locid,tr_no)%>';   
 
 prddataexcel='<%=searchDAO.sublistGridExcel(barchval,docno,locid,tr_no)%>';
	


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
                        	 
                        	{name : 'erowno', type: 'string' }, 
                        	
                        	
                             
                         
							{name : 'psrno', type: 'string' }, 
                             
     						{name : 'productid', type: 'string' }, 
     						{name : 'productname', type: 'string'},
     						{name : 'unit', type: 'string'  },
     					 
     						{name : 'qty', type: 'number'   },
     						 
     						
     					 
     						
     					    {name : 'brandname', type: 'string'  },
     					    {name : 'stockqty', type: 'number'  },
     					   {name : 'issueqty', type: 'number'  },
     					   
     					   
     					  {name : 'eqty', type: 'number'  },
     					 {name : 'eissueqty', type: 'number'  },
     					 {name : 'eresqty', type: 'number'  },
     					 {name : 'ebalqty', type: 'number'  },
     					   
     					   
     					      
     					  
     					     	
     					   
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
                              columntype: 'number', width: '3%',cellsalign: 'center', align: 'center',cellclassname: cellclassname,
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							
					 		
							{ text: 'rowno', datafield: 'rowno' ,cellclassname: cellclassname,hidden:true  },
							{ text: 'Product', datafield: 'productid' ,cellclassname: cellclassname, editable: false, width: '10%'   },
						  	{ text: 'Product Name', datafield: 'productname'  ,cellclassname: cellclassname , editable: false   },	
							{text: 'Brand Name', datafield: 'brandname', width: '8%' , editable:false,cellclassname: cellclassname, editable: false  },
							{ text: 'Unit', datafield: 'unit', width: '4%',editable:false,cellclassname: cellclassname , editable: false},	
							{ text: 'Qty', datafield: 'eqty', width: '5%',cellclassname: cellclassname, editable: false ,  cellsalign: 'left', align:'left',cellclassname: cellclassname,cellsformat:'d2'},
							{ text: 'Issued ', datafield: 'eissueqty', width: '5%',cellclassname: cellclassname,editable:false ,  cellsalign: 'left', align:'left',cellclassname: cellclassname,cellsformat:'d2'},
							{ text: 'Balance ', datafield: 'ebalqty', width: '5%',cellclassname: cellclassname,editable:false ,  cellsalign: 'left', align:'left',cellclassname: cellclassname,cellsformat:'d2'},
							{ text: 'Reserve ', datafield: 'eresqty', width: '5%',cellclassname: cellclassname,editable:false ,  cellsalign: 'left', align:'left',cellclassname: cellclassname,cellsformat:'d2'},
							{ text: 'Stock Qty', datafield: 'stockqty', width: '5%', editable: false,cellclassname: cellclassname ,  cellsalign: 'left', align:'left',cellclassname: cellclassname,cellsformat:'d2'},
							{ text: 'Mat.Req.', datafield: 'qty', width: '5%', editable: false,cellclassname: cellclassname ,  cellsalign: 'left', align:'left',cellclassname: cellclassname,cellsformat:'d2'},
							{ text: 'To Be Issued', datafield: 'issueqty', width: '8%',cellclassname: cellclassname,editable:true ,  cellsalign: 'left', align:'left',cellclassname: cellclassname,cellsformat:'d2'},
							{ text: 'rowno', datafield: 'erowno' ,cellclassname: cellclassname, editable: false ,hidden:true},
							{text: 'psrno', datafield: 'psrno', width: '10%',cellclassname: cellclassname,hidden:true},
						 
							
							
						]
            });
            
            $("#overlay, #PleaseWait").hide(); 
 
 
            
            $("#prdgrid").on('cellvaluechanged', function (event) 
                    {
                 	   
                 	
                    	var datafield = event.args.datafield;
                		
            		    var rowBoundIndex = event.args.rowindex;
            		    
            		    
            		    if(datafield=="issueqty")
            		    	{
            		    	var issueqty=$('#prdgrid').jqxGrid('getcellvalue', rowBoundIndex, "issueqty");
            		    	var stockqty=$('#prdgrid').jqxGrid('getcellvalue', rowBoundIndex, "stockqty");
            		    	var qty=$('#prdgrid').jqxGrid('getcellvalue', rowBoundIndex, "eqty");
            		    	var ebalqty=$('#prdgrid').jqxGrid('getcellvalue', rowBoundIndex, "ebalqty");
            		    	
            		    	if(parseFloat(issueqty)>parseFloat(stockqty))
            		    		{
            		    		
            		    		$.messager.alert('Message', '  Issue Qty Not More than Stock Qty '+stockqty);
            		    		
            		    		
            		    		if(parseFloat(stockqty)>(parseFloat(qty)-parseFloat(ebalqty)))
            		    			{
            		    			stockqty=parseFloat(qty)-parseFloat(ebalqty);
            		    			}
   						    
            		    		
            		    		$('#prdgrid').jqxGrid('setcellvalue', rowBoundIndex, "issueqty",stockqty);
            		    		
            		    		
            		    		
            		    		}
            		    	
            		    	
            		    
            		    	
            		     
        		    			
    		    			 
            		    	}
            		    
            		    
                    });
            
});

            
            
 
 
       
</script>
<div id="prdgrid"></div>
 
 
