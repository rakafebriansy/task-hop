//
//  OnboardingView.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 21/03/26.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var hasSeenOnboarding: Bool
    @State private var currentPage: Int = 0
    
    let pages: [OnboardingInfo] = [
        OnboardingInfo(
            title: "Master Your Time",
            description: "Organize tasks efficiently using the Eisenhower Matrix and watch your productivity evolve.",
            image: "illPepeFocus",
            gradientColors: [Color(hex: "#A8D38E"), Color(hex: "#71BB88")]
        ),
        OnboardingInfo(
            title: "Prioritize Tasks",
            description: "Separate the urgent from the important. Focus only on what truly matters for your goals.",
            image: "illPepePrioritize",
            gradientColors: [Color(hex: "#8ECAE6"), Color(hex: "#219EBC")]
        ),
        OnboardingInfo(
            title: "Achieve Streaks",
            description: "Build a consistent habit, complete tasks daily, and watch Pepe celebrate your success.",
            image: "illPepeAchieve",
            gradientColors: [Color(hex: "#FFD166"), Color(hex: "#F4A261")]
        )
    ]
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                if currentPage < pages.count - 1 {
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            hasSeenOnboarding = true
                        }
                    }) {
                        Text("Skip")
                            .foregroundStyle(Color(hex: "#9CA3AF"))
                            .fontWeight(.semibold)
                    }
                } else {
                    Text("Skip").opacity(0)
                }
            }
            Spacer()
            TabView(selection: $currentPage) {
                ForEach(0..<pages.count, id: \.self) {
                    index in
                    let page = pages[index]
                    
                    VStack (spacing: 12) {
                        ZStack {
                            SolidBlobShape()
                                .fill(Color.white.opacity(0.2))
                                .frame(width: 300, height: 300)
                                .rotationEffect(.degrees(15))
                                .offset(x: 10, y: -10)
                            Image(page.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 300, height: 300)
                            
                        }
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: page.gradientColors),
                                startPoint: .bottomTrailing,
                                endPoint: .topLeading
                            )
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 60))
                        Text(page.title)
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.top, 8)
                        Text(page.description)
                            .fontWeight(.medium)
                            .foregroundStyle(Color(hex: "#6B7280"))
                            .multilineTextAlignment(.center)
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 500)
            HStack (spacing: 8) {
                ForEach(0..<pages.count, id: \.self) {
                    index in
                    Capsule()
                        .fill(currentPage == index ? Color(hex: "#22C55E") : Color(hex: "#D1D5DB"))
                        .frame(width: currentPage == index ? 24 : 8, height: 8)
                        .animation(.spring(), value: currentPage)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                currentPage = index
                            }
                        }
                }
            }
            Spacer()
            Button(action: {
                if(currentPage < pages.count - 1) {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        currentPage += 1
                    }
                } else {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        hasSeenOnboarding = true
                    }
                }
            }) {
                
                Text(currentPage == pages.count - 1 ? "Get Started" : "Next")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(Color(hex: "#22C55E"))
                    .clipShape(RoundedRectangle(cornerRadius: 18))
            }
            .padding(.top, 20)
            .shadow(color: Color(hex: "#22C55E").opacity(0.3), radius: 24, x: 0, y: 12)
            
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    OnboardingView(hasSeenOnboarding: .constant(false))
}
