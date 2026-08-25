<%@page import="com.controlcentre.masters.tarifmgmt.ClsTarifDAO" %>
<%ClsTarifDAO ctd=new ClsTarifDAO(); %>

<%String tempgid=request.getParameter("id");%>
<%String tempdoc=request.getParameter("doc");%>
<%System.out.println("GID="+tempgid+"DOCNO"+tempdoc);%>
<script type="text/javascript">

$(document).ready(function () { 
	var temp='<%=tempgid%>';
	var temp2='<%=tempdoc%>';
	//alert("temp"+temp+"Temp2"+temp2);
	var datafuel;
	if(temp2>0){
		
		datafuel='<%=ctd.getFuelTarif(tempgid,tempdoc)%>';
	}
	else{
		<%-- datafuel='<%=com.controlcentre.masters.tarifmanagement.tarifmgmt.ClsTarifDAO.getNewRegular()%>'; --%>
	}
 var num = 1; 
 
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                      
     						{name : 'level2', type: 'number'  },
     						{name : 'level4', type: 'number'    },
     						{name : 'level6', type: 'number'    },
     						{name : 'level8', type: 'number'    }
     						],
                /* url:url, */
                 localdata:datafuel,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or pagse size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                  //  alert(error);    
	                    }
			            
		            });
            
            $("#jqxgridtariffuel").jqxGrid(
            {
                width: '100%',
                height: 135,
                source: dataAdapter,
                columnsresize: true,
                rowsheight:20,
                pageable: false,
                //sortable: true,
                selectionmode: 'default',
                pagermode: 'default',
                editable:true,
               
                //Add row method
                handlekeyboardnavigation: function (event) {
                    var cell = $('#jqxgridtariffuel').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'monthly' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#jqxgridtariffuel").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    }
                },
               
                columns: [
                       
							
							{ text: 'Quarter', datafield: 'level2', width: '25%',align:'right',cellsalign:'right',cellsformat:'d2' },
							{ text: 'Half', datafield: 'level4', width: '25%',align:'right',cellsalign:'right',cellsformat:'d2'   },
							{ text: 'Tri Quarter', datafield: 'level6', width: '25%',align:'right',cellsalign:'right',cellsformat:'d2'},
							{ text: 'Full', datafield: 'level8', width: '25%',align:'right',cellsalign:'right',cellsformat:'d2'}

	              ]
            });
            //Add Row
            $("#jqxgridtariffuel").jqxGrid('addrow', null, {});
            /* Fuel Info Grid Ends */   
 });
            </script>
            <div id="jqxgridtariffuel"></div>
