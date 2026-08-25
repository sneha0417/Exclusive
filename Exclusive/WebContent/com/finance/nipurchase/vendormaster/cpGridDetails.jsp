<%@page import="com.finance.nipurchase.vendormaster.ClsVendorDetailsDAO" %>

<style>
.column{
background-color: #D6FFEA;
}
</style>
<%
ClsVendorDetailsDAO DAO=new ClsVendorDetailsDAO();
   	int cldocno = request.getParameter("cldocno")==null?0:Integer.parseInt(request.getParameter("cldocno").trim());%>
   	
<script type="text/javascript">


        	 
function getarea(rowBoundIndex){
	 	  $('#areainfowindow').jqxWindow('open');

   // $('#accountWindow').jqxWindow('focus');
          areaSearchContent('area.jsp?getarea=1&rowBoundIndex='+rowBoundIndex); 
 	
       	 }        	 
        	 
function areaSearchContent(url) {
 //alert(url);
 	 $.get(url).done(function (data) {
		 //alert(data);
$('#areainfowindow').jqxWindow('setContent', data);

               	}); 
     	}
     	
       	 
function getactivity(rowBoundIndex){
	
	  $('#activityinfowindow').jqxWindow('open');
  // $('#accountWindow').jqxWindow('focus');
         activitySearchContent('activity.jsp?rowBoundIndex='+rowBoundIndex);
	
      	 }
       	 
function activitySearchContent(url) {
	 
	 $.get(url).done(function (data) {
			 //alert(data);
	$('#activityinfowindow').jqxWindow('setContent', data);

              	}); 
    	}


var temp2='<%=cldocno%>'; 

if(temp2>0)
{

	 var agmtdata='<%=DAO.cpGridload(session,cldocno)%>'; 

}
else
{ 
var agmtdata;
/* 	 /* '[{"Name":""},{"Date of Birth":""},{"Age":""},{"dbage":""},{"Nationality":""},{"Mob No":""},{"Licence#":""},{"Lic Issued":""},{"dbLic Issued":""},{"calcuLic Issued":""},{"Licence#":""},{"Lic Issued":""},{"dbLic Issued":""},{"calcuLic Issued":""},{"Lic Expiry":""},{"Lic Type":""},{"Iss From":""},{"Passport#":""},{"Pass Exp":""},{"doc_no":""}]'; */
} 
     $(document).ready(function () { 	
            
        	 var columnsrenderer = function (value) {
        			return '<div style="text-align: center;margin-top: 5px;">' + value + '</div>';
        		}
            //var url="demo.txt"; 
        	var num = 0;
            var source =
            {
                datatype: "json",
                datafields: [
									{name : 'slno' , type: 'number', },
									{name : 'cpersion' , type:'string'},
									{name : 'mobile' , type:'string'},
									{name : 'phone' , type:'string'},
									{name : 'extn' , type:'string'},
									{name : 'email' , type:'string'},
									{name : 'area' , type:'string'},
									{name : 'areaid',type:'number'},
									{name : 'activity' , type:'string'},
									{name : 'activity_id' , type:'number'},
									{name : 'row_no' , type:'number'}
									],
                localdata: agmtdata,
                //url: url,
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
            $("#cpDetailsGrid").jqxGrid(
            {
                width: '100%',
                height: 100,
                source: dataAdapter,
                rowsheight:18,
                columnsresize: true,
                pageable: false,
                altRows: true,
                sortable: false,
                selectionmode: 'singlecell',
                editable:true,
                //Add row method
                
                 handlekeyboardnavigation: function (event) {
                var rows = $('#cpDetailsGrid').jqxGrid('getrows');
                var rowlength= rows.length;
                   var cell = $('#cpDetailsGrid').jqxGrid('getselectedcell');
                   if (cell != undefined && cell.datafield == 'activity' && cell.rowindex == rowlength - 1) {
                       var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                       if (key ==13) {  
                           var commit = $("#cpDetailsGrid").jqxGrid('addrow', null, {});
                           rowlength++; 
                       }
                   } 
                   var cell1 = $('#cpDetailsGrid').jqxGrid('getselectedcell');
                   if (cell1 != undefined && cell1.datafield == 'area') {
                       var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                       if (key == 114) {
                    	   var rowBoundIndexs =cell1.rowindex;;
                   
                      		$('#cpDetailsGrid').jqxGrid('render');
                      		getarea(rowBoundIndexs); 
                         }
                   }
                   var cell2 = $('#cpDetailsGrid').jqxGrid('getselectedcell');
                   if (cell2 != undefined && cell2.datafield == 'activity') {
                       var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                       if (key == 114) {
                    	   var rowBoundIndex5 =cell2.rowindex;
                   
                      		$('#cpDetailsGrid').jqxGrid('render');
                      		getactivity(rowBoundIndex5); 
                         }
                   }
                   
                 },
                
                columns: [
{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                               return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
       },
{ text: 'Contact Person',  datafield: 'cpersion',  width: '30%'  ,editable:true ,renderer: columnsrenderer, cellsalign: 'center', align: 'center',cellclassname:'column'},
{ text: 'Mobile No',  datafield: 'mobile',  width: '15%',editable:true,renderer: columnsrenderer,cellsalign: 'center', align: 'center',cellclassname:'column'},
{ text: 'Telephone No',  datafield: 'phone',  width: '15%'  ,editable:true ,renderer: columnsrenderer,cellsalign: 'center',align: 'center',cellclassname:'column'},
{ text: 'Extension',  datafield: 'extn',  width: '8%',editable:true,renderer: columnsrenderer,cellsalign: 'center', align: 'center',cellclassname:'column'},
{ text: 'Email',  datafield: 'email',  width: '15%',editable:true,renderer: columnsrenderer,cellsalign: 'center',align: 'center',cellclassname:'column'},
{ text: 'Area',  datafield: 'area', hidden:true, width: '14%',editable:false,renderer: columnsrenderer,cellsalign: 'center',align: 'center',cellclassname:'column'},
{ text: 'Area id', datafield: 'areaid', width: '9%' ,editable:true,renderer: columnsrenderer,cellsalign: 'center',hidden:true,align: 'center',cellclassname:'column'},
{ text: 'Activity',  datafield: 'activity',  width: '14%',editable:false,renderer: columnsrenderer,cellsalign: 'center',align: 'center',cellclassname:'column'},
{ text: 'Activity id',  datafield: 'activity_id',  width: '15%',editable:true,renderer: columnsrenderer,cellsalign: 'center',hidden:true,align: 'center',cellclassname:'column'},
{ text: 'Row No',  datafield: 'row_no',  width: '15%',editable:true,renderer: columnsrenderer,cellsalign: 'center',hidden:true,align: 'center',cellclassname:'column'}	              ]
            });
            //$('#cpDetailsGrid').on('bindingcomplete', function (event) {
	            var rows = $('#cpDetailsGrid').jqxGrid('getrows');
	           
	            var rowslength=rows.length;
	            if(rowslength==0){
	           				 $("#cpDetailsGrid").jqxGrid("addrow", null, {});
	           				 /* $("#cpDetailsGrid").jqxGrid("addrow", null, {});
	           				 $("#cpDetailsGrid").jqxGrid("addrow", null, {});
	           				 $("#cpDetailsGrid").jqxGrid("addrow", null, {}); */
	            }
            // });
            
	            $("#cpDetailsGrid").on("celldoubleclick", function (event) 
	            		   {
				            	var rowBoundIndex = event.args.rowindex;
				    		       var datafield = event.args.datafield;
				    		       
				    		       if(datafield=="area")
				    		    	   {
				    		    	   getarea(rowBoundIndex);
				    		    	  
				    		    	   }
				    		       
				    		       if(datafield=="activity")
			    		    	   {
			    		    	   getactivity(rowBoundIndex);
			    		    	   }
	    		       
	            		   });
	            if(document.getElementById("mode").value=='view'){
	            	$('#cpDetailsGrid').jqxGrid({ disabled: true});
	            }
            
            /* $('#tarifagmtgrid').on('bindingcomplete', function (event) {
             	// alert("Heree");
             	
         	    var rows = $('#tarifreferencegrid').jqxGrid('getrows');
                var rowslength=rows.length;
                //$("#tarifreferencegrid").jqxGrid('setcellvalue', rowslength, datafield, oldvalue);
         	   }); */
        });
  
            </script>
            <div id="cpDetailsGrid"></div>