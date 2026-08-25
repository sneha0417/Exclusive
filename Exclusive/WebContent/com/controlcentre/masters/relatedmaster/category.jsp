<%@page import="com.controlcentre.masters.relatedmaster.hoteltype.ClsHotelDAO"%>  
<% ClsHotelDAO DAO=new ClsHotelDAO();%>
       <script type="text/javascript">
       var cdata;
       <%-- cdata= '<%=DAO.roomDetailsCat() %>'; --%>      
		$(document).ready(function () { 	
            var source =
            { 
                datatype: "json",
                datafields: [
                             {name : 'remarks', type: 'string'  },
                             {name : 'doc_no', type: 'string'  },
                        ],
                		
                		//  url: url1,
                 localdata: cdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxcat").jqxInput({ source: dataAdapter, displayMember: "remarks", valueMember: "doc_no", width: 190, height: 20});
            $("#jqxcat").on('select', function (event) {            
            	  if (event.args) {
                      var item = event.args.item;           
                      if (item) {
                          for (var i = 0; i < dataAdapter.records.length; i++) {   
                              if (item.value == dataAdapter.records[i].doc_no) {   
                                  document.getElementById("catdoc").value=dataAdapter.records[i].doc_no;
                                  break;   
                              }   
                          }
                      }
                  }      
                }); 
                  }); 
    </script>  
    <input id="jqxcat"/> 