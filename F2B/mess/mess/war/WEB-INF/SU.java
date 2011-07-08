package guestbook;
import javax.servlet.*;
import javax.servlet.http.*;
public class SU 
{
	public static final String DOCTYPE =
	"<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 " +"Transitional//EN\">";
	public static String headWithTitle(String title) {return(DOCTYPE + "\n" +"<HTML>\n" +"<HEAD><TITLE>" + title + "</TITLE></HEAD>\n");}
}