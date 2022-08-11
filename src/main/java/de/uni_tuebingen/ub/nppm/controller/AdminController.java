package de.uni_tuebingen.ub.nppm.controller;

import de.uni_tuebingen.ub.nppm.service.*;
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
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private BenutzerService benutzerService;
    
    @Autowired
    private DatenbankService datenbankService;

    @GetMapping("/editHelp")
    public String showFormForUpdateHelp() {
        return "help/edit";
    }

    @GetMapping("/administration")
    public String showFormForAdministration() {
        return "admin/administration";
    }
    
    @GetMapping("/settings")
    public String showFormForSettings() {
        return "settings/settings";
    }
    
    @GetMapping("/openRelations")
    public String showFormForOpenRelations() {
        return "open_relations/open-relations";
    }
    
    @GetMapping("/changeLanguage")
    public String changeLanguage() {
        return "redirect:/einzelbeleg/list";
    }
    
    @GetMapping("/logout")
    public String logout() {
        return "redirect:/einzelbeleg/list";
    }
}
