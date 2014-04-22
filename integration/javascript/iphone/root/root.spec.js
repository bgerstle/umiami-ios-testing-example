/* jshint ignore:start */
#import "../../vendor/tuneup_js/tuneup.js"
#import "../../vendor/mechanic.min.js"
#import "../../vendor/underscore.js"
/* jshint ignore:end */

test("should see #root view after launching", function (target, app) {
  var rootView = $("#root");
  if (_.isEmpty(rootView)) {
    fail("can't find #root view!");
  }
});
