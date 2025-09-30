//
//  ContentView.swift
//  Real Madrid fan
//
//  Created by Agyn Bolatov on 30.09.2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    @State private var showQuiz = false
    @State private var showProfile = false
    @State private var showAuthentication = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.0, green: 0.15, blue: 0.5),
                        Color(red: 0.0, green: 0.1, blue: 0.3)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 40) {
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            if authManager.isAuthenticated {
                                showProfile = true
                            } else {
                                showAuthentication = true
                            }
                        }) {
                            if authManager.isAuthenticated {
                                ZStack {
                                    Circle()
                                        .fill(Color.white.opacity(0.2))
                                        .frame(width: 40, height: 40)
                                    
                                    Text(authManager.user?.initials ?? "RM")
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundColor(.white)
                                }
                            } else {
                                Image(systemName: "person.circle")
                                    .font(.system(size: 30))
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                    
                    VStack(spacing: 20) {
                        Image(systemName: "sportscourt.fill")
                            .font(.system(size: 80))
                            .foregroundColor(.white)
                        
                        Text("Real Madrid")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text("Fan Quiz")
                            .font(.title2)
                            .foregroundColor(Color(red: 1.0, green: 0.84, blue: 0.0))
                    }
                    
                    VStack(spacing: 15) {
                        if let user = authManager.user {
                            Text("Welcome back, \(user.displayNameOrEmail)!")
                                .font(.body)
                                .foregroundColor(.white.opacity(0.9))
                        } else {
                            Text("Test your knowledge about")
                                .font(.body)
                                .foregroundColor(.white.opacity(0.9))
                        }
                        
                        Text("Los Blancos")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(red: 1.0, green: 0.84, blue: 0.0))
                        
                        Text("15 questions about the greatest club in football history")
                            .font(.caption)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white.opacity(0.7))
                            .padding(.horizontal, 40)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        showQuiz = true
                    }) {
                        HStack {
                            Image(systemName: "play.fill")
                                .font(.title2)
                            Text("Start Quiz")
                                .font(.title2)
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(Color(red: 0.0, green: 0.15, blue: 0.5))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(red: 1.0, green: 0.84, blue: 0.0),
                                    Color(red: 0.95, green: 0.7, blue: 0.0)
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
                    }
                    .padding(.horizontal, 40)
                    
                    Text("¡Hala Madrid!")
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.8))
                        .padding(.bottom, 30)
                }
                .padding(.top, authManager.isAuthenticated ? 0 : 60)
            }
            .fullScreenCover(isPresented: $showQuiz) {
                QuizView()
            }
            .fullScreenCover(isPresented: $showProfile) {
                ProfileView()
                    .environmentObject(authManager)
            }
            .fullScreenCover(isPresented: $showAuthentication) {
                AuthenticationView()
                    .environmentObject(authManager)
            }
        }
    }
}

#Preview {
    ContentView()
}
