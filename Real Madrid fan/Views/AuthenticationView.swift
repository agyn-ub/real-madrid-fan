//
//  AuthenticationView.swift
//  Real Madrid fan
//
//  Created by Assistant on 30.09.2025.
//

import SwiftUI
import AuthenticationServices

struct AuthenticationView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    @Environment(\.dismiss) var dismiss
    @State private var isSigningIn = false
    
    var body: some View {
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
                        dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title)
                            .foregroundColor(.white.opacity(0.7))
                    }
                }
                .padding(.horizontal)
                .padding(.top, 20)
                
                VStack(spacing: 30) {
                    Image(systemName: "crown.fill")
                        .font(.system(size: 80))
                        .foregroundColor(Color(red: 1.0, green: 0.84, blue: 0.0))
                        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                    
                    VStack(spacing: 15) {
                        Text("Welcome to")
                            .font(.title2)
                            .foregroundColor(.white.opacity(0.9))
                        
                        Text("Real Madrid")
                            .font(.system(size: 45, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text("Fan Quiz")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(red: 1.0, green: 0.84, blue: 0.0))
                    }
                    
                    Text("Sign in to play the quiz and test your Real Madrid knowledge")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white.opacity(0.8))
                        .padding(.horizontal, 40)
                }
                
                Spacer()
                
                VStack(spacing: 20) {
                    if isSigningIn {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(1.5)
                            .padding()
                    } else {
                        Button(action: {
                            isSigningIn = true
                            Task {
                                await authManager.signInWithApple()
                                isSigningIn = false
                            }
                        }) {
                            HStack {
                                Image(systemName: "applelogo")
                                    .font(.title2)
                                Text("Sign in with Apple")
                                    .font(.headline)
                            }
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                        }
                        .padding(.horizontal, 40)
                    }
                    
                    if let errorMessage = authManager.errorMessage {
                        Text(errorMessage)
                            .font(.caption)
                            .foregroundColor(.red)
                            .padding(.horizontal)
                            .multilineTextAlignment(.center)
                    }
                }
                
                VStack(spacing: 10) {
                    Text("¡Hala Madrid y nada más!")
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.8))
                    
                    Text("Join the greatest club's fan community")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.6))
                }
                .padding(.bottom, 30)
            }
        }
        .onReceive(authManager.$isAuthenticated) { isAuthenticated in
            if isAuthenticated {
                dismiss()
            }
        }
    }
}

#Preview {
    AuthenticationView()
        .environmentObject(AuthenticationManager())
}