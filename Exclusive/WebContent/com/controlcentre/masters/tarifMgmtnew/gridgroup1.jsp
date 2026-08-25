<%@page import="com.controlcentre.masters.tarifmgmtnew.ClsTarifDAO" %>
<%ClsTarifDAO ctd=new ClsTarifDAO(); %>

 <%
 	String docno=request.getParameter("id");
 %>
 <script>
 $(document).ready(function () { 
var urlgroup1;
// alert("DOCNO"+document.getElementById("docno").value);
if(document.getElementById("docno").value==''){
	urlgroup1='<%=ctd.getNewGroup()%>';
}
else{
	urlgroup1='<%=ctd.getGroup1(docno)%>';
}
	
 var num = 1; 
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'gid' , type: 'string' },
                          	{name :'doc_no',type:'number'}
     						],
     			localdata: urlgroup1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or pagse size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                 //   alert(error);    
	                    }
		            });
            
            $("#jqxgridtarifgrp").jqxGrid(
            {
                width: '100%',
                height: 460,
                source: dataAdapter,
                columnsresize: false,
                rowsheight:20,
                pageable: false,
                pagesize: 25,
                pagesizeoptions: ['25', '50', '75'],
                //sortable: true,
                selectionmode: 'single',
                pagermode: 'default',
               
               
                //Add row method
                handlekeyboardnavigation: function (event) {
                    var cell = $('#jqxgridtarifgrp').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'group' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#jqxgridtarifgrp").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    }
                },
               
                columns: [
                       
							{ text: 'Group', datafield: 'gid', width: '100%' },
							{text:'Doc',datafield:'doc_no',width:'100%',hidden:true}
	              ]
            });
            var rows=$("#jqxgridtarifgrp").jqxGrid('getrows');
            if(rows.length==0){
            	$("#jqxgridtarifgrp").jqxGrid("addrow", null, {});
            }
         
         //Row Double Click
         $('#jqxgridtarifgrp').on('rowdoubleclick', function (event) 
              {
           
          	var row2=event.args.rowindex;
          	 $("#divRegularTarif").load("gridRegularTarif.jsp");
          	 $("#divfoc").load("gridFoc.jsp");
          	 $("#divweekday").load("gridWeekday.jsp");
          	 $("#divslab").load("gridSlabTarif.jsp");
          	 $("#divpackage").load("gridPackageTarif.jsp");
          	if(document.getElementById("docno").value==''){
          		return false;
          	}
          	var tariftype=document.getElementById("cmbtariftype").value;
          	 if(tariftype=='Weekend'){
          	   
          		document.getElementById("fieldextrainsur").style.display="none";
      			document.getElementById("fieldfoc").style.display="none";
      			document.getElementById("fieldregular").style.display="none";
      			document.getElementById("fieldpackage").style.display="none";
      			document.getElementById("fieldslab").style.display="none";
      			document.getElementById("fieldweekday").style.display="block";
                
             }
          	 else if(tariftype=='Slab'){
          		document.getElementById("fieldextrainsur").style.display="none";
      			document.getElementById("fieldfoc").style.display="none";
      			document.getElementById("fieldregular").style.display="none";
      			document.getElementById("fieldpackage").style.display="none";
      		document.getElementById("fieldweekday").style.display="none";
      		document.getElementById("fieldslab").style.display="block";
               
            }
          	 else if(tariftype=='Package'){
           	   
          		document.getElementById("fieldextrainsur").style.display="none";
      			document.getElementById("fieldfoc").style.display="none";
      			document.getElementById("fieldregular").style.display="none";
      			document.getElementById("fieldslab").style.display="none";
      			document.getElementById("fieldweekday").style.display="none";
      			document.getElementById("fieldpackage").style.display="block";
               
            }
             else if(tariftype=='FOC'){
          	   
            	 document.getElementById("fieldextrainsur").style.display="none";
       			document.getElementById("fieldregular").style.display="none";
       			document.getElementById("fieldslab").style.display="none";
       			document.getElementById("fieldweekday").style.display="none";
       			document.getElementById("fieldpackage").style.display="none";
       			document.getElementById("fieldfoc").style.display="block";
             }
             else if(tariftype=='Corporate'){
            	   
            	 document.getElementById("fieldslab").style.display="none";
     			document.getElementById("fieldweekday").style.display="none";
     			document.getElementById("fieldpackage").style.display="none";
     			document.getElementById("fieldfoc").style.display="none";
     			document.getElementById("fieldregular").style.display="block";
             }
             else{
          	 		document.getElementById("fieldslab").style.display="none";
        			document.getElementById("fieldweekday").style.display="none";
        			document.getElementById("fieldpackage").style.display="none";
        			document.getElementById("fieldfoc").style.display="none";
        			 document.getElementById("fieldextrainsur").style.display="block";
         			document.getElementById("fieldregular").style.display="block";

             }
          	var value2=$('#jqxgridtarifgrp').jqxGrid('getcellvalue', row2, "gid");
          	document.getElementById("grouplabel").style.display="block";
          	document.getElementById("grouplabel").innerText="Tariff of "+value2;
          	document.getElementById("tempgroup").value=value2;
          	document.getElementById("hidgroupdoc").value=$('#jqxgridtarifgrp').jqxGrid('getcellvalue', row2, "doc_no");
          //	alert(document.getElementById("hidgroupdoc").value);
          	var doctemp=document.getElementById("docno").value;
          	var tariftype=document.getElementById("cmbtariftype").value;
          document.getElementById("tempstatus").value="1";
          document.getElementById("btnTarifSave").style.display="none";
          document.getElementById("btnTarifEdit").style.display="block";
          document.getElementById("insurexcess").value="";
          document.getElementById("cdwexcess").value="";
          document.getElementById("scdwexcess").value="";
          document.getElementById("securityamt").value="";
          	}); 
   
	});

          	</script>
          	<div id="jqxgridtarifgrp"></div>