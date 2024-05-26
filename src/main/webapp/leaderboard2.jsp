<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="org.jsoup.nodes.*" %>
<%@ page import="org.jsoup.select.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.Connection" %>
<html>
<head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
<style type="">
.avatar {
  vertical-align: middle;
  width: 40px;
  height: 40px;
  border-radius: 50%;
}

.column {
  float: right;
  width: 5.33%;
  padding: 0px;
  padding-left: 30px;
  padding-right: 0px;
  border-right: 0px;
  overflow-x: visible;
}
body {
  background-color:#e8e8e8;
  height: 70%;
  margin:0;
  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;
}	
h1{
	text-align: center;
	color:black;
}
h1.small {
  font-variant: small-caps;
  font-size: 50px;
}
address{
    font-size:80%;
    margin:0px;
    color:white;
}
.row-content {
    margin:0px auto;
    padding: 50px 0px 50px 0px;
    border-bottom: 1px ridge;
    min-height:400px;
    color: white;
}

.row-footer{
    background-color: #363636;
    margin:0px auto;
    padding: 20px 0px 20px 0px;
}
h5, li{
	color:white;
}
span {
  font-size:24px;
  content: "\2708";
}
a{
	color:white;
  padding-left: 15px;
}

#customers {
  font-family: Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

#customers td, #customers th {
  border: 1px solid #ddd;
  padding: 8px;
}

#customers tr:nth-child(even){background-color: #f2f2f2;}
#customers tr:nth-child(odd){background-color: white;}
#customers tr:hover {background-color: #ddd;}

#customers th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: left;
  background-color: #454647;
  color: white;
}
</style>
</head>
<body>



<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
  <a class="navbar-brand" href="Coolflights.jsp">CodeStation <i class="fa fa-cubes"></i></a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item">
        <a class="nav-link" href="dashboard.jsp">DashBoard <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="contest.jsp">Contests</a>
      </li>
      <li class="nav-item">
        <a class="nav-link active" href="leaderboard.jsp">LeaderBoard</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="activity.jsp">Activity</a>
      </li>
    </ul>
    <a href="myaccount.jsp">
      <div class="row">

      <div class="column" style="width:10%;margin-top:8px;">
        <i style="font-size:25px;color:white;" class="fa">&#xf2bd;</i>
      </div>

      <div class="column">
      
        <h6 style="color:white;">MyAccount </h6>
      </div>
      
    </div>
  </a>
  </div>
</nav>	

<br><br><br><br>
<center>

   <div class="buttons">

            <div class="action_btn">

            <a href="leaderboard.jsp"><button type="button" class="btn btn-light">View Global Ranking</button></a>
            <a href="leaderboard2.jsp"><button type="button" class="btn btn-dark">View Institute Ranking</button></a>

            <p id="saved"></p>

            </div>

        </div>

</center>
<br>

<center>
  <table id="customers" style="width: 1300px;">
  <tr>
    <th>Rank</th>
    <th>Name</th>
    <th>Email</th>
    <th>Score</th>
    <th>Institute</th>
  </tr>

	 
<%

	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/codestation","root","meghana12");  
		Cookie[] cookies = null;
		cookies = request.getCookies();
		String umail="";
		for(Cookie c: cookies){
	 		if(c.getName().equals("umail")){
	 			umail = c.getValue();
	 			System.out.println("MAIL: "+cookies[0].getValue());
	 		}
		}
		Statement st = con.createStatement();
		String ints = ("SELECT INSTITUTE FROM USER WHERE UMAIL='"+umail+"' ");
		ResultSet intrs = st.executeQuery(ints);
		intrs.next();
		String cllg = intrs.getString("INSTITUTE");
		String sql = ("SELECT U.UNAME, U.UMAIL, U.INSTITUTE, CS.OVERALL_SCORE FROM CODESTATION AS CS, USER AS U WHERE U.INSTITUTE='"+cllg+"' AND U.UMAIL=CS.UMAIL ORDER BY CS.OVERALL_SCORE DESC ;");
		ResultSet rs = st.executeQuery(sql);
		int i=1;
		while(rs.next()) { 
			 String name = rs.getString("UNAME"); 
			 String email = rs.getString("UMAIL"); 
			 String score = rs.getString("OVERALL_SCORE"); 
			 String institute = rs.getString("INSTITUTE"); 
			 
			 %>	
			 
			   <tr>
    			<td><%out.println(i++); %></td>
    			<td><%=name %></td>
    			<td><%=email %></td>
    			<td><%=score %></td>
    			<td><%=institute %></td>
  			   </tr>
			  
			 <%
		}
				
	} catch (ClassNotFoundException e) {
		e.printStackTrace();
	} catch (SQLException e) {
		e.printStackTrace();
	} 
	

%>





</table>
</center>



<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
<div class="footer">
<footer class="row-footer">
  <br>
        <div class="container">
            <div class="row">             
                <div class="col-xs-5 col-xs-offset-1 col-sm-2 col-sm-offset-1">
                    <ul class="list-unstyled"><br>
                        <li><a href="#">Home</a></li>
                        <li><a href="#">About</a></li>
                        <li><a href="#">Contact</a></li>
                    </ul>
                </div>
                <div class="col-xs-6 col-sm-5" >
                    <h5>Our Service</h5>
                    <address>
                       <i class="fa fa-phone" id="phonenumber"></i>:6303504956<br>
                       <i class="fa fa-envelope"></i>:<a style="left:0;" href="bhangeravishankar2302@gmail.com">bhangeravishankar@gmail.com</a>
                    </address>
                </div>
                <div class="col-xs-12 col-sm-4">
                    <div class="nav navbar-nav" style="padding: 40px 10px;"><ul>
                        <a class="btn-social-icon btn-google-plus" href="http://google.com/+"><i class="fa fa-google-plus"></i></a>
                        <a class="btn-social-icon btn-facebook" href="http://www.facebook.com/profile.php?id="><i class="fa fa-facebook"></i></a>
                        <a class="btn-social-icon btn-linkedin" href="http://www.linkedin.com/in/"><i class="fa fa-linkedin"></i></a>
                        <a class="btn-social-icon btn-twitter" href="http://twitter.com/"><i class="fa fa-twitter"></i></a>
                        <a class="btn-social-icon btn-youtube" href="http://youtube.com/"><i class="fa fa-youtube"></i></a>
                        <a class="btn-social-icon" href="mailto:"><i class="fa fa-envelope-o"></i></a>
                        </ul>
                    </div>
                </div>
                <div class="col-xs-12">
                    <p style="padding:0px; border:0px;"></p>
                    <p style="text-align: center;padding-left: 450px; color:white;">� Copyright 2022 RavishankarBhange</p>
                </div>
            </div>
        </div>
    </footer>
</div>





</body>
</html>