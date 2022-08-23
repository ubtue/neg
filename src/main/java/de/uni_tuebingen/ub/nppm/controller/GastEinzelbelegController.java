package de.uni_tuebingen.ub.nppm.controller;

import de.uni_tuebingen.ub.nppm.service.PersonService;
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
import de.uni_tuebingen.ub.nppm.service.EinzelbelegService;

@Controller
@RequestMapping("/gast/einzelbeleg")
public class GastEinzelbelegController {

    @Autowired
    private EinzelbelegService einzelbelegService;

    @GetMapping("/showForm")
    public String showForm(@RequestParam("einzelbelegId") int id,
            Model model) {
        Einzelbeleg einzelbeleg = einzelbelegService.getEinzelbelegById(id);
        model.addAttribute("einzelbeleg", einzelbeleg);
        return "einzelbeleg/gast/einzelbeleg-form";
    }
}
