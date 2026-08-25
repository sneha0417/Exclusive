<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<%@page import="com.controlcentre.masters.relatedmaster.tourtype.ClsTourDAO"%>
<%
ClsTourDAO cd=new ClsTourDAO();
%>  
<%
String brhid=request.getParameter("brhid")==null || request.getParameter("brhid")==""?"0":request.getParameter("brhid").trim();
String dtype = request.getParameter("dtype")==null || request.getParameter("dtype")==""?"0":request.getParameter("dtype");
String qotdoc=request.getParameter("qotdoc")==null || request.getParameter("qotdoc")==""?"0":request.getParameter("qotdoc").trim();
String ebrhid=request.getParameter("ebrhid")==null || request.getParameter("ebrhid")==""?"0":request.getParameter("ebrhid").trim();
String enqdoc=request.getParameter("enqdoc")==null || request.getParameter("enqdoc")==""?"0":request.getParameter("enqdoc").trim();
String qbrhid=request.getParameter("qbrhid")==null || request.getParameter("qbrhid")==""?"0":request.getParameter("qbrhid").trim();
%>         
         
<script type="text/javascript">
		 var comtermdata;  
         $(document).ready(function () {     
        
            var temp='<%=dtype%>';        
                
            	comtermdata='<%=cd.termsGridReLoad(session,qotdoc,qbrhid)%>';
                                
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'string' },
							{name : 'voc_no', type: 'string' },
							{name : 'dtype', type: 'string' },
     						{name : 'terms', type: 'string' },
     						{name : 'priorno', type: 'number' },
     						{name : 'conditions', type: 'string'}
                        ],
                         localdata: comtermdata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxComTerms").jqxGrid(
            {
                width: '100%',
                height: 255,
                source: dataAdapter,
                editable: true,
                disabled:false,
                enabletooltips: true,
                selectionmode: 'singlecell',
                handlekeyboardnavigation: function (event) {
                    var rows = $('#jqxComTerms').jqxGrid('getrows');
                       var rowlength= rows.length;
                       var cell = $('#jqxComTerms').jqxGrid('getselectedcell');
         				if (cell != undefined && cell.datafield == 'conditions' && cell.rowindex == rowlength - 1) {
                           var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                           if (key == 9) {                                                        
                              // var commit = $("#jqxComTerms").jqxGrid('addrow', null, {});
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
							{ text: 'Priority', datafield: 'priorno',  width: '5%'},
							{ text: 'Terms', datafield: 'terms',  width: '20%',editable:false,
								cellsrenderer: function (row, column, value) {
	                            	  return "<b><div style='margin:4px;font-size:110%;'>" + (value) + "</b></center>";
	                              }
							},
							{ text: 'Description', datafield: 'conditions', width: '70%',editable:true },	
							
						]
            });
            
            if (($('#mode').val() == 'A')
					|| ($('#mode').val() == 'E')) {
				$("#jqxComTerms").jqxGrid({
					disabled : false
				});
			}
            
            $('#jqxComTerms').on('celldoubleclick', function (event) {
                
            	 var columnindex1=event.args.columnindex;
            	 var rowindex1 = event.args.rowindex;
            	 var datafield = event.args.datafield;
            	 var dtype=document.getElementById("formdetailcode").value;
            	
            	 var tmp;
            	 var tdocno;
            	 if(datafield=='terms'){
            		 
            		 tmp=$('#jqxComTerms').jqxGrid('getcellvalue', rowindex1, "conditions");
            		 
            		 if(tmp==""||typeof(tmp)=="undefined"|| typeof(tmp)=="NaN")
          		   { 
            			 $('#jqxComTerms').jqxGrid('clearselection');
            			 $('#jqxComTerms').jqxGrid('render');
            			    dtype='TOUR';           
            			
            			 termsSearchContent("<%=contextPath%>/com/controlcentre/masters/relatedmaster/termsearch.jsp?dtype="+dtype+"&rowindex2="+rowindex1);  
          		   }
                   else
                  	 {
          		  } 
            	 }  
            	 
 					if(datafield=='conditions'){
 						
            		 tmp=$('#jqxComTerms').jqxGrid('getcellvalue', rowindex1, "terms");
            		 
            		 if(!(tmp==""||typeof(tmp)=="undefined"|| typeof(tmp)=="NaN"))
          		   { 
            			 tdocno=$('#jqxComTerms').jqxGrid('getcellvalue', rowindex1, "doc_no");
            			 $('#jqxComTerms').jqxGrid('clearselection');
            			 $('#jqxComTerms').jqxGrid('render');
            			 dtype='TOUR';  
            			 var cond=$('#txtcond').val();           
            			    
            			condSearchContent("<%=contextPath%>/com/controlcentre/masters/relatedmaster/condtnSearch.jsp?dtype="+dtype+"&rowindex2="+rowindex1+"&tdocno="+tdocno+"&cond="+cond);
          		   }
                   else
                  	 {    
          		  } 
            	 }
            	 
            	 });
            
            
             
            $("#compopupWindow2").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
            // create context menu
               var contextMenu = $("#comMenu2").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
               $("#jqxComTerms").on('contextmenu', function () {
                   return false;
               });
               
               $("#comMenu2").on('itemclick', function (event) {
            	   var args = event.args;
                   var rowindex = $("#jqxComTerms").jqxGrid('getselectedrowindex');
                   if ($.trim($(args).text()) == "Edit Selected Row") {
                       editrow = rowindex;
                       var offset = $("#jqxComTerms").offset();
                       $("#compopupWindow2").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
                       // get the clicked row's data and initialize the input fields.
                       var dataRecord = $("#jqxComTerms").jqxGrid('getrowdata', editrow);
                       // show the popup window.
                       $("#compopupWindow2").jqxWindow('show');
                   }
                   else {
                       var rowid = $("#jqxComTerms").jqxGrid('getrowid', rowindex);
                       $("#jqxComTerms").jqxGrid('deleterow', rowid);
                   }
               });  $("#jqxComTerms").on('rowclick', function (event) {
                    if (event.args.rightclick) {
        		   if(document.getElementById("mode").value=="view"){
                       $("#jqxComTerms").jqxGrid('selectrow', event.args.rowindex);
                       var scrollTop = $(window).scrollTop();
                       var scrollLeft = $(window).scrollLeft();
                       contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                       return false;
                   }
        		   } 
               }); 
                if($('#btnterms').val()=="Edit"){
       			$("#jqxComTerms").jqxGrid({ disabled: true}); 
       		
               } 
               
               
               $("#jqxComTerms").jqxGrid('addrow', null, {});
        });
        
        
</script>

 <div id='jqxWidget'> 
   <div id="jqxComTerms"></div>
    <div id="compopupWindow2">
 
 <div id='comMenu2'>
        <ul>
            <li>Delete Selected Row</li>
        </ul>
       </div>
       </div>
       </div>
      
       
