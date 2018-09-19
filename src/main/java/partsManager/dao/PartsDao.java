package partsManager.dao;

import partsManager.model.Part;

import java.util.List;

public interface PartsDao {
    public void addPart(Part part);
    public void updatePart(Part part);
    public void removePart(int id);
    public Part getPart(int id);
    public List<Part> listParts();
}
