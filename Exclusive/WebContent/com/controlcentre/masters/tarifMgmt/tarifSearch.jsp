<%@page import="com.controlcentre.masters.tarifmgmt.ClsTarifDAO" %>
<%ClsTarifDAO ctd=new ClsTarifDAO(); %>

<script type="text/javascript">
/* $('#frmTariffManagement select').attr('disabled', false);  */
      var data8= '<%=ctd.mainSearchList()%>';
  
  
        $(document).ready(function () { 	
            

            //var url="demo.txt"; 
        	var num = 0;
            var source =
            {
                datatype: "json",
                datafields: [
                             
                          	{name : 'docno' , type: 'int' },
     						{name : 'date', type: 'String'  },
     						{name : 'tariftype', type: 'String'  },
     						{name : 'tariffor', type:'String'},
     						{name : 'fromdate', type:'String'},
     						{name : 'todate', type:'String'},
     						{name : 'notes', type:'String'},
     						{name : 'clientid', type:'String'},
     						{name : 'clientname', type: 'String'},
     						
                 ],
                localdata: data8,
                //url: url,
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
            $("#tarifSearch").jqxGrid(
            {
                width: '100%',
                height: 372,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                //sortable: true,
                selectionmode: 'singlerow',
                filterable:true,
                showfilterrow:true,
                //Add row method
                columns: [
							{ text: 'Doc No', datafield: 'docno', width: '8%' },
							{ text: 'Date', datafield: 'date', width: '60%',cellsformat:'dd.MM.yyyy',hidden:true },
							{ text: 'Tarif Type', datafield: 'tariftype', width: '20%' },
							{ text: 'Tarif For', datafield: 'tariffor', width:'20%',hidden:true},
							{ text: 'From Date', datafield: 'fromdate', width:'20%',cellsformat:'dd.MM.yyyy'},
							{ text: 'To Date', datafield: 'todate', width:'20%',cellsformat:'dd.MM.yyyy'},
							{ text: 'Notes', datafield:'notes',width:'32%'},
							{text: 'Client Id',datafield:'clientid',width:'20%',hidden:true},
							{text: 'Client Name',datafield:'clientname',width:'20%',hidden:true},
							
	              ]
            });
           
            $('#tarifSearch').on('rowdoubleclick', function (event) {
            	var temp00="";
            	var temp01=0;
            	var rowindex1=event.args.rowindex;
            	$('#jqxTariffFromDate').jqxDateTimeInput({ disabled: false});
        		$('#jqxTariffToDate').jqxDateTimeInput({ disabled: false});
        		$('#jqxTariffDate').jqxDateTimeInput({ disabled: false});
                document.getElementById("docno").value= $('#tarifSearch').jqxGrid('getcellvalue', rowindex1, "docno");
                var docno1=document.getElementById("docno").value==null?0:document.getElementById("docno").value;
                $("#jqxTariffDate").jqxDateTimeInput('val',$("#tarifSearch").jqxGrid('getcellvalue', rowindex1, "date"));
                $("#jqxTariffFromDate").jqxDateTimeInput('val',$("#tarifSearch").jqxGrid('getcellvalue', rowindex1, "fromdate"));
                $("#jqxTariffToDate").jqxDateTimeInput('val',$("#tarifSearch").jqxGrid('getcellvalue', rowindex1, "todate"));
                $('#cmbtariftype').val($("#tarifSearch").jqxGrid('getcellvalue', rowindex1, "tariftype")) ;
                $('#cmbtariffor').val($("#tarifSearch").jqxGrid('getcellvalue', rowindex1, "tariffor")) ;
           		
                if($('#tarifSearch').jqxGrid('getcellvalue', rowindex1, "clientname")=="undefined" ||$('#tarifSearch').jqxGrid('getcellvalue', rowindex1, "clientname")==null){
                	temp00="";
                }
                else{
                	temp00=$('#tarifSearch').jqxGrid('getcellvalue', rowindex1, "clientname");
                }
                if($('#tarifSearch').jqxGrid('getcellvalue', rowindex1, "clientid")=="undefined" ||$('#tarifSearch').jqxGrid('getcellvalue', rowindex1, "clientid")==null){
                	temp01=0;
                }
                else{
                	temp01=$('#tarifSearch').jqxGrid('getcellvalue', rowindex1, "clientid");
                }
                document.getElementById("txtclient").value=temp00;
                document.getElementById("hidtxtclient").value=temp01;
                 document.getElementById("notes").innerHTML=$("#tarifSearch").jqxGrid('getcellvalue', rowindex1, "notes") ;
                 $("#divgroup1").load("gridgroup1.jsp?id="+docno1);
                 $("#divgroup2").load("gridgroup2.jsp?id="+docno1);
                 $("#divRegularTarif").load("gridRegularTarif.jsp");
    			 $("#divfoc").load("gridFoc.jsp");
          		 $("#divweekday").load("gridWeekday.jsp");
                 document.getElementById("grouplabel").style.display="none";
                 document.getElementById("btnTarifEdit").style.display="none";
                 document.getElementById("btnTarifSave").style.display="none";
                 $('#jqxTariffFromDate').jqxDateTimeInput({ disabled: true});
         		$('#jqxTariffToDate').jqxDateTimeInput({ disabled: true});
         		$('#jqxTariffDate').jqxDateTimeInput({ disabled: true});
         	/* 	if(document.getElementById("docno").value>0){
         			document.getElementById("btnTarifEdit").style.display="block";
         		} */    
         		if(document.getElementById("cmbtariftype").value=="Weekend"){
    				document.getElementById("fieldweekday").style.display="block";
    	  			document.getElementById("fieldfoc").style.display="none";
    			}
    			if(document.getElementById("cmbtariftype").value=="FOC"){
    				document.getElementById("fieldweekday").style.display="none";
    	  			document.getElementById("fieldfoc").style.display="block";
    			}
         		if((!(document.getElementById("cmbtariftype").value=='Client')) && (!(document.getElementById("cmbtariftype").value=='Corporate'))){
                	
         			document.getElementById("txtclient").value="";
                }
                 $('#window').jqxWindow('close');
                // $( "#docno" ).focus();
                
            });  
        });
    </script>
    <div id="tarifSearch"></div>
