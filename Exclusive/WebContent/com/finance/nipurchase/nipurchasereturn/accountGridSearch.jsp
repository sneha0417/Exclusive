<% String type1 = request.getParameter("atype").toString(); %> 
<%@page import="com.finance.nipurchase.nipurchase.ClsnipurchaseDAO" %>



	
<%

ClsnipurchaseDAO viewDAO=new ClsnipurchaseDAO();
%>
<script type="text/javascript">
   
        var typedata= '<%=viewDAO.accountGridsearch(type1) %>';
        $(document).ready(function () { 	
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int'   },
     						{name : 'account', type: 'string'   },
     						{name : 'description', type: 'string'   },
     						{name : 'grtype', type: 'int'  },
     						
                        ],
                		 localdata: typedata, 
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxaccmainSearch").jqxGrid(
            {
            	 width: '100%',
                 height: 378,
                source: dataAdapter,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                
                columns: [
                            { text: 'Doc No',  datafield: 'doc_no', width: '5%',hidden : true }, 
							{ text: 'Account', datafield: 'account', width: '20%' },
							{ text: 'Account Name', datafield: 'description', width: '80%' },
							{ text: 'grtype', datafield: 'grtype', width: '8%',hidden : true }
					
						]
            });
            $('#jqxaccmainSearch').on('rowclick', function (event) {
            	var rowindex1 =$('#rowindex1').val();
            	  var rowindex2 = event.args.rowindex; 
               /*   var rows = $('#nidescdetailsGrid').jqxGrid('getrows');
                var rowlength= rows.length;
                if(rowindex1 == rowlength - 1)
                	{
                $("#nidescdetailsGrid").jqxGrid('addrow', null, {});
                	} */
                	 $('#nidescdetailsGrid').jqxGrid('clearselection');
                	// $('#nidescdetailsGrid').jqxGrid('selectcell', rowindex1, 'account');
                	// $('#nidescdetailsGrid').jqxGrid('setcellvalue', rowindex1, "account" ,$('#jqxaccmainSearch').jqxGrid('getcellvalue', rowindex2, "account"));
     
            }); 
            $('#jqxaccmainSearch').on('rowdoubleclick', function (event) {
            	var rowindex1 =$('#rowindex1').val();
                var rowindex2 = event.args.rowindex;  
              var rows = $('#nidescdetailsGrid').jqxGrid('getrows');
                var rowlength= rows.length;
                if(rowindex1 == rowlength - 1)
                	{  
                $("#nidescdetailsGrid").jqxGrid('addrow', null, {});
                	} 
                	
                	 $('#nidescdetailsGrid').jqxGrid('selectcell', rowindex1, 'account');
              $('#nidescdetailsGrid').jqxGrid('setcellvalue', rowindex1, "account" ,$('#jqxaccmainSearch').jqxGrid('getcellvalue', rowindex2, "account"));
              $('#nidescdetailsGrid').jqxGrid('setcellvalue', rowindex1, "accname" ,$('#jqxaccmainSearch').jqxGrid('getcellvalue', rowindex2, "description"));
              $('#nidescdetailsGrid').jqxGrid('setcellvalue',rowindex1, "headdoc",$('#jqxaccmainSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
              $('#nidescdetailsGrid').jqxGrid('setcellvalue',rowindex1, "grtype",$('#jqxaccmainSearch').jqxGrid('getcellvalue', rowindex2, "grtype"));

              $('#accounttypeSearchwindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="jqxaccmainSearch"></div>
 