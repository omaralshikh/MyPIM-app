//
//  AddNote.swift
//  MyPIM
//
//  Created by Omar on 10/18/20.
//  Copyright © 2020 Omar Alshikh. All rights reserved.
//

import SwiftUI
import AVFoundation
import Speech

fileprivate var audioFullFilename = ""
fileprivate var audioRecorder: AVAudioRecorder!

struct AddNote: View {
    
    @EnvironmentObject var userData: UserData

    
    @Environment(\.presentationMode) var presentationMode

    @State private var selectedIndex = 1
    let cam = ["Camera", "Photo Library"]

    @State private var recordingVoice = false
    @State private var NoteTitle = ""
    @State private var note = ""
    @State private var locationName = ""
    @State private var speechConvertedToText = ""
    @State private var photoImageData: Data? = nil
    @State private var showImagePicker = false
 
    // Alerts
    @State private var showMissingInputDataAlert = false
    @State private var showNoteAddedAlert = false


    var body: some View {
        
        Form {
            Section(header: Text("Multimedia Note Title")) {
                HStack {
                TextField("Enter Note Title", text: $NoteTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                
                Button(action: {
                    self.NoteTitle = ""
                }) {
                    Image(systemName: "clear")
                        .imageScale(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
                        .font(Font.title.weight(.regular))
                }
                } // hstack
                .alert(isPresented: $showMissingInputDataAlert, content: { self.missingInputDataAlert })

            }
            Section(header: Text("take notes by entering text")) {
                TextField("Enter note here", text: $note)
            }
            
            Section(header: Text("Add multimedia note photo")) {
                Picker("", selection: $selectedIndex) {
                    ForEach(0 ..< cam.count, id: \.self) { index in
                       Text(self.cam[index]).tag(index)
                   }
                }
                .frame(minWidth: 300, maxWidth: 500, alignment: .center)
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                Button(action: {
                    if(selectedIndex == 1 ){
                    self.showImagePicker = true
                    }
    //                else if (selectedIndex == 0){
    //                    self.showImagePicker = true
    //                }
                }) {
                HStack {
                Image(systemName: "square.and.arrow.up.on.square")
                    .imageScale(.large)
                    .font(Font.title.weight(.regular))
                    .foregroundColor(.blue)
                Text("Get Photo")
                }
                }

            }
            Section(header: Text("Multimedia note photo")) {
                if(photoImageData != nil ){
                    getImageFromBinaryData(binaryData: self.photoImageData, defaultFilename: "DefaultMultimediaNotePhoto")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80)
                }
                else{
                    Image("DefaultMultimediaNotePhoto")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80)
                }


            }

            
            Section(header: Text("Voice Recording")) {
                Button(action: {
                    self.voiceRecordingMicrophoneTapped()
                }) {
                    voiceRecordingMicrophoneLabel
                }
            }
            Section(header: Text("Take Notes by converting speech to text")) {
                VStack {
                    Button(action: {
                        self.microphoneTapped()
                    }) {
                        microphoneLabel
                    }
                    .padding()
                    Text(speechConvertedToText)
                        .multilineTextAlignment(.center)
                        // This enables the text to wrap around on multiple lines
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.horizontal)
                }
                .onDisappear() {
                    self.speechConvertedToText = ""
                }

            }
            
            Section(header: Text("Multimedia location Name")) {
                HStack {
                TextField("Enter location name", text: $locationName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                
                Button(action: {
                    self.locationName = ""
                }) {
                    Image(systemName: "clear")
                        .imageScale(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
                        .font(Font.title.weight(.regular))
                }
                } // hstack
            }
            
        } // form
        
        .font(.system(size: 14))
        .sheet(isPresented: self.$showImagePicker) {
            PhotoCaptureView(showImagePicker: self.$showImagePicker,
                             photoImageData: self.$photoImageData,
                             cameraOrLibrary: "Photo Library")
        }
        .alert(isPresented: $showNoteAddedAlert, content: { self.noteAddedAlert })
        .navigationBarTitle(Text("New Multimedia Note"), displayMode: .inline)
        // Place the Add (+) button on right of the navigation bar
        .navigationBarItems(trailing:
            Button(action: {
                if self.inputDataValidated() {
                    self.addNewVoiceMemo()
                    self.showNoteAddedAlert = true
                } else {
                    self.showMissingInputDataAlert = true
                }
            }) {
                Image(systemName: "plus")
        })
        
    }
    /*
    -----------------------------
    MARK: - Input Data Validation
    -----------------------------
    */
   func inputDataValidated() -> Bool {
      
       if self.NoteTitle.isEmpty || audioFullFilename.isEmpty {
           return false
       }
      
       return true
   }
    
    /*
     --------------------------------
     MARK: - Missing Input Data Alert
     --------------------------------
     */
    var missingInputDataAlert: Alert {
        Alert(title: Text("Missing Input Data!"),
              message: Text("title and audio are required. Default values are assumed for the others."),
              dismissButton: .default(Text("OK")) )
        /*
        Tapping OK resets @State var showMissingInputDataAlert to false.
        */
    }
    /*
    ----------------------------------
    MARK: - New Voice Memo Added Alert
    ----------------------------------
    */
   var noteAddedAlert: Alert {
       Alert(title: Text("New multimedia note Added!"),
             message: Text("New multimedia note is added to your multimedia note list."),
             dismissButton: .default(Text("OK")) {
              
               // Dismiss this Modal View and go back to the previous view in the navigation hierarchy
               self.presentationMode.wrappedValue.dismiss()
             })
   }
    
    var microphoneLabel: some View {
        VStack {
            Image(systemName: recordingVoice ? "mic.fill" : "mic.slash.fill")
                .imageScale(.large)
                .font(Font.title.weight(.medium))
                .foregroundColor(.blue)
            Text(recordingVoice ? "Recording your voice... Tap to Stop!" : "Convert Speech to Text!")
                .padding()
                .multilineTextAlignment(.center)
        }
    }
    
    /*
     ----------------------------------------
     MARK: - Voice Recording Microphone Label
     ----------------------------------------
     */
    var voiceRecordingMicrophoneLabel: some View {
        VStack {
            Image(systemName: recordingVoice ? "mic.fill" : "mic.slash.fill")
                .imageScale(.large)
                .font(Font.title.weight(.medium))
                .foregroundColor(.blue)
                .padding()
            Text(recordingVoice ? "Recording your voice... Tap to Stop!" : "Start Recording!")
                .multilineTextAlignment(.center)
        }
    }
    
    func microphoneTapped() {
        if recordingVoice {
            cancelRecording()
            self.recordingVoice = false
        } else {
            self.recordingVoice = true
            recordAndRecognizeSpeech()
        }
    }
    
    func cancelRecording() {
        request.endAudio()
        audioEngine.inputNode.removeTap(onBus: 0)
        audioEngine.stop()
        recognitionTask.finish()
    }
    
    func recordAndRecognizeSpeech() {
        //--------------------
        // Set up Audio Buffer
        //--------------------
        let node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            request.append(buffer)
        }
       
        //---------------------
        // Prepare Audio Engine
        //---------------------
        audioEngine.prepare()
       
        //-------------------
        // Start Audio Engine
        //-------------------
        do {
            try audioEngine.start()
        } catch {
            print("Unable to start Audio Engine!")
            return
        }
       
        //-------------------------------
        // Convert recorded voice to text
        //-------------------------------
        recognitionTask = speechRecognizer.recognitionTask(with: request, resultHandler: { result, error in
           
            if result != nil {  // check to see if result is empty (i.e. no speech found)
                if let resultObtained = result {
                    let bestString = resultObtained.bestTranscription.formattedString
                    self.speechConvertedToText = bestString
                    
                } else if let error = error {
                    print("Transcription failed, but will continue listening and try to transcribe. See \(error)")
                }
            }
        })
    }
    
    /*
     ---------------------------------------
     MARK: Voice Recording Microphone Tapped
     ---------------------------------------
     */
    func voiceRecordingMicrophoneTapped() {
        if audioRecorder == nil {
            self.recordingVoice = true
            startRecording()
        } else {
            self.recordingVoice = false
            finishRecording()
        }
    }
    
    /*
     ----------------------------------
     MARK: - Start Voice Memo Recording
     ----------------------------------
     */
    func startRecording() {
 
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
       
        audioFullFilename = UUID().uuidString + ".m4a"
        let audioFilenameUrl = documentDirectory.appendingPathComponent(audioFullFilename)
       
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilenameUrl, settings: settings)
            audioRecorder.record()
        } catch {
            finishRecording()
        }
    }
    
    /*
     -----------------------------------
     MARK: - Finish Voice Memo Recording
     -----------------------------------
     */
    func finishRecording() {
        audioRecorder.stop()
        audioRecorder = nil
        self.recordingVoice = false
    }

    /*
     --------------------------
     MARK: - Add New Voice Memo
     --------------------------
     */
    func addNewVoiceMemo() {
       
        // Instantiate a Date object
        let date = Date()
       
        // Instantiate a DateFormatter object
        let dateFormatter = DateFormatter()
       
        // Set the date format to yyyy-MM-dd at HH:mm:ss
        dateFormatter.dateFormat = "yyyy-MM-dd' at 'HH:mm:ss"
       
        // Format the Date object as above and convert it to String
        let currentDateTime = dateFormatter.string(from: date)
       
        // Create a new instance of VoiceMemo struct and dress it up
        let newNote = Notes(id: UUID(), title: self.NoteTitle, textualNote: self.note, photoFullFilename: "", audioFullFilename: audioFullFilename, speechToTextNote: "", locationName: "", dateTime: currentDateTime, latitude: 0.0, longitude: 0.0)
       
        // Append the new voice memo to the list
        userData.NotesList.append(newNote)
       
        // Set the global variable point to the changed list
        NotesStructList = userData.NotesList
       
        // Initialize audioFullFilename for the next use.
        // audioFullFilename = "" if the user did not record his/her voice.
       
        audioFullFilename = ""
       
        
        // Dismiss this View and go back
        self.presentationMode.wrappedValue.dismiss()
    }
   
}

struct AddNote_Previews: PreviewProvider {
    static var previews: some View {
        AddNote()
    }
}
