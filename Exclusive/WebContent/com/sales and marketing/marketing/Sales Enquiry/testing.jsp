
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
<%@page import="com.sales.marketing.salesenquiry.ClsSalesEnquiryDAO"%>
<%
	ClsSalesEnquiryDAO DAO = new ClsSalesEnquiryDAO();
%>

<%
	String docno = request.getParameter("docno") == null
			? "0"
			: request.getParameter("docno").trim();
%>
<script type="text/javascript">
var descdata1;
var prodata= '<%=DAO.searcharrayProduct()%>';
var temp='<%=docno%>';

if(temp>0)
{
 
	 descdata1='<%=DAO.prdGridLoad(session, docno)%>';

	}

	else

	{
		descdata1;

	}

	$(document)
			.ready(
					function() {

						// prepare the data
						var source = {
							datatype : "json",
							datafields : [

							{
								name : 'productid',
								type : 'string'
							}, {
								name : 'productname',
								type : 'string'
							}, {
								name : 'unit',
								type : 'String'
							}, {
								name : 'size',
								type : 'String'
							}, {
								name : 'qty',
								type : 'int'
							}, {
								name : 'unitdocno',
								type : 'number'
							}, {
								name : 'psrno',
								type : 'number'
							},

							],

							localdata : descdata1,

							pager : function(pagenum, pagesize, oldpagenum) {
								// callback called when a page or page size is changed.
							}

						};

						var prodSource = {
							datatype : "json",
							datafields : [ {
								name : 'part_no',
								type : 'string'
							}, {
								name : 'doc_no',
								type : 'string'
							}, {
								name : 'productname',
								type : 'string'
							} ],
							localdata : prodata
						};
						var prodAdapter = new $.jqx.dataAdapter(prodSource, {
							autoBind : true
						});

						var dataAdapter = new $.jqx.dataAdapter(source, {
							loadError : function(xhr, status, error) {
								alert(error);
							}

						});

						var list = prodata.split(",");

						$("#prodetGrid")
								.jqxGrid(
										{
											width : '99.5%',
											height : 297,
											source : dataAdapter,
											editable : true,
											disabled : true,
											statusbarheight : 21,
											selectionmode : 'singlecell',
											pagermode : 'default',

											//Add row method
											//Add row method
											handlekeyboardnavigation : function(
													event) {
												var rows = $('#prodetGrid')
														.jqxGrid('getrows');
												var rowlength = rows.length;
												var cell = $('#prodetGrid')
														.jqxGrid(
																'getselectedcell');
												if (cell != undefined
														&& cell.datafield == 'qty'
														&& cell.rowindex == rowlength - 1) {
													var key = event.charCode ? event.charCode
															: event.keyCode ? event.keyCode
																	: 0;
													if (key == 9) {
														var commit = $(
																"#prodetGrid")
																.jqxGrid(
																		'addrow',
																		null,
																		{});
														rowlength++;
													}
												}
											},

											columns : [

													{
														text : 'SL#',
														sortable : false,
														filterable : false,
														editable : false,
														groupable : false,
														draggable : false,
														resizable : false,
														datafield : 'sl',
														columntype : 'number',
														width : '4%',
														cellsrenderer : function(
																row, column,
																value) {
															return "<center><div style='margin:4px;'>"
																	+ (value + 1)
																	+ "</div></center>";
														}
													},

													/* {
													    text: 'Product', datafield: 'productid', width: '40%', columntype: 'combobox',
													    createeditor: function (row, column, editor) {
													        // assign a new data source to the combobox.
													         
													        editor.jqxComboBox({ autoDropDownHeight: true, source: list, promptText: "Please Choose:" });
													    },
													    // update the editor's value before saving it.
													    cellvaluechanging: function (row, column, columntype, oldvalue, newvalue) {
													        // return the old value, if the new value is empty.
													        alert("inside cellvalue");
													        if (newvalue == "") return oldvalue;
													    }
													},  */
													{
														text : 'Product',
														datafield : 'productid',
														displayfield : 'part_no',
														width : '25%',
														columntype : 'combobox',
														createeditor : function(
																row, value,
																editor) {
															editor
																	.jqxComboBox({
																		autoDropDownHeight : true,
																		source : prodAdapter,
																		displayMember : 'part_no',
																		valueMember : 'doc_no',
																		promptText : "Please Choose:"
																	});
														}/*  ,
																												cellvaluechanging : function(
																														row, column,
																														columntype,
																														oldvalue,
																														newvalue) {
																													// return the old value, if the new value is empty.
																													
																													if (newvalue == "")
																														return oldvalue;
																												}  */
													},
													{
														text : 'Product Name',
														datafield : 'productname',
														width : '35%'
													},

													{
														text : 'Unit',
														datafield : 'unit',
														width : '10%'
													},
													{
														text : 'Size',
														datafield : 'size',
														width : '13%',
														cellsalign : 'left',
														align : 'left'
													},
													{
														text : 'Quantity',
														datafield : 'qty',
														width : '13%',
														cellsalign : 'right',
														align : 'right',
														align : 'right',
														cellsformat : 'd2'
													},
													{
														text : 'unitdocno',
														datafield : 'unitdocno',
														width : '10%',
														hidden : true
													}, {
														text : 'psrno',
														datafield : 'psrno',
														width : '10%',
														hidden : true
													},

											]
										});
						if (temp == 0) {
							$("#prodetGrid").jqxGrid('addrow', null, {});

						}

						if (($('#mode').val() == 'A')
								|| ($('#mode').val() == 'E')) {
							$("#prodetGrid").jqxGrid({
								disabled : false
							});
						}

						 /* $("#prodetGrid").on('cellvaluechanged', function (event){
					          	var datafield = event.args.datafield;
					            var rowBoundIndex = event.args.rowindex;
					            
					          }); */
					          
						
						
						 $("#prodetGrid").on('cellselect', function (event) {
							
							 var rowBoundIndex = event.args.rowindex;
							 alert("==rowBoundIndex=111=="+rowBoundIndex);
						});
						
	
						 $("#prodetGrid").on('select', function(event) {
							
							if (event.args) {
								var item = event.args.item;
								if (item) {
									var pdocno = item.value;
								

								}
							}
						}); 

						/*  $('#prodetGrid').on('celldoubleclick', function (event) {
						 	var columnindex1=event.args.columnindex;
						
						   	   if(columnindex1 == 1)
						   		  { 
						            
						   	 var rowindextemp = event.args.rowindex;
						   	    document.getElementById("rowindex").value = rowindextemp;  
						   	  $('#prodetGrid').jqxGrid('clearselection');
						   	 productSearchContent('productSearch.jsp');
						   	
						   		   } 
						   	
						       }); */

					});
</script>
<div id="prodetGrid"></div>
<input type="hidden" id="rowindex">
