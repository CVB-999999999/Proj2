package proj2.web;

import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;

@RestController
public class ClienteController extends AbstractController{

    @Override
    protected ModelAndView handleRequestInternal(
            HttpServletRequest request,HttpServletResponse response)throws Exception{
    
        String[][] books = cliente.readAll();
        //String books = "1";
        return new ModelAndView("cliente", "books", books);
    }
}
