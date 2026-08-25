<%@page import="com.dashboard.accounts.ageingstatementreport.ClsAgeingStatementReportDAO"%>
<%ClsAgeingStatementReportDAO DAO= new ClsAgeingStatementReportDAO(); %> 
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
  .whiteClass
  {
     background-color: #fff;
  }
</style>
<script type="text/javascript">
      var data;
      var temp='<%=branchval%>';
      
	  	if(temp!='NA'){ 
	  		   data='<%=DAO.ageingStatementReportGridLoading(branchval, upToDate, atype, accdocno, salesperson, category, check)%>'; 
	  		   var dataExcelExport='<%=DAO.ageingStatementReportGridLoading(branchval, upToDate, atype, accdocno, salesperson, category, check)%>';
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
							{name : 'name' , type:'String'},
							{name : 'totaloutstanding' , type:'number'},
							{name : 'unapplied' , type:'number'},
							{name : 'current' , type:'number'},
							{name : 'month1' , type:'number'},
							{name : 'month2',type:'number'},
							{name : 'month3' , type:'number'},
							{name : 'month4' , type:'number'},
							{name : 'month5' , type:'number'},
							{name : 'month6' , type:'number'},
							{name : 'month7' , type:'number'},
							{name : 'month8' , type:'number'},
							{name : 'month9' , type:'number'},
							{name : 'month10' , type:'number'},
							{name : 'month11' , type:'number'},
							{name : 'month12' , type:'number'},
							{name : 'greatermonth12' , type:'number'},
							{name : 'advancepdc' , type:'number'},
							{name : 'creditterms' , type:'number'},
							{name : 'cat_name' , type:'String'},
							{name : 'sal_name' , type:'String'},
							{name : 'acno' , type:'int'},
							{name : 'email' , type:'String'},
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
            
            $("#ageingStatementReportGridID").jqxGrid(
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
             	columnsresize: true,
                
                columns: [
							{ text: 'Account', pinned: true, datafield: 'account', width: '10%', cellclassname: 'whiteClass' },
							{ text: 'Account Name', pinned: true,  datafield: 'name',  width: '15%', cellclassname: 'whiteClass', aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
							{ text: 'Total Outstanding',  datafield: 'totaloutstanding', cellsformat: 'd2',cellsalign:'right',align:'right',  width: '9%', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: 'Unapplied',  datafield: 'unapplied',  width: '7%', cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring, cellclassname: 'unappliedClass' },
							{ text: 'Current', datafield:'current', width:'7%', cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: '1 Month',  datafield: 'month1',  width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring},
							{ text: '2 Months',  datafield: 'month2',  width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: '3 Months',  datafield: 'month3',  width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: '4 Months',  datafield: 'month4',  width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: '5 Months',  datafield: 'month5',  width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: '6 Months',  datafield: 'month6',  width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: '7 Months',  datafield: 'month7',  width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: '8 Months',  datafield: 'month8',  width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: '9 Months',  datafield: 'month9',  width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: '10 Months',  datafield: 'month10',  width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: '11 Months',  datafield: 'month11',  width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: '12 Months',  datafield: 'month12',  width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: '>12 Months',  datafield: 'greatermonth12',  width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: 'Advance PDC', datafield:'advancepdc', width:'7%', cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring, cellclassname: 'advanceClass' },
							{ text: 'Credit Terms',  datafield: 'creditterms',cellsalign:'center',align:'center',  width: '7%' },
							{ text: 'Category',  datafield: 'cat_name',  width: '15%' },
							{ text: 'Sales Man',  datafield: 'sal_name',  width: '15%' },
							{ text: 'Account No',  datafield: 'acno', hidden: true, width: '8%'  },
							{ text: 'Account Email',  datafield: 'email', hidden: true, width: '8%'  },
							{ text: 'Branch Id',  datafield: 'brhid', hidden: true, width: '8%'  },
						 ]
            });
            
            if(temp=='NA'){
                $("#ageingStatementReportGridID").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();

            $('#ageingStatementReportGridID').on('rowdoubleclick', function (event) { 
            	var rowindex1=event.args.rowindex;
            	
            	$('#btnprint').attr('disabled',false);$('#btnIndividual').attr('disabled',false);
          	  
          	  	document.getElementById("txtacountno").value=$('#ageingStatementReportGridID').jqxGrid('getcellvalue', rowindex1, "account");
          	  	document.getElementById("txtaccemail").value=$('#ageingStatementReportGridID').jqxGrid('getcellvalue', rowindex1, "email");
          	  	document.getElementById("txtbranch").value=$('#ageingStatementReportGridID').jqxGrid('getcellvalue', rowindex1, "brhid");
             }); 
        });

</script>
<div id="ageingStatementReportGridID"></div>
