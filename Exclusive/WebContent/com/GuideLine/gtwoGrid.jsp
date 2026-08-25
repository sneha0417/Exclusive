<%@page import="com.guideline.ClsGuidelineDAO" %>
<% ClsGuidelineDAO gld=new ClsGuidelineDAO();%>
<%
 String doctype = request.getParameter("doctype")==null?"0":request.getParameter("doctype").trim();
   	
 //  	System.out.println("type======"+request.getParameter("jobtype"));
   	%>
   	
<script type="text/javascript">
       
        
        $(document).ready(function () { 	
        	
        	var datas;
            
        	datas='<%=gld.fieldLoad (doctype) %>';
        	// alert("data======"+datas);
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'fieldname', type: 'string' },
							{name : 'description', type: 'string' },
							{name : 'srno', type: 'number' }
                        ],
                		    localdata: datas, 
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxgtwo").jqxGrid(
            {
                width: '100%',
                height: 200,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlecell',
                    
              //Add row method
                 handlekeyboardnavigation: function (event) {
                	var rows = $('#jqxgtwo').jqxGrid('getrows');
                 	var rowlength= rows.length;
                    var cell = $('#jqxgtwo').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'description' && cell.rowindex == rowlength - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 9) {                                                        
                            var commit = $("#jqxgtwo").jqxGrid('addrow', null, {});
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
							{ text: 'Field Name', datafield: 'fieldname', width: '20%'},
							{ text: 'Description', datafield: 'description', width: '75%' },
						]
            });
            $("#jqxgtwo").jqxGrid('addrow', null, {});
            if(document.getElementById("mode").value=='view'){
            	$('#jqxgtwo').jqxGrid({ disabled: true});
            }
            /* $("#jqxgtwo").jqxGrid('addrow', null, {});
            $("#jqxgtwo").jqxGrid('addrow', null, {});
            $("#jqxgtwo").jqxGrid('addrow', null, {}); */
            
            /* $('#jqxgtwo').on('rowdoubleclick', function (event) 
            		{ 
              	var rowindex1=event.args.rowindex;
              	//alert("heheheheheheh"+$('#jqxgtwo').jqxGrid('getcellvalue', rowindex1, "mandatory"));
              	document.getElementById("errormsg").innerText="";
              	 document.getElementById("txtdescription").value=$('#jqxgtwo').jqxGrid('getcellvalue', rowindex1, "description");
              	 if($('#jqxgtwo').jqxGrid('getcellvalue', rowindex1, "mandatory")==true){
              		$('#chckmandatory').attr('checked', true);
              	 }
              	 else{
              		$('#chckmandatory').attr('checked', false);
              	 }
              	//document.getElementById("chckmandatory").value=$('#jqxgtwo').jqxGrid('getcellvalue', rowindex1, "mandatory");
              	document.getElementById("is_pglinesrno").value=$('#jqxgtwo').jqxGrid('getcellvalue', rowindex1, "srno");
            		 }); */
           
            
        });
    </script>
    <div id="jqxgtwo"></div>
    <input type="hidden" id="rowindex"/>