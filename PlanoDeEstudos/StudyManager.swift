//
//  StudyManager.swift
//  PlanoDeEstudos
//
//  Created by Vinicius Loss on 03/03/23.
//  Copyright © 2023 Eric Brito. All rights reserved.
//

import Foundation
import UserNotifications

class StudyManager {
    
    static let shared = StudyManager()
    
    let ud = UserDefaults.standard
    var studyPlans: [StudyPlan] = []
    
    private init(){
        if let data = ud.data(forKey: "studyPlans"), let plans = try? JSONDecoder().decode([StudyPlan].self, from: data){
            self.studyPlans = plans
        }
    }
    
    // Persiste os dados no UserDefaults
    func savePlans(){
        if let data = try? JSONEncoder().encode(studyPlans){
            ud.set(data, forKey: "studyPlans")
        }
    }
    
    // Adiciona o plano ao arrya de planos de ensino
    func addPlan(_ studyPlan: StudyPlan){
        studyPlans.append(studyPlan)
        savePlans()
    }
    
    // Remove do array e salva novo array no UserDefaults
    func removePlan(at index: Int){
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [studyPlans[index].id])
        
        studyPlans.remove(at: index)
        savePlans()
    }
    
    func setPlanDone(id: String){
        if let studyPlan = studyPlans.first(where: { $0.id == id }){
            studyPlan.done = true
            savePlans()
        }
    }
}
