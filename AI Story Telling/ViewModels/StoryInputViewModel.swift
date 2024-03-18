//
//  StoryInputViewModel.swift
//  AI Story Telling
//
//  Created by Log on 6/16/23.
//

import Foundation

class StoryInputViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var type: String = ""
    @Published var location: String = ""
    @Published var gender: String = ""
    @Published var interests: String = ""
    @Published var lesson: String = ""
    @Published var generatedStory = ""
    @Published var errorMessage = ""
    
    
    private func validate () -> Bool {
        errorMessage = ""
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !type.trimmingCharacters(in: .whitespaces).isEmpty,
              !location.trimmingCharacters(in: .whitespaces).isEmpty,
              !gender.trimmingCharacters(in: .whitespaces).isEmpty,
              !interests.trimmingCharacters(in: .whitespaces).isEmpty,
              !lesson.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill in all fields"
            return  false
        }
        return true
    }
    

    //WORKS (below)
    func generateStory() {
            let prompt = """
                Write me a childrens story about a kid named \(name) who is a \(type) and \(gender) and enjoys \(interests). The story takes place in \(location) and the kid learns about \(lesson). Please make the story 500 words and create a title to go with the story as well and put it at the top.
                """
            let apiUrl = "https://api.openai.com/v1/engines/text-davinci-002/completions"
            let apiKey = "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"


            guard let url = URL(string: apiUrl) else {
                print("Invalid API URL")
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            let parameters: [String: Any] = [
                "prompt": prompt,
                "max_tokens": 650, // Adjust the desired maximum length of the generated story
                "temperature": 0.7 // Adjust the temperature to control the randomness of the generated text
            ]

            let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
            request.httpBody = jsonData

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error: \(error)")
                    return
                }

                guard let data = data else {
                    print("No data received")
                    return
                }

                if let httpResponse = response as? HTTPURLResponse {
                            print("Response Status Code: \(httpResponse.statusCode)")
                            print("Response Headers: \(httpResponse.allHeaderFields)")
                        }

                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    if let choices = json?["choices"] as? [[String: Any]], let text = choices.first?["text"] as? String {
                        DispatchQueue.main.async {
                            self.generatedStory = text
                            saveStoryToFirestore(story: self.generatedStory)
                        }
                    }
                } catch {
                    print("JSON parsing error: \(error)")
                }
            }.resume()
        }
    }


