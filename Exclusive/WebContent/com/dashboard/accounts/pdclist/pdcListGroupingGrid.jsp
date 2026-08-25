<%@page import="com.dashboard.accounts.pdclist.ClsPdcList"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%ClsPdcList DAO= new ClsPdcList(); %>
<% String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate");
   String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate");
   String branch = request.getParameter("branchval")==null?"NA":request.getParameter("branchval");
   String criteria = request.getParameter("criteria")==null?"0":request.getParameter("criteria");
   String reporttype = request.getParameter("reporttype")==null?"0":request.getParameter("reporttype");
   String code = request.getParameter("code")==null?"0":request.getParameter("code");
   String distribution = request.getParameter("distribution")==null?"0":request.getParameter("distribution");
   String group = request.getParameter("group")==null?"0":request.getParameter("group");
   String accType = request.getParameter("acctype")==null?"0":request.getParameter("acctype");
   String accId = request.getParameter("accno")==null?"0":request.getParameter("accno");
   String unclrPosted = request.getParameter("unclrposted")==null?"0":request.getParameter("unclrposted");
   String check = request.getParameter("check")==null?"0":request.getParameter("check"); %>

<script type="text/javascript">
		 var data1;  
        $(document).ready(function () { 
        	 var temp='<%=branch%>';
        	 var grouping='<%=group%>';
       	     var distribute='<%=distribution%>';
       	     
     	  	 if(temp!='NA'){   
            	  data1='<%=DAO.pdcListGroupGridLoading(branch, reporttype, fromDate, toDate, criteria, group, code, accType, accId, unclrPosted, check)%>';     
             } 
            
             var rendererstring=function (aggregates){
                	var value=aggregates['sum'];
                	if(typeof(value) == "undefined"){
                		value=0.00;
                	}
                	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
                }
         	
         	var rendererstring1=function (aggregates){
                 var value1=aggregates['sum1'];
                 return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total : " + '</div>';
                }
         	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'descriptions', type: 'string' },
     						{name : 'amount', type: 'number'   }
                        ],
                          localdata: data1,   
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxPdcListGroup").jqxGrid(
            {
            	 width: '98%',
                 height: 510,
                 source: dataAdapter,
                 rowsheight:25,
                 statusbarheight:25,
                 filtermode:'excel',
                 filterable: true,
                 sortable: true,
                 selectionmode: 'singlerow',
                 showaggregates: true,
              	 showstatusbar:true,
                 editable: false,

                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Description',  datafield: 'descriptions',  width: '85%' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
							{ text: 'Amount', datafield: 'amount', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
						]
            });
            
            if(temp=='NA'){ 
         	   $("#jqxPdcListGroup").jqxGrid('addrow', null, {});
          	  }
             
             $("#overlay, #PleaseWait").hide();
             
        });
 </script>
 <div id="jqxPdcListGroup"></div>
    