
  <%@page import="com.realestate.tenancycontract.ClsTenancyContractDAO" %>
<%ClsTenancyContractDAO DAO=new ClsTenancyContractDAO();
 
 
String rowno=request.getParameter("rowno")==null?"0":request.getParameter("rowno").trim();

%>
 
 <script type="text/javascript">
 var rowno='<%=rowno%>';
 var datasal= '<%=DAO.SalesgentSearch()%>';
   // alert(data);
        $(document).ready(function () { 	
            
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'String'  },    
     						{name : 'sal_name', type: 'String'  }
                          	],
                 localdata: datasal,
          
				
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxSalagentsearch").jqxGrid(
            {
                width: '100%',
                height: 325,
                source: dataAdapter,
                columnsresize: true,
                filterable:true,
                showfilterrow:true,
                altRows: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                		
     			columns: [
					{ text: 'DocNo', datafield: 'doc_no',   columntype: 'textbox', filtertype: 'input',width: '20%',hidden:true},
					{ text: 'Name', datafield: 'sal_name',  columntype: 'textbox', filtertype: 'input'  }
					]
            });
    
           
      
            
           $('#jqxSalagentsearch').on('rowdoubleclick', function (event) 
            		{ 
              
                var rowindex1=event.args.rowindex;
            
                $('#agentGridId').jqxGrid('setcellvalue', rowno, "agent",$('#jqxSalagentsearch').jqxGrid('getcellvalue', rowindex1, "sal_name"));
                $('#agentGridId').jqxGrid('setcellvalue', rowno, "salid",$('#jqxSalagentsearch').jqxGrid('getcellvalue', rowindex1, "doc_no"));
              
                var rows = $('#agentGridId').jqxGrid('getrows');
                var rowlength= rows.length;
                var rowindex1=event.args.rowindex;
                
                if(rowno == rowlength - 1)
                	{  
                $("#agentGridId").jqxGrid('addrow', null, {});
                	} 
     	       
                $('#salespersonwindow').jqxWindow('close');
               
            
            		 }); 
      
        });
    </script>
    <div id="jqxSalagentsearch"></div>