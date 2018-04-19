/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author cptbo
 */
public class Product {
    private int id;
    private int manufac_id;
    private String code;
    private float cout_achat;
    private int quantite_dispo;
    private float majoration;
    private boolean disponible;
    private String description;

    public Product(int id, int manufac_id, String code, float cout_achat, int quantite_dispo, float majoration, boolean disponible, String description) {
        this.id = id;
        this.manufac_id = manufac_id;
        this.code = code;
        this.cout_achat = cout_achat;
        this.quantite_dispo = quantite_dispo;
        this.majoration = majoration;
        this.disponible = disponible;
        this.description = description;
    }

    public int getId() {
        return id;
    }

    public int getManufac_id() {
        return manufac_id;
    }

    public String getCode() {
        return code;
    }

    public float getCout_achat() {
        return cout_achat;
    }

    public int getQuantite_dispo() {
        return quantite_dispo;
    }

    public float getMajoration() {
        return majoration;
    }

    public boolean isDisponible() {
        return disponible;
    }

    public String getDescription() {
        return description;
    }
    
    
}
