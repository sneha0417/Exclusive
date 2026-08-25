 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@page import="com.dashboard.analysis.amcincomeexpense.ClsAmcIncomeExpense" %>
<%ClsAmcIncomeExpense sd=new ClsAmcIncomeExpense(); %>
     

 <% String radval =request.getParameter("radval")==null?"0":request.getParameter("radval").toString();%>
 <% String frmdate =request.getParameter("frmdate")==null?"0":request.getParameter("frmdate").toString();%>
 <% String todate =request.getParameter("todate")==null?"0":request.getParameter("todate").toString();%>
 <% String branch =request.getParameter("barchval")==null?"0":request.getParameter("barchval").toString();%>
 <% String clientid =request.getParameter("clientid")==null?"0":request.getParameter("clientid").toString();%>
 <% int id =request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id").toString());%>
 <% String dtype =request.getParameter("dtype")==null?"0":request.getParameter("dtype").toString();%>
 <% String jbaction =request.getParameter("jbaction")==null?"0":request.getParameter("jbaction").toString();%>
 

<style type="text/css">
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
    
</style>
 <script type="text/javascript">
 var incexpdata;
 var id='<%=id%>';
 
 if(id>0){
	 
	 incexpdata= '<%= sd.incomeExpenseGridLoad(session,frmdate,todate,branch,clientid,id,radval,dtype,jbaction) %>'; 
	
 }
    
        $(document).ready(function () {
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                             

							{name : 'dtype', type: 'String'  },
     						{name : 'docno', type: 'String'  },
     						{name : 'client', type: 'String' },
     						{name : 'salname', type: 'String' },
     						{name : 'sdate', type: 'String' },
     						{name : 'edate', type: 'String' },
     						{name : 'dueno', type: 'String' },
     						{name : 'cntramt',type: 'number' },
     						{name : 'invamt',type: 'number' },
     						{name : 'inc',type: 'number' },
     						{name : 'exp',type: 'number' }
     						
     						
     			  ],
                 localdata: incexpdata,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
                             

            var cellclassname = function (row, column, value, data) {
            	
       		 if (data.gridrow==1) {
                   return "orangeClass";
               };
           };
           
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxincexpGrid").jqxGrid(
            {
                width: '99.5%',
                height: 500,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                //pagermode: 'default',
                sortable: true,
                //Add row method
                columns: [
                       
                    
					{ text: 'CONTR.TYPE',columntype: 'textbox', datafield: 'dtype', width: '8%',cellclassname:cellclassname },
					{ text: 'CONTRACT NO',columntype: 'textbox',  datafield: 'docno', width: '8%',cellclassname:cellclassname },
					{ text: 'CLIENT NAME',columntype: 'textbox',  datafield: 'client',cellclassname:cellclassname },
					{ text: 'START DATE',columntype: 'textbox',  datafield: 'sdate', width: '10%',cellclassname:cellclassname },
					{ text: 'END DATE',columntype: 'textbox',  datafield: 'edate', width: '10%',cellclassname:cellclassname },
					{ text: 'INCOME AMOUNT',columntype: 'textbox',  datafield: 'inc', width: '10%',cellclassname:cellclassname, cellsformat: 'd2', cellsalign: 'right', align: 'right' },
                    { text: 'EXPENSE AMOUNT',columntype: 'textbox',  datafield: 'exp', width: '10%',cellclassname:cellclassname, cellsformat: 'd2', cellsalign: 'right', align: 'right' }
					
					]
            });

             $('#jqxincexpGrid').on('rowdoubleclick', function (event) 
            		{ 
		            	var rowindex1=event.args.rowindex;
		            	
		           
            		 });
            $("#overlay, #PleaseWait").hide();
        });
    </script>
    <div id="jqxincexpGrid"></div>
