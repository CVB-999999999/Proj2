package proj2.web;

import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class ClienteController {

    //  Adicionar Cliente
    @PostMapping("/addC")
    public String addCliente(@RequestParam String nome, @RequestParam String email, @RequestParam String telemovel, @RequestParam String endereco1,
                             @RequestParam String endereco2, @RequestParam String cidade, @RequestParam String codPostal, @RequestParam String pass) {
        cliente c = new cliente();
        c.setCodPostal(codPostal);
        c.setEmail(email);
        c.setNome(nome);
        c.setPass(pass);
        c.setTelemovel(telemovel);
        c.setEnd1(endereco1);
        c.setEnd2(endereco2);
        c.setCidade(cidade);

        c.create();

        return "Cliente adicionado com sucesso";
    }

    //  Verificar Login
    @GetMapping("findC/{id}")
    public String[] findCustomerById(@RequestParam Integer id) {
        cliente c = new cliente();
        c.read(id);

        String[] cli = new String[3];
        cli[0] = c.getNome();
        cli[1] = c.getEnd1();
        cli[2] = c.getCodPostal();

        return cli;
    }

    @GetMapping("/listC")
    public String[][] getCustomers() {
        return cliente.readAll();
    }

    @GetMapping("/teste")
    public ModelAndView getTest() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("index");
        mv.getModel().put("data", "123Teste");
        return mv;
    }

    @RequestMapping (value = "message", method = RequestMethod.GET)
    public ModelAndView messages() {
        ModelAndView mav = new ModelAndView("index");
        mav.addObject("messages", "cenas");
        return mav;
    }

    /*@RequestMapping("/")
    public ModelAndView welcome(ModelMap model) {
        model.addAttribute("teste", "Programmer Gate");
        return model;
    }*/

    @RequestMapping("/")
    public ModelAndView cenas () {
        return new ModelAndView("indeex", "books", "books");
    }
}
