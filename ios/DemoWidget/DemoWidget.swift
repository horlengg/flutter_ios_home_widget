//
//  DemoWidget.swift
//  DemoWidget
//
//  Created by ly.houleng on 9/8/25.
//

import WidgetKit
import SwiftUI

// Timeline entry with date and message
struct SimpleEntry: TimelineEntry {
    let date: Date
    let message: String
}

// Timeline provider that supplies entries
struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), message: "Placeholder")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = SimpleEntry(date: Date(), message: "Snapshot")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        let entries = [
            SimpleEntry(date: Date(), message: "Hello from widget!")
        ]
        let timeline = Timeline(entries: entries, policy: .never)
        completion(timeline)
    }
}

// The widget view with tap URL
struct DemoWidgetEntryView : View {
    var entry: SimpleEntry

    var body: some View {
        VStack {
            
            HStack {
//                Button(
//                   intent: BackgroundIntent(
//                     url: URL(string: "apdbank://scan_qr_func"))
//                 ) {
//                     Text("Scan QR")
//                 }.buttonStyle(.bordered)
//                
//                Button(
//                   intent: BackgroundIntent(
//                     url: URL(string: "apdbank://generate_qr_func"))
//                 ) {
//                   Text("Scan QR")
//                 }.buttonStyle(.bordered)
                
//                Text("Button 1")
//                    .background(.green)
//                    .widgetURL(URL(string: "apdbankhomewidget://message?message=button_1&homeWidget"))
//                
//                Text("Button 2")
//                    .background(.green)
//                    .widgetURL(URL(string: "apdbankhomewidget://message?message=button_2&homeWidget"))
                
                Link(destination: URL(string: "apdbankhomewidget://func_show_qr?homeWidget")!) {
                    Text("Show QR")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.green)
                        .cornerRadius(6)
                }

                Link(destination: URL(string: "apdbankhomewidget://func_scan_qr?homeWidget")!) {
                    Text("Scan QR")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.green)
                        .cornerRadius(6)
                }
            }
        }
        
        
    }
}


struct DemoWidget: Widget {
    let kind: String = "DemoWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                DemoWidgetEntryView(entry: entry)
                    .containerBackground(Color.white, for: .widget)
            } else {
                DemoWidgetEntryView(entry: entry)
                    .padding()
                    .background(Color.white)
            }
        }
        .configurationDisplayName("APD Home Widget")
        .description("Display QR Code and Scan QR Function")
        .supportedFamilies([.systemMedium])
    }
}

// Preview for Xcode canvas
struct DemoWidget_Previews: PreviewProvider {
    static var previews: some View {
        DemoWidgetEntryView(entry: SimpleEntry(date: Date(), message: "Preview"))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
