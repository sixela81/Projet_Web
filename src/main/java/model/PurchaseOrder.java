/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.Date;
/**
 *
 * @author cptbo
 */
public class PurchaseOrder {
        private int orderNum;
        private int customerId;
	private int productID;
	private int quantity;
        private float shippingCost;
        private Date salesDate;
        private Date shippingDate;
        private String freightCompany;
        
        public PurchaseOrder(int orderNum, int customerId, int productID, int quantity, float shippingCost, Date salesDate, Date shippingDate, String freightCompany) {
                this.orderNum = orderNum;
                this.customerId = customerId;
                this.productID = productID;
                this.quantity = quantity;
                this.shippingCost = shippingCost;
                this.salesDate = salesDate;
                this.shippingDate = shippingDate;
                this.freightCompany = freightCompany;
        }
        
        public int getOrderNum() {
            return orderNum;
        }

        public int getCustomerId() {
            return customerId;
        }

        public int getProductID() {
            return productID;
        }

        public int getQuantity() {
            return quantity;
        }

        public float getShippingCost() {
            return shippingCost;
        }

        public Date getSalesDate() {
            return salesDate;
        }

        public Date getShippingDate() {
            return shippingDate;
        }

        public String getFreightCompany() {
            return freightCompany;
        }

    @Override
    public String toString() {
        return "PurchaseOrder{" + "orderNum=" + orderNum + ", customerId=" + customerId + ", productID=" + productID + ", quantity=" + quantity + ", shippingCost=" + shippingCost + ", salesDate=" + salesDate + ", shippingDate=" + shippingDate + ", freightCompany=" + freightCompany + '}';
    }
        
        
        
}
