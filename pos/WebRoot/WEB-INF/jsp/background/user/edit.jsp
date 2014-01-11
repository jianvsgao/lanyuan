<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../common/taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <%@include file="../../common/common-css.jsp" %>
<script type="text/javascript"
	src="${pageContext.servletContext.contextPath }/js/jquery_1_7_2_min.js"></script>
    <script type="text/javascript">
    function checkMobile(){ 
    var g=document.getElementsByTagName("input"); //设置变量接收所查找到的select控件 
for(i=0;i<g.length;i++) //遍历循环赋值 
{ 
   if(g[i].value==""){
   alert("存在一个空的！请填写！！");
   	return ;
   }
} 
   var sMobile = document.upUser.userName.value;
 	var b = "";
 	if("${user.userName}"!=sMobile){
 		$.ajax({
                url: "${pageContext.servletContext.contextPath }/background/user/checkUserPhone.html",
                type: "POST",
                async:false,
                data: {"userName":sMobile},
                dataType:'json',
                success: function(data) {
               		if(data.data=="false"){
               			b="1";
               		}
                }

            });
 	}
   if(b=="1"){
   alert("该用户名已经存在！");
   return false; 
   }else{
    var userIdCard = document.upUser.userIdCard.value;
    if(validateIdCard(userIdCard)){
     document.upUser.submit();
    }
    
   }
    
}
function validateIdCard(idCard){
 //15位和18位身份证号码的正则表达式
 var regIdCard=/^(^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$)|(^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])((\d{4})|\d{3}[Xx])$)$/;

 //如果通过该验证，说明身份证格式正确，但准确性还需计算
 if(regIdCard.test(idCard)){
  if(idCard.length==18){
   var idCardWi=new Array( 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 ); //将前17位加权因子保存在数组里
   var idCardY=new Array( 1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2 ); //这是除以11后，可能产生的11位余数、验证码，也保存成数组
   var idCardWiSum=0; //用来保存前17位各自乖以加权因子后的总和
   for(var i=0;i<17;i++){
    idCardWiSum+=idCard.substring(i,i+1)*idCardWi[i];
   }

   var idCardMod=idCardWiSum%11;//计算出校验码所在数组的位置
   var idCardLast=idCard.substring(17);//得到最后一位身份证号码

   //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
   if(idCardMod==2){
    if(idCardLast=="X"||idCardLast=="x"){
    return true;
    }else{
     alert("身份证号码错误！");
     return false;
    }
   }else{
    //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
    if(idCardLast==idCardY[idCardMod]){
     return true;
    }else{
     alert("身份证号码错误！");
     return false;
    }
   }
  } 
 }else{
  alert("身份证格式不正确!");
  return false;
 }
}
    </script>
  </head>
  
  <body>
  <div style="height: 100%;overflow-y: auto;">
<br/>
<br/>  
<form action="${pageContext.servletContext.contextPath }/background/user/update.html" method="post" name="upUser">
<input type="hidden" name="userId" value="${user.userId}">
		<table class="ttab" height="100" width="90%" border="0"
				cellpadding="0" cellspacing="1" align="center">
				<tr>
					<td height="30" colspan="4">
						<div align="center">
							<font color="blue" size="5"><b>编辑客户</b> </font>
						</div>
					</td>
				</tr>
				<tr>
					<td height="30" width="10%">
						<div align="right" class="STYLE1">用户名：</div>
					</td>
					<td>
						<div align="left" class="STYLE1" style="padding-left:10px;">
							<input style="height: 20px;width: 200px" name="userName"
								id="userName"  value="${user.userName}"/> *手机号码注册登录   <font color="red">*必填</font>
						</div>
					</td>
					<td height="30" width="10%">
						<div align="right" class="STYLE1">银行户名：</div>
					</td>
					<td>
						<div align="left" class="STYLE1" style="padding-left:10px;">
							<input style="height: 20px;width: 200px" name="bankAccountName" value="${user.bankAccountName}"/>
							*客户结算的银行账户户名 <font color="red">*必填</font>
						</div>
					</td>
				</tr>
				<tr>
					<td height="30" width="10%">
						<div align="right" class="STYLE1">密码：</div>
					</td>
					<td>
						<div align="left" class="STYLE1"
							style="padding-left:10px;color: red;">*默认密码为身份证后6位 <font color="red">*必填</font></div>
					</td>
					<td height="30" width="10%">
						<div align="right" class="STYLE1">银行账号：</div>
					</td>
					<td>
						<div align="left" class="STYLE1" style="padding-left:10px;">
							<input style="height: 20px;width: 200px" name="bankAccount" value="${user.bankAccount}"/>
							*客户结算的银行账户账号 <font color="red">*必填</font>
						</div>
					</td>
				</tr>
				<tr>
				
				<td height="30" width="10%">
						<div align="right" class="STYLE1">真实姓名：</div>
					</td>
					<td>
						<div align="left" class="STYLE1" style="padding-left:10px;">
							<input style="height: 20px;width: 200px" name="userRealname" value="${user.userRealname}"/> <font color="red">*必填</font>
						</div>
					</td>
					<td height="30" width="10%">
						<div align="right" class="STYLE1">银行名称：</div>
					</td>
					<td>
						<div align="left" class="STYLE1" style="padding-left:10px;">
							<input style="height: 20px;width: 200px" name="bankName"  value="${user.bankName}"/>
							*客户结算的银行名称，如：中国银行 <font color="red">*必填</font>
						</div>
					</td>
				</tr>
				<tr>
					
					<td height="30" width="10%">
						<div align="right" class="STYLE1">身份证：</div>
					</td>
					<td>
						<div align="left" class="STYLE1"
							style="padding-left:10px;color: red;">
							<input style="height: 20px;width: 200px" name="userIdCard"
								id="userIdCard" value="${user.userIdCard}" /> *必须输入正确的身份证 <font color="red">*必填</font>
						</div>
					</td>
					
					<td height="30" width="10%">
						<div align="right" class="STYLE1">开户所在省：</div>
					</td>
					<td>
						<div align="left" class="STYLE1" style="padding-left:10px;">
							<input style="height: 20px;width: 200px" name="province" value="${user.province}" />
							*客户结算账户开户行所在省级行政区 <font color="red">*必填</font>
						</div>
					</td>
				</tr>
				<tr>
				<td height="30" width="10%">
						<div align="right" class="STYLE1" >支付通道：</div>
					</td>
					<td>
						<div align="left" class="STYLE1" style="padding-left:10px;">
						<select name="ratesId" id="ratesId">
						<c:forEach var="key" items="${rates}">
						<option value="${key.id}" <c:if test="${user.ratesId eq key.id}">selected="selected"</c:if>>${key.channelname}</option>
						</c:forEach>
						</select>
						</div>
					</td>
					
					<td height="30" width="10%">
						<div align="right" class="STYLE1">开户所在市：</div>
					</td>
					<td>
						<div align="left" class="STYLE1" style="padding-left:10px;">
							<input style="height: 20px;width: 200px" name="city" value="${user.city}"/>
							*客户结算账户开户行所在市级行政区 <font color="red">*必填</font>
						</div>
					</td>
				</tr>
				<tr>
					<td height="30" width="10%">
						<div align="right" class="STYLE1">开通费：</div>
					</td>
					<td>
						<div align="left" class="STYLE1" style="padding-left:10px;">
							<input style="height: 20px;width: 200px" name="pay"  value="${user.pay}"/> <font color="red">*必填</font>
						</div>
					</td>
					
					<td height="30" width="10%">
						<div align="right" class="STYLE1">所属支行或分行：</div>
					</td>
					<td>
						<div align="left" class="STYLE1" style="padding-left:10px;">
							<input style="height: 20px;width: 200px" name="subbranchBank" value="${user.subbranchBank}"/>
							*如：北京分行或三元桥支行 <font color="red">*必填</font>
						</div>
					</td>
				</tr>
				<tr>
					<td height="30" width="10%">
						<div align="right" class="STYLE1">用户状态：</div>
					</td>
					<td>
						<div align="left" class="STYLE1" style="padding-left:10px;color: red">
							 <c:if test="${user.status eq '0'}">待审核</c:if>
							 <c:if test="${user.status eq '1'}">正式用户</c:if>
						</div>
					</td>
					<td height="30" width="10%">
						<div align="right" class="STYLE1">账号类型：</div>
					</td>
					<td>
						<div align="left" class="STYLE1" style="padding-left:10px;">
							<input type="radio" name="accountType" value="个人账号"
								 <c:if test="${user.accountType eq '个人账号'}">checked="checked"</c:if>/>：个人账号 <input type="radio"
								name="accountType" value="企业账号" <c:if test="${user.accountType eq '企业账号'}">checked="checked"</c:if>/>：企业账号
						</div>
					</td>
				</tr>
				<tr>
					
					<td height="30" width="10%">
						<div align="right" class="STYLE1">QQ：</div>
					</td>
					<td>
						<div align="left" class="STYLE1" style="padding-left:10px;">
							<input style="height: 20px;width: 200px" name="userQQ"  value="${user.userQQ}"/> <font color="red">*必填</font>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="4" style="padding: 10px">
						<div align="center">
							<input type="button" value="　保　存　" class="input_btn_style1"
								onclick="checkMobile();" /> <input id="backBt" type="button"
								value="　返　回　" class="input_btn_style1"
								onclick="javascript:window.location.href='javascript:history.go(-1)'" />
						</div>
					</td>
				</tr>
			</table>
</form>
</div>
  </body>
</html>
