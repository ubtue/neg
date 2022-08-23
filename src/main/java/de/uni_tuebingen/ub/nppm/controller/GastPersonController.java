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

@Controller
@RequestMapping("/gast/person")
public class GastPersonController {
    @Autowired
    private PersonService personService;

    @GetMapping("/showForm")
    public String showForm(@RequestParam("personId") int id, Model model) {
        Person person = personService.getPersonById(id);
        model.addAttribute("person", person);
        return "person/gast/person-form";
    }
}
