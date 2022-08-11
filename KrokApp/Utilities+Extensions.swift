//
//  Utilities+Extensions.swift
//  KrokApp
//
//  Created by Вадим Лавор on 2.08.22.
//

import Foundation

class Utilities {
    
    static let krokAppAboutStringUrl =  "https://krokapp.com/about/"
    static let krokAppGetCitiesUrl = "https://krokapp.by/api/get_cities/11/"
    static let krokAppGetPointsUrl = "http://krokapp.by/api/get_points/11/"
    static let defaultMelody = "https://your-melody.ru/wp-content/uploads/2020/06/top-oshibok.mp3"
    static let characterSet = "abcdefghijklmnoiprstuvyz"
    static let errorParsingData = "Error parsing data"
    static let errorTransition = "Error switching to another controller"
    static let errorDataLoading = "Failed to load data"
    static let cellIdentifier = "cellId"
    
    static func isInAlphabet(name: String) -> Bool {
        let characterSet = CharacterSet(charactersIn: Utilities.characterSet)
        if let _ = name.rangeOfCharacter(from: characterSet, options: .caseInsensitive) {
            return true
        } else {
            return false
        }
    }
    
}

extension String {
    
    init?(htmlEncodedString: String) {
        guard let data = htmlEncodedString.data(using: .utf8) else { return nil }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else { return nil }
        self.init(attributedString.string)
    }
    
    var htmlStripped : String{
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}
