 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.sales.Sales.salesInvoice.ClsSalesInvoiceDAO"%>
<%ClsSalesInvoiceDAO DAO= new ClsSalesInvoiceDAO();

String prodsearchtype=request.getParameter("prodsearchtype")==null?"0":request.getParameter("prodsearchtype").trim();
String rrefno=request.getParameter("enqmasterdocno")==null?"0":request.getParameter("enqmasterdocno").trim();
String reftype=request.getParameter("reftype")==null?"0":request.getParameter("reftype").trim();

String cmbprice=request.getParameter("cmbprice")==null?"0":request.getParameter("cmbprice").trim();

String clientid=request.getParameter("clientid")==null?"0":request.getParameter("clientid").trim();
String cmbreftype=request.getParameter("cmbreftype")==null?"0":request.getParameter("cmbreftype").trim();

String location=request.getParameter("location")==null?"0":request.getParameter("location").trim();

String clientcaid=request.getParameter("clientcaid")==null?"0":request.getParameter("clientcaid").trim();

String dates=request.getParameter("dates")==null?"0":request.getParameter("dates").trim();
String cmbbilltype=request.getParameter("cmbbilltype")==null?"0":request.getParameter("cmbbilltype").trim();

System.out.println("=====reftype===="+reftype);

System.out.println("=====clientid===="+clientid);

System.out.println("=====cmbreftype===="+cmbreftype);

System.out.println("=====clientcaid===="+clientcaid);

%>



<script type="text/javascript">
var prodsearchdata1;
var clientcaid='<%=clientcaid%>'; 
 
if(clientcaid>0)
	{
	
	
  prodsearchdata1='<%=DAO.hidesearchProduct(session,prodsearchtype,rrefno,reftype,cmbprice,clientid,cmbreftype,location,clientcaid,dates,cmbbilltype)%>';
	}
else
	{
	prodsearchdata1;
	}
		$(document).ready(function () { 	
           
			var source =
            {
                datatype: "json",  
                datafields: [
                              {name : 'doc_no', type: 'int'  },
                              {name : 'allowdiscount', type: 'number'  },
                              
                              
                            ],
                       localdata: prodsearchdata1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#hidegrids").jqxGrid(
            {
                width: '50%',
                height: 350,
                source: dataAdapter,
                 
                selectionmode: 'singlerow',
                       
                columns: [
                              { text: 'Doc_no', datafield: 'doc_no', width: '40%'},
                              { text: 'allowdiscount', datafield: 'allowdiscount', width: '60%' },
                              
                              
						]
            });
            
             
    
        });
    </script>
    <div id="hidegrids"></div> 