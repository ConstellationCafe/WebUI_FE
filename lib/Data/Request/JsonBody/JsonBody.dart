/// Request json body type
class JsonBody {
  JsonBody({
    required this.dst,
    required this.sub,
    required this.targetFunc,
    required this.args,
  });

  final String dst;
  final String sub;
  final String targetFunc;
  final List<String> args;
}
