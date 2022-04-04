var exec = require('cordova/exec');

var PLUGIN_NAME = "CordovaPluginCoreml";

var CordovaPluginCoreml = function() {}; 

CordovaPluginCoreml.getImage = function(pathOptions, captionOptions, snapUrl, onSuccess, onError) {
   exec(onSuccess, onError, PLUGIN_NAME, "getImage", [pathOptions, captionOptions, snapUrl]);
};

module.exports = CordovaPluginCoreml;