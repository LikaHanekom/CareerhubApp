import '../models/job.dart';
import 'package:flutter_riverpod/legacy.dart';

final savedJobOverrideProvider =
StateProvider.family<Job?, String>((ref, jobId) => null);