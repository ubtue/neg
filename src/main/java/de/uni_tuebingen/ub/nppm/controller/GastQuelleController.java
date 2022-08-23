package de.uni_tuebingen.ub.nppm.controller;

import de.uni_tuebingen.ub.nppm.service.QuelleService;
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
@RequestMapping("/gast/quelle")
public class GastQuelleController {

    @Autowired
    private QuelleService quelleService;

    @GetMapping("/showForm")
    public String showForm(@RequestParam("quelleId") int id,
            Model model) {
        Quelle quelle = quelleService.getQuelleById(id);
        model.addAttribute("quelle", quelle);
        return "quelle/gast/quelle-form";
    }
}
