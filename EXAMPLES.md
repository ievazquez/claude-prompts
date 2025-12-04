# Ejemplos de Uso de Agentes

Guía práctica con ejemplos reales de cómo invocar cada agente para tareas específicas.

---

## Agentes Genéricos

### legacy-modernizer

```
Act as legacy-modernizer. Analyze 'billing_legacy.py'. Plan and implement a
'Strangler Fig' migration to Python 3 with SQLAlchemy. Create a safety net
(tests) first. Do not delete the old code yet; create a facade to switch
traffic gradually.
```

```
Act as legacy-modernizer. We have a 15-year-old PHP monolith. Identify the
most critical module to extract first. Create an anti-corruption layer and
propose a 3-phase migration plan to Laravel with zero downtime.
```

---

### api-designer

```
Act as api-designer. Design a RESTful API for an e-commerce platform with:
- Product catalog with categories and variants
- Shopping cart with guest checkout support
- Order management with status tracking
- User authentication via OAuth 2.0
Include OpenAPI 3.1 specification, pagination strategy, and rate limiting rules.
```

```
Act as api-designer. Convert our existing REST endpoints to GraphQL. Analyze
'src/api/routes/' and design a schema that reduces over-fetching. Include
subscriptions for real-time order updates.
```

---

### api-documenter

```
Act as api-documenter. Generate comprehensive documentation for all endpoints
in 'src/controllers/'. Include request/response examples, error codes, and
authentication requirements. Output as OpenAPI 3.1 YAML.
```

```
Act as api-documenter. Create a developer portal documentation for our public
API. Include quickstart guide, code examples in Python/JavaScript/cURL, and
common error troubleshooting.
```

---

### arquitect-reviewer

```
Act as arquitect-reviewer. Review the architecture in 'src/'. Evaluate:
- Separation of concerns
- Dependency management
- Scalability bottlenecks
- Security vulnerabilities
Provide a detailed report with severity levels and remediation steps.
```

```
Act as arquitect-reviewer. We're experiencing performance issues at 10k
concurrent users. Analyze our current microservices architecture and identify
the bottlenecks. Propose solutions with estimated impact.
```

---

### build-engineer

```
Act as build-engineer. Set up a complete CI/CD pipeline for this Node.js
monorepo using GitHub Actions. Include:
- Parallel test execution
- Docker image building with layer caching
- Staging and production deployments
- Rollback mechanism
```

```
Act as build-engineer. Our build times are 45 minutes. Analyze the current
pipeline in '.github/workflows/' and optimize for speed. Target: under 10
minutes for PR builds.
```

---

### clean-code-expert

```
Act as clean-code-expert. Refactor 'src/services/OrderService.java'. Apply
SOLID principles, extract methods longer than 20 lines, and reduce cyclomatic
complexity. Preserve all existing functionality and add JSDoc comments.
```

```
Act as clean-code-expert. Review 'src/utils/' for code smells. Identify:
- Duplicate code blocks
- God classes
- Long parameter lists
- Feature envy
Provide refactoring recommendations with before/after examples.
```

---

### cli-developer

```
Act as cli-developer. Create a CLI tool in Python using Click for managing
our deployment process. Commands needed:
- deploy <env> [--dry-run]
- rollback <env> <version>
- status <env>
- logs <env> <service> [--tail]
Include auto-completion and colored output.
```

```
Act as cli-developer. Convert this bash script 'scripts/setup.sh' into a
proper CLI with Go using Cobra. Add interactive prompts, progress bars, and
configuration file support.
```

---

### cloud-architect

```
Act as cloud-architect. Design an AWS infrastructure for a SaaS application
with:
- 99.99% availability requirement
- Multi-region deployment
- Auto-scaling based on CPU and request count
- Cost optimization for variable workloads
Provide Terraform modules and cost estimates.
```

```
Act as cloud-architect. Migrate our on-premise infrastructure to GCP. Current
setup: 3 app servers, 1 PostgreSQL master with 2 replicas, Redis cluster.
Design equivalent cloud architecture with disaster recovery.
```

---

### database-administrator

```
Act as database-administrator. Analyze the slow query log in 'logs/mysql-slow.log'.
Identify the top 10 problematic queries, explain why they're slow, and provide
optimized versions with appropriate indexes.
```

```
Act as database-administrator. Design a sharding strategy for our users table
(500M rows, growing 1M/day). Consider:
- Shard key selection
- Cross-shard queries
- Rebalancing strategy
- Migration plan from single database
```

---

### docker-specialist

```
Act as docker-specialist. Optimize the Dockerfile in this project. Current
image is 2.3GB. Reduce size using multi-stage builds, minimize layers, and
implement proper caching. Target: under 200MB.
```

```
Act as docker-specialist. Create a docker-compose.yml for local development
that mirrors production. Include:
- App service with hot-reload
- PostgreSQL with persistent data
- Redis for caching
- Nginx as reverse proxy
- Proper networking and health checks
```

---

### documentation-engineer

```
Act as documentation-engineer. Create comprehensive technical documentation
for this microservices project. Include:
- Architecture overview with diagrams (Mermaid)
- Service communication patterns
- Deployment procedures
- Troubleshooting guide
```

```
Act as documentation-engineer. Generate API documentation from the codebase.
Extract all public methods, their parameters, return types, and usage examples.
Format as a searchable documentation site.
```

---

### fullstack-developer

```
Act as fullstack-developer. Implement a real-time dashboard feature:
- Backend: Node.js WebSocket server for live data
- Frontend: React component with Chart.js
- Database: Time-series data in PostgreSQL
Include error handling, reconnection logic, and loading states.
```

```
Act as fullstack-developer. Add user authentication to this application:
- Backend: JWT with refresh tokens in Express
- Frontend: React context for auth state
- Database: User model with bcrypt passwords
Include protected routes and role-based access.
```

---

### git-workflow-manager

```
Act as git-workflow-manager. Set up a Git workflow for our team of 8 developers:
- Branch naming conventions
- PR template with checklist
- Automated labeling based on files changed
- Protected branch rules
- Semantic versioning with auto-changelog
```

```
Act as git-workflow-manager. Our main branch has diverged significantly from
production. Create a safe plan to:
1. Identify all differences
2. Cherry-pick critical fixes
3. Reconcile the branches
4. Prevent future drift
```

---

### payment-integration

```
Act as payment-integration. Implement Stripe payment processing:
- One-time payments
- Subscription management
- Webhook handling for payment events
- PCI compliance considerations
Include error handling, idempotency keys, and testing with Stripe CLI.
```

```
Act as payment-integration. Add PayPal as an alternative payment method
alongside our existing Stripe integration. Create a unified payment interface
that abstracts the provider. Handle currency conversion and refunds.
```

---

### prompt-engineer

```
Act as prompt-engineer. Create a prompt template for a customer support
chatbot that:
- Maintains brand voice (friendly, professional)
- Handles refund requests
- Escalates complex issues to humans
- Prevents prompt injection attacks
Include few-shot examples and output format specification.
```

```
Act as prompt-engineer. Optimize this RAG prompt for better accuracy:
[current prompt]
Reduce hallucinations, improve source citation, and handle "I don't know"
cases gracefully.
```

---

### requirements-analyst

```
Act as requirements-analyst. The client says: "We need a better search".
Extract detailed requirements through systematic questioning:
- What are users searching for?
- Current pain points?
- Performance expectations?
- Advanced features needed?
Output as user stories with acceptance criteria.
```

```
Act as requirements-analyst. Convert this PRD into technical specifications:
[PRD document]
Include functional requirements, non-functional requirements, constraints,
and assumptions. Identify ambiguities that need clarification.
```

---

### task-manager

```
Act as task-manager. Break down this epic into manageable tasks:
"Implement multi-tenant support for the application"
Create tasks with:
- Clear descriptions
- Dependencies
- Effort estimates (S/M/L/XL)
- Priority levels
- Acceptance criteria
```

```
Act as task-manager. Review our current sprint backlog and:
- Identify blocked tasks
- Suggest task reordering for optimal flow
- Flag scope creep risks
- Recommend what to move to next sprint
```

---

### tech-arquitect

```
Act as tech-arquitect. Design the architecture for a real-time collaborative
document editor like Google Docs:
- Conflict resolution strategy (CRDT vs OT)
- Data model
- Service architecture
- Technology stack recommendations
Include trade-off analysis for each decision.
```

```
Act as tech-arquitect. Evaluate these options for our message queue:
- RabbitMQ
- Apache Kafka
- AWS SQS
Consider our requirements: 100k msgs/sec, at-least-once delivery, 7-day
retention. Recommend with justification.
```

---

### technical-writer

```
Act as technical-writer. Write a README for this open-source project that
includes:
- Clear project description
- Installation instructions for all platforms
- Quick start guide
- Configuration options
- Contributing guidelines
Use clear, concise language for developers of all levels.
```

```
Act as technical-writer. Create an onboarding guide for new developers joining
the team. Cover:
- Development environment setup
- Codebase overview
- Common workflows
- Where to get help
Make it scannable with clear headings and code examples.
```

---

### tooling-engineer

```
Act as tooling-engineer. Set up a complete development toolchain:
- ESLint + Prettier configuration
- Husky pre-commit hooks
- lint-staged for performance
- commitlint for conventional commits
- VS Code workspace settings
Ensure all tools work together without conflicts.
```

```
Act as tooling-engineer. Create a custom code generator that:
- Reads OpenAPI spec
- Generates TypeScript interfaces
- Creates API client with axios
- Adds proper error types
Make it runnable via npm script.
```

---

## Agentes de Backend

### java-developer

```
Act as java-developer. Implement a REST controller for user management using
Spring Boot 3:
- CRUD operations
- Input validation with Bean Validation
- Exception handling with @ControllerAdvice
- Unit tests with JUnit 5 and Mockito
Follow TDD: write tests first, then implementation.
```

```
Act as java-developer. Refactor this legacy service class:
'src/main/java/com/app/service/OrderService.java'
Apply:
- Dependency injection
- Single responsibility principle
- Repository pattern
- Proper exception hierarchy
Maintain backward compatibility.
```

---

### cpp-refactor

```
Act as cpp-refactor. Modernize this C++98 codebase to C++17:
- Replace raw pointers with smart pointers
- Use auto where appropriate
- Apply range-based for loops
- Introduce std::optional for nullable returns
- Add constexpr where possible
Ensure no memory leaks with Valgrind verification.
```

```
Act as cpp-refactor. Optimize the performance of 'src/engine/renderer.cpp':
- Profile and identify hotspots
- Apply cache-friendly data structures
- Consider SIMD optimizations
- Reduce memory allocations
Target: 30% performance improvement.
```

---

## Agentes de Core (Arquitectura)

### microservices-architect

```
Act as microservices-architect. Decompose this monolith into microservices:
- Identify bounded contexts
- Define service boundaries
- Design inter-service communication (sync vs async)
- Plan data ownership and eventual consistency
- Create migration roadmap
Start with domain analysis of 'src/'.
```

```
Act as microservices-architect. Design a saga pattern implementation for
our order processing flow:
1. Reserve inventory
2. Process payment
3. Create shipment
4. Send confirmation
Handle compensating transactions for each failure scenario.
```

---

### graphql-architect

```
Act as graphql-architect. Design a GraphQL schema for our social media
platform:
- User profiles with followers/following
- Posts with comments and reactions
- Real-time notifications via subscriptions
- Efficient pagination with cursor-based connections
Include DataLoader patterns to prevent N+1 queries.
```

```
Act as graphql-architect. Implement GraphQL federation for our microservices:
- User service owns User type
- Order service extends User with orders
- Product service provides catalog
Design the federated schema and gateway configuration.
```

---

### websocket-engineer

```
Act as websocket-engineer. Implement a real-time chat system:
- Room-based messaging
- Presence indicators (online/typing)
- Message delivery acknowledgment
- Reconnection with message replay
- Horizontal scaling with Redis pub/sub
Include client SDK in TypeScript.
```

```
Act as websocket-engineer. Add real-time features to our trading platform:
- Live price updates (tick data)
- Order book changes
- Trade executions
- Connection health monitoring
Handle 10k concurrent connections with <50ms latency.
```

---

## Agentes de Datos

### data-engineer

```
Act as data-engineer. Design an ETL pipeline for our analytics:
- Source: PostgreSQL (transactional data)
- Transform: Clean, aggregate, enrich
- Load: Snowflake data warehouse
Use Apache Airflow for orchestration. Include data quality checks and
alerting for failures.
```

```
Act as data-engineer. Build a real-time data pipeline:
- Ingest: Kafka topics from multiple services
- Process: Flink for stream processing
- Store: ClickHouse for analytics
- Serve: API for dashboards
Handle late-arriving data and exactly-once semantics.
```

---

### postgres-pro

```
Act as postgres-pro. Optimize this slow query (currently 15 seconds):
[query]
Analyze execution plan, suggest indexes, and consider query rewriting.
Target: under 100ms.
```

```
Act as postgres-pro. Design a database schema for a multi-tenant SaaS:
- Tenant isolation strategy (schema vs row-level)
- Efficient tenant queries
- Backup and restore per tenant
- Performance at 1000 tenants
Include migration scripts and RLS policies.
```

---

## Agentes de Infraestructura

### devops-engineer

```
Act as devops-engineer. Implement GitOps for our Kubernetes deployments:
- ArgoCD configuration
- Helm charts for all services
- Environment promotion (dev → staging → prod)
- Secrets management with Sealed Secrets
- Rollback procedures
```

```
Act as devops-engineer. Set up comprehensive monitoring:
- Metrics: Prometheus + Grafana
- Logs: Loki
- Traces: Jaeger
- Alerts: PagerDuty integration
Create dashboards for SLIs/SLOs.
```

---

### incident-responder

```
Act as incident-responder. Production is down. Current symptoms:
- 500 errors on /api/checkout
- Database CPU at 100%
- Started 15 minutes ago
Guide me through the incident response. What to check first? How to
mitigate while investigating?
```

```
Act as incident-responder. Create a post-mortem template and write the
post-mortem for this incident:
- Incident: Payment processing failures for 2 hours
- Root cause: Expired SSL certificate on payment gateway
- Impact: $50k in lost transactions
Include timeline, action items, and prevention measures.
```

---

### network-engineer

```
Act as network-engineer. Design the network architecture for our Kubernetes
cluster:
- Network policies for service isolation
- Ingress configuration with TLS termination
- Service mesh evaluation (Istio vs Linkerd)
- DNS configuration
Include security hardening recommendations.
```

```
Act as network-engineer. Troubleshoot intermittent connectivity issues:
- Services randomly can't reach database
- Happens under load
- No pattern in time
What diagnostic steps should we take? What metrics to collect?
```

---

## Agentes de Calidad

### architect-reviewer

```
Act as architect-reviewer. Perform an Architecture Decision Record (ADR)
review for:
"We decided to use MongoDB instead of PostgreSQL for the user service"
Evaluate the decision, identify risks, and suggest mitigations or
alternatives if the decision seems problematic.
```

```
Act as architect-reviewer. Review our system for:
- Single points of failure
- Scalability limits
- Security vulnerabilities
- Operational complexity
Provide a risk matrix with probability and impact.
```

---

### chaos-engineer

```
Act as chaos-engineer. Design chaos experiments for our payment system:
- What failures to simulate
- Blast radius controls
- Success criteria
- Rollback procedures
Start with low-risk experiments and increase severity gradually.
```

```
Act as chaos-engineer. Implement these failure scenarios using Chaos Monkey:
1. Random pod termination
2. Network latency injection (500ms)
3. Database failover
4. Memory pressure
Create runbooks for each experiment.
```

---

### penetration-tester

```
Act as penetration-tester. Perform a security assessment of our authentication
system:
- Analyze 'src/auth/' for vulnerabilities
- Test for OWASP Top 10
- Check JWT implementation
- Evaluate password policies
Provide findings with CVSS scores and remediation steps.
```

```
Act as penetration-tester. Review this API endpoint for security issues:
[endpoint code]
Check for:
- Injection vulnerabilities
- Broken access control
- Data exposure
- Rate limiting bypass
Provide proof-of-concept for any findings.
```

---

## Combinaciones de Agentes (Flujos Completos)

### Nuevo Feature End-to-End

```
Step 1: Act as requirements-analyst
"Analyze the request: 'Users want to export their data'"
Extract detailed requirements and acceptance criteria.

Step 2: Act as tech-arquitect
Design the technical solution for the data export feature.
Consider formats (JSON, CSV, PDF), async processing, and storage.

Step 3: Act as api-designer
Design the API endpoints for triggering and downloading exports.

Step 4: Act as fullstack-developer
Implement the feature following the design.

Step 5: Act as penetration-tester
Security review of the export feature.
Check for data leakage and access control.
```

### Modernización de Sistema Legacy

```
Step 1: Act as legacy-modernizer
Analyze the legacy system and create migration strategy.

Step 2: Act as architect-reviewer
Review the migration plan for risks and gaps.

Step 3: Act as database-administrator
Plan database migration with zero downtime.

Step 4: Act as devops-engineer
Set up infrastructure for gradual traffic shifting.

Step 5: Act as chaos-engineer
Design tests to validate the new system under failure conditions.
```

---

## Tips de Uso

1. **Sé específico**: Incluye nombres de archivos, tecnologías, y restricciones
2. **Da contexto**: Menciona el estado actual y el objetivo deseado
3. **Define éxito**: Indica métricas o criterios de aceptación
4. **Encadena agentes**: Usa la salida de uno como entrada del siguiente
5. **Itera**: Refina las respuestas con preguntas de seguimiento
