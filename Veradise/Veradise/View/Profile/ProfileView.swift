//
//  ProfileView.swift
//  Veradise
//
//  Created by Rinaldi LNU on 09/08/21.
//

import SwiftUI
import CoreNFC

struct ProfileView: View {
    @State var urlT = ""
    @State var writer = NFCReader()
    
    var body: some View {
        VStack {
        GeometryReader(content: { geometry in
            let topEdge = geometry.safeAreaInsets.top
            NavBar(navTitle: "Profile", topEdge: topEdge)
                .ignoresSafeArea()
        })
            TextField("URL: ", text: $urlT)
            Button(action: {
                writer.scan(actualData: urlT)
            }, label: {
                Text("GET TAG")
            })
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

class NFCReader: NSObject, ObservableObject, NFCNDEFReaderSessionDelegate {
    
    var actualData = ""
    var nfcSession: NFCNDEFReaderSession?
    
    func scan(actualData: String) {
        self.actualData = actualData
        nfcSession = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        nfcSession?.alertMessage = "Hold your iphone near an NFC Card"
        nfcSession?.begin()
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("Error Launching session")
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [NFCNDEFTag]) {
        let str: String = actualData
        if tags.count > 1 {
            let retryInterval = DispatchTimeInterval.milliseconds(500)
            session.alertMessage = "More than one tag detected, please try again."
            DispatchQueue.global().asyncAfter(deadline: .now() + retryInterval) {
                session.restartPolling()
            }
            return
        }
        let tag = tags.first!
        session.connect(to: tag) { (error: Error?) in
            if nil != error {
                session.alertMessage = "Unable to connect to tag"
                session.invalidate()
                return
            }
            tag.queryNDEFStatus { status, capacity, error in
                guard error == nil else {
                    session.alertMessage = "Unable to connect to tag"
                    session.invalidate()
                    return
                }
                switch status {
                case.notSupported:
                    session.alertMessage = "Not supported"
                    session.invalidate()
                case.readOnly:
                    session.alertMessage = "Readonly"
                    session.invalidate()
                case .readWrite:
                    print(tag, "AAAA")
                    tag.writeNDEF(.init(records: [NFCNDEFPayload.wellKnownTypeURIPayload(string: "\(str)")!])) { error in
                        if nil != error {
                            session.alertMessage = "Failed"
                        } else {
                            session.alertMessage = "Success"
                        }
                        session.invalidate()
                    }
                @unknown default:
                    session.alertMessage = "Unknown Error"
                    session.invalidate()
                }
            }
        }
    }
}
