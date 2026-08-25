<%@page import="com.controlcentre.masters.salesmanmaster.driver.ClsDriverDAO" %>
<%ClsDriverDAO cd=new ClsDriverDAO(); %>

<% String docno = request.getParameter("docno")==null?"0":request.getParameter("docno"); %> 
<% String dtype =request.getParameter("dtype")==null?"0":request.getParameter("dtype");  %>
<script type="text/javascript">
	
	var driverdata;
    
	$(document).ready(function () {
      	
      	var temp='<%=docno%>'; 

      	if(temp>0){
         	   driverdata='<%=cd.getDriverGrid(docno,dtype)%>';
         	}
                
          // prepare the data
          var source =
          {
              datatype: "json",
              datafields: [                          	
                       	{name : 'dob', type: 'date' }, 
   						{name : 'nation1', type: 'string' },
   						{name : 'mobno', type: 'string' },
   						{name : 'dlno', type: 'string'  },
   						{name : 'ltype', type: 'string'  },  
   						{name : 'issdate', type: 'date'  },
   						{name : 'issfrm', type: 'string'  },
   						{name : 'led', type: 'date'    },
   						{name : 'passport_no', type: 'string' },
   						{name : 'pass_exp', type: 'date'    },
   						{name : 'visano', type: 'string'    },
   						{name : 'visa_exp', type: 'date'    },
   						{name : 'hiddob', type: 'string' },
 						{name : 'hidpassexp', type: 'string' },
 						{name : 'hidissdate', type: 'string' },
 						{name : 'hidled', type: 'string'    },
 						{name : 'hidvisaexp', type: 'string' },
   						{name : 'dr_id', type: 'int'    }
               ],
               localdata: driverdata,
                                      
          };
          
          var dataAdapter = new $.jqx.dataAdapter(source,
          		 {
              		loadError: function (xhr, status, error) {
                   alert(error);    
                   }
            });
          
          var list = ['GCC', 'IDP','UAE','LV','HB','LB','HV','HT','LT'];
          
          $("#jqxDriver").jqxGrid(
          {
              width: '95%',
              height: 300,
              source: dataAdapter,
              editable: true,
              selectionmode: 'singlecell',
              
               handlekeyboardnavigation: function (event) {
                  //Search Pop-Up
                  var cell1 = $('#jqxDriver').jqxGrid('getselectedcell');
                  if (cell1 != undefined && cell1.datafield == 'nation1') {
                      var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                      if (key == 114) { 
                      	    document.getElementById("gridrowindex").value = cell1.rowindex;
                     	    $('#jqxDriver').jqxGrid('render');
                     	    $('#nationalityWindow').jqxWindow('open');
                            $('#nationalityWindow').jqxWindow('focus');
                    	    nationalitySearchContent('nationSearchGrid.jsp', $('#nationalityWindow'));
                      }
                  }
                  
                //Search Pop-Up
                  var cell1 = $('#jqxDriver').jqxGrid('getselectedcell');
                  if (cell1 != undefined && cell1.datafield == 'issfrm') {
                      var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                      if (key == 114) { 
                      	var value = $('#jqxDriver').jqxGrid('getcellvalue', cell1.rowindex, "ltype");
                      	if(value == "UAE"){
	                        	document.getElementById("gridrowindex").value = cell1.rowindex;
	                        	$('#jqxDriver').jqxGrid('render');
	                        	stateSearchContent('stateSearchGrid.jsp');
                      	}
                      }
                  }
              },
              
              columns: [							
				
					{ text: 'Date of Birth', datafield: 'dob', columntype: 'datetimeinput',  cellsformat: 'dd.MM.yyyy', width: '9%',
	                      validation: function (cell, value) {
	                          if (value == "")
	                             return true; 
	                          
	                          var year = value.getFullYear();
	                          var cdate=new Date();
	                          var cyear=cdate.getFullYear();
	                          if (year >= cyear) {
	                        	  document.getElementById("chkvalid").value=1;
	                              return { result: false, message: "Date of birth should be before 1.1."+cyear+"." };
	                          }
	                          document.getElementById("chkvalid").value=0;
	                          return true;
  			                  } 
	                 },

	                 { text: 'Nationality', datafield: 'nation1', width: '8%',editable:false,
	                	 validation:function (cell,value){
	                		 if(value.length==0){
	                			 return { result: false, message: "Required." };
	                		 }
	                		 else{
	                			 return true;
	                		 }
	                	 }
	                 },
	                 { text: 'Mob No', datafield: 'mobno', width: '10%',
							validation: function (cell,value){
								var phoneno = /^\d{12}$/;  
								if(value.match(phoneno)){
									return true;
								}
								else{
									return { result: false, message: "Invalid Mobile Number." };
								}
							}
	                 },
	                 { text: 'Licence#', datafield: 'dlno', width: '7%' ,
							validation:function(cell,value){
								if(value.length==0){
									return { result: false, message: "Required" };
								}
								else{
									return true;
								}
							}
					},
					{ text: 'Lic Type', datafield: 'ltype', width: '8%',columntype:'dropdownlist',
                        createeditor: function (row, column, editor) {
                                              editor.jqxDropDownList({ autoDropDownHeight: true, source: list });
                        }
                    },
                    { text: 'Iss From', datafield: 'issfrm', width: '8%' ,
						validation:function(cell,value){
							if(value.length==0){
								return {result:false,message:"Required"};
							}
							else{
								return true;
							}
						},
						cellbeginedit: function (row) {
					        if ($('#jqxDriver').jqxGrid('getcellvalue', row, "ltype")=="UAE")
					         {
					              return false;
					         }}
					},
					{ text: 'Lic Issued', datafield: 'issdate', columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy', width: '9%' },
					{ text: 'Lic Expiry', datafield: 'led', columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy', width: '9%',
						validation: function (cell, value) {
	                          if (value.length==0)
	                        	  return {result:false,message:"Required"};
	                          var year = value.getFullYear();
	                          var cdate=new Date();
	                          var cyear=cdate.getFullYear();
	                          var year = value.getFullYear();
	                          if (year < cyear) {
	                        	  document.getElementById("chkvalid").value=1;
	                              return { result: false, message: "Licence Expired." };
	                          }
	                          document.getElementById("chkvalid").value=0;
	                          return true;
						}
					},
					{ text: 'Passport#', datafield: 'passport_no', width: '7%' },
					{ text: 'Pass Exp.', datafield: 'pass_exp', columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy', width: '9%' ,
						validation: function (cell, value) {
	                          var year = value.getFullYear();
	                          var cdate=new Date();
	                          var cyear=cdate.getFullYear();
	                          var year = value.getFullYear();
	                          if (year < cyear) {
	                        	  document.getElementById("chkvalid").value=1;
	                              return { result: false, message: "Passport Expired." };
	                          }
	                          document.getElementById("chkvalid").value=0;
	                          return true;
						}
					
					},
					{ text: 'Visa#', datafield: 'visano', width: '7%' },
					{ text: 'Visa Exp.', datafield: 'visa_exp', columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy', width: '9%' },
					{ text: 'Hid-Dob', datafield: 'hiddob', editable: false, hidden: true, width: '10%' },
					{ text: 'Hid-Pass-Exp', datafield: 'hidpassexp', editable: false, hidden: true,  width: '10%' },
					{ text: 'Hid-Iss-Date', datafield: 'hidissdate', editable: false, hidden: true,  width: '10%' },
					{ text: 'Hid-LED', datafield: 'hidled', editable: false, hidden: true,  width: '10%' },
					{ text: 'Hid-Visa-Exp', datafield: 'hidvisaexp', editable: false, hidden: true,  width: '10%' },
					{ text: 'Hid-Doc No', datafield: 'doc_no', editable: false, hidden: true,  width: '10%' },
					{ text: 'Hid-Driver Id', datafield: 'dr_id', editable: false, hidden: true,  width: '10%' },
             ]
          });
          
          //Add empty row          
          if(temp==0){   
         	   $("#jqxDriver").jqxGrid('addrow', null, {});
          	 }   
            
             if(temp>0){
             	$("#jqxDriver").jqxGrid('disabled', true);
             }
          
     	$('#jqxDriver').on('celldoubleclick', function (event) {
    	  if(event.args.columnindex == 1){
    	      var rowindextemp = event.args.rowindex;    
    	      document.getElementById("gridrowindex").value = rowindextemp;
    	      $("#jqxDriver").jqxGrid('clearselection');
    	      $('#nationalityWindow').jqxWindow('open');
              $('#nationalityWindow').jqxWindow('focus');
    	      nationalitySearchContent('nationSearchGrid.jsp', $('#nationalityWindow'));
    		 }
    	  
    	  if(event.args.columnindex == 5){
	    	var rowindextemp = event.args.rowindex;
	        document.getElementById("gridrowindex").value = rowindextemp;
	        var value = $('#jqxDriver').jqxGrid('getcellvalue', rowindextemp, "ltype");
        	if(value == "UAE"){
		        $('#jqxDriver').jqxGrid('clearselection');
		        stateSearchContent('stateSearchGrid.jsp');
        	}
		  }
    	  
        }); 
     	
    	$("#jqxDriver").on('cellvaluechanged', function (event){
        	var datafield = event.args.datafield;
       		var rowBoundIndex = event.args.rowindex;
	        if(datafield=="dob")
	        {
	            var dob = $('#jqxDriver').jqxGrid('getcelltext', rowBoundIndex, "dob");
	            $('#jqxDriver').jqxGrid('setcellvalue',rowBoundIndex, "hiddob",dob);
	         }
	        
	        if(datafield=="pass_exp")
	        {
	            var passexp = $('#jqxDriver').jqxGrid('getcelltext', rowBoundIndex, "pass_exp");
	            $('#jqxDriver').jqxGrid('setcellvalue',rowBoundIndex, "hidpassexp",passexp);
	         }
	        
	        if(datafield=="issdate")
	        {
	            var issdate = $('#jqxDriver').jqxGrid('getcelltext', rowBoundIndex, "issdate");
	            $('#jqxDriver').jqxGrid('setcellvalue',rowBoundIndex, "hidissdate",issdate);
	         }
	        
	        if(datafield=="led")
	        {
	            var led = $('#jqxDriver').jqxGrid('getcelltext', rowBoundIndex, "led");
	            $('#jqxDriver').jqxGrid('setcellvalue',rowBoundIndex, "hidled",led);
	         }
	        
	        if(datafield=="visa_exp")
	        {
	            var visaexp = $('#jqxDriver').jqxGrid('getcelltext', rowBoundIndex, "visa_exp");
	            $('#jqxDriver').jqxGrid('setcellvalue',rowBoundIndex, "hidvisaexp",visaexp);
	         }
        });
   
});
      
</script>
<div id="jqxDriver"></div>
<input type="hidden" id="gridrowindex" name="gridrowindex"/>
<input type="hidden" id="chkvalid" name="chkvalid">