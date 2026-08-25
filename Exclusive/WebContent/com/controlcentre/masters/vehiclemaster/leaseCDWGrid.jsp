<%@page import="com.controlcentre.masters.vehiclemaster.leasecdw.*" %>
<%ClsLeaseCDWDAO cdwdao=new ClsLeaseCDWDAO();%>
<script>
$(document).ready(function(){

var leasedata='<%=cdwdao.getSearchData()%>'; 


		
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'name', type: 'String'  },
                          	{name : 'date', type: 'date'  },
							{name : 'chkreplace',type:'string'},
							{name : 'remarks',type:'string'},
							{name : 'description',type:'string'},
							{name : 'excesscdw',type:'string'},
                 ],
               localdata: leasedata,
                //url: "/searchDetails",
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                   // alert(error);    
	                    }
		            }		
            );
    
            $("#leaseCDWGrid").jqxGrid(
                    {
                    	width: '100%',
                    	height:300,
                        source: dataAdapter,
                        showfilterrow: true,
                        filterable: true,
                        selectionmode: 'singlerow',
                        //Add row method
                        columns: [
        					{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
        					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
							{ text: 'Name',columntype: 'textbox', filtertype: 'input', datafield: 'name', width: '30%' },
							{ text: 'Replacement',datafield:'chkreplace',width:'5%',hidden:true},
							{ text: 'Description',datafield:'description',width:'50%',columntype: 'textbox', filtertype: 'input'},
							{ text: 'Remarks',datafield:'remarks',width:'10%',hidden:true},
							{ text: 'Excescdw',datafield:'excesscdw',width:'5%',hidden:true},
        					
        	              ]
                    });
            $('#leaseCDWGrid').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#leaseCDWGrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("name").value = $("#leaseCDWGrid").jqxGrid('getcellvalue', rowindex1, "name");
				document.getElementById("remarks").value = $("#leaseCDWGrid").jqxGrid('getcellvalue', rowindex1, "remarks");
				document.getElementById("description").value = $("#leaseCDWGrid").jqxGrid('getcellvalue', rowindex1, "description");
                $("#date").jqxDateTimeInput('val', $("#leaseCDWGrid").jqxGrid('getcellvalue', rowindex1, "date"));
                if($("#leaseCDWGrid").jqxGrid('getcellvalue', rowindex1, "chkreplace")=="1"){
                	document.getElementById("chkreplace").checked=true;
                	document.getElementById("hidchkreplace").value="1";
                }
                else{
                	document.getElementById("chkreplace").checked=false;
                	document.getElementById("hidchkreplace").value="0";
                }
                if($("#leaseCDWGrid").jqxGrid('getcellvalue', rowindex1, "excesscdw")=="1"){
                	document.getElementById("chkexscdw").checked=true;
                	document.getElementById("hidchkexscdw").value="1";
                }
                else{
                	document.getElementById("chkexscdw").checked=false;
                	document.getElementById("hidchkexscdw").value="0";
                }
                //document.getElementById("search").style.display="none";
               
                // 
            }); 
});
            </script>
            <div id="leaseCDWGrid"></div>