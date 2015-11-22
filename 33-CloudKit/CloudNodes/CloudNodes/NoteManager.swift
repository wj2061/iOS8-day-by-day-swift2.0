//
//  NoteManager.swift
//  CloudNodes
//
//  Created by wj on 15/11/22.
//  Copyright © 2015年 wj. All rights reserved.
//

import Foundation
import CoreLocation
import CloudKit

protocol NoteManager{
    func createNote(note: Note, callback: ((success: Bool, note: Note?) -> ())?)
    func getSummaryOfNotes(callback: (notes: [Note]) -> ())
    func getNote(noteID: String, callback: (Note) -> ())
    func updateNote(note: Note, callback: ((success: Bool) -> ())?)
    func deleteNote(note: Note, callback: ((success: Bool) -> ())?)
}

class CloudKitNoteManager:NoteManager{
    let database : CKDatabase
    
    init(database:CKDatabase){
        self.database = database
    }
    
    func createNote(note: Note, callback: ((success: Bool, note: Note?) -> ())?) {
        let ckNote = CloudKitNote(note: note)
        database.saveRecord(ckNote.record) { (recored , error ) -> Void in
            if error != nil{
                print("There was an error: \(error)")
                callback?(success: false , note: ckNote)
            }else{
                print("Record saved successfully")
                callback?(success: true , note: ckNote)
            }
        }
    }
    
    func getSummaryOfNotes(callback: (notes: [Note]) -> ()) {
        let query = CKQuery(recordType: "Note", predicate: NSPredicate(value: true))
        let queryOperation = CKQueryOperation(query: query)
        queryOperation.desiredKeys = ["title"]
        var records =  [Note]()
        queryOperation.recordFetchedBlock = {record in records.append(CloudKitNote(record: record ))}
        queryOperation.queryCompletionBlock = {_ in callback(notes: records)}
        
        database.addOperation(queryOperation)
    }
    
    func updateNote(note: Note, callback: ((success: Bool) -> ())?) {
        let cloudKitNote = CloudKitNote(note: note)
        updateNote(cloudKitNote, callback: callback)
    }
    
    func updateNote(note: CloudKitNote, callback:((success: Bool) -> ())?) {
        let updateOpearation = CKModifyRecordsOperation(recordsToSave: [note.record], recordIDsToDelete: nil)
        updateOpearation.perRecordCompletionBlock = {record , error in
            if error != nil{
                print("Unable to modify record: \(record). Error: \(error)")
            }
        }
        updateOpearation.modifyRecordsCompletionBlock = { saved, _, error in
            if error != nil{
                if error!.code == CKErrorCode.PartialFailure.rawValue {
                    print("There was a problem completing the operation. The following records had problems: \(error!.userInfo[CKPartialErrorsByItemIDKey])")
                }
                callback?(success: false)
            } else {
                callback?(success: true)
            }
        }
        database.addOperation(updateOpearation)
    }
    
    func deleteNote(note: Note, callback: ((success: Bool) -> ())?) {
        let deleteOperation = CKModifyRecordsOperation(recordsToSave: nil, recordIDsToDelete: [CKRecordID(recordName: note.id!)])
        deleteOperation.perRecordCompletionBlock = { record, error in
            if error != nil {
                print("Unable to delete record: \(record). Error: \(error)")
            }
        }
        deleteOperation.modifyRecordsCompletionBlock = { _, deleted, error in
            if error != nil {
                if error!.code == CKErrorCode.PartialFailure.rawValue {
                    print("There was a problem completing the operation. The following records had problems: \(error!.userInfo[CKPartialErrorsByItemIDKey])")
                }
                callback?(success: false)
            }
            callback?(success: true)
        }
        database.addOperation(deleteOperation)
    }
    
    func getNote(noteID: String, callback: (Note) -> ()) {
        let recordID = CKRecordID(recordName: noteID)
        database.fetchRecordWithID(recordID) {
            (record, error) in
            if error != nil {
                print("There was an error: \(error)")
            } else {
                let note = CloudKitNote(record: record!)
                callback(note)
            }
        }
    }
}