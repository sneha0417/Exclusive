<%@page import="com.common.ClsCostCenter"%>
<% ClsCostCenter DAO= new ClsCostCenter(); %>
<% String dtype1 = request.getParameter("costtype").toString();%> 
<script type="text/javascript">
  
var costcode= '<%=DAO.costCodeSearch(dtype1) %>';

  	 $(document).ready(function () { 	
        var costtype='<%=dtype1%>';
		
            var source =
            {
                datatype: "json",  
                datafields: [
							{name : 'doc_no', type: 'string'  },
							{name : 'reg_no', type: 'string'  },
                            {name : 'code', type: 'string'  },
                            {name : 'jobno', type: 'string'  },
                            {name : 'project', type: 'string'  },
                            {name : 'name', type: 'string'  }
                        ],
                      localdata: costcode,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }                          
            };
         
		    $("#costcodeSearch").on("bindingcomplete", function (event) {
		    	$('#costcodeSearch').jqxGrid('hidecolumn', 'jobno');
		    	$('#costcodeSearch').jqxGrid('hidecolumn', 'project');
			    
		    	if (costtype !="6"){
            		$('#costcodeSearch').jqxGrid('hidecolumn', 'reg_no');
			    } 
		    	
		    	if (costtype =="7"){
            		$('#costcodeSearch').jqxGrid('showcolumn', 'jobno');
            		$('#costcodeSearch').jqxGrid('showcolumn', 'project');
			    }
            });
			
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#costcodeSearch").jqxGrid(
            {
                width: '100%',
                height: 375,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                columnsresize : true,
                selectionmode: 'singlerow',
                       
                columns: [
                              { text: 'Docno', datafield: 'doc_no', width: '20%', hidden: true},
							  { text: 'Reg No.', datafield: 'reg_no', width: '20%'},
                              { text: 'Cost Code', datafield: 'code', width: '20%'},
                              { text: 'Job No', datafield: 'jobno', width: '15%'},
                              { text: 'Project', datafield: 'project', width: '15%'},
                              { text: 'Cost Description', datafield: 'name' },
						]
            });
            
           $('#costcodeSearch').on('rowdoubleclick', function (event) {
                var rowindex2 = event.args.rowindex;
                
                if($('#txtorgridclick').val()=='1') {
	                 document.getElementById("txtprojectid").value = $('#costcodeSearch').jqxGrid('getcellvalue', rowindex2, "code");
	            	 document.getElementById("txtprojectidname").value = $('#costcodeSearch').jqxGrid('getcellvalue', rowindex2, "name");
                } else if($('#txtorgridclick').val()=='2') {
		             var rowindex1 =$('#rowindex').val();
		             $('#timeSheetReviewGridID').jqxGrid('setcellvalue', rowindex1, "costcode" ,$('#costcodeSearch').jqxGrid('getcellvalue', rowindex2, "code"));
		             $('#timeSheetReviewGridID').jqxGrid('setcellvalue', rowindex1, "costcodename" ,$('#costcodeSearch').jqxGrid('getcellvalue', rowindex2, "name"));
                } 
                
                $('#costCodeSearchWindow').jqxWindow('close'); 
            });  
        });
    </script>
    <div id="costcodeSearch"></div> 