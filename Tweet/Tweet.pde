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
  String consumerKey = "FGUeIDShwT27DlQys5wt4WZeg";
  String consumerSecret = "q0PkewxReTPWNh5GAqe85GCxg3bxOoVWLURA18NZOkqga2R6TF";
  String accessToken = "714992711489589248-wIKBMstixNoVxsjUqqy4YZhTNa7N81B";
  String accessTokenSecret = "vAiyMV9D8hhJv3rbQQYhHz0x21oak58qw7CTcOUdI5sV9";
   
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
