package mess;

import java.util.Date;
import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.IdentityType;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;
import com.google.appengine.api.users.User;

@PersistenceCapable(identityType = IdentityType.APPLICATION)
public class Manager {
    @PrimaryKey
    @Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
    private Long id;

    @Persistent
    private User author;
	
    @Persistent
    private String man3;
	
	
    @Persistent
    private String man2;
	
	
	@Persistent
	private String man1;
	
	
	@Persistent
	private double exp;

    @Persistent
    private Date date;

    public Manager(User author,String man1,String man2,String man3,double exp ,Date date) {
        this.author = author;
		
		this.man1=man1;
		this.man2=man2;
		this.man3=man3;
		this.date = date;
		this.exp=exp;
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

	public String getMan1() {
        return  man1;
    }
    
	
	public String getMan2() {
        return  man2;
    }
    
	
	public String getMan3() {
        return  man3;
    }

	public double getExp(){
		return exp;
	}
	
	public void setExp(){
		this.exp= exp;
	}
	
    public void setMan1(String man1){
		this.man1=man1;
	}		

	
    public void setMan2(String man2){
		this.man2=man2;
	}		
		
    
    public void setMan3(String man3){
		this.man3=man3;
	}		
				
		
    public void setAuthor(User author) {
        this.author = author;
    }
	
    public void setDate(Date date) {
        this.date=date;
    }

	
}
