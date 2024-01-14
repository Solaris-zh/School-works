#include <iostream>
#include <stack>
#include <cctype>

using namespace std;


int precedence(char op) {
    if (op == '+' || op == '-')
        return 1;
    else if (op == '*' || op == '/')
        return 2;
    else if (op == '^')
        return 3;
    return 0;
}

// 将中缀表达式转换为后缀表达式
string infixToPostfix(const string& infix) {
    stack<char> operators;
    string postfix;

    for (char ch : infix) {
        if (isalnum(ch)) {
            postfix += ch;  // 操作数直接添加到后缀表达式中
        } else if (ch == '(') {
            operators.push(ch);
        } else if (ch == ')') {
            while (!operators.empty() && operators.top() != '(') {
                postfix += operators.top();
                operators.pop();
            }
            operators.pop();  // 弹出左括号
        } else {  // 运算符
            while (!operators.empty() && precedence(ch) <= precedence(operators.top())) {
                postfix += operators.top();
                operators.pop();
            }
            operators.push(ch);
        }
    }

    while (!operators.empty()) {
        postfix += operators.top();
        operators.pop();
    }

    return postfix;
}

// 计算后缀表达式的值
double evaluatePostfix(const string& postfix) {
    stack<double> operands;

    for (char ch : postfix) {
        if (isalnum(ch)) {
            operands.push(ch - '0');  // 将字符转换为数字
        } else {
            double operand2 = operands.top();
            operands.pop();
            double operand1 = operands.top();
            operands.pop();

            switch (ch) {
                case '+':
                    operands.push(operand1 + operand2);
                    break;
                case '-':
                    operands.push(operand1 - operand2);
                    break;
                case '*':
                    operands.push(operand1 * operand2);
                    break;
                case '/':
                    operands.push(operand1 / operand2);
                    break;

            }
        }
    }

    return operands.top();
}

int main() {
    string infixExpression;
    cout << "Enter an infix expression: ";
    getline(cin, infixExpression);

    string postfixExpression = infixToPostfix(infixExpression);
    cout << "Postfix expression: " << postfixExpression << endl;

    double result = evaluatePostfix(postfixExpression);
    cout << "Result: " << result << endl;

    return 0;
}
