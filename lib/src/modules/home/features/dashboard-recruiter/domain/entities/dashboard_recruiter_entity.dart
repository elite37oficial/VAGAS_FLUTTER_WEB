class DashboardRecruiterEntity {
  final String imageUrl;
  final String title;
  final String company;
  final String status;
  final String city;
  final String type;

  DashboardRecruiterEntity({
    required this.imageUrl,
    required this.title,
    required this.company,
    required this.status,
    required this.city,
    required this.type,
  });

  // construtor vazio adicionado
  DashboardRecruiterEntity.empty()
      : imageUrl = '',
        title = '',
        company = '',
        status = '',
        city = '',
        type = '';
}
