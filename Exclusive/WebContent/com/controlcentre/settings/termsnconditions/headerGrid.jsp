<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="com.controlcentre.settings.termsnconditions.ClsTermsAndConditionsDAO"%>

<%
	String dtype = request.getParameter("dtype") == null
			? "0"
			: request.getParameter("dtype");
	ClsTermsAndConditionsDAO DAO = new ClsTermsAndConditionsDAO();
%>
<script type="text/javascript">
var headrdata; 
	 $(document).ready(function () {
		 
		 var temp='<%=dtype%>';
		 
		 if(temp!="0"){
			 headrdata='<%=DAO.headerDtypeDetails(dtype, session)%>';
						
		 }

						var source = {
							datatype : "json",
							datafields : [ {
								name : 'header',
								type : 'String'
							},
							
							{
								name : 'voc_no',
								type : 'String'
							},
							{
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
							localdata : headrdata,

							pager : function(pagenum, pagesize, oldpagenum) {
								// callback called when a page or page size is changed.
							}
						};
						var dataAdapter = new $.jqx.dataAdapter(source, {
							loadError : function(xhr, status, error) {
								alert(error);
							}
						});

						$("#jqxHeader")
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
												var rows = $('#jqxHeader')
														.jqxGrid('getrows');
												var rowlength = rows.length;
												var cell = $('#jqxHeader')
														.jqxGrid(
																'getselectedcell');
												if (cell != undefined
														&& cell.datafield == 'header'
														&& cell.rowindex == rowlength - 1) {
													var key = event.charCode ? event.charCode
															: event.keyCode ? event.keyCode
																	: 0;

													if (key == 9) {
														var commit = $(
																"#jqxHeader")
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
													}, {
														text : 'Description',
														columntype : 'textbox',
														filtertype : 'input',
														datafield : 'header',
														width : '72%'
													}, 
													 {
													text : 'docno',
													columntype : 'textbox',
													filtertype : 'input',
													datafield : 'voc_no',
													width : '10%',hidden:true
												}, 
												{
													text : 'Priority',
													columntype : 'textbox',
													filtertype : 'input',
													datafield : 'priono',
													width : '6%'
												}, 
												{text: 'Mandatory',datafield:'mand',width:'10%', columntype:'checkbox', checked:false},
												 { text: ' ', datafield: 'btnsave', width: '7%',columntype: 'button',editable:false, filterable: false},
													]
										});

						var headValue = $("#rheader").val();
						var hdtype = $("#txthdoctype").val();
						if (headValue == 1 || hdtype != '') {
							$("#jqxHeader").jqxGrid('disabled', false);
							headercheck();
							  $("#jqxHeader").jqxGrid('addrow', null, {"btnsave":"Edit"});
						}

						   $('#jqxHeader').on('cellvaluechanged', function (event) {
						     var rowindex1=event.args.rowindex;
						     var rows = $('#jqxHeader').jqxGrid('getrows');
				               var rowlength= rows.length;
				               if(rowindex1 == rowlength - 1)
				               	{  
				            	  
				               $("#jqxHeader").jqxGrid('addrow', null, {"btnsave":"Edit"});
				               
				            
				         
				               	}    
						     
						     
						 }); 
						   
						   
						   $("#jqxHeader").on('cellclick', function (event) 
				            		{
				            		 
				            		    var datafield = event.args.datafield;
				            		    var rowBoundIndex=event.args.rowindex;
				            		 	    
				            		    
				            if(datafield=="btnsave"){
				           	 if($('#jqxHeader').jqxGrid('getcellvalue',rowBoundIndex, "btnsave")=="Delete"){
				           		
				           		
				           		 
				           		 //for 
				           		  var radocno= $('#jqxHeader').jqxGrid('getcellvalue',rowBoundIndex, "voc_no");
				            		 
				           		 
				           		
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
     	var type="header";
      
     	var x=new XMLHttpRequest();
     	x.onreadystatechange=function(){
     	if (x.readyState==4 && x.status==200)
     		{
     		
          			
     			var items=x.responseText;
     			
     			
     			 $.messager.alert('Message', '  Record successfully deleted ', function(r){
     		 		 
     		 		 
 				     
 			     });
     			 
     			 
     			var dtype = $("#txthdoctype").val();
           	 $("#headerGridDiv").load("headerGrid.jsp?dtype="+dtype);
     			
     			}
     		
     	}
     		
     x.open("GET","deletedate.jsp?radocno="+radocno+"&type="+type,true);
     
     x.send();
     		
     }
</script>
<div id="jqxHeader"></div>