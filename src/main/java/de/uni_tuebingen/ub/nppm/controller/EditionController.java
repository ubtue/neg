package de.uni_tuebingen.ub.nppm.controller;

import de.uni_tuebingen.ub.nppm.service.EditionService;
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
@RequestMapping("/edition")
public class EditionController {

    @Autowired
    private EditionService editionService;

    @GetMapping("/list")
    public String listEditions(Model theModel) {
        //TODO Clean up Edition Table
        /*List < Edition > editions = editionService.listEditions();

        theModel.addAttribute("editions", editions);*/

        return "list-edition";
    }
}