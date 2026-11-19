import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF087F5B);
  static const Color darkGreen = Color(0xFF173B30);
  static const Color background = Color(0xFFF5F8F6);
  static const Color softGreen = Color(0xFFE4F1EA);
  static const Color border = Color(0xFFE4EBE6);
  static const Color muted = Color(0xFF7A8B82);
  static const Color accent = Color(0xFFE9A23B);
}

void main() {
  runApp(const CalorieTrackerApp());
}

class CalorieTrackerApp extends StatelessWidget {
  const CalorieTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Caloria+',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          foregroundColor: AppColors.darkGreen,
          centerTitle: true,
          elevation: 0,
          scrolledUnderElevation: 0,
          titleTextStyle: TextStyle(
            color: AppColors.darkGreen,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          margin: const EdgeInsets.symmetric(vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: const BorderSide(color: AppColors.border),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.white,
          indicatorColor: AppColors.softGreen,
          elevation: 0,
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            final selected = states.contains(WidgetState.selected);
            return TextStyle(
              fontSize: 12,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              color: selected ? AppColors.primary : AppColors.muted,
            );
          }),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

// -----------------------------------------------------------------------------
// 1. TELA DE LOGIN
// -----------------------------------------------------------------------------
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _handleLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      color: AppColors.softGreen,
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: const Icon(
                      Icons.local_fire_department_rounded,
                      size: 48,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Caloria+',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.8,
                      color: AppColors.darkGreen,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Acompanhe sua rotina alimentar',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.muted),
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                      prefixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                      prefixIcon: Icon(Icons.lock_outline),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _handleLogin,
                    child: const Text('Entrar', style: TextStyle(fontSize: 16)),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Não tem uma conta? Cadastre-se'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// NAVEGAÇÃO PRINCIPAL
// -----------------------------------------------------------------------------
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const CalendarScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            selectedIcon: Icon(Icons.calendar_month),
            label: 'Histórico',
          ),
        ],
      ),
    );
  }
}

// Armazenamento temporário em memória: os registros duram enquanto o app estiver aberto.
class FoodEntryStore {
  static final List<Map<String, dynamic>> entries = [];
  static final List<Map<String, dynamic>> savedFoods = [];
  static final ValueNotifier<int> revision = ValueNotifier<int>(0);
  static double calorieGoal = 2000;

  static void add(Map<String, dynamic> entry) {
    entries.add({...entry, 'date': DateTime.now()});
    revision.value++;
  }

  // Atualiza a quantidade e recalcula os nutrientes proporcionalmente.
  static void updateQuantity(Map<String, dynamic> entry, double newGrams) {
    final oldGrams = (entry['grams'] as num).toDouble();
    if (oldGrams <= 0 || newGrams <= 0) return;

    final factor = newGrams / oldGrams;
    entry['grams'] = newGrams;
    entry['calories'] = (entry['calories'] as num).toDouble() * factor;
    entry['protein'] = (entry['protein'] as num).toDouble() * factor;
    entry['carbs'] = (entry['carbs'] as num).toDouble() * factor;
    entry['fat'] = (entry['fat'] as num).toDouble() * factor;
    revision.value++;
  }

  static List<Map<String, dynamic>> get todayEntries {
    final now = DateTime.now();
    return entries.where((entry) {
      final date = entry['date'] as DateTime;
      return date.year == now.year &&
          date.month == now.month &&
          date.day == now.day;
    }).toList();
  }

  static double total(String key, {String? meal}) {
    return todayEntries
        .where((entry) => meal == null || entry['meal'] == meal)
        .fold<double>(0, (sum, entry) => sum + (entry[key] as num).toDouble());
  }
}

// -----------------------------------------------------------------------------
// 2. DASHBOARD
// -----------------------------------------------------------------------------
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  static const double proteinGoal = 120;
  static const double carbsGoal = 200;
  static const double fatGoal = 60;

  @override
  void initState() {
    super.initState();
    // Atualiza o Dashboard sempre que um alimento ou a meta diária mudar,
    // inclusive enquanto a tela de adicionar alimento estiver aberta.
    FoodEntryStore.revision.addListener(_refreshDashboard);
  }

  void _refreshDashboard() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    FoodEntryStore.revision.removeListener(_refreshDashboard);
    super.dispose();
  }

  Future<void> _openAddFoodScreen(String mealName) async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => AddFoodScreen(mealName: mealName),
      ),
    );

    if (!mounted || result == null) return;
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.darkGreen,
      ),
    );
  }

  Future<void> _editCalorieGoal() async {
    final controller = TextEditingController(
      text: FoodEntryStore.calorieGoal.round().toString(),
    );

    final newGoal = await showDialog<double>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Meta diária de calorias',
          style: TextStyle(
            color: AppColors.darkGreen,
            fontWeight: FontWeight.w800,
          ),
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Sua meta diária',
            suffixText: 'kcal',
            hintText: 'Ex.: 2000',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              final value = double.tryParse(controller.text.trim());
              if (value != null && value > 0) {
                Navigator.pop(dialogContext, value);
              }
            },
            child: const Text('Salvar meta'),
          ),
        ],
      ),
    );

    controller.dispose();
    if (newGoal == null || !mounted) return;

    setState(() => FoodEntryStore.calorieGoal = newGoal);
    FoodEntryStore.revision.value++;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Meta diária atualizada para ${newGoal.round()} kcal.'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.darkGreen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dateLabel =
        '${now.day.toString().padLeft(2, '0')}/'
        '${now.month.toString().padLeft(2, '0')}/${now.year}';

    final consumed = FoodEntryStore.total('calories');
    final protein = FoodEntryStore.total('protein');
    final carbs = FoodEntryStore.total('carbs');
    final fat = FoodEntryStore.total('fat');
    final remaining = FoodEntryStore.calorieGoal - consumed;

    String mealSummary(String meal) {
      final items = FoodEntryStore.todayEntries
          .where((entry) => entry['meal'] == meal)
          .toList();
      if (items.isEmpty) return 'Nenhum alimento adicionado';
      return items.map((entry) => entry['name'] as String).join(', ');
    }

    String mealCalories(String meal) {
      final value = FoodEntryStore.total('calories', meal: meal);
      return '${value.round()} kcal';
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: AppColors.softGreen,
                borderRadius: BorderRadius.circular(11),
              ),
              child: const Icon(
                Icons.local_fire_department_rounded,
                color: AppColors.primary,
                size: 21,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'Caloria+',
              style: TextStyle(
                color: AppColors.darkGreen,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            tooltip: 'Sair',
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Seu resumo de hoje',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.darkGreen,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.6,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              dateLabel,
              style: const TextStyle(color: AppColors.muted, fontSize: 13),
            ),
            const SizedBox(height: 20),
            _CalorieSummaryCard(
              consumed: consumed,
              goal: FoodEntryStore.calorieGoal,
              remaining: remaining,
              onEditGoal: _editCalorieGoal,
            ),
            const SizedBox(height: 26),
            const _DashboardSectionTitle(
              title: 'Macronutrientes',
              subtitle: 'Valores registrados hoje',
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _MacroCard(
                    title: 'Proteínas',
                    current: protein.round(),
                    target: proteinGoal.round(),
                    color: const Color(0xFF438B75),
                  ),
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: _MacroCard(
                    title: 'Carboidratos',
                    current: carbs.round(),
                    target: carbsGoal.round(),
                    color: const Color(0xFFE9A23B),
                  ),
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: _MacroCard(
                    title: 'Gorduras',
                    current: fat.round(),
                    target: fatGoal.round(),
                    color: const Color(0xFFD97964),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 26),
            const _DashboardSectionTitle(
              title: 'Refeições',
              subtitle: 'Adicione o que você comeu',
            ),
            const SizedBox(height: 10),
            _buildMealCard(
              'Café da Manhã',
              'Café da manhã',
              Icons.wb_sunny_outlined,
              mealCalories,
              mealSummary,
            ),
            _buildMealCard(
              'Almoço',
              'Almoço',
              Icons.lunch_dining_outlined,
              mealCalories,
              mealSummary,
            ),
            _buildMealCard(
              'Lanche da Tarde',
              'Lanche da tarde',
              Icons.coffee_outlined,
              mealCalories,
              mealSummary,
            ),
            _buildMealCard(
              'Jantar',
              'Jantar',
              Icons.nightlight_outlined,
              mealCalories,
              mealSummary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMealCard(
    String meal,
    String title,
    IconData icon,
    String Function(String) calories,
    String Function(String) summary,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 9),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MealDetailScreen(
                mealName: meal,
                title: title,
                icon: icon,
              ),
            ),
          );
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.softGreen,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: AppColors.primary, size: 22),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.darkGreen,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            '${calories(meal)}\n${summary(meal)}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: AppColors.muted, fontSize: 11),
          ),
        ),
        isThreeLine: true,
        trailing: IconButton(
          tooltip: 'Adicionar alimento',
          onPressed: () => _openAddFoodScreen(meal),
          style: IconButton.styleFrom(
            backgroundColor: AppColors.softGreen,
            foregroundColor: AppColors.primary,
          ),
          icon: const Icon(Icons.add_rounded),
        ),
      ),
    );
  }
}

class _DashboardSectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? trailing;

  const _DashboardSectionTitle({
    required this.title,
    required this.subtitle,
  }) : trailing = null;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.darkGreen,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: const TextStyle(color: AppColors.muted, fontSize: 12),
              ),
            ],
          ),
        ),
        ?trailing,
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// 3. TELA DE ADICIONAR ALIMENTO
// -----------------------------------------------------------------------------
class AddFoodScreen extends StatefulWidget {
  final String mealName;

  const AddFoodScreen({super.key, required this.mealName});

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _searchController = TextEditingController();

  final _foodNameController = TextEditingController();
  final _weightController = TextEditingController(text: '100');
  final _proteinController = TextEditingController();
  final _carbsController = TextEditingController();
  final _fatController = TextEditingController();
  final _caloriesController = TextEditingController();

  bool _isManualCalories = false;
  String _searchQuery = '';

  // Valores nutricionais de referência para cada 100 g.
  // São exemplos locais; ainda não vêm de uma API ou banco de dados.
  final List<Map<String, dynamic>> _foods = [
    {
      'name': 'Arroz branco cozido',
      'category': 'Grãos',
      'calories': 130.0,
      'protein': 2.7,
      'carbs': 28.2,
      'fat': 0.3,
      'icon': Icons.rice_bowl_rounded,
    },
    {
      'name': 'Peito de frango grelhado',
      'category': 'Carnes',
      'calories': 159.0,
      'protein': 32.0,
      'carbs': 0.0,
      'fat': 2.5,
      'icon': Icons.egg_alt_rounded,
    },
    {
      'name': 'Ovo cozido',
      'category': 'Proteínas',
      'calories': 155.0,
      'protein': 13.0,
      'carbs': 1.1,
      'fat': 11.0,
      'icon': Icons.egg_rounded,
    },
    {
      'name': 'Banana',
      'category': 'Frutas',
      'calories': 89.0,
      'protein': 1.1,
      'carbs': 22.8,
      'fat': 0.3,
      'icon': Icons.spa_rounded,
    },
    {
      'name': 'Batata-doce cozida',
      'category': 'Legumes',
      'calories': 86.0,
      'protein': 1.6,
      'carbs': 20.1,
      'fat': 0.1,
      'icon': Icons.grass_rounded,
    },
    {
      'name': 'Aveia em flocos',
      'category': 'Grãos',
      'calories': 394.0,
      'protein': 13.9,
      'carbs': 66.6,
      'fat': 8.5,
      'icon': Icons.grain_rounded,
    },
    {
      'name': 'Leite integral',
      'category': 'Laticínios',
      'calories': 61.0,
      'protein': 3.2,
      'carbs': 4.7,
      'fat': 3.3,
      'icon': Icons.local_drink_rounded,
    },
    {
      'name': 'Feijão carioca cozido',
      'category': 'Grãos',
      'calories': 76.0,
      'protein': 4.8,
      'carbs': 13.6,
      'fat': 0.5,
      'icon': Icons.soup_kitchen_rounded,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.trim().toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    _foodNameController.dispose();
    _weightController.dispose();
    _proteinController.dispose();
    _carbsController.dispose();
    _fatController.dispose();
    _caloriesController.dispose();
    super.dispose();
  }

  double _numberFrom(TextEditingController controller) {
    return double.tryParse(controller.text.trim().replaceAll(',', '.')) ?? 0;
  }

  String _formatNumber(double value) {
    return value.toStringAsFixed(1).replaceAll('.', ',');
  }

  void _calculateCalories() {
    if (_isManualCalories) return;

    final protein = _numberFrom(_proteinController);
    final carbs = _numberFrom(_carbsController);
    final fat = _numberFrom(_fatController);
    final totalCalories = (protein * 4) + (carbs * 4) + (fat * 9);

    _caloriesController.text = totalCalories.round().toString();
  }

  Future<void> _selectFood(Map<String, dynamic> food) async {
    final quantityController = TextEditingController(text: '100');

    final result = await showDialog<double>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            final quantity =
                double.tryParse(
                  quantityController.text.trim().replaceAll(',', '.'),
                ) ??
                0;
            final factor = quantity / 100;
            final calories = (food['calories'] as double) * factor;

            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
              title: Text(
                food['name'] as String,
                style: const TextStyle(
                  color: AppColors.darkGreen,
                  fontWeight: FontWeight.w800,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Quantidade consumida',
                    style: TextStyle(color: AppColors.muted),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: quantityController,
                    autofocus: true,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    onChanged: (_) => setDialogState(() {}),
                    decoration: const InputDecoration(
                      suffixText: 'g',
                      hintText: 'Ex.: 150',
                    ),
                  ),
                  const SizedBox(height: 18),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${calories.round()} kcal',
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 23,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Proteínas  ${_formatNumber((food['protein'] as double) * factor)} g',
                        ),
                        Text(
                          'Carboidratos  ${_formatNumber((food['carbs'] as double) * factor)} g',
                        ),
                        Text(
                          'Gorduras  ${_formatNumber((food['fat'] as double) * factor)} g',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: quantity > 0
                      ? () => Navigator.pop(dialogContext, quantity)
                      : null,
                  child: const Text('Adicionar'),
                ),
              ],
            );
          },
        );
      },
    );

    quantityController.dispose();

    if (result == null || !mounted) return;

    final factor = result / 100;
    final calories = (food['calories'] as double) * factor;
    final protein = (food['protein'] as double) * factor;
    final carbs = (food['carbs'] as double) * factor;
    final fat = (food['fat'] as double) * factor;

    FoodEntryStore.add({
      'meal': widget.mealName,
      'name': food['name'] as String,
      'grams': result,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${food['name']} adicionado (${result.round()} g • ${calories.round()} kcal)',
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.darkGreen,
      ),
    );
  }

  void _saveManualFood() {
    final name = _foodNameController.text.trim();
    final quantity = _numberFrom(_weightController);
    final calories = _numberFrom(_caloriesController);

    if (name.isEmpty || quantity <= 0 || calories < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Informe o alimento e uma quantidade válida.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final protein = _numberFrom(_proteinController);
    final carbs = _numberFrom(_carbsController);
    final fat = _numberFrom(_fatController);

    FoodEntryStore.add({
      'meal': widget.mealName,
      'name': name,
      'grams': quantity,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
    });

    // Guarda os valores nutricionais normalizados por 100 g no catálogo.
    final factorTo100g = 100 / quantity;
    final savedFood = <String, dynamic>{
      'name': name,
      'category': 'Personalizados',
      'calories': calories * factorTo100g,
      'protein': protein * factorTo100g,
      'carbs': carbs * factorTo100g,
      'fat': fat * factorTo100g,
      'icon': Icons.restaurant_rounded,
    };

    final existingIndex = FoodEntryStore.savedFoods.indexWhere(
      (food) => (food['name'] as String).toLowerCase() == name.toLowerCase(),
    );

    if (existingIndex >= 0) {
      FoodEntryStore.savedFoods[existingIndex] = savedFood;
    } else {
      FoodEntryStore.savedFoods.add(savedFood);
    }

    setState(() {
      _foodNameController.clear();
      _weightController.text = '100';
      _proteinController.clear();
      _carbsController.clear();
      _fatController.clear();
      _caloriesController.clear();
      _isManualCalories = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$name adicionado à refeição e salvo em Alimentos '
          '(${quantity.round()} g • ${calories.round()} kcal)',
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.darkGreen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final allFoods = [..._foods, ...FoodEntryStore.savedFoods];
    final filteredFoods = allFoods.where((food) {
      final name = (food['name'] as String).toLowerCase();
      final category = (food['category'] as String).toLowerCase();
      return name.contains(_searchQuery) || category.contains(_searchQuery);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Adicionar alimento'),
            Text(
              widget.mealName,
              style: const TextStyle(
                color: AppColors.muted,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.muted,
          indicatorColor: AppColors.primary,
          indicatorWeight: 3,
          tabs: const [
            Tab(text: 'Alimentos', icon: Icon(Icons.search_rounded)),
            Tab(text: 'Registro manual', icon: Icon(Icons.edit_note_rounded)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildFoodCatalog(filteredFoods), _buildManualForm()],
      ),
    );
  }

  Widget _buildFoodCatalog(List<Map<String, dynamic>> foods) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 12),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Buscar alimento...',
              prefixIcon: const Icon(Icons.search_rounded),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      tooltip: 'Limpar busca',
                      onPressed: _searchController.clear,
                      icon: const Icon(Icons.close_rounded),
                    )
                  : null,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  'Alimentos disponíveis',
                  style: TextStyle(
                    color: AppColors.darkGreen,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Text(
                '${foods.length} itens',
                style: const TextStyle(color: AppColors.muted, fontSize: 12),
              ),
            ],
          ),
        ),
        Expanded(
          child: foods.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off_rounded,
                        size: 48,
                        color: AppColors.muted,
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Nenhum alimento encontrado',
                        style: TextStyle(
                          color: AppColors.muted,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Tente buscar por outro nome.',
                        style: TextStyle(color: AppColors.muted, fontSize: 12),
                      ),
                    ],
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),
                  itemCount: foods.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final food = foods[index];
                    return Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () => _selectFood(food),
                        child: Container(
                          padding: const EdgeInsets.all(13),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 46,
                                height: 46,
                                decoration: BoxDecoration(
                                  color: AppColors.softGreen,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Icon(
                                  food['icon'] as IconData,
                                  color: AppColors.primary,
                                  size: 23,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      food['name'] as String,
                                      style: const TextStyle(
                                        color: AppColors.darkGreen,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${food['category']} • por 100 g',
                                      style: const TextStyle(
                                        color: AppColors.muted,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${(food['calories'] as double).round()}',
                                    style: const TextStyle(
                                      color: AppColors.darkGreen,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const Text(
                                    'kcal',
                                    style: TextStyle(
                                      color: AppColors.muted,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 5),
                              const Icon(
                                Icons.add_circle_outline_rounded,
                                color: AppColors.primary,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildManualForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Informações do alimento',
            style: TextStyle(
              color: AppColors.darkGreen,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Preencha os dados nutricionais para registrar seu alimento.',
            style: TextStyle(color: AppColors.muted, fontSize: 12),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _foodNameController,
            decoration: const InputDecoration(
              labelText: 'Nome do alimento',
              prefixIcon: Icon(Icons.restaurant_menu_rounded),
            ),
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: _weightController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'Quantidade consumida',
              prefixIcon: Icon(Icons.scale_outlined),
              suffixText: 'g',
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Macronutrientes',
            style: TextStyle(
              color: AppColors.darkGreen,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _buildMacroInput(
                  controller: _proteinController,
                  label: 'Proteínas',
                  onChanged: (_) => _calculateCalories(),
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: _buildMacroInput(
                  controller: _carbsController,
                  label: 'Carboidratos',
                  onChanged: (_) => _calculateCalories(),
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: _buildMacroInput(
                  controller: _fatController,
                  label: 'Gorduras',
                  onChanged: (_) => _calculateCalories(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _caloriesController,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                _isManualCalories = value.isNotEmpty;
              });
            },
            decoration: InputDecoration(
              labelText: 'Calorias',
              prefixIcon: const Icon(Icons.local_fire_department_outlined),
              suffixText: 'kcal',
              helperText: _isManualCalories
                  ? 'Valor informado manualmente'
                  : 'Calculado automaticamente pelos macronutrientes',
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _saveManualFood,
              icon: const Icon(Icons.add_rounded),
              label: const Text('Adicionar à refeição'),
            ),
          ),
          const SizedBox(height: 8),
          const Center(
            child: Text(
              'Os dados serão usados nesta demonstração local.',
              style: TextStyle(color: AppColors.muted, fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMacroInput({
    required TextEditingController controller,
    required String label,
    required ValueChanged<String> onChanged,
  }) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        suffixText: 'g',
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 15,
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// COMPONENTES AUXILIARES DO DASHBOARD
// -----------------------------------------------------------------------------
class _CalorieSummaryCard extends StatelessWidget {
  final double consumed;
  final double goal;
  final double remaining;
  final VoidCallback onEditGoal;

  const _CalorieSummaryCard({
    required this.consumed,
    required this.goal,
    required this.remaining,
    required this.onEditGoal,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (consumed / goal).clamp(0.0, 1.0);
    final remainingLabel = remaining >= 0 ? remaining.round() : 0;

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.local_fire_department_outlined,
                  color: AppColors.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Calorias do dia',
                    style: TextStyle(
                      color: AppColors.darkGreen,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: onEditGoal,
                  icon: const Icon(Icons.edit_rounded, size: 15),
                  label: const Text('Editar meta'),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    visualDensity: VisualDensity.compact,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Restantes',
                        style: TextStyle(color: AppColors.muted, fontSize: 13),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$remainingLabel',
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: 38,
                          height: 1.1,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -1.2,
                        ),
                      ),
                      const Text(
                        'kcal disponíveis',
                        style: TextStyle(color: AppColors.muted, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 94,
                  height: 94,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 88,
                        height: 88,
                        child: CircularProgressIndicator(
                          value: progress,
                          strokeWidth: 9,
                          strokeCap: StrokeCap.round,
                          backgroundColor: AppColors.softGreen,
                          color: AppColors.primary,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${(progress * 100).round()}%',
                            style: const TextStyle(
                              color: AppColors.darkGreen,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const Text(
                            'consumido',
                            style: TextStyle(
                              color: AppColors.muted,
                              fontSize: 9,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(color: AppColors.border, height: 1),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: _CalorieInfo(
                    label: 'Consumidas',
                    value: '${consumed.round()} kcal',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _CalorieInfo(
                    label: 'Meta diária',
                    value: '${goal.round()} kcal',
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

class _CalorieInfo extends StatelessWidget {
  final String label;
  final String value;

  const _CalorieInfo({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: AppColors.muted, fontSize: 11),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.darkGreen,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _MacroCard extends StatelessWidget {
  final String title;
  final int current;
  final int target;
  final Color color;

  const _MacroCard({
    required this.title,
    required this.current,
    required this.target,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = (current / target).clamp(0.0, 1.0);

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 9,
              height: 9,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(height: 9),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.darkGreen,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 5),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                '${current}g',
                style: const TextStyle(
                  color: AppColors.darkGreen,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Text(
              'de ${target}g',
              style: const TextStyle(color: AppColors.muted, fontSize: 10),
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                value: progress,
                color: color,
                backgroundColor: color.withValues(alpha: 0.14),
                minHeight: 6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MealSectionCard extends StatelessWidget {
  final String title;
  final String calories;
  final IconData icon;
  final VoidCallback onAddTap;

  const _MealSectionCard({
    required this.title,
    required this.calories,
    required this.icon,
    required this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 9),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.softGreen,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: AppColors.primary, size: 22),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.darkGreen,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            calories,
            style: const TextStyle(color: AppColors.muted, fontSize: 12),
          ),
        ),
        trailing: IconButton(
          tooltip: 'Adicionar alimento',
          onPressed: onAddTap,
          style: IconButton.styleFrom(
            backgroundColor: AppColors.softGreen,
            foregroundColor: AppColors.primary,
          ),
          icon: const Icon(Icons.add_rounded),
        ),
      ),
    );
  }
}


// -----------------------------------------------------------------------------
// TELA DE DETALHES DA REFEIÇÃO / EDIÇÃO DE QUANTIDADES
// -----------------------------------------------------------------------------
class MealDetailScreen extends StatelessWidget {
  final String mealName;
  final String title;
  final IconData icon;

  const MealDetailScreen({
    super.key,
    required this.mealName,
    required this.title,
    required this.icon,
  });

  Future<void> _editQuantity(
    BuildContext context,
    Map<String, dynamic> entry,
  ) async {
    final controller = TextEditingController(
      text: (entry['grams'] as num).toStringAsFixed(
        (entry['grams'] as num) % 1 == 0 ? 0 : 1,
      ),
    );

    final newQuantity = await showDialog<double>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          'Editar quantidade',
          style: const TextStyle(
            color: AppColors.darkGreen,
            fontWeight: FontWeight.w800,
          ),
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'Quantidade',
            suffixText: 'g',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              final value = double.tryParse(
                controller.text.trim().replaceAll(',', '.'),
              );
              if (value != null && value > 0) {
                Navigator.pop(dialogContext, value);
              }
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );

    controller.dispose();

    if (newQuantity == null) return;
    FoodEntryStore.updateQuantity(entry, newQuantity);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Quantidade atualizada.'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.darkGreen,
        ),
      );
    }
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: false,
      ),
      body: ValueListenableBuilder<int>(
        valueListenable: FoodEntryStore.revision,
        builder: (context, revision, child) {
          final mealEntries = FoodEntryStore.entries.where((entry) {
            final date = entry['date'] as DateTime;
            return entry['meal'] == mealName && _isToday(date);
          }).toList();

          final totalCalories = mealEntries.fold<double>(
            0,
            (sum, entry) =>
                sum + (entry['calories'] as num).toDouble(),
          );

          if (mealEntries.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, size: 54, color: AppColors.muted),
                    const SizedBox(height: 14),
                    Text(
                      'Nenhum alimento em $title',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.darkGreen,
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Os alimentos adicionados a esta refeição aparecerão aqui.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.muted, fontSize: 13),
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
            children: [
              Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Total da refeição',
                              style: TextStyle(
                                color: AppColors.muted,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${totalCalories.round()} kcal',
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontSize: 25,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: AppColors.softGreen,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(icon, color: AppColors.primary, size: 24),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Alimentos adicionados',
                style: TextStyle(
                  color: AppColors.darkGreen,
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              ...mealEntries.map((entry) {
                final grams = (entry['grams'] as num).toDouble();
                final calories = (entry['calories'] as num).toDouble();
                final protein = (entry['protein'] as num).toDouble();
                final carbs = (entry['carbs'] as num).toDouble();
                final fat = (entry['fat'] as num).toDouble();

                return Card(
                  key: ObjectKey(entry),
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                entry['name'] as String,
                                style: const TextStyle(
                                  color: AppColors.darkGreen,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            IconButton(
                              tooltip: 'Editar quantidade',
                              onPressed: () => _editQuantity(context, entry),
                              icon: const Icon(
                                Icons.edit_outlined,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '${grams.toStringAsFixed(grams % 1 == 0 ? 0 : 1)} g',
                          style: const TextStyle(
                            color: AppColors.muted,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${calories.round()} kcal',
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Proteínas ${protein.toStringAsFixed(1)} g  •  '
                          'Carboidratos ${carbs.toStringAsFixed(1)} g  •  '
                          'Gorduras ${fat.toStringAsFixed(1)} g',
                          style: const TextStyle(
                            color: AppColors.muted,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 4. CALENDÁRIO / HISTÓRICO
// -----------------------------------------------------------------------------
class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDate = DateTime.now();

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico por Data'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<int>(
        valueListenable: FoodEntryStore.revision,
        builder: (context, revision, child) {
          final dayEntries = FoodEntryStore.entries.where((entry) {
            final entryDate = entry['date'] as DateTime;
            return _isSameDay(entryDate, _selectedDate);
          }).toList();

          final consumed = dayEntries.fold<double>(
            0,
            (sum, entry) => sum + (entry['calories'] as num).toDouble(),
          );
          final goal = FoodEntryStore.calorieGoal;
          final progress = goal > 0 ? (consumed / goal).clamp(0.0, 1.0) : 0.0;
          final remaining = (goal - consumed).round();

          const meals = [
            'Café da manhã',
            'Almoço',
            'Lanche da tarde',
            'Jantar',
          ];

          final hasEntries = dayEntries.isNotEmpty;

          return Column(
            children: [
              CalendarDatePicker(
                initialDate: _selectedDate,
                firstDate: DateTime(2020),
                lastDate: DateTime.now(),
                currentDate: DateTime.now(),
                onDateChanged: (newDate) {
                  setState(() => _selectedDate = newDate);
                },
              ),
              const Divider(height: 1, color: AppColors.border),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
                  children: [
                    Text(
                      'Resumo de ${_formatDate(_selectedDate)}',
                      style: const TextStyle(
                        color: AppColors.darkGreen,
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Card(
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.local_fire_department_rounded,
                                  color: AppColors.primary,
                                ),
                                const SizedBox(width: 8),
                                const Expanded(
                                  child: Text(
                                    'Calorias consumidas',
                                    style: TextStyle(
                                      color: AppColors.darkGreen,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${consumed.round()} kcal',
                                  style: const TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: LinearProgressIndicator(
                                value: progress,
                                minHeight: 8,
                                color: AppColors.primary,
                                backgroundColor: AppColors.softGreen,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Meta: ${goal.round()} kcal',
                                  style: const TextStyle(
                                    color: AppColors.muted,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  remaining >= 0
                                      ? 'Restam $remaining kcal'
                                      : '${remaining.abs()} kcal acima da meta',
                                  style: const TextStyle(
                                    color: AppColors.muted,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    const Text(
                      'Refeições registradas',
                      style: TextStyle(
                        color: AppColors.darkGreen,
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (!hasEntries)
                      Card(
                        margin: EdgeInsets.zero,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 28,
                          ),
                          child: Column(
                            children: const [
                              Icon(
                                Icons.restaurant_outlined,
                                size: 42,
                                color: AppColors.muted,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Nenhum alimento registrado',
                                style: TextStyle(
                                  color: AppColors.darkGreen,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Os alimentos adicionados nesta data aparecerão aqui.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.muted,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      ...meals.map((meal) {
                        final mealEntries = dayEntries
                            .where((entry) => entry['meal'] == meal)
                            .toList();

                        if (mealEntries.isEmpty) {
                          return const SizedBox.shrink();
                        }

                        final mealCalories = mealEntries.fold<double>(
                          0,
                          (sum, entry) =>
                              sum + (entry['calories'] as num).toDouble(),
                        );

                        return Card(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        meal,
                                        style: const TextStyle(
                                          color: AppColors.darkGreen,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${mealCalories.round()} kcal',
                                      style: const TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(height: 18),
                                ...mealEntries.map((entry) {
                                  final grams =
                                      (entry['grams'] as num).toDouble();
                                  final calories =
                                      (entry['calories'] as num).toDouble();

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.circle,
                                          size: 7,
                                          color: AppColors.accent,
                                        ),
                                        const SizedBox(width: 9),
                                        Expanded(
                                          child: Text(
                                            entry['name'] as String,
                                            style: const TextStyle(
                                              color: AppColors.darkGreen,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '${grams.round()} g • ${calories.round()} kcal',
                                          style: const TextStyle(
                                            color: AppColors.muted,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        );
                      }),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
