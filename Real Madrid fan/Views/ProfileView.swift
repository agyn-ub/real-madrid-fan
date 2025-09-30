//
//  ProfileView.swift
//  Real Madrid fan
//
//  Created by Assistant on 30.09.2025.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    @Environment(\.dismiss) var dismiss
    @State private var showingSignOutAlert = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.98, green: 0.98, blue: 1.0),
                        Color(red: 0.95, green: 0.95, blue: 0.98)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    Spacer()
                    
                    ProfileHeader(user: authManager.user)
                    
                    Spacer()
                    
                    SignOutButton(showingAlert: $showingSignOutAlert)
                        .padding(.horizontal)
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(Color(red: 0.0, green: 0.15, blue: 0.5))
                }
            }
        }
        .alert("Sign Out", isPresented: $showingSignOutAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Sign Out", role: .destructive) {
                Task {
                    await authManager.signOut()
                    dismiss()
                }
            }
        } message: {
            Text("Are you sure you want to sign out?")
        }
    }
}

struct ProfileHeader: View {
    let user: User?
    
    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color(red: 0.0, green: 0.15, blue: 0.5),
                                Color(red: 0.0, green: 0.2, blue: 0.6)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 120, height: 120)
                
                Text(user?.initials ?? "RM")
                    .font(.system(size: 42, weight: .bold))
                    .foregroundColor(.white)
            }
            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
            
            VStack(spacing: 8) {
                Text(user?.displayNameOrEmail ?? "Madridista")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.0, green: 0.15, blue: 0.5))
                
                if let email = user?.email {
                    Text(email)
                        .font(.body)
                        .foregroundColor(.gray)
                }
                
                HStack {
                    Image(systemName: "crown.fill")
                        .font(.caption)
                        .foregroundColor(Color(red: 1.0, green: 0.84, blue: 0.0))
                    Text("Real Madrid Fan")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.top, 5)
            }
        }
    }
}

struct SignOutButton: View {
    @Binding var showingAlert: Bool
    
    var body: some View {
        Button(action: {
            showingAlert = true
        }) {
            HStack {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .font(.body)
                Text("Sign Out")
                    .fontWeight(.medium)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.red.opacity(0.8),
                        Color.red.opacity(0.6)
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(12)
            .shadow(color: .red.opacity(0.3), radius: 5, x: 0, y: 3)
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(AuthenticationManager())
}