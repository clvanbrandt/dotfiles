# Carl-Louis Van Brandt

Boulevard de la Woluwe 60B-43, Woluwe-Saint-Lambert, Belgium, 1200

+32 478 96 93 10

<clvanbrandt@gmail.com> | [LinkedIn](https://www.linkedin.com/in/carl-louis-van-brandt-74a9021a2/) | [GitHub](https://github.com/clvanbrandt)

---

## **Summary**

Senior Data & Cloud Engineer with 5+ years of experience designing, implementing, and optimizing complex data and cloud architectures. Proven track record in leading technology adoption, modernizing infrastructure, and harmonizing codebase structures across teams. Expert in building scalable ETL pipelines, real-time data processing systems, and multi-cloud platforms using Kubernetes, Apache Spark, and AWS/Azure. Adept at fostering knowledge sharing through internal workshops and driving continuous improvement in development processes. Committed to delivering robust, secure, and cost-effective solutions that support business growth and innovation.

---

## **Technical Skills**

- **Cloud Platforms:**
  - _AWS_:
    - Compute & Containers: EKS, ECS, ECR, EC2, Lambda, Fargate
    - Storage & Data: S3, EMR, Athena, Glue, MWAA, Kinesis, DynamoDB, RDS (Aurora)
    - API & Integration: API Gateway, EventBridge, SQS, SNS, Step Functions
    - Security & IAM: IAM, IAM Identity Center (SSO), Organizations, Cognito, Secrets Manager, Parameter Store, KMS
    - Networking: VPC, Transit Gateway, VPC Peering, VPN, Route 53, CloudFront
    - DevOps: CodePipeline, CodeBuild, CloudWatch, X-Ray, Systems Manager
  - _Azure_:
    - Compute & Containers: AKS, VMs, Container Registry (ACR)
    - Storage: Blob Storage
    - Networking: Virtual Networks, VPN Gateway, Hub-Spoke topology, VNet Peering
    - Identity: Azure Active Directory (Entra ID)
    - DevOps: Azure DevOps (Pipelines, Repos, Boards)
    - Data: Databricks
- **Programming Languages:** Python, Scala, Rust, HCL, TypeScript, JavaScript, SQL, C
- **Databases:** PostgreSQL, DuckDB, DynamoDB, MySQL, SAP HANA, Redis, Valkey
- **Infrastructure as Code:** OpenTofu, Terraform, Terragrunt, Pulumi, CloudFormation, Serverless Framework
- **DevOps & CI/CD:** Docker, Kubernetes, ArgoCD, Argo Workflows, Github Actions, Azure DevOps Pipelines, Kyverno, Karpenter, Renovate
- **Data Engineering:** Apache Airflow (MWAA), Apache Spark (Scala/Python), Spark Structured Streaming, Delta Lake, Polars, DuckDB, Apache Arrow, Kafka, AWS Kinesis
- **Monitoring & Observability:** VictoriaMetrics, VictoriaLogs, Grafana, Prometheus, Alertmanager, Fluent Bit, CloudWatch, X-Ray
- **Backend & API:** FastAPI, REST APIs, Microservices, Serverless Architecture, Pydantic, SQLAlchemy
- **Collaboration & Project Management:** Linear, Jira, Notion, Agile methodology
- **Other:** Git, Linux, macOS, Neovim, pre-commit, uv, just

---

## **Experience**

### **Data & Cloud Engineer**

**Jetpack.AI** – Etterbeek, Belgium

February 2020 – Present

- Spearheaded technology discussions and drove the integration and adoption of new tools and practices across the company, becoming the most active advocate for technological advancements.
- Led the initiative to harmonize codebase structures across multiple projects and teams, significantly improving consistency and efficiency. Promoted and integrated DevOps practices and CI/CD processes company-wide.
- Developed a robust ETL framework for Apache Spark applications, abstracting common data processing concepts and enhancing integration with Apache Airflow, which streamlined development processes.
- Modernized an existing ETL pipeline architecture, transitioning from Airflow and Spark on EC2 instances to a multi-AZ Kubernetes solution on AWS EKS. This upgrade drastically reduced failures, enhanced monitoring and developer experience, and improved overall system stability without significant cost increases.
- Designed and implemented a real-time GPS notifications ingestion and analytics system, capable of handling hundreds of notifications per minute, ensuring reliable and timely data processing using DynamoDB and Spark Structured Streaming.
- Architected and maintained multiple ETL pipelines supporting frontend and BI-oriented applications. These pipelines, scheduled at various intervals (from every 15 minutes to monthly), processed diverse datasets including sales, billing, and public infrastructure data. Leveraged Kubernetes (EKS, AKS), AWS EMR, and Apache Airflow for orchestration and execution.
- Engineered an asynchronous system for tracking modifications and newly generated smart meter data using AWS services, including EventBridge, Lambda, SQS, SNS, and dead-letter queues. Designed and implemented the accompanying ETL pipeline that transformed raw data into a versioned standard layer in a data lake using Spark Delta Lake and AWS S3, ensuring data integrity and consistency.
- Suggested, designed, and implemented the company's Identity and Access Management (IAM) strategy and overall cloud architecture. Advocated for the adoption of IAM Identity Center and a multi-account AWS structure, leading to a more secure and scalable infrastructure managed through Terraform and Infrastructure as Code (IaC) best practices.
- Hosted multiple internal workshops covering various technologies, aiding in the onboarding of new team members and fostering healthy discussions about internal tools and best practices.

---

## **Education**

**Master's Degree in Electrical Engineering**

Université Catholique de Louvain (UCLouvain) – Ecole Polytechnique de Louvain (EPL)

Louvain-La-Neuve, Belgium

September 2014 – January 2020

- Focus: Integrated circuits, embedded systems, networking, cryptography
- Thesis: Hardware-acceleration of TensorFlow neural network models on FPGAs
- Relevant coursework: Cryptography, Machine Learning, Computer Networks, Microelectronics, Systems Programming, Cybersecurity
- Honors: cum laude

---

## **Certifications**

- **Solutions Architect Associate** – AWS [2020]
- **Security Specialty** – AWS [2021]

---

## **Languages**

- French: Native
- English: Fluent
- Dutch: Limited business proficiency

---

## **Projects**

### **2025-present – Strata (Energy Grid Simulator)**

Design and development of a full-stack energy grid simulation platform allowing users to simulate future grid loads under various scenarios and run flexibility optimization simulations.

- **Technologies:** Python (FastAPI, Polars, Pydantic, SQLAlchemy), React (Vite, TanStack Router, TanStack Query, Shadcn/Radix UI), PostgreSQL, DuckDB, Apache Arrow, Argo Workflows, Kubernetes (EKS, AKS), OpenTofu, ArgoCD, Github Actions, AWS (ECR, S3, Route 53), Azure (AKS, VPN Gateway, ACR)
- **Responsibilities:**
  - Architected and developed the full-stack application: Python/FastAPI backend APIs, React SPA frontend, and simulation engine running on Kubernetes via Argo Workflows.
  - Designed and built a dedicated metering API service backed by DuckDB, ingesting smart meter load curves from an S3 data lake and exposing high-performance analytics endpoints (daily/aggregated peaks, load curves, load duration, volume statistics) using Apache Arrow for efficient data serialization.
  - Designed a multi-cloud Kubernetes platform with a management cluster on AWS EKS and workload clusters on Azure AKS and AWS EKS, managed centrally via ArgoCD (app-of-apps pattern).
  - Implemented comprehensive observability stack: VictoriaMetrics, VictoriaLogs, Grafana, Alertmanager, and Fluent Bit for logging, monitoring, and alerting.
  - Deployed and managed infrastructure across AWS and Azure using OpenTofu, including networking (VPC, VNet peering), DNS (External DNS, Route 53), secrets (External Secrets Operator), and auto-scaling (Karpenter).
  - Implemented GitOps workflows with ArgoCD for application deployment and Kyverno for policy enforcement.
  - Set up CI/CD pipelines via Github Actions for Docker image builds, testing, and automated deployments.
- **Outcome:** Delivered a production-grade energy simulation platform deployed across multiple cloud providers, enabling the client to model and optimize grid load scenarios at scale.

---

### **2021-present – RESA (Sirius)**

Technical lead for the continuous development & maintenance of "Sirius", a web application for forecasting electricity demand and planning network infrastructure updates.

- **Technologies:** Spark, Scala, Apache Airflow, AWS (MWAA, EMR, RDS Aurora, Lambda, API Gateway, S3, CloudFront), Python, Terraform, Github Actions, Azure DevOps, CodePipeline & CodeBuild, SAP HANA
- **Responsibilities:**
  - Led the full solution hosted on AWS: Scala/Spark aggregation pipelines on EMR, Python prediction and phase detection engines orchestrated via Airflow on MWAA, and a simulation engine on AWS Lambda.
  - Designed and implemented ETL pipelines ingesting raw data from SAP HANA to a PostgreSQL database (Aurora) feeding the front-end application.
  - Integrated smart meter data (quarter-hour granularity) from over 100k physical meters, including in-depth analysis with anomaly detection (inverter stalling, overvoltage, undervoltage, etc.).
  - Successfully migrated the entire project from GitHub (+ Actions) to Azure DevOps, including full CI/CD pipeline redesign.
  - Designed and implemented CI/CD pipelines following DevOps principles, including Docker image building, JAR assembly, integration tests, and release management.
  - Migrated API infrastructure management from Serverless Framework to Terraform, unifying all infrastructure under a single IaC tool.
  - Managed all infrastructure as code using Terraform.
  - Delivered technical documentation for day-to-day maintenance and operations.
- **Outcome:** Delivered a robust forecasting platform enabling the client to anticipate electricity demand and plan infrastructure investments with confidence.

---

### **2020-present – Internal Cloud Infrastructure (Jetpack.AI)**

Design, implementation, and ongoing management of Jetpack's multi-account AWS and Azure cloud infrastructure.

- **Technologies:** OpenTofu/Terraform, AWS (Organizations, IAM Identity Center, VPC, Transit Gateway, Route 53, EKS, ECR), Azure (Hub-Spoke networking, VPN Gateway, ACR, AzureAD), Github Actions
- **Responsibilities:**
  - Designed and implemented a multi-account AWS organization (16+ accounts) with IAM Identity Center for centralized access management.
  - Built the entire SSO management system as code: users, groups, permission sets, and account assignments fully managed via OpenTofu with automated CI/CD through Github Actions (OIDC-based, no long-lived credentials).
  - Defined granular permission sets (AdministratorAccess, Developer, ReadOnly, Billing, KubernetesClusterAdmin, project-scoped access) with inline policies enforcing least-privilege principles (e.g., billing denial for developers, IAM restrictions).
  - Implemented a BreakGlass access procedure with time-limited admin sessions (1h), two-person authorization, mandatory post-use credential rotation, and full audit trail — documented in compliance standards.
  - Authored credential management standards and break-glass procedures aligned with security best practices.
  - Developed reusable OpenTofu modules for VPC provisioning, Transit Gateway peering, and account bootstrapping, enabling consistent and repeatable infrastructure across all projects.
  - Architected cross-cloud networking with AWS Transit Gateway and Azure Hub-Spoke topology including VPN connectivity.
  - Managed DNS, container registries (ECR/ACR), and Terraform remote state (S3 + DynamoDB locking) across both cloud providers.
  - Established CI/CD for infrastructure changes via Github Actions, enforcing plan-and-apply workflows.
  - Advocated for and led the migration from Terraform to OpenTofu across all company infrastructure repositories.
- **Outcome:** Built a secure, scalable, and well-governed multi-cloud foundation that supports all company projects with consistent networking, access control, and IaC practices.

---

### **2023 – Lagardère Travel Retail Belgium**

Complete migration and rewrite of the technical infrastructure for multiple projects running for Lagardère Travel Retail Belgium.

- **Technologies:** AWS (EKS, MWAA, RDS Aurora, S3, CloudFront, Elastic Beanstalk), Scala, Spark, Python, Terraform, Github Actions, Argo CD, Grafana, Prometheus
- **Responsibilities:**
  - Modernized infrastructure from ad-hoc EC2 instances to Kubernetes (EKS), with Argo CD managing cluster deployments.
  - Maintained Scala/Spark aggregation pipelines orchestrated via MWAA, alongside Python-based forecasting engines.
  - Implemented monitoring solutions for Airflow DAG execution and ETL pipelines using Grafana and Prometheus.
  - Managed all infrastructure as code using Terraform; CI/CD driven by Github Actions and Argo CD.
- **Outcome:** Significantly improved system reliability, observability, and developer experience while reducing operational overhead.

---

### **2022-2023 – MFD**

Development of an analytic engine collecting wagon sensor notifications in real-time.

- **Technologies:** PostgreSQL, Scala, Spark Structured Streaming, AWS (Kinesis, DynamoDB, API Gateway, Lambda, MKS), Terraform, Github Actions
- **Responsibilities:**
  - Designed and implemented a real-time pipeline to process hundreds of sensor notifications per minute.
  - Developed a customer-facing API leveraging DynamoDB, PostgreSQL, API Gateway, and Lambda.
  - Managed all infrastructure as code using Terraform.
- **Outcome:** Enabled real-time visibility into wagon sensor data, providing actionable analytics to the client.

---

### **2021 – Stokke AS**

Development of data pipelines and infrastructure on Azure, alongside PowerBI dashboards reporting shop sales and manager visit impact.

- **Technologies:** Azure (AKS, VPN Gateway, DevOps), Apache Airflow, Apache Spark, Terraform, Terragrunt, PowerBI
- **Responsibilities:**
  - Implemented a data platform on Kubernetes hosting Apache Airflow, Spark, and monitoring solutions.
  - Developed ETL pipelines to process raw business data and created PowerBI dashboards for visualization.
  - Managed CI/CD through Azure DevOps; infrastructure as code with Terraform and Terragrunt.
  - Implemented monitoring for Airflow DAG execution and ETL pipelines.
- **Outcome:** Delivered a fully automated data platform with self-service BI reporting for the client's retail operations.

---

### **2020-2021 – Lineas**

Data lake infrastructure deployment and management: deploying a data processing platform on AWS EKS.

- **Technologies:** AWS (EKS, EC2, Route 53), Apache NiFi, Apache Airflow, Apache Spark, Apache Livy, Terraform, NGINX, Apache Bamboo
- **Responsibilities:**
  - Deployed and managed a Kubernetes-based data processing platform running Spark, Livy, NiFi, and Airflow.
  - Infrastructure deployed and managed entirely through Terraform.
- **Outcome:** Provided a scalable and maintainable data lake infrastructure enabling the client's data engineering teams to process large volumes of logistics data.

---

## **Interests**

- Sports: Strength training, tennis, golf (1.8 HCP), padel
- Gaming: Fighting games, factory simulation & logistics games
- Board and social deduction games
