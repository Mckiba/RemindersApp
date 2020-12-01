//
//  ListDocument.swift
//  Reminders
//
//  Created by McKiba Williams on 9/30/20.
//  Copyright © 2020 McKiba Williams. All rights reserved.
//
import Combine
import SwiftUI
import Foundation


class ListDocument: ObservableObject, Identifiable  {
    
    @EnvironmentObject var document: ListDocument
    
    let id: UUID
    
    static let title = ""
    
    @Published var model: Task
    
    
    init(id: UUID) {
        self.id = id

        let defaultsKey = "EmojiArtDocument.\(self.id.uuidString)"
        model = Task(json: UserDefaults.standard.data(forKey: defaultsKey))!
    }
    
    
    
    
    
    
    
    
    
    
    
}
