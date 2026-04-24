//
//  QuizScreen.swift
//  Faunex
//
//  Created by Student on 23/04/2026.
//

// Reference: https://developer.apple.com/documentation/swiftui/state
// Reference: https://developer.apple.com/documentation/swiftui/view

struct Question {
    let text: String
    let answers: [String]
    let correctIndex: Int
}

import SwiftUI

struct QuizScreen: View {
    
    private let questions: [Question] = [
        Question(
            text: "Which animal is critically endangered?",
            answers: ["African Elephant", "Amur Leopard", "House Cat", "Grey Wolf"],
            correctIndex: 1
        ),
        Question(
            text: "Where does the Vaquita live?",
            answers: ["Arctic Ocean", "Gulf of California", "Indian Ocean", "Amazon River"],
            correctIndex: 1
        ),
        Question(
            text: "Which big cat has fewer than 100 individuals left in the wild?",
            answers: ["Tiger", "Snow Leopard", "Amur Leopard", "Lion"],
            correctIndex: 2
        ),
        Question(
            text: "What is the main threat to sea turtles?",
            answers: ["Volcanoes", "Plastic pollution", "Snowstorms", "Lightning"],
            correctIndex: 1
        ),
        Question(
            text: "Which animal is NOT extinct but highly endangered?",
            answers: ["Dodo", "Sumatran Rhino", "Mammoth", "Saber-tooth Tiger"],
            correctIndex: 1
        )
    ]
    
    @State private var currentIndex = 0
    @State private var score = 0
    @State private var showResult = false
    
    var body: some View {
        VStack(spacing: 20) {
            
            if showResult {
                VStack(spacing: 15) {
                    Text("Quiz Complete!")
                        .font(.largeTitle)
                        .bold()
                    
                    Text("You scored \(score) / \(questions.count)")
                        .font(.title2)
                    
                    Button("Restart Quiz") {
                        restartQuiz()
                    }
                    .buttonStyle(.borderedProminent)
                }
            } else {
                
                let question = questions[currentIndex]
                
                Text(question.text)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding()
                
                ForEach(0..<question.answers.count, id: \.self) { index in
                    Button(question.answers[index]) {
                        answerTapped(index)
                    }
                    .buttonStyle(.bordered)
                    .padding(.horizontal)
                }
                
                Text("Question \(currentIndex + 1) / \(questions.count)")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.top)
            }
        }
        .padding()
    }
    
    private func answerTapped(_ index: Int) {
        if index == questions[currentIndex].correctIndex {
            score += 1
        }
        
        if currentIndex + 1 < questions.count {
            currentIndex += 1
        } else {
            showResult = true
        }
    }
    
    private func restartQuiz() {
        currentIndex = 0
        score = 0
        showResult = false
    }
}
