package partsManager.model;

import javax.persistence.*;

@Entity
@Table(name = "parts")
public class Part {
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "name")
    private String name;

    @Column(name = "need")
    private boolean need;

    @Column(name = "quantity")
    private int quantity;

    public Part() {
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setNeed(boolean need) {
        this.need = need;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public boolean isNeed() {
        return need;
    }

    public int getQuantity() {
        return quantity;
    }

    @Override
    public String toString() {
        return "Part{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", need='" + need + '\'' +
                ", quantity=" + quantity +
                '}';
    }
}
