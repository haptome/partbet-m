class CompanySettingsModel {
  CompanySettingsModel({
    required this.id,
    required this.name,
    required this.logo,
    required this.theme,
    required this.paymentId,
    required this.storageType,
    required this.freePlanDuration,
    required this.freePlanImages,
    required this.faq,
    required this.privacyPolicy,
    required this.termsAndCondition,
    required this.canSendPromp,
    required this.freeTrialStatus,
    required this.percentage,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create an instance from JSON
  factory CompanySettingsModel.fromJson(Map<String, dynamic> json) =>
      CompanySettingsModel(
        id: json['id'] as String,
        name: json['name'] as String,
        logo: json['logo'] as String,
        theme: json['theme'] as String,
        paymentId: json['paymentId'] as String,
        storageType: json['storageType'] as String,
        freePlanDuration: json['freePlaneDuration'] as int,
        freePlanImages: json['freePlaneImages'] as int,
        faq: (json['faq'] as List<dynamic>)
            .map((faqItem) => FAQ.fromJson(faqItem as Map<String, dynamic>))
            .toList(), // Convert the list of FAQ JSON objects to a list of FAQ models
        privacyPolicy: json['privacyPolicy'] as String,
        termsAndCondition: json['termsAndCondition'] as String,
        canSendPromp: json['canSendPromp'] as bool,
        freeTrialStatus: json['freeTrailStatus'] as bool,
        percentage: double.tryParse(json['percentage'].toString()) ?? 0.0,
        createdAt: DateTime.parse(json['createdAt'] as String),
        updatedAt: DateTime.parse(json['updatedAt'] as String),
      );

  final String id;
  final String name;
  final String logo;
  final String theme;
  final String paymentId;
  final String storageType;
  final int freePlanDuration;
  final int freePlanImages;
  final List<FAQ> faq; // List of FAQ objects
  final String privacyPolicy;
  final String termsAndCondition;
  final bool canSendPromp;
  final bool freeTrialStatus;
  final double percentage;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'logo': logo,
        'theme': theme,
        'paymentId': paymentId,
        'storageType': storageType,
        'freePlaneDuration': freePlanDuration,
        'freePlaneImages': freePlanImages,
        'faq': faq
            .map((faqItem) => faqItem.toJson())
            .toList(), // Convert the list of FAQ objects to a list of JSON objects
        'privacyPolicy': privacyPolicy,
        'termsAndCondition': termsAndCondition,
        'canSendPromp': canSendPromp,
        'freeTrailStatus': freeTrialStatus,
        'percentage': percentage.toString(),
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };
}

class PublicCompanySettingsModel {
  PublicCompanySettingsModel({
    required this.faq,
    required this.privacyPolicy,
    required this.termsAndCondition,
    required this.canSendPromp,
  });

  // Factory method to create an instance from JSON
  factory PublicCompanySettingsModel.fromJson(Map<String, dynamic> json) =>
      PublicCompanySettingsModel(
        faq: (json['faq'] as List<dynamic>)
            .map((faqItem) => FAQ.fromJson(faqItem as Map<String, dynamic>))
            .toList(), // Convert the list of FAQ JSON objects to a list of FAQ models
        privacyPolicy: json['privacyPolicy'] as String,
        canSendPromp: json['canSendPromp'] as bool,

        termsAndCondition: json['termsAndCondition'] as String,
      );
  final List<FAQ> faq; // List of FAQ objects
  final String privacyPolicy;
  final String termsAndCondition;
  final bool canSendPromp;

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() => {
        'faq': faq
            .map((faqItem) => faqItem.toJson())
            .toList(), // Convert the list of FAQ objects to a list of JSON objects
        'privacyPolicy': privacyPolicy,
        'canSendPromp': canSendPromp,
        'termsAndCondition': termsAndCondition,
      };
}

class FAQ {
  FAQ({
    required this.answer,
    required this.status,
    required this.question,
    required this.createdAt,
  });

  // Factory method to create an instance from JSON
  factory FAQ.fromJson(Map<String, dynamic> json) => FAQ(
        answer: json['answer'] as String,
        status: json['status'] as String,
        question: json['question'] as String,
        createdAt: DateTime.parse(json['createdAt'] as String),
      );

  final String answer;
  final String status;
  final String question;
  final DateTime createdAt;

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() => {
        'answer': answer,
        'status': status,
        'question': question,
        'createdAt': createdAt.toIso8601String(),
      };
}
