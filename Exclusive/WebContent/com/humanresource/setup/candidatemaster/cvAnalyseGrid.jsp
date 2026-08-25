<%@page import="com.humanresource.setup.candidatemaster.ClsCandidateMasterDAO"%>
<%ClsCandidateMasterDAO DAO= new ClsCandidateMasterDAO(); %>
<% String mode = request.getParameter("mode")==null?"view":request.getParameter("mode");%>
<% String docNo = request.getParameter("docno")==null?"0":request.getParameter("docno"); %>
<style type="text/css">
  .statutoryDeductionClass
  {
      background-color: #FDF9EF;
  }
</style>
<script type="text/javascript">
		var tempMode='<%=mode%>';
		var tempDocNo='<%=docNo%>';
		var temp='0';
		
		var data1;
		
        $(document).ready(function () { 	
        	
        	 <%-- if(tempDocNo>0 && tempMode=='E') {
         		 
         		data1='<%=DAO.allowanceEditReloading(docNo)%>';
         		
         	 } else  --%>
         	 if(tempDocNo>0) {
          		data1='<%=DAO.cvGridReloading(docNo)%>';
          		
          	 } else {
         		 
         		 temp='1';
         	 }
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'questions', type: 'string' },
     						{name : 'remarks', type: 'string' },
     						{name : 'grade', type: 'string'   }
                        ],
                		 localdata: data1, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dropdownListSource=['Excellent','Good','Average','Poor'];
            
            var dataAdapter = new $.jqx.dataAdapter(source,{
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			         });

            
            $("#cvAnalyseGridID").jqxGrid(
            {
            	width: '100%',
                height: 250,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                handlekeyboardnavigation: function (event) {
                    var cell = $('#cvAnalyseGridID').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'grade') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 9) {                                                        
                            $("#cvAnalyseGridID").jqxGrid('addrow', null, {});
                            return true;                         
                        }
                    }
                    
                }, 
                
                columns: [
							{ text: 'S#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }    
							},
							{ text: 'Questions', datafield: 'questions',  width: '40%' },
							{ text: 'Remarks', datafield: 'remarks',  width: '40%'},			
							{ text: 'Grade', datafield: 'grade', width: '15%',columntype: 'dropdownlist',
								initeditor: function (row, cellvalue, editor) {
			                          editor.jqxDropDownList({ source: dropdownListSource});
								}
							},	
						]
            });

            //Add empty row
            if(temp=='1'){
           	   $("#cvAnalyseGridID").jqxGrid('addrow', null, {});
             }
            
            if(tempDocNo>0 && tempMode=='view'){
            	$("#cvAnalyseGridID").jqxGrid('disabled', true);
            }
            
           
            
        });
    </script>
    <div id="cvAnalyseGridID"></div>
 