package servlet;

import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import model.DAO;
import model.DataSourceFactory;
import model.DiscountCode;
import model.PurchaseOrder;
import org.apache.derby.tools.ij;

/**
 * Web application lifecycle listener, initialise la base de données au
 * démarrage de l'application si nécessaire
 */
@WebListener()
public class DatabaseInitializer implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        if (!databaseExists()) {
            initializeDatabase();
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {

    }

    private boolean databaseExists() {
        boolean result = false;

        DAO dao = new DAO(DataSourceFactory.getDataSource());
        try {
            List<PurchaseOrder> allCodes = dao.allCodes();
            Logger.getLogger("PurchaseOEditor").log(Level.INFO, "Database already exists");
            result = true;
        } catch (SQLException ex) {
            Logger.getLogger("PurchaseOEditor").log(Level.INFO, "Database does not exist");
        }
        return result;
    }

    private void initializeDatabase() {
        OutputStream nowhere = new OutputStream() {
            @Override
            public void write(int b) {
            }
        };

        Logger.getLogger("PurchaseOEditor").log(Level.INFO, "Creating databse from SQL script");
        try {
            Connection connection = DataSourceFactory.getDataSource().getConnection();
            int result = ij.runScript(connection, this.getClass().getResourceAsStream("export.sql"), "UTF-8", System.out /* nowhere */, "UTF-8");
            if (result == 0) {
                Logger.getLogger("PurchaseOEditor").log(Level.INFO, "Database succesfully created");
            } else {
                Logger.getLogger("PurchaseOEditor").log(Level.SEVERE, "Errors creating database");
            }

        } catch (UnsupportedEncodingException | SQLException e) {
            Logger.getLogger("PurchaseOEditor").log(Level.SEVERE, null, e);
        }

    }
}
