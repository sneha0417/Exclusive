<%@page import="com.dashboard.client.paymentfollowup.ClsPaymentFollowUpDAO"%>
<%ClsPaymentFollowUpDAO DAO= new ClsPaymentFollowUpDAO(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String uptodate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate").trim();
	 String clientaccount = request.getParameter("clientaccount")==null?"0":request.getParameter("clientaccount").trim();
     String chkfollowup = request.getParameter("chkfollowup")==null?"0":request.getParameter("chkfollowup").trim();
     String followupdate = request.getParameter("followupdate")==null?"0":request.getParameter("followupdate").trim();
     String salesperson = request.getParameter("salesperson")==null?"0":request.getParameter("salesperson").trim();
     String category = request.getParameter("category")==null?"0":request.getParameter("category").trim();
     String amtrangefrm = request.getParameter("amtrangefrm")==null?"0":request.getParameter("amtrangefrm").trim();
     String amtrangeto = request.getParameter("amtrangeto")==null?"0":request.getParameter("amtrangeto").trim();
     String clientstatus = request.getParameter("clientstatus")==null?"0":request.getParameter("clientstatus").trim();
     String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();%> 

<style type="text/css">
  .advanceClass
  {
      background-color: #FBEFF5;
  }
  .balanceClass
  {
      background-color: #E0F8F1;
  }
  .unappliedClass
  {
     color: #FF0000;
  }
   .whiteClass
  {
     background-color: #FFF;
  }
  .currentClass
  {
     background-color: #CECEF6;
  }
  .salikClass
  {
     background-color: #DBEFEC;
  }
  .trafficClass
  {
     background-color: #D3E4B2;
  }
  
</style>
<script type="text/javascript">
      var data;
      var dataExcelExport;
      var temp='<%=branchval%>';
      
	  	if(temp!='NA'){ 
	  		    data='<%=DAO.paymentFollowUpGridLoading(branchval, uptodate, clientaccount, chkfollowup, followupdate, salesperson, category, amtrangefrm, amtrangeto, clientstatus,check)%>';
	  		    dataExcelExport='<%=DAO.paymentFollowUpGridExporting(branchval, uptodate, clientaccount, chkfollowup, followupdate, salesperson, category, amtrangefrm, amtrangeto, clientstatus,check)%>';
	  	}
  	
        $(document).ready(function () {
        	
        	var source =
            {
                datatype: "json",
                datafields: [
							{name : 'name' , type: 'string' },
							{name : 'contact' , type:'string'},
							{name : 'pmob' , type:'int'},
							{name : 'advance' , type:'number'},
							{name : 'balance' , type:'number'},
							{name : 'unapplied',type:'number'},
							{name : 'netamount' , type:'number'},
							{name : 'level1' , type:'number'},
							{name : 'level2' , type:'number'},
							{name : 'level3' , type:'number'},
							{name : 'level4' , type:'number'},
							{name : 'level5' , type:'number'},
							{name : 'sal_name' , type:'String'},
							{name : 'fdate' , type:'date'},
							{name : 'acno' , type:'int'},
							{name : 'brhid' , type:'int'},
							{name : 'cldocno' , type:'int'},
							{name : 'email' , type:'String'},
							{name : 'doc_no' , type:'int'},
							{name : 'current' , type:'int'},
							{name : 'salik' , type:'int'},
							{name : 'traffic' , type:'int'},
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
            $("#paymentFollowUp").jqxGrid(
            {
                width: '98%',
                height: 400,
                source: dataAdapter,
                rowsheight:25,
                filtermode:'excel',
                filterable: true,
                showfilterrow: true,
                sortable: true,
                selectionmode: 'singlerow',
                editable: false,
                columnsresize: true,
                localization: {thousandsSeparator: ""},
                
                //Add row method
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,datafield: '',
							    columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
							    cellclassname: 'whiteClass', pinned: true,
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }    
							},
							{ text: 'Account Name', pinned: true, datafield: 'name', width: '18%', cellclassname: 'whiteClass' },
							{ text: 'Cldocno',  datafield: 'cldocno', hidden: true, width: '8%'  },
							{ text: 'Contact Person', datafield: 'contact',  width: '11%' },
							{ text: 'Mobile No',  datafield: 'pmob',  width: '7%'  },
							{ text: 'Advance', datafield:'advance', width:'7%', cellsformat: 'd2',cellsalign:'right',align:'right', cellclassname: 'advanceClass' },
							{ text: 'Balance', datafield:'balance', width:'7%', cellsformat: 'd2',cellsalign:'right',align:'right', cellclassname: 'balanceClass' },
							{ text: 'Unapplied',  datafield: 'unapplied',  width: '7%', cellsformat: 'd2',cellsalign:'right',align:'right', cellclassname: 'unappliedClass' },
							
							{ text: 'Current',  datafield: 'current', hidden: true, width: '8%',cellsformat: 'd2', cellclassname: 'currentClass'  }, 
							{ text: 'Salik',  datafield: 'salik', hidden: true, width: '8%' ,cellsformat: 'd2' , cellclassname: 'salikClass'},
							{ text: 'Traffic',  datafield: 'traffic', hidden: true, width: '8%'  ,cellsformat: 'd2', cellclassname: 'trafficClass'},
							{ text: 'Total',  datafield: 'netamount',  width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right' },
							{ text: '0 - 30',  datafield: 'level1',  width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right'},
							{ text: '31 - 60',  datafield: 'level2',  width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right' },
							{ text: '61 - 90',  datafield: 'level3',  width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right' },
							{ text: '91 - 120',  datafield: 'level4',  width: '8%',cellsformat: 'd2',cellsalign:'right',align:'right' },
							{ text: '> 121',  datafield: 'level5',  width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right' },
							{ text: 'Sales Person',  datafield: 'sal_name',  width: '15%' },
							{ text: 'Follow-Up Date', datafield: 'fdate', cellsformat: 'dd.MM.yyyy' , width: '7%' },
							{ text: 'Account No',  datafield: 'acno', hidden: true, width: '8%'  },
							{ text: 'Branch Id',  datafield: 'brhid', hidden: true, width: '8%'  },
							{ text: 'Email',  datafield: 'email', hidden: true, width: '8%'  },
							{ text: 'Doc No',  datafield: 'doc_no', hidden: true, width: '8%'  },
						 ]
            });
            
            if(temp=='NA'){
                $("#paymentFollowUp").jqxGrid("addrow", null, {});
            }
            
			$("#overlay, #PleaseWait").hide();
			
            $('#paymentFollowUp').on('rowdoubleclick', function (event) { 
          	  var rowindex1=event.args.rowindex;
          	  $('#cmbprocess').val('');$('#date').val(new Date());$('#txtremarks').val('');$('#txtbranch').val('');$('#txtacountno').val('');$('#txtdocno').val('');
  			  $('#txttranid').val('');
          	  
                $('#cmbprocess').attr("disabled",false);$('#txtremarks').attr("readonly",false);
                $('#date').jqxDateTimeInput({disabled: false});$('#btnupdate').attr("disabled",false);
          		 
          	  document.getElementById("txtacountno").value=$('#paymentFollowUp').jqxGrid('getcellvalue', rowindex1, "acno"); 
          	  document.getElementById("txtdocno").value=$('#paymentFollowUp').jqxGrid('getcellvalue', rowindex1, "doc_no");
          	  document.getElementById("txtbranch").value=$('#paymentFollowUp').jqxGrid('getcellvalue', rowindex1, "brhid");
          	  document.getElementById("txtcldocno").value=$('#paymentFollowUp').jqxGrid('getcellvalue', rowindex1, "cldocno");
          	  document.getElementById("txtclientaccountemail").value=$('#paymentFollowUp').jqxGrid('getcellvalue', rowindex1, "email");
          	
              $("#detailDiv").load("detailGrid.jsp?cldocno="+$('#paymentFollowUp').jqxGrid('getcellvalue', rowindex1, 'cldocno')+'&check=1');
             }); 
            
            
            

        });

</script>
<div id="paymentFollowUp"></div>
