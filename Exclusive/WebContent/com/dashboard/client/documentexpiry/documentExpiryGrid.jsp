<%@ page import="com.dashboard.client.ClsClientDAO" %>
<% ClsClientDAO cld=new ClsClientDAO();%>

<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String upToDate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate").trim();%>
<style>
 		.redClass
        {
            background-color: #FFEBEB;
        }
        .yellowClass
        {
            background-color: #FFFFD1;
        }
        .orangeClass
        {
            background-color: #FFEBC2;
        }
        .whiteClass
        {
           background-color: #fff;
        }
        .folllowUpClass
	    {
	      background-color: #E0F8F1;
	    }
</style>
        
<script type="text/javascript">
      var data;
      var temp='<%=branchval%>';
      
	  	if(temp!='NA'){ 
	  		    data='<%=cld.documentExpiryGridLoading(branchval, upToDate)%>';   
	  	}
  	
        $(document).ready(function () {
        	
        	/*$("#btnExcel").click(function() {
    			$("#documentExpiry").jqxGrid('exportdata', 'xls', 'DocumentExpiry');
    		});*/
        	
        	var source =
            {
                datatype: "json",
                datafields: [
					{name : 'refname', type: 'String'  },
					{name : 'name', type: 'String'  },
				    {name : 'per_mob' , type: 'String' },
				    {name : 'document' , type: 'String' },
				    {name : 'expirydate', type: 'date'  },
				    {name : 'followupdate', type: 'date'  },
				    {name : 'cldocno', type: 'int'  },
				    {name : 'sr_no', type: 'int'  },
				    {name : 'brhid', type: 'int'  },
				    {name : 'clientinfo', type: 'string'  }
	            ],
                localdata: data,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
        	
        	var cellclassname = function (row, column, value, data) {
        		if (data.document == 'Licence Expired') {
                    return "redClass";
                } else if (data.document == 'Passport Expired') {
                    return "yellowClass";
                }else if (data.document == 'Trade Licence Expired') {
                    return "orangeClass";
                } else{
                	return "whiteClass";
                };
            };
        	
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#documentExpiry").jqxGrid(
            {
                width: '98%',
                height: 400,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                rowsheight:25,
                selectionmode: 'singlerow',
                editable: false,
                
                columns: [
						{ text: 'Client', datafield: 'refname', width: '30%' },
						{ text: 'Ref. Details', datafield: 'name', width: '25%' },
						{ text: 'Mobile No.', datafield: 'per_mob', width: '10%' },
						{ text: 'Document', datafield: 'document', cellclassname: cellclassname,  width: '15%' },
						{ text: 'Expiry Date', datafield: 'expirydate', cellclassname: cellclassname,  cellsformat: 'dd.MM.yyyy' , width: '10%' },
						{ text: 'Follow-Up Date', datafield: 'followupdate', cellclassname: 'folllowUpClass',  cellsformat: 'dd.MM.yyyy' , width: '10%' },
						{ text: 'Cldocno', datafield: 'cldocno', hidden: true, width: '10%' },
						{ text: 'Driver SrNo.', datafield: 'sr_no', hidden: true, width: '10%' },
						{ text: 'Branch Id', datafield: 'brhid', hidden: true, width: '10%' },
						{ text: 'Client Info', datafield: 'clientinfo', hidden:true, width: '10%' },
					 ]
            });
            
            if(temp=='NA'){
                $("#documentExpiry").jqxGrid("addrow", null, {});
            }
        
            $("#overlay, #PleaseWait").hide();
            
            $('#documentExpiry').on('rowdoubleclick', function (event) { 
        	  var rowindex1=event.args.rowindex;
        	  $('#cmbprocess').val('');$('#date').val(new Date());$('#txtbranch').val('');$('#txtcldocno').val('');$('#expiryDate').val(new Date());$('#txtremarks').val('');
			  $('#txtdriver').val('');$('#txtdocument').val('');
        	  
              $('#cmbprocess').attr("disabled",false);$('#txtremarks').attr("readonly",false);
              $('#date').jqxDateTimeInput({disabled: false});$('#btnupdate').attr("disabled",false);
        		 
        	  document.getElementById("txtcldocno").value=$('#documentExpiry').jqxGrid('getcellvalue', rowindex1, "cldocno"); 
        	  document.getElementById("txtdriver").value=$('#documentExpiry').jqxGrid('getcellvalue', rowindex1, "sr_no");
        	  document.getElementById("txtbranch").value=$('#documentExpiry').jqxGrid('getcellvalue', rowindex1, "brhid");
        	  document.getElementById("txtdocument").value=$('#documentExpiry').jqxGrid('getcellvalue', rowindex1, "document");
        	  $('#expiryDate').val($('#documentExpiry').jqxGrid('getcellvalue', rowindex1, "expirydate")) ; 
        	  
        	  var values= $('#documentExpiry').jqxGrid('getcellvalue',rowindex1, "clientinfo");
              
              var sum2 = values.toString().replace(/\*/g, '\n');
           
              document.getElementById("clientinfo").value=sum2;
				
              $("#detailDiv").load("detailGrid.jsp?cldocno="+$('#documentExpiry').jqxGrid('getcellvalue', rowindex1, 'cldocno')+'&srno='+$('#documentExpiry').jqxGrid('getcellvalue', rowindex1, 'sr_no')+'&document='+$('#documentExpiry').jqxGrid('getcelltext', rowindex1, 'document').replace(/ /g, "%20"));
           }); 
            
  });
                       
</script>
<div id="documentExpiry"></div>