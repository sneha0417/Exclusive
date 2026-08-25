<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="com.sales.Sales.salesInvoice.ClsSalesInvoiceDAO"%>
<%ClsSalesInvoiceDAO DAO= new ClsSalesInvoiceDAO();%>
<% 
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




%>
 
<style>
#jqxInput1{
	background-color:#fff;
}
</style>
 
  <script type="text/javascript">
 
            $(document).ready(function () {
                
            	 var dd2='<%=DAO.searchProduct(session,prodsearchtype,rrefno,reftype,cmbprice,clientid,cmbreftype,location,clientcaid,dates,cmbbilltype)%>';
            	 
            	 
                // prepare the data
                var source =
                {
                    datatype: "json",
                    datafields: [
                                 {name : 'part_no', type: 'string'  },
                                 {name : 'productname', type: 'string'  },
                                 {name : 'doc_no', type: 'string'  },
                                 {name : 'unit', type: 'string'  },
                                 {name : 'unitdocno', type: 'string'  },
                                 {name : 'psrno', type: 'string'  },
                                 {name : 'specid', type: 'string'  },
                                  
                                 {name : 'unitprice', type: 'string'  },
                               
                              
                                 
                                 {name : 'brandname', type: 'string'  },    
                                 {name : 'taxper', type: 'number'  },
                                 {name : 'balqty', type: 'number'  },
                    ],
                    localdata: dd2,
                };
                var dataAdapter = new $.jqx.dataAdapter(source);
                // Create a jqxInput
                 
                $("#jqxInput1").jqxInput({ source: dataAdapter, displayMember: "productname", valueMember: "psrno", width: 260, height: 20});
                
                $("#jqxInput1").on('select', function (event) {
              	  if (event.args) {
                        var item = event.args.item;
                        if (item) {
                            for (var i = 0; i < dataAdapter.records.length; i++) {
                                if (item.value == dataAdapter.records[i].psrno) {
                                	 
                                    document.getElementById("jqxInput").value=dataAdapter.records[i].part_no;
                                    document.getElementById("temppsrno").value=dataAdapter.records[i].psrno;
                                    document.getElementById("tempspecid").value=dataAdapter.records[i].specid;
                                    getunit(dataAdapter.records[i].psrno);
                                    
                                    
                                    document.getElementById("unit").value=dataAdapter.records[i].unitdocno;
                                
                                    
                                    document.getElementById("brand").value=dataAdapter.records[i].brandname; 
                                    funRoundAmt(dataAdapter.records[i].taxper,"taxpers");
                                    funRoundAmt(dataAdapter.records[i].unitprice,"uprice");
                                    document.getElementById("errormsg").innerText="";
                                    
                                    document.getElementById("quantity").value="";
                                    document.getElementById("focs").value="";
                                    
                                    document.getElementById("quantity").focus();
                                   
                                    document.getElementById("stockmsg").innerText="";
                                  //  document.getElementById("stockmsg").innerText=" Stock : "+dataAdapter.records[i].balqty;
                                    
                                    document.getElementById("totalstock").value=dataAdapter.records[i].balqty;
                                    break;
                                }
                            }
                            

                             
                        }
                    }
                  }); 
            });
        </script>
        <input id="jqxInput1" />
        <br />
         