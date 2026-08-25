<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page
	import="com.controlcentre.settings.termsnconditions.ClsTermsAndConditionsDAO"%>

<%
	String dtype = request.getParameter("dtype") == null
			? "0"
			: request.getParameter("dtype");
	String doc_no = request.getParameter("fhdesc") == null
			? "0"
			: request.getParameter("fhdesc");
	ClsTermsAndConditionsDAO DAO = new ClsTermsAndConditionsDAO();
%>
<script type="text/javascript">
var fotdata; 
	 $(document).ready(function () {
		 
         var temp1='<%=dtype%>';
		 
		 if(temp1!="0"){ 
			 fotdata='<%=DAO.footerDtypeDetails(dtype, session, doc_no)%>';
						
		 }
						var source = {
							datatype : "json",
							datafields : [ {
								name : 'doc_no',
								type : 'int'
							}, {
								name : 'footer',
								type : 'String'
							},{
								name : 'btnsave',
								type : 'String'
							},
							{
								name : 'priono',
								type : 'number'
							},
							{
								name : 'mand',
								type : 'bool'
							},
							 ],
							localdata : fotdata,

							pager : function(pagenum, pagesize, oldpagenum) {
								// callback called when a page or page size is changed.
							}
						};
						var dataAdapter = new $.jqx.dataAdapter(source, {
							loadError : function(xhr, status, error) {
								alert(error);
							}
						});

						$("#jqxFooter")
								.jqxGrid(
										{
											width : '100%',
											height : 375,
											source : dataAdapter,
											/* showfilterrow: true, */
											filterable : true,
											disabled : true,
											editable : true,
											selectionmode : 'singlecell',
											enabletooltips: true,
											/* handlekeyboardnavigation : function(
													event) {
												var rows = $('#jqxFooter')
														.jqxGrid('getrows');
												var rowlength = rows.length;
												var cell = $('#jqxFooter')
														.jqxGrid(
																'getselectedcell');
												if (cell != undefined
														&& cell.datafield == 'footer'
														&& cell.rowindex == rowlength - 1) {
													var key = event.charCode ? event.charCode
															: event.keyCode ? event.keyCode
																	: 0;
													if (key == 9) {
														var commit = $(
																"#jqxFooter")
																.jqxGrid(
																		'addrow',
																		null,
																		{});
														rowlength++;
													}
												}
											}, */

											columns : [
													{
														text : 'Sr. No.',
														sortable : false,
														filterable : false,
														editable : false,
														groupable : false,
														draggable : false,
														resizable : false,
														datafield : '',
														columntype : 'number',
														width : '5%',
														cellsalign : 'center',
														align : 'center',
														cellsrenderer : function(
																row, column,
																value) {
															return "<center><div style='margin:4px;'>"
																	+ (value + 1)
																	+ "</div></center>";
														}
													},
													{
														text : 'Description',
														columntype : 'textbox',
														filtertype : 'input',
														datafield : 'footer',
														width : '72%'
													},
													{
														text : 'Priority',
														columntype : 'textbox',
														filtertype : 'input',
														datafield : 'priono',
														width : '6%'
													},
													{ text: ' Mandatory', datafield: 'mand', width: '10%',columntype: 'checkbox', filterable: false},
													 { text: ' ', datafield: 'btnsave', width: '7%',columntype: 'button',editable:false, filterable: false},
													]
										});

						var footVal = $("#hidrfooter").val();
						var fdtype = $("#txtfdoctype").val();

						if (footVal == 2 || fdtype != '') {
							$("#jqxFooter").jqxGrid('disabled', false);
							footercheck();
							  $("#jqxFooter").jqxGrid('addrow', null, {"btnsave":"Edit"});
						}
						 $('#jqxFooter').on('cellvaluechanged', function (event) {
						     var rowindex1=event.args.rowindex;
						     var rows = $('#jqxFooter').jqxGrid('getrows');
				               var rowlength= rows.length;
				               if(rowindex1 == rowlength - 1)
				               	{  
				            	   $("#jqxFooter").jqxGrid('addrow', null, {"btnsave":"Edit"});
				               	}   
							});
						  $("#jqxFooter").on('cellclick', function (event) 
				            		{
				            		 
				            		    var datafield = event.args.datafield;
				            		    var rowBoundIndex=event.args.rowindex;
				            		 	    
				            		    
				            if(datafield=="btnsave"){
				           	 if($('#jqxFooter').jqxGrid('getcellvalue',rowBoundIndex, "btnsave")=="Delete"){
				           		
				           		
				           		 
				           		 //for 
				           		  var radocno= $('#jqxFooter').jqxGrid('getcellvalue',rowBoundIndex, "doc_no");
				            		 
				           		 
				           		
								    		          $.messager.confirm('Message', 'Do you want to delete?', function(r){
								    		        	  
								    	     		       
													       		        	if(r==false)
													       		        	  {
													       		        		return false; 
													       		        	  }
													       		        	else{
													        				 savegriddata(radocno);
													       		        	   }
								    		                      });
				           	                      }
												           	  
												             }
				            });
				   		          
				         }); 
				        
				        
	 function savegriddata(radocno)
   {
   	var type="footer";
   	var x=new XMLHttpRequest();
   	x.onreadystatechange=function(){
   	if (x.readyState==4 && x.status==200)
   		{
   		
        			
   			var items=x.responseText;
   			
   			
   			 $.messager.alert('Message', '  Record successfully deleted ', function(r){
   		 		 
   		 		 
				     
			     });
   			 
   			 
   			 var fdtype = $("#txtfdoctype").val();
			 var fhdesc = $("#headerid").val();
			 
            $("#footerGridDiv").load("footerGrid.jsp?dtype="+fdtype+"&fhdesc="+fhdesc);
   			
   			}
   		
   	}
   		
   x.open("GET","deletedate.jsp?radocno="+radocno+"&type="+type,true);
   
   x.send();
   		
   }
</script>
<div id="jqxFooter"></div>