package de.uni_tuebingen.ub.nppm.model;

import java.time.LocalDateTime;
import javax.persistence.*;

@Entity
@Table(name = "benutzer")
public class Benutzer {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private int ID;

    @Column(name = "Login")
    private String Login;

    @Column(name = "Nachname")
    private String Nachname;

    @Column(name = "Vorname")
    private String Vorname;

    @Column(name = "EMail")
    private String EMail;

    @Column(name = "Password")
    private String Password;

    @Column(name = "IstAdmin")
    private boolean IstAdmin;

    @ManyToOne(targetEntity = BenutzerGruppe.class)
    @JoinColumn(name = "GruppeID", referencedColumnName = "ID")
    private BenutzerGruppe Gruppe;

    @Column(name = "Sprache")
    private String Sprache;

    @Column(name = "IstGast")
    private boolean IstGast;

    @Column(name = "IstAktiv", columnDefinition = "TINYINT")
    private boolean IstAktiv;

    @Column(name = "IstReadOnly", columnDefinition = "TINYINT")
    private boolean IstReadOnly;

    @Column(name = "ResetToken")
    private String ResetToken;

    @Column(name = "ResetTokenValidUntil")
    private LocalDateTime ResetTokenValidUntil;

    @Column(name = "Salt")
    private String Salt;

    public String getResetToken() {
        return ResetToken;
    }

    public void setResetToken(String ResetToken) {
        this.ResetToken = ResetToken;
    }

    public LocalDateTime getResetTokenValidUntil() {
        return ResetTokenValidUntil;
    }

    public void setResetTokenValidUntil(LocalDateTime ResetTokenValidUntil) {
        this.ResetTokenValidUntil = ResetTokenValidUntil;
    }

    public String getSalt() {
        return Salt;
    }

    public void setSalt(String Salt) {
        this.Salt = Salt;
    }

    public String getPassword() {
        return Password;
    }

    public void setPassword(String Password) {
        this.Password = Password;
    }

    public int getID() {
        return ID;
    }

    public String getLogin() {
        return Login;
    }

    public void setLogin(String login) {
        this.Login = login;
    }

    public String getNachname() {
        return Nachname;
    }

    public void setNachname(String nachname) {
        this.Nachname = nachname;
    }

    public String getVorname() {
        return Vorname;
    }

    public void setVorname(String vorname) {
        this.Vorname = vorname;
    }

    public String getEMail() {
        return EMail;
    }

    public boolean isAdmin() {
        return IstAdmin;
    }

    public void setAdmin(boolean isAdmin) {
        this.IstAdmin = isAdmin;
    }

    public BenutzerGruppe getGruppe() {
        return Gruppe;
    }

    public void setGruppe(BenutzerGruppe gruppe) {
        this.Gruppe = gruppe;
    }

    public String getSprache() {
        return Sprache;
    }

    public void setSprache(String sprache) {
        this.Sprache = sprache;
    }

    public boolean isGast() {
        return IstGast;
    }

    public boolean isAktiv() {
        return IstAktiv;
    }

    public void setAktiv(boolean isActive) {
        this.IstAktiv = isActive;
    }

    public boolean isReadOnly() {
        return IstReadOnly;
    }

    public void setEMail(String EMail) {
        this.EMail = EMail;
    }


}
