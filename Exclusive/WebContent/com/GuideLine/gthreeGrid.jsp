<%@page import="com.guideline.ClsGuidelineDAO" %>
<% ClsGuidelineDAO gld=new ClsGuidelineDAO();%>
<%
   	
 String doctype = request.getParameter("doctype")==null?"0":request.getParameter("doctype").trim();
   	
  // 	System.out.println("doctype======"+request.getParameter("doctype"));
   	%>
   	
<script type="text/javascript">
       
        
        $(document).ready(function () { 	
        	
        	var datas;
            
        	datas='<%=gld.noteLoad (doctype) %>';
        	// alert("data======"+datas);
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'notes', type: 'string' }
                        ],
                		    localdata: datas, 
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxgthree").jqxGrid(
            {
                width: '100%',
                height: 200,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlecell',
                    
              //Add row method
                 handlekeyboardnavigation: function (event) {
                	var rows = $('#jqxgthree').jqxGrid('getrows');
                 	var rowlength= rows.length;
                    var cell = $('#jqxgthree').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'notes'  && cell.rowindex == rowlength - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 9) {                                                        
                            var commit = $("#jqxgthree").jqxGrid('addrow', null, {});
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
							{ text: 'Notes', datafield: 'notes', width: '95%'},
							
						]
            });
            $("#jqxgthree").jqxGrid('addrow', null, {});
            if(document.getElementById("mode").value=='view'){
            	$('#jqxgthree').jqxGrid({ disabled: true});
            }
            /* $("#jqxgthree").jqxGrid('addrow', null, {});
            $("#jqxgthree").jqxGrid('addrow', null, {});
            $("#jqxgthree").jqxGrid('addrow', null, {}); */
            
            /* $('#jqxgthree').on('rowdoubleclick', function (event) 
            		{ 
              	var rowindex1=event.args.rowindex;
              	//alert("heheheheheheh"+$('#jqxgthree').jqxGrid('getcellvalue', rowindex1, "mandatory"));
              	document.getElementById("errormsg").innerText="";
              	 document.getElementById("txtdescription").value=$('#jqxgthree').jqxGrid('getcellvalue', rowindex1, "description");
              	 if($('#jqxgthree').jqxGrid('getcellvalue', rowindex1, "mandatory")==true){
              		$('#chckmandatory').attr('checked', true);
              	 }
              	 else{
              		$('#chckmandatory').attr('checked', false);
              	 }
              	//document.getElementById("chckmandatory").value=$('#jqxgthree').jqxGrid('getcellvalue', rowindex1, "mandatory");
              	document.getElementById("is_pglinesrno").value=$('#jqxgthree').jqxGrid('getcellvalue', rowindex1, "srno");
            		 }); */
           
            
        });
    </script>
    <div id="jqxgthree"></div>
    <input type="hidden" id="rowindex"/>