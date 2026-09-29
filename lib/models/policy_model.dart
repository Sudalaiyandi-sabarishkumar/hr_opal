

import '../core/utils/enums.dart';

class PolicySection {
  const PolicySection({required this.heading, required this.body});

  factory PolicySection.fromJson(Map<String, dynamic> json) => PolicySection(
        heading: json['heading'] as String? ?? '',
        body: json['body'] as String? ?? '',
      );

  final String heading;
  final String body;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'heading': heading,
        'body': body,
      };
}

class PolicyModel {
  const PolicyModel({
    required this.id,
    required this.title,
    required this.lastUpdated,
    required this.type,
    required this.documentTitle,
    required this.createdBy,
    required this.contactEmail,
    required this.sections,
  });

  factory PolicyModel.fromJson(Map<String, dynamic> json) => PolicyModel(
        id: json['id'].toString(),
        title: json['title'] as String? ?? '',
        lastUpdated: json['lastUpdated'] as String? ?? '',
        type: PolicyType.values.firstWhere(
          (PolicyType t) => t.name == json['type'],
          orElse: () => PolicyType.other,
        ),
        documentTitle: json['documentTitle'] as String? ?? '',
        createdBy: json['createdBy'] as String? ?? '',
        contactEmail: json['contactEmail'] as String? ?? '',
        sections: (json['sections'] as List<dynamic>? ?? <dynamic>[])
            .map((dynamic e) =>
                PolicySection.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  final String id;

  
  final String title;

  
  final String lastUpdated;

  
  final PolicyType type;

  
  final String documentTitle;
  final String createdBy;
  final String contactEmail;
  final List<PolicySection> sections;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'lastUpdated': lastUpdated,
        'type': type.name,
        'documentTitle': documentTitle,
        'createdBy': createdBy,
        'contactEmail': contactEmail,
        'sections': sections.map((PolicySection s) => s.toJson()).toList(),
      };
}


const List<PolicyModel> samplePolicies = <PolicyModel>[
  
  PolicyModel(
    id: '2',
    title: 'Bonus Policy',
    lastUpdated: 'Oct 2025',
    type: PolicyType.bonus,
    documentTitle: 'Finance Payroll Policy',
    createdBy: '[Your Company Name]',
    contactEmail: '[Your Company Email]',
    sections: <PolicySection>[
      PolicySection(
        heading: 'Policy Overview',
        body:
            'The aim of this Finance Payroll Policy is to ensure the structured, timely, and accurate compensation of employees, in adherence to legal and regulatory standards. This policy lays out the principles and procedures governing payroll schedules, deductions, overtime payment, and compliance with federal and state laws. This will ensure efficiency and fairness in the payroll process at [Your Company Name].',
      ),
      PolicySection(
        heading: 'Policy Effective Date',
        body:
            'This policy will come into effect from [Month, Day, Year], and will remain in effect until further amendments are made to it. Any changes will be communicated to all employees by the management.',
      ),
      PolicySection(
        heading: 'Payroll Schedule',
        body:
            'Employees will be compensated on a [monthly] basis, with payments being made on the last working day of each [month]. Employees joining or leaving the company in mid-month will have their pay calculated on a pro-rata basis.',
      ),
      PolicySection(
        heading: 'Deductions',
        body:
            'Standard federal and state deductions for taxes, health insurance, retirement contributions, and any other benefits will be deducted from employee salaries in accordance with legal requirements.',
      ),
      
    ],
  ),
  PolicyModel(
    id: '2',
    title: 'Leave Policy',
    lastUpdated: 'Oct 2025',
    type: PolicyType.leave,
    documentTitle: 'Leave Policy',
    createdBy: '[Your Company Name]',
    contactEmail: '[Your Company Email]',
    sections: <PolicySection>[
      PolicySection(
        heading: 'Policy Overview',
        body:
            'The aim of this Leave Policy is to ensure the structured, timely, and accurate compensation of employees, in adherence to legal and regulatory standards. This policy lays out the principles and procedures governing payroll schedules, deductions, overtime payment, and compliance with federal and state laws. This will ensure efficiency and fairness in the payroll process at [Your Company Name].',
      ),
      PolicySection(
        heading: 'Policy Effective Date',
        body:
            'This policy will come into effect from [Month, Day, Year], and will remain in effect until further amendments are made to it. Any changes will be communicated to all employees by the management.',
      ),
      PolicySection(
        heading: 'Payroll Schedule',
        body:
            'Employees will be compensated on a [monthly] basis, with payments being made on the last working day of each [month]. Employees joining or leaving the company in mid-month will have their pay calculated on a pro-rata basis.',
      ),
      PolicySection(
        heading: 'Deductions',
        body:
            'Standard federal and state deductions for taxes, health insurance, retirement contributions, and any other benefits will be deducted from employee salaries in accordance with legal requirements.',
      ),
    ],
  ),
  PolicyModel(
    id: '3',
    title: 'Holiday Policy',
    lastUpdated: 'Oct 2025',
    type: PolicyType.holiday,
    documentTitle: 'Holiday Policy',
    createdBy: '[Your Company Name]',
    contactEmail: '[Your Company Email]',
    sections: <PolicySection>[
      PolicySection(
        heading: 'Policy Overview',
        body:
            'The aim of this Holiday Policy is to ensure the structured, timely, and accurate compensation of employees, in adherence to legal and regulatory standards. This policy lays out the principles and procedures governing payroll schedules, deductions, overtime payment, and compliance with federal and state laws. This will ensure efficiency and fairness in the payroll process at [Your Company Name].',
      ),
      PolicySection(
        heading: 'Policy Effective Date',
        body:
            'This policy will come into effect from [Month, Day, Year], and will remain in effect until further amendments are made to it. Any changes will be communicated to all employees by the management.',
      ),
      PolicySection(
        heading: 'Payroll Schedule',
        body:
            'Employees will be compensated on a [monthly] basis, with payments being made on the last working day of each [month]. Employees joining or leaving the company in mid-month will have their pay calculated on a pro-rata basis.',
      ),
      PolicySection(
        heading: 'Deductions',
        body:
            'Standard federal and state deductions for taxes, health insurance, retirement contributions, and any other benefits will be deducted from employee salaries in accordance with legal requirements.',
      ),
    ],
  ),
];
