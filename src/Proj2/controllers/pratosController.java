package Proj2.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
//@RequestMapping("/index")
public class pratosController extends AbstractController {
    public pratosController() {

    }

    @RequestMapping("/index")
    public ModelAndView someAction() {

        String mymsg = "Saying hi!";
        System.out.println(mymsg);
        return new ModelAndView("index", "message", mymsg);
    }


    @Override
    protected ModelAndView handleRequestInternal(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String modelInstance ="Olá Mundo!!!";
        return new ModelAndView("index", "joao", modelInstance);
    }
    /*@GetMapping("/")
    public String index(Model m) {
        m.addAttribute("joao", "Hello World");
        return "index";
    }*/

}
