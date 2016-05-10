/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fx_jdbc;

/**
 *
 * @author iiiiisch
 */
public class Artikel {
    private int anr;
    private String bezeichnung;
    private double preis;

    public Artikel(int anr, String bezeichnung, double preis) {
        this.anr = anr;
        this.bezeichnung = bezeichnung;
        this.preis = preis;
    }
    
    public Artikel() {
        this.anr = 0;
        this.bezeichnung = null;
        this.preis = 0;
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
    
    public double getPreis() {
        return this.preis;
    }
    
    public void setPreis(double preis) {
        this.preis = preis;
    }
}
