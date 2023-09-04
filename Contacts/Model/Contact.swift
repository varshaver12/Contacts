//
//  Contact.swift
//  Contacts
//
//  Created by 1234 on 29.08.2023.
//

import Foundation

protocol ContactProtocol {
    var title: String { get set }
    var phone: String { get set }
}

protocol ContactStorageProtocol {
    // Load list of contacts
    func load() -> [ContactProtocol]
    // Save list of contacts
    func save(contacts: [ContactProtocol])
}

struct Contact: ContactProtocol {
    var title: String
    var phone: String
}

class ContactStorage: ContactStorageProtocol {
    private var storage = UserDefaults.standard
    private var storageKey = "contacts"
    private enum ContactKey: String {
        case title
        case phone
    }
    
    func load() -> [ContactProtocol] {
        var resultsContacts: [ContactProtocol] = []
        let contactsFromStorage = storage.array(forKey: storageKey) as? [[String: String]] ?? []
        for contact in contactsFromStorage {
            guard let title = contact[ContactKey.title.rawValue],
                  let phone = contact[ContactKey.phone.rawValue] else { continue }
            resultsContacts.append(Contact(title: title, phone: phone))
        }
        return resultsContacts
    }
    
    func save(contacts: [ContactProtocol]) {
        var arrayForStorage: [[String:String]] = []
        contacts.forEach { contact in
            var newElementForStorage: Dictionary<String, String> = [:]
            newElementForStorage[ContactKey.title.rawValue] = contact.title
            newElementForStorage[ContactKey.phone.rawValue] = contact.phone
            arrayForStorage.append(newElementForStorage)
        }
        storage.set(arrayForStorage, forKey: storageKey)
    }
    
    
}
