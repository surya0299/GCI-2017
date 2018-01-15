// Coded by Tarun Ravi
// For Liquid Galaxy in Google Code-in 2017-2018
function myFunction() {

	// Creates a document by the name queries.txt
	var doc = DocumentApp.create('queries.txt');
	var body = doc.getBody();

	// Populates form with the actual form
	var form = FormApp.openById('1-qEVHwvHEw6SW_jiWMuX2KMkyyFzxhuE2gUEKnyU0xA');

	// This wil extract all the responses from the form
	var formResponses = form.getResponses();

	// The first response, will contain all the correct answers, so I am only
	// acessing that one.
	var formResponse = formResponses[0];
	var itemResponses = formResponse.getItemResponses();

	// Loops through all the questions
	for (var j = 0; j < itemResponses.length; j++) {

		// Gets the data for question j, now with this I can acess the question
		// name, and answer
		var itemResponse = itemResponses[j];

		// The answers contain both longitude and latatude. I am using an array,
		// so that the first slot is the longitude and the second is the
		// latatude
		var cord = ((itemResponse.getResponse()).toString()).split(", ");

		// I am now populating the queries.txt document, it uses the array cord
		// and the question. I create a new line at the end.
		body.appendParagraph("earth@"+itemResponse.getItem().getTitle()+"@flytoview=<LookAt><longitude>"
						+ cord[0]
						+ "</longitude><latitude>"
						+ cord[1]
						+ "</latitude><altitude>0</altitude><heading>"
						+ itemResponse.getItem().getTitle()
						+ "</heading><tilt>0</tilt><range>0</range><gx:altitudeMode>0</gx:altitudeMode></LookAt>\n");

	}
}
