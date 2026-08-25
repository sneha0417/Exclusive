<%@ page import="com.dashboard.client.ClsClientDAO" %>
<% ClsClientDAO cld=new ClsClientDAO();%>

<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
	 String gridLoad = request.getParameter("gridload")==null?"0":request.getParameter("gridload").trim();
     String uptodate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate").trim();
     String rentalType = request.getParameter("rentaltype")==null?"0":request.getParameter("rentaltype").trim();%> 
<script type="text/javascript">
      var data;
      var temp='<%=branchval%>';
      
	  	if(temp!='NA'){ 
	  		    data='<%=cld.creditCardFollowUpGridLoading(branchval, uptodate, rentalType, gridLoad)%>'; 
	  	}
  	
        $(document).ready(function (){
        	
        	var source =
            {
                datatype: "json",
                datafields: [
							{name : 'agreement' , type: 'string' },
							{name : 'refname' , type:'string'},
							{name : 'cardno' , type:'string'},
							{name : 'expdate' , type:'date'},
							{name : 'aggno',type:'int'},
						    {name : 'cldocno', type: 'int'  },
						    {name : 'brhid', type: 'int'  },
						    {name : 'cards' , type:'string'},
						    {name : 'pytdocno', type: 'int'  }
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
            $("#creditCardFollowUp").jqxGrid(
            {
                width: '98%',
                height: 400,
                source: dataAdapter,
                rowsheight:25,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
                editable: false,
                localization: {thousandsSeparator: ""},
                
                //Add row method
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,datafield: '',
							    columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }    
							},
							{ text: 'Agreement', datafield: 'agreement', width: '15%' },
							{ text: 'Client Name',  datafield: 'refname',  width: '60%' },
							{ text: 'Card No',  datafield: 'cardno',  width: '5%'  },
							{ text: 'Expiry Date', datafield: 'expdate', cellsformat: 'dd.MM.yyyy' , width: '15%' },
							{ text: 'Agreement No.',  datafield: 'aggno', hidden: true, width: '7%' },
							{ text: 'Cldocno', datafield: 'cldocno', hidden: true, width: '10%' },
							{ text: 'Branch Id', datafield: 'brhid', hidden: true, width: '10%' },
							{ text: 'Card',  datafield: 'cards',  hidden: true, width: '15%'  },
							{ text: 'Pytdocno',  datafield: 'pytdocno',  hidden: true, width: '15%'  },
						 ]
            });
            
            if(temp=='NA'){
                $("#creditCardFollowUp").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();
            
            $('#creditCardFollowUp').on('rowdoubleclick', function (event) { 
          	  var rowindex1=event.args.rowindex;
          	    $('#cmbprocess').val('');$('#date').val(new Date());$('#txtremarks').val('');$('#txtbranch').val('');$('#txtagreementno').val('');$('#txtcldocno').val('');
          	  
                $('#cmbprocess').attr("disabled",false);$('#txtremarks').attr("readonly",false);
                $('#date').jqxDateTimeInput({disabled: false});$('#btnupdate').attr("disabled",false);
                
          	  document.getElementById("txtcldocno").value=$('#creditCardFollowUp').jqxGrid('getcellvalue', rowindex1, "cldocno"); 
          	  document.getElementById("txtagreementno").value=$('#creditCardFollowUp').jqxGrid('getcellvalue', rowindex1, "aggno");
          	  document.getElementById("txtbranch").value=$('#creditCardFollowUp').jqxGrid('getcellvalue', rowindex1, "brhid");
          	  document.getElementById("txtexpirydate").value=$('#creditCardFollowUp').jqxGrid('getcellvalue', rowindex1, "expdate");
              document.getElementById("txtcardno").value=$('#creditCardFollowUp').jqxGrid('getcellvalue', rowindex1, "cards");
              document.getElementById("txtpytdocno").value=$('#creditCardFollowUp').jqxGrid('getcellvalue', rowindex1, "pytdocno");
              
              $("#detailDiv").load("detailGrid.jsp?cldocno="+$('#creditCardFollowUp').jqxGrid('getcellvalue', rowindex1, 'cldocno')+'&rtype='+document.getElementById("rentaltype").value+'&aggno='+$('#creditCardFollowUp').jqxGrid('getcellvalue', rowindex1, 'aggno')+'&cardno='+$('#creditCardFollowUp').jqxGrid('getcellvalue', rowindex1, 'cards'));
             });

        });

</script>
<div id="creditCardFollowUp"></div>
