//
//  AppDelegate.swift
//  Dual Temp
//
//  Created by Ben Gauger on 10/19/22.
//

import UIKit
import BackgroundTasks

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let appRefreshTaskId = "com.bengauger.refresh"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("background")
        registerBackgroundTasks()
        
        return true
    }
    
    func registerBackgroundTasks() {
        BGTaskScheduler.shared.register(forTaskWithIdentifier: appRefreshTaskId, using: nil) { task in
            task.setTaskCompleted(success: true)
            print("scheduled in background")
            self.handleAppRefreshTask(task: task as! BGAppRefreshTask)
        }
    }
    
    func handleAppRefreshTask(task: BGAppRefreshTask) {
        
        scheduleAppRefresh()
        scheduleBackgroundProcessing()
        
        
        task.expirationHandler = {
            print("Background Working")
            task.setTaskCompleted(success: true)
        }
    }
    
    func scheduleAppRefresh() {
        let request = BGAppRefreshTaskRequest(identifier: appRefreshTaskId)
        
        request.earliestBeginDate = Date(timeIntervalSinceNow: 15*60)
        
        do{
            try BGTaskScheduler.shared.submit(request)
        }catch{
            print("Could not schedule app refresh task \(error.localizedDescription)")
        }
    }
    
    func scheduleBackgroundProcessing() {
        let request = BGProcessingTaskRequest(identifier: appRefreshTaskId)
        request.requiresNetworkConnectivity = true
        request.requiresExternalPower = false
        
        request.earliestBeginDate = Date(timeIntervalSinceNow: 15*60)
        
        do{
            try BGTaskScheduler.shared.submit(request)
        }catch{
            print("Could not schedule app refresh task \(error.localizedDescription)")
        }
    }
    
    func cancelAllPendingBGTask() {
        BGTaskScheduler.shared.cancelAllTaskRequests()
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        self.cancelAllPendingBGTask()
        self.scheduleAppRefresh()
        self.scheduleBackgroundProcessing()
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as! AppDelegate).scheduleAppRefresh()
        print("called")
    }
    
}



