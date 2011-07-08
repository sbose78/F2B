
package sbose78;

import com.google.gdata.client.GoogleService;
import com.google.gdata.client.authn.oauth.*;
import com.google.gdata.data.*;
import com.google.gdata.util.*;

import java.io.*;
import java.net.*;
import java.util.Date;




import com.google.gdata.client.Query;
import com.google.gdata.client.blogger.BloggerService;
import com.google.gdata.util.ServiceException;


public class MyBlog
{
	
	private BloggerService bloggerService;
	private URL feedUrl;
	private static final String METAFEED_URL ="http://www.blogger.com/feeds/default/blogs";
	
	private static final String FEED_URI_BASE = "http://www.blogger.com/feeds";
	private static final String POSTS_FEED_URI_SUFFIX = "/posts/default";
	private static final String COMMENTS_FEED_URI_SUFFIX = "/comments/default";
	
	private String feedUri;


	public MyBlog(GoogleOAuthParameters oauthParameters,OAuthSigner signer)
	{	
		try{
			bloggerService =   new BloggerService("sbose78");
		

	 	    // Set the OAuth credentials 

			 bloggerService.setOAuthCredentials(oauthParameters, signer);
			 feedUrl = new URL(METAFEED_URL);
		}
		catch(Exception e)
		{


		}
		
	}


	public String[] printUserBlogs()throws ServiceException,AuthenticationException
	{
	   String s[]=new String[1];
	

	    // Request the feed

	    try{
		   Feed resultFeed = bloggerService.getFeed(feedUrl, Feed.class);
		   s=new String[resultFeed.getEntries().size()];		    
		  for (int i = 0; i < resultFeed.getEntries().size(); i++) 
	    	  {	
      			Entry entry = resultFeed.getEntries().get(i);
   	        	s[i]="\t" + entry.getTitle().getPlainText();
	    	  }	
	    
	    }	
	    catch(AuthenticationException e)
	    {	s=new String[1];
		s[0]="\n\n\nCOULD NOT RETRIEVE.. NOT AUTHENTICATED\n\n\n ";
//		e.printStackTrace();
		return s;

	    }
	   catch(Exception e){
			s=new String[1];
			s[0]="\n\n\nCOULD NOT RETRIEVE..!!\n\n\n ";

			return s;
	   }	
	    
	   return s;
	}	
	
	private String getBlogId()  throws ServiceException, IOException {
	    // Get the metafeed
//	    final URL feedUrl = new URL(METAFEED_URL);
	    Feed resultFeed = bloggerService.getFeed(feedUrl, Feed.class);

	    // If the user has a blog then return the id (which comes after 'blog-')
	    if (resultFeed.getEntries().size() > 0) {
		 Entry entry = resultFeed.getEntries().get(0);
		 return entry.getId().split("blog-")[1];
	    }
	    return "NOTFOUND";  
	}
	
	public String insertPost(String title, String content , String authorName, String userName, Boolean isDraft)throws ServiceException, IOException 
	{
	
		
	    String blogId = getBlogId();
	  if(!blogId.equals("NOTFOUND") ){
	    feedUri = FEED_URI_BASE + "/" + blogId;
		 
	    try{		 
		 
		 // Create the entry to insert
    		Entry myEntry = new Entry();
		myEntry.setTitle(new PlainTextConstruct(title));
		myEntry.setContent(new PlainTextConstruct(content));
		Person author = new Person(authorName, null, userName);
		myEntry.getAuthors().add(author);
		myEntry.setDraft(isDraft);


    // Ask the service to insert the new entry
		URL postUrl = new URL(feedUri + POSTS_FEED_URI_SUFFIX);
		bloggerService.insert(postUrl, myEntry);
		
		return "inserted";
		
	    }	
	    catch(Exception e){ return e.toString();
	    }
	  }
	  else{
	  	return "COULDNT RETRIEVE BLOGS FOR INSERTION";  

           }
	}
	
	
	
	public Entry insertPost_entry(String title, String content , String authorName, String userName, Boolean isDraft)throws ServiceException, IOException 
	{
	 
	    Entry blank =new Entry();
		
	    String blogId = getBlogId();
	  if(!blogId.equals("NOTFOUND") ){
	    feedUri = FEED_URI_BASE + "/" + blogId;
		 
	    try{		 
		 
		 // Create the entry to insert
    		Entry myEntry = new Entry();
		myEntry.setTitle(new PlainTextConstruct(title));
		myEntry.setContent(new PlainTextConstruct(content));
		Person author = new Person(authorName, null, userName);
		myEntry.getAuthors().add(author);
		myEntry.setDraft(isDraft);


    // Ask the service to insert the new entry
		URL postUrl = new URL(feedUri + POSTS_FEED_URI_SUFFIX);
		
		
		return bloggerService.insert(postUrl, myEntry);
		
	    }	
	    catch(Exception e){ return blank;
	    }
	  }
	  else{
	  	return blank;  

           }
	}
	
	
	
	/****** CREATE COMMENT ***/
	
	 public Entry createComment(String postId,String commentText) throws ServiceException, IOException 
	 {

	    	    String blogId = getBlogId();
    	    feedUri = FEED_URI_BASE + "/" + blogId;
	    
	    // Build the comment feed URI
	    String commentsFeedUri = feedUri + "/" + postId + COMMENTS_FEED_URI_SUFFIX;
	    URL feedUrl = new URL(commentsFeedUri);

	    // Create a new entry for the comment and submit it to the GoogleService
	    Entry myEntry = new Entry();
	    myEntry.setContent(new PlainTextConstruct(commentText));
	    return bloggerService.insert(feedUrl, myEntry);
  	}
	
	
	
	/*******  *********************/
	
	
	
	
}




/*
 public static Entry createPost(BloggerService myService, String title,
      String content, String authorName, String userName, Boolean isDraft)
      throws ServiceException, IOException {
    // Create the entry to insert
    Entry myEntry = new Entry();
    myEntry.setTitle(new PlainTextConstruct(title));
    myEntry.setContent(new PlainTextConstruct(content));
    Person author = new Person(authorName, null, userName);
    myEntry.getAuthors().add(author);
    myEntry.setDraft(isDraft);

    // Ask the service to insert the new entry
    URL postUrl = new URL(feedUri + POSTS_FEED_URI_SUFFIX);
    return myService.insert(postUrl, myEntry);
  }
*/
