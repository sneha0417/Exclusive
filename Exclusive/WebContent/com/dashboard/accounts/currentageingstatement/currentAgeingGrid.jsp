<%@page import="com.dashboard.accounts.currentageingstatement.ClsCurrentAgeingDAO"%>
<%ClsCurrentAgeingDAO DAO= new ClsCurrentAgeingDAO(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String upToDate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate").trim();
     String atype = request.getParameter("atype"); 
     String accdocno = request.getParameter("accdocno")==null?"0":request.getParameter("accdocno").trim();
     String salesperson = request.getParameter("salesperson")==null?"0":request.getParameter("salesperson").trim();
     String category = request.getParameter("category")==null?"0":request.getParameter("category").trim();
     String level1From = request.getParameter("level1from")==null?"0":request.getParameter("level1from").trim();
     String level1To = request.getParameter("level1to")==null?"0":request.getParameter("level1to").trim();
     String level2From = request.getParameter("level2from")==null?"0":request.getParameter("level2from").trim();
     String level2To = request.getParameter("level2to")==null?"0":request.getParameter("level2to").trim();
     String level3From = request.getParameter("level3from")==null?"0":request.getParameter("level3from").trim();
     String level3To = request.getParameter("level3to")==null?"0":request.getParameter("level3to").trim();
     String level4From = request.getParameter("level4from")==null?"0":request.getParameter("level4from").trim();
     String level4To = request.getParameter("level4to")==null?"0":request.getParameter("level4to").trim();
     String level5From = request.getParameter("level5from")==null?"0":request.getParameter("level5from").trim();
     String check= request.getParameter("check")==null?"0":request.getParameter("check").trim();%> 
     
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
      var l1=''+$('#txtlevel1from').val()+' - '+$('#txtlevel1to').val()+'';
      var l2=''+$('#txtlevel2from').val()+' - '+$('#txtlevel2to').val()+'';
      var l3=''+$('#txtlevel3from').val()+' - '+$('#txtlevel3to').val()+'';
      var l4=''+$('#txtlevel4from').val()+' - '+$('#txtlevel4to').val()+'';
      var l5='>='+$('#txtlevel5from').val()+'';
      
	  	if(temp!='NA'){ 
	  		   data='<%=DAO.currentAgeing(branchval, upToDate, atype, accdocno, salesperson, category, level1From, level1To, level2From, level2To, level3From, level3To, level4From, level4To, level5From,check)%>';
			   var dataExcelExport='<%=DAO.currentAgeingExcelExport(branchval, upToDate, atype, accdocno, salesperson, category, level1From, level1To, level2From, level2To, level3From, level3To, level4From, level4To, level5From,check)%>';
	  	}
  	
        $(document).ready(function () {
        	
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
							{name : 'account' , type: 'String' },
							{name : 'name' , type: 'String' },
							{name : 'contact' , type:'String'},
							{name : 'pmob' , type:'String'},
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
            
            $("#currentAgeing").jqxGrid(
            {
                width: '98%',
                height: 500,
                source: dataAdapter,
                rowsheight:25,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
                editable: false,
                showaggregates: true,
                showstatusbar:true,
             	statusbarheight:25,
                localization: {thousandsSeparator: ""},
                
                columns: [
							{ text: 'Account', datafield: 'account', width: '6%' },
                            { text: 'Account Name', datafield: 'name', width: '15%' },
							{ text: 'Contact Person',  datafield: 'contact',  width: '15%' },
							{ text: 'Mobile No',  datafield: 'pmob',  width: '7%', aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
							{ text: 'Advance', datafield:'advance', width:'7%', cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring, cellclassname: 'advanceClass' },
							{ text: 'Balance', datafield:'balance', width:'7%', cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring, cellclassname: 'balanceClass' },
							{ text: 'Unapplied',  datafield: 'unapplied',  width: '7%', cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring, cellclassname: 'unappliedClass' },
							{ text: 'Total',  datafield: 'netamount',  width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: l1,  datafield: 'level1',  width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring},
							{ text: l2,  datafield: 'level2',  width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: l3,  datafield: 'level3',  width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: l4,  datafield: 'level4',  width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: l5,  datafield: 'level5',  width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: 'Sales Person',  datafield: 'sal_name',  width: '15%' },
							{ text: 'Account No',  datafield: 'acno', hidden: true, width: '8%'  },
							{ text: 'Branch Id',  datafield: 'brhid', hidden: true, width: '8%'  },
						 ]
            });
            
            if(temp=='NA'){
                $("#currentAgeing").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();
            
            $('#currentAgeing').on('rowdoubleclick', function (event) { 
            	  var rowindex1=event.args.rowindex;
            	  document.getElementById("txtacountno").value=$('#currentAgeing').jqxGrid('getcellvalue', rowindex1, "acno");
            	  document.getElementById("txtbranch").value=$('#currentAgeing').jqxGrid('getcellvalue', rowindex1, "brhid");
               }); 

        });

</script>
<div id="currentAgeing"></div>
