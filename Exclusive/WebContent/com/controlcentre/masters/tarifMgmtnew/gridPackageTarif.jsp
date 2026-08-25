<%@page import="com.controlcentre.masters.tarifmgmtnew.ClsTarifDAO" %>
<%ClsTarifDAO ctd=new ClsTarifDAO(); %>
<%String tempgid=request.getParameter("id1");%>
<%String tempdoc=request.getParameter("doc");%>
<%System.out.println("GID="+tempgid+"DOCNO"+tempdoc);%>
  <jsp:include  page="../../../common/commonGridNew.jsp"></jsp:include>
<script type="text/javascript">

$(document).ready(function () { 
	var temp='<%=tempgid%>';
	var temp2='<%=tempdoc%>';
	//alert("tariff");
	var datapackage;
	if(temp2>0){
		
		datapackage='<%=ctd.getPackageTarif(tempgid,tempdoc,session)%>'; 
	}
	else{
		datapackage='<%=ctd.getNewPackage()%>';
	}

	
 var columnsrenderer = function (value) {
        		return '<div style="text-align: right;margin-top: 5px;">' + value + '</div>';
         }

         var num = 1; 
       
        var source =
           {
           datatype: "json",
           datafields: [
                       	{name : 'rentaltype' , type: 'string' },
                       	
                    	{name : 'packageblockday' , type:'number'},
                       	{name : 'packageblocktarif' , type:'number'},
                       	{name : 'packageextradaytarif' , type:'number'},
                       	{name : 'cdw' , type:'number'},
                       	{name : 'pai' , type:'number'},
                       	{name : 'cdw1' , type:'number'},
                       	{name : 'pai1' , type:'number'},
                       	{name : 'gps' , type:'number'},
                       	{name : 'babyseater' , type:'number'},
                       	{name : 'cooler' , type:'number'}, 
                       	{name : 'exhrchg' , type:'number'},
                     //  	{name : 'chaufchg' , type:'number'},
                       	{name : 'chaufexchg' , type:'number'},
                      /*  	{name : 'disclevel1' , type:'number'},
                       	{name : 'disclevel2' , type:'number'},
                       	{name : 'disclevel3' , type:'number'}, */
                       	{name : 'kmrest' , type:'number'},
                       	{name : 'exkmrte' , type:'number'},
                       	{name : 'oinschg' , type:'number'}
     				   ],
					localdata:datapackage,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or pagse size is changed.
                }
          };
           
          var dataAdapter = new $.jqx.dataAdapter(source,
           		 {
               		loadError: function (xhr, status, error) {
	                 ///alert(error);    
	              }
			            
		        });
            
            $("#jqxpackagetarif").jqxGrid(
            {
               width: '100%',
               height: 250,
               source: dataAdapter,
               columnsresize: true,
               rowsheight:20,
               disabled:true,
               pagesize: 25,
               pagesizeoptions: ['20', '25', '50'],
               pageable: false,
               editable:true,
               //sortable: true,
               selectionmode: 'singlecell',
               pagermode: 'default',
               
                //Add row method
                handlekeyboardnavigation: function (event) {
                	
                  var rows = $('#jqxpackagetarif').jqxGrid('getrows');
                     var rowlength= rows.length;
                       var cell1 = $('#jqxpackagetarif').jqxGrid('getselectedcell');
                       
                     
                       if (cell1 != undefined && cell1.datafield == 'packageextradaytarif' && cell1.rowindex == rowlength - 1) {
                           var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                           if (key ==9) {   
                        	   
                                $("#jqxpackagetarif").jqxGrid('addrow', null, {});
                                
                                rowlength++;
                                var temprowindex=parseInt(cell1.rowindex)+2;
                               $("#jqxpackagetarif").jqxGrid('setcellvalue',parseInt(cell1.rowindex)+1,'rentaltype','Package '+temprowindex);
                           }
                       }
                 },
               
                columns: [
							{ text: '   '+document.getElementById("mainrentaltype").value, datafield: 'rentaltype', editable:false},
							{ text: '      '+document.getElementById("mainpackageblockday").value,  datafield: 'packageblockday',editable:true,renderer: columnsrenderer,cellsalign:'right'},
							{ text: '      '+document.getElementById("mainpackageblocktarif").value,  datafield: 'packageblocktarif',editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign:'right'},
							{ text: '      '+document.getElementById("mainpackageextradaytarif").value,  datafield: 'packageextradaytarif',editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign:'right'},
							{ text: '     '+document.getElementById("maincdw").value,  datafield: 'cdw',editable:true ,renderer: columnsrenderer,cellsformat: 'd2',cellsalign:'right'},
							{ text: '     '+document.getElementById("mainpai").value,  datafield: 'pai', editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign:'right'},
							{ text: '     '+document.getElementById("maincdw1").value,  datafield: 'cdw1',editable:true ,renderer: columnsrenderer,cellsformat: 'd2',cellsalign:'right'},
							{ text:  '     '+document.getElementById("mainpai1").value,  datafield: 'pai1',editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign:'right'},
							{ text: '     '+document.getElementById("maingps").value,  datafield: 'gps', editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign:'right'},
							{ text: ''+document.getElementById("mainbabyseater").value,  datafield: 'babyseater',editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign:'right'},
							{ text: ''+document.getElementById("maincooler").value,  datafield: 'cooler',editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign:'right'},
							{ text: ''+document.getElementById("mainkmrest").value,  datafield: 'kmrest', editable:true,renderer: columnsrenderer,cellsalign:'right'},
							{ text: ''+document.getElementById("mainexkmrte").value,  datafield: 'exkmrte', editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign:'right'},
							{ text: ''+document.getElementById("mainoinschg").value,  datafield: 'oinschg',editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign:'right'},
							{ text: ''+document.getElementById("mainexhrchg").value,  datafield: 'exhrchg',editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign:'right'},
						//	{ text: ''+document.getElementById("mainchaufchg").value,  datafield: 'chaufchg', editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign:'right'},
							{ text: ''+document.getElementById("mainchaufexchg").value,  datafield: 'chaufexchg',editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign:'right'},
							/* { text: ''+document.getElementById("maindisclevel1").value,  datafield: 'disclevel1',editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign:'right'},
							{ text: ''+document.getElementById("maindisclevel2").value,  datafield: 'disclevel2', editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign:'right'},
							{ text: ''+document.getElementById("maindisclevel3").value,  datafield: 'disclevel3',editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign:'right'}
         	            */
							]
           
            });
            
            
            $("#jqxpackagetarif").bind('cellclick', function (event) {
           	 var rows = $('#jqxpackagetarif').jqxGrid('getrows');
                var rowlength= rows.length;
                  var cell1 = $('#jqxpackagetarif').jqxGrid('getselectedcell');
                 
                  if (cell1 != undefined && cell1.datafield == 'packageextradaytarif' && cell1.rowindex == rowlength - 1) {
                    //  var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                      
                	  $("#jqxpackagetarif").jqxGrid('addrow', null, {});
                      
                      rowlength++;
                      var temprowindex=parseInt(cell1.rowindex)+2;
                     $("#jqxpackagetarif").jqxGrid('setcellvalue',parseInt(cell1.rowindex)+1,'rentaltype','Package '+temprowindex);
                     
                  }
        	});
            
            $('#jqxpackagetarif').jqxGrid('hidecolumn', ''+document.getElementById("subrentaltype").value);
            
            $('#jqxpackagetarif').jqxGrid('hidecolumn', ''+document.getElementById("subpackageblockday").value);
            $('#jqxpackagetarif').jqxGrid('hidecolumn', ''+document.getElementById("subpackageblocktarif").value);
            $('#jqxpackagetarif').jqxGrid('hidecolumn', ''+document.getElementById("subpackageextradaytarif").value);
         
            $('#jqxpackagetarif').jqxGrid('hidecolumn', ''+document.getElementById("subcdw").value);
            $('#jqxpackagetarif').jqxGrid('hidecolumn', ''+document.getElementById("subpai").value); 
            $('#jqxpackagetarif').jqxGrid('hidecolumn', ''+document.getElementById("subcdw1").value);
            $('#jqxpackagetarif').jqxGrid('hidecolumn', ''+document.getElementById("subpai1").value);
            $('#jqxpackagetarif').jqxGrid('hidecolumn', ''+document.getElementById("subgps").value); 
            $('#jqxpackagetarif').jqxGrid('hidecolumn', ''+document.getElementById("subbabyseater").value);
            $('#jqxpackagetarif').jqxGrid('hidecolumn', ''+document.getElementById("subcooler").value);
            $('#jqxpackagetarif').jqxGrid('hidecolumn', ''+document.getElementById("subkmrest").value); 
            $('#jqxpackagetarif').jqxGrid('hidecolumn', ''+document.getElementById("subexkmrte").value);
            $('#jqxpackagetarif').jqxGrid('hidecolumn', ''+document.getElementById("suboinschg").value);
            $('#jqxpackagetarif').jqxGrid('hidecolumn', ''+document.getElementById("subexhrchg").value); 
            $('#jqxpackagetarif').jqxGrid('hidecolumn', ''+document.getElementById("subchaufexchg").value);
         //   $('#jqxpackagetarif').jqxGrid('hidecolumn', ''+document.getElementById("subchaufchg").value);
           
           /*  $('#jqxpackagetarif').jqxGrid('hidecolumn', ''+document.getElementById("subdisclevel1").value);
            $('#jqxpackagetarif').jqxGrid('hidecolumn', ''+document.getElementById("subdisclevel2").value);
            $('#jqxpackagetarif').jqxGrid('hidecolumn', ''+document.getElementById("subdisclevel3").value); */
});
            </script>
            <div id="jqxpackagetarif"></div>