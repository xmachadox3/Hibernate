package com.persistentes;
// Generated 23/07/2015 03:35:00 PM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * Cliente generated by hbm2java
 */
public class Cliente  implements java.io.Serializable {


     private String idpersona;
     private Paquete paquete;
     private Persona persona;
     private String ndeposito;
     private Set reservas = new HashSet(0);
     private Set pagos = new HashSet(0);

    public Cliente() {
    }

	
    public Cliente(Persona persona) {
        this.persona = persona;
    }
    public Cliente(Paquete paquete, Persona persona, String ndeposito, Set reservas, Set pagos) {
       this.paquete = paquete;
       this.persona = persona;
       this.ndeposito = ndeposito;
       this.reservas = reservas;
       this.pagos = pagos;
    }
   
    public String getIdpersona() {
        return this.idpersona;
    }
    
    public void setIdpersona(String idpersona) {
        this.idpersona = idpersona;
    }
    public Paquete getPaquete() {
        return this.paquete;
    }
    
    public void setPaquete(Paquete paquete) {
        this.paquete = paquete;
    }
    public Persona getPersona() {
        return this.persona;
    }
    
    public void setPersona(Persona persona) {
        this.persona = persona;
    }
    public String getNdeposito() {
        return this.ndeposito;
    }
    
    public void setNdeposito(String ndeposito) {
        this.ndeposito = ndeposito;
    }
    public Set getReservas() {
        return this.reservas;
    }
    
    public void setReservas(Set reservas) {
        this.reservas = reservas;
    }
    public Set getPagos() {
        return this.pagos;
    }
    
    public void setPagos(Set pagos) {
        this.pagos = pagos;
    }




}


