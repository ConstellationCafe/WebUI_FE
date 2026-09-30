import '../../domain/model/module_availability.dart';
import '../api/module_config_api.dart';

class ModuleConfigRepository {
  final ModuleConfigApi api;

  const ModuleConfigRepository({required this.api});

  Future<ModuleAvailability> getAvailability() async {
    final modules = await api.getMenuConfigs();
    final networkAddOns = modules
        .where((module) => module.moduleId == 'network_operations')
        .expand((module) => module.addOns)
        .toSet();
    return ModuleAvailability(
      chatbot: modules.any((module) => module.moduleId == 'chatbot'),
      shadowverse: modules.any((module) => module.moduleId == 'shadowverse'),
      academy: networkAddOns.contains('academy'),
      competition: networkAddOns.contains('competition'),
    );
  }
}
