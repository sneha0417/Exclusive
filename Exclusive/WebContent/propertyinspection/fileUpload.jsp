 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>Property Inspection</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
</head>
<body>
	<input type="file" name="file" id="file" class="form-control hidden">
	<script type="text/javascript">
		$(document).ready(function(){
			$("input[type=file]").change(function(){
		        if(document.getElementById("file").files.length > 0 ){
		        	$('.page-loader').show();
		        	var insptype=$('.custom-tabs li.active a').text();
		        	var propdocno=$('#selecteddoc').attr('data-propdocno');
					var attachdesc="Property "+insptype+" of "+propdocno;
					var inspdocno=$('#selecteddoc').attr('data-inspdocno');
					var roomdocno=$('.room-outer-container .outer-wrapper .room-container.active').attr('data-roomdocno');
					var furndocno=$('#room'+roomdocno).find('.cmbattachfurniture').val();
					$.ajaxFileUpload({
              			url:'filePropInspAttachAction.action?formCode=BPI&doc_no='+inspdocno+'&descpt='+attachdesc+'&reftypid='+roomdocno+'&furndocno='+furndocno ,
            			secureuri:false,//false  
            			fileElementId:'file',//id  <input type="file" id="file" name="file" />  
            			dataType: 'json',// json  
            			success: function (data, status){  
               				if(status=='success'){
               					$('.page-loader').hide();
			            		Swal.fire({
									icon: 'success',
						  			title: 'Success',
						  			text: insptype+' upload successfull'
								});
								$('#fileuploaddiv').load('fileUpload.jsp');
                  			}
                  			else if(typeof(data.error) != 'undefined'){
                  				$('.page-loader').hide();  
                      			if(data.error != ''){
                      				Swal.fire({
										icon: 'error',
							  			title: 'Error',
							  			text: data.error
									});
                      			}
                      			else{
                      				$('.page-loader').hide();
                      				Swal.fire({
										icon: 'warning',
							  			title: 'Warning',
							  			text: data.message
									});  
                      			}  
                  			}  
              			},  
              			error: function (data, status, e){
              				$('.page-loader').hide(); 
              				Swal.fire({
								icon: 'warning',
					  			title: 'Warning',
					  			text: e
							});
              			}  
          			});  
      			}
		    });
		});
	</script>
</body>
</html>