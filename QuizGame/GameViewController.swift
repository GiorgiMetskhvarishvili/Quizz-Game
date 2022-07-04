//
//  GameViewController.swift
//  QuizGame
//
//  Created by Gi Oo on 07.06.22.
//

import UIKit

class GameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    var gameMododels = [Question]()
    var currentQuestion: Question?
    
    
    @IBOutlet var label: UILabel!
    @IBOutlet var table: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        setupQuestions()
        configueUI(question: gameMododels.first!)
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//    }
//    
    private func configueUI(question: Question) {
        label.text = question.text
        currentQuestion = question
        table.reloadData()    }

    private func checkAnswer(answer: Answer, question: Question) -> Bool {
        return question.answers.contains(where: {  $0.text == answer.text }) && answer.correct
    }

    private func setupQuestions() {
        gameMododels.append(Question(text: "What is 2 + 2 ", answers:[
        Answer(text: "1", correct: false),
        Answer(text: "4", correct: true),
        Answer(text: "2", correct: false),
        Answer(text: "3", correct: false),
        ]))
        
        gameMododels.append(Question(text: "What is 2 + 10 ", answers:[
        Answer(text: "12", correct: true),
        Answer(text: "8", correct: false),
        Answer(text: "14", correct: false),
        Answer(text: "7", correct: false),
        ]))
        
        gameMododels.append(Question(text: "What is 2 + 0 ", answers:[
        Answer(text: "1", correct: false),
        Answer(text: "4", correct: false),
        Answer(text: "2", correct: true),
        Answer(text: "3", correct: false),
        ]))
    }
    
    //Table view Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentQuestion?.answers.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = currentQuestion?.answers[indexPath.row].text
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let question = currentQuestion else {
            return
        }
        
        let answer = question.answers[indexPath.row]
        if  checkAnswer(answer: answer, question: question) {
            //correct
            if let index = gameMododels.firstIndex(where: {  $0.text == question.text}) {
                if index < (gameMododels.count - 1) {
                    //next qeustion
                    let nextQuestion = gameMododels[index+1]
                    currentQuestion = nil
                    configueUI(question: nextQuestion)
                }
                else {
                    //end of game
                    let alert = UIAlertController(title: "Done", message: "You beat the game", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                    present(alert, animated: true)
                    
                }
            }
            
        }
        else {
            // wrong
            let alert = UIAlertController(title: "Wrong", message: "You are dumb", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
        }
    }
    
}


struct Question {
    let text : String
    let answers: [Answer]
}

struct Answer {
    let text: String
    let correct: Bool // true / false
}
