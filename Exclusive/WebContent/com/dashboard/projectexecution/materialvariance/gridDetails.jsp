<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<% String contextPath=request.getContextPath();%>
  <%@page import="com.dashboard.projectexecution.materialvariance.ClsMaterialVarianceDAO"%>
<%
ClsMaterialVarianceDAO sd=new ClsMaterialVarianceDAO();
%>
<%

String trno=request.getParameter("trno")==null?"0":request.getParameter("trno").trim();
//String aid = request.getParameter("aid")==null?"0":request.getParameter("aid");
int loadid =request.getParameter("loadid")==null?0:Integer.parseInt(request.getParameter("loadid").trim());
%>

<style type="text/css">
    .orangeClass
    {
        background-color: #FDEBD0;
    }
    
    .yellowClass
    {
        background-color: #FFFFD1;
    }
    
    .greenClass
    {
        background-color: #D1F2EB;
    }
     .greyClass
    {
        background-color: #EAEDED;
    }         
       .blueClass
    {
        background-color: #E8DAEF;
    }           
</style>

<script type="text/javascript">
var matdata;
$(document).ready(function () {
  
   var trno='<%=trno%>';
   var loadid=parseInt('<%=loadid%>');
 if(loadid==2){
	  
	   matdata='<%=sd.materialGridLoad(session,trno)%>';
   }
	 
 
 var rendererstring2=function (aggregates){
  	var value=aggregates['sum2'];
  	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "  Total" + '</div>';
  }    



	  var rendererstring1=function (aggregates){
    	var value=aggregates['sum1'];
    	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Net Total" + '</div>';
    }
	  
	  var cellclassname = function (row, column, value, data) {
    		/* if (data.qty==0) {
    			document.getElementById("errormsg").innetText="Quantity Should not Be Zero";
                return "redClass";
            }
    		else{
    			//document.getElementById("errormsg").innetText="";
    		} */
    		};
 
var rendererstring=function (aggregates){
	var value=aggregates['sum'];
	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
}
            	 
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'desc1', type: 'string'  },
							{name : 'product', type: 'string' },
     						{name : 'productid', type: 'string' },
     						{name : 'activity', type: 'string' },
     						{name : 'activityid', type: 'string' },
     						{name : 'productname', type: 'string'},
     						{name : 'unit', type: 'string'  },
     						{name : 'qty', type: 'number'  },
     						{name : 'netotal', type: 'number'  },
							
     						{name : 'totval', type: 'string' },
     						{name : 'difval', type: 'string' },
     						{name : 'isqty', type: 'string' },
     						{name : 'difqty', type: 'string'},
     						
     						{name : 'invoiced', type: 'bool'  },
                    		{name : 'proname', type: 'string'    },
                    		{name : 'prodoc', type: 'number'    },
     						{name : 'unitdocno', type: 'number'    },
     						{name : 'psrno', type: 'number'    },
     						{name : 'proid', type: 'number'    },
     						{name : 'specid', type: 'number'    },
     						{name : 'rowno', type: 'number'    },
     						{name : 'brhid', type: 'number'    },
     						{name : 'locid', type: 'number'    },
     						{name : 'brandname', type: 'string'    },
     						{name : 'remqty', type: 'string'    },
     						
                        ],
                        
                        
                       
                         localdata: matdata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            		
            };
            	
            		
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#GridData").jqxGrid(
            {
                width: '99%',
                height: 520,
                source: dataAdapter,
                showaggregates:true,
                showstatusbar:true,
                editable: true,
              
                statusbarheight: 20,
                selectionmode: 'singlerow',
                pagermode: 'default',
    
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',cellclassname: cellclassname,
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Activty', datafield: 'activity', width: '10%',editable:false },
							{text: 'activityid', datafield: 'activityid', width: '10%',cellclassname: cellclassname,hidden:true},
							{ text: 'Description', datafield: 'desc1', width: '18%',editable:false },
							{ text: 'Product', datafield: 'productid',columntype: 'custom', width: '7%',cellclassname: cellclassname,editable:false},  
  					
{ text: 'Product Name', datafield: 'productname', width: '24%'  ,cellclassname: cellclassname ,editable:false},
							
							{ text: 'Unit', datafield: 'unit', width: '7%',editable:false,cellclassname: cellclassname },	
						
							
							{ text: 'Estimated Value', datafield: 'netotal', width: '9%',editable:false,cellsalign: 'right', align: 'right',cellclassname: cellclassname, cellsformat: 'd2',editable:false },
							{ text: 'Total Issue Value', datafield: 'totval',editable:false, width: '9%',cellsalign: 'right', align: 'right',cellclassname: cellclassname, cellsformat: 'd2' },
							{ text: 'Diff value', datafield: 'difval', width: '9%',cellclassname: cellclassname,cellsalign: 'right', align: 'right', cellsformat: 'd2' },
							{ text: 'Estimated Quantity', datafield: 'qty', width: '9%',cellclassname: cellclassname,cellsalign: 'right', align: 'right', cellsformat: 'd2' },
							{ text: 'Issue Quantity', datafield: 'isqty', width: '8%',editable:false, cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname },
							{ text: 'Diff Quantity', datafield: 'difqty', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right',editable:false,cellclassname: cellclassname },
							
							{text: 'pid', datafield: 'proid', width: '10%',cellclassname: cellclassname,hidden:true }, 
  							{text: 'pname', datafield: 'proname', width: '10%',cellclassname: cellclassname,hidden:true },
  							{text: 'prodoc', datafield: 'prodoc', width: '10%',cellclassname: cellclassname,hidden:true},
							{text: 'unitdocno', datafield: 'unitdocno', width: '10%',cellclassname: cellclassname,hidden:true },
							{text: 'psrno', datafield: 'psrno', width: '10%',cellclassname: cellclassname,hidden:true},
							{text: 'specid', datafield: 'specid', width: '10%',cellclassname: cellclassname,hidden:true},
							{text: 'rowno', datafield: 'rowno', width: '10%',cellclassname: cellclassname,hidden:true},
							{text: 'brhid', datafield: 'brhid', width: '10%',cellclassname: cellclassname,hidden:true},
							{text: 'locid', datafield: 'locid', width: '10%',cellclassname: cellclassname,hidden:true},
							{text: 'brandname', datafield: 'brandname', width: '10%',cellclassname: cellclassname,hidden:true},
							/* { text: 'Invoiced', datafield: 'invoiced', columntype: 'checkbox', editable: true, checked: true, width: '5%',cellsalign: 'center', align: 'center' }, */
						]
            });
            
            

            $("#overlay, #PleaseWait").hide();      
         
        });
</script>

   <div id="GridData"></div>
   
<input type="hidden" id="rowindex">
<input type="hidden" id="datas">
<input type="hidden" id="datas1">
