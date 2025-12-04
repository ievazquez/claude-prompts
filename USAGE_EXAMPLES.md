# Usage Examples for Claude Code Agents

Comprehensive usage examples with realistic scenarios, problem statements, and input/output demonstrations.

---

## Table of Contents

1. [Generic Agents](#generic-agents)
2. [Backend Agents](#backend-agents)
3. [Quality Agents](#quality-agents)
4. [Infrastructure Agents](#infrastructure-agents)
5. [Core Agents](#core-agents)
6. [Data Agents](#data-agents)
7. [Misc Agents](#misc-agents)

---

## Generic Agents

### clean-code-expert.md
**Profile:** Polyglot Senior Software Engineer specializing in refactoring code for Python, Java, and C++ to production-ready standards.

* **Scenario:** A junior developer wrote a Python script for data processing that works but violates multiple PEP 8 guidelines and contains code smells.
* **The Problem:** Nested conditionals, magic numbers, missing type hints, and poor naming conventions make the code hard to maintain.

**📝 Input Code:**
```python
def p(d, t):
    r = []
    for i in d:
        if i['status'] == 1:
            if i['age'] > 18:
                if i['score'] >= 75:
                    r.append(i['name'])
    return r
```

**✅ Expected Output:**
```python
from typing import List, TypedDict

class UserData(TypedDict):
    status: int
    age: int
    score: int
    name: str

STATUS_ACTIVE = 1
MINIMUM_AGE = 18
PASSING_SCORE = 75

def get_eligible_user_names(users: List[UserData]) -> List[str]:
    """Filter and return names of eligible active adult users with passing scores."""
    return [
        user['name']
        for user in users
        if user['status'] == STATUS_ACTIVE
        and user['age'] > MINIMUM_AGE
        and user['score'] >= PASSING_SCORE
    ]
```

---

### legacy-modernizer.md
**Profile:** Senior legacy modernizer transforming aging systems into modern architectures using incremental migration strategies.

* **Scenario:** A 10-year-old PHP 5 codebase for billing needs to be modernized without disrupting daily operations.
* **The Problem:** Outdated PHP syntax, no ORM, raw SQL queries with SQL injection vulnerabilities, and tightly coupled code.

**📝 Input Text:**
```
Analyze our billing_processor.php file. Plan a Strangler Fig migration to PHP 8
with Laravel. Identify the first module to extract and create a migration plan
with zero downtime requirements.
```

**✅ Expected Output:** A phased migration plan including:
- Anti-corruption layer design
- Module extraction priority (payments → invoices → reports)
- Database abstraction strategy
- Parallel run testing approach
- Rollback procedures for each phase

---

### prompt-engineer.md
**Profile:** Senior prompt engineer crafting and optimizing prompts for maximum effectiveness with LLMs.

* **Scenario:** A chatbot's customer support prompt has inconsistent responses and high token usage.
* **The Problem:** The prompt is verbose, lacks structure, and produces unpredictable outputs.

**📝 Input Prompt (Before):**
```
You are a helpful assistant. Help customers with their questions about our
products. Be nice and helpful. Answer questions about shipping, returns,
and product information. If you don't know something, just say so.
```

**✅ Optimized Output:**
```
Role: Customer Support Agent for TechStore

## Response Protocol
1. Greet briefly (max 10 words)
2. Address the specific question
3. Offer one relevant follow-up

## Knowledge Boundaries
- Shipping: 3-5 business days, free over $50
- Returns: 30-day window, original packaging required
- Products: Reference product catalog only

## Constraints
- Max 100 tokens per response
- Unknown queries → "Let me connect you with a specialist"
- No price negotiations or custom discounts

## Output Format
[Greeting]
[Answer]
[Follow-up question or action]
```

---

### docker-specialist.md
**Profile:** Senior DevOps Engineer specializing in containerization with production-grade security and optimization.

* **Scenario:** A Node.js application needs to be containerized for production deployment.
* **The Problem:** Current Docker image is 1.2GB, runs as root, and has no layer caching optimization.

**📝 Input Context:**
```
Containerize a Node.js Express API (v18) with:
- Production dependencies only
- Non-root user
- Multi-stage build
- Optimized layer caching
```

**✅ Expected Dockerfile Output:**
```dockerfile
# Stage 1: Dependencies
FROM node:18-alpine AS deps
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

# Stage 2: Production
FROM node:18-alpine AS runner
WORKDIR /app

# Security: Non-root user
RUN addgroup --system --gid 1001 nodejs \
    && adduser --system --uid 1001 appuser

# Copy only production artifacts
COPY --from=deps /app/node_modules ./node_modules
COPY --chown=appuser:nodejs . .

USER appuser
EXPOSE 3000

CMD ["node", "server.js"]
```

---

### api-designer.md
**Profile:** Senior API architect designing scalable, developer-friendly REST and GraphQL interfaces.

* **Scenario:** Designing a REST API for an e-commerce order management system.
* **The Problem:** Need consistent pagination, proper error handling, and versioning strategy.

**📝 Input Requirements:**
```
Design REST endpoints for order management:
- List orders with filtering and pagination
- Create new order
- Update order status
- Cancel order
Include error responses and rate limiting headers.
```

**✅ Expected Output (OpenAPI Snippet):**
```yaml
paths:
  /v1/orders:
    get:
      summary: List orders with pagination
      parameters:
        - name: status
          in: query
          schema:
            type: string
            enum: [pending, processing, shipped, delivered]
        - name: cursor
          in: query
          schema:
            type: string
        - name: limit
          in: query
          schema:
            type: integer
            default: 20
            maximum: 100
      responses:
        200:
          headers:
            X-RateLimit-Remaining:
              schema:
                type: integer
          content:
            application/json:
              schema:
                type: object
                properties:
                  data:
                    type: array
                    items:
                      $ref: '#/components/schemas/Order'
                  pagination:
                    $ref: '#/components/schemas/CursorPagination'
        429:
          description: Rate limit exceeded
```

---

### arquitect-reviewer.md
**Profile:** Principal Software Architect reviewing system designs for bottlenecks, SPOFs, and scalability issues.

* **Scenario:** Reviewing a proposed architecture for a real-time bidding platform.
* **The Problem:** Need to identify potential failure points and scaling limitations before implementation.

**📝 Input Architecture:**
```
Single PostgreSQL database handling:
- 10K bids/second
- User sessions
- Auction state
- Analytics logging
All services communicate via synchronous REST calls.
```

**✅ Expected Review Output:**
```
## Executive Summary: ❌ FAIL

### Critical Risks (Severity: HIGH)
1. **SPOF**: Single PostgreSQL instance
   - Impact: Total system failure
   - Recommendation: Implement read replicas + connection pooling

2. **Scalability**: REST for 10K/sec bidding
   - Impact: Latency spikes, timeouts
   - Recommendation: WebSockets for real-time + message queue (Kafka)

3. **Data Strategy**: Mixed OLTP/OLAP workloads
   - Impact: Query contention, degraded performance
   - Recommendation: Separate analytics to ClickHouse/TimescaleDB
```

---

## Backend Agents

### python-refactor.md
**Profile:** Python Core Developer transforming "script-kiddie" code into professional, Pythonic engineering.

* **Scenario:** Refactoring a file processing script with multiple anti-patterns.
* **The Problem:** String concatenation, no type hints, os.path usage, and missing context managers.

**📝 Input Code:**
```python
import os

def process_files(dir):
    results = []
    files = os.listdir(dir)
    for f in files:
        path = dir + "/" + f
        if os.path.isfile(path) and f.endswith(".txt"):
            file = open(path, "r")
            content = file.read()
            file.close()
            results.append({"name": f, "size": len(content)})
    return results
```

**✅ Refactored Output:**
```python
from pathlib import Path
from typing import TypedDict

class FileInfo(TypedDict):
    name: str
    size: int

def process_text_files(directory: Path) -> list[FileInfo]:
    """Process all .txt files in directory and return their metadata."""
    return [
        FileInfo(name=file.name, size=file.stat().st_size)
        for file in directory.glob("*.txt")
        if file.is_file()
    ]
```

---

### python-optimizer.md
**Profile:** Python Efficiency Expert focused on bypassing GIL limitations and maximizing performance.

* **Scenario:** A data processing function is slow due to inefficient loop patterns.
* **The Problem:** Manual loops instead of vectorized operations, excessive memory allocation.

**📝 Input Code:**
```python
def calculate_statistics(numbers):
    total = 0
    for n in numbers:
        total = total + n
    average = total / len(numbers)

    squared_diffs = []
    for n in numbers:
        squared_diffs.append((n - average) ** 2)

    variance = 0
    for sd in squared_diffs:
        variance = variance + sd
    variance = variance / len(numbers)

    return {"mean": average, "variance": variance}
```

**✅ Optimized Output:**
```python
import numpy as np
from functools import lru_cache

def calculate_statistics(numbers: np.ndarray) -> dict[str, float]:
    """Calculate mean and variance using vectorized NumPy operations."""
    mean = np.mean(numbers)
    variance = np.var(numbers)
    return {"mean": float(mean), "variance": float(variance)}

# For repeated calls with same data:
@lru_cache(maxsize=128)
def calculate_statistics_cached(numbers: tuple[float, ...]) -> dict[str, float]:
    arr = np.array(numbers)
    return {"mean": float(np.mean(arr)), "variance": float(np.var(arr))}
```

---

### java-optimizer.md
**Profile:** Java Performance Architect minimizing latency and GC pauses while maximizing throughput.

* **Scenario:** A Java service has high GC pressure and latency spikes.
* **The Problem:** String concatenation in loops, auto-boxing overhead, and excessive object creation.

**📝 Input Code:**
```java
public List<String> processRecords(List<Record> records) {
    List<String> results = new ArrayList<>();
    for (Record r : records) {
        String output = "";
        output = output + r.getId() + ": ";
        output = output + r.getName() + " (";
        output = output + r.getScore() + ")";
        results.add(output);
    }
    return results;
}
```

**✅ Optimized Output:**
```java
public List<String> processRecords(List<Record> records) {
    List<String> results = new ArrayList<>(records.size()); // Pre-size
    StringBuilder sb = new StringBuilder(64); // Reusable buffer

    for (Record r : records) {
        sb.setLength(0); // Reset instead of new allocation
        sb.append(r.getId())
          .append(": ")
          .append(r.getName())
          .append(" (")
          .append(r.getScore())
          .append(")");
        results.add(sb.toString());
    }
    return results;
}
```

---

### spring-boot-engineer.md
**Profile:** Senior Spring Boot engineer building scalable, cloud-native microservices with reactive programming.

* **Scenario:** Creating a REST endpoint with proper validation, error handling, and documentation.
* **The Problem:** Need production-ready endpoint following Spring Boot 3 best practices.

**📝 Input Requirements:**
```
Create a user registration endpoint with:
- Input validation
- Custom error responses
- OpenAPI documentation
- Service layer separation
```

**✅ Expected Output:**
```java
@RestController
@RequestMapping("/api/v1/users")
@Tag(name = "User Management")
@Validated
public class UserController {

    private final UserService userService;

    @PostMapping
    @Operation(summary = "Register new user")
    @ApiResponses({
        @ApiResponse(responseCode = "201", description = "User created"),
        @ApiResponse(responseCode = "400", description = "Validation error"),
        @ApiResponse(responseCode = "409", description = "Email already exists")
    })
    public ResponseEntity<UserResponse> register(
            @Valid @RequestBody UserRegistrationRequest request) {
        User user = userService.register(request);
        return ResponseEntity
            .status(HttpStatus.CREATED)
            .body(UserResponse.from(user));
    }
}

public record UserRegistrationRequest(
    @NotBlank @Email String email,
    @NotBlank @Size(min = 8, max = 100) String password,
    @NotBlank @Size(min = 2, max = 50) String name
) {}
```

---

### golang-pro.md
**Profile:** Senior Go developer building high-performance concurrent systems following Go proverbs.

* **Scenario:** Implementing a concurrent worker pool for processing jobs.
* **The Problem:** Need goroutine-safe implementation with proper cancellation and error handling.

**📝 Input Requirements:**
```
Create a worker pool that:
- Processes jobs concurrently with N workers
- Supports context cancellation
- Collects results and errors
- Uses channels properly
```

**✅ Expected Output:**
```go
type Job func(ctx context.Context) (any, error)

type Result struct {
    Value any
    Err   error
}

func WorkerPool(ctx context.Context, workers int, jobs <-chan Job) <-chan Result {
    results := make(chan Result, workers)

    var wg sync.WaitGroup
    for i := 0; i < workers; i++ {
        wg.Add(1)
        go func() {
            defer wg.Done()
            for {
                select {
                case <-ctx.Done():
                    return
                case job, ok := <-jobs:
                    if !ok {
                        return
                    }
                    value, err := job(ctx)
                    select {
                    case results <- Result{Value: value, Err: err}:
                    case <-ctx.Done():
                        return
                    }
                }
            }
        }()
    }

    go func() {
        wg.Wait()
        close(results)
    }()

    return results
}
```

---

### laravel-specialist.md
**Profile:** Senior Laravel specialist building elegant, scalable applications with Laravel 10+.

* **Scenario:** Creating an API resource with proper transformation and pagination.
* **The Problem:** Need clean API responses following Laravel conventions.

**📝 Input Requirements:**
```
Create API resources for Order model with:
- Nested product relationships
- Conditional attribute loading
- Pagination support
```

**✅ Expected Output:**
```php
class OrderResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'status' => $this->status,
            'total' => $this->formatted_total,
            'created_at' => $this->created_at->toISOString(),

            // Conditional loading
            'products' => ProductResource::collection(
                $this->whenLoaded('products')
            ),

            'customer' => new CustomerResource(
                $this->whenLoaded('customer')
            ),

            // Include only when requested
            $this->mergeWhen($request->include_metadata, [
                'metadata' => $this->metadata,
            ]),
        ];
    }
}

// Controller usage
public function index(Request $request): AnonymousPaginatedResourceCollection
{
    $orders = Order::query()
        ->with(['products', 'customer'])
        ->latest()
        ->paginate($request->per_page ?? 15);

    return OrderResource::collection($orders);
}
```

---

### cpp-refactor.md
**Profile:** Modern C++ Expert modernizing code with RAII, smart pointers, and C++17/20/23 features.

* **Scenario:** Refactoring legacy C++ code with manual memory management.
* **The Problem:** Raw pointers, C-style casts, and memory leak potential.

**📝 Input Code:**
```cpp
class DataProcessor {
    int* data;
    int size;
public:
    DataProcessor(int n) {
        size = n;
        data = new int[n];
    }
    ~DataProcessor() {
        delete[] data;
    }
    void process(void* input) {
        int* values = (int*)input;
        for (int i = 0; i < size; i++) {
            data[i] = values[i] * 2;
        }
    }
};
```

**✅ Refactored Output:**
```cpp
#include <vector>
#include <span>
#include <algorithm>
#include <ranges>

class DataProcessor {
    std::vector<int> data_;

public:
    explicit DataProcessor(std::size_t n) : data_(n) {}

    void process(std::span<const int> input) {
        std::ranges::transform(
            input | std::views::take(data_.size()),
            data_.begin(),
            [](int value) { return value * 2; }
        );
    }

    [[nodiscard]] std::span<const int> data() const noexcept {
        return data_;
    }
};
```

---

### perl-optimizer.md
**Profile:** Modern Perl 5 expert specializing in text processing speed and Regex optimization.

* **Scenario:** Optimizing a slow Perl script that processes log files.
* **The Problem:** Inefficient regex compilation, sorting, and reference passing.

**📝 Input Code:**
```perl
sub process_logs {
    my @lines = @_;  # Copy by value!
    my @results;

    foreach my $line (@lines) {
        if ($line =~ /ERROR: (.*)/) {  # Recompiles each iteration
            push @results, $1;
        }
    }

    # Inefficient sort
    @results = sort { length($a) <=> length($b) } @results;
    return @results;
}
```

**✅ Optimized Output:**
```perl
use constant ERROR_PATTERN => qr/ERROR: (.*)/o;  # Compile once

sub process_logs {
    my $lines_ref = shift;  # Pass by reference

    # Schwartzian Transform for efficient sorting
    my @results =
        map  { $_->[0] }
        sort { $a->[1] <=> $b->[1] }
        map  { [$_, length($_)] }
        map  { $_ =~ ERROR_PATTERN ? $1 : () }
        @$lines_ref;

    return \@results;  # Return reference
}
```

---

## Quality Agents

### penetration-tester.md
**Profile:** Senior penetration tester specializing in ethical hacking and vulnerability assessment.

* **Scenario:** Security assessment of a web application's authentication system.
* **The Problem:** Need to identify authentication vulnerabilities before production deployment.

**📝 Input Scope:**
```
Test authentication system for:
- SQL injection in login
- Brute force protection
- Session management
- Password reset flow
```

**✅ Expected Output (Finding Report):**
```markdown
## Vulnerability Report: Authentication System

### Finding #1: SQL Injection in Login
**Severity:** CRITICAL
**CVSS:** 9.8

**Evidence:**
POST /api/login
Content-Type: application/json

{"email": "admin'--", "password": "x"}

Response: 200 OK (Authentication bypassed)

**Impact:** Complete authentication bypass, database access

**Remediation:**
- Use parameterized queries
- Implement input validation
- Add WAF rules

### Finding #2: Missing Rate Limiting
**Severity:** HIGH
**Evidence:** 10,000 login attempts executed without blocking

**Remediation:**
- Implement exponential backoff
- Add CAPTCHA after 5 failures
- Account lockout after 10 attempts
```

---

### chaos-engineer.md
**Profile:** Senior chaos engineer building antifragile systems through controlled failure injection.

* **Scenario:** Testing system resilience when a critical database replica fails.
* **The Problem:** Unknown behavior during partial database failure in production.

**📝 Input Experiment:**
```
Design chaos experiment for:
- PostgreSQL read replica failure
- 25% of read traffic affected
- Measure impact on API latency
- Define rollback criteria
```

**✅ Expected Output (Experiment Plan):**
```markdown
## Chaos Experiment: Database Replica Failure

### Hypothesis
When one PostgreSQL read replica fails, the system will automatically
route traffic to healthy replicas with <10% latency increase.

### Steady State
- API p99 latency: 45ms
- Error rate: 0.1%
- Database connections: 500

### Experiment Variables
- **Action:** Kill read replica 2
- **Blast Radius:** 25% read traffic
- **Duration:** 5 minutes

### Safety Controls
- [ ] Automatic rollback if error rate > 5%
- [ ] Manual kill switch available
- [ ] Customer-facing endpoints excluded

### Metrics to Collect
1. API latency (p50, p95, p99)
2. Connection pool exhaustion events
3. Failover detection time
4. Read traffic redistribution

### Rollback Procedure
1. Restore replica from snapshot
2. Re-add to load balancer pool
3. Verify replication lag < 500ms
```

---

### architect-reviewer.md
**Profile:** Expert architecture reviewer validating system designs and technology choices.

* **Scenario:** Reviewing a proposed microservices architecture for an e-commerce platform.
* **The Problem:** Evaluating if the design will scale and remain maintainable.

**📝 Input Architecture:**
```
Proposed: 15 microservices with:
- Synchronous REST between all services
- Shared PostgreSQL database
- No caching layer
- Manual deployment via SSH
```

**✅ Expected Review Output:**
```markdown
## Architecture Review: E-Commerce Platform

### Overall Assessment: ⚠️ NEEDS REVISION

### Pattern Evaluation
| Pattern | Current | Recommended |
|---------|---------|-------------|
| Communication | Sync REST | Event-driven + Sync for queries |
| Data | Shared DB | Database per service |
| Caching | None | Redis for sessions/catalog |
| Deployment | Manual SSH | GitOps + Kubernetes |

### Critical Issues

1. **Distributed Monolith Risk**
   - 15 services sharing one database
   - Tight coupling via direct calls
   - **Action:** Define bounded contexts, separate data stores

2. **Scalability Ceiling**
   - Sync calls create cascading latency
   - No circuit breakers
   - **Action:** Implement Saga pattern, add Resilience4j

### Recommendations
1. Start with 5 core services (Users, Orders, Inventory, Payments, Shipping)
2. Introduce event bus (Kafka) for eventual consistency
3. Add API Gateway for authentication/routing
4. Implement Redis cache for product catalog
```

---

## Infrastructure Agents

### devops-engineer.md
**Profile:** Senior DevOps engineer bridging development and operations with comprehensive automation.

* **Scenario:** Setting up a CI/CD pipeline for a Node.js application.
* **The Problem:** Manual deployments causing inconsistencies and delayed releases.

**📝 Input Requirements:**
```
Create GitHub Actions pipeline for Node.js with:
- Testing on PR
- Build and push Docker image
- Deploy to Kubernetes staging on merge
- Production deployment with approval
```

**✅ Expected Output (Pipeline):**
```yaml
name: CI/CD Pipeline

on:
  pull_request:
    branches: [main]
  push:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'
      - run: npm ci
      - run: npm test
      - run: npm run lint

  build:
    needs: test
    if: github.event_name == 'push'
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: docker/setup-buildx-action@v3
      - uses: docker/build-push-action@v5
        with:
          push: true
          tags: registry.io/app:${{ github.sha }}
          cache-from: type=gha
          cache-to: type=gha,mode=max

  deploy-staging:
    needs: build
    runs-on: ubuntu-latest
    environment: staging
    steps:
      - uses: azure/k8s-set-context@v3
      - run: kubectl set image deployment/app app=registry.io/app:${{ github.sha }}

  deploy-production:
    needs: deploy-staging
    runs-on: ubuntu-latest
    environment:
      name: production
      url: https://app.example.com
    steps:
      - uses: azure/k8s-set-context@v3
        with:
          cluster-name: prod-cluster
      - run: kubectl set image deployment/app app=registry.io/app:${{ github.sha }}
```

---

### deployment-engineer.md
**Profile:** Senior deployment engineer specializing in CI/CD pipelines and zero-downtime releases.

* **Scenario:** Implementing blue-green deployment for a critical service.
* **The Problem:** Current deployments cause brief downtime during releases.

**📝 Input Requirements:**
```
Implement blue-green deployment with:
- Kubernetes ingress switching
- Health check validation
- Automatic rollback on failure
- Traffic gradual shift
```

**✅ Expected Output (Strategy):**
```yaml
# Blue-Green Deployment with Argo Rollouts
apiVersion: argoproj.io/v1alpha1
kind: Rollout
metadata:
  name: api-service
spec:
  replicas: 5
  strategy:
    blueGreen:
      activeService: api-service-active
      previewService: api-service-preview
      autoPromotionEnabled: false
      prePromotionAnalysis:
        templates:
          - templateName: success-rate
        args:
          - name: service-name
            value: api-service-preview
      postPromotionAnalysis:
        templates:
          - templateName: success-rate
      scaleDownDelaySeconds: 300
  template:
    spec:
      containers:
        - name: api
          image: registry.io/api:latest
          readinessProbe:
            httpGet:
              path: /health
              port: 8080
            initialDelaySeconds: 10
            periodSeconds: 5
```

---

### incident-responder.md
**Profile:** Senior incident responder managing security and operational incidents with rapid response.

* **Scenario:** Responding to a potential data breach alert.
* **The Problem:** Anomalous database queries detected outside business hours.

**📝 Input Alert:**
```
ALERT: Unusual database activity
- Time: 03:42 UTC (Sunday)
- Source IP: 192.168.1.105 (internal)
- Queries: SELECT * FROM users (500K rows exported)
- User: service_account_backup
```

**✅ Expected Response Playbook:**
```markdown
## Incident Response: Potential Data Exfiltration

### Severity: HIGH | Status: INVESTIGATING

### Immediate Actions (First 15 minutes)
1. [ ] **Contain**: Revoke service_account_backup credentials
2. [ ] **Preserve**: Snapshot affected database and logs
3. [ ] **Isolate**: Block IP 192.168.1.105 at firewall

### Evidence Collection
- [ ] Database query logs (past 24 hours)
- [ ] Authentication logs for service account
- [ ] Network flow logs from source IP
- [ ] Backup job schedules (verify legitimacy)

### Investigation Questions
1. Is this a legitimate backup job? → Check cron schedules
2. Who has access to service_account_backup?
3. What data was accessed? (PII columns?)
4. Was data transferred externally?

### Communication Plan
| Time | Stakeholder | Message |
|------|-------------|---------|
| +15m | Security Lead | Initial assessment |
| +30m | VP Engineering | Incident scope |
| +2h | Legal | If PII involved |
| +4h | Customers | If breach confirmed |
```

---

### network-engineer.md
**Profile:** Senior network engineer designing cloud and hybrid network architectures with zero-trust principles.

* **Scenario:** Designing a multi-region VPC architecture for high availability.
* **The Problem:** Single-region deployment with no disaster recovery capability.

**📝 Input Requirements:**
```
Design AWS network for:
- Primary: us-east-1
- DR: us-west-2
- Private subnets for application tier
- Public subnets for load balancers
- VPN to on-premise datacenter
```

**✅ Expected Output (Architecture):**
```hcl
# Multi-Region VPC with Transit Gateway
module "vpc_primary" {
  source  = "terraform-aws-modules/vpc/aws"

  name = "primary-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = false  # HA: NAT per AZ

  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_ec2_transit_gateway" "main" {
  description = "Multi-region transit gateway"

  default_route_table_association = "disable"
  default_route_table_propagation = "disable"
}

resource "aws_ec2_transit_gateway_vpc_attachment" "primary" {
  transit_gateway_id = aws_ec2_transit_gateway.main.id
  vpc_id             = module.vpc_primary.vpc_id
  subnet_ids         = module.vpc_primary.private_subnets
}
```

---

## Core Agents

### graphql-architect.md
**Profile:** Senior GraphQL architect designing efficient, scalable API graphs with federation.

* **Scenario:** Designing a federated GraphQL schema for an e-commerce platform.
* **The Problem:** Multiple teams need to own different parts of the schema independently.

**📝 Input Requirements:**
```
Design federated schema for:
- User service (authentication, profiles)
- Product service (catalog, inventory)
- Order service (cart, checkout, history)
Enable cross-service queries like "user's orders with product details"
```

**✅ Expected Output (Schema):**
```graphql
# User Subgraph
type User @key(fields: "id") {
  id: ID!
  email: String!
  name: String!
  createdAt: DateTime!
}

type Query {
  me: User @authenticated
  user(id: ID!): User
}

# Product Subgraph
type Product @key(fields: "sku") {
  sku: ID!
  name: String!
  price: Money!
  inventory: Int!
}

extend type Query {
  products(filter: ProductFilter, first: Int, after: String): ProductConnection!
  product(sku: ID!): Product
}

# Order Subgraph
type Order @key(fields: "id") {
  id: ID!
  user: User!
  items: [OrderItem!]!
  total: Money!
  status: OrderStatus!
}

type OrderItem {
  product: Product!
  quantity: Int!
  unitPrice: Money!
}

extend type User @key(fields: "id") {
  id: ID! @external
  orders(first: Int, after: String): OrderConnection!
}
```

---

### microservices-architect.md
**Profile:** Distributed systems architect designing scalable microservice ecosystems.

* **Scenario:** Decomposing a monolith into microservices for an online marketplace.
* **The Problem:** Tight coupling and scaling issues in the current monolithic architecture.

**📝 Input Context:**
```
Current monolith handles:
- User management
- Product listings
- Order processing
- Payment handling
- Notifications
Need to decompose for independent scaling and team ownership.
```

**✅ Expected Output (Decomposition Plan):**
```markdown
## Microservices Decomposition Strategy

### Service Boundaries (Domain-Driven)

| Service | Responsibility | Data Store | Team |
|---------|---------------|------------|------|
| User | Auth, profiles | PostgreSQL | Platform |
| Catalog | Products, search | Elasticsearch + PostgreSQL | Product |
| Order | Cart, checkout | PostgreSQL | Commerce |
| Payment | Transactions | PostgreSQL (isolated) | Finance |
| Notification | Email, SMS, push | Redis | Platform |

### Communication Patterns
- **Synchronous:** User → Order (auth validation)
- **Eventual:** Order → Notification (email confirmation)
- **Saga Pattern:** Order → Payment → Inventory

### Migration Phases
1. **Phase 1:** Extract User service (2 weeks)
2. **Phase 2:** Extract Notification service (1 week)
3. **Phase 3:** Extract Catalog with Strangler Fig (4 weeks)
4. **Phase 4:** Extract Order/Payment together (6 weeks)
```

---

### websocket-engineer.md
**Profile:** Real-time communication specialist implementing scalable WebSocket architectures.

* **Scenario:** Building a real-time collaborative document editor.
* **The Problem:** Need to handle thousands of concurrent connections with sub-100ms latency.

**📝 Input Requirements:**
```
Build WebSocket system for:
- Real-time cursor positions
- Document change synchronization
- Presence indicators (who's online)
- Horizontal scaling across multiple servers
```

**✅ Expected Output (Architecture):**
```typescript
// Server-side WebSocket handler with Redis pub/sub for scaling
import { Server } from 'socket.io';
import { createAdapter } from '@socket.io/redis-adapter';
import { Redis } from 'ioredis';

const pubClient = new Redis(process.env.REDIS_URL);
const subClient = pubClient.duplicate();

const io = new Server(server, {
  adapter: createAdapter(pubClient, subClient),
  cors: { origin: process.env.ALLOWED_ORIGINS?.split(',') }
});

io.on('connection', (socket) => {
  const { documentId, userId } = socket.handshake.auth;

  // Join document room
  socket.join(`doc:${documentId}`);

  // Broadcast presence
  socket.to(`doc:${documentId}`).emit('user:joined', {
    userId,
    timestamp: Date.now()
  });

  // Handle cursor updates (high frequency)
  socket.on('cursor:move', (position) => {
    socket.to(`doc:${documentId}`).volatile.emit('cursor:update', {
      userId,
      position
    });
  });

  // Handle document changes (reliable delivery)
  socket.on('doc:change', async (operation) => {
    const result = await applyOperation(documentId, operation);
    io.to(`doc:${documentId}`).emit('doc:changed', result);
  });

  socket.on('disconnect', () => {
    socket.to(`doc:${documentId}`).emit('user:left', { userId });
  });
});
```

---

## Data Agents

### data-engineer.md
**Profile:** Senior data engineer building scalable data pipelines and ETL/ELT processes.

* **Scenario:** Building a data pipeline for processing e-commerce events.
* **The Problem:** Raw event data needs to be transformed and loaded into a data warehouse.

**📝 Input Requirements:**
```
Build pipeline for:
- Source: Kafka topic (order events)
- Transform: Enrich with product details
- Load: Snowflake warehouse
- SLA: < 15 minute latency
```

**✅ Expected Output (Airflow DAG):**
```python
from airflow import DAG
from airflow.providers.apache.kafka.operators.consume import ConsumeFromKafkaOperator
from airflow.providers.snowflake.operators.snowflake import SnowflakeOperator
from datetime import datetime, timedelta

default_args = {
    'retries': 3,
    'retry_delay': timedelta(minutes=2),
    'execution_timeout': timedelta(minutes=10),
}

with DAG(
    'order_events_pipeline',
    default_args=default_args,
    schedule_interval='*/15 * * * *',
    start_date=datetime(2024, 1, 1),
    catchup=False,
    tags=['orders', 'etl'],
) as dag:

    extract_events = ConsumeFromKafkaOperator(
        task_id='extract_order_events',
        topics=['order.events'],
        max_messages=10000,
        apply_function='plugins.transformers.parse_order_event',
    )

    load_staging = SnowflakeOperator(
        task_id='load_to_staging',
        sql="""
            COPY INTO staging.order_events
            FROM @order_events_stage
            FILE_FORMAT = (TYPE = 'JSON')
            ON_ERROR = 'CONTINUE';
        """,
    )

    transform_enrich = SnowflakeOperator(
        task_id='transform_and_enrich',
        sql="""
            MERGE INTO analytics.fact_orders AS target
            USING (
                SELECT
                    e.order_id,
                    e.customer_id,
                    p.product_name,
                    p.category,
                    e.quantity,
                    e.total_amount,
                    e.event_timestamp
                FROM staging.order_events e
                JOIN dimensions.dim_products p ON e.product_sku = p.sku
                WHERE e.processed_at IS NULL
            ) AS source
            ON target.order_id = source.order_id
            WHEN NOT MATCHED THEN INSERT (*);
        """,
    )

    extract_events >> load_staging >> transform_enrich
```

---

### postgres-pro.md
**Profile:** Senior PostgreSQL expert mastering database administration and performance optimization.

* **Scenario:** Optimizing a slow query on a large orders table.
* **The Problem:** Query takes 30+ seconds due to missing indexes and suboptimal execution plan.

**📝 Input Query:**
```sql
SELECT o.*, c.name as customer_name, p.name as product_name
FROM orders o
JOIN customers c ON o.customer_id = c.id
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
WHERE o.created_at > '2024-01-01'
  AND o.status = 'completed'
  AND c.country = 'US'
ORDER BY o.created_at DESC
LIMIT 100;
```

**✅ Optimized Solution:**
```sql
-- Create composite index for common query pattern
CREATE INDEX CONCURRENTLY idx_orders_status_created
ON orders (status, created_at DESC)
WHERE status = 'completed';

-- Partial index for active customers by country
CREATE INDEX CONCURRENTLY idx_customers_country
ON customers (id, name)
WHERE country = 'US';

-- Covering index for order_items
CREATE INDEX CONCURRENTLY idx_order_items_order_product
ON order_items (order_id)
INCLUDE (product_id);

-- Optimized query with explicit join hints
SELECT o.id, o.created_at, o.total_amount,
       c.name as customer_name,
       p.name as product_name
FROM orders o
JOIN customers c ON o.customer_id = c.id AND c.country = 'US'
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
WHERE o.status = 'completed'
  AND o.created_at > '2024-01-01'
ORDER BY o.created_at DESC
LIMIT 100;

-- Verify with EXPLAIN ANALYZE
EXPLAIN (ANALYZE, BUFFERS, FORMAT TEXT)
-- Query above
```

**Expected Improvement:** Query time reduced from 30s to <100ms with proper index usage.

---

## Misc Agents

### code-explain.md
**Profile:** Code education expert explaining complex code through clear narratives and visual diagrams.

* **Scenario:** Explaining a complex recursive algorithm to a junior developer.
* **The Problem:** The developer doesn't understand how the recursion unfolds.

**📝 Input Code:**
```python
def merge_sort(arr):
    if len(arr) <= 1:
        return arr

    mid = len(arr) // 2
    left = merge_sort(arr[:mid])
    right = merge_sort(arr[mid:])

    return merge(left, right)

def merge(left, right):
    result = []
    i = j = 0
    while i < len(left) and j < len(right):
        if left[i] <= right[j]:
            result.append(left[i])
            i += 1
        else:
            result.append(right[j])
            j += 1
    result.extend(left[i:])
    result.extend(right[j:])
    return result
```

**✅ Expected Explanation:**
```markdown
## Merge Sort Explained

### What This Code Does
Merge Sort is a "divide and conquer" algorithm that sorts a list by:
1. Splitting it in half repeatedly until you have single elements
2. Merging the pieces back together in sorted order

**Key Concepts**: Recursion, Divide and Conquer
**Difficulty Level**: Intermediate

### Step-by-Step Execution

For input `[38, 27, 43, 3]`:

1. **Split**: `[38, 27]` and `[43, 3]`
2. **Split again**: `[38]`, `[27]`, `[43]`, `[3]`
3. **Merge pairs**: `[27, 38]`, `[3, 43]`
4. **Final merge**: `[3, 27, 38, 43]`

### Why It Works
- Single elements are already sorted (base case)
- Merging two sorted lists is efficient (O(n))
- Guaranteed O(n log n) time complexity
```

---

## Quick Reference

| Agent | Use Case | Key Input |
|-------|----------|-----------|
| `clean-code-expert` | Refactor messy code | Code snippet |
| `legacy-modernizer` | Migrate old systems | Legacy codebase |
| `docker-specialist` | Containerize apps | App requirements |
| `api-designer` | Design REST/GraphQL APIs | Business requirements |
| `penetration-tester` | Security testing | Scope & targets |
| `devops-engineer` | CI/CD pipelines | Project type |
| `data-engineer` | Data pipelines | Source & destination |
| `postgres-pro` | Database optimization | Slow queries |

---

*Generated for Claude Code Agents Library*
