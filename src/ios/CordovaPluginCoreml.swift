import Vision
import CoreML

@objc(CordovaPluginCoreml) class CordovaPluginCoreml : CDVPlugin {

  @objc(getImage:) func getImage(command: CDVInvokedUrlCommand) { 

  		let argPathUrl = command.arguments[0] as? String ?? ""

  		let modelImageUrl: URL = URL(string: argPathUrl)!;
		let model = try VNCoreMLModel(for: Resnet50().model)
		let request = VNCoreMLRequest(model: model, completionHandler: myResultsMethod)
		let handler = VNImageRequestHandler(url: modelImageUrl)
		handler.perform([request])

		func myResultsMethod(request: VNRequest, error: Error?) {
		    guard let results = request.results as? [VNClassificationObservation]
		        else { 

	        	//fatalError("huh") 

			    var pluginResult = CDVPluginResult (status: CDVCommandStatus_ERROR, messageAs: error);
			    // Set the plugin result to succeed.
			        pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: error);
			    // Send the function result back to Cordova.
			    self.commandDelegate!.send(pluginResult, callbackId: command.callbackId);

		    }
		    for classification in results {

		        // print(classification.identifier, classification.confidence)

			    var pluginResult = CDVPluginResult (status: CDVCommandStatus_ERROR, messageAs: "The Plugin Failed");
			    // Set the plugin result to succeed.
			        pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: classification.identifier);
			    // Send the function result back to Cordova.
			    self.commandDelegate!.send(pluginResult, callbackId: command.callbackId);

		    }

		}

	}
}