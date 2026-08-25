<%@page import="com.fixedassets.assets.assetssalesinvoice.ClsAssetSalesInvDAO" %>
<%ClsAssetSalesInvDAO asi=new ClsAssetSalesInvDAO(); %>

<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>
 --%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String searchdate = request.getParameter("searchdate")==null?"":request.getParameter("searchdate");
 String name = request.getParameter("name")==null?"0":request.getParameter("name");
 String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");
String acno=request.getParameter("acno")==null?"0":request.getParameter("acno");
String mobile=request.getParameter("mobile")==null?"0":request.getParameter("mobile");
String id=request.getParameter("id")==null?"0":request.getParameter("id");
%> 
<script type="text/javascript">
var dataclient;
var id='<%=id%>';
if(id=="1"){
	dataclient='<%=asi.clientSearch(searchdate,name,docno,acno,mobile)%>';	
}
else{
	
}
	

		$(document).ready(function () { 	
            

            //var url="demo.txt"; 
        	var num = 0;
            var source =
            {
                datatype: "json",
                datafields: [

                          	{name : 'cldocno' , type: 'String' },
     						{name : 'refname',type:'String'},
     						{name : 'address',type:'String'},
     						{name : 'per_mob',type:'String'},
     						{name : 'acno',type :'String'},
     						{name : 'mail1',type:'String'},
     					
                 ],
                localdata: dataclient,
                //url: url,
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#clientSearch").jqxGrid(
            {
                width: '100%',
                height: 280,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                //sortable: true,
                selectionmode: 'singlerow',
                //Add row method
                columns: [
							{ text: 'Doc No', datafield: 'cldocno', width: '25%' },
							{ text: 'Name',datafield:'refname',width:'25%'},
							{ text:'Mobile',datafield:'per_mob',width:'25%'},
							{ text:'Ac No',datafield:'acno',width:'25%'},
							{ text:'Address',datafield:'address',width:'16.66%',hidden:true},
							{ text:'Mail',datafield:'mail1',width:'16.66%',hidden:true}
							]
            });
           
           $('#clientSearch').on('rowdoubleclick', function (event) {
            	var rowindex1=event.args.rowindex;
            	var temp="";
              
            	document.getElementById("client").value=$('#clientSearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
            	temp=$('#clientSearch').jqxGrid('getcellvalue', rowindex1, "refname");
            	temp=temp+",Address: "+$('#clientSearch').jqxGrid('getcellvalue', rowindex1, "address");
            	temp=temp+",Mobile: "+$('#clientSearch').jqxGrid('getcellvalue', rowindex1, "per_mob");
            	temp=temp+",Mail: "+$('#clientSearch').jqxGrid('getcellvalue', rowindex1, "mail1");
              	document.getElementById("clientname").value=temp;
              	document.getElementById("clientacno").value=$('#clientSearch').jqxGrid('getcellvalue', rowindex1, "acno");
               $('#clientwindow').jqxWindow('close');
                
            }); 

        });
    </script>
    <div id="clientSearch"></div>
