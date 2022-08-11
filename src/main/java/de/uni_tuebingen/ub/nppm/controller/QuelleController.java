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
@RequestMapping("/quelle")
public class QuelleController {

    @Autowired
    private QuelleService quelleService;

    @GetMapping("/gast/showForm")
    public String showFormForUpdateGast(@RequestParam("quelleId") int id,
            Model model) {
        Quelle quelle = quelleService.getQuelleById(id);
        model.addAttribute("quelle", quelle);
        return "quelle/gast/quelle-form";
    }

    @GetMapping("/showForm")
    public String showFormForAdd(Model model) {
        Quelle quelle = new Quelle();
        model.addAttribute("quelle", quelle);
        return "quelle/quelle-form";
    }

    @PostMapping("/saveQuelle")
    public String addQuelle(@ModelAttribute("quelle") Quelle quelle) {
        quelleService.addQuelle(quelle);
        return "redirect:/quelle/list";
    }

    @GetMapping("/updateForm")
    public String showFormForUpdate(@RequestParam("quelleId") int id,
            Model model) {
        Quelle quelle = quelleService.getQuelleById(id);
        model.addAttribute("quelle", quelle);
        return "quelle/quelle-form";
    }

    @GetMapping("/remove")
    public String removeQuelle(@RequestParam("quelleId") int id) {
        quelleService.removeQuelle(id);
        return "redirect:/quelle/list";
    }
}
