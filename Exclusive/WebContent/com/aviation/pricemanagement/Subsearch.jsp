<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.aviation.pricemanagement.ClsPriceManagementDAO"%>
<% ClsPriceManagementDAO DAO = new ClsPriceManagementDAO(); %> 


<%
String type = request.getParameter("type")==null?"NA":request.getParameter("type");
String docno = request.getParameter("docno")==null?"NA":request.getParameter("docno");
String clientname = request.getParameter("clientname")==null?"NA":request.getParameter("clientname");
String date = request.getParameter("date")==null?"0":request.getParameter("date");
String note = request.getParameter("note")==null?"0":request.getParameter("note");
String aa = request.getParameter("aa")==null?"NA":request.getParameter("aa"); 
String product= request.getParameter("product")==null?"NA":request.getParameter("product"); 
%>
<script type="text/javascript">

var datamain= '<%=DAO.mainsearch(session,docno,type,clientname,date,aa,product,note) %>'; 
        $(document).ready(function () { 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int'},
                            {name : 'voc_no', type: 'int'},
                            {name : 'date', type: 'date'},
     						{name : 'dtype', type: 'string'},
     						{name : 'cldocno', type: 'string'},
     						{name : 'refname', type: 'string'},
     						{name : 'psrno', type: 'string'},
     						{name : 'part_no', type: 'string'},
     						{name : 'productname', type: 'string'},
     						{name : 'currency', type: 'string'},
     						{name : 'currate', type: 'string'},
                        	{name : 'validfrom', type: 'date'},
     						{name : 'pnotes', type: 'string'},
     						{name : 'validupto', type: 'date'},
     						{name : 'currid', type: 'string'}
                        ],
                		localdata: datamain, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#mainsearshgrid").jqxGrid(
            {
                width: '100%',
                height: 283,
                source: dataAdapter,
           
                selectionmode: 'singlerow',
                
                columns: [
                         
                            { text: 'Doc No', datafield: 'voc_no', width: '10%' },
                            { text: 'doc_no', datafield: 'doc_no', width: '6%',hidden: true },
							{ text: 'Date', datafield: 'date', width: '20%',cellsformat:'dd.MM.yyyy' },
							{ text: 'Type', datafield: 'dtype', width: '10%' },
							{ text: 'cldocno', datafield: 'cldocno', width: '6%',hidden: true },
							{ text: 'Client Name', datafield: 'refname', width: '30%' },
							{ text: 'psrno', datafield: 'psrno', width: '14%',cellsformat: 'd2', cellsalign: 'right', align:'right',hidden:true },
							{ text: 'part_no', datafield: 'part_no', width: '5%',hidden:true },
							{ text: 'Product Name', datafield: 'productname', width: '30%' ,hidden:false },
							{ text: 'currency', datafield: 'currency', width: '2%' ,hidden:true},
							{ text: 'currate', datafield: 'currate', width: '8%',hidden:true },
							{ text: 'currid',  datafield: 'currid', width: '5%' ,hidden:true},
							{ text: 'validfrom', datafield: 'validfrom', width: '24%',hidden:true,cellsformat:'dd.MM.yyyy'},
							{ text: 'validupto', datafield: 'validupto', width: '2%' ,hidden:true,cellsformat:'dd.MM.yyyy'},
							{ text: 'pnotes', datafield: 'pnotes', width: '2%',hidden:true },
										
						]
            });
            
             $('#mainsearshgrid').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("docno").value = $('#mainsearshgrid').jqxGrid('getcellvalue',rowindex1, "voc_no");
                document.getElementById("masterdoc_no").value = $('#mainsearshgrid').jqxGrid('getcellvalue',rowindex1, "doc_no");
                document.getElementById("frmpmgtmt").submit();
            }); 
             
        });
    </script>
    <div id="mainsearshgrid"></div>