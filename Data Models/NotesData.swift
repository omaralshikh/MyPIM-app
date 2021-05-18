//
//  FileData.swift
//  MyPIM
//
//  Created by Omar on 10/18/20.
//  Copyright © 2020 Omar Alshikh. All rights reserved.
//

import Foundation
import SwiftUI
import CoreLocation
import AVFoundation

 
// Global array of note structs
var NotesStructList = [Notes]()

var audioSession = AVAudioSession()

 
/*
 ***********************************
 MARK: - Read note Photos Data File
 ***********************************
 */
public func readNotesDataFile() {
   
    var fileExistsInDocumentDirectory = false
    let jsonDataFullFilename = "MultimediaNotesData.json"
   
    // Obtain URL of the data file in document directory on user's device
    let urlOfJsonFileInDocumentDirectory = documentDirectory.appendingPathComponent(jsonDataFullFilename)
 
    do {
        _ = try Data(contentsOf: urlOfJsonFileInDocumentDirectory)
       
        // MultimediaNotesData.json file exists in the document directory
        fileExistsInDocumentDirectory = true
 
        NotesStructList = decodeJsonFileIntoArrayOfStructs(fullFilename: jsonDataFullFilename, fileLocation: "Document Directory")
        print("NotesData is loaded from document directory")
       
    } catch {
        /*
         MultimediaNotesData.json file does not exist in the document directory; Load it from the main bundle.
         This happens only once when the app is launched for the very first time.
         */
       
        NotesStructList = decodeJsonFileIntoArrayOfStructs(fullFilename: jsonDataFullFilename, fileLocation: "Main Bundle")
        print("NotesData is loaded from main bundle")
    }
   
    if !fileExistsInDocumentDirectory {
        /*
         ===============================================================
         |   Copy note Photo Files from Assets to Document Directory  |
         ===============================================================
         */
        for photo in NotesStructList {
           
            // Example photo fullFilename = "D3C83FED-B482-425C-A3F8-6C90A636DFBF.jpg"
            let array = photo.photoFullFilename.components(separatedBy: ".")
           
            // array[0] = "D3C83FED-B482-425C-A3F8-6C90A636DFBF"
            // array[1] = "jpg"
           
            // Copy each photo file from Assets.xcassets to document directory
            copyImageFileFromAssetsToDocumentDirectory(filename: array[0], fileExtension: array[1])
        }
    }
}
 
/*
 **********************************************************
 MARK: - Write note Photos Data File to Document Directory
 **********************************************************
 */
public func writeNotesDataFile() {
   
    // Obtain URL of the JSON file into which data will be written
    let urlOfJsonFileInDocumentDirectory: URL? = documentDirectory.appendingPathComponent("MultimediaNotesData.json")
 
    // Encode photoStructList into JSON and write it into the JSON file
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(NotesStructList) {
        do {
            try encoded.write(to: urlOfJsonFileInDocumentDirectory!)
        } catch {
            fatalError("Unable to write encoded photo data to document directory!")
        }
    } else {
        fatalError("Unable to encode photo data!")
    }
}

/*
******************************************
MARK: - Get Permission for Voice Recording
******************************************
*/
public func getPermissionForVoiceRecording() {
   
    // Create a shared audio session instance
    audioSession = AVAudioSession.sharedInstance()
   
    //---------------------------
    // Enable Built-In Microphone
    //---------------------------
   
    // Find the built-in microphone.
    guard let availableInputs = audioSession.availableInputs,
          let builtInMicrophone = availableInputs.first(where: { $0.portType == .builtInMic })
    else {
        print("The device must have a built-in microphone.")
        return
    }
    do {
        try audioSession.setPreferredInput(builtInMicrophone)
    } catch {
        print("Unable to Find the Built-In Microphone!")
    }
   
    //--------------------------------------------------
    // Set Audio Session Category and Request Permission
    //--------------------------------------------------
   
    do {
        try audioSession.setCategory(.playAndRecord, mode: .default)
       
        // Activate the audio session
        try audioSession.setActive(true)
       
        // Request permission to record user's voice
        audioSession.requestRecordPermission() { allowed in
            DispatchQueue.main.async {
                if allowed {
                    // Permission is recorded in the Settings app on user's device
                } else {
                    // Permission is recorded in the Settings app on user's device
                }
            }
        }
    } catch {
        print("Setting category or getting permission failed!")
    }
}
 
/*
**************************************************************
MARK: - Save Taken or Picked Photo Image to Document Directory
**************************************************************
*/
func savePhoto(title: String, textualNote: String, audioFullFilename: String, speechToText: String, locationName: String) -> Notes {
 
    //----------------------------------------
    // Generate a new id and new full filename
    //----------------------------------------
    let newAlbumPhotoId = UUID()
    let newFullFilename = UUID().uuidString + ".jpg"
    //let newAudioFilename = UUID().uuidString + ".m4a"

 
    //-----------------------------
    // Obtain Current Date and Time
    //-----------------------------
    let date = Date()
   
    // Instantiate a DateFormatter object
    let dateFormatter = DateFormatter()
 
    // Set the date format to yyyy-MM-dd at HH:mm:ss
    dateFormatter.dateFormat = "yyyy-MM-dd' at 'HH:mm:ss"
   
    // Format current date and time as above and convert it to String
    let currentDateTime = dateFormatter.string(from: date)
   
    //----------------------------------------------------------
    // Get Latitude and Longitude of Where Photo Taken or Picked
    //----------------------------------------------------------
   
    // Public function currentLocation() is given in CurrentLocation.swift
    let photoLocation = currentLocation()
   
    let newAlbumPhoto = Notes(id: newAlbumPhotoId, title: title, textualNote: textualNote, photoFullFilename: newFullFilename, audioFullFilename: audioFullFilename, speechToTextNote: speechToText, locationName: locationName, dateTime: currentDateTime, latitude: photoLocation.latitude, longitude: photoLocation.longitude)
   
    //-------------------------------------------------------
    // Save Taken or Picked Photo Image to Document Directory
    //-------------------------------------------------------
   
    // Global variable pickedImage was obtained in ImagePicker.swift
 
    /*
     Convert pickedImage to a data object containing the
     image data in JPEG format with 100% compression quality
     */
    if let data = pickedImage.jpegData(compressionQuality: 1.0) {
        let fileUrl = documentDirectory.appendingPathComponent(newFullFilename)
        try? data.write(to: fileUrl)
    } else {
        print("Unable to write photo image to document directory!")
    }
   
    return newAlbumPhoto
}
 
