package de.uni_tuebingen.ub.nppm.controller;

import de.uni_tuebingen.ub.nppm.service.MghLemmaService;
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
@RequestMapping("/gast/mghlemma")
public class GastMghLemmaController {

    @Autowired
    private MghLemmaService mghlemmaService;

    @GetMapping("/showForm")
    public String showForm(@RequestParam("mghlemmaId") int id,
            Model model) {
        MghLemma mghlemma = mghlemmaService.getMghLemmaById(id);
        model.addAttribute("mghlemma", mghlemma);
        return "mghlemma/gast/mghlemma-form";
    }
}
