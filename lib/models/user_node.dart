class UserNode {
  final String id;
  final String name;
  final String avatarUrl; // Using letters for placeholder
  final bool isOnline;

  double x;
  double y;
  double z;

  UserNode({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.isOnline,
    this.x = 0,
    this.y = 0,
    this.z = 0,
  });
}
