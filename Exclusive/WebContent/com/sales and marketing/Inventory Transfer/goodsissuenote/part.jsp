<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="com.sales.InventoryTransfer.goodsissuenote.ClsGoodsissuenoteDAO"%>
<% ClsGoodsissuenoteDAO searchDAO = new ClsGoodsissuenoteDAO(); %> 
<%
String refmasterdoc_no=request.getParameter("refmasterdoc_no")==null?"0":request.getParameter("refmasterdoc_no").trim();
String id = request.getParameter("id")==null?"0":request.getParameter("id");
String productname = request.getParameter("productsname")==null?"0":request.getParameter("productsname");
String brandname = request.getParameter("brandsname")==null?"0":request.getParameter("brandsname");
String gridunit = request.getParameter("gridunit")==null?"0":request.getParameter("gridunit");
String gridprdname = request.getParameter("gridprdname")==null?"0":request.getParameter("gridprdname");
String scope = request.getParameter("scopeid")==null?"0":request.getParameter("scopeid");
String scopeproduct = request.getParameter("scopeproduct")==null?"0":request.getParameter("scopeproduct");
String gridcategory = request.getParameter("gridcategory")==null?"0":request.getParameter("gridcategory");
String gridssubcategory = request.getParameter("gridssubcategory")==null?"0":request.getParameter("gridssubcategory");


String locid=request.getParameter("locid")==null?"0":request.getParameter("locid").trim();
String date=request.getParameter("date")==null?"0":request.getParameter("date");

%>
 
<style>
#jqxInput{
	background-color:#fff;
	height: 20px;
	
}
</style>
 
  <script type="text/javascript">   
	 
 
            $(document).ready(function () {
            var aa1= '<%=searchDAO.searchProduct(session,locid,date,productname,brandname,id,gridunit,gridprdname,gridcategory,gridssubcategory)%>';
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
                    ],
                    localdata: aa1,
                };
                var dataAdapter = new $.jqx.dataAdapter(source);
                // Create a jqxInput
                 
                $("#jqxInput").jqxInput({ source: dataAdapter, displayMember: "part_no", valueMember: "psrno", width: 140, height: 20});
                
            $("#jqxInput").on('select', function (event) {
            	  if (event.args) {
                      var item = event.args.item;
                      if (item) {
                          

                          for (var i = 0; i < dataAdapter.records.length; i++) { 
                              if (item.value == dataAdapter.records[i].psrno) {
                            	  
                            	  
                            	 
                                  document.getElementById("jqxInput1").value=dataAdapter.records[i].productname;
                                  document.getElementById("temppsrno").value=dataAdapter.records[i].psrno;
                                  document.getElementById("tempspecid").value=dataAdapter.records[i].specid;
                                  getunit(dataAdapter.records[i].psrno);
                                  document.getElementById("unit").value=dataAdapter.records[i].unitdocno;
                                  document.getElementById("brand").value=dataAdapter.records[i].brandname;
                                  
                              /*     funRoundAmt(dataAdapter.records[i].taxper,"taxpers");
                                  funRoundAmt(dataAdapter.records[i].unitprice,"uprice"); */
                                  
                                   
                                  document.getElementById("quantity").focus();
                                  
                                  break;
                              }
                          }
                          

                           
                      }
                  }
                });  
            });
        </script>
         <input id="jqxInput" />
     