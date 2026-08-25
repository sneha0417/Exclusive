<%@page import="com.controlcentre.masters.tarifmgmt.ClsTarifDAO" %>
<%ClsTarifDAO ctd=new ClsTarifDAO(); %>
<%String tempgid=request.getParameter("id1");%>
<%String tempdoc=request.getParameter("doc");%>
<%System.out.println("GID="+tempgid+"DOCNO"+tempdoc);%>
  <jsp:include  page="../../../common/commonGrid.jsp"></jsp:include>
<script type="text/javascript">

$(document).ready(function () { 
	var temp='<%=tempgid%>';
	var temp2='<%=tempdoc%>';
	//alert("tariff");
	var datatarif;
	if(temp2>0){
		
		datatarif='<%=ctd.getRegularTarif(tempgid,tempdoc,session)%>';
	}
	else{
		datatarif='<%=ctd.getNewRegular()%>';
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
                       	{name : 'rate' , type:'number'},
                       	{name : 'cdw' , type:'number'},
                       	{name : 'pai' , type:'number'},
                       	{name : 'cdw1' , type:'number'},
                       	{name : 'pai1' , type:'number'},
                       	{name : 'gps' , type:'number'},
                       	{name : 'babyseater' , type:'number'},
                       	{name : 'cooler' , type:'number'}, 
                       	{name : 'exhrchg' , type:'number'},
                       	{name : 'chaufchg' , type:'number'},
                       	{name : 'chaufexchg' , type:'number'},
                       	{name : 'disclevel1' , type:'number'},
                       	{name : 'disclevel2' , type:'number'},
                       	{name : 'disclevel3' , type:'number'},
                       	{name : 'kmrest' , type:'number'},
                       	{name : 'exkmrte' , type:'number'},
                       	{name : 'oinschg' , type:'number'}
     				   ],
					localdata:datatarif,
                
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
            
            $("#jqxgridtarif").jqxGrid(
            {
               width: '100%',
               height: 107,
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
            // var rows = $('#jqxgridtarif').jqxGrid('getrows');
       /*      alert("here");
                  var rowlength= event.args.rowindex;
                  alert(rowlength);
                    var cell = $('#jqxgridtarif').jqxGrid('getselectedcell');
				if (cell != undefined && cell.datafield == 'disclevel3') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 9) {
                            $('#jqxgridtarif').jqxGrid('selectcell',rowlength+1, 'rentaltype');
                   					$('#jqxgridtarif').jqxGrid('focus',rowlength+1, 'rentaltype');
                                       
                        }
				} */
                 },
            
               
                columns: [
							{ text: '   '+document.getElementById("mainrentaltype").value, datafield: 'rentaltype', editable:false},
							{ text: '      '+document.getElementById("mainrate").value,  datafield: 'rate',editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign:'right'},
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
							{ text: ''+document.getElementById("mainchaufchg").value,  datafield: 'chaufchg', editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign:'right'},
							{ text: ''+document.getElementById("mainchaufexchg").value,  datafield: 'chaufexchg',editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign:'right'},
							{ text: ''+document.getElementById("maindisclevel1").value,  datafield: 'disclevel1',editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign:'right'},
							{ text: ''+document.getElementById("maindisclevel2").value,  datafield: 'disclevel2', editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign:'right'},
							{ text: ''+document.getElementById("maindisclevel3").value,  datafield: 'disclevel3',editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign:'right'}
         	              ]
           
            });
            $('#jqxgridtarif').jqxGrid('hidecolumn', ''+document.getElementById("subrentaltype").value);
            $('#jqxgridtarif').jqxGrid('hidecolumn', ''+document.getElementById("subrate").value);
            $('#jqxgridtarif').jqxGrid('hidecolumn', ''+document.getElementById("subcdw").value);
            $('#jqxgridtarif').jqxGrid('hidecolumn', ''+document.getElementById("subpai").value); 
            $('#jqxgridtarif').jqxGrid('hidecolumn', ''+document.getElementById("subcdw1").value);
            $('#jqxgridtarif').jqxGrid('hidecolumn', ''+document.getElementById("subpai1").value);
            $('#jqxgridtarif').jqxGrid('hidecolumn', ''+document.getElementById("subgps").value); 
            $('#jqxgridtarif').jqxGrid('hidecolumn', ''+document.getElementById("subbabyseater").value);
            $('#jqxgridtarif').jqxGrid('hidecolumn', ''+document.getElementById("subcooler").value);
            $('#jqxgridtarif').jqxGrid('hidecolumn', ''+document.getElementById("subkmrest").value); 
            $('#jqxgridtarif').jqxGrid('hidecolumn', ''+document.getElementById("subexkmrte").value);
            $('#jqxgridtarif').jqxGrid('hidecolumn', ''+document.getElementById("suboinschg").value);
            $('#jqxgridtarif').jqxGrid('hidecolumn', ''+document.getElementById("subexhrchg").value); 
            $('#jqxgridtarif').jqxGrid('hidecolumn', ''+document.getElementById("subchaufchg").value);
            $('#jqxgridtarif').jqxGrid('hidecolumn', ''+document.getElementById("subchaufexchg").value);
            $('#jqxgridtarif').jqxGrid('hidecolumn', ''+document.getElementById("subdisclevel1").value);
            $('#jqxgridtarif').jqxGrid('hidecolumn', ''+document.getElementById("subdisclevel2").value);
            $('#jqxgridtarif').jqxGrid('hidecolumn', ''+document.getElementById("subdisclevel3").value);
});
            </script>
            <div id="jqxgridtarif"></div>