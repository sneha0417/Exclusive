<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.audit.goodsIssueNote.ClsGoodsIssueNoteDAO"%>
<% ClsGoodsIssueNoteDAO searchDAO = new ClsGoodsIssueNoteDAO(); %> 


<%
    String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
//System.out.println("fromdate="+fromdate+"todate="+todate);
%>
<script type="text/javascript">


var datamain= '<%=searchDAO.goodsIssueGrid(barchval,fromdate,todate) %>'; 
        $(document).ready(function () { 
                     
            // prepare the data
            var source =
            {                            
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int'   },
                            {name : 'voc_no', type: 'int'   },
                            {name : 'date', type: 'date'   },
     						{name : 'type', type: 'string'   },
     						{name : 'desc1', type: 'string'   },
     						{name : 'refno', type: 'string'   },
     						{name : 'prjname', type: 'string'   },
     						{name : 'costgroup', type: 'string'   },
                        ],
                		localdata: datamain, 
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#goodsissuenote").jqxGrid(
            {
                width: '100%',
                height: 283,
                source: dataAdapter,
           
                selectionmode: 'singlerow',
                
                columns: [
                          
                            { text: 'Doc No', datafield: 'doc_no', width: '6%',hidden:true },
                            { text: 'Doc No11', datafield: 'voc_no', width: '10%' },
							{ text: 'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
	 
							{ text: 'Type', datafield: 'type', width: '15%'},
							{ text: 'Group', datafield: 'costgroup', width: '10%'  },
						    { text: 'Name', datafield: 'prjname', width: '20%'  },
						  					      
						    { text: 'Ref No', datafield: 'refno', width: '10%'  },
							{ text: 'Description', datafield: 'desc1', width: '25%' },
				 
							 
						]
            });
            $("#overlay, #PleaseWait").hide();
             $('#goodsissuenote').on('rowdoubleclick', function (event) {
            	    var rowindex1 = event.args.rowindex;
            	       $('#audit').attr('disabled',false);
            	       $("#goodsIssueNoteGrd").jqxGrid({disabled: false});
            	       document.getElementById("docno").value= $('#goodsissuenote').jqxGrid('getcellvalue', rowindex1, "doc_no");  
            		  $("#listDetailDiv").load("goodsIssueNoteGridDetail.jsp?doc_no="+$('#goodsissuenote').jqxGrid('getcellvalue', rowindex1, "doc_no"));
            	    });  
             
        });
    </script>
    <div id="goodsissuenote"></div>