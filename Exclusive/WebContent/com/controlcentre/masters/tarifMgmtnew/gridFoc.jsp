<%@page import="com.controlcentre.masters.tarifmgmtnew.ClsTarifDAO" %>
<%ClsTarifDAO ctd=new ClsTarifDAO(); %>

<%String tempgid=request.getParameter("id");%>
<%String tempdoc=request.getParameter("doc");%>
<%System.out.println("weekday grid GID="+tempgid+"DOCNO"+tempdoc);%>
<style>
.column{
background-color: #FFEEDC;
}
</style>
<script>
$(document).ready(function () { 
	var temp='<%=tempgid%>';
	var temp2='<%=tempdoc%>';
	var datafoc;
	if(temp2>0){
		
		datafoc='<%=ctd.getFocTarif(tempgid,tempdoc,session)%>';
	}
	else
		{
		<%-- datafoc='<%=com.controlcentre.masters.tarifmgmt.ClsTarifAction.searchDetails_foc()%>'; --%>
		}
	
 var num = 1; 
              // prepare the data
              var source =
              {
                  datatype: "json",
                  datafields: [
                            	{name : 'minday' , type: 'int'},
       						{name : 'foc', type: 'int'  },
       						{name : 'rate', type: 'number'    },
       						{name : 'cdw', type: 'number'    },
       						{name : 'gps', type: 'number'    },
       						{name : 'babyseater', type: 'number'    },
       						{name : 'cooler', type: 'number'    },
       						{name : 'kmrest', type: 'number'    },
       						{name : 'exkmrte', type: 'number'    },
       						{name : 'oinschg', type: 'number'    }
       						
       					
       						
       						],
                  /* url: url, */
                  localdata:datafoc,
                  
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
              
              $("#jqxgridtariffoc").jqxGrid(
              {
                  width: '100%',
                  height:47,
                  source: dataAdapter,
                  columnsresize: true,
                  rowsheight:20,
                  pageable: false,
                  disabled: true,
                  editable:true,
                  selectionmode: 'multiplecellsadvanced',
                  //pagermode: 'default',
                 
                  //Add row method
               /*    handlekeyboardnavigation: function (event) {
                      var cell = $('#jqxgridtariffoc').jqxGrid('getselectedcell');
                      if (cell != undefined && cell.datafield == 'inschg' && cell.rowindex == num - 1) {
                          var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                          if (key == 13) {                                                        
                              var commit = $("#jqxgridtariffoc").jqxGrid('addrow', null, {});
                              num++;                           
                          }
                      }
                  }, */
                 
                  columns: [
  							{ text: ''+document.getElementById("mainminday").value, datafield: 'minday', width: '10%' ,align:'right',cellsalign:'right',cellclassname:'column'},
  							{ text: '      '+document.getElementById("mainfoc").value, datafield: 'foc', width: '10%',align:'right',cellsalign:'right' ,cellclassname:'column'},
  							{ text: '      '+document.getElementById("mainrate").value, datafield: 'rate', width: '10%',align:'right',cellsalign:'right',cellsformat:'d2',cellclassname:'column'},
  							{ text: '     '+document.getElementById("maincdw").value, datafield: 'cdw', width: '10%',align:'right',cellsalign:'right',cellsformat:'d2' ,cellclassname:'column'},
  							{ text: '     '+document.getElementById("maingps").value, datafield: 'gps', width: '10%',align:'right',cellsalign:'right',cellsformat:'d2' ,cellclassname:'column'},
  							{ text: ''+document.getElementById("mainbabyseater").value, datafield: 'babyseater', width: '10%' ,align:'right',cellsalign:'right',cellsformat:'d2',cellclassname:'column'},
  							{ text: ''+document.getElementById("maincooler").value, datafield: 'cooler', width: '10%' ,align:'right',cellsalign:'right',cellsformat:'d2',cellclassname:'column'},
  							{ text: ''+document.getElementById("mainkmrest").value, datafield: 'kmrest', width: '10%',align:'right',cellsalign:'right',cellsformat:'d2' ,cellclassname:'column'},
  							{ text: ''+document.getElementById("mainexkmrte").value, datafield: 'exkmrte', width: '10%',align:'right',cellsalign:'right',cellsformat:'d2' ,cellclassname:'column'},
  							{ text: ''+document.getElementById("mainoinschg").value, datafield: 'oinschg', width: '10%',align:'right',cellsalign:'right',cellsformat:'d2' ,cellclassname:'column'}
  	              ]
                 
              }); 
              $('#jqxgridtarifweekday').jqxGrid('hidecolumn', ''+document.getElementById("subminday").value);
              $('#jqxgridtarifweekday').jqxGrid('hidecolumn', ''+document.getElementById("subfoc").value);
              $('#jqxgridtarifweekday').jqxGrid('hidecolumn', ''+document.getElementById("subrate").value);
              $('#jqxgridtarifweekday').jqxGrid('hidecolumn', ''+document.getElementById("subcdw").value);
              $('#jqxgridtarifweekday').jqxGrid('hidecolumn', ''+document.getElementById("subgps").value); 
              $('#jqxgridtarifweekday').jqxGrid('hidecolumn', ''+document.getElementById("subbabyseater").value);
              $('#jqxgridtarifweekday').jqxGrid('hidecolumn', ''+document.getElementById("subcooler").value);
              $('#jqxgridtarifweekday').jqxGrid('hidecolumn', ''+document.getElementById("subkmrest").value); 
              $('#jqxgridtarifweekday').jqxGrid('hidecolumn', ''+document.getElementById("subexkmrte").value);
              $('#jqxgridtarifweekday').jqxGrid('hidecolumn', ''+document.getElementById("suboinschg").value);
              var rows=  $("#jqxgridtariffoc").jqxGrid('getrows');
              var rowcount=rows.length;
              if(rowcount==0){
            	  $("#jqxgridtariffoc").jqxGrid('addrow', null, {});
              }
           

              
});
              </script>
              <div id="jqxgridtariffoc"></div>