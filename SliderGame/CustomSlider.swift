//
//  SwiftUIView.swift
//  SliderGame
//
//  Created by slava on 18.09.2021.
//

import SwiftUI


struct CustomSlider: UIViewRepresentable {
    static private let thumbImage = UIImage(systemName: "circle.fill")?.withTintColor(.red)
    
    @Binding var currentValue: Float
    let alpha: CGFloat
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        slider.maximumValue = 100
        slider.minimumValue = 0
        setThumbAlpha(slider: slider)
        slider.addTarget(context.coordinator, action: #selector(Coordinator.sliderValueChanged(sender:)), for: .valueChanged)
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        setThumbAlpha(slider: uiView)
        uiView.value = Float(currentValue)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(value: $currentValue)
    }
    
    private func setThumbAlpha(slider: UISlider) {
        
        slider.setThumbImage(CustomSlider.thumbImage?.getImageWithAlpha(alpha), for: .highlighted)
        slider.setThumbImage(CustomSlider.thumbImage?.getImageWithAlpha(alpha), for: .normal)
    }
}

extension CustomSlider {
    
    final class Coordinator: NSObject {
        @Binding var value: Float
        
        init(value: Binding<Float>) {
            self._value = value
        }
        
        @objc func sliderValueChanged(sender: UISlider) {
            value = sender.value
        }
    }
}


extension UIImage {

    func getImageWithAlpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return UIImage() }
        UIGraphicsEndImageContext()
        return newImage
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CustomSlider(currentValue: .constant(0.5), alpha: 0.5)
    }
}
