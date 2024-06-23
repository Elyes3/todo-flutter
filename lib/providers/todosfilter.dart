import 'package:flutter_riverpod/flutter_riverpod.dart';

enum TodosFilter { all, completed, uncompleted }

final todosFilter = StateProvider((ref) => TodosFilter.all);
