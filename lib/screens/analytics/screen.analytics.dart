part of 'widget.analytics.dart';

class AnalytiqueScreen extends StatefulWidget {
  const AnalytiqueScreen({super.key});

  static const String path = '/analytique';
  static const String name = 'Analytique';

  @override
  State<AnalytiqueScreen> createState() => _AnalytiqueScreenState();
}

class _AnalytiqueScreenState extends State<AnalytiqueScreen> {
  final TaskService _taskService = TaskService();
  bool _isLoading = true;
  List<Task> _tasks = [];
  int _inProgressCount = 0;
  int _completedCount = 0;
  String _totalWorkingHours = '00:00:00';
  int _totalTasks = 0;

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    try {
      setState(() => _isLoading = true);

      // Charger les tâches
      final tasks = await _taskService.getTasks();

      // Calculer les statistiques
      final inProgress = tasks.where((t) => t.status == 'in_progress').length;
      final completed = tasks.where((t) => t.status == 'completed').length;

      // Calculer le temps total de travail

      // final totalMinutes = tasks.totalWorkHours(
      //   0,
      //   tasks.map((t) => t.totalWorkHours).fold(0, (a, b) => a + b) * 60,
      // );
      // final hours = totalMinutes ~/ 60;
      // final minutes = totalMinutes % 60;
      // final timeString =
      //     '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:00';

      setState(() {
        _tasks = tasks;
        _inProgressCount = inProgress;
        _completedCount = completed;
        // _totalWorkingHours = timeString;
        _totalTasks = tasks.length;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      // Afficher une snackbar d'erreur
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur lors du chargement des données: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Dashboard',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadDashboardData,
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadDashboardData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Project Summary',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Let\'s Finish Your Project For Today!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: ProjectSummaryCard(
                        count: _inProgressCount,
                        label: 'In Progress Project',
                        color: const Color(0xFF8B80F8),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ProjectSummaryCard(
                        count: _completedCount,
                        label: 'Project Completed',
                        color: const Color(0xFF69C7C7),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Project Statistics',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '$_totalTasks Tasks',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const ProjectStatisticsChart(),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: TaskActivityCard(
                        title: 'Total Working Hour',
                        value: _totalWorkingHours,
                        progress: 0.7,
                        progressColor: const Color(0xFFFFA726),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TaskActivityCard(
                        title: 'Total Task Activity',
                        value: '$_totalTasks Task',
                        progress: 0.85,
                        progressColor: const Color(0xFF69C7C7),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder_outlined),
            label: 'Projects',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            label: 'Notifications',
          ),
        ],
      ),
    );
  }
}
