class MovingServiceItem {
  final String id;
  final String name;
  final String description;
  final String iconEmoji;

  const MovingServiceItem({
    required this.id,
    required this.name,
    required this.description,
    required this.iconEmoji,
  });
}

const demoServices = <MovingServiceItem>[
  MovingServiceItem(
    id: 'packing',
    name: 'Packing',
    description: 'Boxes, bubble wrap, labels',
    iconEmoji: '📦',
  ),
  MovingServiceItem(
    id: 'loading',
    name: 'Loading',
    description: 'Careful lifting and loading',
    iconEmoji: '💪',
  ),
  MovingServiceItem(
    id: 'transport',
    name: 'Transport',
    description: 'Trucks and vans',
    iconEmoji: '🚚',
  ),
  MovingServiceItem(
    id: 'unpacking',
    name: 'Unpacking',
    description: 'Setup in your new place',
    iconEmoji: '🏠',
  ),
];

