<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="com.operations.crm.callregister.ClsCallRegisterDAO"%>
<%ClsCallRegisterDAO DAO= new ClsCallRegisterDAO();%>
<%String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno");%>
<style>
#jqxInput{
	background-color:#fff;
	height: 20px;
}
</style>
<script type="text/javascript"> 
$(document).ready(function () {
	var aa1= '<%=DAO.searchVehicle(session,cldocno)%>';
// 	DAO.searchProduct(session,prodsearchtype,rrefno,location,reftype)
	var source =
	{
			datatype: "json",
			datafields: [
                                 {name : 'regno', type: 'string'  },
                                 {name : 'fleetno', type: 'string'  },
                                 {name : 'others', type: 'string'  },
                                 {name : 'client', type: 'string'  },
                                 {name : 'cldocno', type: 'string'  },
                                 {name : 'acno', type: 'string'  },
                    ],
                    localdata: aa1,
     };
                var dataAdapter = new $.jqx.dataAdapter(source);
                // Create a jqxInput
                 
                $("#jqxInput").jqxInput({ source: dataAdapter, displayMember: "regno", valueMember: "regno", width: 140, height: 20});
                
            $("#jqxInput").on('select', function (event) {
            	  if (event.args) {
                      var item = event.args.item;
                      if (item) {
                          

                          for (var i = 0; i < dataAdapter.records.length; i++) { 
                              if (item.value == dataAdapter.records[i].regno) {
                                  document.getElementById("txtvehicleno").value=dataAdapter.records[i].fleetno;
                                  document.getElementById("txtvehicle").value=dataAdapter.records[i].others;
                                  /* document.getElementById("txtclientdocno").value=dataAdapter.records[i].cldocno;
                                  document.getElementById("txtclientname").value=dataAdapter.records[i].client;
                                  document.getElementById("txtclientacno").value=dataAdapter.records[i].acno; */
                                  document.getElementById("txtregno").value=dataAdapter.records[i].regno;
                                  
                                  document.getElementById("txtcontactperson").focus();
                                  break;
                              }
                          }
                          

                           
                      }
                  }
                });  
            });
        </script>
         <input id="jqxInput" />
     