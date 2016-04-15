package dbi01;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javafx.beans.property.SimpleStringProperty;
import javafx.beans.value.ObservableValue;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.util.Callback;

public class FXMLDocumentController {
    ObservableList<ObservableList> data;
    ObservableList<String> row;
    
    Connection conn = null;

    @FXML
    private Button buttonConnect;

    @FXML
    private Button buttonSearch;

    @FXML
    private TextField textfieldSearch;

    @FXML
    private Label labelStatement;

    @FXML
    private TableView<ObservableList> tableviewOutput;

    @FXML
    void onClickConnect(ActionEvent event) throws SQLException {
        data = FXCollections.observableArrayList();
        String connStr = "jdbc:oracle:thin:@oracledb.htl-donaustadt.at:1521:XE";
        conn = DriverManager.getConnection(connStr, "if4akoepplm", "Michael");
        Statement st = conn.createStatement();
        String SQL = "SELECT * FROM LAGER";
        ResultSet rs = st.executeQuery(SQL);

        while (rs.next()) {
            row = FXCollections.observableArrayList();
            for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
                row.add(rs.getString(i));
            }
            
            data.add(row);
        }
        
        tableviewOutput.setItems(data);
        rs.close();
        
        TableColumn lnr = new TableColumn("LNR");
        lnr.setCellValueFactory(new Callback<TableColumn.CellDataFeatures<ObservableList,String>,ObservableValue<String>> (){                    
            public ObservableValue<String> call(TableColumn.CellDataFeatures<ObservableList, String> param) {                                                                                              
                return new SimpleStringProperty(param.getValue().get(0).toString());                        
            }                    
        });
        
        
        TableColumn ort = new TableColumn("Ort");
        ort.setCellValueFactory(new Callback<TableColumn.CellDataFeatures<ObservableList,String>,ObservableValue<String>> (){                    
            public ObservableValue<String> call(TableColumn.CellDataFeatures<ObservableList, String> param) {                                                                                              
                return new SimpleStringProperty(param.getValue().get(1).toString());                        
            }                    
        });
        
        TableColumn stueckkap = new TableColumn("STUECKKAP");
        stueckkap.setCellValueFactory(new Callback<TableColumn.CellDataFeatures<ObservableList,String>,ObservableValue<String>> (){                    
            public ObservableValue<String> call(TableColumn.CellDataFeatures<ObservableList, String> param) {                                                                                              
                return new SimpleStringProperty(param.getValue().get(2).toString());                        
            }                    
        });

        tableviewOutput.getColumns().addAll(lnr, ort, stueckkap);

    }

    @FXML
    void onClickSearch(ActionEvent event) {
        PreparedStatement prep;
        ResultSet rs;
        
        String sql = "SELECT anr, bezeichnung FROM artikel";
        
        try {
            prep = conn.prepareStatement(sql);
            rs = prep.executeQuery();
            while(rs.next()) {
                System.out.println(rs.getRow());
                row.add(rs.getString(rs.getRow()));
                data.add(row);
                tableviewOutput.getItems().add(data);
            }
        } catch (SQLException ex) {
            System.out.println(ex.toString());
        }
    }

}
