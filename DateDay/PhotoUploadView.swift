//
//  PhotoUploadView.swift
//  DateDay
//
//  Created by Quentin Derouard on 26/05/2024.
//

import SwiftUI
import Firebase
import FirebaseStorage
import UIKit

struct PhotoUploadView: View {
    @Binding var isSignedIn: Bool
    @Binding var user: User? // Utilisateur en cours de création
    @State private var images: [UIImage] = [] // Les images sélectionnées
    @State private var navigateToCompletion = false // Gestion de la navigation après l'enregistrement
    @State private var showingImagePicker = false // Variable pour déclencher l'image picker
    @State private var selectedImage: UIImage? // Image sélectionnée à chaque fois

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

            Text("Ajoute des photos de toi ! La première doit montrer ta tête. Pour le reste, montre tes passions !")
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
                                .overlay(
                                    Button(action: {
                                        images.remove(at: index)
                                    }) {
                                        Image(systemName: "minus.circle.fill")
                                            .foregroundColor(.red)
                                            .padding(5)
                                    },
                                    alignment: .topTrailing
                                )
                        } else {
                            Button(action: {
                                // Afficher le picker pour ajouter une photo
                                self.showingImagePicker = true
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

            NavigationLink(destination: CompletionView(isSignedIn: $isSignedIn, user: $user), isActive: $navigateToCompletion) {
                Text("Enregistrer")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.top)
            }
            .simultaneousGesture(TapGesture().onEnded {
                savePhotos() // Enregistrer les photos dans Firebase
            })

            Spacer()
        }
        .background(
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                HeartAnimationView()  // Animation des cœurs en arrière-plan
            }
        )
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$selectedImage) // Utilise le picker d'image
        }
    }

    // Fonction pour enregistrer les photos dans Firebase Storage et Firestore
    private func savePhotos() {
        guard let user = user else { return } // S'assurer que l'utilisateur existe
        let db = Firestore.firestore()
        let storage = Storage.storage()

        for (index, image) in images.enumerated() {
            let storageRef = storage.reference().child("user_photos/\(user.id)_\(index).jpg") // Référence au fichier de stockage Firebase
            if let imageData = image.jpegData(compressionQuality: 0.8) {
                storageRef.putData(imageData, metadata: nil) { (metadata, error) in
                    if let error = error {
                        print("Erreur lors du téléchargement de l'image: \(error.localizedDescription)")
                        return
                    }

                    storageRef.downloadURL { (url, error) in
                        if let error = error {
                            print("Erreur lors de l'obtention de l'URL de l'image: \(error.localizedDescription)")
                            return
                        }

                        if let url = url {
                            // Mise à jour de Firestore avec l'URL de la photo
                            db.collection("users").document(user.id).updateData([
                                "photoURLs": FieldValue.arrayUnion([url.absoluteString])
                            ]) { error in
                                if let error = error {
                                    print("Erreur lors de la mise à jour des URL des photos: \(error.localizedDescription)")
                                } else if index == self.images.count - 1 {
                                    // Une fois toutes les photos enregistrées, navigation vers CompletionView
                                    navigateToCompletion = true
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    // Fonction pour charger l'image sélectionnée
    private func loadImage() {
        if let selectedImage = selectedImage {
            images.append(selectedImage)
        }
    }
}

struct PhotoUploadView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoUploadView(isSignedIn: .constant(false), user: .constant(nil))
    }
}

// ImagePicker pour utiliser UIImagePickerController
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }

            picker.dismiss(animated: true)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}
}
