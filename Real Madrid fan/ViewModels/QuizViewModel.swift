//
//  QuizViewModel.swift
//  Real Madrid fan
//
//  Created by Agyn Bolatov on 30.09.2025.
//

import Foundation
import SwiftUI

class QuizViewModel: ObservableObject {
    
    @Published var questions: [Question] = []
    @Published var currentQuestionIndex = 0
    @Published var selectedAnswer: Int? = nil
    @Published var userAnswers: [Int?] = []
    @Published var showingResults = false
    @Published var score = 0
    @Published var isAnswerSubmitted = false
    
    var currentQuestion: Question? {
        guard currentQuestionIndex < questions.count else { return nil }
        return questions[currentQuestionIndex]
    }
    
    var progress: Double {
        guard !questions.isEmpty else { return 0 }
        return Double(currentQuestionIndex + 1) / Double(questions.count)
    }
    
    var questionNumber: Int {
        return currentQuestionIndex + 1
    }
    
    var totalQuestions: Int {
        return questions.count
    }
    
    init() {
        loadQuestions()
    }
    
    func loadQuestions() {
        questions = Question.sampleQuestions.shuffled()
        userAnswers = Array(repeating: nil, count: questions.count)
        currentQuestionIndex = 0
        score = 0
        showingResults = false
        isAnswerSubmitted = false
        selectedAnswer = nil
    }
    
    func selectAnswer(_ index: Int) {
        if !isAnswerSubmitted {
            selectedAnswer = index
        }
    }
    
    func submitAnswer() {
        guard let selectedAnswer = selectedAnswer else { return }
        
        isAnswerSubmitted = true
        userAnswers[currentQuestionIndex] = selectedAnswer
        
        if selectedAnswer == currentQuestion?.correctAnswer {
            score += 1
        }
    }
    
    func nextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            selectedAnswer = nil
            isAnswerSubmitted = false
        } else {
            showingResults = true
        }
    }
    
    func restartQuiz() {
        loadQuestions()
    }
    
    func isAnswerCorrect(_ index: Int) -> Bool? {
        guard isAnswerSubmitted else { return nil }
        return index == currentQuestion?.correctAnswer
    }
    
    func isAnswerWrong(_ index: Int) -> Bool? {
        guard isAnswerSubmitted, let selected = selectedAnswer else { return nil }
        return index == selected && index != currentQuestion?.correctAnswer
    }
    
    var scorePercentage: Int {
        guard !questions.isEmpty else { return 0 }
        return Int((Double(score) / Double(questions.count)) * 100)
    }
    
    var resultMessage: String {
        let percentage = scorePercentage
        switch percentage {
        case 90...100:
            return "¡Hala Madrid! You're a true Madridista!"
        case 70..<90:
            return "Great job! You know your Real Madrid history well!"
        case 50..<70:
            return "Good effort! Keep learning about Los Blancos!"
        case 30..<50:
            return "Not bad! Time to brush up on your Real Madrid knowledge!"
        default:
            return "Keep trying! Every Madridista starts somewhere!"
        }
    }
}