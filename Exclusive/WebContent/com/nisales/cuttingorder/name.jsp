 <%@page import="com.nisales.cuttingorder.ClsCuttingOrderDAO"%>
<% ClsCuttingOrderDAO  ClsCuttingOrderDAO = new ClsCuttingOrderDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");

%>
 
<style>
#jqxInput1{
	background-color:#fff;
}
</style>
 
  <script type="text/javascript">
  
 
            $(document).ready(function () {
                
            	var	 dd2='<%=ClsCuttingOrderDAO.searchProduct(session,id)%>';
            	 
            	 
                // prepare the data
                var source =
                {
                    datatype: "json",
                    datafields: [
                        { name: 'psrno' },
                        { name: 'part_no' },
                        { name: 'productname' },
                        {name : 'unit' },
                        {name : 'munit' },
                        {name : 'psrno' },
                        {name : 'specid'  },
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
                                    document.getElementById("tempunit").value=dataAdapter.records[i].unit;
                                    document.getElementById("tempunitdocno").value=dataAdapter.records[i].munit;
                                    document.getElementById("floor").focus();
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
         