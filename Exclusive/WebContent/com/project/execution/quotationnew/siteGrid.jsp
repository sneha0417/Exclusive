<%@page import="com.project.execution.quotationnew.ClsQuotationDAO"%> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsQuotationDAO DAO= new ClsQuotationDAO(); %>
 <%
 
 int surtrno =request.getParameter("surtrno")==null?0:Integer.parseInt(request.getParameter("surtrno").trim()); 
 String docno=request.getParameter("docno")==null?"0":request.getParameter("docno").trim().toString();
 String trno=request.getParameter("trno")==null?"0":request.getParameter("trno").trim().toString();
 String reftype=request.getParameter("reftype")==null?"DIR":request.getParameter("reftype").trim().toString();
 
 System.out.println("surtrno ="+surtrno+"==docno=="+docno+"==trno=="+trno+"==reftype=="+reftype);
 %>
    <script type="text/javascript">
    var sitedata;
    var docno='<%=docno%>';
    var surtrno='<%=surtrno%>';
    var trno='<%=trno%>';
    var reftype='<%=reftype%>';
    
    $(document).ready(function () { 
    	//alert(surtrno);
    	
		if(parseInt(trno)>0 && reftype!='SRVE'){      
    		sitedata = '<%=DAO.siteRefGridLoad(session,trno,surtrno) %>';
       
        } else if(parseInt(docno)==0 && parseInt(surtrno)>0 && reftype!='SERV'){  
        	sitedata = '<%=DAO.siteEstGridLoad(surtrno,reftype,trno) %>';
    	}
    	 if(docno>0){
    		sitedata='<%=DAO.siteGridLoad(session,docno)%>';
    		
    	} 
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'rowno' , type: 'number' },
     						{name : 'site', type: 'String'  },
                          	{name : 'area', type: 'String'  },
                          	{name : 'amount', type: 'String'  },
                          	{name : 'areaid', type: 'String'  },
                          	],
                 localdata: sitedata,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#siteGrid").jqxGrid(
            {
                width: '100%',
                height: 140,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlecell',
                sortable: true,
                editable:true,
                //Add row method
	
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '5%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Site', datafield: 'site', width: '50%' },
					{text: 'Area',datafield:'area',width:'45%',editable:false},
					{text: 'Areaid',datafield:'areaid',width:'25%',editable:false,hidden:true},
					{text: 'rowno',datafield:'rowno',width:'25%',editable:false,hidden:true},
					]
            });
            
            $('#siteGrid').on('celldoubleclick', function(event) 
            		{
            	var rowBoundIndex = event.args.rowindex;
            	var datafield = event.args.datafield;
            	
 		      
 		      if((datafield=="area"))
	    	   {
 		    	 getareas(rowBoundIndex);
	    	   }
 		     /* if((datafield=="site"))
	    	   {
 		    	getsite(rowBoundIndex);
	    	   } */
		     
            			
            		});
            
            if($('#mode').val()=='view'){
                
          		 $("#siteGrid").jqxGrid({ disabled: true});
              }
            
            
            
            $("#popupWindow").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
            // create context menu
               var contextMenu = $("#Menu").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
               $("#siteGrid").on('contextmenu', function () {
                   return false;
               });
               
               $("#Menu").on('itemclick', function (event) {
            	   var args = event.args;
                   var rowindex = $("#siteGrid").jqxGrid('getselectedrowindex');
                   if ($.trim($(args).text()) == "Edit Selected Row") {
                       editrow = rowindex;
                       var offset = $("#siteGrid").offset();
                       $("#popupWindow").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
                       // get the clicked row's data and initialize the input fields.
                       var dataRecord = $("#siteGrid").jqxGrid('getrowdata', editrow);
                       // show the popup window.
                       $("#popupWindow").jqxWindow('show');
                   }
                   else {
                       var rowid = $("#siteGrid").jqxGrid('getrowid', rowindex);
                       $("#siteGrid").jqxGrid('deleterow', rowid);
                   }
               });
               
               $("#siteGrid").on('rowclick', function (event) {
                   if (event.args.rightclick) {
        		   if(document.getElementById("mode").value=="A" || document.getElementById("mode").value=="E"){
                       $("#siteGrid").jqxGrid('selectrow', event.args.rowindex);
                       var scrollTop = $(window).scrollTop();
                       var scrollLeft = $(window).scrollLeft();
                       contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                       return false;
                   }
        		   }
               });
            
            
                 
            $("#siteGrid").jqxGrid('addrow', null, {});
        });
    </script>
    
    <div id='jqxWidget'>
    <div id="siteGrid"></div>
    <div id="popupWindow">
 
 <div id='Menu'>
        <ul>
            <li>Delete Selected Row</li>
        </ul>
       </div>
       </div>
       </div>
