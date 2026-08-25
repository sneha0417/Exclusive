<%@page import="com.project.execution.serviceContract.ClsServiceContractDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsServiceContractDAO DAO= new ClsServiceContractDAO(); %>
 <%
 String gridload=request.getParameter("gridload")==null?"0":request.getParameter("gridload").trim().toString(); 
 String docno=request.getParameter("docno")==null?"0":request.getParameter("docno").trim().toString();
 String trno=request.getParameter("trno")==null?"0":request.getParameter("trno").trim().toString();
 
 %>
    <script type="text/javascript">
    var sitedata;
    var gridload='<%=gridload%>';
    var docno='<%=docno%>';
    var trno='<%=trno%>';
    
    $(document).ready(function () { 
    	chkserviceteam();
    	if(gridload=="1" && trno>0){
    		sitedata = '<%=DAO.siteRefGridLoad(session,trno) %>';
        
        }
    	
    	 if(docno>0){
    		sitedata='<%=DAO.siteGridLoad(session,docno)%>';
    		
    	} 
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'srno' , type: 'number' },
     						{name : 'site', type: 'String'  },
                          	{name : 'area', type: 'String'  },
                          	
                          	{name : 'siteadd', type: 'String'  },
                          	{name : 'contid', type: 'String'  },
                          	{name : 'contper', type: 'String'  },
                          	{name : 'contmob', type: 'String'  },
                          	
                          	{name : 'amount', type: 'String'  },
                          	{name : 'areaid', type: 'String'  },
                          	{name : 'rowno', type: 'String'  },
                          	{name : 'serviceteam', type: 'String'  },
                        	{name : 'steamid', type: 'String'  },
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
					{ text: 'Site', datafield: 'site', width: '25%' },
					{text: 'Service Team', datafield: 'serviceteam', width: '10%' , editable:false  },
					{text: 'steamid',datafield:'steamid',width:'25%',editable:false,hidden:true},
					{text: 'Address',datafield:'siteadd',width:'20%',editable:true},
					{text: 'Contact Person',datafield:'contper',width:'20%',editable:false},
					{text: 'Contact Tel',datafield:'contmob',width:'10%',editable:false},
					{text: 'Area',datafield:'area',width:'20%',editable:false},
					{text: 'Areaid',datafield:'areaid',width:'25%',editable:false,hidden:true},
					{text: 'contid',datafield:'contid',width:'25%',editable:false,hidden:true},
					{text: 'rowno',datafield:'rowno',width:'25%',hidden:true},
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
 		     if((datafield=="serviceteam"))
	    	   {
		    	 getserviceteam(rowBoundIndex);
	    	   }
 		     if(datafield=="contper")
	    	   {
 		    	var clientid=document.getElementById("clientid").value;
 		  		
 		  		if(clientid==""){
 		  			document.getElementById("errormsg").innerText=" Select Client";
 		  			return 0;
 		  		}
 		  		var type=2;
 		  		 $('#cpinfowindow').jqxWindow('open');
 	  	       cpSearchContent('contactpersonsearch.jsp?clientdocno='+clientid+'&rowindex='+rowBoundIndex+'&type='+type); 
 		  		
	    	   }
            			
            		});
            
            if($('#mode').val()=='view'){
                
          		 $("#siteGrid").jqxGrid({ disabled: true});
              }
                 
            $("#siteGrid").jqxGrid('addrow', null, {});
			
			 $("#popupWindow3").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
            // create context menu
               var contextMenu = $("#Menu3").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
               $("#siteGrid").on('contextmenu', function () {
                   return false;
               });
               
               $("#Menu3").on('itemclick', function (event) {
            	   var args = event.args;
                   var rowindex = $("#siteGrid").jqxGrid('getselectedrowindex');
                   if ($.trim($(args).text()) == "Edit Selected Row") {
                       editrow = rowindex;
                       var offset = $("#siteGrid").offset();
                       $("#popupWindow3").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
                       // get the clicked row's data and initialize the input fields.
                       var dataRecord = $("#siteGrid").jqxGrid('getrowdata', editrow);
                       // show the popup window.
                       $("#popupWindow3").jqxWindow('show');
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
        });
    
    function chkserviceteam()
    {
     
	   var x=new XMLHttpRequest();
	   x.onreadystatechange=function(){
	   if (x.readyState==4 && x.status==200)
	    {
	      var items= x.responseText.trim();
	     
	      if(parseInt(items)>0)
	       {
	     
	    	  
	    	  $('#siteGrid').jqxGrid('showcolumn', 'serviceteam');
	    
	    	  
	    	  
	        }
	          else
	      {
	      
	        	  $('#siteGrid').jqxGrid('hidecolumn', 'serviceteam');
	      
	      }
	      
	       }}
	   x.open("GET","checkserviceteam.jsp?",true);
		x.send();
	 
	      
	        
    	
    }
</script>
<div id='jqxWidget'>
   <div id="siteGrid"></div>
   <div id="popupWindow3">
 
 <div id='Menu3'>
    <ul>
        <li>Delete Selected Row</li>
    </ul>
</div>
</div>
</div>