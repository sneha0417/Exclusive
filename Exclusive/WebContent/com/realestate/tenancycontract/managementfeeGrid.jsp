<%@page import="com.realestate.tenancycontract.ClsTenancyContractDAO" %>
<%ClsTenancyContractDAO DAO=new ClsTenancyContractDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<% String docno = request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno");%> 

<script type="text/javascript">
		 var data1;  
        $(document).ready(function () { 
            var temp='<%=docno%>';
             if(temp>0){   
            	  data1='<%=DAO.managementfeeloading(docno)%>';   
           	 }            
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [     						  
     						{name : 'date', type: 'date'},
     						{name : 'amount', type: 'string'} 
                        ],
                         localdata: data1,  
                pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
                }
            };            
            var dataAdapter = new $.jqx.dataAdapter(source); 
            $("#managementfeeGridId").jqxGrid(
            {
                width: '99.5%',
                height: 150,
                source: dataAdapter,
                disabled:true,
                editable: true,
                showaggregates: true,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                columns: [
							{ text: 'Sr.No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '10%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Date', datafield: 'date', columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy'
								,
								  createeditor: function (row, cellvalue, editor, celltext, cellwidth, cellheight) {
						               editor.jqxDateTimeInput({ enableBrowserBoundsDetection: true});  
						           }},	
							{ text: 'Amount', datafield: 'amount',  editable: true},								
						]
            });
            
            if ($("#mode").val() == "A" || $("#mode").val() == "E") {            	
            	  $("#managementfeeGridId").jqxGrid({ disabled: false});           	
            }
            
                   
        });

</script>
<div id="managementfeeGridId"></div>
    