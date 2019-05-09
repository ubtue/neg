<%@ page import="java.security.MessageDigest" isThreadSafe="false" %>
<%@ page import="java.math.BigInteger" isThreadSafe="false" %>

<form method="post">
  <input name="password">
  <input type="submit" value="generate">
</form>

<%
  if (request.getParameter("password") != null) {
    String s = request.getParameter("password");
    MessageDigest m = MessageDigest.getInstance("MD5");
    m.update(s.getBytes(), 0, s.length());
    out.println(new BigInteger(1, m.digest()).toString(16));
  }
%>
