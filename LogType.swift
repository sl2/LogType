//
//  LogType.swift
//  Copyright (c) 2015 so. All rights reserved.
//

import Foundation

enum Log:Int {

    case debug = 100
    case info = 200
    case warning = 300
    case error = 400
    
    func toString() -> String {
        switch self {
        case .debug:
            return "Debug"
        case .info:
            return "Info"
        case .warning:
            return "Warning"
        case .error:
            return "Error"
        default:
            return "Error"
        }
    }

    func set() -> Void {
        NSUserDefaults.standardUserDefaults().setInteger(self.rawValue, forKey: "LogLevel")
    }

    func out(filepath:String=__FILE__, line:Int=__LINE__, function:String=__FUNCTION__) -> Void {
        writeToConsole("", filepath: filepath, line: line, function: function)
    }
    
    func out(message:String, filepath:String=__FILE__, line:Int=__LINE__, function:String=__FUNCTION__) -> Void {
        writeToConsole(message, filepath: filepath, line: line, function: function)
    }

    internal func writeToConsole(message:String, filepath:String, line:Int, function:String) -> Void {
 
        func getCurrentLogLevel() -> Int {
            return NSUserDefaults.standardUserDefaults().integerForKey("LogLevel")
        }
        
        func getDate() -> String {
            let now = NSDate()
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
            return dateFormatter.stringFromDate(now)
        }
        
        if self.rawValue >= getCurrentLogLevel() {
            let file = split(filepath){ $0 == "/" }.last!
            println("[\(toString())],\(getDate()),\(file),\(line),\(function),\(message)")
        }
    }
    

}


