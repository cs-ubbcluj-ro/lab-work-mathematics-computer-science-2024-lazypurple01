#include <iostream>
#include <fstream>
#include <set>
#include <map>
#include <string>
#include <vector>
#include <sstream>

class FiniteAutomaton {
private:
    std::set<std::string> states;
    std::set<char> alphabet;
    std::map<std::pair<std::string, char>, std::string> transitions;
    std::set<std::string> finalStates;
    std::string startState;

public:
    // Load the finite automaton data from a file
    bool loadFromFile(const std::string& filename) {
    std::ifstream file(filename);
    if (!file.is_open()) {
        std::cerr << "Error opening file.\n";
        return false;
    }

    std::string line;
    while (std::getline(file, line)) {
        std::cout << "Reading line: " << line << "\n";  // Debugging line to see the content
        std::istringstream iss(line);
        std::string keyword;
        iss >> keyword;

        if (keyword == "States:") {
            std::string state;
            while (iss >> state) {
                if (state.back() == ',') state.pop_back(); // Remove trailing commas
                states.insert(state);
            }
        } else if (keyword == "Alphabet:") {
            char symbol;
            while (iss >> symbol) {
                if (symbol == ',') continue;
                alphabet.insert(symbol);
            }
        } else if (keyword == "Transitions:") {
            std::string fromState, toState;
            char symbol;
            while (iss >> fromState >> symbol >> toState) {
                transitions[{fromState, symbol}] = toState;
                std::cout << "Loaded transition: " << fromState << " --" << symbol << "--> " << toState << "\n";  // Debugging
            }
        } else if (keyword == "FinalStates:") {
            std::string state;
            while (iss >> state) {
                if (state.back() == ',') state.pop_back(); // Remove trailing commas
                finalStates.insert(state);
            }
        } else if (keyword == "StartState:") {
            iss >> startState;
        }
    }

    file.close();
    return true;
}


    // Display the elements of the finite automaton
    void displayElements() const {
        std::cout << "States: ";
        for (const auto& state : states) std::cout << state << " ";
        std::cout << "\nAlphabet: ";
        for (const auto& symbol : alphabet) std::cout << symbol << " ";
        std::cout << "\nTransitions:\n";
    
    // Debugging: Check if transitions are empty
        if (transitions.empty()) {
            std::cout << "No transitions to display.\n";
        } else {
            for (const auto& transition : transitions) {
                std::cout << transition.first.first << " --" << transition.first.second << "--> " << transition.second << "\n";
            }
        }

        std::cout << "Final States: ";
        for (const auto& state : finalStates) std::cout << state << " ";
        std::cout << "\nStart State: " << startState << "\n";
    }


   
   
};

int main() {
    FiniteAutomaton fa;

    if (!fa.loadFromFile("FA.in")) {
        std::cerr << "Failed to load finite automaton from file.\n";
        return 1;
    }

    fa.displayElements();
    
    
    return 0;
}
