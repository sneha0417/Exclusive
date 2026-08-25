<%@page import="com.controlcentre.settings.serviceteam.ClsServiceTeamDAO"%>
<%ClsServiceTeamDAO DAO= new ClsServiceTeamDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
 String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");
 %>
    
<script type="text/javascript">
	    var data;
	    var docno="<%=docno%>";
	    data= '<%=DAO.descLoad(docno,session)%>';
    
        $(document).ready(function () { 	
            
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'srno' , type: 'number' },
     						{name : 'empid', type: 'String'  },
     						{name : 'empcode', type: 'String'  },
                          	{name : 'empname', type: 'String'  },
                          	{name : 'teamuserlinkid', type: 'String'  },
                          	{name : 'teamuserlinkname', type: 'String'  },
                          	],
                 localdata: data,
                
                
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
            $("#serviceteamGrid").jqxGrid(
            {
                width: '80%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlecell',
                //pagermode: 'default',
                sortable: true,
                //Add row method
	
                columns: [
					{ text: 'Sr No', datafield: 'srno', width: '25%',editable:true, filterable: false, editable: false,
                        groupable: false, draggable: false, resizable: false,datafield: '',
                        columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
                        cellsrenderer: function (row, column, value) {
                         return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                        }  
 },
					{ text: 'EmployeeId', datafield: 'empid', width: '30%',editable:true,hidden:true },
					{ text: 'Employee code', datafield: 'empcode', width: '26%',editable:true },
					{ text: 'Employee Name',datafield:'empname',width:'50%',editable:true},
					{ text: 'Team User Link',datafield:'teamuserlinkname',width:'20%',editable: false},
					{ text: 'Team User Link Id',datafield:'teamuserlinkid',width:'60%',editable: false,hidden:true}
					
					]
            });
            
            $("#serviceteamGrid").on("celldoubleclick", function (event) 
         		   {
			            	var rowBoundIndex = event.args.rowindex;
			    		       var datafield = event.args.datafield;
			    		       
			    		       if(datafield=="empname")
			    		    	   {
			    		    	   getemployee(rowBoundIndex);
			    		    	  
			    		    	   }
			    		       if(datafield=="empcode")
		    		    	   {
		    		    	   getemployee(rowBoundIndex);
		    		    	  
		    		    	   }
			    		       
			    		       if(datafield=="teamuserlinkname")
		    		    	   {
			    		    	   getTeamUserLink(rowBoundIndex);
		    		    	  
		    		    	   }
			    		       
 		       
         		   });
            
            if($('#mode').val()=='view'){
            	$("#serviceteamGrid").jqxGrid('disabled',true);
            }
            
            $("#popupWindow").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
            // create context menu
               var contextMenu = $("#Menu").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
               $("#serviceteamGrid").on('contextmenu', function () {
                   return false;
               });
               
               $("#Menu").on('itemclick', function (event) {
            	   var args = event.args;
                   var rowindex = $("#serviceteamGrid").jqxGrid('getselectedrowindex');
                   if ($.trim($(args).text()) == "Edit Selected Row") {
                       editrow = rowindex;
                       var offset = $("#materialGrid").offset();
                       $("#popupWindow").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
                       // get the clicked row's data and initialize the input fields.
                       var dataRecord = $("#serviceteamGrid").jqxGrid('getrowdata', editrow);
                       // show the popup window.
                       $("#popupWindow").jqxWindow('show');
                   }
                   else {
                       var rowid = $("#serviceteamGrid").jqxGrid('getrowid', rowindex);
                      
                       $("#serviceteamGrid").jqxGrid('deleterow', rowid);
                   }
               });
               
               $("#serviceteamGrid").on('rowclick', function (event) {
                   if (event.args.rightclick) {
        		   if(document.getElementById("mode").value=="A" || document.getElementById("mode").value=="E"){
                       $("#serviceteamGrid").jqxGrid('selectrow', event.args.rowindex);
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
    <div id="serviceteamGrid"></div>
    <div id="popupWindow">
 
 <div id='Menu'>
        <ul>
            <li>Delete Selected Row</li>
        </ul>
       </div>
       </div>
       </div>
<input type="hidden" id="rowindex">
<input type="hidden" id="datas">
<input type="hidden" id="datas1">
