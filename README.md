# middleware_technology
 Middleware Technology - REST API

Twelve Factor Principles:

1. Codebasis
Der Code wird mit dem Versionsmanagementsystem Git/Github verwaltet.

2. Abhängigkeiten
Das Flutter Frontend benutzt die pubspec.yaml um externe Abhängigkeiten zu verwalten. Hier als Beispiel die externe Abhängigkeit des http Packages.

3. Konfiguration
Die Umgebungsvariablen wurden in der umgebungsvariablen.env Datei im Flutter Projekt abgelegt. Die Backend URL wird als Umgebungsvariable gesetzt und verwaltet.

4. Unterstützende Dienste
In einem Flutter Projekt kann über die pubspec.yaml Datei Datenbanken Packages an die App angehängt werden. Es könnte hier beispielsweise eine Hive Datenbank angebunden werden.

5. Build, release, run
Durch die Konfigurationsdatei umgebungsvariablen.env kann die Applikation mit unterschiedlichen Konfigurationen in verschiedenen Umgebungen laufen.

6. Prozesse
Die App wird mit einem Frontend und einem getrennten Backend ausgeführt, die unabhängig voneinander skaliert werden können.

7. Bindung an Ports
Das Backend läuft immer auf dem Port 8080.

8. Nebenläufigkeit
Das Frontend und Backend kann unabhängig voneinander skaliert werden, weil diese beiden Prozesse jeweils in eigenen Docker Containern laufen und somit horizontal skaliert werden können.

9. Einweggebrauch
Das Frontend und Backend lassen sich jeweils in den IDEs schnell starten und stoppen für schnelle Entwicklungszyklen.

10. Dev-Prod-Vergleichbarkeit
Da die Prozesse in Docker laufen können diese gut verglichen werden zwischen Dev und Prod.

11. Logs
Da die Anwendung in Docker Containern läuft, liegt die Verantwortung für die Logs bei Docker und nicht direkt bei der Anwendung selbst. Die Logs können dann in den jeweiligen Docker Containern eingesehen und ggf. ausgewertet werden.

12. Admin-Prozesse
Prozesse wie beispielsweise die Migration von Daten von bspw. hinzufügen von neuen Feldern zu den Items (Kategorie, Rabatte, etc.) sollten dann außerhalb der Anwendung einmalig stattfinden und nicht innerhalb der eigentlichen Anwendung.
