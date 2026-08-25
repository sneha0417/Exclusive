<%@page import="com.project.execution.callRegister.ClsCallRegisterDAO"%>
<% ClsCallRegisterDAO DAO= new ClsCallRegisterDAO(); %>
<% String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno");
   String docNo = request.getParameter("docno")==null?"0":request.getParameter("docno"); %>  

<style type="text/css">
        .blueClass
        {
            background-color: #E0ECF8;
        }
        .whiteClass
        {
           background-color: #fff;
        }
</style>

<script type="text/javascript">

	    var data= '<%=DAO.contractDetailsGridLoading(cldocno) %>';
	    
        $(document).ready(function () { 
        	
        	var temp='<%=docNo%>';
        	
        	// prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							
     						{name : 'reftype', type: 'string' },
     						{name : 'refdocno', type: 'string'   },
     						{name : 'stdate', type: 'date'  },
     						{name : 'enddate', type: 'date'  },
     						{name : 'project', type: 'string'  },
     						{name : 'projectname', type: 'string'  },
     						{name : 'costid', type: 'string'   },
     						{name : 'refno', type: 'string'   }
     					     						  											
                 ],
                 localdata: data, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
        	
            var cellclassname = function (row, column, value, data) {
        		if (data.project == '0') {
                    return "blueClass";
                } else{
                	return "whiteClass";
                };
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			            
		            } );

            
            
            $("#contractDetailsGridID").jqxGrid(
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
						  { text: 'No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Doc. Type', datafield: 'reftype', width: '14%' },	
							{ text: 'Doc. No.', datafield: 'refdocno', width: '15%' },	
							{ text: 'Start Date', datafield: 'stdate', cellsformat: 'dd.MM.yyyy', width: '15%' },	
							{ text: 'End date', datafield: 'enddate', cellsformat: 'dd.MM.yyyy', width: '15%' },
							{ text: 'Ref. Type', datafield: 'project', width: '15%' },
							{ text: 'Ref. No.', datafield: 'projectname', width: '20%' },
							{ text: 'Ref. TRNo.', datafield: 'costid', hidden: true, width: '10%' },
							{ text: 'Ref. No.', datafield: 'refno', hidden: true, width: '10%' },
							
						 ]
            });
            
            if(temp>0){
            	$("#contractDetailsGridID").jqxGrid('disabled', true);
            }
            
            $('#contractDetailsGridID').on('rowdoubleclick', function (event) {
	              var rowindex1 = event.args.rowindex;
	              document.getElementById("cmbcontracttype").value= $('#contractDetailsGridID').jqxGrid('getcellvalue', rowindex1, "reftype");
	              document.getElementById("txtcontractno").value= $('#contractDetailsGridID').jqxGrid('getcellvalue', rowindex1, "refdocno");
	              document.getElementById("txtcontracttrno").value= $('#contractDetailsGridID').jqxGrid('getcellvalue', rowindex1, "costid");
	              document.getElementById("txtcontractdetails").value= $('#contractDetailsGridID').jqxGrid('getcellvalue', rowindex1, "refno");
	              $('#txtsite').val('');$('#txtsiteid').val('');
	      		  if (document.getElementById("txtsite").value == "") {
	      	        $('#txtsite').attr('placeholder', 'Press F3 to Search'); 
	      	      }
	      		
            }); 
            
        });

</script>

<div id="contractDetailsGridID"></div>

 