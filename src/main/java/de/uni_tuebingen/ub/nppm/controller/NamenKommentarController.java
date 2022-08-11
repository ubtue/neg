package de.uni_tuebingen.ub.nppm.controller;

import de.uni_tuebingen.ub.nppm.service.NamenKommentarService;
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
@RequestMapping("/namenkommentar")
public class NamenKommentarController {

    @Autowired
    private NamenKommentarService namenkommentarService;

    @GetMapping("/showForm")
    public String showFormForAdd(Model model) {
        NamenKommentar namenkommentar = new NamenKommentar();
        model.addAttribute("namenkommentar", namenkommentar);
        return "namenkommentar/namenkommentar-form";
    }

    @PostMapping("/saveNamenKommentar")
    public String addNamenKommentar(@ModelAttribute("namenkommentar") NamenKommentar namenkommentar) {
        namenkommentarService.addNamenKommentar(namenkommentar);
        return "redirect:/namenkommentar/list";
    }

    @GetMapping("/updateForm")
    public String showFormForUpdate(@RequestParam("namenkommentarId") int id,
            Model model) {
        NamenKommentar namenkommentar = namenkommentarService.getNamenKommentarById(id);
        model.addAttribute("namenkommentar", namenkommentar);
        return "namenkommentar/namenkommentar-form";
    }

    @GetMapping("/remove")
    public String removeNamenKommentar(@RequestParam("namenkommentarId") int id) {
        namenkommentarService.removeNamenKommentar(id);
        return "redirect:/namenkommentar/list";
    }
}
