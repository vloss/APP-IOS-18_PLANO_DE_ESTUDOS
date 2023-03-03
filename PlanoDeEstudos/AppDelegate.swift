//
//  AppDelegate.swift
//  PlanoDeEstudos
//
//  Created by Eric Brito
//  Copyright © 2017 Eric Brito. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let center = UNUserNotificationCenter.current()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window?.tintColor = UIColor(named: "main")
        
        center.delegate = self
        // Validação de permissão de acesso a notificação
        center.getNotificationSettings { (settings) in
            if settings.authorizationStatus == .notDetermined {
                let options: UNAuthorizationOptions = [.alert, .sound, .badge, .carPlay] // Array com as permissões que seram solicitadas acesso.
                
                // Requisita autorização para o usuário
                self.center.requestAuthorization(options: options) { (success, error) in
                    if error == nil {
                        print(success)
                    } else {
                        print(error?.localizedDescription)
                    }
                }
            } else if settings.authorizationStatus == .denied {
                // implementar alerta, e redirecionamento para tela configurações para liberar permissões
                print("Usuário negou a permissão de acesso a notificações")
            }
        }
        
        // Opções de notificações
        // .authenticationRequired: Tela tem que estar desbloqueada
        // .destructive: aparecerá em vermelho, ação destrutiva
        // .foreground:  segnifica que vai trazer o app para frente
        
        
        
        let confirmAction = UNNotificationAction(identifier: "Confirm", title: "Já estudei 👍", options: [.foreground])
        let cancelAction = UNNotificationAction(identifier: "Cancel", title: "Cancelar", options: [])
        
        let category = UNNotificationCategory(identifier: "Lembrete", actions: [confirmAction, cancelAction], intentIdentifiers: [], hiddenPreviewsBodyPlaceholder: "", options: [.customDismissAction])
        
        center.setNotificationCategories([category])
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate {
    // para mostrar a notificação mesmo que o usuário esteja no App (ios 10 ou superior)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound]) // Dispera uma notificação e o som.
    }
    
    // Disparado toda vez que o usuário recebe a notificação e captura a ação que o usuário tomou
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("AQUIIII: didReceive response")
        
        // através do response se tem acesso a todos dados da notificaação
        // response.notification.request.content.title
        
        let id = response.notification.request.identifier
        print("identifier da notiticação: ", id)
        
        // Validando o identifier da notificação
        switch response.actionIdentifier {
            case "Confirm":
                print("Usuário confirmou que já estudou a matéria")
            case "Cancel":
                print("Usuário cancelou")
            case UNNotificationDefaultActionIdentifier:
                print("Tocou na Notificação")
            case UNNotificationDismissActionIdentifier:
                print("Dismiss na notificação, jogou pro lado")
            default:
                break
        }
        completionHandler()
    }
}
