class ProfileModel {
  const ProfileModel({
    required this.name,
    required this.email,
    this.phone,
    this.photoUrl,
    this.jobTitle = 'Software Engineer at Troology Technologies',
    this.location = 'Ahmedabad',
    this.viewsCount = '1245',
    this.savedCount = '124',
    this.isPersonal = true,
  });

  final String name;
  final String email;
  final String? phone;
  final String? photoUrl;
  final String jobTitle;
  final String location;
  final String viewsCount;
  final String savedCount;
  final bool isPersonal;

  ProfileModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? photoUrl,
    String? jobTitle,
    String? location,
    String? viewsCount,
    String? savedCount,
    bool? isPersonal,
  }) {
    return ProfileModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      photoUrl: photoUrl ?? this.photoUrl,
      jobTitle: jobTitle ?? this.jobTitle,
      location: location ?? this.location,
      viewsCount: viewsCount ?? this.viewsCount,
      savedCount: savedCount ?? this.savedCount,
      isPersonal: isPersonal ?? this.isPersonal,
    );
  }
}
