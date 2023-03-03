//
//  StudyViewController.swift
//  PlanoDeEstudos
//
//  Created by Eric Brito
//  Copyright © 2017 Eric Brito. All rights reserved.

import UIKit
import UserNotifications // Para notificações

class StudyPlanViewController: UIViewController {

    @IBOutlet weak var tfCourse: UITextField!
    @IBOutlet weak var tfSection: UITextField!
    @IBOutlet weak var dpDate: UIDatePicker!
    
    let sm = StudyManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dpDate.minimumDate = Date() // Difine data minima para datepicker
    }

    @IBAction func schedule(_ sender: UIButton) {
        let id = String(Date().timeIntervalSince1970)
        let studyPlan = StudyPlan(course: tfCourse.text!, section: tfSection.text!, date: dpDate.date, done: false, id: id)

        // Criando notificação
        let content = UNMutableNotificationContent()
        content.title = "Lembrete"
        content.subtitle = "Matéria: \(studyPlan.course)"
        content.body = "Estudar \(studyPlan.section)"
        // content.sound = UNNotificationSound(named: "arquivodesom.caf") // para tocar som na notificação
        content.categoryIdentifier = "Lembrete"
        
        // Três tipos de notificação: Intervalo de Tempo, Data e Localização
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 15, repeats: false) // Executa por um Intervalo de tempo
        
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: dpDate.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false) // Executa por Data especifica.
        
        // Cria a requisição
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        // Adiciona a notificação
        UNUserNotificationCenter.current().add(request)
        
        
        sm.addPlan(studyPlan)
        navigationController!.popViewController(animated: true)
    }
    
}
