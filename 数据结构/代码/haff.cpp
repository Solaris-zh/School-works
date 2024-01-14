#include <iostream>
#include <fstream>
#include <string>
#include <queue>
#include <unordered_map>
#include <iomanip>

using namespace std;

// 节点表示哈夫曼树中的一个节点
struct Node {
    char data;
    int frequency;
    Node *left, *right;

    Node(char data, int frequency) : data(data), frequency(frequency), left(nullptr), right(nullptr) {}

    ~Node() {
        delete left;
        delete right;
    }
};

// 比较器，用于优先队列
struct Compare {
    bool operator()(Node* left, Node* right) {
        return left->frequency > right->frequency;
    }
};

// 生成哈夫曼树
Node* buildHuffmanTree(const unordered_map<char, int>& charFrequency) {
    priority_queue<Node*, vector<Node*>, Compare> minHeap;

    for (const auto& pair : charFrequency) {
        minHeap.push(new Node(pair.first, pair.second));
    }

    while (minHeap.size() > 1) {
        Node* left = minHeap.top();
        minHeap.pop();
        Node* right = minHeap.top();
        minHeap.pop();

        Node* internalNode = new Node('$', left->frequency + right->frequency);
        internalNode->left = left;
        internalNode->right = right;
        minHeap.push(internalNode);
    }

    return minHeap.top();
}

// 生成哈夫曼编码表
void generateHuffmanCodes(Node* root, const string& currentCode, unordered_map<char, string>& huffmanCodes) {
    if (root == nullptr) {
        return;
    }

    if (root->data != '$') {
        huffmanCodes[root->data] = currentCode;
    }

    generateHuffmanCodes(root->left, currentCode + "0", huffmanCodes);
    generateHuffmanCodes(root->right, currentCode + "1", huffmanCodes);
}

// 哈夫曼编码
string huffmanEncode(const string& text, const unordered_map<char, string>& huffmanCodes) {
    string encodedText;
    for (char ch : text) {
        encodedText += huffmanCodes.at(ch);
    }
    return encodedText;
}

// 哈夫曼译码
string huffmanDecode(const string& encodedText, const Node* root) {
    string decodedText;
    const Node* current = root;

    for (char bit : encodedText) {
        if (bit == '0') {
            current = current->left;
        } else if (bit == '1') {
            current = current->right;
        }

        if (current->data != '$') {
            decodedText += current->data;
            current = root;
        }
    }

    return decodedText;
}

// 保存哈夫曼树到文件
void saveHuffmanTreeToFile(Node* root, ofstream& outFile) {
    if (root == nullptr) {
        return;
    }

    outFile << root->data << " " << root->frequency << endl;
    saveHuffmanTreeToFile(root->left, outFile);
    saveHuffmanTreeToFile(root->right, outFile);
}

// 打印哈夫曼树
// 打印哈夫曼树的树状图
void printHuffmanTree(Node* root, int indent = 0) {
    if (root == nullptr) {
        return;
    }

    // 右子树，根，左子树的顺序
    printHuffmanTree(root->right, indent + 4);

    // 打印当前节点
    if (indent > 0) {
        cout << setw(indent) << " ";
    }
    cout << root->data << " (" << root->frequency << ")" << endl;

    // 打印左子树
    printHuffmanTree(root->left, indent + 4);
}


int main() {
    string text;
    cout << "Enter the text: ";
    getline(cin, text);

    // 统计字符频率
    unordered_map<char, int> charFrequency;
    for (char ch : text) {
        charFrequency[ch]++;
    }

    // 生成哈夫曼树
    Node* huffmanTreeRoot = buildHuffmanTree(charFrequency);

    // 保存哈夫曼树到文件
    ofstream huffmanTreeFile("hfmTree.txt");
    saveHuffmanTreeToFile(huffmanTreeRoot, huffmanTreeFile);
    huffmanTreeFile.close();

    // 生成哈夫曼编码表
    unordered_map<char, string> huffmanCodes;
    generateHuffmanCodes(huffmanTreeRoot, "", huffmanCodes);

    // 打印字符的哈夫曼编码
    cout << "\nHuffman Codes:" << endl;
    for (const auto& pair : huffmanCodes) {
        cout << pair.first << ": " << pair.second << endl;
    }

    // 哈夫曼编码
    string encodedText = huffmanEncode(text, huffmanCodes);
    cout << "\nEncoded Text: " << encodedText << endl;

    // 保存编码到文件
    ofstream codeFile("CodeFile.txt");
    codeFile << encodedText;
    codeFile.close();

    // 打印哈夫曼树
    cout << "\nHuffman Tree:" << endl;
    printHuffmanTree(huffmanTreeRoot);

    // 释放哈夫曼树内存
    delete huffmanTreeRoot;

    return 0;
}
