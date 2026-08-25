<%@page import="com.dashboard.accounts.prepaymentdistribution.ClsPrePaymentDistributionDAO"%>
<% ClsPrePaymentDistributionDAO DAO= new ClsPrePaymentDistributionDAO(); %> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<% 
String branch = request.getParameter("branchval")==null?"NA":request.getParameter("branchval");
String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");
String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate");
String todate = request.getParameter("todate")==null?"0":request.getParameter("todate");
String check = request.getParameter("check")==null?"0":request.getParameter("check");
%>
       
<style type="text/css">
  .generateableClass
  {
      background-color: #DAF7A6;
  }
  .whiteClass
  {
     background-color: #FFF;
  }
</style>
 
<script type="text/javascript">
 	 var data;


 	$(document).ready(function () {
 		
 		 var temp='<%=branch%>';
        
	  	 if(temp!='NA'){   
	  		data='<%=DAO.prePaymentDistribustionGridLoading(session, docno, fromdate, todate, check)%>';     
         }
 		
	    var source =
	    {
	        datatype: "json",
	        datafields: [   
	                     	{name : 'branch', type: 'string' },
     						{name : 'dtype', type: 'string'  },
     						{name : 'transno', type: 'int' },
     						{name : 'doc_no', type: 'int' },
     						{name : 'acno', type: 'int' },
     						{name : 'account', type: 'int'   },
     		     		    {name : 'accountname', type: 'string'   },
     		     		  	{name : 'date', type: 'date' },
							{name : 'description', type: 'string'   },
   							{name : 'dramount', type: 'number'   },
   							{name : 'editbtn', type: 'String'  },
   							{name : 'costtype', type: 'string'    },
							{name : 'costgroup', type: 'string'    },
							{name : 'costcode', type: 'number'    },
   							{name : 'stdate', type: 'date' },
   							{name : 'enddate', type: 'date' },
     						{name : 'postacno', type: 'int'   },
     						{name : 'paccount', type: 'int'   },
     						{name : 'paccountname', type: 'string' },
     						{name : 'grtype', type: 'int'  },
     						{name : 'trno', type: 'int' },
     						{name : 'tranid', type: 'int' },
     						{name : 'brhid', type: 'int' },
     						{name : 'rowno', type: 'int' }
     						],
					    localdata: data,
	        
	        
	        pager: function (pagenum, pagesize, oldpagenum) {
	            // callback called when a page or page size is changed.
	        }
	    };
	  
	    var cellclassname = function (row, column, value, data) {
    		if (parseInt(data.rowno)>0) {
                return "generateableClass";
            } else{
            	return "whiteClass";
            };
        };
	    
	    var dataAdapter = new $.jqx.dataAdapter(source,
	    		 {
	        		loadError: function (xhr, status, error) {
	                alert(error);    
	                }
			            
		            }		
	    );
    
   $("#prepaymentDistributionGridID").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        enableAnimations: true,
        editable: true,
        columnsresize: true,
        selectionmode: 'singlecell',
        localization: {thousandsSeparator: ""},
        
        handlekeyboardnavigation: function (event) {
        	
            //Search Pop-Up
            var cell1 = $('#prepaymentDistributionGridID').jqxGrid('getselectedcell');
            if (cell1 != undefined && cell1.datafield == 'costgroup') {
        	var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
        		if($('#prepaymentDistributionGridID').jqxGrid('getcellvalue',cell1.rowindex, "editbtn")=='SAVE' && $('#mode').val()=='E'){
		            if (key == 114) {  
		            	 costTypeSearchContent('costTypeSearchGrid.jsp');
		            	 $('#prepaymentDistributionGridID').jqxGrid('render');
		             }
             	}
        	}
            
            var cell2 = $('#prepaymentDistributionGridID').jqxGrid('getselectedcell');
            if (cell2 != undefined && cell2.datafield == 'costcode') {
               var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
               if($('#prepaymentDistributionGridID').jqxGrid('getcellvalue',cell2.rowindex, "editbtn")=='SAVE' && $('#mode').val()=='E'){
	               if (key == 114) {   
	            	   var value=  $('#prepaymentDistributionGridID').jqxGrid('getcellvalue', cell2.rowindex, "costtype");
	            	   costCodeSearchContent('costCodeSearchGrid.jsp?costtype='+value);
	            	   $('#prepaymentDistributionGridID').jqxGrid('render');
	               }
	           }
           }
            
            var cell3 = $('#prepaymentDistributionGridID').jqxGrid('getselectedcell');
            if (cell3 != undefined && cell3.datafield == 'paccount') {
                var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                if($('#prepaymentDistributionGridID').jqxGrid('getcellvalue',cell3.rowindex, "editbtn")=='SAVE' && $('#mode').val()=='E'){
	                if (key == 114) {   
	                	prepaymentDistributionSearchContent('accountsDetailsSearch.jsp');
	                }
                }
            }
            
        },
        
        columns: [                             
					{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
				    groupable: false, draggable: false, resizable: false,datafield: '',
				    columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
				    cellclassname: cellclassname,cellsrenderer: function (row, column, value) {
				        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
				    }    
					},
					{ text: 'Branch', datafield: 'branch', editable: false, cellclassname: cellclassname, width: '8%' },
					{ text: 'Doc Type', datafield: 'dtype', editable: false, cellclassname: cellclassname, width: '5%' },
					{ text: 'Doc No.', datafield: 'transno', editable: false, cellclassname: cellclassname, width: '6%' },
					
					{ text: 'Account', hidden: true, datafield: 'acno',  width: '5%' },
					{ text: 'Account No.', datafield: 'account', editable: false, cellclassname: cellclassname, width: '7%' },
					{ text: 'Account Name', datafield: 'accountname', editable: false, cellclassname: cellclassname, width: '15%'},	
					{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy', editable: false, cellclassname: cellclassname, width: '6%' },
					{ text: 'Description' , datafield: 'description', editable: false, cellclassname: cellclassname, width: '18%' },
					{ text: 'Amount', datafield: 'dramount', editable: false, cellclassname: cellclassname, width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
					{ text: ' ', datafield: 'editbtn', width: '6%', columntype: 'button', editable:false, cellclassname: cellclassname, filterable: false},
					{ text: 'Cost Type', datafield: 'costgroup', editable:false, cellclassname: cellclassname, width: '8%' },
					{ text: 'Cost Id', datafield: 'costtype', cellclassname: cellclassname, hidden: true, width: '8%' },
					{ text: 'Cost Code', datafield: 'costcode', editable:false, cellclassname: cellclassname, width: '5%'},
					{ text: 'St Date', datafield: 'stdate', columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy', cellclassname: cellclassname,  width: '10%',
						cellbeginedit: function (row) {
							if($('#prepaymentDistributionGridID').jqxGrid('getcellvalue',row, "editbtn")=='SAVE' && $('#mode').val()=='E'){
							} else {
					        	 return false;
					         }
						}
					},
					{ text: 'End Date', datafield: 'enddate', columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy', cellclassname: cellclassname,  width: '10%',
						cellbeginedit: function (row) {
							if($('#prepaymentDistributionGridID').jqxGrid('getcellvalue',row, "editbtn")=='SAVE' && $('#mode').val()=='E'){
							} else {
					        	 return false;
					         }
						} 
					},
					{ text: 'Post A/C', hidden: true, datafield: 'postacno',  width: '5%' },
					{ text: 'Post A/C No.', datafield: 'paccount', editable: false, cellclassname: cellclassname,  width: '10%' },
					{ text: 'Post A/C Name' , datafield: 'paccountname', editable: false, cellclassname: cellclassname,  width: '15%' },
					{ text: 'Group Type', datafield: 'grtype', hidden: true, width: '10%' },
					{ text: 'Tr No', hidden: true, datafield: 'trno',  width: '7%' },
					{ text: 'Tran Id', hidden: true, datafield: 'tranid',  width: '7%' },
					{ text: 'Branch Id', hidden: true, datafield: 'brhid',  width: '7%' },
					{ text: 'Row No', hidden: true, datafield: 'rowno',  width: '7%' },
					{ text: 'doc_no', hidden: true, datafield: 'doc_no', editable: false, cellclassname: cellclassname, width: '6%' },
				]
   
    });
   
    $("#overlay, #PleaseWait").hide();
    
    $("#prepaymentDistributionGridID").on('cellvaluechanged', function (event) {
  	   var rowindexestemp = event.args.rowindex;
  	   $('#rowindex').val(rowindexestemp);  
    });
    
    $('#prepaymentDistributionGridID').on('celldoubleclick', function (event) {
       	if(event.args.columnindex == 11)
          {
	           var rowindextemp = event.args.rowindex;
	           document.getElementById("rowindex").value = rowindextemp;
	           if($('#prepaymentDistributionGridID').jqxGrid('getcellvalue',rowindextemp, "editbtn")=='SAVE' && $('#mode').val()=='E'){
		           $('#prepaymentDistributionGridID').jqxGrid('clearselection');
		           costTypeSearchContent('costTypeSearchGrid.jsp');
               } 
          }
  		  
         if(event.args.columnindex == 13)
          {
	           var rowindextemp = event.args.rowindex;
	           document.getElementById("rowindex").value = rowindextemp;
	           if($('#prepaymentDistributionGridID').jqxGrid('getcellvalue',rowindextemp, "editbtn")=='SAVE' && $('#mode').val()=='E'){
		           $('#prepaymentDistributionGridID').jqxGrid('clearselection');
		           var value = $('#prepaymentDistributionGridID').jqxGrid('getcellvalue', rowindextemp, "costtype");
		           costCodeSearchContent('costCodeSearchGrid.jsp?costtype='+value);
           	   } 
          }
         
         if(event.args.columnindex == 17)
  		  {
  			var rowindextemp = event.args.rowindex;
  			document.getElementById("rowindex").value = rowindextemp;
  			if($('#prepaymentDistributionGridID').jqxGrid('getcellvalue',rowindextemp, "editbtn")=='SAVE' && $('#mode').val()=='E'){
  				prepaymentDistributionSearchContent('accountsDetailsSearch.jsp');
  			}
           } 
         
       });
   
    $("#prepaymentDistributionGridID").on('cellclick', function (event) {
  		 
    	  var datafield = event.args.datafield;
    	  var rowIndex = event.args.rowindex;
  			  
			  if(datafield=="editbtn"){
				  
				  if($('#prepaymentDistributionGridID').jqxGrid('getcellvalue',rowIndex, "editbtn")=='SAVE'){
	   					 
	   					 $.messager.confirm('Message', 'Do you want to save changes?', function(r){
	   				        
	   				     	if(r==false)
	   				     	  {
	   				     		return false; 
	   				     	  }
	   				     	else{
	   				     		
  				     		 	var docno = $('#prepaymentDistributionGridID').jqxGrid('getcellvalue', rowIndex, "doc_no");
  				     		 	var dtype = $('#prepaymentDistributionGridID').jqxGrid('getcellvalue', rowIndex, "dtype");
  				     		    var date = $('#prepaymentDistributionGridID').jqxGrid('getcelltext', rowIndex, "date");
  				     		    var trno = $('#prepaymentDistributionGridID').jqxGrid('getcellvalue', rowIndex, "trno");
  				     		 	var tranid = $('#prepaymentDistributionGridID').jqxGrid('getcellvalue', rowIndex, "tranid");
  				     		 	var acno = $('#prepaymentDistributionGridID').jqxGrid('getcellvalue', rowIndex, "acno");
  				     		 	var postacno = $('#prepaymentDistributionGridID').jqxGrid('getcelltext', rowIndex, "postacno");
  				     		 	var stdate = $('#prepaymentDistributionGridID').jqxGrid('getcelltext', rowIndex, "stdate");
  				     		 	var enddate = $('#prepaymentDistributionGridID').jqxGrid('getcelltext', rowIndex, "enddate");
  				     		    var costtype = $('#prepaymentDistributionGridID').jqxGrid('getcelltext', rowIndex, "costtype");
  				     		    var costcode = $('#prepaymentDistributionGridID').jqxGrid('getcelltext', rowIndex, "costcode");
  				     		    var amount = $('#prepaymentDistributionGridID').jqxGrid('getcellvalue', rowIndex, "dramount");
  				     		    var brhid = $('#prepaymentDistributionGridID').jqxGrid('getcelltext', rowIndex, "brhid");
  				     		 	var mode = $('#mode').val();
  				     		 
  				     		 	if(typeof(costtype) == "undefined" || typeof(costtype) == "NaN" || costtype == "" || costtype == "0"){
				     		 	 	$.messager.alert('Message','Costtype is Mandatory.','warning');
				 			  		return;
				     		 	}
  				     		 
  				     		    if(typeof(costcode) == "undefined" || typeof(costcode) == "NaN" || costcode == "" || costcode == "0"){
				     		 	 	$.messager.alert('Message','Costcode is Mandatory.','warning');
				 			  		return;
				     		 	}
  				     		 
  				     		    if(typeof(stdate) == "undefined" || typeof(stdate) == "NaN" || stdate == "" || stdate == "0"){
				     		 	 	$.messager.alert('Message','Start Date is Mandatory.','warning');
				 			  		return;
				     		 	}
  				     			
  				     		    if(typeof(enddate) == "undefined" || typeof(enddate) == "NaN" || enddate == "" || enddate == "0"){
				     		 	 	$.messager.alert('Message','End Date is Mandatory.','warning');
				 			  		return;
				     		 	}
  				     		
  				     		    if(typeof(postacno) == "undefined" || typeof(postacno) == "NaN" || postacno == "" || postacno == "0"){
  				     		 	 	$.messager.alert('Message','Post Account is Mandatory.','warning');
  				 			  		return;
  				     		 	}
  				     		 	
  				     		 	$("#overlay, #PleaseWait").show();
  				     		 
  				     		 	saveGridData(docno,dtype,date,trno,tranid,acno,postacno,stdate,enddate,costtype,costcode,amount,brhid,mode);	
	   				     	}
	   				 	});
	   					 
	   				  } else {
	   					$('#mode').val('E');$('#prepaymentDistributionGridID').jqxGrid('setcellvalue',rowIndex, "editbtn","SAVE");
	   					
	   				  }
			  }
    });
    
});

</script>
<div id="prepaymentDistributionGridID"></div>
<input type="hidden" id="rowindex"/> 