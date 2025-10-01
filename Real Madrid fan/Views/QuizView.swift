//
//  QuizView.swift
//  Real Madrid fan
//
//  Created by Agyn Bolatov on 30.09.2025.
//

import SwiftUI

struct QuizView: View {
    @StateObject private var viewModel = QuizViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var showingQuitAlert = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color(red: 0.98, green: 0.98, blue: 1.0), Color(red: 0.95, green: 0.95, blue: 0.98)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                if viewModel.showingResults {
                    ResultView(viewModel: viewModel)
                } else if let question = viewModel.currentQuestion {
                    VStack(spacing: 20) {
                        ProgressBar(progress: viewModel.progress)
                            .padding(.horizontal)
                        
                        QuestionCounter(
                            current: viewModel.questionNumber,
                            total: viewModel.totalQuestions
                        )
                        
                        ScrollView {
                            VStack(spacing: 25) {
                                QuestionCard(question: question.text)
                                
                                VStack(spacing: 15) {
                                    ForEach(0..<question.options.count, id: \.self) { index in
                                        AnswerButton(
                                            text: question.options[index],
                                            label: String(Character(UnicodeScalar(65 + index)!)),
                                            isSelected: viewModel.selectedAnswer == index,
                                            isCorrect: viewModel.isAnswerCorrect(index),
                                            isWrong: viewModel.isAnswerWrong(index),
                                            action: {
                                                viewModel.selectAnswer(index)
                                            }
                                        )
                                    }
                                }
                                .padding(.horizontal)
                                
                                if !viewModel.isAnswerSubmitted {
                                    Button(action: {
                                        viewModel.submitAnswer()
                                    }) {
                                        Text("Submit Answer")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .frame(maxWidth: .infinity)
                                            .padding()
                                            .background(
                                                viewModel.selectedAnswer != nil
                                                ? Color(red: 0.0, green: 0.15, blue: 0.5)
                                                : Color.gray
                                            )
                                            .cornerRadius(12)
                                    }
                                    .disabled(viewModel.selectedAnswer == nil)
                                    .padding(.horizontal)
                                } else {
                                    Button(action: {
                                        viewModel.nextQuestion()
                                    }) {
                                        Text(viewModel.currentQuestionIndex < viewModel.questions.count - 1 ? "Next Question" : "See Results")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .frame(maxWidth: .infinity)
                                            .padding()
                                            .background(Color(red: 0.0, green: 0.15, blue: 0.5))
                                            .cornerRadius(12)
                                    }
                                    .padding(.horizontal)
                                }
                            }
                            .padding(.vertical)
                        }
                    }
                }
            }
            .navigationTitle("Real Madrid Quiz")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if !viewModel.showingResults {
                        Button(action: {
                            showingQuitAlert = true
                        }) {
                            HStack(spacing: 4) {
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                    .font(.caption)
                                Text("Quit")
                                    .font(.callout)
                                    .fontWeight(.medium)
                            }
                            .foregroundColor(.red)
                        }
                    }
                }
            }
            .alert("Quit Game", isPresented: $showingQuitAlert) {
                Button("Continue Playing", role: .cancel) {}
                Button("Quit", role: .destructive) {
                    dismiss()
                }
            } message: {
                Text("Are you sure you want to quit? Your progress will be lost.")
            }
        }
    }
}

struct ProgressBar: View {
    let progress: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 8)
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color(red: 1.0, green: 0.84, blue: 0.0),
                                Color(red: 0.95, green: 0.7, blue: 0.0)
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: geometry.size.width * progress, height: 8)
                    .animation(.easeInOut(duration: 0.3), value: progress)
            }
        }
        .frame(height: 8)
    }
}

struct QuestionCounter: View {
    let current: Int
    let total: Int
    
    var body: some View {
        HStack {
            Text("Question")
                .font(.subheadline)
                .foregroundColor(.gray)
            Text("\(current)")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(Color(red: 0.0, green: 0.15, blue: 0.5))
            Text("of \(total)")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

struct QuestionCard: View {
    let question: String
    
    var body: some View {
        VStack {
            Text(question)
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.2))
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                )
        }
        .padding(.horizontal)
    }
}

struct AnswerButton: View {
    let text: String
    let label: String
    let isSelected: Bool
    let isCorrect: Bool?
    let isWrong: Bool?
    let action: () -> Void
    
    var backgroundColor: Color {
        if let isCorrect = isCorrect, isCorrect {
            return Color.green.opacity(0.3)
        } else if let isWrong = isWrong, isWrong {
            return Color.red.opacity(0.3)
        } else if isSelected {
            return Color(red: 0.0, green: 0.15, blue: 0.5).opacity(0.2)
        } else {
            return Color.white
        }
    }
    
    var borderColor: Color {
        if let isCorrect = isCorrect, isCorrect {
            return Color.green
        } else if let isWrong = isWrong, isWrong {
            return Color.red
        } else if isSelected {
            return Color(red: 0.0, green: 0.15, blue: 0.5)
        } else {
            return Color.gray.opacity(0.3)
        }
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 15) {
                Text(label)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.0, green: 0.15, blue: 0.5))
                    .frame(width: 40, height: 40)
                    .background(
                        Circle()
                            .fill(Color(red: 0.95, green: 0.95, blue: 0.98))
                    )
                
                Text(text)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.2))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if let isCorrect = isCorrect, isCorrect {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .font(.title2)
                } else if let isWrong = isWrong, isWrong {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.red)
                        .font(.title2)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(backgroundColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(borderColor, lineWidth: 2)
                    )
            )
        }
        .disabled(isCorrect != nil || isWrong != nil)
    }
}

#Preview {
    QuizView()
}