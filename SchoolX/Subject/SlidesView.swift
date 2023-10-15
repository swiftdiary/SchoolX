//
//  SlidesView.swift
//  SchoolX
//
//  Created by Muhammadjon Madaminov on 15/10/23.
//

import SwiftUI

struct SlidesView: View {
    let topicSlides: [Slide]
    @State private var sheetUp: Bool = false
    @StateObject var vm: SlidesViewModel = SlidesViewModel()
    @EnvironmentObject var appNavigation: AppNavigation
    
    var body: some View {
        ZStack {
            ForEach(topicSlides, id: \.hashValue) { i in
                if vm.getIndexFromValue(value: i, slides: topicSlides) == vm.currentIndex {
                    EachSlideView(slide: i, slides: topicSlides, sheetUp: sheetUp)
                        .transition(.slide)
                }
            }
        }
        .environmentObject(vm)
        .overlay(alignment: .topLeading) {
            Button(action: {
                _ = appNavigation.path.popLast()
            }, label: {
                Image(systemName: "xmark")
                    .foregroundStyle(Color.accentColor)
                    .font(.title3)
                    .bold()
                    .padding(5)
                    .background(
                        Color(UIColor.systemBackground)
                    )
                    .cornerRadius(40)
                    .padding()
            })
        }
        .overlay(alignment: .topTrailing) {
            Button {
                appNavigation.path.append(.ar)
            } label: {
                Text("View In AR")
                Image(systemName: "shippingbox")
            }
            .buttonStyle(.bordered)
        }
    }
    
//    @ViewBuilder func EachSlideView(slide: Slide, sheetUp: Bool, offsetY: CGFloat = 0) -> some View {
//        
//    }
}


struct EachSlideView: View {
    var slide: Slide
    var slides: [Slide]
    @State var sheetUp: Bool
    @State private var offsetY: CGFloat = 0
    @State private var currentY: CGFloat = 0
    @EnvironmentObject var vm: SlidesViewModel
    
    
    var body: some View {
        ZStack {
//            SlideImageView(url: slide.imageUrl, key: slide.title)
//                .ignoresSafeArea()
//                .blur(radius: 10)
            Color.black
                .ignoresSafeArea()
            
            VStack {
                SlideImageView(url:slide.imageUrl, key: slide.title)
                    .frame(height: 250)
//                    .cornerRadius(15)
                    .offset(y: sheetUp ? 210 : 0)
                RoundedRectangle(cornerRadius: 35)
                    .frame(maxWidth: .infinity)
//                    .frame(height: 600)
                    .ignoresSafeArea()
                    .foregroundStyle(Color(UIColor.systemBackground))
                    .overlay(content: {
                        VStack {
                            Text(slide.title)
                                .font(.title.bold())
                                .padding(.top)
                            HStack {
                                Button(action: {
                                    if vm.currentIndex != 0 {
                                        vm.currentIndex -= 1
                                    }
                                }, label: {
                                    RoundedRectangle(cornerRadius: 20)
                                        .frame(width: 100, height: 70)
                                        .foregroundStyle(Color.accentColor)
                                        .overlay {
                                            Image(systemName: "chevron.left")
                                                .foregroundStyle(Color.white)
                                                .font(.title.bold())
                                        }
                                })
                                Spacer()
                                
                                Text("\(vm.currentIndex+1)/\(slides.count)")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                
                                Spacer()
                                
                                Button(action: {
                                    if vm.currentIndex != slides.count - 1 {
                                        vm.currentIndex += 1
                                    }
                                }, label: {
                                    RoundedRectangle(cornerRadius: 20)
                                        .frame(width: 100, height: 70)
                                        .foregroundStyle(Color.accentColor)
                                        .overlay {
                                            Image(systemName: "chevron.right")
                                                .foregroundStyle(Color.white)
                                                .font(.title.bold())
                                        }
                                })
                            }
                            .padding(.horizontal)
                            
                            ScrollView {
                                Text(slide.description)
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .padding()
                                    .background(
                                        Color.accentColor.opacity(0.3)
                                    )
                                    .cornerRadius(20)
                                    .padding()
                                .padding(.vertical)
                            }
                            .onTapGesture { }
                            .frame(maxHeight: .infinity)
                            
                            
                            Spacer()
                        }
                        .fontDesign(.rounded)
                    })
                    .offset(y: sheetUp ? 360 : 0)
                    .offset(y: offsetY)
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                withAnimation(.spring()) {
                                    offsetY = value.translation.height
                                }
                            })
                            .onEnded({ value in
                                withAnimation(.bouncy) {
                                    if currentY == 0 {
                                        if offsetY > 50 {
                                            sheetUp.toggle()
                                            currentY = offsetY
                                            offsetY = 0
                                        } else {
                                            offsetY = 0
                                        }
                                    } else {
                                        if offsetY < -50 {
                                            sheetUp.toggle()
                                            offsetY = 0
                                            currentY = 0
                                        } else {
                                            offsetY = 0
                                        }
                                    }
                                }
                            })
                    )
            }
        }
        .navigationBarBackButtonHidden()
    }
}


#Preview {
    
        SlidesView(topicSlides: [Slide(imageUrl: "https://images.unsplash.com/photo-1619410283995-43d9134e7656?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fHByb2dyYW1taW5nfGVufDB8fDB8fHww&w=1000&q=80", title: "Earth", description: "Earth is 4th plane in solar system")])
    
}


struct SlideImageView: View {
    @StateObject private var imageCacher: ImageCacher
    
    init(url: String, key: String) {
        _imageCacher = StateObject(wrappedValue: ImageCacher(url: url, key: key))
    }
    
    var body: some View {
        VStack {
            if imageCacher.isLoading {
                ProgressView()
                    .frame(width: 300, height: 200, alignment: .center)
            } else if let image = imageCacher.image  {
                Image(uiImage: image)
                   .resizable()
           }
        }
    }
}
