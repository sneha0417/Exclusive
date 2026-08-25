<%@page import="com.dashboard.accounts.individualageing.ClsIndividualAgeing"%>
<%ClsIndividualAgeing DAO=new ClsIndividualAgeing(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String upToDate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate").trim();
     String atype = request.getParameter("atype"); 
     String accdocno = request.getParameter("accdocno")==null?"0":request.getParameter("accdocno").trim();
     String salesperson = request.getParameter("salesperson")==null?"0":request.getParameter("salesperson").trim();
     String category = request.getParameter("category")==null?"0":request.getParameter("category").trim();
     String check = request.getParameter("check")==null?"0":request.getParameter("check");%> 
     
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
</style>
<script type="text/javascript">
      var data;
      var temp='<%=branchval%>';
      
	  	if(temp!='NA'){ 
	  		   data='<%=DAO.individualAgeing(branchval, upToDate, atype, accdocno, salesperson, category, check)%>';
	  	}
  	
        $(document).ready(function () {
        	
        	/*$("#btnExcel").click(function() {
    			$("#individualAgeing").jqxGrid('exportdata', 'xls', 'IndividualAgeing');
    		});*/
        	
        	var rendererstring=function (aggregates){
               	var value=aggregates['sum'];
               	if(typeof(value) == "undefined"){
               		value=0.00;
               	}
               	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
               }
        	
        	var rendererstring1=function (aggregates){
                var value1=aggregates['sum1'];
                return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total : " + '</div>';
               }
        	
        	var source =
            {
                datatype: "json",
                datafields: [
							{name : 'date', type: 'date' },
							{name : 'transno', type: 'int' },
							{name : 'transtype', type: 'string'   },
							{name : 'name' , type: 'String' },
							{name : 'contact' , type:'String'},
							{name : 'pmob' , type:'String'},
							{name : 'description', type: 'string' },
							{name : 'salname', type: 'string' },
							{name : 'advance' , type:'number'},
							{name : 'balance' , type:'number'},
							{name : 'unapplied',type:'number'},
							{name : 'age' , type:'number'},
							{name : 'acno' , type:'int'},
							{name : 'brhid' , type:'int'}
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
		            });
            
            $("#individualAgeing").jqxGrid(
            {
                width: '98%',
                height: 490,
                source: dataAdapter,
                rowsheight:25,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                columnsresize: true,
                selectionmode: 'singlerow',
                editable: false,
                showaggregates: true,
                showstatusbar:true,
             	statusbarheight:25,
                
                columns: [
						   { text: 'Sr. No', sortable: false, filterable: false, editable: false,
						       groupable: false, draggable: false, resizable: false,datafield: '',
						       columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
						       cellsrenderer: function (row, column, value) {
						        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						     }    
							},
							{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , editable: false, width: '6%' },
							{ text: 'Type', datafield: 'transtype', editable: false, width: '3%' },	
							{ text: 'Doc No.', datafield: 'transno', editable: false, width: '5%' },
							{ text: 'Account Name', datafield: 'name', width: '15%' },
							{ text: 'Contact Person',  datafield: 'contact',  width: '10%' },
							{ text: 'Sales Person',  datafield: 'salname',  width: '8%' },
							{ text: 'Mobile No',  datafield: 'pmob',  width: '7%' },
							{ text: 'Description',  datafield: 'description',  width: '17%', aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
							{ text: 'Advance', datafield:'advance', width:'7%', cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring, cellclassname: 'advanceClass' },
							{ text: 'Balance', datafield:'balance', width:'7%', cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring, cellclassname: 'balanceClass' },
							{ text: 'Unapplied',  datafield: 'unapplied',  width: '7%', cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring, cellclassname: 'unappliedClass' },
							{ text: 'Age',  datafield: 'age',  width: '4%', cellsalign: 'center', align: 'center' },
							{ text: 'Account No',  datafield: 'acno', hidden: true, width: '8%'  },
							{ text: 'Branch Id',  datafield: 'brhid', hidden: true, width: '8%'  },
						 ]
            });
            
            if(temp=='NA'){
                $("#individualAgeing").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();
            
            $('#individualAgeing').on('rowdoubleclick', function (event) { 
            	  var rowindex1=event.args.rowindex;
            	  document.getElementById("txtacountno").value=$('#individualAgeing').jqxGrid('getcellvalue', rowindex1, "acno");
            	  document.getElementById("txtbranch").value=$('#individualAgeing').jqxGrid('getcellvalue', rowindex1, "brhid");
               }); 

        });

</script>
<div id="individualAgeing"></div>
