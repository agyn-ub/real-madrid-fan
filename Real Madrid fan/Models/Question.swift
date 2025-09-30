//
//  Question.swift
//  Real Madrid fan
//
//  Created by Agyn Bolatov on 30.09.2025.
//

import Foundation

struct Question: Identifiable {
    let id = UUID()
    let text: String
    let options: [String]
    let correctAnswer: Int
    
    static let sampleQuestions: [Question] = [
        Question(
            text: "In which year was Real Madrid founded?",
            options: ["1895", "1902", "1910", "1920"],
            correctAnswer: 1
        ),
        Question(
            text: "How many UEFA Champions League titles has Real Madrid won as of 2024?",
            options: ["10", "12", "14", "15"],
            correctAnswer: 2
        ),
        Question(
            text: "Who is Real Madrid's all-time top scorer?",
            options: ["Raúl", "Alfredo Di Stéfano", "Karim Benzema", "Cristiano Ronaldo"],
            correctAnswer: 3
        ),
        Question(
            text: "What is the name of Real Madrid's stadium?",
            options: ["Camp Nou", "Santiago Bernabéu", "Wanda Metropolitano", "Mestalla"],
            correctAnswer: 1
        ),
        Question(
            text: "Which player has won the most Ballon d'Or awards while playing for Real Madrid?",
            options: ["Zinedine Zidane", "Ronaldinho", "Cristiano Ronaldo", "Luka Modrić"],
            correctAnswer: 2
        ),
        Question(
            text: "Who was Real Madrid's manager during 'La Décima' (10th Champions League)?",
            options: ["José Mourinho", "Carlo Ancelotti", "Zinedine Zidane", "Rafael Benítez"],
            correctAnswer: 1
        ),
        Question(
            text: "What is Real Madrid's nickname?",
            options: ["Los Blancos", "Los Azules", "Los Rojos", "Los Amarillos"],
            correctAnswer: 0
        ),
        Question(
            text: "Which year did Real Madrid complete the first 'Galácticos' era signing of Luís Figo?",
            options: ["1998", "2000", "2002", "2004"],
            correctAnswer: 1
        ),
        Question(
            text: "How many La Liga titles has Real Madrid won (as of 2024)?",
            options: ["30", "33", "35", "36"],
            correctAnswer: 3
        ),
        Question(
            text: "Which player scored the winning goal in the 2014 Champions League final?",
            options: ["Sergio Ramos", "Gareth Bale", "Cristiano Ronaldo", "Ángel Di María"],
            correctAnswer: 1
        ),
        Question(
            text: "Who is known as 'El Capitán' and played for Real Madrid from 2005 to 2021?",
            options: ["Iker Casillas", "Sergio Ramos", "Marcelo", "Karim Benzema"],
            correctAnswer: 1
        ),
        Question(
            text: "What year did Real Madrid win their first European Cup?",
            options: ["1950", "1956", "1960", "1965"],
            correctAnswer: 1
        ),
        Question(
            text: "Which legendary player wore the number 7 jersey before Cristiano Ronaldo?",
            options: ["Emilio Butragueño", "Raúl", "Fernando Morientes", "Iván Zamorano"],
            correctAnswer: 1
        ),
        Question(
            text: "Who scored a bicycle kick goal in the 2018 Champions League final?",
            options: ["Karim Benzema", "Sergio Ramos", "Gareth Bale", "Cristiano Ronaldo"],
            correctAnswer: 2
        ),
        Question(
            text: "Which club is considered Real Madrid's biggest rival?",
            options: ["Atlético Madrid", "Valencia", "Barcelona", "Sevilla"],
            correctAnswer: 2
        )
    ]
}