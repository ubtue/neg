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
@RequestMapping("/mghlemma")
public class MghLemmaController {

    @Autowired
    private MghLemmaService mghlemmaService;

    @GetMapping("/showForm")
    public String showFormForAdd(Model model) {
        MghLemma mghlemma = new MghLemma();
        model.addAttribute("mghlemma", mghlemma);
        return "mghlemma/mghlemma-form";
    }

    @PostMapping("/saveMghLemma")
    public String addMghLemma(@ModelAttribute("mghlemma") MghLemma mghlemma) {
        mghlemmaService.addMghLemma(mghlemma);
        return "redirect:/mghlemma/list";
    }

    @GetMapping("/updateForm")
    public String showFormForUpdate(@RequestParam("mghlemmaId") int id,
            Model model) {
        MghLemma mghlemma = mghlemmaService.getMghLemmaById(id);
        model.addAttribute("mghlemma", mghlemma);
        return "mghlemma/mghlemma-form";
    }

    @GetMapping("/remove")
    public String removeMghLemma(@RequestParam("mghlemmaId") int id) {
        mghlemmaService.removeMghLemma(id);
        return "redirect:/mghlemma/list";
    }
}
