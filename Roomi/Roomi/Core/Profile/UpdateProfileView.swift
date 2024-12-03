import SwiftUI
import Firebase
import RediStack
import FirebaseFirestore

struct UpdateProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    @State private var name: String
    @State private var age: Int
    @State private var gender: String
    @State private var phoneNumber: String
    @State private var selectedImage: UIImage? = nil
    @State private var isPickerPresented: Bool = false

    init(user: User?) {
        _name = State(initialValue: user?.name ?? "")
        _age = State(initialValue: user?.age ?? 18) // Default age to 18
        _gender = State(initialValue: user?.gender ?? "")
        _phoneNumber = State(initialValue: user?.phoneNumber ?? "") // Default to empty string
    }
    
    var body: some View {
        VStack {
            Text("Profile")
                .font(.title)
            
            Form {
                Section(header: Text("Name")) {
                    TextField("Enter your name", text: $name)
                }
                
                Section(header: Text("Age")) {
                    TextField("Enter your age", value: $age, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("Gender")) {
                    Picker("Gender", selection: $gender) {
                        Text("Male").tag("Male")
                        Text("Female").tag("Female")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Phone Number")) {
                    TextField("Enter your phone number", text: $phoneNumber)
                        .keyboardType(.phonePad)
                }
                
                Section(header: Text("Profile Image")) {
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                    } else {
                        Text("No image selected")
                    }
                    
                    Button("Select Image") {
                        isPickerPresented = true
                    }
                    
                    ButtonView(title: "Upload & Save Image", background: .green) {
                        Task {
                            guard let image = selectedImage else { return }
                            do {
                                // Convert the image to JPEG data
                                guard let imageData = image.jpegData(compressionQuality: 0.8) else {
                                    print("Failed to convert image to JPEG data")
                                    return
                                }

                                // Encode the image data to Base64
                                let base64String = imageData.base64EncodedString()

                                // Generate a unique Redis key
                                let redisKey = RedisKey("profile_image_\(UUID().uuidString)")
                                
                                // Use RedisManager to store the Base64 string
                                if let redisConnection = RedisManager.shared.getConnection() {
                                    try await redisConnection.set(redisKey, to: base64String)
                                    
                                    // Save the Redis key to Firebase
                                    let db = Firestore.firestore()
                                    let userId = viewModel.currentUser?.id ?? "unknown_user"
                                    try await db.collection("users").document(userId).setData([
                                        "imageKey": redisKey.description // Save Redis key as a String
                                    ], merge: true)

                                    print("Image uploaded and key saved to Firebase!")
                                } else {
                                    print("Redis connection not available")
                                }
                            } catch {
                                print("Error uploading image: \(error)")
                            }
                        }
                    }

                    .frame(width: 200, height: 50)
                    .padding()
                }
            }
            
            Spacer()
            
            
            ButtonView(title: "Update Profile", background: .blue) {
                Task {
                    do {
                        try await viewModel.updateProfile(user: User(id: "", email: "", name: name, age: age, gender: gender, phoneNumber: phoneNumber, imageKey: ""))
                        dismiss()
                    } catch {
                        print("Error updating profile")
                    }
                }
            }
            .frame(width: 150, height: 50)
            .padding()
        }
        .sheet(isPresented: $isPickerPresented) {
            ImagePicker(image: $selectedImage)
        }
    }
}
