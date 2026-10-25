//
//  DrawingCanvas.swift
//  DuoNotes
//
//  Created by billyking on 25/10/2026.
//

import SwiftUI
import PencilKit

struct DrawingCanvas: UIViewRepresentable {
    @Binding var data: Data?
    
    func makeUIView(context: Context) -> PKCanvasView {
        let canvas = PKCanvasView()
        canvas.drawingPolicy = .anyInput   // finger works too
        canvas.tool = PKInkingTool(.pen, color: .label, width: 3)
        if let data {
            canvas.drawing = (try? PKDrawing(data: data)) ?? PKDrawing()
        }
        canvas.backgroundColor = .secondarySystemBackground
        canvas.delegate = context.coordinator
        return canvas
    }
    
    func updateUIView(_ canvas: PKCanvasView, context: Context) {}
    
    func makeCoordinator() -> Coordinator { Coordinator(self) }
    
    class Coordinator: NSObject, PKCanvasViewDelegate {
        let parent: DrawingCanvas
        init(_ parent: DrawingCanvas) { self.parent = parent }
        
        func canvasViewDrawingDidChange(_ canvas: PKCanvasView) {
            parent.data = canvas.drawing.dataRepresentation()
        }
    }
}
