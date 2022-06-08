package proj2.web;

import org.springframework.web.bind.annotation.*;

@RestController
public class pratoController {

    //  Listar todos os pratos
    @GetMapping("/listP")
    public String[][] getPratos() {
        return menu.readAll();
    }

    //  Procurar Prato Especifico   //  Falta adicionar o preco     //
    @GetMapping("findP/{id}")
    public String[] findPratoById(@RequestParam Integer id) {

        menu m = new menu();

        m.read(id);

        String[] menu = new String[2];
        menu[0] = m.getNome();
        menu[1] = m.getDescricao();

        return menu;
    }
}