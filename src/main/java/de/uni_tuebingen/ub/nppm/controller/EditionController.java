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

    @GetMapping("/showForm")
    public String showFormForAdd(Model model) {
        Edition edition = new Edition();
        model.addAttribute("edition", edition);
        return "edition/edition-form";
    }

    @PostMapping("/saveEdition")
    public String addEdition(@ModelAttribute("edition") Edition edition) {
        editionService.addEdition(edition);
        return "redirect:/edition/list";
    }

    @GetMapping("/updateForm")
    public String showFormForUpdate(@RequestParam("editionId") int id,
            Model model) {
        Edition edition = editionService.getEditionById(id);
        model.addAttribute("edition", edition);
        return "edition/edition-form";
    }

    @GetMapping("/remove")
    public String removeEdition(@RequestParam("editionId") int id) {
        editionService.removeEdition(id);
        return "redirect:/edition/list";
    }
}
