package de.uni_tuebingen.ub.nppm.controller;

import de.uni_tuebingen.ub.nppm.service.HandschriftService;
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
@RequestMapping("/handschrift")
public class HandschriftController {

    @Autowired
    private HandschriftService handschriftService;

    @GetMapping("/list")
    public String listHandschriften(Model model) {        
        List < Handschrift > handschrifts = handschriftService.listHandschriften();
        model.addAttribute("handschrifts", handschrifts);
        return "handschrift/list-handschrift";
    }

    @GetMapping("/showForm")
    public String showFormForAdd(Model model) {
        Handschrift handschrift = new Handschrift();
        model.addAttribute("handschrift", handschrift);
        return "handschrift/handschrift-form";
    }

    @PostMapping("/saveHandschrift")
    public String addHandschrift(@ModelAttribute("handschrift") Handschrift handschrift) {
        handschriftService.addHandschrift(handschrift);
        return "redirect:/handschrift/list";
    }

    @GetMapping("/updateForm")
    public String showFormForUpdate(@RequestParam("handschriftId") int id,
            Model model) {
        Handschrift handschrift = handschriftService.getHandschriftById(id);
        model.addAttribute("handschrift", handschrift);
        return "handschrift/handschrift-form";
    }

    @GetMapping("/remove")
    public String removeHandschrift(@RequestParam("handschriftId") int id) {
        handschriftService.removeHandschrift(id);
        return "redirect:/handschrift/list";
    }
}
