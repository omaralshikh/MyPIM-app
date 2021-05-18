//
//  NotesDetails.swift
//  MyPIM
//
//  Created by Omar on 10/18/20.
//  Copyright © 2020 Omar Alshikh. All rights reserved.
//

import SwiftUI
import MapKit
import AVFoundation



struct NotesDetails: View {
    let note: Notes
    
    @EnvironmentObject var audioPlayer: AudioPlayer

    var body: some View {
        
    Form {
        Section(header: Text("Multimedia Note Title")) {
            Text(note.title)
        }
        Section(header: Text("Multimedia Note Photo")) {
            // This public function is given in UtilityFunctions.swift
            getImageFromDocumentDirectory(filename: note.photoFullFilename.components(separatedBy: ".")[0], fileExtension: note.photoFullFilename.components(separatedBy: ".")[1], defaultFilename: "ImageUnavailable")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(minWidth: 300, maxWidth: 500, alignment: .center)
        }
        Section(header: Text("Textual Note")) {
            Text(note.textualNote)
        }
        Section(header: Text("Name of location where note was taken")) {
            Text(note.locationName)
        }
        Section(header: Text("show multimedia note photo location on map")) {
            NavigationLink(destination: photoLocationOnMap) {
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                        .imageScale(.medium)
                        .font(Font.title.weight(.regular))
                        .foregroundColor(.blue)
                    Text("Show Photo Location on Map")
                        .font(.system(size: 16))
                }
                .frame(minWidth: 300, maxWidth: 500, alignment: .leading)
            }
        }
        Section(header: Text("Play Notes Taken by Voice Recording")) {
            Button(action: {
                if self.audioPlayer.isPlaying {
                    self.audioPlayer.pauseAudioPlayer()
                } else {
                    self.audioPlayer.startAudioPlayer()
                }
            }) {
                Image(systemName: self.audioPlayer.isPlaying ? "pause.fill" : "play.fill")
                    .foregroundColor(.blue)
                    .font(Font.title.weight(.regular))
                }
        
        }
        
        Section(header: Text("speech to text note")) {
            Text( note.speechToTextNote)
        }
        
        Section(header: Text("Date and Time Photo Obtained")) {
            Text(note.dateTime)
        }
        
    }   // End of Form
        .navigationBarTitle(Text(note.title), displayMode: .inline)
        .font(.system(size: 14))
}

var photoLocationOnMap: some View {
    return AnyView(MapView(mapType: MKMapType.standard, latitude: note.latitude,
                           longitude: note.longitude, delta: 15.0, deltaUnit: "degrees",
                           annotationTitle: note.title, annotationSubtitle: note.dateTime)
        .navigationBarTitle(Text(note.title), displayMode: .inline)
        .edgesIgnoringSafeArea(.all) )
}
    
    func createPlayer() {
        let voiceMemoFileUrl = documentDirectory.appendingPathComponent(note.audioFullFilename)
        audioPlayer.createAudioPlayer(url: voiceMemoFileUrl)
    }
}

struct NotesDetails_Previews: PreviewProvider {
    static var previews: some View {
        NotesDetails(note: NotesStructList[0])
    }
}
