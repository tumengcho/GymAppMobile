enum ActivityLevel {
  sedentary(1.2, "Sédentaire (peu ou pas d'exercice)"),
  lightlyActive(1.375, "Légèrement actif (1–3 jours/semaine)"),
  moderatelyActive(1.55, "Modérément actif (3–5 jours/semaine)"),
  veryActive(1.725, "Très actif (6–7 jours/semaine)"),
  extraActive(1.9, "Extra actif (travail ou entraînement intensif)");

  final double multiplier;
  final String description;

  const ActivityLevel(this.multiplier, this.description);
}
