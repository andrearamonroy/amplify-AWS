//
//  AmplifyiOSApp.swift
//  AmplifyiOS
//
//  Created by Andrea Monroy on 3/22/23.
//
import AWSAPIPlugin
import Amplify
import AWSDataStorePlugin
import SwiftUI


@main
struct AmplifyiOSApp: App {
    
    init() {
        configureAmplify()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

func configureAmplify() {
    let apiPlugin = AWSAPIPlugin(modelRegistration: AmplifyModels())
    let dataStorePlugin = AWSDataStorePlugin(modelRegistration: AmplifyModels())
    do {
        try Amplify.add(plugin: apiPlugin)
        try Amplify.add(plugin: dataStorePlugin)
        try Amplify.configure()
        print("Initialized Amplify");
    } catch {
        // simplified error handling for the tutorial
        print("Could not initialize Amplify: \(error)")
    }
}
