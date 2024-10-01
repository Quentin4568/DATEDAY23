//
//  AppDelegate.swift
//  DateDay
//
//  Created by Quentin Derouard on 14/05/2024.
//

import UIKit
import Firebase
import GoogleSignIn
import AuthenticationServices
import UserNotifications

class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Configuration de Firebase
        FirebaseApp.configure()

        // Configuration de Google Sign-In avec le clientID de Firebase
        GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: FirebaseApp.app()?.options.clientID ?? "")

        // Configuration des notifications
        UNUserNotificationCenter.current().delegate = self

        // Demander l'autorisation des notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Erreur lors de la demande d'autorisation des notifications : \(error.localizedDescription)")
            }
        }

        // Enregistrer l'application pour les notifications distantes
        application.registerForRemoteNotifications()

        return true
    }

    // Méthode appelée lors de l'enregistrement des notifications distantes
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Auth.auth().setAPNSToken(deviceToken, type: .unknown)
    }

    // Méthode pour gérer les notifications distantes reçues
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if Auth.auth().canHandleNotification(userInfo) {
            completionHandler(.noData)
            return
        }
        // Gérer les autres notifications ici si nécessaire
        completionHandler(.newData)
    }

    // Gérer le retour de l'URL pour Google Sign-In (iOS 9+)
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }

    // Gérer le retour de l'URL pour Google Sign-In (iOS plus ancien)
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }

    // iOS 10+ Méthode pour recevoir les notifications pendant que l'application est active
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        if Auth.auth().canHandleNotification(userInfo) {
            completionHandler([])
            return
        }
        // Afficher l'alerte, le son et le badge pour les notifications entrantes
        completionHandler([.alert, .sound, .badge])
    }
}
