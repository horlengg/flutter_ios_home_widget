//
//  AppIntent.swift
//  DemoWidget
//
//  Created by ly.houleng on 9/8/25.
//

import AppIntents
import Foundation
import home_widget



@available(iOS 17, *)
@available(iOSApplicationExtension, unavailable)
extension BackgroundIntent: ForegroundContinuableIntent {}


@available(iOS 17, *)
public struct BackgroundIntent: AppIntent {
   static public var title: LocalizedStringResource = "HomeWidget Background Intent"


    @Parameter(title: "Method")
    var method: String

    public init() {
        method = "increment"
      }

      public init(method: String) {
        self.method = method
      }


   public func perform() async throws -> some IntentResult {
      await HomeWidgetBackgroundWorker.run(
        url: URL(string: "apdbankwidget://\(method)"),
        appGroup: "group.lenghomewidget"
      )
       return .result()
   }
}
