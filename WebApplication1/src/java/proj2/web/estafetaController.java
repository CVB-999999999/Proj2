package proj2.web;

import org.springframework.web.bind.annotation.*;

@RestController
public class estafetaController {

    //  Verificar Login estafeta
    @GetMapping("findE/{id}")
    public String[] findPEstafetaId(@RequestParam Integer id) {
        funcionario f = new funcionario();
        f.readFUNC(id);

        String[] func = new String[4];
        func[0] = String.valueOf(f.getIdFunc());
        func[1] = f.getNome();
        func[2] = f.getFuncao();
        func[3] = String.valueOf(f.getDemitido());

        return func;
    }
}