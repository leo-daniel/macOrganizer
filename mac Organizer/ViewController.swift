//
//  ViewController.swift
//  mac Organizer
//
//  Created by Shubham Batra on 06/03/18.
//  Copyright © 2018 Esper. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, FileManagerDelegate  {

    let fileManager:FileManager = FileManager()
    var filesArray: [String] = []
    var foldersInOrganized: [String] = ["Documents", "PDFs", "Pictures", "Audio", "Video", "Spreadsheet", "Presentation", "Archieves", "Other"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    //Mark: To get all the Contents of Directory
    func getContentsOfFolder(folder: URL) {
        do {
            let files = try fileManager.contentsOfDirectory(at: folder, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            for file in files {
                filesArray.append(file.lastPathComponent)
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    //Mark: Organize all the files in the array containing all file name.
    func organizeFiles(folderPicked: URL) {
        
        for file in filesArray {
            let filetype = fileType.getFileType(fileName: file)
            if(filetype != "Folder") {
                let filePath = folderPicked.appendingPathComponent(file)
                var destinationPath = folderPicked.appendingPathComponent("Organized")
                destinationPath = destinationPath.appendingPathComponent(filetype)
                destinationPath = destinationPath.appendingPathComponent(file)
                moveFiles(from: filePath, to: destinationPath)
            }
        }
        
    }
    
    @IBAction func importButton(_ sender: Any) {
        filesArray.removeAll()
        let folderPicker: NSOpenPanel = NSOpenPanel()
        folderPicker.allowsMultipleSelection = false
        folderPicker.canChooseDirectories = true
        folderPicker.canChooseFiles = false
        let button = folderPicker.runModal()
        if(button.rawValue == NSOKButton) {
        var folderPicked = folderPicker.url
        getContentsOfFolder(folder: folderPicked!)
        checkAndCreateFolder(folderPicked: folderPicked!)
        organizeFiles(folderPicked: folderPicked!)
        }
        else {
            print("Action canceled")
        }
    }
    
    func moveFiles(from: URL, to: URL) {
        
        do {
            try fileManager.moveItem(at: from, to: to)
            print("Move Successful")
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    //Mark: Checks if the Organized Folder Already Exists. If not, Creates it.
    
    func checkAndCreateFolder(folderPicked: URL) {
        
        let pathComponent = folderPicked.appendingPathComponent("Organized")
            let filePath = pathComponent.path
          //  print(filePath)
            if !fileManager.fileExists(atPath: filePath) {
                do {
                    try fileManager.createDirectory(at: pathComponent, withIntermediateDirectories: true, attributes: nil)
                    for folder in foldersInOrganized {
                        let subDirectory = pathComponent.appendingPathComponent(folder)
                        try fileManager.createDirectory(at: subDirectory, withIntermediateDirectories: false, attributes: nil)
                    }
                }
                catch {
                    print(error.localizedDescription)
                }
            }
            else {
                //Todo:If folder already exists.
            }
    }
    
    
    
    
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

extension String {
    
    func fileExtension() -> String {
        return NSURL(fileURLWithPath: self).pathExtension ?? ""
    }
    
}
