<%@page import="com.cargo.costingforinvoicing.ClsCostingForInvoicingDAO"%>
<%@page import="javax.servlet.http.HttpSession" %>
<% ClsCostingForInvoicingDAO DAO = new ClsCostingForInvoicingDAO();
String rdocno1 = request.getParameter("rdocno1")==null?"0":request.getParameter("rdocno1").trim();
 System.out.println("=====rdocno1==aaaaaaaaaa==="+rdocno1);
%>

<script type="text/javascript">
var expdata;
 
 

$(document).ready(function () {
	
 
// 		 
var tempdocno1='<%=rdocno1%>';
 
if(tempdocno1>0){

  	expdata='<%=DAO.expDataLoad(session,rdocno1)%>'; 
}
else
{
expdata;
}
	
	  var rendererstring1=function (aggregates){
	       	var value=aggregates['sum1'];
	       	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total" + '</div>';
	       }    
	    
	 var rendererstring=function (aggregates){
	 	var value=aggregates['sum'];
	 	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
	 }
	var source =
	{
			datatype: "json",
			datafields: [
			             {name : 'transno', type: 'string'},
			             {name : 'transtype', type: 'string'},
	                      {name : 'date', type: 'date'},
			             {name : 'desc1', type: 'string'},
			             {name : 'acname', type: 'string'},  
			             {name : 'amount', type: 'number'},  
			              
                 ],
                 localdata: expdata,
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

 
            
            
            $("#jqxgridexp").jqxGrid(
            {
                width: '100%',
                height: 200,
                source: dataAdapter,
                editable: false,
                disabled:true,
                showaggregates:true,
                showstatusbar:true,
                
                statusbarheight: 21,
                pagermode: 'default',
               
                columns: [
                          { text: 'DOC NO', datafield: 'transno', width: '10%', editable: false },	
      					  { text: 'DTYPE', datafield: 'transtype', width: '8%', editable: false },	
      					    { text: 'Date', datafield: 'date', width: '8%', editable: false,cellsformat:'dd.MM.yyyy'  },
						  { text: 'Account name', datafield: 'acname', width: '25%',aggregates: ['sum1'],aggregatesrenderer:rendererstring1  },	
						  { text: 'Total', datafield: 'amount', width: '10%',cellsformat: 'd2', align: 'right', cellsalign: 'right' , editable: false,aggregates: ['sum'],aggregatesrenderer:rendererstring},	
						  { text: 'Description', datafield: 'desc1'  },
						 
					 	
		 
			              ]
               
            });
           
            
            if(($('#mode').val()=='A')||($('#mode').val()=='E'))
    		{
    		  $("#jqxgridexp").jqxGrid({ disabled: false}); 
    		}
            
          
});
 
    </script>
    <div id="jqxgridexp"></div>
  <input type="hidden" id="rowindex1"/> 