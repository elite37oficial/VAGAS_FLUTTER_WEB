import 'package:flutter/material.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/domain/entities/dashboard_recruiter_entity.dart';

class DashboardRecruiterItem extends StatelessWidget {
  final DashboardRecruiterEntity job;

  const DashboardRecruiterItem({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            job.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            job.company,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                job.type,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(width: 16),
              Text(
                job.status,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            job.city,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
