/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fx_jdbc;

/**
 *
 * @author hoef
 */
public class Artikel {
    private int anr;
    private String bezeichnung;

    public Artikel(int anr, String bezeichnung) {
        this.anr = anr;
        this.bezeichnung = bezeichnung;
    }
    
    public Artikel() {
        this.anr = 0;
        this.bezeichnung = null;
    }

    public int getAnr() {
        return anr;
    }

    public void setAnr(int anr) {
        this.anr = anr;
    }

    public String getBezeichnung() {
        return bezeichnung;
    }

    public void setBezeichnung(String bezeichnung) {
        this.bezeichnung = bezeichnung;
    }
    
    
}
