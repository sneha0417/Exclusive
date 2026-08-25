<%@page import="com.controlcentre.masters.tarifmgmt.ClsTarifDAO" %>
<%ClsTarifDAO ctd=new ClsTarifDAO(); %>

<%String tempgid=request.getParameter("id");%>
<%String tempdoc=request.getParameter("doc");%>
<%System.out.println("weekday grid GID="+tempgid+"DOCNO"+tempdoc);%>
  <jsp:include  page="../../../common/commonGrid.jsp"></jsp:include>
<script>
$(document).ready(function () { 
	var temp='<%=tempgid%>';
	var temp2='<%=tempdoc%>';
	var dataweekday;
	if(temp2>0){
		
		dataweekday='<%=ctd.getWeekDayTarif(tempgid,tempdoc)%>';
	}
	else
		{
		<%-- dataweekday='<%=com.controlcentre.masters.tarifmgmt.ClsTarifAction.searchDetails_weekday()%>'; --%>
		}

var num = 1; 
             // prepare the data
             var source =
             {
                 datatype: "json",
                 datafields: [
                           	{name : 'cswkday' , type: 'string' },
      						{name : 'cewkday', type: 'string'  },
      						{name : 'cstime', type: 'date'    },
      						{name : 'cetime', type: 'date'    },
      						{name : 'rate', type: 'number'    },
      						{name : 'cdw', type: 'number'    },
      						{name : 'gps', type: 'number'    },
      						{name : 'babyseater', type: 'number'    },
      						{name : 'cooler', type: 'number'    },
      						{name : 'kmrest', type: 'number'    },
      						{name : 'exkmrte', type: 'number'    },
      						{name : 'oinschg', type: 'number'    },
      						{name : 'ulevel1',type:'number'},
      						{name : 'ulevel2',type:'number'},
      						{name : 'ulevel3',type:'number'},
      						{name : 'exdaychg',type:'number'}
      						
      					
      						
      						],
                 /* url: url, */
                 localdata:dataweekday,
                 
                 pager: function (pagenum, pagesize, oldpagenum) {
                     // callback called when a page or pagse size is changed.
                 }
             };
             
             var dataAdapter = new $.jqx.dataAdapter(source,
             		 {
                 		loadError: function (xhr, status, error) {
 	                   // alert(error);    
 	                    }
 		            });
             var list = ['Saturday', 'Sunday', 'Monday','Tuesday','Wednesday','Thursday','Friday'];
             $("#jqxgridtarifweekday").jqxGrid(
             {
                 width: '100%',
                 height: 87,
                 source: dataAdapter,
                 columnsresize: true,
                 rowsheight:20,
                 pageable: false,
                 disabled: true,
                 editable:true,
                 selectionmode: 'default',
                 pagermode: 'default',
                
                 //Add row method
                 handlekeyboardnavigation: function (event) {
                     var cell = $('#jqxgridtarifweekday').jqxGrid('getselectedcell');
                     if (cell != undefined && cell.datafield == 'inschg' && cell.rowindex == num - 1) {
                         var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                         if (key == 13) {                                                        
                             var commit = $("#jqxgridtarifweekday").jqxGrid('addrow', null, {});
                             num++;                           
                         }
                     }
                 },
                
                 columns: [
 							{ text: ''+document.getElementById("mainstartday").value, datafield: 'cswkday',cellclassname:'column',columntype:'dropdownlist',
 								createeditor: function (row, column, editor) {
 		                            editor.jqxDropDownList({ autoDropDownHeight: true, source: list });
 								}
 							},
 							{ text: ''+document.getElementById("mainstarttime").value, datafield: 'cstime',cellsformat:'HH:mm',cellclassname:'column',columntype:"datetimeinput", createeditor: function (row, cellvalue, editor, celltext, cellwidth, cellheight) {
 						        editor.jqxDateTimeInput({ showCalendarButton: false });
 						    }
 							},
 							{ text: ''+document.getElementById("mainendday").value, datafield: 'cewkday',cellclassname:'column',width:'6.5%',columntype:'dropdownlist',
 								createeditor: function (row, column, editor) {
 		                            editor.jqxDropDownList({ autoDropDownHeight: true, source: list });
 								} },
 							{ text: ''+document.getElementById("mainendtime").value, datafield: 'cetime', cellclassname:'column', cellsformat: 'HH:mm',columntype:"datetimeinput", createeditor: function (row, cellvalue, editor, celltext, cellwidth, cellheight) {
 						        editor.jqxDateTimeInput({ showCalendarButton: false });
 						    }
 							},
 							{ text: '      '+document.getElementById("mainrate").value, datafield: 'rate',cellsformat: 'd2',cellsalign:'right',align:'right',cellclassname:'column'},
 							{ text: '     '+document.getElementById("maincdw").value, datafield: 'cdw', cellsformat: 'd2',cellsalign:'right',align:'right',cellclassname:'column'},
 							{ text: '     '+document.getElementById("maingps").value, datafield: 'gps',cellsformat: 'd2',cellsalign:'right',align:'right',cellclassname:'column'},
 							{ text: ''+document.getElementById("mainbabyseater").value, datafield: 'babyseater',cellsformat: 'd2',cellsalign:'right',align:'right',cellclassname:'column'},
 							{ text: ''+document.getElementById("maincooler").value, datafield: 'cooler',cellsformat: 'd2',cellsalign:'right',align:'right',cellclassname:'column'},
 							{ text: ''+document.getElementById("mainkmrest").value, datafield: 'kmrest',cellsformat: 'd2',cellsalign:'right',align:'right',cellclassname:'column'},
 							{ text: ''+document.getElementById("mainexkmrte").value, datafield: 'exkmrte',cellsformat: 'd2',cellsalign:'right',align:'right',cellclassname:'column'},
 							{ text: ''+document.getElementById("mainoinschg").value, datafield: 'oinschg',cellsformat: 'd2',cellsalign:'right',align:'right',cellclassname:'column'},
 							{ text: 'U Level 1', datafield: 'ulevel1',cellsformat: 'd2',cellsalign:'right',align:'right',cellclassname:'column',width:'6%'},
 							{ text: 'U Level 2', datafield: 'ulevel2',cellsformat: 'd2',cellsalign:'right',align:'right',cellclassname:'column',width:'6%'},
 							{ text: 'U Level 3', datafield: 'ulevel3',cellsformat: 'd2',cellsalign:'right',align:'right',cellclassname:'column',width:'6%'},
 							{ text: 'Extra Day Chg', datafield: 'exdaychg',cellsformat: 'd2',cellsalign:'right',align:'right',cellclassname:'column',width:'6%'}
 	              ]
             }); 
             $('#jqxgridtarifweekday').jqxGrid('hidecolumn', ''+document.getElementById("subcstime").value);
             $('#jqxgridtarifweekday').jqxGrid('hidecolumn', ''+document.getElementById("subcswkday").value);
             $('#jqxgridtarifweekday').jqxGrid('hidecolumn', ''+document.getElementById("subcewkday").value);
             $('#jqxgridtarifweekday').jqxGrid('hidecolumn', ''+document.getElementById("subcetime").value);
             $('#jqxgridtarifweekday').jqxGrid('hidecolumn', ''+document.getElementById("subrate").value);
             $('#jqxgridtarifweekday').jqxGrid('hidecolumn', ''+document.getElementById("subcdw").value);
             $('#jqxgridtarifweekday').jqxGrid('hidecolumn', ''+document.getElementById("subgps").value); 
             $('#jqxgridtarifweekday').jqxGrid('hidecolumn', ''+document.getElementById("subbabyseater").value);
             $('#jqxgridtarifweekday').jqxGrid('hidecolumn', ''+document.getElementById("subcooler").value);
             $('#jqxgridtarifweekday').jqxGrid('hidecolumn', ''+document.getElementById("subkmrest").value); 
             $('#jqxgridtarifweekday').jqxGrid('hidecolumn', ''+document.getElementById("subexkmrte").value);
             $('#jqxgridtarifweekday').jqxGrid('hidecolumn', ''+document.getElementById("suboinschg").value);
             var rows=  $("#jqxgridtarifweekday").jqxGrid('getrows');
             var rowcount=rows.length;
             if(rowcount==0){
            	  $("#jqxgridtarifweekday").jqxGrid("addrow", null, {});
            	  $("#jqxgridtarifweekday").jqxGrid("addrow", null, {});
            	  $("#jqxgridtarifweekday").jqxGrid("addrow", null, {});
             }
             else if(rowcount==1){
            	 $("#jqxgridtarifweekday").jqxGrid("addrow", null, {});
           	  $("#jqxgridtarifweekday").jqxGrid("addrow", null, {});
             }
             else if(rowcount==2){
            	 $("#jqxgridtarifweekday").jqxGrid("addrow", null, {});
           	  
             }
             else{
            	 
             }
          
});
             //Weekday grid end
             </script>
             <div id="jqxgridtarifweekday"></div>