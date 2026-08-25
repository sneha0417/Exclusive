<%@page import="com.dashboard.accounts.ageingstatementmonthly.ClsAgeingStatementMonthlyDAO"%>
<% ClsAgeingStatementMonthlyDAO DAO= new ClsAgeingStatementMonthlyDAO(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String upToDate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate").trim();
     String atype = request.getParameter("atype"); 
     String accdocno = request.getParameter("accdocno")==null?"0":request.getParameter("accdocno").trim();
     String salesperson = request.getParameter("salesperson")==null?"0":request.getParameter("salesperson").trim();
     String category = request.getParameter("category")==null?"0":request.getParameter("category").trim();
     String check = request.getParameter("check")==null?"0":request.getParameter("check");%> 
     
<script type="text/javascript">
      var data;
      var temp='<%=branchval%>';
      var currentmonthname=''+$('#txtcurrentmonth').val()+'';
      var previousmonthname1=''+$('#txtpreviousmonth1').val()+'';
      var previousmonthname2=''+$('#txtpreviousmonth2').val()+'';
      var previousmonthname3=''+$('#txtpreviousmonth3').val()+'';
      var previousmonthname4=''+$('#txtpreviousmonth4').val()+'';
      var previousmonthname5=''+$('#txtpreviousmonth5').val()+'';
      var previousmonthname6=''+$('#txtpreviousmonth6').val()+'';
      var previousmonthname7=''+$('#txtpreviousmonth7').val()+'';
      var previousmonthname8=''+$('#txtpreviousmonth8').val()+'';
      var previousmonthname9=''+$('#txtpreviousmonth9').val()+'';
      
	  	if(temp!='NA'){ 
	  		  data='<%=DAO.ageingStatementMonthlyGridLoading(branchval, upToDate, atype, accdocno, salesperson, category, check)%>'; 
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
							{name : 'sal_name' , type:'String'},
							{name : 'account' , type:'int'},
							{name : 'name' , type: 'String' },
							{name : 'previousmonth10' , type:'number'},
							{name : 'previousmonth9' , type:'number'},
							{name : 'previousmonth8',type:'number'},
							{name : 'previousmonth7' , type:'number'},
							{name : 'previousmonth6' , type:'number'},
							{name : 'previousmonth5' , type:'number'},
							{name : 'previousmonth4' , type:'number'},
							{name : 'previousmonth3' , type:'number'},
							{name : 'previousmonth2' , type:'number'},
							{name : 'previousmonth1' , type:'number'},
							{name : 'currentmonth' , type:'number'},
							{name : 'unapplied' , type:'number'},
							{name : 'totaloutstanding' , type:'number'},
							{name : 'acno' , type:'int'},
							{name : 'branch_id' , type:'int'}
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
            
            $("#ageingStatement").jqxGrid(
            {
                width: '98%',
                height: 490,
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
                
                columns: [
							{ text: 'Salesman',  datafield: 'sal_name',  width: '15%' },
							{ text: 'Account',  datafield: 'account', width: '8%'  },
							{ text: 'Account Name', datafield: 'name', width: '27%', aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
							{ text: 'Previous Months',  datafield: 'previousmonth10',  width: '9%', cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: previousmonthname9, datafield:'previousmonth9', width:'8%', cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: previousmonthname8, datafield:'previousmonth8', width:'8%', cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: previousmonthname7, datafield:'previousmonth7', width:'8%', cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: previousmonthname6, datafield:'previousmonth6', width:'8%', cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: previousmonthname5, datafield:'previousmonth5', width:'8%', cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: previousmonthname4, datafield:'previousmonth4', width:'8%', cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: previousmonthname3, datafield:'previousmonth3', width:'8%', cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: previousmonthname2, datafield:'previousmonth2', width:'8%', cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: previousmonthname1, datafield:'previousmonth1', width:'8%', cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: currentmonthname, datafield:'currentmonth', width:'8%', cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: 'Unapplied',  datafield: 'unapplied',  width: '9%', cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: 'Grand Total',  datafield: 'totaloutstanding',  width: '10%',cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: 'Account DocNo',  datafield: 'acno', hidden: true, width: '8%'  },
							{ text: 'Branch Id',  datafield: 'branch_id', hidden: true, width: '8%'  },
						 ]
            });
            
            if(temp=='NA'){
                $("#ageingStatement").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();
            
			$('#ageingStatement').on('rowdoubleclick', function (event) { 
            	var rowindex1=event.args.rowindex;
            	
            	$('#btnIndividual').attr('disabled',false);
          	  
          	  	document.getElementById("txtacountno").value=$('#ageingStatement').jqxGrid('getcellvalue', rowindex1, "acno");
          	  	document.getElementById("txtbranch").value=$('#ageingStatement').jqxGrid('getcellvalue', rowindex1, "brhid");
             }); 
			 
        });

</script>
<div id="ageingStatement"></div>
