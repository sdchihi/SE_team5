<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import ="java.sql.*" %>
    
<%
    String DRIVER = "oracle.jdbc.driver.OracleDriver";
    String URL = "jdbc:oracle:thin:@127.0.0.1:1521:DBSERVER"; 
    String USER = "SE";
    String PASS = "SE";

	Connection conn = null;
	try{
		Class.forName(DRIVER);
		conn = DriverManager.getConnection(URL,USER,PASS);
	}catch(Exception e){
		System.out.println(e.getMessage());
	}
	
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8");
	String reservationNumber = request.getParameter("reservationNumber");
    String userId = (String)session.getAttribute("userId");
    String cinemaRegion = request.getParameter("cinemaRegion");
    String theaterName = request.getParameter("theaterName");
    String startTime = request.getParameter("startTime");
    String price = request.getParameter("price");
    int row = Integer.parseInt(request.getParameter("row"));
    int column = Integer.parseInt(request.getParameter("column"));
    
    int[] rows = new int[row * column];
    int[] columns = new int[row * column];
    int count = 0;
   
	for(int i = 1; i <= row; i++) {
		for(int j = 1; j <= column; j++) {
			String a = "seat" + i + "" + j;
			int d = Integer.parseInt(request.getParameter("seat" + i + "" + j));
			if(d == 1) {
				rows[count] = i;
				columns[count++] = j;
			}
		}
	}
   

   
%>
    
<!DOCTYPE html>
<html>
    <head>
        <script language="javascript" type="text/javascript">

            function dispList(selectList) {

                var obj1 = document.getElementById("card_id"); 
                var obj2 = document.getElementById("cell_phone"); 


                if(selectList.id == 'card') { 
                    obj1.style.display = "block"; 
                    obj2.style.display = "none";


                } else if(selectList.id == 'cp'){ 
                    obj1.style.display = "none";
                    obj2.style.display = "block"; 
                }
            }
        </script>
    </head>
    
<body>
    
<form action = "payment_decision.jsp" method = "post">
    <p>가 격 <input type = "text" name = "price" value="<%out.print(price);%>" ><br></p>
    <p>결제수단</p>
    <p>
        <input type="radio" name="credit_method" value="INTERNET" id = "card" onclick="javascript:dispList(card);"> 신용카드
        <input type="radio" name="credit_method" value="PHONE" id = "cp" onclick="javascript:dispList(cp);"> 휴대폰
    </p>

<div id = "card_id" style="display:none"> 카드사
<select name="card_offi">
    <option value="">카드사 선택</option>
    <option value="hana">KEB 하나</option>
    <option value="nhk">농 협</option>
    <option value="kb">국 민</option>
    <option value="ibk">기 업</option>
</select>
    <p method="post">카드번호 <input type = "text" name = "card_number" placeholder="'-'없이 입력해주십시오"><br>
    </p>
</div>

    
<div id = "cell_phone" style="display:none"> 통신사
<select name="phone_offi">
    <option value="">통신사 선택</option>
    <option value="skt">SKT</option>
    <option value="kt">KT</option>
    <option value="lg">LG</option>
</select>
    <p method="post">휴대폰번호 <input type = "text" name = "phone_number" placeholder="'-'없이 입력해주십시오"><br>
    </p>
</div>

<p>   
    <button type = "submit"> 결 제 </button>
    <a href="movie_list.jsp" target="_self">
        <button type = "button"> 취 소 </button>
    </a>
</p>
<input type="text" name="cinemaRegion" value="<%out.print(cinemaRegion);%>" style=display:none>
<input type="text" name="price" value="<%out.print(price);%>" style=display:none>
<input type="text" name="theaterName" value="<%out.print(theaterName);%>" style=display:none>
<input type="text" name="startTime" value="<%out.print(startTime);%>" style=display:none>
<input type="text" name="reservationNumber" value="<%out.print(reservationNumber);%>" style=display:none>
<input type="text" name="seatCount" value="<%out.print(count);%>" style=display:none>
<%for(int i = 0; i < count; i++) {%>
	<input type="text" name="row<%out.print(i);%>" value="<%out.print(rows[i]);%>" style=display:none>
	<input type="text" name="column<%out.print(i);%>" value="<%out.print(columns[i]);%>" style=display:none>
<%}%>
</form>
</body>
</html>