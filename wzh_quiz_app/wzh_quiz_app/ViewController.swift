//
//  ViewController.swift
//  wzh_quiz_app
//
//  Created by SD on 13/03/2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundLabel: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var orangeButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var showCategoryButton: UIButton!
    @IBOutlet weak var hideCategoryButton: UIButton!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var showButton: UIButton!
    @IBOutlet weak var hideAnswerButton: UIButton!
    
    // the array with all questions
    var quizQuestions: [QuizQuestion] = []
    var quizQuestionsCount = 0
    var categoryQuestions: [QuizQuestion] = []
    var categoryQuestionsCount = 0

    // Verbergt de knop "Verberg Categorieën"
    @IBAction func hideCategory(_ sender: Any) {
        redButton.isHidden = true
        orangeButton.isHidden = true
        yellowButton.isHidden = true
        greenButton.isHidden = true
        blueButton.isHidden = true
        hideCategoryButton.isHidden = true
        showCategoryButton.isHidden = false
    }
    
    // Toont de knop "Toon categorieën
    @IBAction func showCategory(_ sender: Any) {
        redButton.isHidden = false
        orangeButton.isHidden = false
        yellowButton.isHidden = false
        greenButton.isHidden = false
        blueButton.isHidden = false
        showCategoryButton.isHidden = true
        hideCategoryButton.isHidden = false
    }
    
    // Verbergt het antwoord
    @IBAction func hideAnswer(_ sender: Any) {
        answerLabel.isHidden = true
        showButton.isHidden = false
        hideAnswerButton.isHidden = true
    }
    
    // Toont het antwoord
    @IBAction func show(_ sender: Any) {
        answerLabel.isHidden = false
        hideAnswerButton.isHidden = false
        showButton.isHidden = true
    }
    
    // Gaat naar de volgende vraag
    @IBAction func next(_ sender: Any) {
        categoryQuestionsCount += 1
        quizQuestionsCount += 1
        showQuestion()
        hideAnswerButton.isHidden = true
        showButton.isHidden = false
    }
    
    // Laad alle functies die hierin zitten nadat de pagina ingeladen is
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getLocalQuizData()
        hideAnswerButton.isHidden = true
        showCategoryButton.isHidden = true
        questionLabel.text = "Kies een categorie aub"
    }


    // Haalt alle data uit de JSON
    func getLocalQuizData() {
        // Call readLocalFile function with the name of the local file (localQuizData)
        if let localData = self.readLocalFile(forName: "localQuizData") {
            // File exists, now parse 'localData' with the parse function
            self.parse(jsonData: localData)
            setupQuiz()
        }
    }
    
    // Informatie over de array voor de quiz
    func setupQuiz() {
        //Start hier met de quiz
        print("Quiz-data is binnen: \(quizQuestions[quizQuestionsCount])")
        
        categoryQuestionsCount = 0
        categoryQuestions = []
        answerLabel.isHidden = true
    }
    
    // Toont de vraag
    func showQuestion() {
        let question = categoryQuestions[categoryQuestionsCount]
        
        questionLabel.text = question.question
        answerLabel.text = question.answer
        answerLabel.isHidden = true
    }

    // Lees het JSON bestand in
    private func readLocalFile(forName name: String) -> Data? {
        do {
            // Check if file exists in application bundle, then try to convert it to a string, if that works return that
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error) // Something went wrong, show an alert
        }
        
        return nil
    }

    // Probeerd de data uit het JSON bestand om te zetten in objecten
    private func parse(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode([QuizQuestion].self,
                                                       from: jsonData)
//            questionLabel.text = "\(decodedData[quizQuestionsCount].question)"
//            answerLabel.text = "\(decodedData[quizQuestionsCount].answer)"
//            answerLabel.isHidden = true
//            print("===================================")
            
            self.quizQuestions = decodedData
        } catch {
            print("decode error")
        }
    }
    
    // Alle knoppen om de categorieën te kiezen
    @IBAction func didTapRedButton(_ sender: UIButton) {
        categoryQuestions = quizQuestions.filter({ $0.category == .red })
        showQuestion()
        redButton.isHidden = false
        orangeButton.isHidden = true
        yellowButton.isHidden = true
        greenButton.isHidden = true
        blueButton.isHidden = true
        hideCategoryButton.isHidden = true
        showCategoryButton.isHidden = false
        backgroundLabel.backgroundColor = .red
        questionLabel.textColor = .white
    }
    
    @IBAction func didTapBlueButton(_ sender: UIButton) {
        categoryQuestions = quizQuestions.filter({ $0.category == .blue })
        showQuestion()
        redButton.isHidden = true
        orangeButton.isHidden = true
        yellowButton.isHidden = true
        greenButton.isHidden = true
        blueButton.isHidden = false
        hideCategoryButton.isHidden = true
        showCategoryButton.isHidden = false
        backgroundLabel.backgroundColor = .blue
        questionLabel.textColor = .white
    }
    
    @IBAction func didTapOrangeButton(_ sender: UIButton) {
        categoryQuestions = quizQuestions.filter({ $0.category == .orange })
        showQuestion()
        redButton.isHidden = true
        orangeButton.isHidden = false
        yellowButton.isHidden = true
        greenButton.isHidden = true
        blueButton.isHidden = true
        hideCategoryButton.isHidden = true
        showCategoryButton.isHidden = false
        backgroundLabel.backgroundColor = .orange
        questionLabel.textColor = .white
    }
    
    @IBAction func didTapYellowController(_ sender: UIButton) {
        categoryQuestions = quizQuestions.filter({ $0.category == .yellow })
        showQuestion()
        redButton.isHidden = true
        orangeButton.isHidden = true
        yellowButton.isHidden = false
        greenButton.isHidden = true
        blueButton.isHidden = true
        hideCategoryButton.isHidden = true
        showCategoryButton.isHidden = false
        backgroundLabel.backgroundColor = .yellow
        questionLabel.textColor = .black
    }
    
    @IBAction func didTapGreenButton(_ sender: UIButton) {
        categoryQuestions = quizQuestions.filter({ $0.category == .green })
        showQuestion()
        redButton.isHidden = true
        orangeButton.isHidden = true
        yellowButton.isHidden = true
        greenButton.isHidden = false
        blueButton.isHidden = true
        hideCategoryButton.isHidden = true
        showCategoryButton.isHidden = false
        backgroundLabel.backgroundColor = .green
        questionLabel.textColor = .black
    }
}

