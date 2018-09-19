package partsManager.service;

import partsManager.dao.PartsDao;
import partsManager.model.Part;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class PartsServiceImpl implements PartsService {
    private PartsDao partsDao;

    public void setPartsDao(PartsDao partsDao) {
        this.partsDao = partsDao;
        System.out.println("partsDao " + this.partsDao.toString() + "initialized");
    }

    @Transactional
    public void addPart(Part part) {
        this.partsDao.addPart(part);
    }

    @Transactional
    public void updatePart(Part part) {
        this.partsDao.updatePart(part);
    }

    @Transactional
    public void removePart(int id) {
        this.partsDao.removePart(id);
    }

    @Transactional
    public Part getPart(int id) {
        return this.partsDao.getPart(id);
    }

    @Transactional
    public List<Part> listParts() {
        return this.partsDao.listParts();
    }
}
