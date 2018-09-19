package partsManager.dao;

import partsManager.model.Part;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class PartsDaoImpl implements PartsDao{

    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
        System.out.println("factory session "+this.sessionFactory.toString()+" created");
    }

    public void addPart(Part part) {
        Session session = sessionFactory.getCurrentSession();
        session.persist(part);
    }

    public void updatePart(Part part) {
        Session session = sessionFactory.getCurrentSession();
        session.update(part);
    }

    public void removePart(int id) {
        Session session = sessionFactory.getCurrentSession();
        Part part = getPart(id);
        if(part!=null)
        session.delete(part);
    }

    public Part getPart(int id) {
        Part part;
        Session session = sessionFactory.getCurrentSession();
        part = (Part)session.get(Part.class, id);
        return part;
    }
@SuppressWarnings("unchecked")
    public List<Part> listParts(){
        Session session = sessionFactory.getCurrentSession();
        List<Part> partsList = session.createQuery("select c from Part c").list();
        return partsList;
    }
}
