// This is a placeholder script that copies sample files and data files to the desktop
// so the user can try out the script. If you don't want it, delete it, and adjust
// the manifest.json so it does not try to find it

const SAMPLE_FILE_NAME_NO_EXTENSION = "SomeSampleFile";
const FILENAME_EXTENSION_IDML       = ".idml";
const FILENAME_EXTENSION_DOCUMENT   = ".indd";

const SAMPLE_DOCUMENT = SAMPLE_FILE_NAME_NO_EXTENSION + FILENAME_EXTENSION_DOCUMENT;
const SAMPLE_TEMPLATE = SAMPLE_FILE_NAME_NO_EXTENSION + FILENAME_EXTENSION_IDML;

var installedFolder = File($.fileName).parent;

var installerSampleFile = File(installedFolder + "/" + SAMPLE_TEMPLATE);
if (! installerSampleFile.exists) {
	alert("Cannot find file " + installerSampleFile);
}
else {
	var desktopSampleFile = File(Folder.desktop + "/" + SAMPLE_DOCUMENT);
	if (desktopSampleFile.exists) {
		alert("There is already a sample file " + SAMPLE_DOCUMENT + " on the desktop. Opening this document if it's not already open.");
		var doc = app.open(desktopSampleFile);
	}
	else {
		var doc = app.open(installerSampleFile);
		doc.save(desktopSampleFile);
		if (! desktopSampleFile.exists) {
			alert("Copy operation unexpectedly failed. :-(");
		}
		else {
			alert("Sample files " + SAMPLE_DOCUMENT + " and " + SAMPLE_DOCS + " have been saved to the desktop.");
		}
	}
}

