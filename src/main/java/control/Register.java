package control;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.DriverManagerConnectionPool;
import org.mindrot.jbcrypt.BCrypt;

/**
 * Servlet implementation class Register
 */
@WebServlet("/Register")
public class Register extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public Register() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        String indirizzo = request.getParameter("indirizzo");
        String telefono = request.getParameter("telefono");
        String carta = request.getParameter("carta");
        String intestatario = request.getParameter("intestatario");
        String cvv = request.getParameter("cvv");
        String redirectedPage = "/loginPage.jsp";

        // Hash the password using BCrypt
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        Connection con = null;
        PreparedStatement ps = null;
        PreparedStatement ps2 = null;
        PreparedStatement ps3 = null;

        try {
            con = DriverManagerConnectionPool.getConnection();
            con.setAutoCommit(false); // Disable auto-commit

            String sql = "INSERT INTO UserAccount(email, passwordUser, nome, cognome, indirizzo, telefono, numero, intestatario, CVV) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            String sql2 = "INSERT INTO Cliente(email) VALUES (?)";
            String sql3 = "INSERT INTO Venditore(email) VALUES (?)";

            // Insert into UserAccount
            ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, hashedPassword);
            ps.setString(3, nome);
            ps.setString(4, cognome);
            ps.setString(5, indirizzo);
            ps.setString(6, telefono);
            ps.setString(7, carta);
            ps.setString(8, intestatario);
            ps.setString(9, cvv);
            ps.executeUpdate();

            // Insert into Cliente
            ps2 = con.prepareStatement(sql2);
            ps2.setString(1, email);
            ps2.executeUpdate();

            // Insert into Venditore
            ps3 = con.prepareStatement(sql3);
            ps3.setString(1, email);
            ps3.executeUpdate();

            // Commit the transaction
            con.commit();
        } catch (SQLException e) {
            if (con != null) {
                try {
                    con.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            request.getSession().setAttribute("register-error", true);
            redirectedPage = "/register-form.jsp";
        } finally {
            // Ensure resources are closed
            try {
                if (ps != null) ps.close();
                if (ps2 != null) ps2.close();
                if (ps3 != null) ps3.close();
                if (con != null) DriverManagerConnectionPool.releaseConnection(con);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect(request.getContextPath() + redirectedPage);
    }
}
