<%@ page import="kr.co.sist.project.user.UserVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${ empty userData }">
<c:redirect url="http://egoempo.sist.co.kr/user/login/login_page_o.jsp"/>
</c:if>
<%
String sessionId=
((UserVO)session.getAttribute("userData")).getUserId();
//로그인 한 계정의 id
%>