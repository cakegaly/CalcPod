//
//  ViewController.swift
//  CalcPod
//
//  Created by Toshiki Okazaki on 2018/08/10.
//  Copyright © 2018年 Toshiki Okazaki. All rights reserved.
//

import UIKit
import Expression // inputted string to swift code, and calculate

class ViewController: UIViewController {
    @IBOutlet weak var formulaLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // when view loaded, make labels of formula and answer empty
        formulaLabel.text = ""
        answerLabel.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func inputFormula(_ sender: UIButton) {
        // guard: when substitute formulaLabel.text for formulaText -> return
        guard let formulaText = formulaLabel.text else {
            return
        }
        guard let senderedText = sender.titleLabel?.text else {
            return
        }
        formulaLabel.text = formulaText + senderedText
    }
    
    @IBAction func clearCalculation(_ sender: UIButton) {
        // when 'C' tapped, clear formula and answer
        formulaLabel.text = ""
        answerLabel.text = ""
    }

    private func formatFormula(_ formula: String) -> String {
        
        let formattedFormula: String = formula.replacingOccurrences(
            // Regular Expression
            of: "(?<=^|[÷×\\+\\-\\(])([0-9]+)(?=[÷×\\+\\-\\)]|$)",
            // add '.0' to inputted Integer, and evaluate as decimal
            with: "$1.0",
            options: NSString.CompareOptions.regularExpression,
            range: nil
            ).replacingOccurrences(of: "÷", with: "/").replacingOccurrences(of: "×", with: "*")
        // replace '÷' to '/', and '×' to '*' for user, easy to understand
        return formattedFormula
    }
    
    private func evalFormula(_ formula: String) -> String {
        do {
            // evaluate strings and calculate by Expression
            let expression = Expression(formula)
            let answer = try expression.evaluate()
            return formatAnswer(String(answer))
        } catch {
            // invalid
            return "Invalid input"
        }
    }
    
    @IBAction func answerCalculation(_ sender: UIButton) {
        // when "=" tapped, print answer after calculating
        guard let formulaText = formulaLabel.text else {
            return
        }
        let formula: String = formatFormula(formulaText)
        answerLabel.text = evalFormula(formula)
    }
    
    private func formatAnswer(_ answer: String) -> String {
        // print answer as Integer when answer is "*.0"
        let formattedAnswer: String = answer.replacingOccurrences(
            of: "\\.0$",
            with: "",
            options: NSString.CompareOptions.regularExpression,
            range: nil)
        return formattedAnswer
    }
    
}

