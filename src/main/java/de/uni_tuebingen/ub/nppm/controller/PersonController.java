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
@RequestMapping("/person")
public class PersonController {

    @Autowired
    private PersonService personService;

    @GetMapping("/gast/showForm")
    public String showFormForGast(@RequestParam("personId") int id, Model model) {
        Person person = personService.getPersonById(id);
        model.addAttribute("person", person);
        return "person/gast/person-form";
    }

    @GetMapping("/showForm")
    public String showFormForAdd(Model model) {
        Person person = new Person();
        model.addAttribute("person", person);
        return "person/person-form";
    }

    @PostMapping("/savePerson")
    public String addPerson(@ModelAttribute("person") Person person) {
        personService.addPerson(person);
        return "redirect:/person/showForm";
    }

    @GetMapping("/updateForm")
    public String showFormForUpdate(@RequestParam("personId") int id,
            Model model) {
        Person person = personService.getPersonById(id);
        model.addAttribute("person", person);
        return "person/person-form";
    }

    @GetMapping("/remove")
    public String removePerson(@RequestParam("personId") int id) {
        personService.removePerson(id);
        return "redirect:/person/showForm";
    }
}
