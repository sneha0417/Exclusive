<%@page import="com.controlcentre.masters.vehiclemaster.vehicle.ClsVehicleDAO" %>
<%ClsVehicleDAO cvd=new ClsVehicleDAO(); %>

   <%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
   
<%	System.out.println("Here Doc In Grid"+request.getParameter("docno1")+"==="+request.getParameter("aaa"));
	String aaa=request.getParameter("aaa")==null?"0":request.getParameter("aaa").toString();
	String docno=request.getParameter("docno1")==null?"0":request.getParameter("docno1").toString();
	System.out.println("Here Doc In Grid"+docno);
%>
<script type="text/javascript">
        $(document).ready(function () { 
        	var specdata;
        	//var url = "specification.txt";
             var num = 0; 
      // alert("docno"+document.getElementById("docno").value);
                  //   if((document.getElementById("docno").value>0)){
      // alert((document.getElementById("docno").value>0));
                    	 specdata='<%=cvd.getSpecdetails(docno)%>';
               //      }
       //              alert(specdata);
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'name', type: 'string'  },
     						{name : 'description', type: 'string'   },
     						{name : 'doc_no',type:'number'}
                 ],
                 localdata: specdata,
                
                
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

            
            
            $("#jqxSpecification").jqxGrid(
            {
                width: '85%',
                height: 315,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                //editable: true,
                altRows: true,
                /* showfilterrow: true, */
                /* filterable: true, */ 
                sortable: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                    var cell = $('#jqxSpecification').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'DESCRIPTION' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#jqxSpecification").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    }
                },
                
                       
                columns: [
							{ text: 'Sr. No.',datafield: '',columntype:'number', width: '5%', cellsrenderer: function (row, column, value) {
	                               return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                            }   },	
                            { text:'Doc No',datafield:'doc_no',width:'25%',hidden:true},
							{ text: 'Name', datafield: 'name', width: '25%' },			
							{ text: 'Description', datafield: 'description', width: '70%' }					
			              ]
            });
            $("#jqxSpecification").on("rowdoubleclick", function (event) {
            	//alert("here");
                var row1=event.args.rowindex;
                //alert(row1);
					document.getElementById("specrow").value=row1;              
                	$('#specwindow').jqxWindow('open');
              		$('#specwindow').jqxWindow('focus');
               	  specSearchContent('specSearch.jsp?', $('#specwindow'));
              
                });
            $("#jqxSpecification").jqxGrid("addrow", null, {});

        });
    </script>
    <div id="jqxSpecification"></div>
    <input type="hidden" name="specrow" id="specrow">
