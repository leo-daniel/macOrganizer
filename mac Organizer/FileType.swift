//
//  FileType.swift
//  macOrganizer
//
//  Created by Shubham Batra on 12/03/18.
//  Copyright © 2018 Esper. All rights reserved.
//

import Foundation

class fileType {
    
    class func getFileType(fileName: String) {
        isDocument(ext: fileName.fileExtension())
    }
    
    class func isPDF(ext: String) -> Bool {
        let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, ext as CFString, nil)
        if(UTTypeConformsTo((uti?.takeRetainedValue())!, kUTTypePDF)) {
           return true
        }
        else {
            return false
        }
    }
    
    class func isImage(ext: String) -> Bool {
        
        let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, ext as CFString, nil)
        if(UTTypeConformsTo((uti?.takeRetainedValue())!, kUTTypeImage)) {
            print("File is a Image")
            return true
        }
        else {
            print("File is not a Image")
            return false
        }
        
    }
    
    class func isAudio(ext: String) -> Bool {
        let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, ext as CFString, nil)
        if(UTTypeConformsTo((uti?.takeRetainedValue())!, kUTTypeAudio)) {
            print("File is a Audio")
            return true
        }
        else {
            print("File is not a audio")
            return false
        }
    }
    
    class func isVideo(ext: String) -> Bool {
        let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, ext as CFString, nil)
        if(UTTypeConformsTo((uti?.takeRetainedValue())!, kUTTypeMovie)) {
            print("File is a Video")
            return true
        }
        else {
            print("File is not a video")
            return false
        }
    }
    
    class func isDocument(ext: String) -> Bool {
    
        if(ext == "pages" || ext == "doc" || ext == "docx" || ext == "txt") {
            print("File is a Document")
            return true
        }
        else {
            print("File is not a document")
            return false
        }
    
    }
}
