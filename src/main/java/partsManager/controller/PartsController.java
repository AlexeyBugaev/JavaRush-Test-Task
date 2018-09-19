package partsManager.controller;

import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import partsManager.model.Part;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import partsManager.service.PartsService;
import java.util.ArrayList;
import java.util.List;

@Controller()
public class PartsController {

    private PartsService partsService;
    private int currentPage = 1;
    private int pages =0;
    private List<Part> listPerPage = new ArrayList<Part>();
    private int readyForAssembly=0;
    private String sort="all";
    private Part partFound = null;
    private String lookFor = "";
    private boolean sortChanged = false;
    private boolean deleted = false;
    private boolean changed = false;
    private boolean showInEditMode = true;

    public String getSort() {
        return sort;
    }

    @Autowired(required = true)
    @Qualifier(value = "partsService")
    public void setPartsService(PartsService partsService) {
        this.partsService = partsService;
    }

    @RequestMapping(value = "parts", method = RequestMethod.GET)
    public String listParts(Model model){
        setPages();
        readyForAssembly = canBeAssembled();
        model.addAttribute("part", new Part());
        model.addAttribute("pages", pages);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("listParts",listPerPage);
        model.addAttribute("ready",readyForAssembly);
        model.addAttribute("sort",sort);
        model.addAttribute("lookFor",lookFor);
        model.addAttribute("partFound",partFound);
        model.addAttribute("deleted",deleted);
        model.addAttribute("changed",changed);
        model.addAttribute("showInEdit", showInEditMode);
        System.out.println("PartFound in parts = "+partFound);
        return "parts";
    }

    @RequestMapping(value = "/parts/add",method = RequestMethod.POST)
    public String addPart(@ModelAttribute ("part") Part part, BindingResult result){
        setPages();
        readyForAssembly = canBeAssembled();
        System.out.println("ID = " + part.getId());
        if(part.getId()==0){
            this.partsService.addPart(part);
        }
        else{
            if(partFound!=null) changed = true;
            this.partsService.updatePart(part);
        }
        return "redirect:/parts";
    }

    @RequestMapping(value = "/remove/{id}")
    public String removePart(@PathVariable("id") int id){
        this.partsService.removePart(id);
        if(partFound!=null) deleted = true;
        return "redirect:/parts";
    }

    @RequestMapping(value = "edit/{id}")
    public String editPart(@PathVariable("id") int id, Model model){
        setPages();
        readyForAssembly = canBeAssembled();
        showInEditMode = true;
        if(partFound!=null) showInEditMode = false;
        model.addAttribute("part",partsService.getPart(id));
        model.addAttribute("listParts",listPerPage);
        model.addAttribute("showInEdit", showInEditMode);
        System.out.println("PartFound in edit = "+partFound);
        return "parts";
    }

    @RequestMapping(value = "/parts/next", method = RequestMethod.POST)
    public String Next(){
        this.currentPage++;
        return "redirect:/parts";
    }

    @RequestMapping(value = "/parts/back", method = RequestMethod.POST)
    public String Back(){
        this.currentPage--;
        return "redirect:/parts";
    }

    @RequestMapping(value = "/parts/return", method = RequestMethod.GET)
    public String Return(){
        partFound = null;
        deleted = false;
        changed = false;
        showInEditMode = true;
        return "redirect:/parts";
    }

    @RequestMapping(value = "/parts/sort", method = RequestMethod.POST)
    public String Sort(@ModelAttribute("sort") String sort){
        this.sort=sort;
        sortChanged = true;
        return "redirect:/parts";
    }

    @RequestMapping(value = "parts/partData", method = RequestMethod.GET)
    public String partData(@ModelAttribute("lookFor") Part part) {
        String name = part.getName();
        if(name!=""){
            for (Part partLookFor: partsService.listParts()) {
                if(partLookFor.getName().equals(name)) partFound = partLookFor;
            }
        }
        return "redirect:/parts";
    }
    private void setPages(){
        List<Part> listAllParts = partsService.listParts();
        List<Part> listShownParts = new ArrayList<Part>();
        if(partFound!=null){
            pages = 1;
            currentPage = 1;
            listShownParts.clear();
            listShownParts.add(partFound);
        }
        else if(sort.equals("all")) listShownParts=listAllParts;
        else if(sort.equals("required")){
            listShownParts.clear();
            for (Part part : listAllParts) {
                if(part.isNeed()) listShownParts.add(part);
            }
            if(sortChanged){
                currentPage = 1;
                sortChanged = false;
            }
        }
        else if(sort.equals("optional")){
            listShownParts.clear();
            for (Part part : listAllParts) {
                if(!part.isNeed()) listShownParts.add(part);
            }
            if(sortChanged){
                currentPage = 1;
                sortChanged = false;
            }
        }
        if(partFound==null) pages = listShownParts.size()%10==0 ? listShownParts.size()/10 : listShownParts.size()/10+1;
        listPerPage = listShownParts.subList((currentPage-1)*10,(currentPage)*10<listShownParts.size() ? (currentPage)*10 : listShownParts.size());
    }

    private int canBeAssembled(){
        List<Part> list = partsService.listParts();
        List<Part> listOfNeededParts = new ArrayList<Part>();
        for (Part part : list) {
           if(part.isNeed()) listOfNeededParts.add(part);
        }
        int amount = listOfNeededParts.get(0).getQuantity();
        for (Part part : listOfNeededParts) {
            if(amount>part.getQuantity()) amount = part.getQuantity();
        }
        return amount;
    }
}
