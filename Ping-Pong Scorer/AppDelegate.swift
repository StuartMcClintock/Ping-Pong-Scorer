//
//  AppDelegate.swift
//  Ping-Pong Scorer
//
//  Created by Stuart McClintock on 12/15/19.
//  Copyright © 2019 Stuart McClintock. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

   var window: UIWindow?
   var defVals: UserDefaults!


   enum ServeChangeType{
      case everyTwoScores
      case winnerServes
      case loserServes
   }

   func serveChangeToInt(s: ServeChangeType) -> Int{
      switch s{
      case .everyTwoScores:
         return 1
      case .winnerServes:
         return 2
      case .loserServes:
         return 3
      }
   }

   func intToServeChange(num: Int) -> ServeChangeType{
      switch num{
      case 2:
         return .winnerServes
      case 3:
         return .loserServes
      default:
         return .everyTwoScores
      }
   }

   private var serveChange: ServeChangeType!
   private var winningScore: Int!
   private var mustBeAheadBy2: Bool!
   var selectedServe: [Bool]!

   func setServeChange(val: Int){
      serveChange = intToServeChange(num: val)
      defVals.set(val, forKey:"serveChange")
   }

   func getServeChange() -> ServeChangeType{
      return serveChange
   }

   func setMustBeAheadBy2(val: Bool){
      mustBeAheadBy2=val
      defVals.set(!val, forKey: "opposite of mustBeAheadBy2")
   }
   func getMustBeAheadBy2() -> Bool{
      return mustBeAheadBy2
   }

   func setWinningScore(score: Int){
      winningScore = score
      defVals.set(winningScore, forKey: "winningScore")
   }
   func getWinningScore() -> Int{
      return winningScore
   }

   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      // Override point for customization after application launch.
      defVals = UserDefaults.standard
      let storedWS: Int = defVals.integer(forKey: "winningScore")
      if storedWS == 0{
         winningScore = 11
      }
      else{
         winningScore = storedWS
      }

      let storedSC: Int = defVals.integer(forKey:"serveChange")
      if storedWS == 0{
         serveChange = .everyTwoScores
      }
      else{
         serveChange = intToServeChange(num: storedSC)
      }

      let storedAhead: Bool = !defVals.bool(forKey: "opposite of mustBeAheadBy2")
      mustBeAheadBy2 = storedAhead


      selectedServe = [false, false, false]
      selectedServe[serveChangeToInt(s: serveChange)-1] = true

      defVals.set(winningScore, forKey: "winningScore")
      defVals.set(serveChangeToInt(s: serveChange), forKey:"serveChange")
      defVals.set(!mustBeAheadBy2, forKey:"opposite of mustBeAheadBy2")//opposite is taken because we want default value to be true

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

