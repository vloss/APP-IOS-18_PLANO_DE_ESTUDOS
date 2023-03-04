//
//  StudyPlan.swift
//  PlanoDeEstudos
//
//  Created by Vinicius Loss on 03/03/23.
//  Copyright © 2023 Eric Brito. All rights reserved.
//

import Foundation

class StudyPlan: Codable {
    
    let course: String
    let section: String
    let date: Date
    var done: Bool = false
    var id: String
    
    init (course: String, section: String, date: Date, done: Bool, id: String){
        self.course = course
        self.section = section
        self.date = date
        self.id = id
    }
}
