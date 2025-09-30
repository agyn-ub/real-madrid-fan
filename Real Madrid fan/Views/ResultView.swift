//
//  ResultView.swift
//  Real Madrid fan
//
//  Created by Agyn Bolatov on 30.09.2025.
//

import SwiftUI

struct ResultView: View {
    @ObservedObject var viewModel: QuizViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                VStack(spacing: 20) {
                    Image(systemName: getTrophyIcon())
                        .font(.system(size: 80))
                        .foregroundColor(getTrophyColor())
                    
                    Text("Quiz Completed!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.0, green: 0.15, blue: 0.5))
                    
                    Text(viewModel.resultMessage)
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                }
                
                VStack(spacing: 25) {
                    ScoreCard(
                        score: viewModel.score,
                        total: viewModel.totalQuestions,
                        percentage: viewModel.scorePercentage
                    )
                    
                    VStack(spacing: 15) {
                        StatRow(
                            icon: "checkmark.circle.fill",
                            label: "Correct Answers",
                            value: "\(viewModel.score)",
                            color: .green
                        )
                        
                        StatRow(
                            icon: "xmark.circle.fill",
                            label: "Wrong Answers",
                            value: "\(viewModel.totalQuestions - viewModel.score)",
                            color: .red
                        )
                        
                        StatRow(
                            icon: "percent",
                            label: "Accuracy",
                            value: "\(viewModel.scorePercentage)%",
                            color: Color(red: 0.0, green: 0.15, blue: 0.5)
                        )
                    }
                    .padding(.horizontal)
                }
                
                Button(action: {
                    viewModel.restartQuiz()
                }) {
                    Text("Play Again")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(red: 0.0, green: 0.15, blue: 0.5),
                                    Color(red: 0.0, green: 0.2, blue: 0.6)
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                }
                .padding(.horizontal)
                .padding(.top, 10)
            }
            .padding(.vertical, 30)
        }
    }
    
    func getTrophyIcon() -> String {
        let percentage = viewModel.scorePercentage
        switch percentage {
        case 90...100:
            return "trophy.fill"
        case 70..<90:
            return "medal.fill"
        case 50..<70:
            return "star.fill"
        default:
            return "flag.fill"
        }
    }
    
    func getTrophyColor() -> Color {
        let percentage = viewModel.scorePercentage
        switch percentage {
        case 90...100:
            return Color(red: 1.0, green: 0.84, blue: 0.0)
        case 70..<90:
            return Color.gray
        case 50..<70:
            return Color(red: 0.8, green: 0.5, blue: 0.2)
        default:
            return Color.blue
        }
    }
}

struct ScoreCard: View {
    let score: Int
    let total: Int
    let percentage: Int
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Your Score")
                .font(.headline)
                .foregroundColor(.gray)
            
            HStack(alignment: .bottom, spacing: 5) {
                Text("\(score)")
                    .font(.system(size: 60, weight: .bold))
                    .foregroundColor(Color(red: 0.0, green: 0.15, blue: 0.5))
                
                Text("/ \(total)")
                    .font(.title)
                    .foregroundColor(.gray)
            }
            
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 15)
                    .frame(width: 150, height: 150)
                
                Circle()
                    .trim(from: 0, to: CGFloat(percentage) / 100)
                    .stroke(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color(red: 1.0, green: 0.84, blue: 0.0),
                                Color(red: 0.95, green: 0.7, blue: 0.0)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        style: StrokeStyle(lineWidth: 15, lineCap: .round)
                    )
                    .frame(width: 150, height: 150)
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut(duration: 1), value: percentage)
                
                VStack {
                    Text("\(percentage)%")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(Color(red: 0.0, green: 0.15, blue: 0.5))
                    Text("Accuracy")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .padding(.top, 20)
        }
    }
}

struct StatRow: View {
    let icon: String
    let label: String
    let value: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.title2)
                .frame(width: 30)
            
            Text(label)
                .font(.body)
                .foregroundColor(.gray)
            
            Spacer()
            
            Text(value)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.2))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
        )
    }
}

#Preview {
    ResultView(viewModel: QuizViewModel())
}