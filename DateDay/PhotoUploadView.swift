//
//  PhotoUploadView.swift
//  DateDay
//
//  Created by Quentin Derouard on 26/05/2024.
//

import SwiftUI
import PhotosUI

struct PhotoUploadView: View {
    @Binding var isSignedIn: Bool
    @Binding var user: User?
    @State private var images: [UIImage] = []
    @State private var showingImagePicker = false

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Retour")
                        .foregroundColor(.white)
                }
                Spacer()
                Text("Ajout de photos")
                    .font(.custom("Lobster-Regular", size: 24))
                    .foregroundColor(.white)
                Spacer()
                Spacer().frame(width: 60)
            }
            .padding()

            Spacer()

            Text("Ajoutez jusqu'à 5 photos à votre profil")
                .font(.custom("Lobster-Regular", size: 24))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()

            ScrollView(.horizontal) {
                HStack {
                    ForEach(0..<5) { index in
                        if index < images.count {
                            Image(uiImage: images[index])
                                .resizable()
                                .frame(width: 100, height: 100)
                                .cornerRadius(10)
                        } else {
                            Button(action: {
                                pickImage()
                            }) {
                                Rectangle()
                                    .fill(Color.gray)
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(10)
                                    .overlay(
                                        Image(systemName: "plus")
                                            .foregroundColor(.white)
                                            .font(.largeTitle)
                                    )
                            }
                        }
                    }
                }
                .padding()
            }

            Button(action: {
                savePhotos()
            }) {
                Text("Enregistrer")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.top)
            }

            Spacer()
        }
        .background(
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                HeartAnimationView()
            }
        )
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(images: $images, showingImagePicker: $showingImagePicker)
        }
    }

    private func pickImage() {
        showingImagePicker = true
    }

    private func savePhotos() {
        // Sauvegarder les photos sur Firebase
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var images: [UIImage]
    @Binding var showingImagePicker: Bool

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 5 - images.count
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.showingImagePicker = false
            for result in results {
                if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    result.itemProvider.loadObject(ofClass: UIImage.self) { image, _ in
                        if let uiImage = image as? UIImage {
                            DispatchQueue.main.async {
                                self.parent.images.append(uiImage)
                            }
                        }
                    }
                }
            }
        }
    }
}
