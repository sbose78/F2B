/* Copyright (c) 2008 Google Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


package sbose78;

import com.google.gdata.client.Query;
import com.google.gdata.client.blogger.BloggerService;
import com.google.gdata.data.DateTime;
import com.google.gdata.data.Entry;
import com.google.gdata.data.Feed;
import com.google.gdata.data.Person;
import com.google.gdata.data.PlainTextConstruct;
import com.google.gdata.data.TextContent;
import com.google.gdata.util.ServiceException;

import java.io.IOException;
import java.util.*;
import java.net.URL;

/**
 * Demonstrates how to use the Google Data API's Java client library to
 * interface with the Blogger service. There are examples for the following
 * operations:
 * 
 * <ol>
 * <li>Retrieving the list of all the user's blogs</li>
 * <li>Retrieving all posts on a single blog</li>
 * <li>Performing a date-range query for posts on a blog</li>
 * <li>Creating draft posts and publishing posts</li>
 * <li>Updating posts</li>
 * <li>Retrieving comments</li>
 * <li>Deleting posts</li>
 * </ol>
 * 
 * 
 */
public class BloggerClient {

  private static final String METAFEED_URL = 
      "http://www.blogger.com/feeds/default/blogs";
 

  private static String post_topic="hello topic" ;
  private static String post_content="hello post";
	  
  private static final String FEED_URI_BASE = "http://www.blogger.com/feeds";
  private static final String POSTS_FEED_URI_SUFFIX = "/posts/default";
  private static final String COMMENTS_FEED_URI_SUFFIX = "/comments/default";

  private static String feedUri;

  /**
   * Utility classes should not have a public or default constructor.
   */
  private BloggerClient() {
    // do nothing
  }

  /**
   * Parses the metafeed to get the blog ID for the authenticated user's default
   * blog.
   * 
   * @param myService An authenticated GoogleService object.
   * @return A String representation of the blog's ID.
   * @throws ServiceException If the service is unable to handle the request.
   * @throws IOException If the URL is malformed.
   */
  private static String getBlogId(BloggerService myService)
      throws ServiceException, IOException {
    // Get the metafeed
    final URL feedUrl = new URL(METAFEED_URL);
    Feed resultFeed = myService.getFeed(feedUrl, Feed.class);

    // If the user has a blog then return the id (which comes after 'blog-')
    if (resultFeed.getEntries().size() > 0) {
      Entry entry = resultFeed.getEntries().get(0);
      return entry.getId().split("blog-")[1];
    }
    throw new IOException("User has no blogs!");
  }

  
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

  
  /**
   * Updates the title of the given post. The Entry object is updated with the
   * new title, then a request is sent to the GoogleService. If the insertion is
   * successful, the updated post will be returned.
   * 
   * Note that other characteristics of the post can also be modified by
   * updating the values of the entry object before submitting the request.
   * 
   * @param myService An authenticated GoogleService object.
   * @param entryToUpdate An Entry containing the post to update.
   * @param newTitle Text to use for the post's new title.
   * @return An Entry containing the newly-updated post.
   * @throws ServiceException If the service is unable to handle the request.
   * @throws IOException If the URL is malformed.
   */
  public static Entry updatePostTitle(BloggerService myService,
      Entry entryToUpdate, String newTitle) throws ServiceException,
      IOException {
    entryToUpdate.setTitle(new PlainTextConstruct(newTitle));
    URL editUrl = new URL(entryToUpdate.getEditLink().getHref());
    return myService.update(editUrl, entryToUpdate);
  }

  /**
   * Adds a comment to the specified post. First the comment feed's URI is built
   * using the given post ID. Then an Entry is created for the comment and
   * submitted to the GoogleService.
   * 
   * NOTE: This functionality is not officially supported yet.
   * 
   * @param myService An authenticated GoogleService object.
   * @param postId The ID of the post to comment on.
   * @param commentText Text to store in the comment.
   * @return An entry containing the newly-created comment.
   * @throws ServiceException If the service is unable to handle the request.
   * @throws IOException If the URL is malformed.
   */
  public static Entry createComment(BloggerService myService, String postId,
      String commentText) throws ServiceException, IOException {
    // Build the comment feed URI
    String commentsFeedUri = feedUri + "/" + postId + COMMENTS_FEED_URI_SUFFIX;
    URL feedUrl = new URL(commentsFeedUri);

    // Create a new entry for the comment and submit it to the GoogleService
    Entry myEntry = new Entry();
    myEntry.setContent(new PlainTextConstruct(commentText));
    return myService.insert(feedUrl, myEntry);
  }

  
  public static void run(BloggerService myService, String userName,
      String userPassword) throws ServiceException, IOException {
    // Authenticate using ClientLogin
    myService.setUserCredentials(userName, userPassword);

    // Get the blog ID from the metatfeed.
    String blogId = getBlogId(myService);
    feedUri = FEED_URI_BASE + "/" + blogId;

    // Demonstrate retrieving a list of the user's blogs.
  //  printUserBlogs(myService);

    // Demonstrate how to create a draft post.
    //Entry draftPost = createPost(myService, post_topic , post_content,true);
	
	/*"Snorkling in Aruba",
        "<p>We had so much fun snorkling in Aruba<p>", "Post author", userName,
        true);
		*/
		
    //System.out.println("Successfully created draft post: "     + draftPost.getTitle().getPlainText());

    // Demonstrate how to publish a public post.
    Entry publicPost = createPost(myService,post_topic,post_content,
							"Post author", userName, false);
   // System.out.println("Successfully created public post: "      + publicPost.getTitle().getPlainText());

    // Demonstrate various feed queries.
  //  printAllPosts(myService);
  //  printDateRangeQueryResults(myService, DateTime.parseDate("2007-04-04"),     DateTime.parseDate("2007-04-06"));

    // Demonstrate two ways of updating posts.
   // draftPost.setTitle(new PlainTextConstruct("Swimming with the fish"));
   // draftPost.update();
    //publicPost = updatePostTitle(myService, publicPost, "The party's over");
    //System.out.println("Post's new title is \""      + publicPost.getTitle().getPlainText() + "\".\n");

    // Demonstrate how to add a comment on a post
    // Get the post ID and build the comments feed URI for the specified post
   // System.out.println("Creating comment");
    String selfLinkHref = publicPost.getSelfLink().getHref();
    String[] tokens = selfLinkHref.split("/");
    String postId = tokens[tokens.length - 1];
    Entry comment = createComment(myService, postId, "Did you see any sharks?");

    // Demonstrate how to retrieve the comments for a post
//    printAllComments(myService, postId);

    // Demonstrate how to delete a comment from a post
    // System.out.println("Deleting comment");
  //  deleteComment(myService, comment.getEditLink().getHref());

    // Demonstrate two ways of deleting posts.
    //System.out.println("Deleting draft post");
  //  draftPost.delete();
    //System.out.println("Deleting published post");
   // deletePost(myService, publicPost.getEditLink().getHref());
  }

  /**
   * Uses the command line arguments to authenticate the GoogleService and build
   * the basic feed URI, then invokes all the other methods to demonstrate how
   * to interface with the Blogger service.
   * 
   * @param args See the usage method.
   */
  public static void main(String ptopic, String pcontent) {

    // Set username, password and feed URI from command-line arguments.
    //SimpleCommandLineParser parser = new SimpleCommandLineParser(args);
    String userName = "sbose78";//parser.getValue("username", "user", "u");
    String userPassword = "ECDW=19YRS";//parser.getValue("password", "pass", "p");
    //boolean help = parser.containsKey("help", "h");
	
	post_topic=ptopic;
	post_content=pcontent;
   

    BloggerService myService = new BloggerService("sbose78");

    try {
      run(myService, userName, userPassword);
    } catch (ServiceException se) {
      se.printStackTrace();
    } catch (IOException ioe) {
      ioe.printStackTrace();
    }
  }

  /**
   * Prints the command line usage of this sample application.
   */
  private static void usage() {
    System.out.println("Usage: BloggerClient --username <username>"
        + " --password <password>");
    System.out.println("\nA simple application that creates, queries,\n"
        + "updates and deletes posts and comments on the\n"
        + "specified blog using the provided username and\n"
        + "password for authentication.");
  }
}
