<%@page import="com.controlcentre.masters.relatedmaster.hoteltype.ClsHotelDAO" %>
<%ClsHotelDAO csd=new ClsHotelDAO(); %>

<script type="text/javascript">
  		
  		var datasm= '<%=csd.hotelsearch()%>';
        
  		$(document).ready(function () { 	
         
            var source =
            {
            		
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'int' },
     						{name : 'area', type: 'String'  },
                          	{name : 'name', type: 'String'  },
                          	{name : 'areaid', type: 'String'  },
                          	{name : 'vendor', type: 'String'  },
                          	{name : 'vendid', type: 'String'  },
                          	{name : 'location', type: 'String' },
                          	{name : 'lat', type: 'String'  },
                          	{name : 'longitude',type:'String'},
                          	{name : 'infmin' , type: 'int' },
                          	{name : 'infmax' , type: 'int' },
                          	{name : 'childmin' , type: 'int' },
                          	{name : 'childmax' , type: 'int' },
                          	{name : 'teenmin' , type: 'int' },
                          	{name : 'teenmax' , type: 'int' },
                          	{name : 'rating' , type: 'String' },
                          	
                          	
                 ],
               localdata: datasm,
        
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
            $("#jqxhotelSearch").jqxGrid(
            {
            	width: '100%',
                height: 340,
                source: dataAdapter,
                sortable: true,
                filtermode:'excel',
                filterable: true,
                selectionmode: 'singlerow',
                columnsresize: true,
                showfilterrow:true,
                
                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '20%' },
					{ text: 'Name', datafield: 'name', width: '40%' },
					 { text: 'Areaid', datafield: 'areaid',hidden:true },
					 { text: 'Area', datafield: 'area',hidden:false },
					 { text: 'vendorid', datafield: 'vendid', width: '40%',hidden:true },
					 { text: 'vendor', datafield: 'vendor', width: '40%',hidden:true },
					 { text: 'Location', datafield: 'location', hidden:false},
  					{ text: 'Longitude', datafield: 'longitude', width: '40%',hidden:true },
  					{ text: 'Latitude',datafield:'lat',width:'40%',hidden:true},
  					{ text: 'infmin',datafield:'infmin',hidden:true},
  					{ text: 'infmax',datafield:'infmax',hidden:true},
  					{ text: 'childmin',datafield:'childmin',hidden:true},
  					{ text: 'childmax',datafield:'childmax',hidden:true},
  					{ text: 'teenmin',datafield:'teenmin',hidden:true},
  					{ text: 'teenmax',datafield:'teenmax',hidden:true},
  					{ text: 'rating',datafield:'rating',hidden:true},
	              ]
            });
            
            $('#jqxhotelSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $("#jqxhotelSearch").jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("name").value = $("#jqxhotelSearch").jqxGrid('getcellvalue', rowindex1, "name");
                document.getElementById("txtarea").value = $("#jqxhotelSearch").jqxGrid('getcellvalue', rowindex1, "area");
                document.getElementById("txtareaid").value = $("#jqxhotelSearch").jqxGrid('getcellvalue', rowindex1, "areaid");
                document.getElementById("vendor").value = $("#jqxhotelSearch").jqxGrid('getcellvalue', rowindex1, "vendor");
                document.getElementById("vendid").value = $("#jqxhotelSearch").jqxGrid('getcellvalue', rowindex1, "vendid");
                document.getElementById("location").value= $("#jqxhotelSearch").jqxGrid('getcellvalue', rowindex1, "location"); 
                document.getElementById("longitude").value = $("#jqxhotelSearch").jqxGrid('getcellvalue', rowindex1, "longitude");
                document.getElementById("latitude").value= $("#jqxhotelSearch").jqxGrid('getcellvalue', rowindex1, "lat");
                document.getElementById("txtinfmin").value= $("#jqxhotelSearch").jqxGrid('getcellvalue', rowindex1, "infmin");
                document.getElementById("txtinfmax").value= $("#jqxhotelSearch").jqxGrid('getcellvalue', rowindex1, "infmax");
                document.getElementById("txtchildmin").value= $("#jqxhotelSearch").jqxGrid('getcellvalue', rowindex1, "childmin");
                document.getElementById("txtchildmax").value= $("#jqxhotelSearch").jqxGrid('getcellvalue', rowindex1, "childmax");
                document.getElementById("txtteenmin").value= $("#jqxhotelSearch").jqxGrid('getcellvalue', rowindex1, "teenmin");
                document.getElementById("txtteenmax").value= $("#jqxhotelSearch").jqxGrid('getcellvalue', rowindex1, "teenmax");
                document.getElementById("txthidrating").value= $("#jqxhotelSearch").jqxGrid('getcellvalue', rowindex1, "rating");
                $('#window').jqxWindow('close');
                if(document.getElementById("location").value!=""){
       			 document.getElementById("pac-input").value=document.getElementById("location").value;
                }
       			//document.getElementById("mode").value="view";
       				$('#frmHotelType input').attr('disabled', false );
		            $('#frmHotelType select').attr('disabled', false ); 
       			document.getElementById("frmHotelType").submit();
                 /*map=null;
       			$('#mapdiv').load('map.jsp?latitude='+document.getElementById("latitude").value+'&longitude='+document.getElementById("longitude").value);*/ 
       		 	
            }); 
           
        });
    </script>
    <div id="jqxhotelSearch"></div>
