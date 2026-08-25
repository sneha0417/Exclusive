<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<%@page import="com.project.execution.quotation.ClsQuotationDAO"%>
<%ClsQuotationDAO DAO= new ClsQuotationDAO();
String dtype = request.getParameter("dtype")==null?"0":request.getParameter("dtype");
String qotdoc=request.getParameter("qotdoc")==null?"0":request.getParameter("qotdoc").trim();

%> 
<script type="text/javascript">
		 var termsdata;  
        $(document).ready(function () { 
           
            var temp='<%=dtype%>';
            var temp2='<%=qotdoc%>';
             if(temp2!='0'){
            	termsdata='<%=DAO.termsGridReLoad(session,dtype,qotdoc)%>';
            }
             else{
            	
                 termsdata='<%=DAO.termsGridLoad(session,dtype)%>';     
                
             }
                           
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'string' },
							{name : 'voc_no', type: 'string' },
							{name : 'dtype', type: 'string' },
     						{name : 'terms', type: 'string' }, 
     						{name : 'conditions', type: 'string'}
                        ],
                         localdata: termsdata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxTerms").jqxGrid(
            {
                width: '99.5%',
                height: 220,
                source: dataAdapter,
                editable: true,
                disabled:true,
                selectionmode: 'singlecell',
                handlekeyboardnavigation: function (event) {
                    var rows = $('#jqxTerms').jqxGrid('getrows');
                       var rowlength= rows.length;
                       var cell = $('#jqxTerms').jqxGrid('getselectedcell');
         				if (cell != undefined && cell.datafield == 'conditions' && cell.rowindex == rowlength - 1) {
                           var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                           if (key == 9) {                                                        
                              // var commit = $("#jqxTerms").jqxGrid('addrow', null, {});
                               rowlength++;                           
                           }
                       }
   },  
                
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Doc_no', datafield: 'doc_no', width: '10%',hidden:true },
							{ text: 'Voc_no', datafield: 'voc_no', width: '10%',hidden:true },
							{ text: 'Dtype', datafield: 'dtype',  width: '10%',hidden:true },
							{ text: 'Terms', datafield: 'terms',  width: '10%',editable:false,
								cellsrenderer: function (row, column, value) {
	                            	  return "<b><div style='margin:4px;font-size:110%;'>" + (value) + "</b></center>";
	                              }
							},
							{ text: 'Description', datafield: 'conditions', width: '85%' },	
							
						]
            });
            
            if (($('#mode').val() == 'A')
					|| ($('#mode').val() == 'E')) {
				$("#jqxTerms").jqxGrid({
					disabled : false
				});
			}
            
            $('#jqxTerms').on('celldoubleclick', function (event) {
                
            	var columnindex1=event.args.columnindex;
            	 var rowindex1 = event.args.rowindex;
            	 var datafield = event.args.datafield;
            	 var dtype=document.getElementById("formdetailcode").value;
            	
            	 var tmp;
            	 var tdocno;
            	 if(datafield=='terms'){
            		 
            		 tmp=$('#jqxTerms').jqxGrid('getcellvalue', rowindex1, "conditions");
            		 
            		 if(tmp==""||typeof(tmp)=="undefined"|| typeof(tmp)=="NaN")
          		   { 
            			 
            			 termsSearchContent("termsSearch.jsp?dtype="+dtype+"&rowindex2="+rowindex1);  
          		   }
                   else
                  	 {

           
          		  } 
            	 }
            	 
 					if(datafield=='conditions'){
 						
            		 
            		 tmp=$('#jqxTerms').jqxGrid('getcellvalue', rowindex1, "terms");
            		 
            		 if(!(tmp==""||typeof(tmp)=="undefined"|| typeof(tmp)=="NaN"))
          		   { 
            			 tdocno=$('#jqxTerms').jqxGrid('getcellvalue', rowindex1, "doc_no");
            			 
            			 termsSearchContent("condtnSearch.jsp?dtype="+dtype+"&rowindex2="+rowindex1+"&tdocno="+tdocno);  
          		   }
                   else
                  	 {

           
          		  } 
            		 
            	 }
            	 
            	 });
            
            
            
            $("#popupWindow2").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
            // create context menu
               var contextMenu = $("#Menu2").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
               $("#jqxTerms").on('contextmenu', function () {
                   return false;
               });
               
               $("#Menu2").on('itemclick', function (event) {
            	   var args = event.args;
                   var rowindex = $("#jqxTerms").jqxGrid('getselectedrowindex');
                   if ($.trim($(args).text()) == "Edit Selected Row") {
                       editrow = rowindex;
                       var offset = $("#jqxTerms").offset();
                       $("#popupWindow2").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
                       // get the clicked row's data and initialize the input fields.
                       var dataRecord = $("#jqxTerms").jqxGrid('getrowdata', editrow);
                       // show the popup window.
                       $("#popupWindow2").jqxWindow('show');
                   }
                   else {
                       var rowid = $("#jqxTerms").jqxGrid('getrowid', rowindex);
                       $("#jqxTerms").jqxGrid('deleterow', rowid);
                   }
               });
               
               $("#jqxTerms").on('rowclick', function (event) {
                   if (event.args.rightclick) {
        		   if(document.getElementById("mode").value=="A" || document.getElementById("mode").value=="E"){
                       $("#jqxTerms").jqxGrid('selectrow', event.args.rowindex);
                       var scrollTop = $(window).scrollTop();
                       var scrollLeft = $(window).scrollLeft();
                       contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                       return false;
                   }
        		   }
               });
            
               $("#jqxTerms").jqxGrid('addrow', null, {});
        });
</script>
<div id='jqxWidget'>
   <div id="jqxTerms"></div>
    <div id="popupWindow2">
 
 <div id='Menu2'>
        <ul>
            <li>Delete Selected Row</li>
        </ul>
       </div>
       </div>
       </div>
