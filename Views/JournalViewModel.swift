//
//  JournalViewModel.swift
//  MyApp
//
//  Created by HAWRA12 on 02/06/1448 AH.
//

import SwiftUI
import Combine
import Speech
import AVFoundation

class JournalViewModel: ObservableObject {
    @Published var journals: [JournalItem] = [
        JournalItem(
            title: "My Birthday",
            date: "02/09/2024",
            content: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros. Nullam malesuada erat ut turpis.",
            isBookmarked: true,
            createdDate: Date()
        ),
        JournalItem(
            title: "Today's Journal",
            date: "02/09/2024",
            content: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros.",
            isBookmarked: false,
            createdDate: Date().addingTimeInterval(-86400)
        ),
        JournalItem(
            title: "Great Day",
            date: "02/09/2024",
            content: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio.",
            isBookmarked: false,
            createdDate: Date().addingTimeInterval(-172800)
        )
    ]
    
    @Published var searchText: String = ""
    @Published var showAddSheet: Bool = false
    @Published var selectedSort: SortOption = .all
    
    @Published var journalToDelete: JournalItem? = nil
    @Published var showDeleteAlert: Bool = false

    // ==========================================
    // خصائص ودوال التسجيل الصوتي
    // ==========================================
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ar-SA"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    @Published var isRecording: Bool = false

    func toggleVoiceSearch() {
        if isRecording {
            stopRecording()
        } else {
            startRecording()
        }
    }

    private func startRecording() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            DispatchQueue.main.async {
                guard authStatus == .authorized else {
                    print("لم يتم منح إذن التعرف الصوتي")
                    return
                }

                AVAudioSession.sharedInstance().requestRecordPermission { granted in
                    DispatchQueue.main.async {
                        guard granted else {
                            print("لم يتم منح إذن المايكروفون")
                            return
                        }
                        
                        if let recognitionTask = self.recognitionTask {
                            recognitionTask.cancel()
                            self.recognitionTask = nil
                        }

                        let audioSession = AVAudioSession.sharedInstance()
                        do {
                            try audioSession.setCategory(.record, mode: .measurement, options: [.duckOthers])
                            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
                        } catch {
                            print("AudioSession error: \(error)")
                            return
                        }

                        self.recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
                        let inputNode = self.audioEngine.inputNode
                        
                        let recordingFormat = inputNode.outputFormat(forBus: 0)
                        guard recordingFormat.sampleRate > 0 && recordingFormat.channelCount > 0 else {
                            print("لا يوجد مدخل صوت صالح حالياً")
                            return
                        }

                        guard let recognitionRequest = self.recognitionRequest else { return }
                        recognitionRequest.shouldReportPartialResults = true

                        self.recognitionTask = self.speechRecognizer?.recognitionTask(with: recognitionRequest) { result, error in
                            var isFinal = false
                            if let result = result {
                                let spokenText = result.bestTranscription.formattedString
                                DispatchQueue.main.async {
                                    self.searchText = spokenText
                                }
                                isFinal = result.isFinal
                            }

                            if error != nil || isFinal {
                                self.audioEngine.stop()
                                inputNode.removeTap(onBus: 0)
                                self.recognitionRequest = nil
                                self.recognitionTask = nil
                                self.isRecording = false
                            }
                        }

                        inputNode.removeTap(onBus: 0)
                        inputNode.installTap(onBus: 0, bufferSize: 1024, format: nil) { buffer, _ in
                            recognitionRequest.append(buffer)
                        }

                        self.audioEngine.prepare()
                        do {
                            try self.audioEngine.start()
                            self.isRecording = true
                        } catch {
                            print("AudioEngine start error: \(error)")
                        }
                    }
                }
            }
        }
    }

    private func stopRecording() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionRequest?.endAudio()
        isRecording = false
    }

    // ==========================================
    // الدوال الأساسية للـ ViewModel
    // ==========================================
    func addJournal(_ item: JournalItem) {
        journals.insert(item, at: 0)
    }

    func deleteJournal(_ item: JournalItem) {
        if let index = journals.firstIndex(where: { $0.id == item.id }) {
            journals.remove(at: index)
        }
    }

    func toggleBookmark(for item: JournalItem) {
        if let index = journals.firstIndex(where: { $0.id == item.id }) {
            journals[index].isBookmarked.toggle()
        }
    }

    var filteredAndSortedJournals: [JournalItem] {
        var list = journals
         
        if !searchText.isEmpty {
            list = list.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.content.localizedCaseInsensitiveContains(searchText)
            }
        }
         
        switch selectedSort {
        case .bookmarked:
            return list.filter { $0.isBookmarked }
        case .date:
            return list.sorted { $0.createdDate > $1.createdDate }
        case .all:
            return list
        }
    }
}

enum SortOption {
    case all
    case bookmarked
    case date
}
