/* jshint ignore:start */
#import "../../vendor/tuneup_js/tuneup.js"
#import "../../vendor/mechanic.min.js"
#import "../../vendor/underscore.js"
/* jshint ignore:end */

test("should see placeholder tracks", function(target, app) {
  var homeTabButton = $("tabbar button[label=Home]");
  assertTrue(homeTabButton.isValid(), "couldn't find Home tab bar button");
  homeTabButton.tap();

  // find all table view cells
  var trackListCells = $("cell");
  assertEquals(5, trackListCells.length, "wrong number of track cells");
});
