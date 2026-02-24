
# Inception

A complete containerized infrastructure is designed and deployed using Docker and Docker Compose. Multiple services are configured and orchestrated, including NGINX with SSL/TLS, WordPress with PHP-FPM, and MariaDB. The project focuses on container networking, volume management, environment isolation, and secure service configuration. All services are deployed within a personal virtual machine, reinforcing best practices in system administration, containerization, and secure web service deployment.

## Services
- **NGINX**: Acts as a reverse proxy and web server, configured with SSL/TLS for secure communication.

- **WordPress**: A popular content management system (CMS) running with PHP-FPM for efficient processing of PHP scripts.

- **MariaDB**: A relational database management system used to store WordPress data, configured with secure credentials and proper volume management for data persistence.


## Bonus
- **Grafana**: A powerful open-source platform for monitoring and observability, integrated into the infrastructure to provide insights into the performance and health of the services. Grafana is configured to collect and visualize metrics from the NGINX, WordPress, and MariaDB containers, allowing for proactive monitoring and troubleshooting of the application stack.

- **Redis**: An in-memory data structure store used as a caching layer to improve the performance of the WordPress application. Redis is configured to work with WordPress, providing faster access to frequently accessed data and reducing the load on the MariaDB database, resulting in improved response times and overall performance of the web application.

- **Adminer**: A web-based database management tool that provides an intuitive interface for managing the MariaDB database. Adminer is deployed as a separate container and configured to connect securely to the MariaDB service, allowing for easy database administration and management without the need for command-line access.



## Features
- **Containerization**: All services are containerized using Docker, ensuring consistency and ease of deployment across different environments.

- **Orchestration**: Docker Compose is used to manage and orchestrate the multiple services, allowing for easy scaling and management of the application stack.

- **Networking**: Proper container networking is implemented to allow seamless communication between services while maintaining isolation from the host system.

- **Volume Management**: Persistent storage is configured for the database and WordPress files, ensuring data durability and ease of backup.

- **Security**: SSL/TLS is configured for secure communication, and environment variables are used to manage sensitive information such as database credentials, enhancing the security of the deployment.

## Deployment
The entire infrastructure is deployed within a personal virtual machine, providing an isolated environment for testing and development. This setup allows for a realistic simulation of a production environment while maintaining control over the resources and configurations. The deployment process includes building Docker images, configuring services, and ensuring proper communication between containers, demonstrating best practices in containerization and secure web service deployment.

## Conclusion
This project showcases the ability to design and deploy a complete containerized infrastructure using Docker and Docker Compose. It highlights the importance of proper service configuration, secure communication, and efficient orchestration in modern web application deployment. By leveraging containerization, the project ensures consistency, scalability, and ease of management across different environments, making it a valuable learning experience in system administration and web service deployment.