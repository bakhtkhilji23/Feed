import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/author.dart';
import '../../repositories/users/user_repository.dart';

final userDataProvider =
    FutureProvider.family<AuthorData?, int>((ref, id) async {
  final theAuthor = await UserRepository.getUserNamebyID(id);
  return theAuthor;
});
