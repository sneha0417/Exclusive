<%@page import="com.guideline.ClsGuidelineDAO" %>
<% ClsGuidelineDAO gld=new ClsGuidelineDAO();%>
<%
   	
 String doctype = request.getParameter("doctype")==null?"0":request.getParameter("doctype").trim();
   	
 //  	System.out.println("type======"+request.getParameter("jobtype"));
   	%>
   	
<script type="text/javascript">
       
        
        $(document).ready(function () { 	
        	
        	var datas;
            
        	datas='<%=gld.descLoad (doctype) %>';
        	// alert("data======"+datas);
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							
							{name : 'description', type: 'string' },
							{name : 'ref_no', type: 'string' }
                        ],
                		    localdata: datas, 
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxgDesc").jqxGrid(
            {
                width: '100%',
                height: 200,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlecell',
                    
              //Add row method
                 handlekeyboardnavigation: function (event) {
                	 var rows = $('#jqxgDesc').jqxGrid('getrows');
                     var rowlength= rows.length;
                        var cell = $('#jqxgDesc').jqxGrid('getselectedcell');
                        
                        if (cell != undefined && cell.datafield == 'description' && cell.rowindex == rowlength - 1) {
                            var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                            if (key ==9) {  
                                var commit = $("#jqxgDesc").jqxGrid('addrow', null, {});
                                rowlength++; 
                            }
                        }
                }, 
                    
                columns: [
						    {  text: 'Sr. No.', sortable: false, filterable: false, editable: false,
						       groupable: false, draggable: false, resizable: false,datafield: '',
						       columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
						       cellsrenderer: function (row, column, value) {
						  	   return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						      }  
							},                          
							{ text: 'Description', datafield: 'description', width: '95%'},
							{ text: 'ref_no', datafield: 'ref_no', width: '5%',hidden:true}
						]
            });
            $("#jqxgDesc").jqxGrid('addrow', null, {});
            if(document.getElementById("mode").value=='view'){
            	$('#jqxgDesc').jqxGrid({ disabled: true});
            }
              //$("#jqxgDesc").jqxGrid('addrow', null, {});
           /*$("#jqxgDesc").jqxGrid('addrow', null, {});
            $("#jqxgDesc").jqxGrid('addrow', null, {});  */
            
            /* $('#jqxgDesc').on('rowdoubleclick', function (event) 
            		{ 
              	var rowindex1=event.args.rowindex;
              	//alert("heheheheheheh"+$('#jqxgDesc').jqxGrid('getcellvalue', rowindex1, "mandatory"));
              	document.getElementById("errormsg").innerText="";
              	 document.getElementById("txtdescription").value=$('#jqxgDesc').jqxGrid('getcellvalue', rowindex1, "description");
              	 if($('#jqxgDesc').jqxGrid('getcellvalue', rowindex1, "mandatory")==true){
              		$('#chckmandatory').attr('checked', true);
              	 }
              	 else{
              		$('#chckmandatory').attr('checked', false);
              	 }
              	//document.getElementById("chckmandatory").value=$('#jqxgDesc').jqxGrid('getcellvalue', rowindex1, "mandatory");
              	document.getElementById("is_pglinesrno").value=$('#jqxgDesc').jqxGrid('getcellvalue', rowindex1, "srno");
            		 }); */
           
            
        });
    </script>
    <div id="jqxgDesc"></div>
    <input type="hidden" id="rowindex"/>