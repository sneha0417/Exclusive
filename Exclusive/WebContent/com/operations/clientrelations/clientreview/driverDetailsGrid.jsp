<%@page import="com.operations.clientrelations.clientreview.ClsClientReviewDAO" %>
<% ClsClientReviewDAO DAO=new ClsClientReviewDAO(); %>
<% String contextPath=request.getContextPath();%>
<% String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno"); %> 

<style type="text/css">
        .redClass
        {
            background-color: #FFEBEB;
        }
        .yellowClass
        {
            background-color: #FFFFD1;
        }
        .whiteClass
        {
           background-color: #fff;
        }
</style>

<script type="text/javascript">

	    var data3= '<%=DAO.driverLoading(cldocno) %>';

        $(document).ready(function () { 
        	
        	// prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							
     						{name : 'name', type: 'string'  },
     						{name : 'dob', type: 'date'    },
     						{name : 'nation', type: 'string'    },
     						{name : 'mobno', type: 'string'    },
     						{name : 'dlno', type: 'string'    },
     						{name : 'ltype', type: 'string' },
     						{name : 'issfrm', type: 'string' },
     						{name : 'issdate', type: 'date'    },
     						{name : 'led', type: 'date' },
							{name : 'hcdlno', type: 'string'    },
     						{name : 'hcissdate', type: 'date'    }, 
     						{name : 'hcled', type: 'date'    }, 
     						{name : 'passport_no', type: 'string'    },
     						{name : 'pass_exp', type: 'date'    },     						     						
     						{name : 'visano', type: 'string' },
     						{name : 'visa_exp', type: 'date' },
     						{name : 'attachbtn', type: 'String'  },
     						{name : 'doc_no', type: 'int' },
     						{name : 'dr_id', type: 'int'  },
     						{name : 'expired', type: 'string'  }
     					     						  											
                 ],
                 localdata: data3, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
        	
            $("#driverGridID").on("bindingcomplete", function (event) {
            	var temp=document.getElementById("mode").value;
            	var drid = $('#driverGridID').jqxGrid('getcellvalue', 0, "dr_id");
            	
			    if (temp !="view" && drid!="" || drid==null){
            		$('#driverGridID').jqxGrid('hidecolumn', 'attachbtn');
					$("#driverGridID").jqxGrid('hidecolumn', 'hcdlno');
	    			$("#driverGridID").jqxGrid('hidecolumn', 'hcissdate');
	    			$("#driverGridID").jqxGrid('hidecolumn', 'hcled');
			    }
                
				var rows = $("#driverGridID").jqxGrid('getrows');
					 for(var i=0 ; i < rows.length ; i++){
						 var value = $('#driverGridID').jqxGrid('getcellvalue', i, "ltype"); 
						 var idpinfo=document.getElementById("idpdetailsallowed").value;
					     if(value == "IDP" && parseInt(idpinfo)==0){
							 $("#driverGridID").jqxGrid('showcolumn', 'hcdlno');
				    	     $("#driverGridID").jqxGrid('showcolumn', 'hcissdate');
				    		 $("#driverGridID").jqxGrid('showcolumn', 'hcled');
				    		 break;
						 }else if(value != "IDP" && parseInt(idpinfo)==1){
							 $("#driverGridID").jqxGrid('hidecolumn', 'hcdlno');
				    		 $("#driverGridID").jqxGrid('hidecolumn', 'hcissdate');
				    		 $("#driverGridID").jqxGrid('hidecolumn', 'hcled'); 
						 }
					 }
            });
            
            var cellclassname = function (row, column, value, data) {
        		if (data.expired == 'PASSPORT EXPIRED') {
                    return "yellowClass";
                } else if (data.expired == 'LICENCE EXPIRED') {
                    return "redClass";
                } else {
                	return "whiteClass";
                };
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			            
		            } );

            
            
            $("#driverGridID").jqxGrid(
            {
            	width: '100%',
                height: 120,
                source: dataAdapter,
                columnsresize: true,
                editable: false,
                sortable: true,
                rowsheight:25,
                selectionmode: 'singlerow',
                localization: {thousandsSeparator: ""},
                
                columns: [
						    { text: 'Name', datafield: 'name', cellclassname: cellclassname, width: '10%'},
							{ text: 'Date of Birth', datafield: 'dob', cellclassname: cellclassname, cellsformat: 'dd.MM.yyyy', width: '6%'},
			                { text: 'Nationality', datafield: 'nation', cellclassname: cellclassname, width: '6%'},
			                { text: 'Mob No', datafield: 'mobno', cellclassname: cellclassname, width: '6%'},
			                { text: 'Licence#', datafield: 'dlno', cellclassname: cellclassname, width: '6%'},
							{ text: 'Lic Type', datafield: 'ltype', cellclassname: cellclassname, width: '6%'},
							{ text: 'Iss From', datafield: 'issfrm', cellclassname: cellclassname, width: '6%'},
							{ text: 'Lic Issued', datafield: 'issdate', cellclassname: cellclassname, cellsformat: 'dd.MM.yyyy', width: '6%'},
							{ text: 'Lic Expiry', datafield: 'led', cellclassname: cellclassname, cellsformat: 'dd.MM.yyyy', width: '6%'},
							{ text: 'HC Licence#', datafield: 'hcdlno', cellclassname: cellclassname, width: '6%'},
							{ text: 'HC Lic Issued', datafield: 'hcissdate', cellclassname: cellclassname, cellsformat: 'dd.MM.yyyy', width: '6%'},
							{ text: 'HC Lic Expiry', datafield: 'hcled', cellclassname: cellclassname, cellsformat: 'dd.MM.yyyy', width: '6%'},
							{ text: 'Passport#', datafield: 'passport_no', cellclassname: cellclassname, width: '6%'},
							{ text: 'Pass Exp.', datafield: 'pass_exp', cellclassname: cellclassname, cellsformat: 'dd.MM.yyyy', width: '6%'},
							{ text: 'ID#', datafield: 'visano', cellclassname: cellclassname, width: '6%' },
							{ text: 'ID Exp.', datafield: 'visa_exp', cellclassname: cellclassname, cellsformat: 'dd.MM.yyyy', width: '6%'},
							{ text: 'Expired', datafield: 'expired', cellclassname: cellclassname },
							{ text: ' ', datafield: 'attachbtn', width: '6%', columntype: 'button', editable:false, filterable: false}, 
							{ text: 'Hid-Doc No', datafield: 'doc_no', hidden: true,  width: '10%' },
							{ text: 'Hid-Driver Id', datafield: 'dr_id', hidden: true,  width: '10%' },
							
						 ]
            });
            
              $("#driverGridID").on('cellclick', function (event) {
          	    var datafield = event.args.datafield;
          	    var rowBoundIndex = event.args.rowindex;
        			 if(datafield=="attachbtn"){
                  		 document.getElementById("hiddrid").value=$('#driverGridID').jqxGrid('getcellvalue',rowBoundIndex, "dr_id");
                  		 document.getElementById("hiddriver").value=$('#driverGridID').jqxGrid('getcellvalue',rowBoundIndex, "name");
                  		 funAttachedBtn();
        			 }
          		}); 
         	  
          });
          
      function funAttachedBtn(){
          	
        	    $("#windowattach").jqxWindow('setTitle', document.getElementById("hiddriver").value+" - CRW - "+document.getElementById("txtcldocno").value);
        		changeAttachContent("<%=contextPath%>/com/common/multiAttach.jsp?formCode=CRM&docno="+document.getElementById("txtcldocno").value+"&barchvals="+document.getElementById("brchName").value+"&drid="+document.getElementById("hiddrid").value);		
        	
        }
        
</script>
<div id="driverGridID"></div>
<input type="hidden" id="hiddrid" name="hiddrid">
<input type="hidden" id="hiddriver" name="hiddriver">