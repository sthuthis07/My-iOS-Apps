//
//  IndexView.swift
//  My-iOS-Apps
//
//  Created by Sthuthi S on 24/10/25.
//

import SwiftUI

struct IndexView: View {
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                    ForEach(currentApps) { app in
                        NavigationLink(destination: TimerView()) {
                            VStack {
                                Image(app.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(.blue)
                                Text(app.name)
                                    .font(.headline)
                                    .foregroundColor(Color(.secondaryLabel))
                            }
                            .frame(width: 150, height: 150)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Apps")
        }
    }
}

#Preview {
    IndexView()
}
