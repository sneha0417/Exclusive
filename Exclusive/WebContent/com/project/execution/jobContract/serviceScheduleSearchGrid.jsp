<%@page import="com.project.execution.jobContract.ClsJobContractDAO"%> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsJobContractDAO DAO= new ClsJobContractDAO(); %>
<%
 String gridload=request.getParameter("gridload")==null?"0":request.getParameter("gridload").trim().toString(); 
 String serfrmdate = request.getParameter("serfrmdate")==null?"0":request.getParameter("serfrmdate");
 String sertodate = request.getParameter("sertodate")==null?"0":request.getParameter("sertodate");
 String cmbsrvday = request.getParameter("cmbsrvday")==null?"0":request.getParameter("cmbsrvday");
 
 String srvalue = request.getParameter("srvalue")==null?"0":request.getParameter("srvalue");
 String srvid = request.getParameter("srvid")==null?"0":request.getParameter("srvid");
 String siteid = request.getParameter("siteid")==null?"0":request.getParameter("siteid");
 String service = request.getParameter("srvser")==null?"0":request.getParameter("srvser");
 String site = request.getParameter("srvsite")==null?"0":request.getParameter("srvsite");
 
 String srvint = request.getParameter("srvint")==null?"0":request.getParameter("srvint");
 String srvdue = request.getParameter("srvdue")==null?"0":request.getParameter("srvdue");
 String csrvtyp = request.getParameter("csrvtyp")==null?"0":request.getParameter("csrvtyp");
 String chkday = request.getParameter("chkday")==null?"0":request.getParameter("chkday");

 %>
     <script type="text/javascript">
   
   
        $(document).ready(function () { 
        	
        	 var schserdata;
        	    var gridload='<%=gridload%>';
        	
          if(gridload=="1"){
          schserdata = '<%=DAO.serviceScheduleGrid(session,serfrmdate,sertodate,cmbsrvday,srvalue,srvid,siteid,
        		  service,site,gridload,srvint,srvdue,csrvtyp,chkday) %>';
          }
        	
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'pldate' , type: 'String' },
     						{name : 'pltime', type: 'String'  },
     						{name : 'site', type: 'String'  },
     						{name : 'siteid', type: 'String'  },
     						{name : 'service', type: 'String'  },
     						{name : 'serviceid', type: 'String'  },
     						{name : 'value', type: 'String'  },
     						{name : 'days', type: 'String'  },
     						{name : 'priority', type: 'bool'   }
                          	],
                 localdata: schserdata,
                
                
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
            $("#servserGrid").jqxGrid(
            {
                width: '100%',
                height: 300,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'checkbox',
                editable:true,
                sortable: true,
                //Add row method--mm:ss
	
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '5%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Pl.Date', datafield: 'pldate', width: '15%',editable:true, columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy' },
					{ text: 'Pl.Time', datafield: 'pltime', width: '13%' ,cellsformat:'HH:mm',cellclassname:'column',columntype:"datetimeinput", createeditor: function (row, cellvalue, editor, celltext, cellwidth, cellheight) {
	                      editor.jqxDateTimeInput({ showCalendarButton: false });
	                  }
	         
	               },
	               {text: 'Days',datafield:'days',width:'10%',editable:false},
	           	    {text: 'Site',datafield:'site',width:'20%',editable:false},
	           	    {text: 'Service',datafield:'service',width:'20%',editable:false},
	           	    {text: 'serviceid',datafield:'serviceid',width:'10%',editable:false,hidden:true},
	           	    {text: 'siteid',datafield:'siteid',width:'10%',editable:false,hidden:true},
	             	{text: 'Value',datafield:'value',width:'15%',editable:true},
					]
            });
            if($('#mode').val()=='view'){
       		 $("#servserGrid").jqxGrid({ disabled: true});
       		
           }
		/* if(docno>0){
        		
			$('#servserGrid').jqxGrid('showcolumn','site');
        		
          } */
            
            $('#servserGrid').on('cellValueChanged', function (event) 
            		{ 
            	
              	 var rowBoundIndex=event.args.rowindex;
              	 $('#servserGrid').jqxGrid('setcellvalue', rowBoundIndex, "pltime" ,new Date());
            
           });
            
            $('#servserGrid').on('celldoubleclick', function(event) 
            		{
            	var rowBoundIndex = event.args.rowindex;
            	var datafield = event.args.datafield;
            	
 		      
 		     if((datafield=="site"))
	    	   {
 		    	 $('#siteinfowindow').jqxWindow('open');
 		    	     var type=2;
 		    	      siteSearchContent('servicesitesearch.jsp?rowBoundIndex='+rowBoundIndex+'&type='+type);
	    	   }
 		    if((datafield=="service"))
	    	   {
 		    	var sert=3;
 		    	getserType(rowBoundIndex,sert);
	    	   }
 		    /* if((datafield=="assignto"))
	    	   {
 		    	 var assgnid=$('#servserGrid').jqxGrid('getcellvalue', rowBoundIndex, "assigngrpid");
 		    	
 		    	getteam(rowBoundIndex,assgnid);
	    	   }*/
 		     
            			
            		});
            
           
            $("#servserGrid").jqxGrid('addrow', null, {});
      
        });
    </script>
    <div id="servserGrid"></div>