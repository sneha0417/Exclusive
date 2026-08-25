<%@ taglib uri="/struts-tags" prefix="s"%>
<html>
	<head>
		<title>Struts 2 dynamic method invocation example</title>
	</head>
	<body>
		<h3>This is a dynamic method invocation example.</h3>
 
		<s:form action="User">
 
		 
        <s:submit action="addUser" value="Add" />
        <s:submit action="updateUser" value="Update" />
        <s:submit action="deleteUser" value="Delete" />
			
		</s:form>
 
	</body>
</html>