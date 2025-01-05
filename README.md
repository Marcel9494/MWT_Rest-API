# middleware_technology
 Middleware Technology - REST API

Twelve Factor Principles:

1. Code base
The code is managed with the version management system Git/Github.

2. Dependencies
The Flutter frontend uses pubspec.yaml to manage external dependencies. As an example of the external dependency in the project is the http package.

3. Configuration
The environment variables are stored in the umgebungsvariablen.env file in the Flutter project. The backend URL is set and managed as an environment variable.

4. Supporting services
In a Flutter project, database packages can be attached to the app via the pubspec.yaml file. For example, a Hive database could be connected here.

5. Build, release, run
The application can run with different configurations in different environments using the configuration file umgebungsvariablen.env.

6. Processes
The app is executed with a frontend and a separate backend, which can be scaled independently of each other.

7. Binding to ports
The backend always runs on port 8080.

8. Concurrency
The frontend and backend can be scaled independently of each other because these two processes each run in their own Docker containers and can therefore be scaled horizontally.

9. Disposability
The frontend and backend can be started and stopped quickly in the IDEs for fast development cycles.

10. Dev-prod comparability
Since the processes run in Docker, they can be easily compared between Dev and Prod.

11. Logs
Since the application runs in Docker containers, the responsibility for the logs lies with Docker and not directly with the application itself. The logs can then be viewed in the respective Docker containers and evaluated if necessary.

12. Admin processes
Processes such as the migration of data, e.g. adding new fields to the items (category, discounts, etc.) should then take place once outside the application and not within the actual application.
