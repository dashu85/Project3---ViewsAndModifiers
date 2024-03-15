//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Marcus Benoit on 14.03.24.
//

import SwiftUI

struct ContentView: View {
    @State var useBlackText = false
    
    @ViewBuilder var motto: some View {
        Text("This is a test")
        Text("here we go")
    }
    
    var body: some View {
        Form {
            VStack(alignment: .center) {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        
        VStack {
            Text("Gryffindor")
                .font(.largeTitle)
                .blur(radius: 2.0)
            Text("Hufflepuff")
                .blur(radius: 5.0)
            Text("Ravenclaw")
                .blur(radius: 8.0)
            Text("Slytherin")
                .blur(radius: 10.0)
        }
        .font(.title)
        
        Color.blue
            .frame(maxWidth: 100, maxHeight: 100)
            .watermark(with: "HWS")
        
        Spacer()
        
        Button("Is this red, yet?") {
            useBlackText.toggle()
        }
        .foregroundColor(useBlackText ? .yellow : .black)
        
        Button("Do something") {
            print(type(of: self.body))
        }
        .frame(width: 200, height: 200)
        .foregroundColor(.black)
        .background(.yellow)
        
        Text("BVB Borussia")
            .padding()
            .background(.yellow)
            .padding()
            .background(.black)
            .padding()
            .background(.yellow)
            .padding()
            .background(.black)
        
        Text("Wer wird deutscher Meister?")
            .modifier(BVBModifier())
        
        Text("extention text")
            .bvbStyle()
            
            GridStack(rows: 4, columns: 4) { row, col in
             Text("R\(row) C\(col)")
                
            }
            
            GridStack(rows: 4, columns: 4) { row, col in
                HStack {
                    Image(systemName: "\(row * 4 + col).circle")
                    // Text("R\(row) C\(col)")
                }
            }
                
            // no HStack needed after applying @ViewBuilder to "let content" in the struct GridStack
            GridStack(rows: 4, columns: 4) { row, col in
                Image(systemName: "\(row * 4 + col).circle")
                // Text("R\(row) C\(col)")
            } // GridStack
        } // Form
    } // body
} // ContentView

// struct needs to conform to ViewModifier which has have a func called body accepting a content and returning some View
struct BVBModifier: ViewModifier {
        func body(content: Content) -> some View {
            content
                .background(.yellow)
                .foregroundColor(.black)
                .font(.title3)
                .multilineTextAlignment(.center)
        }
    }

// for a simpler implementation we can create a View extension to just call .BVBModifier
extension View {
        func bvbStyle() -> some View {
            modifier(BVBModifier())
        }
    }


// another custom Modifier called Watermark
struct Watermark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .center) {
            content
            Text(text)
                .font(.caption)
                .foregroundStyle(.white)
                .padding(5)
                .background(.black)
                .opacity(0.4)
        }
    }
}

extension View {
    func watermark(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}

struct GridStack<Content: View>: View {   // this uses generics - "you can provide any kind of content you like but it must conform to View protocol"
    let rows: Int
    let columns: Int
    @ViewBuilder let content: (Int, Int) -> Content //with @ViewBuilder in place SwiftUI will automatically create an implicit HStack inside our cell closure
    
    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<columns, id: \.self) { column in
                        content(row, column)
                    }
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
