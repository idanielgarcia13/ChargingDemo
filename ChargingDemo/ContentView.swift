//
//  ContentView.swift
//  ChargingDemo
//
//  Created by Daniel Garcia on 2/4/21.
//

import SwiftUI
import UIKit

struct ContentView: View {
    
    @State var batteryState: String = "Retrieving..."
    
    var body: some View {
        NavigationView {
            Text("Status: \(batteryState)")
                .padding()
                .navigationBarTitle("Battery Status")
                .navigationBarItems(trailing:
                    Button(action: {
                        checkChargingState()
                    }) {
                        Image(systemName: "arrow.counterclockwise")
                    }
                )
        }.onAppear(perform: {
            checkChargingState()
        })
    }
    
    private func checkChargingState() {
        // Allows the app to be notified of changes to the battery state
        UIDevice.current.isBatteryMonitoringEnabled = true
        
        // Retrieves the battery percentage
        let deviceBatteryLevel = Int(UIDevice.current.batteryLevel * 100)
        
        switch UIDevice.current.batteryState {
            case .unknown:
              batteryState = "Unknown"
            case .charging:
              batteryState = "Charging at \(deviceBatteryLevel)%"
            case .full:
              batteryState = "Full at \(deviceBatteryLevel)%"
            case .unplugged:
              batteryState = "Unplugged at \(deviceBatteryLevel)%"
        @unknown default:
            batteryState = "Error."
            fatalError()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
