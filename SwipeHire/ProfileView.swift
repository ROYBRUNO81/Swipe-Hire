import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: AppViewModel
    @State private var isEditing = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ZStack(alignment: .center) {
                    viewModel.profile.bannerImage
                        .resizable()
                        .scaledToFill()
                        .frame(height: 140)
                        .clipped()
                        .overlay(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.black.opacity(0.3),
                                    Color.black.opacity(0)
                                ]),
                                startPoint: .bottom,
                                endPoint: .center
                            )
                        )
                    

                    viewModel.profile.profileImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 3))
                        .shadow(radius: 5)
                        .offset(y: 60)
                }

                VStack(spacing: 20) {
                    VStack(spacing: 10) {
                        Spacer().frame(height: 60)
                        
                        Text("\(viewModel.profile.firstName) \(viewModel.profile.lastName)")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Button(action: {
                            isEditing.toggle()
                        }) {
                            Text("Edit Profile")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 6)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color.blue.opacity(0.5))
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.white, lineWidth: 1)
                                )
                        }
                    }
                    .padding(.top)
                
                    VStack(spacing: 18) {
                        if !viewModel.profile.about.isEmpty {
                            ProfileCardView(title: "About") {
                                Text(viewModel.profile.about)
                                    .font(.body)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 4)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        
        
                        if !viewModel.profile.email.isEmpty {
                            ProfileCardView(title: "Contact") {
                                HStack {
                                    Image(systemName: "envelope.fill")
                                        .foregroundColor(.blue)
                                    Text(viewModel.profile.email)
                                        .font(.body)
                                        .foregroundColor(.white)
                                }
                                .padding(.horizontal, 4)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        
               
                        if !viewModel.profile.schools.isEmpty {
                            ProfileCardView(title: "Education") {
                                VStack(alignment: .leading, spacing: 12) {
                                    ForEach(viewModel.profile.schools, id: \.self) { school in
                                        HStack(alignment: .top, spacing: 12) {
                                            Image(systemName: "graduationcap.fill")
                                                .foregroundColor(.blue)
                                                .frame(width: 20)
                                            
                                            Text(school)
                                                .font(.body)
                                                .foregroundColor(.white)
                                                .fixedSize(horizontal: false, vertical: true)
                                        }
                                    }
                                }
                                .padding(.horizontal, 4)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        
                   
                        if !viewModel.profile.skills.isEmpty {
                            ProfileCardView(title: "Skills") {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 16) {
                                        ForEach(0..<viewModel.profile.skills.count, id: \.self) { index in
                                            VStack {
                                                viewModel.profile.skills[index]
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 32, height: 32)
                                                    .foregroundColor(.white)  // Ensure visibility
                                                    .padding(10)
                                                    .background(
                                                        Circle()
                                                            .fill(
                                                                LinearGradient(
                                                                    gradient: Gradient(colors: [
                                                                        Color(red: 0.1, green: 0.2, blue: 0.4),
                                                                        Color(red: 0.1, green: 0.15, blue: 0.3)
                                                                    ]),
                                                                    startPoint: .topLeading,
                                                                    endPoint: .bottomTrailing
                                                                )
                                                            )
                                                    )
                                                    .overlay(
                                                        Circle()
                                                            .stroke(Color.blue.opacity(0.5), lineWidth: 1)
                                                    )
                                            }
                                        }
                                    }
                                    .padding(.horizontal, 4)
                                }
                            }
                        }
                        
                        if !viewModel.profile.experiences.isEmpty {
                            ProfileCardView(title: "Experience") {
                                VStack(alignment: .leading, spacing: 16) {
                                    ForEach(0..<viewModel.profile.experiences.count, id: \.self) { index in
                                        VStack(alignment: .leading, spacing: 8) {
                                            Text(viewModel.profile.experiences[index])
                                                .font(.headline)
                                                .foregroundColor(.white)
                                            
                                            Text(viewModel.profile.experienceDescriptions[index])
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                                .fixedSize(horizontal: false, vertical: true)
                                            
                                            if index < viewModel.profile.experiences.count - 1 {
                                                Divider()
                                                    .background(Color.gray.opacity(0.3))
                                                    .padding(.top, 8)
                                            }
                                        }
                                    }
                                }
                                .padding(.horizontal, 4)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 20)
            }
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
            .edgesIgnoringSafeArea(.all)
        )
        .sheet(isPresented: $isEditing) {
            ProfileEditView(viewModel: viewModel)
        }
    }
}


struct ProfileCardView<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.horizontal, 4)
            
            content
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.black.opacity(0.2))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color.blue.opacity(0.5),
                                            Color.purple.opacity(0.2)
                                        ]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 1
                                )
                        )
                )
        }
    }
}

