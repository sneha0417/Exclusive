<%@page import="com.dashboard.project.amcrenewalfollowup.amcRenewalFollowupDAO"%>
<%
amcRenewalFollowupDAO DAO=new amcRenewalFollowupDAO();
%>       

<% String doc =request.getParameter("doc")==null?"0":request.getParameter("doc").toString();%>
 <% String cldoc =request.getParameter("cldoc")==null?"0":request.getParameter("cldoc").toString();%>

<script type="text/javascript">
  
		var amcdata='<%=DAO.amcdetails(doc,cldoc) %>';
		$(document).ready(function () { 	
           
            var source =
            {
                datatype: "json",
                datafields: [
                           
                            {name : 'docno', type: 'string'  },
                            {name : 'refno', type: 'string'  },
                            {name : 'sdate', type: 'date'  },
                            {name : 'edate', type: 'date'  }
                        ],
                 	localdata: amcdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#amcsearch").jqxGrid(
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
                              { text: 'AMC No', datafield: 'docno', width: '25%'},
                              { text: 'Ref No', datafield: 'refno', width: '25%'},
                              { text: 'Start Date', datafield: 'sdate', width: '25%',cellsformat:'dd.MM.yyyy'},
                              { text: 'End Date', datafield: 'edate', width: '25%',cellsformat:'dd.MM.yyyy'},
                             
						]
            });
            
          $('#amcsearch').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                document.getElementById("amcno").value=$('#amcsearch').jqxGrid('getcellvalue', rowindex2, "docno");
           //     document.getElementById("cldocno").value=$('#amcsearch').jqxGrid('getcellvalue', rowindex2, "cldocno");
               
                
                $('#amcwindow').jqxWindow('close');
            }); 
        });
    </script>
    <div id="amcsearch"></div>