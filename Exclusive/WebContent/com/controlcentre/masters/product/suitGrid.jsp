<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.product.ClsProductDAO"%>
<% String contextPath=request.getContextPath();%>
<%ClsProductDAO DAO= new ClsProductDAO(); 
String psrno=request.getParameter("docno")==null?"0":request.getParameter("docno").toString();
String stype=request.getParameter("stype")==null?"0":request.getParameter("stype").toString();
String spec1id=request.getParameter("spec1id")==null?"0":request.getParameter("spec1id").toString();
String spec2id=request.getParameter("spec2id")==null?"0":request.getParameter("spec2id").toString();
String spec3id=request.getParameter("spec3id")==null?"0":request.getParameter("spec3id").toString();
String suitid=request.getParameter("suitid")==null?"0":request.getParameter("suitid").toString();

%>
<script type="text/javascript">
		 var suitdata;  
        $(document).ready(function () { 
        	var psrno='<%=psrno%>';
        	var stype='<%=stype%>';
        	
    		if(psrno>=0){
    			suitdata='<%=DAO.prdsuitLoad(session,psrno)%>'; 
    		}
    		 if(stype!="0"){
    			<%-- suitdata='<%=DAO.suitSpecload(session,stype,spec1id,spec2id,spec3id)%>'; --%> 
    			suitdata='<%=DAO.suitSearchLoad(session,suitid)%>';
    		}
    		// prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						
{name : 'doc_no', type: 'string'  },     		
{name : 'model', type: 'string'  },
{name : 'modelid', type: 'int'   },
{name : 'submodel', type: 'string'  },
{name : 'submodelid', type: 'int'   },
{name : 'brand', type: 'string'   },
{name : 'brandid', type: 'int'   },
{name : 'yomfrm', type: 'string'   },
{name : 'yomto', type: 'string'   },
{name : 'yomfrmid', type: 'int'   },
{name : 'yomtoid', type: 'int'   },
{name : 'esize', type: 'string'   },
{name : 'esizeid', type: 'int'   },
{name : 'bsize1', type: 'string'   },
{name : 'bsize1id', type: 'int'   },
{name : 'bsize2', type: 'string'   },
{name : 'bsize2id', type: 'int'   },
{name : 'bsize3', type: 'string'   },
{name : 'bsize3id', type: 'int'   },
{name : 'csize1', type: 'string'   },
{name : 'csize1id', type: 'int'   },
{name : 'csize2', type: 'string'   },
{name : 'csize2id', type: 'int'   },
{name : 'csize3', type: 'string'   },
{name : 'csize3id', type: 'int'   },
     						
							
                        ],
                         localdata: suitdata, 
                         deleterow: function (rowid, commit) {
                             // synchronize with the server - send delete command
                             // call commit with parameter true if the synchronization with the server is successful 
                             // and with parameter false if the synchronization failed.
                             commit(true);
                         },
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxSuitGrid").jqxGrid(
            {
                width: '100%',
                height: 300,
                source: dataAdapter,
                editable: true,
                columnsresize: true,
                selectionmode: 'singlecell',
                handlekeyboardnavigation: function (event) {
                    var rows = $('#jqxSuitGrid').jqxGrid('getrows');
                       var rowlength= rows.length;
                       var cell = $('#jqxSuitGrid').jqxGrid('getselectedcell');
                       if (cell != undefined && cell.datafield == 'spec3' && cell.rowindex == rowlength - 1) {
                           var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                           if (key == 9) {                                                        
                               var commit = $("#jqxSuitGrid").jqxGrid('addrow', null, {});
                               rowlength++;                           
                           }
                       }
   },      
                columns: [
							{ text: 'Sr. No.',datafield: '',columntype:'number', width: '4%', cellsrenderer: function (row, column, value) {
	                               return "<div style='margin:4px;'>" + (value + 1) + "</div>";
                            }   },
                            { text: 'doc_no', datafield: 'doc_no', hidden: true, width: '10%',cellsalign: 'center', align: 'center' },
                            { text: 'Yom(From)', datafield: 'yomfrm', editable: false, width: '4%',cellsalign: 'center', align: 'center' },
                            { text: 'Yomfrmid', datafield: 'yomfrmid', hidden:true, width: '7%',cellsalign: 'center', align: 'center' },
                            { text: 'Yom(To)', datafield: 'yomto', editable: false, width: '4%',cellsalign: 'center', align: 'center' },
                            { text: 'Yomtoid', datafield: 'yomtoid', hidden:true, width: '15%',cellsalign: 'center', align: 'center' },
                            { text: 'typeid', datafield: 'typeid', width: '5%',hidden:true },
                            { text: 'modelid', datafield: 'modelid', width: '5%',hidden:true },
                            { text: 'brandid', datafield: 'brandid', width: '5%',hidden:true },
                            { text: 'submodelid', datafield: 'submodelid', width: '5%',hidden:true },
                            { text: 'Type', datafield: 'ptype', editable: false, width: '15%',cellsalign: 'center', align: 'center',hidden:true },
                            { text: 'Brand', datafield: 'brand', editable: false, width: '10%',cellsalign: 'center', align: 'center' },
                            { text: 'Model', datafield: 'model', editable: false, width: '12%',cellsalign: 'center', align: 'center' },
                            { text: 'Sub Model', datafield: 'submodel', editable: false, width: '10%',cellsalign: 'center', align: 'center' },
                            { text: 'EngineSize', datafield: 'esize', editable: false, width: '10%',cellsalign: 'center', align: 'center' },
                            { text: 'spec2id', datafield: 'esizeid', hidden:true, width: '11%',cellsalign: 'center', align: 'center' },
                            { text: 'BedSize1', datafield: 'bsize1', editable: false, width: '12%',cellsalign: 'center', align: 'center' },
                            { text: 'BedSize2', datafield: 'bsize2', editable: false, width: '12%',cellsalign: 'center', align: 'center' },
                            { text: 'BedSize3', datafield: 'bsize3', editable: false, width: '12%',cellsalign: 'center', align: 'center' },
                            { text: 'bsize1id', datafield: 'bsize1id',hidden:true, width: '11%',cellsalign: 'center', align: 'center' },
                            { text: 'bsize2id', datafield: 'bsize2id',hidden:true, width: '11%',cellsalign: 'center', align: 'center' },
                            { text: 'bsize3id', datafield: 'bsize3id',hidden:true, width: '11%',cellsalign: 'center', align: 'center' },
                            { text: 'CabinSize1', datafield: 'csize1', editable: false, width: '11%',cellsalign: 'center', align: 'center' },
                            { text: 'csize1id', datafield: 'csize1id',hidden:true , width: '12%',cellsalign: 'center', align: 'center' },
                            { text: 'CabinSize2', datafield: 'csize2', editable: false, width: '11%',cellsalign: 'center', align: 'center' },
                            { text: 'csize2id', datafield: 'csize2id',hidden:true , width: '12%',cellsalign: 'center', align: 'center' },
                            { text: 'CabinSize3', datafield: 'csize3', editable: false, width: '11%',cellsalign: 'center', align: 'center' },
                            { text: 'csize3id', datafield: 'csize3id',hidden:true , width: '12%',cellsalign: 'center', align: 'center' },


	
							
						

						]
            });
           
            $('#jqxSuitGrid').on('celldoubleclick', function (event) {

            	var rowBoundIndex = event.args.rowindex;
            	var datafield = event.args.datafield;
            	if(datafield=="yomfrm")
 	    	   { 
            	var suitrows = $("#jqxSuitGrid").jqxGrid('getrows').length;	
  		    	var type="frm";
  		    	var yomfrm=$('#jqxSuitGrid').jqxGrid('getcellvalue',rowBoundIndex, "yomfrm");
  		    	var yomto=$('#jqxSuitGrid').jqxGrid('getcellvalue',rowBoundIndex, "yomto");
  		    	yomSearchContent('yomSearchGrid.jsp?rowno='+rowBoundIndex+'&type='+type+'&yomfrm='+yomfrm+'&yomto='+yomto+'&suitrows='+suitrows);
 	    	   }
  		    
  		   if(datafield=="yomto")
     	   { 
  			  var suitrows = $("#jqxSuitGrid").jqxGrid('getrows').length;
  			  var yomfrm=$('#jqxSuitGrid').jqxGrid('getcellvalue',rowBoundIndex, "yomfrm");
  			  var type="to";
  			  var yomto=$('#jqxSuitGrid').jqxGrid('getcellvalue',rowBoundIndex, "yomto");
		    yomSearchContent('yomSearchGrid.jsp?rowno='+rowBoundIndex+'&type='+type+'&yomfrm='+yomfrm+'&yomto='+yomto+'&suitrows='+suitrows);
     	   }
  		   
 		       
 		      if(datafield=="brand")
	    	   {
 		    	 var yomfrm=$('#jqxSuitGrid').jqxGrid('getcellvalue',rowBoundIndex, "yomfrm");
 		    	var yomto=$('#jqxSuitGrid').jqxGrid('getcellvalue',rowBoundIndex, "yomto");
 		    	 //brandSearchContent('brandSearchGrid.jsp?rowno='+rowBoundIndex);
 		    	 suitSearchContent("suitSearch.jsp?rowno="+rowBoundIndex+"&yomto="+yomto+"&yomfrm="+yomfrm);
	    	   }
 		      
 		     if(datafield=="model")
	    	   {
 		    	var yomfrm=$('#jqxSuitGrid').jqxGrid('getcellvalue',rowBoundIndex, "yomfrm");
 		    	var yomto=$('#jqxSuitGrid').jqxGrid('getcellvalue',rowBoundIndex, "yomto");
 		    	 //brandSearchContent('brandSearchGrid.jsp?rowno='+rowBoundIndex);
 		    	 suitSearchContent("suitSearch.jsp?rowno="+rowBoundIndex+"&yomto="+yomto+"&yomfrm="+yomfrm);
	    	   }
 		    if(datafield=="submodel")
	    	   {
 		    	var yomfrm=$('#jqxSuitGrid').jqxGrid('getcellvalue',rowBoundIndex, "yomfrm");
 		    	var yomto=$('#jqxSuitGrid').jqxGrid('getcellvalue',rowBoundIndex, "yomto");
 		    	 //brandSearchContent('brandSearchGrid.jsp?rowno='+rowBoundIndex);
 		    	 suitSearchContent("suitSearch.jsp?rowno="+rowBoundIndex+"&yomto="+yomto+"&yomfrm="+yomfrm);
	    	   }
 		    
 		    
 		   if(datafield=="bsize1")
    	   {
 			    var type="1";
		    	var brandid=$('#jqxSuitGrid').jqxGrid('getcellvalue',rowBoundIndex, "brandid");
		    	var modelid=$('#jqxSuitGrid').jqxGrid('getcellvalue',rowBoundIndex, "modelid");
		    	var submodelid=$('#jqxSuitGrid').jqxGrid('getcellvalue',rowBoundIndex, "submodelid");

		    	spec1SearchContent("spec1Search.jsp?rowno="+rowBoundIndex+"&brandid="+brandid+"&modelid="+modelid+"&submodelid="+submodelid+"&type="+type);
    	   }
 		   
 		  if(datafield=="bsize2")
   	   {
 			 var type="2";
 			 var brandid=$('#jqxSuitGrid').jqxGrid('getcellvalue',rowBoundIndex, "brandid");
		    	var modelid=$('#jqxSuitGrid').jqxGrid('getcellvalue',rowBoundIndex, "modelid");
		    	var submodelid=$('#jqxSuitGrid').jqxGrid('getcellvalue',rowBoundIndex, "submodelid");
		    	
		    	 spec1SearchContent("spec1Search.jsp?rowno="+rowBoundIndex+"&brandid="+brandid+"&modelid="+modelid+"&submodelid="+submodelid+"&type="+type);
   	   }
 		  
 		 if(datafield=="bsize3")
  	   {
 			var type="3"; 
 			var brandid=$('#jqxSuitGrid').jqxGrid('getcellvalue',rowBoundIndex, "brandid");
	    	var modelid=$('#jqxSuitGrid').jqxGrid('getcellvalue',rowBoundIndex, "modelid");
	    	var submodelid=$('#jqxSuitGrid').jqxGrid('getcellvalue',rowBoundIndex, "submodelid");

	    	spec1SearchContent("spec1Search.jsp?rowno="+rowBoundIndex+"&brandid="+brandid+"&modelid="+modelid+"&submodelid="+submodelid+"&type="+type);
  	   }
 		 
 		 
 		 if(datafield=="csize1")
  	   {
 			var type="1"; 
 			var brandid=$('#jqxSuitGrid').jqxGrid('getcellvalue',rowBoundIndex, "brandid");
	    	var modelid=$('#jqxSuitGrid').jqxGrid('getcellvalue',rowBoundIndex, "modelid");
	    	var submodelid=$('#jqxSuitGrid').jqxGrid('getcellvalue',rowBoundIndex, "submodelid");

		    	 spec3SearchContent("spec3Search.jsp?rowno="+rowBoundIndex+"&brandid="+brandid+"&modelid="+modelid+"&submodelid="+submodelid+"&type="+type);
  	   }
		   
		  if(datafield=="csize2")
 	   {
			  var type="2";
			  var brandid=$('#jqxSuitGrid').jqxGrid('getcellvalue',rowBoundIndex, "brandid");
		    	var modelid=$('#jqxSuitGrid').jqxGrid('getcellvalue',rowBoundIndex, "modelid");
		    	var submodelid=$('#jqxSuitGrid').jqxGrid('getcellvalue',rowBoundIndex, "submodelid");

		    	
	    	 spec3SearchContent("spec3Search.jsp?rowno="+rowBoundIndex+"&brandid="+brandid+"&modelid="+modelid+"&submodelid="+submodelid+"&type="+type);
 	   }
		  
		 if(datafield=="csize3")
	   {
			 var type="3";
			 var brandid=$('#jqxSuitGrid').jqxGrid('getcellvalue',rowBoundIndex, "brandid");
		    	var modelid=$('#jqxSuitGrid').jqxGrid('getcellvalue',rowBoundIndex, "modelid");
		    	var submodelid=$('#jqxSuitGrid').jqxGrid('getcellvalue',rowBoundIndex, "submodelid");

		    	
	    	 spec3SearchContent("spec3Search.jsp?rowno="+rowBoundIndex+"&brandid="+brandid+"&modelid="+modelid+"&submodelid="+submodelid+"&type="+type);
	   }
 		
 		    
 		    
 		     
 		                 	  
                  });
            
            if($('#mode').val()=='view')
	         {
         	$("#jqxSuitGrid").jqxGrid({
  			disabled : true
  		});
	           }
            
            $("#popupWindow").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
            // create context menu
               var contextMenu = $("#Menu").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
               $("#jqxSuitGrid").on('contextmenu', function () {
                   return false;
               });
               
               $("#Menu").on('itemclick', function (event) {
            	   var args = event.args;
                   var rowindex = $("#jqxSuitGrid").jqxGrid('getselectedrowindex');
                   if ($.trim($(args).text()) == "Edit Selected Row") {
                       editrow = rowindex;
                       var offset = $("#jqxSuitGrid").offset();
                       $("#popupWindow").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
                       // get the clicked row's data and initialize the input fields.
                       var dataRecord = $("#jqxSuitGrid").jqxGrid('getrowdata', editrow);
                       // show the popup window.
                       $("#popupWindow").jqxWindow('show');
                   }
                   else {
                       var rowid = $("#jqxSuitGrid").jqxGrid('getrowid', rowindex);
                       $("#jqxSuitGrid").jqxGrid('deleterow', rowid);
                   }
               });
               
               $("#jqxSuitGrid").on('rowclick', function (event) {
                   if (event.args.rightclick) {
        		   if(document.getElementById("mode").value=="A" || document.getElementById("mode").value=="E"){
                       $("#jqxSuitGrid").jqxGrid('selectrow', event.args.rowindex);
                       var scrollTop = $(window).scrollTop();
                       var scrollLeft = $(window).scrollLeft();
                       contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                       return false;
                   }
        		   }
               });
            
          
        });
</script>

<div id='jqxWidget'>
   <div id="jqxSuitGrid"></div>
    <div id="popupWindow">
 
 <div id='Menu'>
        <ul>
            <li>Delete Selected Row</li>
        </ul>
       </div>
       </div>
       </div>
