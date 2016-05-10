package fx_jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.Node;
import javafx.scene.control.Button;
import javafx.scene.control.ContextMenu;
import javafx.scene.control.Label;
import javafx.scene.control.MenuItem;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableRow;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.input.MouseButton;

public class FXMLDocumentController {

    private final ObservableList<Artikel> data = FXCollections.observableArrayList();
    private Connection DbConnection;
    int lastClickedItem = 0;
    
    @FXML
    private MenuItem changePriceAction;

    @FXML
    private TextField nameTextField;

    @FXML
    private Button addButton;

    @FXML
    private Label label;

    @FXML
    private TextField priceUpdateTextField;

    @FXML
    private MenuItem deleteAction;

    @FXML
    private MenuItem updateAction;

    @FXML
    private MenuItem addAction;

    @FXML
    private Button changePriceButton;

    @FXML
    private ContextMenu contextMenu;

    @FXML
    private TextField nameUpdateTextField;

    @FXML
    private Button updateButton;

    @FXML
    private TableView<Artikel> fx_tabelle;

    void updateTable() {
        PreparedStatement prep;
        ResultSet rs;

        String sql = "SELECT a.anr, a.bezeichnung, p.preis FROM artikel a left join preise p on p.anr = a.anr where gueltig_bis is null";
        try {
            data.clear();
            prep = DbConnection.prepareStatement(sql);
            rs = prep.executeQuery();
            while (rs.next()) {
                data.add(new Artikel(rs.getInt(1), rs.getString(2), rs.getDouble(3)));
            }

        } catch (SQLException ex) {
            Logger.getLogger(FXMLDocumentController.class.getName()).log(Level.SEVERE, null, ex);
        }
        /*if (!fx_tabelle.getItems().isEmpty()) {
            fx_tabelle.getItems().clear();
        }*/
        fx_tabelle.setItems(data);
        //fx_tabelle.refresh();
    }

    @FXML
    void handleAddAction(ActionEvent event) {
        nameTextField.requestFocus();
    }

    @FXML
    void handleAddButtonAction(ActionEvent event) {
        if (nameTextField.getText().length() == 0) {
            return;
        }
        PreparedStatement prep;
        ResultSet rs;
        int highestId = 0;

        String sql = "SELECT anr FROM artikel";
        try {
            prep = DbConnection.prepareStatement(sql);
            rs = prep.executeQuery();
            while (rs.next()) {
                highestId = rs.getInt(1);
            }

        } catch (SQLException ex) {
            Logger.getLogger(FXMLDocumentController.class.getName()).log(Level.SEVERE, null, ex);
        }

        highestId++;

        sql = "INSERT INTO artikel (ANR, Bezeichnung) VALUES (" + highestId + ", '" + nameTextField.getText() + "')";
        System.out.println(sql);
        try {
            prep = DbConnection.prepareStatement(sql);
            prep.execute(sql);
        } catch (SQLException ex) {
            Logger.getLogger(FXMLDocumentController.class.getName()).log(Level.SEVERE, null, ex);
        }
        updateTable();
        nameTextField.clear();
    }

    @FXML
    void handleDeleteButtonAction(ActionEvent event) {
        PreparedStatement prep;
        String sql = "DELETE FROM artikel WHERE ANR=" + fx_tabelle.getItems().get(lastClickedItem).getAnr();
        System.out.println(sql);
        try {
            prep = DbConnection.prepareStatement(sql);
            prep.execute(sql);
        } catch (SQLException ex) {
            Logger.getLogger(FXMLDocumentController.class.getName()).log(Level.SEVERE, null, ex);
        }
        updateTable();
    }

    @FXML
    void handleUpdateAction(ActionEvent event) {
        nameUpdateTextField.setDisable(false);
        updateButton.setDisable(false);
        nameUpdateTextField.setText(fx_tabelle.getItems().get(lastClickedItem).getBezeichnung());
        nameUpdateTextField.requestFocus();
    }

    @FXML
    void handleUpdateButtonAction(ActionEvent event) {
        if (nameUpdateTextField.getText().length() == 0) {
            return;
        }
        PreparedStatement prep;
        String sql = "UPDATE artikel SET Bezeichnung='" + nameUpdateTextField.getText() + "' WHERE ANR=" + fx_tabelle.getItems().get(lastClickedItem).getAnr();
        System.out.println(sql);
        try {
            prep = DbConnection.prepareStatement(sql);
            prep.execute(sql);
        } catch (SQLException ex) {
            Logger.getLogger(FXMLDocumentController.class.getName()).log(Level.SEVERE, null, ex);
        }
        updateTable();
        updateButton.setDisable(true);
        nameUpdateTextField.setDisable(true);
        nameUpdateTextField.clear();
    }

    @FXML
    void handleChangePriceAction(ActionEvent event) {
        priceUpdateTextField.setText("" + fx_tabelle.getItems().get(lastClickedItem).getPreis());
        changePriceButton.setDisable(false);
        priceUpdateTextField.setDisable(false);
        priceUpdateTextField.requestFocus();
    }

    @FXML
    void handleChangePriceButtonAction(ActionEvent event) {
        PreparedStatement prep;
        // sql statement abaendern
        String sql = "UPDATE preise SET PREIS='" + priceUpdateTextField.getText() + 
                "' WHERE ANR=" + fx_tabelle.getItems().get(lastClickedItem).getAnr() +
                " AND gueltig_bis is null";
        System.out.println(sql);
        try {
            prep = DbConnection.prepareStatement(sql);
            prep.execute(sql);
        } catch (SQLException ex) {
            Logger.getLogger(FXMLDocumentController.class.getName()).log(Level.SEVERE, null, ex);
        }
        updateTable();
        changePriceButton.setDisable(true);
        priceUpdateTextField.setDisable(true);
        priceUpdateTextField.clear();
    }

    @FXML
    void initialize() {
        TableColumn ColAnr = new TableColumn("Anr");
        ColAnr.setMinWidth(100);
        ColAnr.setCellValueFactory(
                new PropertyValueFactory<>("anr"));

        TableColumn ColBezeichnung = new TableColumn("Bezeichnung");
        ColBezeichnung.setMinWidth(100);
        ColBezeichnung.setCellValueFactory(
                new PropertyValueFactory<>("bezeichnung"));

        TableColumn colPreis = new TableColumn("Preis");
        colPreis.setMinWidth(100);
        colPreis.setCellValueFactory(
                new PropertyValueFactory<>("preis")
        );

        fx_tabelle.getColumns().addAll(ColAnr, ColBezeichnung, colPreis);

        fx_tabelle.setRowFactory(tv -> {
            TableRow<Artikel> row = new TableRow<>();
            row.setOnMouseClicked(event -> {
                if (!row.isEmpty() && event.getButton() == MouseButton.SECONDARY
                        && event.getClickCount() == 1) {

                    Artikel clickedRow = row.getItem();
                    lastClickedItem = row.getIndex();
                    //printRow(clickedRow);
                    contextMenu.show(((Node)event.getTarget()).getScene().getWindow());
                }
            });
            return row;
        });

        String connString;
        connString = makeConnectionString("oracledb.htl-donaustadt.at");

        try {

            DbConnection = DriverManager.getConnection(connString, "if4akoepplm", "Michael");

        } catch (SQLException ex) {
            Logger.getLogger(FXMLDocumentController.class.getName()).log(Level.SEVERE, null, ex);
        }

        updateTable();
    }

    public String makeConnectionString(String host) {
        String connStr = null;
        // Mit MySql verbinden
        // connStr = "jdbc:mysql://" + host + "/scott";
        // z.B jdbc:mysql://mysql.htl-donaustadt.at/scott

        // Mit oracle verbinden
        connStr = "jdbc:oracle:thin:@" + host + ":1521:XE";
        // jdbc:oracle:thin:@oracledb.htl-donaustadt.at:1521:XE
        return connStr;
    }

}
