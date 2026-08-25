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
		var data;  
        $(document).ready(function () { 
        	 var temp='<%=branch%>';
        	 var grouping='<%=group%>';
        	 var distribute='<%=distribution%>';
             
     	  	 if(temp!='NA'){   
            	  data='<%=DAO.pdcListGridLoading(branch, reporttype, fromDate, toDate, criteria, code, accType, accId, unclrPosted, check)%>';     
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
							{name : 'branchname', type: 'string' },
							{name : 'dtype', type: 'string'  },
							{name : 'doc_no', type: 'int'  },
							{name : 'bankacno', type: 'int'  },
     						{name : 'bank', type: 'string' }, 
     						{name : 'bankname', type: 'string' },
     						{name : 'atype', type: 'string'   },
     						{name : 'acno', type: 'int'  },
     						{name : 'account', type: 'int'  },
     						{name : 'accountname', type: 'string'   },
     						{name : 'chqno', type: 'int'   },
     						{name : 'chqdt', type: 'date' },
     						{name : 'amount', type: 'number'   },
     						{name : 'brhid', type: 'int'  },
     						{name : 'description', type: 'string'   },
                        ],
                          localdata: data,   
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxPdcList").jqxGrid(
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
				 columnsresize: true,
				 
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Branch',  datafield: 'branchname',  width: '10%' },
							{ text: 'Type', datafield: 'dtype', cellsalign: 'center', align: 'center', width: '4%' },
							{ text: 'Doc No', datafield: 'doc_no', cellsalign: 'center', align: 'center', width: '5%' },
							{ text: 'Bank Doc No', hidden: true, datafield: 'bankacno', width: '10%' },	
							{ text: 'Bank No.',  datafield: 'bank',  width: '5%' },
							{ text: 'Bank Name',  datafield: 'bankname',  width: '15%' },
							{ text: 'A/C Type', datafield: 'atype', width: '5%' },	
							{ text: 'A/C No', hidden: true, datafield: 'acno', width: '10%' },	
							{ text: 'A/C No', datafield: 'account', width: '5%' },
							{ text: 'Account Name', datafield: 'accountname', width: '16%' },
							{ text: 'Cheque No', datafield: 'chqno', width: '10%' },
							{ text: 'Cheque Date', datafield: 'chqdt', cellsformat: 'dd.MM.yyyy' , width: '10%',aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
							{ text: 'Amount', datafield: 'amount', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Description', datafield: 'description', width: '15%' },
							{ text: 'Branch Id',  hidden: true, datafield: 'brhid', width: '10%' },
							
						]
            });
            
            if(temp=='NA'){ 
         	   $("#jqxPdcList").jqxGrid('addrow', null, {});
          	  }
             
             $("#overlay, #PleaseWait").hide();
             
        });
 </script>
 <div id="jqxPdcList"></div>
    