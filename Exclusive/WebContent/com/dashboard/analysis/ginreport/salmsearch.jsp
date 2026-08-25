 <%@page import="com.dashboard.analysis.ginreport.ClsginreportDAO"%>
     <%
     ClsginreportDAO cmd= new ClsginreportDAO();
     %>
      

<script type="text/javascript">
  
		var amcdata='<%=cmd.salmdetails() %>';
		$(document).ready(function () { 	
           
            var source =
            {
                datatype: "json",
                datafields: [
                           
                            {name : 'docno', type: 'string'  },
                            {name : 'salm', type: 'string'  },
                            
                        ],
                 	localdata: amcdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#salmsearch").jqxGrid(
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
                              { text: 'Doc No', datafield: 'docno', width: '25%',hidden:true},
                              { text: 'Salesman', datafield: 'salm', width: '100%'},
                             
                             
						]
            });
            
          $('#salmsearch').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                document.getElementById("salid").value=$('#salmsearch').jqxGrid('getcellvalue', rowindex2, "docno");
                document.getElementById("salname").value=$('#salmsearch').jqxGrid('getcellvalue', rowindex2, "salm");
           //     document.getElementById("cldocno").value=$('#salmsearch').jqxGrid('getcellvalue', rowindex2, "cldocno");
               
                
                $('#salmwindow').jqxWindow('close');
            }); 
        });
    </script>
    <div id="salmsearch"></div>