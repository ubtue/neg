package de.uni_tuebingen.ub.nppm.controller;

import de.uni_tuebingen.ub.nppm.service.SucheService;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import de.uni_tuebingen.ub.nppm.model.*;

@Controller
@RequestMapping("/suche")
public class SucheController {

    @GetMapping("/showForm")
    public String showForm() {
        return "suche/suche-form";
    }
    
    @GetMapping("/showFormAdvanced")
    public String showFormAdvanced() {
        return "suche/freie-suche-form";
    }
    
    @GetMapping("/gast/showFormAdvanced")
    public String showFormAdvancedGast() {
        return "suche/gast/erweiterte-suche-form";
    }
}
