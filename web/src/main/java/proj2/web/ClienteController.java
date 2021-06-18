package proj2.web;

import org.springframework.web.bind.annotation.*;

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
}
