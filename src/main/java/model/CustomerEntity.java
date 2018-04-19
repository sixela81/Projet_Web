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
public class CustomerEntity {
        private int customerId;
	private String name;
	private String addressLine1;
        private String email;

	public CustomerEntity(int customerId, String name, String addressLine1, String email) {
		this.customerId = customerId;
		this.name = name;
		this.addressLine1 = addressLine1;
                this.email = email;
	}

	/**
	 * Get the value of customerId
	 *
	 * @return the value of customerId
	 */
	public int getCustomerId() {
		return customerId;
	}

	/**
	 * Get the value of name
	 *
	 * @return the value of name
	 */
	public String getName() {
		return name;
	}

	/**
	 * Get the value of addressLine1
	 *
	 * @return the value of addressLine1
	 */
	public String getAddressLine1() {
		return addressLine1;
	}
        
        /**
	 * Get the value of email
	 *
	 * @return the value of email
	 */
	public String getEmail() {
		return email;
	}
}
