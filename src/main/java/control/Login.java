package control;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.nio.charset.StandardCharsets;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.DriverManagerConnectionPool;
import model.OrderModel;
import model.UserBean;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String email = request.getParameter("j_email");
		String password = request.getParameter("j_password");
		String redirectedPage = "/loginPage.jsp";
		Boolean control = false;
		try {
			Connection con = DriverManagerConnectionPool.getConnection();
			String sql = "SELECT email, passwordUser, ruolo, nome, cognome, indirizzo, telefono, numero, intestatario, CVV FROM UserAccount";
			
			Statement s = con.createStatement();
			ResultSet rs = s.executeQuery(sql);
			
			while (rs.next()) {
				if (email.compareTo(rs.getString(1)) == 0) {
					String psw = checkPsw(password);
					if (psw.compareTo(rs.getString(2)) == 0) {
						control = true;
						UserBean registeredUser = new UserBean();
						registeredUser.setEmail(rs.getString(1));
						registeredUser.setNome(rs.getString(4));
						registeredUser.setCognome(rs.getString(5));
						registeredUser.setIndirizzo(rs.getString(6));
						registeredUser.setTelefono(rs.getString(7));
						registeredUser.setNumero(rs.getString(8));
						registeredUser.setIntestatario(rs.getString(9));
						registeredUser.setCvv(rs.getString(10));
						registeredUser.setRole(rs.getString(3));
						request.getSession().setAttribute("registeredUser", registeredUser);
						request.getSession().setAttribute("role", registeredUser.getRole());
						request.getSession().setAttribute("email", rs.getString(1));
						request.getSession().setAttribute("nome", rs.getString(6));
						
						OrderModel model = new OrderModel();
						request.getSession().setAttribute("listaOrdini", model.getOrders(rs.getString(1)));
						
						redirectedPage = "/index.jsp";
						DriverManagerConnectionPool.releaseConnection(con);
					}
				}
			}
		}
		catch (Exception e) {
			redirectedPage = "/loginPage.jsp";
		}
		if (control == false) {
			request.getSession().setAttribute("login-error", true);
		}
		else {
			request.getSession().setAttribute("login-error", false);
		}
		response.sendRedirect(request.getContextPath() + redirectedPage);
	}
		
	private String checkPsw(String psw) {
		MessageDigest md = null;
		try {
			// Creare un'istanza di MessageDigest con l'algoritmo MD5
            md = MessageDigest.getInstance("MD5");

            // La stringa di input che vuoi hashare
            String input = "exampleString";

            // Convertire la stringa in byte e aggiornare il digest
            byte[] hashInBytes = md.digest(input.getBytes(StandardCharsets.UTF_8));

            // Convertire l'array di byte in una rappresentazione esadecimale
            StringBuilder sb = new StringBuilder();
            for (byte b : hashInBytes) {
                sb.append(String.format("%02x", b));
		}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		byte[] messageDigest = md.digest(psw.getBytes());
		BigInteger number = new BigInteger(1, messageDigest);
		String hashtext = number.toString(16);
		
		return hashtext;
	}

}
