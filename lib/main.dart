import 'package:flutter/material.dart';

void main() {
  runApp(const MiRutinaApp());
}

class MiRutinaApp extends StatelessWidget {
  const MiRutinaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rutinas de Ada',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFC8A2C8),
          primary: const Color(0xFFB388FF),
          secondary: const Color(0xFFEA80FC),
          surface: const Color(0xFFFAF4FF),
        ),
      ),
      home: const RutinasPage(),
    );
  }
}

class Tarea {
  String titulo;
  String hora;
  bool completada;

  Tarea({
    required this.titulo,
    required this.hora,
    this.completada = false,
  });
}

class RutinasPage extends StatefulWidget {
  const RutinasPage({super.key});

  @override
  State<RutinasPage> createState() => _RutinasPageState();
}

class _RutinasPageState extends State<RutinasPage> {
  final List<Tarea> _rutinas = [
    Tarea(titulo: '🎀 Skincare Kawaii & Despertar', hora: '07:00 AM'),
    Tarea(titulo: '🥐 Desayuno & Café Anime', hora: '08:00 AM'),
    Tarea(titulo: '💻 Tiempo de Estudio / Trabajo', hora: '09:00 AM'),
    Tarea(titulo: '🍱 Almuerzo Delicioso', hora: '01:30 PM'),
    Tarea(titulo: '🧘‍♀️ Ejercicio / Yoga Suave', hora: '05:00 PM'),
    Tarea(titulo: '🌙 Maratón de Anime & Relax', hora: '09:30 PM'),
  ];

  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _horaController = TextEditingController();

  void _agregarRutina() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        backgroundColor: const Color(0xFFF5E6FF),
        title: const Text(
          '✨ Nueva Rutina Kawaii ✨',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF7B1FA2),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _tituloController,
              decoration: InputDecoration(
                labelText: '🌸 Actividad',
                labelStyle: const TextStyle(color: Color(0xFF9C27B0)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _horaController,
              decoration: InputDecoration(
                labelText: '⏰ Hora (ej. 08:00 AM)',
                labelStyle: const TextStyle(color: Color(0xFF9C27B0)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              _tituloController.clear();
              _horaController.clear();
              Navigator.pop(context);
            },
            child: const Text('Cancelar', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFAB47BC),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            ),
            onPressed: () {
              if (_tituloController.text.isNotEmpty && _horaController.text.isNotEmpty) {
                setState(() {
                  _rutinas.add(
                    Tarea(
                      titulo: _tituloController.text,
                      hora: _horaController.text,
                    ),
                  );
                });
                _tituloController.clear();
                _horaController.clear();
                Navigator.pop(context);
              }
            },
            child: const Text('Guardar 💖', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _eliminarRutina(int index) {
    setState(() {
      _rutinas.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    int completadas = _rutinas.where((t) => t.completada).length;

    return Scaffold(
      backgroundColor: const Color(0xFFF3E5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE1BEE7), Color(0xFFCE93D8), Color(0xFFB39DDB)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF8E24AA).withValues(alpha: 0.25),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purple.withValues(alpha: 0.2),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: const Text(
                        '🐱‍👤',
                        style: TextStyle(fontSize: 32),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '¡Hola, Ada! ✨💖',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4A148C),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _rutinas.isEmpty
                                ? 'Organiza tu día hermoso 🌸'
                                : '$completadas de ${_rutinas.length} rutinas completadas 🎉',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF6A1B9A),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                'Mi Itinerario Kawaii 💜🌸',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6A1B9A),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: _rutinas.isEmpty
                    ? const Center(
                        child: Text(
                          'No tienes rutinas hoy, ¡a descansar! 🌺',
                          style: TextStyle(color: Color(0xFFAB47BC), fontSize: 16),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _rutinas.length,
                        itemBuilder: (context, index) {
                          final rutina = _rutinas[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: rutina.completada
                                  ? const Color(0xFFF3E8FF).withValues(alpha: 0.7)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(22),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.purple.withValues(alpha: 0.08),
                                  blurRadius: 12,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 6,
                              ),
                              leading: Checkbox(
                                activeColor: const Color(0xFFAB47BC),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                value: rutina.completada,
                                onChanged: (bool? value) {
                                  setState(() {
                                    rutina.completada = value ?? false;
                                  });
                                },
                              ),
                              title: Text(
                                rutina.titulo,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: rutina.completada
                                      ? Colors.purple.shade200
                                      : const Color(0xFF4A148C),
                                  decoration: rutina.completada
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.access_time_filled_rounded,
                                      size: 15,
                                      color: Color(0xFFCE93D8),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      rutina.hora,
                                      style: TextStyle(
                                        color: Colors.purple.shade300,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete_outline_rounded,
                                  color: Color(0xFFFF80AB),
                                ),
                                onPressed: () => _eliminarRutina(index),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _agregarRutina,
        backgroundColor: const Color(0xFFAB47BC),
        elevation: 6,
        icon: const Icon(Icons.add_rounded, color: Colors.white, size: 28),
        label: const Text(
          'Agregar ✨',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}