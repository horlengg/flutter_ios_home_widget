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
    let counter: Int
}

// Timeline provider that supplies entries
struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        loadWidgetData()
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        completion(loadWidgetData())
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        let timeline = Timeline(entries: [loadWidgetData()], policy: .never)
        completion(timeline)
    }
    func loadWidgetData() -> SimpleEntry {
        let userDefaults = UserDefaults(suiteName: "group.lenghomewidget")
        let counter = userDefaults?.integer(forKey: "counter") ?? 0
        return SimpleEntry(date: Date(), counter: counter)
    }
}

// The widget view with tap URL
struct DemoWidgetEntryView : View {
    var entry: SimpleEntry

    var body: some View {
        VStack {
            
            HStack(alignment: .top) {
                
                VStack{
                    Text("Background work")
                        .font(.system(size: 14))
                        .foregroundColor(.green)
                    Spacer()
                        .frame(height: 20)
                    HStack {
                        Button(intent: BackgroundIntent(method: "decrement")) {
                            Image(systemName: "minus")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                                .frame(width: 40, height: 40)
                                .background(Circle().fill(Color.blue))
                        }
                        .buttonStyle(PlainButtonStyle())
                        Text("\(entry.counter)")
                            .font(.system(size: 30))
                        
                        Button(intent: BackgroundIntent(method: "increment")) {
                            Image(systemName: "plus")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                                .frame(width: 40, height: 40)
                                .background(Circle().fill(Color.blue))
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                Rectangle()
                    .frame(width: 1)   // thickness of the vertical line
                    .foregroundColor(.gray)  // line color
                    .frame(maxHeight: .infinity)
                    .opacity(0.4)
                
                VStack(alignment: .leading) {
                    Text("Detect widget click")
                        .font(.system(size: 14))
                        .foregroundColor(.green)
                    Spacer()
                        .frame(height: 20)
                    
                    HStack {
                        
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
        
    }
}

//
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

//// Preview for Xcode canvas
//struct DemoWidget_Previews: PreviewProvider {
//    static var previews: some View {
//        DemoWidgetEntryView(entry: SimpleEntry(date: Date(), message: "Preview"))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}

#Preview(as: .systemMedium) {
    DemoWidget()
} timeline: {
   SimpleEntry(date: .now, counter: 0)
}
