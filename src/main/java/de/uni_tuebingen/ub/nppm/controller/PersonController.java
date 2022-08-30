package de.uni_tuebingen.ub.nppm.controller;

import de.uni_tuebingen.ub.nppm.service.PersonService;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.*;
import org.springframework.web.servlet.ModelAndView;
import de.uni_tuebingen.ub.nppm.model.*;
import org.springframework.web.bind.annotation.*;
import org.apache.log4j.Logger;

@Controller
@RequestMapping("/person")
public class PersonController {

    private static final Logger logger = Logger.getLogger(PersonController.class);
    
    @Autowired
    private PersonService personService;

    @GetMapping("/showForm")
    public String showForm(@RequestParam("personId") int id, Model model) {
        Person person = null;
        if(id == -1){
            person = new Person();
        }else{
            person = personService.getPersonById(id);
            model.addAttribute("person", person);
        }
        model.addAttribute("person", person);
        logger.error("test");
        return "person/person-form";
    }

    @PostMapping("/savePerson")
    public String addPerson(@ModelAttribute("person") Person person) {
        if(person.getId() == null){
            personService.addPerson(person);
        }else{
            personService.updatePerson(person);            
        }
        return "redirect:/person/updateForm";
    }

    @GetMapping("/remove")
    public String removePerson(@RequestParam("personId") int id) {
        personService.removePerson(id);
        return "redirect:/person/showForm";
    }
}
