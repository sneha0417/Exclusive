 <%@page import="com.nisales.deliverynote.ClsDeliveryNoteDAO"%>
<% ClsDeliveryNoteDAO  sDAO = new ClsDeliveryNoteDAO();  

String id=request.getParameter("id")==null?"0":request.getParameter("id");
 

%>
 
<style>
#jqxInput{
	background-color:#fff;
	height: 20px;
	
}
</style>
 
  <script type="text/javascript">
  
 
            $(document).ready(function () {
                
            	var	 aa1='<%=sDAO.searchProduct(session,id,"","")%>';
            	 
            	 
                // prepare the data
                var source =
                {
                    datatype: "json",
                    datafields: [
                        { name: 'psrno' },
                        { name: 'part_no' },
                        { name: 'productname' },
                        {name : 'unit'  },
                        {name : 'munit'   },
                        {name : 'psrno'  },
                        {name : 'specid'  },
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
                                  document.getElementById("tempunit").value=dataAdapter.records[i].unit;
                                  document.getElementById("tempunitdocno").value=dataAdapter.records[i].munit;
                                  document.getElementById("jqxInput1").focus();
                                  
                                  break;
                              }
                          }
                          

                           
                      }
                  }
                });  
            });
        </script>
         <input id="jqxInput" />
     