<%--  <jsp:include page="../../../../includes.jsp"></jsp:include> --%>

 <script type="text/javascript">
        <%-- var data= '<%=com.operations.clientrelations.client.ClsClientAction.driver()%>'; --%>
        $(document).ready(function () { 	
         var data;
             var num = 68; 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [                          	
     						{name : 'name', type: 'string'  },
     						{name : 'dob', type: 'date'    },
     						{name : 'nation', type: 'string'    },
     						/* {name : 'EMID', type: 'int'    }, */
     						{name : 'mobno', type: 'string'    },
     						{name : 'passport_no', type: 'string'    },
     						{name : 'pass_exp', type: 'date'    },
     						{name : 'dlno', type: 'string'    },
     						{name : 'issdate', type: 'date'    },
     						{name : 'issfrm', type: 'string'    },
     						{name : 'led', type: 'date'    },
     						{name : 'ltype', type: 'string'    },     						
     						{name : 'visano', type: 'string'    },
     						{name : 'visa_exp', type: 'date'    }
     								
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

            
            
            $("#drivergrid").jqxGrid(
            {
                width: '95%',
                height: 300,
                source: dataAdapter,
                columnsresize: true,
                pageable: true,
                editable: true,
                altRows: true,
                /* showfilterrow: true, */
                /* filterable: true, */ 
                sortable: true,
                selectionmode: 'singlecell',
                pagermode: 'default',
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                    var cell = $('#drivergrid').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'visa_exp' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#drivergrid").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    }
                },
                
                //Filter
                /* ready: function () {
                    addfilter();
                }, */
                
                
                columns: [							
							{ text: 'Name', datafield: 'name', width: '10%' },
							{ text: 'Date of Birth', datafield: 'dob', width: '12%',columntype:'datetimeinput',cellsformat:'dd-MM-yyyy' },
							{ text: 'Nationality', datafield: 'nation', width: '10%' },
							{ text: 'Mob No', datafield: 'mobno', width: '15%' },
							/* { text: 'EMID', datafield: 'EMID', width: '15%' }, */
							{ text: 'Passport#', datafield: 'passport_no', width: '10%' },
							{ text: 'Pass Exp.', datafield: 'pass_exp', width: '12%',columntype:'datetimeinput',cellsformat:'dd-MM-yyyy' },
							{ text: 'Licence#', datafield: 'dlno', width: '10%' },
							{ text: 'Lic Issued', datafield: 'issdate', width: '12%',columntype:'datetimeinput',cellsformat:'dd-MM-yyyy' },
							{ text: 'Iss From', datafield: 'issfrm', width: '12%' },
							{ text: 'Lic Expiry', datafield: 'led', width: '12%' },
							{ text: 'Lic Type', datafield: 'ltype', width: '15%' },														
							{ text: 'Visa#', datafield: 'visano', width: '10%' },
							{ text: 'Visa Exp.#', datafield: 'visa_exp', width: '12%',columntype:'datetimeinput',cellsformat:'dd-MM-yyyy' }							
	              ]
            });
            $("#drivergrid").jqxGrid('addrow', null, {});
            $("#drivergrid").on('cellendedit', function (event) 
            		{
            	var cellno=event.args.rowindex;
            	var datacell=event.args.datafield;
            	if(datacell=="mobno"){
                    var mobivalue = event.args.value;    
                  //  alert(mobivalue.length);
                    /* var phoneno = /^\d{12}$/;  
                    if(mobivalue.match(phoneno)){ 
                    $("#drivergrid").jqxGrid('hidevalidationpopups');
                     return true;  
                    }
                    else  
                    {  
                    $("#drivergrid").jqxGrid('showvalidationpopup', cellno, "mobno", "Invalid Mobile Number");
                    return false;  
                    }
                    $("#drivergrid").jqxGrid('hidevalidationpopups');
                    return true;  
                    } */
            		});
        });
    </script>
    <div id="drivergrid"></div>
 
