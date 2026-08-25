<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
     "http://www.w3.org/TR/html4/loose.dtd">
<html>
 <% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>GatewayERP(i)</title>
<link href="<%=contextPath%>/css/myButton.css" media="screen" rel="stylesheet" type="text/css" />
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/css/loading.css">
<title>Struts2 - Email application</title>
</head>
<body>
    <center>
        <h1>Struts2 - Send e-mail with attachment</h1>
        <s:form action="doSendEmail" enctype="multipart/form-data" method="post">
            <table border="0" width="80%" align="center">
                <tr>
                    <td>
                        <s:textfield name="recipient" size="65" label="Recipient Address" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <s:textfield name="CC" size="65" label="CC" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <s:textfield name="subject" size="65" label="Subject" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <s:textarea cols="50" rows="10" name="message" label="Message" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <s:file name="fileUpload" size="60" label="Attach file" />
                    </td>
                </tr>               
                <tr>
                    <td>
                        <s:submit value="Send E-mail" align="center" />
                    </td>
                </tr>
            </table>
        </s:form>
    </center>
</body>
</html>
