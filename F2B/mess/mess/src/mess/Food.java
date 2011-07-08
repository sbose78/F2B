package mess;

import java.util.Date;
import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.IdentityType;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;
import com.google.appengine.api.users.User;

@PersistenceCapable(identityType = IdentityType.APPLICATION)
public class Food {
    @PrimaryKey
    @Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
    private Long id;

    @Persistent
    private User author;

    @Persistent
    private String name;
	
	@Persistent
    private String manCode;
	
	
    @Persistent
    private String comments;
	
	
	@Persistent
	private String item;
	
	@Persistent
	private double price;

    @Persistent
    private Date date;

    public Food(User author,String comments,String item,double price ,String manCode,Date date) {
        this.author = author;
        this.comments = comments;
		this.item = item;
		this.price = price;
		this.manCode=manCode;		
        this.date = date;
		
    }
    public Long getId() {
        return id;
    }

    public User getAuthor() {
        return author;
    }


    public Date getDate() {
        return date;
    }

	
	public String getComments() {
        return  comments;
    }
	
	
	public String manCode() {
        return  manCode;
    }
	
	
	public String getItem() {
        return  item;
    }
	
	
	public double getPrice() {
        return  price;
    }
	
	
    public void setAuthor(User author) {
        this.author = author;
    }

	
	public void setComments(String comments) {
        this.comments = comments;
    }
	
		
	public void setManCode(String manCode) {
        this.manCode = manCode;
    }

	
	public void setItem(String item) {
        this.item = item;
    }
	
    public void setDate(Date date) {
        this.date = date;
    }
	public void setPrice(double price) {
        this.price = price;
    }
}
