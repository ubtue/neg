package de.uni_tuebingen.ub.nppm.controller;

import de.uni_tuebingen.ub.nppm.service.EinzelbelegService;
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
@RequestMapping("/einzelbeleg")
public class EinzelbelegController {

    @Autowired
    private EinzelbelegService einzelbelegService;

    @GetMapping("/showForm")
    public String showFormForAdd(Model model) {
        Einzelbeleg einzelbeleg = new Einzelbeleg();
        model.addAttribute("einzelbeleg", einzelbeleg);
        return "einzelbeleg/einzelbeleg-form";
    }

    @PostMapping("/saveEinzelbeleg")
    public String addEinzelbeleg(@ModelAttribute("einzelbeleg") Einzelbeleg einzelbeleg) {
        einzelbelegService.addEinzelbeleg(einzelbeleg);
        return "redirect:/einzelbeleg/showForm";
    }

    @GetMapping("/updateForm")
    public String showFormForUpdate(@RequestParam("einzelbelegId") int id,
            Model model) {
        Einzelbeleg einzelbeleg = einzelbelegService.getEinzelbelegById(id);
        model.addAttribute("einzelbeleg", einzelbeleg);
        return "einzelbeleg/einzelbeleg-form";
    }

    @GetMapping("/remove")
    public String removeEinzelbeleg(@RequestParam("einzelbelegId") int id) {
        einzelbelegService.removeEinzelbeleg(id);
        return "redirect:/einzelbeleg/showForm";
    }
}
