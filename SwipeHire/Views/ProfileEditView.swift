import SwiftUI

struct ProfileEditView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: AppViewModel
    @State private var editedProfile: Profile
    @State private var showingImagePicker = false
    @State private var showingBannerPicker = false
    @State private var showingAddEducation = false
    @State private var showingAddExperience = false
    @State private var showingAddSkill = false
    @State private var firstName: String
    @State private var lastName: String
    @State private var about: String
    @State private var email: String
    @State private var newSchool = ""
    @State private var newExperience = ""
    @State private var newExperienceDescription = ""
    @State private var selectedSkillIcon = 0
    @State private var city: String
    @State private var state: String
    @State private var country: String
    @State private var newSkillText: String = ""
    @State private var pickedProfileImage: UIImage?
    @State private var pickedBannerImage: UIImage?
    
    
    init(viewModel: AppViewModel) {
        _editedProfile = State(initialValue: viewModel.profile)
        _firstName = State(initialValue: viewModel.profile.firstName)
        _lastName = State(initialValue: viewModel.profile.lastName)
        _about = State(initialValue: viewModel.profile.about)
        _email = State(initialValue: viewModel.profile.email)
        _city    = State(initialValue: viewModel.profile.city)
        _state   = State(initialValue: viewModel.profile.state)
        _country = State(initialValue: viewModel.profile.country)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    ZStack(alignment: .bottom) {
                        editedProfile.bannerImage
                            .resizable()
                            .scaledToFill()
                            .frame(height: 150)
                            .clipped()
                            .overlay(
                                Button(action: {
                                    showingBannerPicker = true
                                }) {
                                    Image(systemName: "pencil.circle.fill")
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .background(Color.black.opacity(0.3))
                                        .clipShape(Circle())
                                        .padding(.trailing, 20)
                                }
                                .padding(8),
                                alignment: .bottomTrailing
                            )
                        
                        editedProfile.profileImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            .background(Circle().fill(Color(red: 0.05, green: 0.1, blue: 0.2)))
                            .overlay(
                                Button(action: {
                                    showingImagePicker = true
                                }) {
                                    Image(systemName: "camera.circle.fill")
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .background(Color.blue)
                                        .clipShape(Circle())
                                }
                                .offset(x: 30, y: 30),
                                alignment: .bottomTrailing
                            )
                            .offset(y: 50)
                    }
                    .padding(.bottom, 50)
                    
                    EditSectionView(title: "Personal Information") {
                        VStack(spacing: 16) {
                            EditFieldView(title: "First Name", text: $firstName)
                            EditFieldView(title: "Last Name", text: $lastName)
                            EditFieldView(title: "Email", text: $email)
                        }
                    }
                    .padding(.top, 20)
                    
                    EditSectionView(title: "About") {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Bio")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.leading, 4)
                            
                            TextEditor(text: $about)
                                .scrollContentBackground(.hidden)
                                .foregroundColor(.white)
                                .frame(minHeight: 100)
                                .padding(8)
                                .background(Color.black.opacity(0.2))
                                .cornerRadius(8)
                        }
                    }
                    
                    EditSectionView(title: "Education") {
                        VStack(spacing: 16) {
                            ForEach(0..<editedProfile.schools.count, id: \.self) { index in
                                HStack {
                                    Image(systemName: "graduationcap.fill")
                                        .foregroundColor(.blue)
                                    
                                    Text(editedProfile.schools[index])
                                        .foregroundColor(.white)
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        editedProfile.removeSchool(at: index)
                                    }) {
                                        Image(systemName: "trash")
                                            .foregroundColor(.red)
                                    }
                                }
                                .padding(.vertical, 4)
                            }
                            
                            Button(action: {
                                showingAddEducation = true
                            }) {
                                HStack {
                                    Image(systemName: "plus.circle.fill")
                                    Text("Add Education")
                                }
                                .foregroundColor(.blue)
                                .padding(.vertical, 8)
                            }
                        }
                    }
                    

                    EditSectionView(title: "Skills") {
                        VStack(spacing: 16) {
                            // Current skills as pills
                            FlowLayout(spacing: 8) {
                                ForEach(editedProfile.skills, id: \.self) { skill in
                                    Text(skill)
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                        .padding(.vertical, 6)
                                        .padding(.horizontal, 12)
                                        .background(Color.blue.opacity(0.3))
                                        .cornerRadius(12)
                                        .onTapGesture {
                                            if let idx = editedProfile.skills.firstIndex(of: skill) {
                                                editedProfile.removeSkill(at: idx)
                                            }
                                        }
                                }
                            }

                            // Button to open the sheet
                            Button(action: {
                                showingAddSkill = true
                            }) {
                                HStack {
                                    Image(systemName: "plus.circle.fill")
                                    Text("Add Skill")
                                }
                                .foregroundColor(.blue)
                                .padding(.vertical, 8)
                            }
                        }
                    }
                    
                    EditSectionView(title: "Experience") {
                        VStack(spacing: 16) {
                            ForEach(0..<editedProfile.experiences.count, id: \.self) { index in
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(editedProfile.experiences[index])
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    
                                    Text(editedProfile.experienceDescriptions[index])
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .fixedSize(horizontal: false, vertical: true)
                                    
                                    HStack {
                                        Spacer()
                                        Button(action: {
                                            editedProfile.removeExperience(at: index)
                                        }) {
                                            Image(systemName: "trash")
                                                .foregroundColor(.red)
                                        }
                                    }
                                    
                                    if index < editedProfile.experiences.count - 1 {
                                        Divider()
                                            .background(Color.gray.opacity(0.3))
                                            .padding(.top, 8)
                                    }
                                }
                            }
                            
                            Button(action: {
                                showingAddExperience = true
                            }) {
                                HStack {
                                    Image(systemName: "plus.circle.fill")
                                    Text("Add Experience")
                                }
                                .foregroundColor(.blue)
                                .padding(.vertical, 8)
                            }
                        }
                    }
                    
                    EditSectionView(title: "Location") {
                      EditFieldView(title: "City",    text: $city)
                      EditFieldView(title: "State",   text: $state)
                      EditFieldView(title: "Country", text: $country)
                    }
                }
                .padding(.horizontal, 80)
                .padding(.bottom, 40)
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.05, green: 0.1, blue: 0.2),
                        Color(red: 0.1, green: 0.15, blue: 0.3)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
            )
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(.white),
                
                trailing: Button("Save") {
                    editedProfile.editName(first: firstName, last: lastName)
                    editedProfile.editAbout(about)
                    editedProfile.editEmail(email)
                    editedProfile.city    = city
                    editedProfile.state   = state
                    editedProfile.country = country
                    viewModel.updateProfile(editedProfile)
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(.blue)
            )

            .sheet(isPresented: $showingAddEducation) {
                AddEducationView(newSchool: $newSchool, isPresented: $showingAddEducation) { school in
                    editedProfile.addSchool(school)
                }
            }
            .sheet(isPresented: $showingAddExperience) {
                AddExperienceView(
                    title: $newExperience,
                    description: $newExperienceDescription,
                    isPresented: $showingAddExperience
                ) { title, description in
                    editedProfile.addExperience(experience: title, experienceDescription: description)
                }
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(sourceType: .photoLibrary,
                            selectedImage: $pickedProfileImage)
            }
            // pick banner photo
            .sheet(isPresented: $showingBannerPicker) {
                ImagePicker(sourceType: .photoLibrary,
                            selectedImage: $pickedBannerImage)
            }
            // whenever the user picks, update our editedProfile
            .onChange(of: pickedProfileImage) { _ , newImage in
                if let img = newImage {
                    editedProfile.editProfileUIImage(img)
                }
            }
            .onChange(of: pickedBannerImage) { _ , newBanner in
                if let img = newBanner {
                    editedProfile.editBannerUIImage(img)
                }
            }
            .sheet(isPresented: $showingAddSkill) {
                NavigationView {
                    ZStack {
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color(red: 0.05, green: 0.1, blue: 0.2),
                                Color(red: 0.1, green: 0.15, blue: 0.3)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .ignoresSafeArea()

                        VStack(spacing: 16) {
                            // Existing skill pills
                            FlowLayout(spacing: 8) {
                                ForEach(editedProfile.skills, id: \.self) { skill in
                                    Text(skill)
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                        .padding(.vertical, 6)
                                        .padding(.horizontal, 12)
                                        .background(Color.blue.opacity(0.3))
                                        .cornerRadius(12)
                                }
                            }
                            .padding()

                            // Entry + OK to append
                            HStack {
                                TextField("Enter a skill", text: $newSkillText)
                                    .textFieldStyle(.roundedBorder)
                                    .foregroundColor(.primary)

                                Button("OK") {
                                    let s = newSkillText
                                        .trimmingCharacters(in: .whitespacesAndNewlines)
                                    guard !s.isEmpty else { return }
                                    editedProfile.skills.append(s)
                                    newSkillText = ""
                                }
                                .buttonStyle(.borderedProminent)
                            }
                            .padding(.horizontal)

                            Spacer()
                        }
                    }
                    .navigationTitle("Manage Skills")
                    .navigationBarItems(
                        trailing:
                            Button("Done") {
                                showingAddSkill = false
                            }
                            .foregroundColor(.white)
                    )
                }
            }


        }
    }
}


struct EditSectionView<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.leading, 20)
            
            content
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.black.opacity(0.2))
                )
        }
        .padding(.horizontal)
    }
}

struct EditFieldView: View {
    let title: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.leading, 20)
            
            TextField("", text: $text)
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(Color.black.opacity(0.2))
                .cornerRadius(8)
        }
        .padding(.horizontal)
    }
}

struct AddEducationView: View {
    @Binding var newSchool: String
    @Binding var isPresented: Bool
    var onAdd: (String) -> Void
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Add Education")
                    .font(.headline)
                    .padding(.top)
                
                TextEditor(text: $newSchool)
                    .scrollContentBackground(.hidden)
                    .foregroundColor(.white)
                    .padding()
                    .frame(minHeight: 100)
                    .background(Color.black.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                Text("Include school name, degree, and major")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Button(action: {
                    if !newSchool.isEmpty {
                        onAdd(newSchool)
                        newSchool = ""
                        isPresented = false
                    }
                }) {
                    Text("Add Education")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.blue)
                        )
                        .padding(.horizontal)
                }
                
                Spacer()
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.05, green: 0.1, blue: 0.2),
                        Color(red: 0.1, green: 0.15, blue: 0.3)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
            )
            .navigationBarItems(
                trailing: Button("Cancel") {
                    isPresented = false
                }
                .foregroundColor(.white)
            )
        }
    }
}

struct AddExperienceView: View {
    @Binding var title: String
    @Binding var description: String
    @Binding var isPresented: Bool
    var onAdd: (String, String) -> Void
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Add Experience")
                    .font(.headline)
                    .padding(.top)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Job Title")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.leading, 4)
                    
                    TextField("", text: $title)
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 10)
                        .background(Color.black.opacity(0.2))
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Description")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.leading, 4)
                    
                    TextEditor(text: $description)
                        .scrollContentBackground(.hidden)
                        .foregroundColor(.white)
                        .frame(minHeight: 100)
                        .padding()
                        .background(Color.black.opacity(0.2))
                        .cornerRadius(8)
                }
                
                Button(action: {
                    if !title.isEmpty && !description.isEmpty {
                        onAdd(title, description)
                        title = ""
                        description = ""
                        isPresented = false
                    }
                }) {
                    Text("Add Experience")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.blue)
                        )
                        .padding(.horizontal)
                }
                
                Spacer()
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.05, green: 0.1, blue: 0.2),
                        Color(red: 0.1, green: 0.15, blue: 0.3)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
            )
            .navigationBarItems(
                trailing: Button("Cancel") {
                    isPresented = false
                }
                .foregroundColor(.white)
            )
        }
    }
}

struct AddSkillView: View {
    @Binding var selectedIcon: Int
    @Binding var isPresented: Bool
    let skillIcons: [String]
    var onAdd: (String) -> Void
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Choose Skill Icon")
                    .font(.headline)
                    .padding(.top)
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(0..<skillIcons.count, id: \.self) { index in
                            Button(action: {
                                selectedIcon = index
                            }) {
                                Image(systemName: skillIcons[index])
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .padding(12)
                                    .foregroundColor(.white)
                                    .background(
                                        Circle()
                                            .fill(selectedIcon == index
                                                  ? Color.blue.opacity(0.6)
                                                  : Color(red: 0.1, green: 0.15, blue: 0.3))
                                    )
                                    .overlay(
                                        Circle()
                                            .stroke(selectedIcon == index
                                                   ? Color.white
                                                   : Color.blue.opacity(0.3),
                                                   lineWidth: 1)
                                    )
                            }
                        }
                    }
                    .padding()
                }
                
                Button(action: {
                    onAdd(skillIcons[selectedIcon])
                    isPresented = false
                }) {
                    Text("Add Skill")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.blue)
                        )
                        .padding(.horizontal)
                }
                .padding(.bottom)
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.05, green: 0.1, blue: 0.2),
                        Color(red: 0.1, green: 0.15, blue: 0.3)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
            )
            .navigationBarItems(
                trailing: Button("Cancel") {
                    isPresented = false
                }
                .foregroundColor(.white)
            )
        }
    }
}
