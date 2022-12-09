import 'package:flutter/material.dart';

class WPConfig {
  /// The Name of your app
  static const String appName = 'NewsPro';

  /// The url of your app, should not inclued any '/' slash or any 'https://' or 'http://'
  /// Otherwise it may break the compaitbility, And your website must be
  /// a wordpress website.
  static const String url = 'awakenedwayapp.suzannegiesemann.com';

  /// Primary Color of the App, must be a valid hex code after '0xFF'
  static const Color primaryColor = Color(0xff006199);

  /// Used for redirecting users to privacy policy page on your website
  static const String privacyPolicyUrl =
      'https://awakenedwayapp.suzannegiesemann.com/privacy-policy/';

  /// Used for redirecting users to privacy terms & services on your website
  static const String termsAndServicesUrl =
      'https://awakenedwayapp.suzannegiesemann.com/privacy-policy/';

  /// Used for showing about page of website
  static const String aboutPageUrl = 'https://awakenedwayapp.suzannegiesemann.com/';

  /// Support Email
  static const String supportEmail = 'jayesh.mitha@gmail.com';

  /// Social Links
  static const String facebookUrl = '';
  static const String youtubeUrl = '';
  static const String twitterUrl = '';

  /// If we should force user to login everytime they start the app
  static const bool forceUserToLoginEverytime = true;

  /* <---- Show Post on notificaiton -----> */
  /// If you want to enable a post dialog when a notification arrives, if
  /// it is false a small Toast will appear on the bottom of the screen, see the
  /// example below
  /// https://drive.google.com/file/d/1Dq2ZyNgXTsnFFqm4m9infbnSn4rb-vTl/view?usp=sharing
  static bool showPostDialogOnNotificaiton = false;

  /// IF you want the popular post plugin to be disabled turn this to "false"
  static bool isPopularPostPluginEnabled = true;

  /* <-----------------------> 
      Categories    
   <-----------------------> */

  /// "FEATURED" tag id From Website
  /// the feature tag id which used to identify featured articles
  static const int featuredTagID = 26;

  /// "VIDEO" tag id from website
  /// the id of the video tag, which will help us identify the post type in app
  static const int videoTagID = 12;

  /// Home Page Category Name With Their ID's, the ordering will be same in UI
  /// How to find category ID:
  /// https://njengah.com/find-wordpress-category-id/
  static final homeCategories = <int, String>{
    // ID of Category : Name of the Category
    180: 'Daily Way',
    26: 'Daily',
    213:'Poem',
    118:'Special Sessions'
  };

  /// Name of the feature category
  static const featureCategoryName = 'Trending';

  /// Show horizonatal Logo in home page or title
  /// You can replace the logo in the asset folder
  /// horizonatal logo width is 136x35
  static bool showLogoInHomePage = true;

  /// IF we should keep the caching of home categories tab caching or not
  /// if this is false, then we will fetch new data and refresh the
  /// list if user changes tab or click on one
  static bool enableHomeTabCache = false;

  /// Blocked Categories ID's which will not appear in UI
  ///
  /// How to find category ID:
  /// https://njengah.com/find-wordpress-category-id/
  static List<int> blockedCategoriesIds = [1];
}
