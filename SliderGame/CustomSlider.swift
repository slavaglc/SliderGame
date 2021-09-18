//
//  SwiftUIView.swift
//  SliderGame
//
//  Created by slava on 18.09.2021.
//

import SwiftUI

struct CustomSlider: UIViewRepresentable {
    @Binding var currentValue: Float
    let alpha: CGFloat
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        slider.maximumValue = 100
        slider.minimumValue = 0
        slider.thumbTintColor = .red
        guard let image = slider.currentThumbImage?.getImageWithAlpha(alpha) else { return UISlider() }
        slider.setThumbImage(image, for: .highlighted)
        slider.setThumbImage(image, for: .normal)
        
        
        
        slider.alpha = alpha
        slider.addTarget(context.coordinator, action: #selector(Coordinator.sliderValueChanged(sender:)), for: .valueChanged)
        return slider
    }
    
    
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        guard let image = uiView.currentThumbImage?.getImageWithAlpha(alpha) else { return }
        uiView.value = Float(currentValue)
        uiView.setThumbImage(image, for: .normal)
        uiView.setThumbImage(image, for: .highlighted)
        print(alpha)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(value: $currentValue)
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

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CustomSlider(currentValue: .constant(0.5), alpha: 0.3)
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
