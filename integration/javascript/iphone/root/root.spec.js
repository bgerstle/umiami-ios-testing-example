/* jshint ignore:start */
#import "../../vendor/tuneup_js/tuneup.js"
#import "../../vendor/mechanic.min.js"
#import "../../vendor/underscore.js"
/* jshint ignore:end */

test("should see root view and tabs after launching", function (target, app) {
  var rootView = $("#root");
  assertTrue(rootView.isValid(), "can't find the #root view!");

  var tabBar = rootView.find('tabbar');

  var searchTab = tabBar.find("button[label=Search]");
  assertTrue(searchTab.isValid(), "can't find search tab!");

  var homeTab = tabBar.find("button[label=Home]");
  assertTrue(homeTab.isValid(), "can't find home tab!");

  searchTab.tap();
  $.delay(0.1);
  assertTrue(rootView.find("#search").isValid(),
             "should see #search after tapping search button");

  homeTab.tap();
  $.delay(0.1);
  assertTrue(rootView.find("#home").isValid(),
             "should see #home after tapping home button");
});
