**Carl-Louis Van Brandt**

**Staff Data, Cloud & ML Platform Engineer**

Brussels, Belgium • \+32 478 96 93 10 • clvanbrandt@gmail.com • LinkedIn • GitHub

**SUMMARY**

Staff-level platform engineer specializing in distributed data systems, cloud-native infrastructure, and ML platforms. I design and operate production systems at scale: real-time IoT analytics processing 100,000+ smart meters, electricity-demand forecasting supporting grid-investment decisions, and multi-cloud Kubernetes platforms across AWS and Azure. I pair deep hands-on ownership with technical leadership: establishing architecture standards, improving delivery reliability, hardening security posture, and enabling cross-team platform adoption. Proven track record reducing incident frequency, maintaining cost efficiency, and driving operational excellence.

**CORE EXPERTISE**

Cloud-native Data Platforms • Distributed Systems & Streaming Analytics • Event-Driven Architecture • Multi-Cloud Kubernetes (AWS/Azure) • MLOps & Data-for-AI • Infrastructure as Code • CI/CD & Developer Platforms • Observability & SLOs • IAM, Security & Compliance • Technical Leadership & Standards

**PROFESSIONAL EXPERIENCE**

**Jetpack.AI — Data, Cloud & ML Platform Engineer**

_Feb 2020 – Present • Belgium • Data & cloud engineering consultancy_

- Platform architect and technical lead across internal and client-facing data/ML projects, owning full-stack design, deployment, and operational reliability. Delivered solutions for energy grids, logistics networks, and retail forecasting.
- Established company-wide engineering standards for DevOps, CI/CD, repository structure, and deployment workflows; led adoption across multiple teams, improving delivery consistency and reducing onboarding time by 40%.
- Architected and deployed Apache Spark ETL framework with native Airflow orchestration and cloud storage integrations (S3, Azure Blob Storage), standardizing pipeline development patterns and eliminating redundant custom implementations across ML and analytics projects.
- Re-architected critical ETL platform from Airflow/Spark on EC2 to multi-AZ Kubernetes (AWS EKS), reducing pipeline failures by \~60%, improving observability via Grafana/Prometheus/VictoriaMetrics, and enhancing developer experience while maintaining flat infrastructure costs.
- Designed 16+ AWS account organization with IAM Identity Center, zero long-lived credentials (OIDC-based CI/CD), least-privilege permission sets, and BreakGlass procedure with time-limited admin access, two-person authorization, and full audit trails.
- Architected multi-cloud Kubernetes platform (AWS EKS, Azure AKS) centrally governed via ArgoCD, Kyverno policies, and VictoriaMetrics observability, enabling consistent deployment, policy enforcement, and compliance across cloud boundaries.

**SELECTED CLIENT & PLATFORM PROJECTS**

**Strata — Energy-Grid Simulation Platform**

_2025 – Present • Ongoing_

- Architected end-to-end platform: FastAPI backend, React SPA, and simulation engine orchestrated on Kubernetes via Argo Workflows. Developed custom Helm charts for packaging and deploying all application services consistently across environments.
- Built metering analytics API on DuckDB over S3 data lake with Apache Arrow serialization, delivering sub-second queries on 100M+ meter readings without provisioning dedicated OLAP infrastructure; trades columnar scan efficiency against database management overhead.
- Designed multi-cloud Kubernetes platform (AWS EKS, Azure AKS) centrally governed with ArgoCD, Kyverno policies, and observability stack, enabling consistent policy enforcement, disaster recovery, and compliance audits across cloud providers.

**RESA "Sirius" — Electricity-Demand Forecasting Platform**

_2021 – Present • Ongoing_

- Technical lead for forecasting platform supporting grid-investment decisions and demand-response coordination for Belgium's largest distribution system operator.
- Architected AWS solution: Scala/Spark aggregation on EMR, Python forecasting and phase-detection engines via Airflow (MWAA), and simulation on Lambda; processes quarter-hour data from 100,000+ smart meters with anomaly detection. Raw and processed data managed in S3 with Delta Lake versioning.
- Integrated real-time telemetry ingestion and implemented anomaly detection for inverter stalling and voltage issues, improving grid stability insights and enabling proactive network maintenance.

**Internal Multi-Cloud Foundation — Jetpack.AI**

_2020 – Present • Ongoing_

- Designed 16+ account AWS organization with IAM Identity Center, SSO, and CI/CD entirely as code via OpenTofu; enforces least-privilege access and full auditability.
- Implemented BreakGlass emergency-access procedure: time-limited admin elevation, two-person authorization requirement, mandatory credential rotation, and immutable audit trail.
- Delivered reusable infrastructure modules (VPC, security groups, IAM patterns) and cross-cloud networking (AWS Transit Gateway, Azure Hub-Spoke); led company-wide Terraform-to-OpenTofu migration.

_Delivered Projects_

**Lagardère Travel Retail Belgium** _(2023)_ Migrated ad-hoc EC2 infrastructure to Kubernetes (EKS) with ArgoCD; maintained Scala/Spark pipelines (S3-based data lake) and Python forecasting while improving reliability and observability (Grafana/Prometheus).

**MFD — Real-time Wagon-Sensor Analytics** _(2022–2023)_ Designed real-time IoT analytics pipeline (DynamoDB, PostgreSQL, Lambda) for continuous wagon-sensor notifications with customer-facing API; full infrastructure-as-code deployment.

**Stokke AS — Azure Data Platform & BI** _(2021)_ Built Kubernetes data platform (Airflow, Spark, monitoring) on Azure with ETL pipelines reading and writing to Azure Blob Storage, and PowerBI dashboards for retail-sales analytics; CI/CD via Azure DevOps, IaC with Terraform.

**Lineas — Data-Lake Infrastructure** _(2020–2021)_ Deployed and managed Kubernetes data-processing platform (Spark, Livy, NiFi, Airflow) on AWS EKS with S3 as the data lake storage layer, fully provisioned with Terraform for Belgium's largest freight rail operator.

**TECHNICAL SKILLS**

**Languages** Python • Scala • Rust • SQL • TypeScript / JavaScript

**Data & Streaming** Apache Spark • Structured Streaming • Delta Lake • Airflow (MWAA) • DuckDB • Polars • Apache Arrow • Kafka • Kinesis

**Cloud & Infrastructure** AWS (EKS, EMR, Lambda, DynamoDB, S3, EventBridge, IAM Identity Center) • Azure (AKS, Blob Storage, Databricks, ACR, Entra ID) • Terraform • OpenTofu

**DevOps & Platform** Docker • Kubernetes • Helm • ArgoCD • Argo Workflows • Kyverno • Karpenter • GitHub Actions • Azure DevOps

**Observability** Grafana • Prometheus • VictoriaMetrics / VictoriaLogs • Alertmanager • CloudWatch

**EDUCATION & CERTIFICATIONS**

**UCLouvain (EPL) — M.Sc. Electrical Engineering, cum laude**

_2014–2020_

**Thesis:** Hardware acceleration of TensorFlow neural-network models on FPGAs. Foundation for expertise in high-performance systems, embedded distributed computing, and later specialized work in data platforms and ML infrastructure.

**AWS Certifications:** Certified Solutions Architect – Associate • Certified Security – Specialty

**Languages:** French (native) • English (fluent) • Dutch (business proficiency)

