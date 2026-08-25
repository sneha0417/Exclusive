   <%@page import="com.dashboard.marketing.enquirylist.ClsEnqiryListDAO"%>
     <%
     ClsEnqiryListDAO cmd= new ClsEnqiryListDAO();
     %>

<script type="text/javascript">
  
		var data='<%=cmd.sourcedetails() %>';
		$(document).ready(function () { 	
           
            var source =
            {
                datatype: "json",
                datafields: [
                           
                            {name : 'docno', type: 'string'  },
                            {name : 'source', type: 'string'  },
                            
                        ],
                 	localdata: data,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#sourcesearch").jqxGrid(
            {
                width: '100%',
                height: 357,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
                              { text: 'Source ID', datafield: 'docno', width: '25%',hidden:true},
                              { text: 'Source', datafield: 'source', width: '100%'},
                            
                             
						]
            });
            
          $('#sourcesearch').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                document.getElementById("srcno").value=$('#sourcesearch').jqxGrid('getcellvalue', rowindex2, "docno");
                document.getElementById("srcname").value=$('#sourcesearch').jqxGrid('getcellvalue', rowindex2, "source");
           //     document.getElementById("cldocno").value=$('#sourcesearch').jqxGrid('getcellvalue', rowindex2, "cldocno");
               
                
                $('#sourcewindow').jqxWindow('close');
            }); 
        });
    </script>
    <div id="sourcesearch"></div>