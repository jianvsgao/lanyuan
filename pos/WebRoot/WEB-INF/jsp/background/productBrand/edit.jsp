<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../common/taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <%@include file="../../common/common-css.jsp" %>
  </head>
  
  <body>
<br/>
<br/>  
<form action="${pageContext.servletContext.contextPath }/background/productBrand/update.html" method="post">
		<input type="hidden" name="productBrandId" value="${productBrand.productBrandId}">
		<table class="ttab" height="100" width="50%" border="0" cellpadding="0" cellspacing="1"
			align="center">
			<tr>
				<td height="30"
					 colspan="2">
					<div align="center">
					<font color="blue" size="8" ><b>添加信息</b></font>
					</div>
				</td>
			</tr>
				<tr>	
					<td height="30"width="20%" >
						<div align="right" class="STYLE1" >
								类型名称：
						</div>
					</td>
					<td >
						<div align="left" class="STYLE1"  style="padding-left:10px;">
							 <input id="productBrandName" style="height: 20px;width: 200px" name="productBrandName" value="${productBrand.productBrandName}"/>
						</div>
					</td>
				</tr>
				<tr>	
					<td height="30"width="20%" >
						<div align="right" class="STYLE1" >
								所属父类：
						</div>
					</td>
					<td >
						<div align="left" class="STYLE1"  style="padding-left:10px;">
							<select name="parentId">
							<option value="0">选择类型</option>
								<c:forEach items="${brandNameList}" var="key">
									<option  value="${key.productBrandId}" <c:if test="${productBrand.parentId eq key.productBrandId}">selected="selected"</c:if>>${key.productBrandName}</option>
								</c:forEach>	
							</select>　
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="padding: 10px">
						<div align="center">
			 				<input type="submit" value="　保　存　" class="input_btn_style1"/>　　　　
			 				<input id="backBt" type="button" value="　返　回　" class="input_btn_style1" onclick="javascript:window.location.href='javascript:history.go(-1)'"/>
		 				</div>
					</td>
				</tr>
		</table>
</form>
  </body>
</html>