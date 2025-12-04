# Usage Examples for Claude Code Agents

Comprehensive usage examples with realistic scenarios, problem statements, and terminal commands.

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

**💻 Command:**
```bash
claude -p agents/generic/clean-code-expert.md "Refactor this function: $(cat utils.py)"
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

**💻 Command:**
```bash
claude -p agents/generic/legacy-modernizer.md "$(cat billing_processor.php)" \
  --context "Target: PHP 8 + Laravel, Zero downtime required"
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

**💻 Command:**
```bash
claude -p agents/generic/prompt-engineer.md "Optimize this prompt for consistency and token efficiency: $(cat current_prompt.txt)"
```

**✅ Expected Output:**
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

**💻 Command:**
```bash
claude -p agents/generic/docker-specialist.md "Create production Dockerfile for Node.js 18 Express API with security best practices"
```

**✅ Expected Output:**
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
```

**💻 Command:**
```bash
claude -p agents/generic/api-designer.md "Design REST API for order management with pagination, filtering, error handling, and rate limiting"
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

**💻 Command:**
```bash
claude -p agents/generic/arquitect-reviewer.md "Review this architecture for 10K bids/sec real-time bidding platform: $(cat architecture.md)"
```

**✅ Expected Output:**
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

### task-manager.md
**Profile:** Agile task management expert breaking down complex projects into actionable items.

* **Scenario:** A new feature request needs to be broken down into sprint tasks.
* **The Problem:** Vague requirements need structured decomposition with estimates.

**📝 Input Request:**
```
Add dark mode support to the web application
```

**💻 Command:**
```bash
claude -p agents/generic/task-manager.md "Break down: Add dark mode support to React web app with existing Tailwind CSS"
```

**✅ Expected Output:**
```markdown
## Epic: Dark Mode Support

### Sprint Tasks

| ID | Task | Estimate | Priority |
|----|------|----------|----------|
| DM-1 | Create color token system (CSS variables) | 2h | P0 |
| DM-2 | Add ThemeContext provider | 1h | P0 |
| DM-3 | Implement useTheme hook | 1h | P0 |
| DM-4 | Add theme toggle component | 2h | P1 |
| DM-5 | Migrate existing components to tokens | 4h | P1 |
| DM-6 | Persist preference to localStorage | 1h | P2 |
| DM-7 | Respect system preference (prefers-color-scheme) | 1h | P2 |
| DM-8 | Add E2E tests for theme switching | 2h | P2 |

**Total Estimate:** 14h (~2 days)
```

---

### database-administrator.md
**Profile:** Senior DBA expert in database design, optimization, and high availability configurations.

* **Scenario:** Designing a database schema for a multi-tenant SaaS application.
* **The Problem:** Need proper isolation, efficient querying, and scalability considerations.

**📝 Input Requirements:**
```
Design schema for multi-tenant SaaS:
- Tenant isolation
- User management per tenant
- Audit logging
- Soft deletes
```

**💻 Command:**
```bash
claude -p agents/generic/database-administrator.md "Design PostgreSQL schema for multi-tenant SaaS with row-level security"
```

**✅ Expected Output:**
```sql
-- Tenant isolation with RLS
CREATE TABLE tenants (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    subdomain VARCHAR(63) UNIQUE NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    deleted_at TIMESTAMPTZ
);

CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id UUID NOT NULL REFERENCES tenants(id),
    email VARCHAR(255) NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    deleted_at TIMESTAMPTZ,
    UNIQUE(tenant_id, email)
);

-- Row Level Security
ALTER TABLE users ENABLE ROW LEVEL SECURITY;

CREATE POLICY tenant_isolation ON users
    USING (tenant_id = current_setting('app.current_tenant')::UUID);
```

---

### cloud-architect.md
**Profile:** Senior cloud architect designing scalable, cost-effective infrastructure on AWS/GCP/Azure.

* **Scenario:** Designing a serverless architecture for an event processing system.
* **The Problem:** Need cost-effective, auto-scaling solution for variable workloads.

**📝 Input Requirements:**
```
Process webhook events from 10+ integrations
Peak: 10K events/minute
Store events for 90 days
Real-time dashboard updates
```

**💻 Command:**
```bash
claude -p agents/generic/cloud-architect.md "Design serverless event processing on AWS: 10K events/min peak, 90-day retention, real-time dashboard"
```

**✅ Expected Output:**
```
## Serverless Event Processing Architecture

### Components
- **Ingestion:** API Gateway + Lambda (webhook receivers)
- **Queue:** SQS FIFO (deduplication, ordering)
- **Processing:** Lambda (event processors)
- **Storage:** DynamoDB (hot, 7 days) → S3 (cold, 90 days)
- **Real-time:** DynamoDB Streams → Lambda → WebSocket API

### Cost Estimate (10K events/min avg)
| Service | Monthly Cost |
|---------|-------------|
| Lambda | $45 |
| API Gateway | $35 |
| DynamoDB | $120 |
| S3 | $15 |
| **Total** | **~$215/month** |
```

---

### git-workflow-manager.md
**Profile:** Git expert managing branching strategies, merge conflicts, and repository workflows.

* **Scenario:** Establishing a Git workflow for a team transitioning from SVN.
* **The Problem:** Team needs clear branching strategy and PR guidelines.

**📝 Input Context:**
```
Team size: 8 developers
Release cycle: 2-week sprints
Environments: dev, staging, production
Current pain: Long-lived branches, merge conflicts
```

**💻 Command:**
```bash
claude -p agents/generic/git-workflow-manager.md "Design Git workflow for 8-person team with 2-week sprints and dev/staging/prod environments"
```

**✅ Expected Output:**
```markdown
## Git Flow Strategy

### Branch Structure
- `main` → Production (protected)
- `develop` → Integration branch
- `feature/*` → Feature branches (from develop)
- `release/*` → Release candidates
- `hotfix/*` → Production fixes

### Branch Naming
```
feature/JIRA-123-add-user-auth
bugfix/JIRA-456-fix-login-error
hotfix/JIRA-789-security-patch
```

### PR Requirements
- [ ] Linked to JIRA ticket
- [ ] 1+ approvals required
- [ ] CI pipeline passes
- [ ] No merge conflicts
- [ ] Squash merge to develop
```

---

### fullstack-developer.md
**Profile:** Senior fullstack developer building end-to-end features across frontend and backend.

* **Scenario:** Implementing a real-time notification system.
* **The Problem:** Need coordinated frontend/backend implementation with WebSocket support.

**📝 Input Requirements:**
```
Implement notification system:
- Backend: Node.js + WebSocket
- Frontend: React
- Types: info, warning, error
- Persistence: Last 50 notifications
```

**💻 Command:**
```bash
claude -p agents/generic/fullstack-developer.md "Implement real-time notifications: Node.js WebSocket backend + React frontend"
```

**✅ Expected Output:**

Backend (Node.js):
```javascript
// notification.service.js
const WebSocket = require('ws');

class NotificationService {
  constructor() {
    this.clients = new Map();
  }

  broadcast(userId, notification) {
    const client = this.clients.get(userId);
    if (client?.readyState === WebSocket.OPEN) {
      client.send(JSON.stringify(notification));
    }
  }
}
```

Frontend (React):
```typescript
// useNotifications.ts
export function useNotifications() {
  const [notifications, setNotifications] = useState<Notification[]>([]);

  useEffect(() => {
    const ws = new WebSocket(WS_URL);
    ws.onmessage = (event) => {
      const notification = JSON.parse(event.data);
      setNotifications(prev => [notification, ...prev].slice(0, 50));
    };
    return () => ws.close();
  }, []);

  return notifications;
}
```

---

### documentation-engineer.md
**Profile:** Technical documentation expert creating clear, maintainable documentation.

* **Scenario:** Creating API documentation for a REST service.
* **The Problem:** Existing docs are outdated and lack examples.

**📝 Input Context:**
```
Document the /users endpoint:
- GET /users - List users
- POST /users - Create user
- GET /users/:id - Get user
- PUT /users/:id - Update user
- DELETE /users/:id - Delete user
```

**💻 Command:**
```bash
claude -p agents/generic/documentation-engineer.md "Generate API docs for users CRUD endpoints with examples"
```

**✅ Expected Output:**
```markdown
# Users API

## List Users
`GET /api/v1/users`

### Query Parameters
| Name | Type | Description |
|------|------|-------------|
| page | integer | Page number (default: 1) |
| limit | integer | Items per page (default: 20) |

### Example Request
```bash
curl -X GET "https://api.example.com/v1/users?page=1&limit=10" \
  -H "Authorization: Bearer <token>"
```

### Example Response
```json
{
  "data": [
    {"id": "123", "email": "user@example.com", "name": "John Doe"}
  ],
  "meta": {"page": 1, "total": 42}
}
```
```

---

### build-engineer.md
**Profile:** Build systems expert optimizing CI/CD pipelines and build configurations.

* **Scenario:** Optimizing a slow monorepo build that takes 45 minutes.
* **The Problem:** No caching, sequential builds, unnecessary rebuilds.

**📝 Input Context:**
```
Monorepo with:
- 5 Node.js services
- 3 React apps
- Shared libraries
- Current build time: 45 minutes
- CI: GitHub Actions
```

**💻 Command:**
```bash
claude -p agents/generic/build-engineer.md "Optimize 45-min monorepo build: 5 Node services, 3 React apps, GitHub Actions"
```

**✅ Expected Output:**
```yaml
# Optimized GitHub Actions workflow
name: Optimized Build

on:
  push:
    branches: [main]

jobs:
  detect-changes:
    runs-on: ubuntu-latest
    outputs:
      services: ${{ steps.filter.outputs.changes }}
    steps:
      - uses: dorny/paths-filter@v2
        id: filter
        with:
          filters: |
            service-a: 'services/a/**'
            service-b: 'services/b/**'
            shared: 'packages/shared/**'

  build:
    needs: detect-changes
    strategy:
      matrix:
        service: ${{ fromJson(needs.detect-changes.outputs.services) }}
    steps:
      - uses: actions/cache@v3
        with:
          path: ~/.npm
          key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}

      - run: npm ci --workspace=${{ matrix.service }}
      - run: npm run build --workspace=${{ matrix.service }}
```

**Expected Improvement:** Build time reduced from 45 min to ~8 min.

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

**💻 Command:**
```bash
claude -p agents/backend/python/python-refactor.md "$(cat file_processor.py)"
```

**✅ Expected Output:**
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

**💻 Command:**
```bash
claude -p agents/backend/python/python-optimizer.md "$(cat stats.py)"
```

**✅ Expected Output:**
```python
import numpy as np
from functools import lru_cache

def calculate_statistics(numbers: np.ndarray) -> dict[str, float]:
    """Calculate mean and variance using vectorized NumPy operations."""
    mean = np.mean(numbers)
    variance = np.var(numbers)
    return {"mean": float(mean), "variance": float(variance)}
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

**💻 Command:**
```bash
claude -p agents/backend/java/java-optimizer.md "$(cat RecordProcessor.java)"
```

**✅ Expected Output:**
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

**💻 Command:**
```bash
claude -p agents/backend/java/spring-boot-engineer.md "Create user registration endpoint with validation and OpenAPI docs"
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

### java-architect.md
**Profile:** Senior Java architect designing enterprise-grade systems with clean architecture.

* **Scenario:** Designing a hexagonal architecture for an order processing system.
* **The Problem:** Current monolithic design makes testing and scaling difficult.

**📝 Input Requirements:**
```
Design order processing module with:
- Hexagonal architecture
- Domain-driven design
- External payment gateway integration
- Event publishing
```

**💻 Command:**
```bash
claude -p agents/backend/java/java-architect.md "Design hexagonal architecture for order processing with DDD"
```

**✅ Expected Output:**
```
## Hexagonal Architecture: Order Processing

### Package Structure
```
com.example.order/
├── domain/
│   ├── model/          # Order, OrderLine, OrderStatus
│   ├── port/
│   │   ├── in/         # OrderUseCase, PaymentUseCase
│   │   └── out/        # OrderRepository, PaymentGateway
│   └── service/        # OrderDomainService
├── application/
│   └── service/        # OrderApplicationService
├── adapter/
│   ├── in/
│   │   ├── web/        # OrderController
│   │   └── messaging/  # OrderEventListener
│   └── out/
│       ├── persistence/# OrderJpaRepository
│       └── payment/    # StripePaymentAdapter
└── config/             # Spring configuration
```

### Domain Model
```java
@Entity
public class Order {
    @Id
    private OrderId id;
    private CustomerId customerId;
    private List<OrderLine> lines;
    private OrderStatus status;
    private Money total;

    public void place() {
        validateOrderCanBePlaced();
        this.status = OrderStatus.PLACED;
        registerEvent(new OrderPlacedEvent(this));
    }
}
```
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

**💻 Command:**
```bash
claude -p agents/backend/go/golang-pro.md "Create concurrent worker pool with context cancellation"
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

**💻 Command:**
```bash
claude -p agents/backend/php/laravel-specialist.md "Create Order API resource with nested relationships and pagination"
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

**💻 Command:**
```bash
claude -p agents/backend/cpp/cpp-refactor.md "$(cat DataProcessor.cpp)"
```

**✅ Expected Output:**
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

    @results = sort { length($a) <=> length($b) } @results;
    return @results;
}
```

**💻 Command:**
```bash
claude -p agents/backend/perl/perl-optimizer.md "$(cat log_processor.pl)"
```

**✅ Expected Output:**
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

**💻 Command:**
```bash
claude -p agents/quality/penetration-tester.md "Test auth system: login SQLi, brute force, sessions, password reset" \
  --context "Target: https://staging.example.com, Scope: auth endpoints only"
```

**✅ Expected Output:**
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

**💻 Command:**
```bash
claude -p agents/quality/chaos-engineer.md "Design experiment: PostgreSQL replica failure, 25% traffic, measure latency"
```

**✅ Expected Output:**
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

**💻 Command:**
```bash
claude -p agents/quality/architect-reviewer.md "Review: 15 microservices, shared DB, sync REST, manual deploy"
```

**✅ Expected Output:**
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

**💻 Command:**
```bash
claude -p agents/infrastructure/devops-engineer.md "Create GitHub Actions CI/CD: Node.js, Docker, K8s staging/prod with approvals"
```

**✅ Expected Output:**
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
```

**💻 Command:**
```bash
claude -p agents/infrastructure/deployment-engineer.md "Implement blue-green deployment on Kubernetes with auto-rollback"
```

**✅ Expected Output:**
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

**💻 Command:**
```bash
claude -p agents/infrastructure/incident-responder.md "Respond to: 500K user rows exported at 3AM by service_account_backup from internal IP"
```

**✅ Expected Output:**
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

### Communication Plan
| Time | Stakeholder | Message |
|------|-------------|---------|
| +15m | Security Lead | Initial assessment |
| +30m | VP Engineering | Incident scope |
| +2h | Legal | If PII involved |
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

**💻 Command:**
```bash
claude -p agents/infrastructure/network-engineer.md "Design multi-region AWS VPC: us-east-1 primary, us-west-2 DR, VPN to on-prem"
```

**✅ Expected Output:**
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
}

resource "aws_ec2_transit_gateway" "main" {
  description = "Multi-region transit gateway"
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
```

**💻 Command:**
```bash
claude -p agents/core/graphql-architect.md "Design federated GraphQL for: users, products, orders services"
```

**✅ Expected Output:**
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

# Order Subgraph
type Order @key(fields: "id") {
  id: ID!
  user: User!
  items: [OrderItem!]!
  total: Money!
  status: OrderStatus!
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
```

**💻 Command:**
```bash
claude -p agents/core/microservices-architect.md "Decompose monolith: users, products, orders, payments, notifications"
```

**✅ Expected Output:**
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
1. **Phase 1:** Extract User service
2. **Phase 2:** Extract Notification service
3. **Phase 3:** Extract Catalog with Strangler Fig
4. **Phase 4:** Extract Order/Payment together
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

**💻 Command:**
```bash
claude -p agents/core/websocket-engineer.md "Design WebSocket system for collaborative editor: cursors, sync, presence, horizontal scaling"
```

**✅ Expected Output:**
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

  socket.join(`doc:${documentId}`);

  socket.to(`doc:${documentId}`).emit('user:joined', {
    userId,
    timestamp: Date.now()
  });

  socket.on('cursor:move', (position) => {
    socket.to(`doc:${documentId}`).volatile.emit('cursor:update', {
      userId,
      position
    });
  });

  socket.on('doc:change', async (operation) => {
    const result = await applyOperation(documentId, operation);
    io.to(`doc:${documentId}`).emit('doc:changed', result);
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

**💻 Command:**
```bash
claude -p agents/data/data-engineer.md "Build Kafka → Snowflake pipeline with product enrichment, <15min SLA"
```

**✅ Expected Output:**
```python
from airflow import DAG
from airflow.providers.apache.kafka.operators.consume import ConsumeFromKafkaOperator
from airflow.providers.snowflake.operators.snowflake import SnowflakeOperator
from datetime import datetime, timedelta

with DAG(
    'order_events_pipeline',
    schedule_interval='*/15 * * * *',
    catchup=False,
) as dag:

    extract_events = ConsumeFromKafkaOperator(
        task_id='extract_order_events',
        topics=['order.events'],
        max_messages=10000,
    )

    transform_enrich = SnowflakeOperator(
        task_id='transform_and_enrich',
        sql="""
            MERGE INTO analytics.fact_orders AS target
            USING staging.order_events AS source
            ON target.order_id = source.order_id
            WHEN NOT MATCHED THEN INSERT (*);
        """,
    )

    extract_events >> transform_enrich
```

---

### postgres-pro.md
**Profile:** Senior PostgreSQL expert mastering database administration and performance optimization.

* **Scenario:** Optimizing a slow query on a large orders table.
* **The Problem:** Query takes 30+ seconds due to missing indexes and suboptimal execution plan.

**📝 Input Query:**
```sql
SELECT o.*, c.name as customer_name
FROM orders o
JOIN customers c ON o.customer_id = c.id
WHERE o.created_at > '2024-01-01'
  AND o.status = 'completed'
ORDER BY o.created_at DESC
LIMIT 100;
```

**💻 Command:**
```bash
claude -p agents/data/sql/postgres-pro.md "Optimize: $(cat slow_query.sql)"
```

**✅ Expected Output:**
```sql
-- Create composite index for common query pattern
CREATE INDEX CONCURRENTLY idx_orders_status_created
ON orders (status, created_at DESC)
WHERE status = 'completed';

-- Verify with EXPLAIN ANALYZE
EXPLAIN (ANALYZE, BUFFERS, FORMAT TEXT)
SELECT o.id, o.created_at, o.total_amount,
       c.name as customer_name
FROM orders o
JOIN customers c ON o.customer_id = c.id
WHERE o.status = 'completed'
  AND o.created_at > '2024-01-01'
ORDER BY o.created_at DESC
LIMIT 100;
```

**Expected Improvement:** Query time reduced from 30s to <100ms.

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
```

**💻 Command:**
```bash
claude -p agents/misc/code-explain.md "$(cat merge_sort.py)"
```

**✅ Expected Output:**
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

| Agent | Command | Use Case |
|-------|---------|----------|
| `clean-code-expert` | `claude -p agents/generic/clean-code-expert.md "$(cat file.py)"` | Refactor messy code |
| `python-refactor` | `claude -p agents/backend/python/python-refactor.md "$(cat script.py)"` | Pythonic refactoring |
| `docker-specialist` | `claude -p agents/generic/docker-specialist.md "Containerize Node.js app"` | Create Dockerfiles |
| `api-designer` | `claude -p agents/generic/api-designer.md "Design users API"` | REST/GraphQL design |
| `penetration-tester` | `claude -p agents/quality/penetration-tester.md "Test login security"` | Security testing |
| `devops-engineer` | `claude -p agents/infrastructure/devops-engineer.md "Create CI/CD pipeline"` | Pipeline automation |
| `postgres-pro` | `claude -p agents/data/sql/postgres-pro.md "$(cat query.sql)"` | Query optimization |
| `code-explain` | `claude -p agents/misc/code-explain.md "$(cat algorithm.py)"` | Code explanation |

---

*Generated for Claude Code Agents Library*
