package de.uni_tuebingen.ub.nppm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/gast")
public class GastController {
    
    @GetMapping("/startseite")
    public String startseite(Model model) {
        return "startseite/gast/index";
    }
}
