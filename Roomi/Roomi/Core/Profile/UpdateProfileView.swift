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
    @State private var schoolWork: String
    @State private var bio: String
    @State private var drugs: String
    @State private var petFriendly: Bool
    @State private var social: String
    @State private var selectedImage: UIImage? = nil
    @State private var isPickerPresented: Bool = false

    init(user: User?) {
        _name = State(initialValue: user?.name ?? "")
        _age = State(initialValue: user?.age ?? 18) // Default age to 18
        _gender = State(initialValue: user?.gender ?? "")
        _phoneNumber = State(initialValue: user?.phoneNumber ?? "")
        _schoolWork = State(initialValue: user?.schoolWork ?? "")
        _bio = State(initialValue: user?.bio ?? "")
        _drugs = State(initialValue: user?.drugs ?? "")
        _petFriendly = State(initialValue: user?.petFriendly ?? false)
        _social = State(initialValue: user?.social ?? "")
    }
    
    var body: some View {
        VStack {
            Text("Profile")
                .font(.title)
            
            Form {
                // Name
                Section(header: Text("Name")) {
                    TextField("Enter your name", text: $name)
                }
                
                // Age
                Section(header: Text("Age")) {
                    TextField("Enter your age", value: $age, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                }
                
                // Gender
                Section(header: Text("Gender")) {
                    Picker("Gender", selection: $gender) {
                        Text("Male").tag("Male")
                        Text("Female").tag("Female")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                // Phone Number
                Section(header: Text("Phone Number")) {
                    TextField("Enter your phone number", text: $phoneNumber)
                        .keyboardType(.phonePad)
                }

                // School/Work
                Section(header: Text("School/Work")) {
                    TextField("Enter school or work information", text: $schoolWork)
                }
                
                // Bio
                Section(header: Text("Bio")) {
                    TextField("Enter your bio", text: $bio, axis: .vertical)
                        .lineLimit(1...7) // Allow up to 7 lines
                }
                
                // Social
                Section(header: Text("Social")) {
                    Picker("Social", selection: $social) {
                        Text("Introverted").tag("Introverted")
                        Text("Both").tag("Both")
                        Text("Extroverted").tag("Extroverted")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                // Alcohol/420
                Section(header: Text("Alcohol / 420")) {
                    Picker("Alcohol / 420", selection: $drugs) {
                        Text("Neither").tag("Neither")
                        Text("420 Only").tag("420 Only")
                        Text("Alc Only").tag("Alc Only")
                        Text("Both").tag("Both")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                // Pet Friendly
                Section(header: Text("Pet Friendly")) {
                    Picker("Pet Friendly", selection: $petFriendly) {
                        Text("Yes").tag(true)
                        Text("No").tag(false)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                // Profile Image
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
                            uploadImage()
                        }
                    }
                    .frame(width: 200, height: 50)
                    .padding()
                }
            }
            
            Spacer()
            
            // Update Profile Button
            ButtonView(title: "Update Profile", background: .blue) {
                Task {
                    do {
                        try await viewModel.updateProfile(
                            user: User(
                                id: "",
                                email: "",
                                name: name,
                                age: age,
                                gender: gender,
                                phoneNumber: phoneNumber,
                                schoolWork: schoolWork,
                                bio: bio,
                                social: social,
                                drugs: drugs,
                                petFriendly: petFriendly
                            )
                        )
                        dismiss()
                    } catch {
                        print("Error updating profile: \(error)")
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
    
    // Upload Image to Redis and Firebase
    private func uploadImage() async {
        guard let image = selectedImage else { return }
        do {
            guard let imageData = image.jpegData(compressionQuality: 0.8) else {
                print("Failed to convert image to JPEG data")
                return
            }
            let base64String = imageData.base64EncodedString()
            let redisKey = RedisKey("profile_image_\(UUID().uuidString)")
            
            if let redisConnection = RedisManager.shared.getConnection() {
                try await redisConnection.set(redisKey, to: base64String)
                let db = Firestore.firestore()
                let userId = viewModel.currentUser?.id ?? "unknown_user"
                try await db.collection("users").document(userId).setData([
                    "imageKey": redisKey.description
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

#Preview {
    UpdateProfileView(user: User(
        id: "",
        email: "",
        name: "",
        age: 0,
        gender: "",
        phoneNumber: "",
        schoolWork: "",
        bio: "",
        social: "",
        drugs: "",
        petFriendly: true
    ))
    .environmentObject(AuthViewModel())
}
