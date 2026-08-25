<%@page import="com.controlcentre.audit.yearendclose.ClsYearEndCloseDAO" %>
<%ClsYearEndCloseDAO cycd=new ClsYearEndCloseDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String docNo = request.getParameter("docNo")==null?"0":request.getParameter("docNo");
 String date = request.getParameter("date")==null?"0":request.getParameter("date");
 String yrcAccFrmDate = request.getParameter("yrcAccFrmDate")==null?"0":request.getParameter("yrcAccFrmDate");
 String yrcAccToDate = request.getParameter("yrcAccToDate")==null?"0":request.getParameter("yrcAccToDate");
%> 

 <script type="text/javascript">
 
 			var data3='<%=cycd.yrcMainSearch(session, docNo, date, yrcAccFrmDate, yrcAccToDate)%>';
			 $(document).ready(function () { 

        	var source = 
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int' },
     						{name : 'date', type: 'date'  },
     						{name : 'yearclose_from', type: 'date' }, 
     						{name : 'yearclose_to', type: 'date' },
     						{name : 'nextyear_from', type: 'date' }, 
     						{name : 'nextyear_to', type: 'date' },
     						{name : 'tr_no', type: 'int' }
                          	],
                          	localdata: data3,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#yearEndCloseMainSearch").jqxGrid(
            {
                width: '99%',
                height: 300,
                source: dataAdapter,
                selectionmode: 'singlerow',
     			editable: false,
     			columnsresize: true,
     			localization: {thousandsSeparator: ""},
     			
                columns: [
					 { text: 'Doc No', datafield: 'doc_no', width: '20%' },
					 { text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '20%' },
					 { text: 'Accounting Year From', datafield: 'yearclose_from', cellsformat: 'dd.MM.yyyy' , width: '30%' },
					 { text: 'Accounting Year To', datafield: 'yearclose_to',cellsformat: 'dd.MM.yyyy' , width: '30%' },
					 { text: 'Next Accounting Year From', datafield: 'nextyear_from', cellsformat: 'dd.MM.yyyy' , hidden: true, width: '10%' },
					 { text: 'Next Accounting Year To', datafield: 'nextyear_to',cellsformat: 'dd.MM.yyyy' , hidden: true, width: '10%' },
					 { text: 'Tr No', datafield: 'tr_no', width: '10%', hidden: true },
					]
            });
            
			  $('#yearEndCloseMainSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
				funReset();
                document.getElementById("docno").value= $('#yearEndCloseMainSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("txttrno").value= $('#yearEndCloseMainSearch').jqxGrid('getcellvalue', rowindex1, "tr_no");
                $('#yearEndDate').jqxDateTimeInput({disabled:false});$('#accountingYearFrom').jqxDateTimeInput({disabled:false});
        		$('#accountingYearTo').jqxDateTimeInput({disabled:false});$('#ycloseDateFrom').jqxDateTimeInput({disabled:false});
        		$('#ycloseDateTo').jqxDateTimeInput({disabled:false});
        		$("#yearEndDate").jqxDateTimeInput('val', $("#yearEndCloseMainSearch").jqxGrid('getcellvalue', rowindex1, "date"));
        		$("#accountingYearFrom").jqxDateTimeInput('val', $("#yearEndCloseMainSearch").jqxGrid('getcellvalue', rowindex1, "yearclose_from"));
        		$("#accountingYearTo").jqxDateTimeInput('val', $("#yearEndCloseMainSearch").jqxGrid('getcellvalue', rowindex1, "yearclose_to"));
        		$("#ycloseDateFrom").jqxDateTimeInput('val', $("#yearEndCloseMainSearch").jqxGrid('getcellvalue', rowindex1, "nextyear_from"));
        		$("#ycloseDateTo").jqxDateTimeInput('val', $("#yearEndCloseMainSearch").jqxGrid('getcellvalue', rowindex1, "nextyear_to"));
                //funSetlabel();
                //document.getElementById("frmYearEndClose").submit();
                
        		var indexVal = $('#yearEndCloseMainSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
       		 	var indexVal1 = $('#yearEndCloseMainSearch').jqxGrid('getcellvalue', rowindex1, "tr_no");
       		 	if(indexVal>0){
                	$("#yearEndCloseDiv").load("yearEndCloseGrid.jsp?docno="+indexVal+"&trno="+indexVal1); 
                	$("#yearEndCloseGroupDiv").load("yearEndCloseGroupGrid.jsp?docno="+indexVal+"&trno="+indexVal1);
       		    }
       		 
                $('#yearEndDate').jqxDateTimeInput({disabled:true});$('#accountingYearFrom').jqxDateTimeInput({disabled:true});
        		$('#accountingYearTo').jqxDateTimeInput({disabled:true});$('#ycloseDateFrom').jqxDateTimeInput({disabled:true});
        		$('#ycloseDateTo').jqxDateTimeInput({disabled:true});
                
               $('#window').jqxWindow('close');
            });   
				           
}); 
				       
                       
    </script>
    <div id="yearEndCloseMainSearch"></div>
    