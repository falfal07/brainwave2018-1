import twitter4j.*;
import twitter4j.util.*;
import twitter4j.util.function.*;
import twitter4j.auth.*;
import twitter4j.management.*;
import twitter4j.json.*;
import twitter4j.api.*;
import twitter4j.conf.*;
import java.util.*;

class Tweet{
  //
   
  Twitter twitter;
  List<Status> statuses = null;
   
  void setup(){
      ConfigurationBuilder cb = new ConfigurationBuilder();
      cb.setOAuthConsumerKey(consumerKey);
      cb.setOAuthConsumerSecret(consumerSecret);
      cb.setOAuthAccessToken(accessToken);
      cb.setOAuthAccessTokenSecret(accessTokenSecret);
       
      twitter = new TwitterFactory(cb.build()).getInstance();
       
      try{
        Status status = twitter.updateStatus("test");
      }catch(TwitterException e){
        println("Get timeline:" + e + "Status code:" + e.getStatusCode());
      }
  }
}
