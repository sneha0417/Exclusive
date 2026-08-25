<%@page import="com.controlcentre.masters.tarifmgmtnew.ClsTarifDAO" %>
<%ClsTarifDAO ctd=new ClsTarifDAO(); %>

  <%String tempdocno=request.getParameter("id");%>
  <script>
  $(document).ready(function () {
	  var urlgroup2; 
	  var temp='<%=tempdocno%>';
//alert("JS"+temp);
	 if(temp>0){
		 urlgroup2='<%=ctd.getGroup2(tempdocno)%>';
		 //alert("asd"+urlgroup2);
	 }
   var num = 1; 
              // prepare the data
              var source =
              {
                  datatype: "json",
                  datafields: [
                            	{name : 'gid' , type: 'string' },
                            	{name :'docno',type:'number'},
                            	{name : 'insurexcess',type:'number'},
         						{name : 'cdwexcess',type:'number'},
         						{name : 'scdwexcess',type:'number'},
         						{name : 'securityamt',type:'number'},
       						],
       			localdata: urlgroup2,
                  
                 
              };
              
              var dataAdapter = new $.jqx.dataAdapter(source,
              		 {
                  		loadError: function (xhr, status, error) {
  	                    //alert(error);    
  	                    }
  		            });
              
              $("#jqxgridtarifgrpfinish").jqxGrid(
              {
                  width: '100%',
                  height: 460,
                  source: dataAdapter,
                  columnsresize: false,
                  rowsheight:20,
                  
                  
                  pagesize: 25,
                  pagesizeoptions: ['25', '50', '75'],
                  //sortable: true,
                  selectionmode: 'default',
                 
           		
                 
                  //Add row method
                  handlekeyboardnavigation: function (event) {
                      var cell = $('#jqxgridtarifgrpfinish').jqxGrid('getselectedcell');
                      if (cell != undefined && cell.datafield == 'gid1' && cell.rowindex == num - 1) {
                          var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                          if (key == 13) {                                                        
                              var commit = $("#jqxgridtarifgrpfinish").jqxGrid('addrow', null, {});
                              num++;                           
                          }
                      }
                  },
                 
                  columns: [
                         
  							{ text: 'Group', datafield: 'gid', width: '100%' },
  							{ text: 'Doc', datafield: 'docno', width: '100%',hidden:true },
  							{text: 'Insur Excess',datafield:'insurexcess',width:'20%',hidden:true,cellsformat:'d2'},
							{text: 'CDW Excess',datafield:'cdwexcess',width:'20%',hidden:true,cellsformat:'d2'},
							{text: 'SCDW Excess',datafield:'scdwexcess',width:'20%',hidden:true,cellsformat:'d2'},
							{text: 'Security Amount',datafield:'securityamt',width:'20%',hidden:true,cellsformat:'d2'}
  	              ]
              });

              $('#jqxgridtarifgrpfinish').on('rowdoubleclick', function (event) 
              {
               var row1=event.args.rowindex;
            	document.getElementById("grouplabel").style.display="block";
               document.getElementById("grouplabel").innerText="Tariff of Group "+$('#jqxgridtarifgrpfinish').jqxGrid('getcellvalue', row1, "gid");
               var value=$('#jqxgridtarifgrpfinish').jqxGrid('getcellvalue', row1, "gid")==null?0:$('#jqxgridtarifgrpfinish').jqxGrid('getcellvalue', row1, "gid");
               var docno1=document.getElementById("docno").value==null?0:document.getElementById("docno").value;
               var tariftype=document.getElementById("cmbtariftype").value;
               document.getElementById("tempgroup").value=$('#jqxgridtarifgrpfinish').jqxGrid('getcellvalue', row1, "gid");
               document.getElementById("hidgroupdoc").value=$('#jqxgridtarifgrpfinish').jqxGrid('getcellvalue', row1, "docno");
              document.getElementById("tempstatus").value="0";
              document.getElementById("insurexcess").value=$('#jqxgridtarifgrpfinish').jqxGrid('getcellvalue', row1, "insurexcess");
              document.getElementById("cdwexcess").value=$('#jqxgridtarifgrpfinish').jqxGrid('getcellvalue', row1, "cdwexcess");
              document.getElementById("scdwexcess").value=$('#jqxgridtarifgrpfinish').jqxGrid('getcellvalue', row1, "scdwexcess");
              document.getElementById("securityamt").value=$('#jqxgridtarifgrpfinish').jqxGrid('getcellvalue', row1, "securityamt");
              if(tariftype.trim()=='Weekend'){
            	   $("#divweekday").load("gridWeekday.jsp?id="+document.getElementById("hidgroupdoc").value+"&doc="+docno1);
                   //$("#divfoc").load("gridFoc.jsp?id="+document.getElementById("hidgroupdoc").value+"&doc="+docno1);
               //    $("#divRegularTarif").load("gridRegularTarif.jsp");
             //      $("#jqxgridtarif").jqxGrid({ disabled: true});
            	   document.getElementById("fieldextrainsur").style.display="none";
         			document.getElementById("fieldfoc").style.display="none";
         			document.getElementById("fieldregular").style.display="none";
         			
         			document.getElementById("fieldpackage").style.display="none";
         			document.getElementById("fieldslab").style.display="none";
         			document.getElementById("fieldweekday").style.display="block";
                  
               }
              else if(tariftype.trim()=='Slab'){
            	
           	   $("#divslab").load("gridSlabTarif.jsp?id1="+document.getElementById("hidgroupdoc").value+"&doc="+docno1);
                  //$("#divfoc").load("gridFoc.jsp?id="+document.getElementById("hidgroupdoc").value+"&doc="+docno1);
                 /*  $("#divRegularTarif").load("gridRegularTarif.jsp");
                  $("#jqxgridtarif").jqxGrid({ disabled: true}); */
           	document.getElementById("fieldextrainsur").style.display="none";
  			document.getElementById("fieldfoc").style.display="none";
  			document.getElementById("fieldregular").style.display="none";
  			document.getElementById("fieldweekday").style.display="none";
  			document.getElementById("fieldpackage").style.display="none";
  			document.getElementById("fieldslab").style.display="block";
              }
              else if(tariftype.trim()=='Package'){
              	   $("#divpackage").load("gridPackageTarif.jsp?id1="+document.getElementById("hidgroupdoc").value+"&doc="+docno1);
                     //$("#divfoc").load("gridFoc.jsp?id="+document.getElementById("hidgroupdoc").value+"&doc="+docno1);
                    /*  $("#divRegularTarif").load("gridRegularTarif.jsp");
                     $("#jqxgridtarif").jqxGrid({ disabled: true}); */
              	document.getElementById("fieldextrainsur").style.display="none";
     			document.getElementById("fieldfoc").style.display="none";
     			document.getElementById("fieldregular").style.display="none";
     			document.getElementById("fieldweekday").style.display="none";
     			
     			document.getElementById("fieldslab").style.display="none";
     			document.getElementById("fieldpackage").style.display="block";    
                 }
               else if(tariftype=='FOC'){
            	   //$("#divweekday").load("gridWeekday.jsp?id="+document.getElementById("hidgroupdoc").value+"&doc="+docno1);
                   $("#divfoc").load("gridFoc.jsp?id="+document.getElementById("hidgroupdoc").value+"&doc="+docno1);
                //   $("#divRegularTarif").load("gridRegularTarif.jsp");
               //    $("#jqxgridtarif").jqxGrid({ disabled: true});
               	document.getElementById("fieldextrainsur").style.display="none";
      			document.getElementById("fieldregular").style.display="none";
      			document.getElementById("fieldweekday").style.display="none";
      			document.getElementById("fieldpackage").style.display="none";
      			document.getElementById("fieldslab").style.display="none";
      			document.getElementById("fieldfoc").style.display="block";
               }
               else if(tariftype=='Corporate'){
            	  
            	   $("#divRegularTarif").load("gridRegularTarif.jsp?id1="+document.getElementById("hidgroupdoc").value+"&doc="+docno1);
            	//	$("#jqxgridtarifweekday").jqxGrid({ disabled: true});
          			//$("#jqxgridtariffoc").jqxGrid({ disabled: true});
          				document.getElementById("fieldextrainsur").style.display="none";
          			document.getElementById("fieldweekday").style.display="none";
         			document.getElementById("fieldpackage").style.display="none";
         			document.getElementById("fieldslab").style.display="none";
         			document.getElementById("fieldfoc").style.display="none";
         		
         			 document.getElementById("fieldregular").style.display="block";

               }
               else{
            	   $("#divRegularTarif").load("gridRegularTarif.jsp?id1="+document.getElementById("hidgroupdoc").value+"&doc="+docno1);
               	//	$("#jqxgridtarifweekday").jqxGrid({ disabled: true});
             			//$("#jqxgridtariffoc").jqxGrid({ disabled: true});
             			document.getElementById("fieldweekday").style.display="none";
            			document.getElementById("fieldpackage").style.display="none";
            			document.getElementById("fieldslab").style.display="none";
            			document.getElementById("fieldfoc").style.display="none";
            			document.getElementById("fieldextrainsur").style.display="block";
            			 document.getElementById("fieldregular").style.display="block";
               }
             
              document.getElementById("btnTarifSave").style.display="none";
              document.getElementById("btnTarifEdit").style.display="block";
              
             /*  if(document.getElementById("mode").value=='view')
            	  {
            	  document.getElementById("btnTarifSave").style.display="none";
                  document.getElementById("btnTarifEdit").style.display="none";
            	  }
               */
              
            
              });
              var rows=$("#jqxgridtarifgrpfinish").jqxGrid("getrows");
              var rowcount=rows.length;
              if(rowcount==0){
            	  $("#jqxgridtarifgrpfinish").jqxGrid("addrow", null, {});  
              }
              
            
  });
	
              </script>
              <div id="jqxgridtarifgrpfinish"></div>
