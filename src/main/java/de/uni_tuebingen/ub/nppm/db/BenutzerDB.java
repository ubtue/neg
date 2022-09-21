package de.uni_tuebingen.ub.nppm.db;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;

import de.uni_tuebingen.ub.nppm.model.Benutzer;

public interface BenutzerDB extends JpaRepository<Benutzer, Integer> {
    @Query("SELECT b FROM Benutzer b WHERE b.EMail = :EMail")
    public Benutzer findByEmail(@Param("EMail") String EMail);
}
