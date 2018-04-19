/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.sql.DataSource;
/**
 *
 * @author cptbo
 */
public class DAO {
    private final DataSource myDataSource;

	/**
	 *
	 * @param dataSource la source de données à utiliser
	 */
	public DAO(DataSource dataSource) {
		this.myDataSource = dataSource;
	}

        
        public CustomerEntity findCustomer(int customerID, String emailUtilisateur) throws DAOException {
		CustomerEntity result = null;

		String sql;
                sql = "SELECT * FROM CUSTOMER WHERE CUSTOMER_ID = ? AND CUSTOMER.EMAIL = ?";
		try (Connection connection = myDataSource.getConnection(); // On crée un statement pour exécuter une requête
			PreparedStatement stmt = connection.prepareStatement(sql)) {

			stmt.setInt(1, customerID);
                        stmt.setString(2, emailUtilisateur);
			try (ResultSet rs = stmt.executeQuery()) {
				if (rs.next()) { // On a trouvé
					String name = rs.getString("NAME");
					String address = rs.getString("ADDRESSLINE1");
					// On crée l'objet "entity"
					result = new CustomerEntity(customerID, name, address,emailUtilisateur);
				} // else on n'a pas trouvé, on renverra null
			}
		}  catch (SQLException ex) {
			Logger.getLogger("DAO").log(Level.SEVERE, null, ex);
			throw new DAOException(ex.getMessage());
		}

		return result;
	}
        
        public List<PurchaseOrder> findPurchaseOrder(int customerID) throws DAOException, SQLException {
		//PurchaseOrder result = null;
                List<PurchaseOrder> result = new LinkedList<>();
               
		String sql;
                sql = "SELECT * FROM PURCHASE_ORDER WHERE CUSTOMER_ID = ?";
		try (Connection connection = myDataSource.getConnection(); // On crée un statement pour exécuter une requête
			PreparedStatement stmt = connection.prepareStatement(sql)) {

			stmt.setInt(1, customerID);

			try (ResultSet rs = stmt.executeQuery()) {
				while (rs.next()) { // On a trouvé
					int orderNum = rs.getInt("ORDER_NUM");
                                        int customerId = rs.getInt("CUSTOMER_ID");
                                        int productID = rs.getInt("PRODUCT_ID");
                                        int quantity = rs.getInt("QUANTITY");
                                        float shippingCost = rs.getFloat("SHIPPING_COST");
                                        Date salesDate = rs.getDate("SALES_DATE");
                                        Date shippingDate = rs.getDate("SHIPPING_DATE");
                                        String freightCompany = rs.getString("FREIGHT_COMPANY");
					// On crée l'objet "entity"
					PurchaseOrder PO = new PurchaseOrder(orderNum, customerId, productID, quantity, shippingCost, salesDate, shippingDate, freightCompany);
                                        
                                        result.add(PO);
                                        
				} // else on n'a pas trouvé, on renverra null
			}
		}  catch (SQLException ex) {
			Logger.getLogger("DAO").log(Level.SEVERE, null, ex);
			throw new DAOException(ex.getMessage());
		}
		return result;
        }
        
                /**
	 * Contenu de la table DISCOUNT_CODE
	 * @return Liste des discount codes
	 * @throws SQLException renvoyées par JDBC
	 */
	public List<PurchaseOrder> allCodes() throws SQLException {

		List<PurchaseOrder> result = new LinkedList<>();

		String sql = "SELECT * FROM PURCHASE_ORDER ORDER BY CUSTOMER_ID";
		try (Connection connection = myDataSource.getConnection(); 
		     PreparedStatement stmt = connection.prepareStatement(sql)) {
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
                                int orderNum = rs.getInt("ORDER_NUM");
                                int customerId = rs.getInt("CUSTOMER_ID");
                                int productID = rs.getInt("PRODUCT_ID");
                                int quantity = rs.getInt("QUANTITY");
                                float shippingCost = rs.getFloat("SHIPPING_COST");
                                Date salesDate = rs.getDate("SALES_DATE");
                                Date shippingDate = rs.getDate("SHIPPING_DATE");
                                String freightCompany = rs.getString("FREIGHT_COMPANY");
                                // On crée l'objet "purchaseOrder"
                                PurchaseOrder PO = new PurchaseOrder(orderNum, customerId, productID, quantity, shippingCost, salesDate, shippingDate, freightCompany);
                                result.add(PO);
			}
		}
		return result;
	}
        
        
        
        public int addPurchaseOrder(int orderNum, int customerId, int productID, int quantity, float shippingCost, Date salesDate, Date shippingDate, String freightCompany) throws SQLException {
		int result = 0;
		String sql = "INSERT INTO PURCHSE_ORDER VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		try (Connection connection = myDataSource.getConnection(); 
		     PreparedStatement stmt = connection.prepareStatement(sql)) {
			stmt.setInt(1, orderNum);
			stmt.setInt(2, customerId);
                        stmt.setInt(3, productID);
                        stmt.setInt(4, quantity);
                        stmt.setFloat(5, shippingCost);
                        stmt.setDate(6, (java.sql.Date) salesDate);
                        stmt.setDate(7, (java.sql.Date) shippingDate);
                        stmt.setString(8, freightCompany);
			result = stmt.executeUpdate();
		}
		return result;
	}
        
        


	/**
	 * Ajout d'un enregistrement dans la table DISCOUNT_CODE
         * @param numC
         * @param IDclient
         * @param prodid
         * @param quantite
         * @param fraisPort
         * @param dateVente
         * @param dateExp
         * @param transport
	 * @return 1 si succès, 0 sinon
	 * @throws SQLException renvoyées par JDBC
	 */
	public int addDiscountCode(int numC, int IDclient, int prodid, int quantite, float fraisPort, Date dateVente, Date dateExp, String transport) throws SQLException {
		int result = 0;

		String sql = "INSERT INTO PURCHASE_ORDER VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		try (Connection connection = myDataSource.getConnection(); 
		     PreparedStatement stmt = connection.prepareStatement(sql)) {
			stmt.setInt(1, numC);
			stmt.setInt(2, IDclient);
                        stmt.setInt(3, prodid);
                        stmt.setInt(4, quantite);
                        stmt.setFloat(5, fraisPort);
                        stmt.setDate(6, (java.sql.Date) dateVente);
                        stmt.setDate(7, (java.sql.Date) dateExp);
                        stmt.setString(8, transport);
			result = stmt.executeUpdate();
		}
		return result;
	}

		
	/**
	 * Supprime un enregistrement dans la table DISCOUNT_CODE
	 * @param code la clé de l'enregistrement à supprimer
	 * @return le nombre d'enregistrements supprimés (1 ou 0)
	 * @throws java.sql.SQLException renvoyées par JDBC
	 **/
	public int deleteDiscountCode(int code) throws SQLException {
		int result = 0;
		String sql = "DELETE FROM PURCHASE_ORDER WHERE ORDER_NUM = ?";
		try (Connection connection = myDataSource.getConnection(); 
		     PreparedStatement stmt = connection.prepareStatement(sql)) {
			stmt.setInt(1, code);
			result = stmt.executeUpdate();
		}
		return result;
	}
        
        public int modifPurchaseOrder(int numC, int IDclient, int prodid, int quantite, float fraisPort, Date dateVente, Date dateExp, String transport) throws SQLException {
            int result = 0;
            //String sql = "UPDATE PURCHASE_ORDER SET ORDER_NUM= " + numC + ", CUSTOMER_ID= " + IDclient + ", PRODUCT_ID="+prodid + ", QUANTITY=?, SHIPPING_COST=?, SALES_DATE=?, SHIPPING_DATE=?, FREIGHT_COMPANY=? WHERE CUSTOMER_ID=" + IDclient;
            String sql = "UPDATE PURCHASE_ORDER SET PRODUCT_ID=? , QUANTITY=?, SHIPPING_COST=?, SALES_DATE=?, SHIPPING_DATE=?, FREIGHT_COMPANY=? WHERE CUSTOMER_ID=" + IDclient +"AND ORDER_NUM=" + numC;
            try (Connection connection = myDataSource.getConnection(); 
		     PreparedStatement stmt = connection.prepareStatement(sql)) {
			/*stmt.setInt(1, numC);
			stmt.setInt(2, IDclient);*/
                        stmt.setInt(1, prodid);
                        stmt.setInt(2, quantite);
                        stmt.setFloat(3, fraisPort);
                        stmt.setDate(4, (java.sql.Date) dateVente);
                        stmt.setDate(5, (java.sql.Date) dateExp);
                        stmt.setString(6, transport);
			result = stmt.executeUpdate();
		}
                return result;
        }
        
	public List<Product> allProducts() throws SQLException {

		List<Product> result = new LinkedList<>();

		String sql = "SELECT * FROM PRODUCT ORDER BY PRODUCT_ID";
		try (Connection connection = myDataSource.getConnection(); 
		     PreparedStatement stmt = connection.prepareStatement(sql)) {
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {                                
                                int prodid = rs.getInt("PRODUCT_ID");
                                int manufac_id = rs.getInt("MANUFACTURER_ID");
                                String code = rs.getString("PRODUCT_CODE");
                                float cout_achat = rs.getFloat("PURCHASE_COST");
                                int quantite_dispo = rs.getInt("QUANTITY_ON_HAND");
                                float majoration = rs.getFloat("MARKUP");
                                boolean dispo = rs.getBoolean("AVAILABLE");
                                String descrip = rs.getString("DESCRIPTION");
                                // On crée l'objet "product"
                                Product p = new Product(prodid, manufac_id, code, cout_achat, quantite_dispo, majoration, dispo, descrip);
                                result.add(p);
			}
		}
		return result;
	}
        
        //Date datedeb, Date datefin

    /**
     *
     * @param datedeb
     * @param datefin
     * @return
     * @throws SQLException
     * @throws DAOException
     */
        
        public Map<String, Double> CAclient(Date datedeb, Date datefin) throws SQLException, DAOException {
            Map<String, Double> result = new HashMap<>();
            String sql;
            sql = "select customer.name, sum(quantity*purchase_cost + shipping_cost) as CA, rate from purchase_order "
                  + "inner join product using (product_id)inner join customer using(customer_id) "
                  + "inner join discount_code using (discount_code) where sales_date >= ? and sales_date <= ? "
                  + "group by customer.name, rate";

            try (Connection connection = myDataSource.getConnection(); 
			PreparedStatement stmt = connection.prepareStatement(sql)) {
			stmt.setDate(1, datedeb);
                        stmt.setDate(2, datefin);

			try (ResultSet rs = stmt.executeQuery()) {
				while (rs.next()) {
                                    String name = rs.getString("name");
                                    Double CA = rs.getDouble("ca")*(1-rs.getDouble("rate")/100);
                                    result.put(name, CA);
				} 
			}
		}  catch (SQLException ex) {
			Logger.getLogger("DAO").log(Level.SEVERE, null, ex);
			throw new DAOException(ex.getMessage());
		}
            return result;
        }
        
        
        public Map<String, Double> CAzone(Date datedeb, Date datefin) throws SQLException, DAOException {
            Map<String, Double> result = new HashMap<>();
            String sql;
            sql = "select state, sum(quantity*shipping_cost) as CA from purchase_order inner join customer using(customer_id)"
                  //+ "inner join discount_code using(discount_code)"
                  + "where sales_date >= ? and sales_date <= ? group by state";
            
            try (Connection connection = myDataSource.getConnection(); 
			PreparedStatement stmt = connection.prepareStatement(sql)) {
			stmt.setDate(1, datedeb);
                        stmt.setDate(2, datefin);

			try (ResultSet rs = stmt.executeQuery()) {
				while (rs.next()) {
                                    String state = rs.getString("state");
                                    Double CA = rs.getDouble("ca")/*(1-rs.getDouble("rate")/100)*/;
                                    result.put(state, CA);
				} 
			}
		}  catch (SQLException ex) {
			Logger.getLogger("DAO").log(Level.SEVERE, null, ex);
			throw new DAOException(ex.getMessage());
		}
            return result;
        }
        
        public Map<String, Double> CAzip(Date datedeb, Date datefin) throws SQLException, DAOException {
            Map<String, Double> result = new HashMap<>();
            String sql;
            sql = "select zip, sum(quantity*shipping_cost) as CA from purchase_order inner join customer using(customer_id)"
                  +" where sales_date >= ? and sales_date <= ? group by zip";
            
            try (Connection connection = myDataSource.getConnection(); 
			PreparedStatement stmt = connection.prepareStatement(sql)) {
			stmt.setDate(1, datedeb);
                        stmt.setDate(2, datefin);

			try (ResultSet rs = stmt.executeQuery()) {
				while (rs.next()) {
                                    String zip = rs.getString("zip");
                                    Double CA = rs.getDouble("ca");
                                    
                                    result.put(zip, CA);
				} 
			}
		}  catch (SQLException ex) {
			Logger.getLogger("DAO").log(Level.SEVERE, null, ex);
			throw new DAOException(ex.getMessage());
		}
            return result;
        }
        
        public Map<String, Double> CAproduct(Date datedeb, Date datefin) throws SQLException, DAOException {
            Map<String, Double> result = new HashMap<>();
            String sql;
            sql =   "select product_code.description, sum(purchase_order.quantity*purchase_order.shipping_cost) as CA from product "
                   + "inner join product_code on prod_code=product_code "
                   + "inner join purchase_order using (product_id) "
                   + "where sales_date >= ? and sales_date <= ? group by product_code.description";
            
            try (Connection connection = myDataSource.getConnection(); 
			PreparedStatement stmt = connection.prepareStatement(sql)) {
			stmt.setDate(1, datedeb);
                        stmt.setDate(2, datefin);

			try (ResultSet rs = stmt.executeQuery()) {
				while (rs.next()) {
                                    String description = rs.getString("description");
                                    Double CA = rs.getDouble("ca");
                                    result.put(description, CA);
				} 
			}
		}  catch (SQLException ex) {
			Logger.getLogger("DAO").log(Level.SEVERE, null, ex);
			throw new DAOException(ex.getMessage());
		}
            return result;
        }
        
}

