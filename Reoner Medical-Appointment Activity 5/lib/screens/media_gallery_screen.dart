import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/app_navigation.dart';

class MediaGalleryScreen extends StatefulWidget {
  const MediaGalleryScreen({super.key});

  @override
  State<MediaGalleryScreen> createState() => _MediaGalleryScreenState();
}

class _MediaGalleryScreenState extends State<MediaGalleryScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _audioPlayer = AudioPlayer();
    _setupAudioPlayer();
  }

  void _setupAudioPlayer() {
    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _duration = duration;
      });
    });

    _audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        _position = position;
      });
    });

    _audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        _isPlaying = state == PlayerState.playing;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medical Media Gallery'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.image), text: 'Images'),
            Tab(icon: Icon(Icons.video_library), text: 'Videos'),
            Tab(icon: Icon(Icons.audiotrack), text: 'Audio'),
          ],
        ),
      ),
      drawer: AppNavigation.buildDrawer(context, 'media_gallery'),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildImagesTab(),
          _buildVideosTab(),
          _buildAudioTab(),
        ],
      ),
      bottomNavigationBar: AppNavigation.buildBottomNavigationBar(context, 'media_gallery'),
    );
  }

  Widget _buildImagesTab() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF8F9FA),
            Color(0xFFE9ECEF),
          ],
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  Icons.photo_library,
                  size: 40,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Medical Image Gallery',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Sample medical images and demonstrations'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Image Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                itemCount: _medicalImages.length,
                itemBuilder: (context, index) {
                  final image = _medicalImages[index];
                  return _ImageCard(
                    title: image['title'],
                    icon: image['icon'],
                    color: image['color'],
                    isNetwork: image['isNetwork'] ?? false,
                    imageUrl: image['url'],
                    assetPath: image['assetPath'],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideosTab() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF8F9FA),
            Color(0xFFE9ECEF),
          ],
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  Icons.video_library,
                  size: 40,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Medical Video Library',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Educational medical videos and procedures'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Video List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _medicalVideos.length,
              itemBuilder: (context, index) {
                final video = _medicalVideos[index];
                return _VideoCard(
                  title: video['title'],
                  description: video['description'],
                  duration: video['duration'],
                  thumbnail: video['thumbnail'],
                  videoUrl: video['url'],
                  assetPath: video['assetPath'],
                  isAsset: video['isAsset'] ?? false,
                  networkUrl: video['networkUrl'],
                  youtubeUrl: video['youtubeUrl'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAudioTab() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF8F9FA),
            Color(0xFFE9ECEF),
          ],
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  Icons.audiotrack,
                  size: 40,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Medical Audio Library',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Heart sounds, breathing patterns, and audio guides'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Audio Player
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                const Text(
                  'Heartbeat Sound Player',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () async {
                        try {
                          if (_isPlaying) {
                            await _audioPlayer.pause();
                          } else {
                            // Load and play the actual heartbeat audio file
                            await _audioPlayer.setSource(AssetSource('audio/Heartbeat sound.mp3'));
                            await _audioPlayer.resume();
                          }
                        } catch (e) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error playing audio: $e'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      },
                      icon: Icon(
                        _isPlaying ? Icons.pause_circle : Icons.play_circle,
                        size: 64,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      onPressed: () async {
                        await _audioPlayer.stop();
                      },
                      icon: Icon(
                        Icons.stop_circle,
                        size: 48,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Slider(
                  min: 0,
                  max: _duration.inSeconds.toDouble(),
                  value: _position.inSeconds.toDouble(),
                  onChanged: (value) async {
                    final position = Duration(seconds: value.toInt());
                    await _audioPlayer.seek(position);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_formatDuration(_position)),
                    Text(_formatDuration(_duration)),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'Real heartbeat audio from assets',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          
          // Audio List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _medicalAudio.length,
              itemBuilder: (context, index) {
                final audio = _medicalAudio[index];
                return _AudioCard(
                  title: audio['title'],
                  description: audio['description'],
                  duration: audio['duration'],
                  audioUrl: audio['url'],
                  assetPath: audio['assetPath'],
                  isAsset: audio['isAsset'] ?? false,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}

class _ImageCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final bool isNetwork;
  final String? imageUrl;
  final String? assetPath;

  const _ImageCard({
    required this.title,
    required this.icon,
    required this.color,
    this.isNetwork = false,
    this.imageUrl,
    this.assetPath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => _showImageDialog(context),
        borderRadius: BorderRadius.circular(12),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  border: Border.all(
                    color: color.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: _buildImageWidget(),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageWidget() {
    if (isNetwork && imageUrl != null) {
      return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        child: Image.network(
          imageUrl!,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Icon(icon, size: 60, color: color);
          },
        ),
      );
    } else if (assetPath != null) {
      return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        child: Image.asset(
          assetPath!,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Icon(icon, size: 60, color: color);
          },
        ),
      );
    } else {
      return Icon(icon, size: 60, color: color);
    }
  }

  Widget _buildDialogImageWidget() {
    if (isNetwork && imageUrl != null) {
      return Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Icon(icon, size: 100, color: color);
        },
      );
    } else if (assetPath != null) {
      return Image.asset(
        assetPath!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Icon(icon, size: 100, color: color);
        },
      );
    } else {
      return Icon(icon, size: 100, color: color);
    }
  }

  void _showImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppBar(
              title: Text(title),
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                border: Border.all(color: color.withOpacity(0.3), width: 2),
              ),
              child: _buildDialogImageWidget(),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                assetPath != null 
                    ? 'Medical image loaded from assets. Tap to view in full size.'
                    : isNetwork 
                        ? 'Network image loaded from URL.'
                        : 'This is a demonstration placeholder image.',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VideoCard extends StatelessWidget {
  final String title;
  final String description;
  final String duration;
  final IconData thumbnail;
  final String? videoUrl;
  final String? assetPath;
  final bool isAsset;
  final String? networkUrl;
  final String? youtubeUrl;

  const _VideoCard({
    required this.title,
    required this.description,
    required this.duration,
    required this.thumbnail,
    this.videoUrl,
    this.assetPath,
    this.isAsset = false,
    this.networkUrl,
    this.youtubeUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => _showVideoDialog(context),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 60,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      thumbnail,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    ),
                    const Positioned(
                      bottom: 4,
                      right: 4,
                      child: Icon(
                        Icons.play_circle_filled,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      duration,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showVideoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppBar(
              title: Text(title),
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Icon(
                    Icons.video_library,
                    size: 60,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 20),
                  
                  // Demo Video Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => _VideoPlayerScreen(
                              title: '$title (Demo)',
                              assetPath: assetPath!,
                              description: 'Demo video for testing video player functionality',
                              networkUrl: networkUrl,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.play_circle),
                      label: const Text('Play Demo Video'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // YouTube Video Button
                  if (youtubeUrl != null)
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () async {
                          final Uri url = Uri.parse(youtubeUrl!);
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url, mode: LaunchMode.externalApplication);
                          } else {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Could not open YouTube video'),
                                ),
                              );
                            }
                          }
                        },
                        icon: const Icon(Icons.open_in_new),
                        label: const Text('Watch on YouTube'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AudioCard extends StatelessWidget {
  final String title;
  final String description;
  final String duration;
  final String? audioUrl;
  final String? assetPath;
  final bool isAsset;

  const _AudioCard({
    required this.title,
    required this.description,
    required this.duration,
    this.audioUrl,
    this.assetPath,
    this.isAsset = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Icon(
            Icons.audiotrack,
            color: Theme.of(context).primaryColor,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(description),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.play_circle_outline,
              color: Theme.of(context).primaryColor,
            ),
            Text(
              duration,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        onTap: () => _showAudioDialog(context),
      ),
    );
  }

  void _showAudioDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppBar(
              title: Text(title),
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Icon(
                    Icons.audiotrack,
                    size: 60,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Duration: $duration',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  if (isAsset && assetPath != null)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => _AudioPlayerScreen(
                                title: title,
                                assetPath: assetPath!,
                                description: description,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.play_circle),
                        label: const Text('Play Audio'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    )
                  else
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Colors.grey[600],
                            size: 40,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Demo Audio',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'This is a placeholder for demonstration purposes.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Sample data
final List<Map<String, dynamic>> _medicalImages = [
  {
    'title': 'X-Ray Sample',
    'icon': Icons.medical_services,
    'color': Colors.blue,
    'isNetwork': false,
    'assetPath': 'assets/images/xray.jpg',
  },
  {
    'title': 'MRI Scan',
    'icon': Icons.scanner,
    'color': Colors.green,
    'isNetwork': false,
    'assetPath': 'assets/images/mri.jpg',
  },
  {
    'title': 'CT Scan',
    'icon': Icons.camera_alt,
    'color': Colors.orange,
    'isNetwork': false,
    'assetPath': 'assets/images/ct scan.jpg',
  },
  {
    'title': 'Ultrasound',
    'icon': Icons.waves,
    'color': Colors.purple,
    'isNetwork': false,
    'assetPath': 'assets/images/ultrasound.jpg',
  },
  {
    'title': 'Medical Cart',
    'icon': Icons.local_hospital,
    'color': Colors.teal,
    'isNetwork': false,
    'assetPath': 'assets/images/medicart.jpg',
  },
  {
    'title': 'Network Image',
    'icon': Icons.cloud,
    'color': Colors.red,
    'isNetwork': true,
    'url': 'https://scontent.fceb6-1.fna.fbcdn.net/v/t39.30808-6/490305653_10163180981587090_6861735419101396138_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=127cfc&_nc_ohc=hDm9BGxJhKAQ7kNvwGto7zv&_nc_oc=Adm-ghfLZvYEhEovNecebsq_GR_iJLhYA7JTJI6hDfO0cF8QNJzerUUIGKk-HlP51AY&_nc_zt=23&_nc_ht=scontent.fceb6-1.fna&_nc_gid=dqdG5zblqlJmJ9MUD8Qn0w&oh=00_AfeGmAhqlRLTevyuWyu4iGK-u4LaXjoLG1c5f_twWGRBOw&oe=68EE6361',
  },
];

final List<Map<String, dynamic>> _medicalVideos = [
  {
    'title': 'Chest Compressions (CPR Steps)',
    'description': 'Learn proper CPR chest compression techniques and procedures',
    'duration': '3:12',
    'thumbnail': Icons.favorite,
    'assetPath': 'assets/videos/Chest Compressions (CPR Steps).mp4',
    'isAsset': true,
    'networkUrl': 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    'youtubeUrl': 'https://www.youtube.com/watch?v=BQNNOh8c8ks', // Actual medical video
  },
  {
    'title': 'How to Wash Your Hands',
    'description': 'Proper hand hygiene and washing techniques in medical settings',
    'duration': '7:15',
    'thumbnail': Icons.clean_hands,
    'assetPath': 'assets/videos/How to Wash Your Hands.mp4',
    'isAsset': true,
    'networkUrl': 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
    'youtubeUrl': 'https://www.youtube.com/watch?v=3zElj70dYJ4', // Actual medical video
  },
  {
    'title': 'How to Measure Blood Pressure at Home',
    'description': 'Step-by-step guide for measuring blood pressure at home',
    'duration': '5:30',
    'thumbnail': Icons.monitor_heart,
    'assetPath': 'assets/videos/How to measure your blood pressure at home.mp4',
    'isAsset': true,
    'networkUrl': 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
    'youtubeUrl': 'https://www.youtube.com/watch?v=lpvyCGPsVDU', // Actual medical video
  },
];

final List<Map<String, dynamic>> _medicalAudio = [
  {
    'title': 'Heartbeat Sound',
    'description': 'Real heartbeat audio sample for medical training',
    'duration': '1:30',
    'assetPath': 'assets/audio/Heartbeat sound.mp3',
    'isAsset': true,
  },
  {
    'title': 'Lung Sounds - Clear (Demo)',
    'description': 'Normal breathing pattern audio (placeholder)',
    'duration': '0:45',
    'url': 'lungs_clear.mp3',
    'isAsset': false,
  },
  {
    'title': 'Medical Instruction (Demo)',
    'description': 'Audio guide for medical procedures (placeholder)',
    'duration': '2:30',
    'url': 'instruction.mp3',
    'isAsset': false,
  },
];

class _VideoPlayerScreen extends StatefulWidget {
  final String title;
  final String assetPath;
  final String description;
  final String? networkUrl;

  const _VideoPlayerScreen({
    required this.title,
    required this.assetPath,
    required this.description,
    this.networkUrl,
  });

  @override
  State<_VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<_VideoPlayerScreen> {
  late VideoPlayerController _controller;
  ChewieController? _chewieController;
  bool _isInitialized = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      // For web platform, try network URL first as assets have limitations
      if (widget.networkUrl != null) {
        print('Attempting to load video from network: ${widget.networkUrl}');
        _controller = VideoPlayerController.networkUrl(Uri.parse(widget.networkUrl!));
      } else {
        print('Attempting to load video from assets: ${widget.assetPath}');
        _controller = VideoPlayerController.asset(widget.assetPath);
      }
      
      await _controller.initialize();
      
      _chewieController = ChewieController(
        videoPlayerController: _controller,
        autoPlay: false,
        looping: false,
        showControls: true,
        aspectRatio: _controller.value.aspectRatio,
        materialProgressColors: ChewieProgressColors(
          playedColor: Theme.of(context).primaryColor,
          handleColor: Theme.of(context).primaryColor,
          backgroundColor: Colors.grey,
          bufferedColor: Theme.of(context).primaryColor.withOpacity(0.5),
        ),
        placeholder: Container(
          color: Colors.black,
          child: const Center(
            child: CircularProgressIndicator(color: Colors.orange),
          ),
        ),
        errorBuilder: (context, errorMessage) {
          return Container(
            color: Colors.black,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.orange,
                    size: 60,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Video Playback Error',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      );

      setState(() {
        _isInitialized = true;
      });
      print('Video initialized successfully');
    } catch (e) {
      print('Video loading error: $e');
      setState(() {
        _hasError = true;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Video Player
          Container(
            width: double.infinity,
            height: 250,
            color: Colors.black,
            child: _hasError
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.info,
                          color: Colors.orange,
                          size: 60,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Video Asset Not Available on Web',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Flutter Web has limitations with video assets.',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                        Text(
                          'Videos work better on mobile platforms.',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  )
                : _isInitialized && _chewieController != null
                    ? Chewie(controller: _chewieController!)
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
          ),
          
          // Video Information
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.video_file,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Video file: ${widget.assetPath.split('/').last}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (_isInitialized && !_hasError)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.green[200]!),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green[600],
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              widget.networkUrl != null 
                                  ? 'Video loaded successfully from network. Use the controls to play, pause, and seek.'
                                  : 'Video loaded successfully from assets. Use the controls to play, pause, and seek.',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AudioPlayerScreen extends StatefulWidget {
  final String title;
  final String assetPath;
  final String description;

  const _AudioPlayerScreen({
    required this.title,
    required this.assetPath,
    required this.description,
  });

  @override
  State<_AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<_AudioPlayerScreen> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool _isInitialized = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _setupAudioPlayer();
    _loadAudio();
  }

  void _setupAudioPlayer() {
    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _duration = duration;
      });
    });

    _audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        _position = position;
      });
    });

    _audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        _isPlaying = state == PlayerState.playing;
      });
    });
  }

  Future<void> _loadAudio() async {
    try {
      print('Loading audio from: ${widget.assetPath}');
      await _audioPlayer.setSource(AssetSource(widget.assetPath.replaceFirst('assets/', '')));
      setState(() {
        _isInitialized = true;
      });
      print('Audio loaded successfully');
    } catch (e) {
      print('Audio loading error: $e');
      setState(() {
        _hasError = true;
      });
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Audio Info Card
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Icon(
                      Icons.audiotrack,
                      size: 80,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Audio Controls
            if (_hasError)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red[200]!),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Colors.red[600],
                      size: 48,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Audio Loading Error',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Unable to load the audio file. Please check if the file exists and is in a supported format.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            else if (!_isInitialized)
              const Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Loading audio...'),
                  ],
                ),
              )
            else
              Column(
                children: [
                  // Play/Pause Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () async {
                          if (_isPlaying) {
                            await _audioPlayer.pause();
                          } else {
                            await _audioPlayer.resume();
                          }
                        },
                        icon: Icon(
                          _isPlaying ? Icons.pause_circle : Icons.play_circle,
                          size: 80,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        onPressed: () async {
                          await _audioPlayer.stop();
                        },
                        icon: Icon(
                          Icons.stop_circle,
                          size: 60,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Progress Slider
                  Slider(
                    min: 0,
                    max: _duration.inSeconds.toDouble(),
                    value: _position.inSeconds.toDouble(),
                    onChanged: (value) async {
                      final position = Duration(seconds: value.toInt());
                      await _audioPlayer.seek(position);
                    },
                    activeColor: Theme.of(context).primaryColor,
                  ),
                  
                  // Time Display
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_formatDuration(_position)),
                        Text(_formatDuration(_duration)),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // File Info
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blue[200]!),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.audio_file,
                          color: Colors.blue[600],
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Audio File',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.assetPath.split('/').last,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
