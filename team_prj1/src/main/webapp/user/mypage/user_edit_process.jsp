<%@page import="java.sql.SQLException" %>
<%@page import="kr.co.sist.chipher.DataEncryption" %>
<%@ page import="kr.co.sist.project.user.UserAuthenticationDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         info=""
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../../common/post_chk.jsp" %>
<%@ include file="../../common/session_chk.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Insert title here</title>
  <!-- bootstrap CDN 시작 -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

  <!-- jQuery CDN 시작 -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

  <style type="text/css">

  </style>
  <script type="text/javascript">
      $(function () {

      });//ready
  </script>
</head>
<body>
<div id="wrap">
  <%
    String userId = ((UserVO) session.getAttribute("userData")).getUserId();
    String tempCurrentPassword = request.getParameter("currentPassword");
    String tempNewPassword = request.getParameter("newPassword");

    UserAuthenticationDAO uDAO = UserAuthenticationDAO.getInstance();
    int rowCnt = 0;

    try {
      //비밀번호 일방향 hash
      String currentPassword = DataEncryption.messageDigest("SHA-1", tempCurrentPassword);
      String newPassword = DataEncryption.messageDigest("SHA-1", tempNewPassword);

      rowCnt = uDAO.updateChangePassword(userId, currentPassword, newPassword);
    } catch (SQLException se) {
      se.printStackTrace();
    }//end catch

  %>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
  <script type="text/javascript">
      <%	if(rowCnt != 0){ %>
      Swal.fire({
          icon: 'success',
          title: '비밀번호 변경 완료!',
          text: '다시 로그인 해주세요.',
          confirmButtonText: '확인'
      }).then((result) => {
          if (result.isConfirmed) {
              location.href = "/user/login/logout"
              location.href = "/user/login/login_page_o.jsp";
          }//end if
      });
      <% } else { %>
      Swal.fire({
          icon: 'error',
          title: '문제 발생',
          text: '비밀번호 변경 중 문제가 발생했습니다.',
          confirmButtonText: '확인'
      }).then((result) => {
          if (result.isConfirmed) {
              location.href = "http://egoempo.sist.co.kr/index.jsp";
          }//end if
      });
      <% } %>
  </script>


</div>
</body>
</html>