package com.persistentes;
// Generated 23/07/2015 03:35:00 PM by Hibernate Tools 4.3.1



/**
 * Reserva generated by hbm2java
 */
public class Reserva  implements java.io.Serializable {


     private String codigo;
     private Cliente cliente;
     private Paquete paquete;

    public Reserva() {
    }

	
    public Reserva(String codigo) {
        this.codigo = codigo;
    }
    public Reserva(String codigo, Cliente cliente, Paquete paquete) {
       this.codigo = codigo;
       this.cliente = cliente;
       this.paquete = paquete;
    }
   
    public String getCodigo() {
        return this.codigo;
    }
    
    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }
    public Cliente getCliente() {
        return this.cliente;
    }
    
    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }
    public Paquete getPaquete() {
        return this.paquete;
    }
    
    public void setPaquete(Paquete paquete) {
        this.paquete = paquete;
    }




}


