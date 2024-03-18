//
//  GeneratedStoryView.swift
//  AI Story Telling
//
//  Created by Log on 6/16/23.
//
import SwiftUI

struct GeneratedStoryView: View {
    @ObservedObject var viewModel: StoryInputViewModel
    @State private var isLoadingComplete = false
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        if isLoadingComplete {
            ZStack{
                Color("Background1")
                    .ignoresSafeArea()

                // Display the generated story
//                Text(viewModel.self.generatedStory)
//                    .font(Font.custom("Noteworthy", size: 20))
//                    .fontWeight(.bold)
//                    .padding()
                
                //Display Story seperate into paragraphs by periods
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(viewModel.generatedStory.components(separatedBy: "."), id: \.self) { paragraph in
                            Text(paragraph)
                                .font(Font.custom("Noteworthy", size: 20))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 20)
                        }
                    }
                }
            }
            //Loading Screen before story is displayed
        } else {
            ZStack{
                Color("Background1")
                    .ignoresSafeArea()
                // Display a loading screen
                VStack {
                    ProgressView("Writing your Story...")
                        .font(Font.custom("Noteworthy", size: 40))
                        .foregroundColor(Color("Purple1"))
                        .onAppear {
                            // Simulate a 5-second delay before showing the story
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                isLoadingComplete = true
                            }
                        }
                    if colorScheme == .light {
                                Image("LoadingStory")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 300, height: 200)
                                    .padding()
                            } else {
                                Image("LoadingStoryDark")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 300, height: 200)
                                    .padding()
                            }
                }

            }
        }
    }


        
}

struct GeneratedStoryView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = StoryInputViewModel()
        viewModel.generatedStory = "Logan was a boy who lived in a castle. With towering turrets and a grand drawbridge, it was a sight to behold. One day, the king of the castle, wise and noble, called Logan into his majestic chamber. Logan, the king began, his voice resonating with authority, a dragon has been terrorizing our kingdom. I call upon you, you young knight, to embark on a quest to defeat this mighty creature. As he ventured deeper into the dragon's lair, Logan's every step was accompanied by the echoes of his racing heartbeat. Finally, he stood face-to-face with the colossal beast. Its scales shimmered like molten gold, and its fiery breath illuminated the cavernous chamber. Summoning all his strength and courage, Logan engaged in a fierce battle with the dragon. He dodged its fiery onslaught, parried its mighty tail swipes, and struck back with unyielding resolve. After an arduous struggle, Logan's unwavering determination prevailed. The dragon let out a thunderous roar before collapsing defeated. News of Logan's triumph spread like wildfire through the kingdom. The people hailed him as a hero, and the king praised his bravery. Logan returned to the castle, greeted by a jubilant celebration. The halls resounded with cheers and applause, each person recognizing his remarkable feat. And so, Logan's tale echoed through the generations, inspiring young and old alike. His name became synonymous with bravery and resilience, a testament to the fact that within the heart of a seemingly ordinary boy lay the spirit of a true hero."
        return GeneratedStoryView(viewModel: viewModel)
    }
}



