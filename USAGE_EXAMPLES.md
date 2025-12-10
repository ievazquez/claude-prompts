# Usage Examples for Claude Code Agents

Comprehensive usage examples with realistic scenarios, problem statements, and terminal commands.

---

## Table of Contents

1. [Generic Agents](#generic-agents)
2. [Frontend Agents](#frontend-agents)
3. [Backend Agents](#backend-agents)
4. [Quality Agents](#quality-agents)
5. [Infrastructure Agents](#infrastructure-agents)
6. [Core Agents](#core-agents)
7. [Data Agents](#data-agents)
8. [Misc Agents](#misc-agents)

---

## Generic Agents

### clean-code-expert.md
**Profile:** Polyglot Senior Software Engineer specializing in refactoring code for Python, Java, and C++ to production-ready standards.

* **Scenario:** A junior developer wrote a Python script for data processing that works but violates multiple PEP 8 guidelines and contains code smells.
* **The Problem:** Nested conditionals, magic numbers, missing type hints, and poor naming conventions make the code hard to maintain and extend.

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
claude "@clean-code-expert Refactor this Python function to follow clean code principles and PEP 8"
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

**📝 Input Code:**
```php
<?php
function get_user($id) {
    $conn = mysql_connect("localhost", "root", "");
    mysql_select_db("users", $conn);
    $result = mysql_query("SELECT * FROM users WHERE id = " . $id);
    $row = mysql_fetch_array($result);
    mysql_close($conn);
    return $row;
}
?>
```

**💻 Command:**
```bash
claude "@legacy-modernizer Migrate this PHP 5 code to PHP 8 with Laravel best practices"
```

**✅ Expected Output:**
```php
<?php

namespace App\Repositories;

use App\Models\User;
use Illuminate\Database\Eloquent\ModelNotFoundException;

class UserRepository
{
    public function find(int $id): User
    {
        return User::findOrFail($id);
    }
}
```

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
claude "@prompt-engineer Optimize this customer support prompt for consistency and token efficiency"
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
* **The Problem:** Current Docker image is 1.2GB (too large), runs as root (security risk), and has no layer caching optimization (slow builds).

**📝 Input Dockerfile:**
```dockerfile
FROM node:18
WORKDIR /app
COPY . .
RUN npm install
EXPOSE 3000
CMD ["node", "server.js"]
```

**💻 Command:**
```bash
claude "@docker-specialist Optimize this Dockerfile for production with security best practices"
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
* **The Problem:** Need consistent pagination, proper error handling, versioning strategy, and rate limiting for API stability.

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
claude "@api-designer Design REST API for order management with pagination, filtering, and rate limiting"
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
Current design:
- Single PostgreSQL database for all data
- 10K bids/second expected load
- Synchronous REST calls between all services
- No caching layer
- User sessions stored in database
```

**💻 Command:**
```bash
claude "@arquitect-reviewer Review this architecture for a 10K bids/sec real-time bidding platform"
```

**✅ Expected Output:**
```markdown
## Architecture Review: Real-Time Bidding Platform

### Overall Assessment: ❌ CRITICAL ISSUES FOUND

### Risk Analysis

| Issue | Severity | Impact |
|-------|----------|--------|
| Single PostgreSQL | CRITICAL | Total system failure on DB outage |
| Sync REST at 10K/sec | HIGH | Cascading latency, timeouts |
| No caching | HIGH | Unnecessary DB load |
| Sessions in DB | MEDIUM | Performance degradation |

### Recommendations

1. **Database**: Read replicas + PgBouncer connection pooling
2. **Communication**: WebSockets for bidding, Kafka for events
3. **Caching**: Redis for sessions and hot data
4. **Analytics**: Separate to ClickHouse/TimescaleDB
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
claude "@task-manager Break down this feature into sprint tasks: Add dark mode to React app with Tailwind CSS"
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
- Shared tables approach
```

**💻 Command:**
```bash
claude "@database-administrator Design PostgreSQL schema for multi-tenant SaaS with row-level security"
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
claude "@cloud-architect Design serverless event processing on AWS: 10K events/min peak, 90-day retention"
```

**✅ Expected Output:**
```markdown
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
claude "@git-workflow-manager Design Git workflow for 8-person team with 2-week sprints"
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

### Branch Naming Convention
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
claude "@fullstack-developer Implement real-time notifications with Node.js WebSocket backend and React frontend"
```

**✅ Expected Output:**

**Backend (Node.js):**
```javascript
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

**Frontend (React):**
```typescript
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

**📝 Input Code:**
```javascript
app.get('/users', getUsers);
app.post('/users', createUser);
app.get('/users/:id', getUser);
app.put('/users/:id', updateUser);
app.delete('/users/:id', deleteUser);
```

**💻 Command:**
```bash
claude "@documentation-engineer Generate API docs for these users CRUD endpoints with examples"
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
```yaml
# Current slow workflow
name: Build
on: push
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm install
      - run: npm run build
      - run: npm test
```

**💻 Command:**
```bash
claude "@build-engineer Optimize this 45-min monorepo build for GitHub Actions"
```

**✅ Expected Output:**
```yaml
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

## Frontend Agents

### javascript-pro.md
**Profile:** Expert JavaScript developer specializing in modern ES2023+ features, asynchronous programming, and full-stack development.

* **Scenario:** Refactoring callback-based code to modern async/await with proper error handling.
* **The Problem:** Legacy code uses nested callbacks (callback hell) making it hard to maintain and debug.

**📝 Input Code:**
```javascript
function getUserData(userId, callback) {
    fetchUser(userId, function(err, user) {
        if (err) return callback(err);
        fetchProfile(user.id, function(err, profile) {
            if (err) return callback(err);
            fetchPosts(user.id, function(err, posts) {
                if (err) return callback(err);
                callback(null, { user, profile, posts });
            });
        });
    });
}
```

**💻 Command:**
```bash
claude "@javascript-pro Refactor this callback-based code to async/await with proper error handling"
```

**✅ Expected Output:**
```javascript
/**
 * Fetches complete user data including profile and posts
 * @param {string} userId - The user identifier
 * @returns {Promise<{user: User, profile: Profile, posts: Post[]}>}
 * @throws {Error} When user data cannot be retrieved
 */
async function getUserData(userId) {
    try {
        const user = await fetchUser(userId);
        const [profile, posts] = await Promise.all([
            fetchProfile(user.id),
            fetchPosts(user.id)
        ]);

        return { user, profile, posts };
    } catch (error) {
        console.error(`Failed to fetch data for user ${userId}:`, error);
        throw new Error(`User data retrieval failed: ${error.message}`);
    }
}
```

---

### react-specialist.md
**Profile:** Expert React specialist mastering React 18+ with modern patterns and production-ready architectures.

* **Scenario:** Optimizing a slow component that re-renders unnecessarily.
* **The Problem:** Product list component re-renders on every parent update, causing performance issues.

**📝 Input Code:**
```jsx
function ProductList({ products, onAddToCart }) {
    return (
        <div>
            {products.map(product => (
                <div key={product.id}>
                    <h3>{product.name}</h3>
                    <p>${product.price}</p>
                    <button onClick={() => onAddToCart(product)}>
                        Add to Cart
                    </button>
                </div>
            ))}
        </div>
    );
}
```

**💻 Command:**
```bash
claude "@react-specialist Optimize this component to prevent unnecessary re-renders"
```

**✅ Expected Output:**
```jsx
import { memo, useCallback } from 'react';

const ProductItem = memo(({ product, onAddToCart }) => {
    const handleClick = useCallback(() => {
        onAddToCart(product);
    }, [product, onAddToCart]);

    return (
        <div className="product-item">
            <h3>{product.name}</h3>
            <p>${product.price.toFixed(2)}</p>
            <button onClick={handleClick} aria-label={`Add ${product.name} to cart`}>
                Add to Cart
            </button>
        </div>
    );
});

ProductItem.displayName = 'ProductItem';

export const ProductList = memo(({ products, onAddToCart }) => {
    return (
        <div className="product-list" role="list">
            {products.map(product => (
                <ProductItem
                    key={product.id}
                    product={product}
                    onAddToCart={onAddToCart}
                />
            ))}
        </div>
    );
});

ProductList.displayName = 'ProductList';
```

---

### vue-expert.md
**Profile:** Expert Vue specialist mastering Vue 3 with Composition API and Nuxt 3 development.

* **Scenario:** Migrating Options API component to Composition API with improved reactivity.
* **The Problem:** Legacy Options API component needs modernization to Vue 3 standards.

**📝 Input Code:**
```vue
<script>
export default {
    data() {
        return {
            users: [],
            loading: false,
            searchTerm: ''
        }
    },
    computed: {
        filteredUsers() {
            return this.users.filter(u =>
                u.name.toLowerCase().includes(this.searchTerm.toLowerCase())
            );
        }
    },
    methods: {
        async fetchUsers() {
            this.loading = true;
            const response = await fetch('/api/users');
            this.users = await response.json();
            this.loading = false;
        }
    },
    mounted() {
        this.fetchUsers();
    }
}
</script>
```

**💻 Command:**
```bash
claude "@vue-expert Migrate this Options API component to Composition API with TypeScript"
```

**✅ Expected Output:**
```vue
<script setup lang="ts">
import { ref, computed, onMounted } from 'vue';

interface User {
    id: number;
    name: string;
    email: string;
}

const users = ref<User[]>([]);
const loading = ref(false);
const searchTerm = ref('');

const filteredUsers = computed(() =>
    users.value.filter(user =>
        user.name.toLowerCase().includes(searchTerm.value.toLowerCase())
    )
);

async function fetchUsers() {
    loading.value = true;
    try {
        const response = await fetch('/api/users');
        if (!response.ok) throw new Error('Failed to fetch users');
        users.value = await response.json();
    } catch (error) {
        console.error('Error fetching users:', error);
    } finally {
        loading.value = false;
    }
}

onMounted(() => {
    fetchUsers();
});
</script>

<template>
    <div>
        <input
            v-model="searchTerm"
            type="search"
            placeholder="Search users..."
            aria-label="Search users"
        />
        <div v-if="loading">Loading...</div>
        <ul v-else>
            <li v-for="user in filteredUsers" :key="user.id">
                {{ user.name }}
            </li>
        </ul>
    </div>
</template>
```

---

### ui-designer.md
**Profile:** Expert visual designer specializing in creating intuitive, beautiful, and accessible user interfaces.

* **Scenario:** Designing a design system for a multi-product company.
* **The Problem:** Inconsistent UI across products, no shared components, and accessibility gaps.

**📝 Input Requirements:**
```
Products: 3 web apps, 2 mobile apps
Brand: Modern SaaS, professional
Users: B2B professionals
Needs: Consistency, accessibility (WCAG 2.1 AA), dark mode
```

**💻 Command:**
```bash
claude "@ui-designer Create design system foundation with tokens, components, and accessibility guidelines"
```

**✅ Expected Output:**
```css
/* Design Tokens - tokens.css */
:root {
    /* Color Palette - Light Mode */
    --color-primary: #3B82F6;
    --color-primary-hover: #2563EB;
    --color-secondary: #8B5CF6;
    --color-surface: #FFFFFF;
    --color-background: #F9FAFB;
    --color-text-primary: #111827;
    --color-text-secondary: #6B7280;
    --color-border: #E5E7EB;

    /* Typography */
    --font-family-sans: 'Inter', system-ui, sans-serif;
    --font-size-xs: 0.75rem;
    --font-size-sm: 0.875rem;
    --font-size-base: 1rem;
    --font-size-lg: 1.125rem;
    --font-size-xl: 1.25rem;
    --font-size-2xl: 1.5rem;

    /* Spacing */
    --space-1: 0.25rem;
    --space-2: 0.5rem;
    --space-3: 0.75rem;
    --space-4: 1rem;
    --space-6: 1.5rem;
    --space-8: 2rem;

    /* Border Radius */
    --radius-sm: 0.25rem;
    --radius-md: 0.375rem;
    --radius-lg: 0.5rem;

    /* Shadows */
    --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
    --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
    --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
}

/* Dark Mode */
[data-theme="dark"] {
    --color-surface: #1F2937;
    --color-background: #111827;
    --color-text-primary: #F9FAFB;
    --color-text-secondary: #D1D5DB;
    --color-border: #374151;
}

/* Button Component */
.btn {
    font-family: var(--font-family-sans);
    font-size: var(--font-size-base);
    padding: var(--space-3) var(--space-6);
    border-radius: var(--radius-md);
    border: none;
    cursor: pointer;
    transition: all 0.2s ease;
    font-weight: 500;
}

.btn-primary {
    background: var(--color-primary);
    color: white;
}

.btn-primary:hover {
    background: var(--color-primary-hover);
    box-shadow: var(--shadow-md);
}

.btn-primary:focus-visible {
    outline: 2px solid var(--color-primary);
    outline-offset: 2px;
}
```

**Deliverables:**
- Design tokens (colors, typography, spacing)
- Component library (buttons, inputs, cards, etc.)
- Accessibility annotations (ARIA, keyboard navigation)
- Dark mode variants
- Usage documentation

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
claude "@python-refactor Refactor this file processing script to modern Pythonic standards"
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
claude "@python-optimizer Optimize this statistics function for performance"
```

**✅ Expected Output:**
```python
import numpy as np

def calculate_statistics(numbers: np.ndarray) -> dict[str, float]:
    """Calculate mean and variance using vectorized NumPy operations."""
    return {
        "mean": float(np.mean(numbers)),
        "variance": float(np.var(numbers))
    }
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
claude "@java-optimizer Optimize this method to reduce GC pressure and improve throughput"
```

**✅ Expected Output:**
```java
public List<String> processRecords(List<Record> records) {
    List<String> results = new ArrayList<>(records.size());
    StringBuilder sb = new StringBuilder(64);

    for (Record r : records) {
        sb.setLength(0);
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

**📝 Input Code:**
```java
@PostMapping("/users")
public User createUser(@RequestBody Map<String, String> data) {
    User user = new User();
    user.setEmail(data.get("email"));
    user.setPassword(data.get("password"));
    user.setName(data.get("name"));
    return userRepo.save(user);
}
```

**💻 Command:**
```bash
claude "@spring-boot-engineer Refactor this endpoint with validation, error handling, and OpenAPI docs"
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

**📝 Input Code:**
```java
@Service
public class OrderService {
    @Autowired
    private OrderRepository repo;
    @Autowired
    private PaymentGateway payment;
    @Autowired
    private EmailService email;

    public Order createOrder(OrderDTO dto) {
        Order order = new Order(dto);
        repo.save(order);
        payment.charge(order);
        email.send(order);
        return order;
    }
}
```

**💻 Command:**
```bash
claude "@java-architect Refactor to hexagonal architecture with proper port/adapter separation"
```

**✅ Expected Output:**
```
## Hexagonal Architecture: Order Processing

### Package Structure
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

---

### golang-pro.md
**Profile:** Senior Go developer building high-performance concurrent systems following Go proverbs.

* **Scenario:** Implementing a concurrent worker pool for processing jobs.
* **The Problem:** Need goroutine-safe implementation with proper cancellation and error handling.

**📝 Input Code:**
```go
func processJobs(jobs []Job) []Result {
    var results []Result
    for _, job := range jobs {
        result := job.Process()
        results = append(results, result)
    }
    return results
}
```

**💻 Command:**
```bash
claude "@golang-pro Implement concurrent worker pool with context cancellation and error handling"
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

**📝 Input Code:**
```php
public function index() {
    $orders = DB::table('orders')
        ->join('customers', 'orders.customer_id', '=', 'customers.id')
        ->select('orders.*', 'customers.name')
        ->get();
    return response()->json($orders);
}
```

**💻 Command:**
```bash
claude "@laravel-specialist Refactor with API resources, eager loading, and pagination"
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
            'customer' => new CustomerResource($this->whenLoaded('customer')),
            $this->mergeWhen($request->include_metadata, [
                'metadata' => $this->metadata,
            ]),
        ];
    }
}

// Controller
public function index(Request $request): AnonymousPaginatedResourceCollection
{
    $orders = Order::query()
        ->with(['customer'])
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
claude "@cpp-refactor Modernize this class with RAII, smart pointers, and C++20 features"
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
    my @lines = @_;
    my @results;

    foreach my $line (@lines) {
        if ($line =~ /ERROR: (.*)/) {
            push @results, $1;
        }
    }

    @results = sort { length($a) <=> length($b) } @results;
    return @results;
}
```

**💻 Command:**
```bash
claude "@perl-optimizer Optimize this log processor for performance"
```

**✅ Expected Output:**
```perl
use constant ERROR_PATTERN => qr/ERROR: (.*)/o;

sub process_logs {
    my $lines_ref = shift;

    # Schwartzian Transform for efficient sorting
    my @results =
        map  { $_->[0] }
        sort { $a->[1] <=> $b->[1] }
        map  { [$_, length($_)] }
        map  { $_ =~ ERROR_PATTERN ? $1 : () }
        @$lines_ref;

    return \@results;
}
```

---

## Quality Agents

### performance-engineer.md
**Profile:** Expert performance engineer specializing in system optimization, bottleneck identification, and scalability engineering.

* **Scenario:** API endpoint is slow under load, taking 2.1 seconds to respond.
* **The Problem:** Database N+1 queries and missing indexes causing performance degradation.

**📝 Input Code:**
```javascript
app.get('/api/orders', async (req, res) => {
    const orders = await Order.findAll();
    const result = [];

    for (const order of orders) {
        const customer = await Customer.findById(order.customerId);
        const items = await OrderItem.findAll({ orderId: order.id });
        result.push({ order, customer, items });
    }

    res.json(result);
});
```

**💻 Command:**
```bash
claude "@performance-engineer Optimize this endpoint: current response time 2.1s, target <200ms"
```

**✅ Expected Output:**
```javascript
const { Order, Customer, OrderItem } = require('./models');

// Optimized with eager loading and proper indexing
app.get('/api/orders', async (req, res) => {
    try {
        const orders = await Order.findAll({
            include: [
                {
                    model: Customer,
                    attributes: ['id', 'name', 'email']
                },
                {
                    model: OrderItem,
                    attributes: ['id', 'productId', 'quantity', 'price']
                }
            ],
            order: [['createdAt', 'DESC']],
            limit: 100 // Pagination
        });

        res.json(orders);
    } catch (error) {
        console.error('Error fetching orders:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

// Required indexes (migration file):
// CREATE INDEX idx_orders_customer_id ON orders(customer_id);
// CREATE INDEX idx_order_items_order_id ON order_items(order_id);
// CREATE INDEX idx_orders_created_at ON orders(created_at DESC);
```

**Performance Improvements:**
- Response time: 2.1s → 67ms (97% improvement)
- Database queries: 201 → 1 (eliminated N+1 problem)
- Memory usage: Reduced by 40%
- Throughput: 10 RPS → 450 RPS

---

### test-automator.md
**Profile:** Expert test automation engineer building robust test frameworks with comprehensive coverage.

* **Scenario:** Manual regression testing takes 3 days before each release.
* **The Problem:** No automated tests, blocking frequent deployments and causing missed bugs.

**📝 Input Requirements:**
```
Application: E-commerce checkout flow
Tech stack: Node.js + React
Current: 100% manual testing
Target: 80% automation coverage, <30 min execution
```

**💻 Command:**
```bash
claude "@test-automator Design test automation strategy for checkout flow: cart, payment, confirmation"
```

**✅ Expected Output:**

**Test Framework Structure:**
```javascript
// tests/e2e/checkout.spec.js
import { test, expect } from '@playwright/test';
import { CheckoutPage } from '../pages/CheckoutPage';
import { CartPage } from '../pages/CartPage';
import { TestDataFactory } from '../utils/TestDataFactory';

test.describe('Checkout Flow', () => {
    let checkoutPage: CheckoutPage;
    let cartPage: CartPage;

    test.beforeEach(async ({ page }) => {
        checkoutPage = new CheckoutPage(page);
        cartPage = new CartPage(page);
        await page.goto('/');
    });

    test('should complete successful checkout with valid payment', async ({ page }) => {
        // Arrange
        const testUser = TestDataFactory.createUser();
        const testProduct = TestDataFactory.createProduct();

        // Act
        await cartPage.addProduct(testProduct);
        await cartPage.proceedToCheckout();
        await checkoutPage.fillShippingInfo(testUser.address);
        await checkoutPage.selectPaymentMethod('credit-card');
        await checkoutPage.fillPaymentInfo({
            cardNumber: '4242424242424242',
            expiry: '12/25',
            cvc: '123'
        });
        await checkoutPage.submitOrder();

        // Assert
        await expect(page).toHaveURL(/\/order-confirmation/);
        await expect(page.locator('[data-testid="success-message"]'))
            .toContainText('Order placed successfully');
        await expect(page.locator('[data-testid="order-number"]'))
            .toBeVisible();
    });

    test('should show validation errors for invalid payment info', async ({ page }) => {
        const testUser = TestDataFactory.createUser();

        await cartPage.addProduct(TestDataFactory.createProduct());
        await cartPage.proceedToCheckout();
        await checkoutPage.fillShippingInfo(testUser.address);
        await checkoutPage.selectPaymentMethod('credit-card');
        await checkoutPage.fillPaymentInfo({
            cardNumber: '1111',
            expiry: '01/20',
            cvc: '1'
        });
        await checkoutPage.submitOrder();

        await expect(page.locator('[data-testid="error-invalid-card"]'))
            .toBeVisible();
    });

    test('should handle payment gateway timeout gracefully', async ({ page }) => {
        // Mock network delay
        await page.route('**/api/payment', route =>
            route.abort('timedout')
        );

        await cartPage.addProduct(TestDataFactory.createProduct());
        await cartPage.proceedToCheckout();
        // ... complete checkout flow

        await expect(page.locator('[data-testid="error-timeout"]'))
            .toContainText('Payment processing timed out');
    });
});
```

**CI/CD Integration:**
```yaml
# .github/workflows/test.yml
name: E2E Tests

on:
  pull_request:
  push:
    branches: [main]

jobs:
  e2e-tests:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        browser: [chromium, firefox, webkit]
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
      - run: npm ci
      - run: npx playwright install --with-deps
      - run: npm run test:e2e -- --project=${{ matrix.browser }}
      - uses: actions/upload-artifact@v3
        if: failure()
        with:
          name: test-results
          path: test-results/
```

**Results Delivered:**
- Test coverage: 0% → 83%
- Execution time: 3 days → 27 minutes
- Parallel execution: 5 browsers simultaneously
- Regression bugs caught: 15 before production
- Deployment frequency: Monthly → Daily

---

### penetration-tester.md
**Profile:** Senior penetration tester specializing in ethical hacking and vulnerability assessment.

* **Scenario:** Security assessment of a web application's authentication system.
* **The Problem:** Need to identify authentication vulnerabilities before production deployment.

**📝 Input Code:**
```python
@app.route('/login', methods=['POST'])
def login():
    username = request.form['username']
    password = request.form['password']
    query = f"SELECT * FROM users WHERE username='{username}' AND password='{password}'"
    user = db.execute(query).fetchone()
    if user:
        session['user_id'] = user['id']
        return redirect('/dashboard')
    return "Login failed"
```

**💻 Command:**
```bash
claude "@penetration-tester Analyze this login endpoint for security vulnerabilities"
```

**✅ Expected Output:**
```markdown
## Vulnerability Report: Login Endpoint

### Finding #1: SQL Injection
**Severity:** CRITICAL | **CVSS:** 9.8

**Vulnerable Code:**
```python
query = f"SELECT * FROM users WHERE username='{username}'"
```

**Proof of Concept:**
```
username: admin'--
password: anything
```

**Impact:** Complete authentication bypass, database access

**Remediation:**
```python
query = "SELECT * FROM users WHERE username = ? AND password = ?"
user = db.execute(query, (username, hashed_password)).fetchone()
```

### Finding #2: Plain Text Passwords
**Severity:** HIGH

**Remediation:** Use bcrypt or Argon2 for password hashing
```

---

### chaos-engineer.md
**Profile:** Senior chaos engineer building antifragile systems through controlled failure injection.

* **Scenario:** Testing system resilience when a critical database replica fails.
* **The Problem:** Unknown behavior during partial database failure in production.

**📝 Input Requirements:**
```
System: E-commerce platform
Component: PostgreSQL read replica
Traffic: 25% of reads go to this replica
SLA: 99.9% availability
```

**💻 Command:**
```bash
claude "@chaos-engineer Design chaos experiment for PostgreSQL replica failure with 25% traffic impact"
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
Proposed: 15 microservices
- Synchronous REST between all services
- Shared PostgreSQL database
- No caching layer
- Manual deployment via SSH
```

**💻 Command:**
```bash
claude "@architect-reviewer Review this 15-microservice architecture with shared database"
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
   - 15 services sharing one database = tight coupling
   - **Action:** Define bounded contexts, separate data stores

2. **Scalability Ceiling**
   - Sync calls create cascading latency
   - **Action:** Implement Saga pattern, add circuit breakers
```

---

## Infrastructure Agents

### devops-engineer.md
**Profile:** Senior DevOps engineer bridging development and operations with comprehensive automation.

* **Scenario:** Setting up a CI/CD pipeline for a Node.js application.
* **The Problem:** Manual deployments causing inconsistencies and delayed releases.

**📝 Input Requirements:**
```
Stack: Node.js 20
Registry: Docker Hub
Environments: staging, production
Approval: Required for production
```

**💻 Command:**
```bash
claude "@devops-engineer Create GitHub Actions CI/CD for Node.js with Docker and K8s deployment"
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

  build:
    needs: test
    if: github.event_name == 'push'
    runs-on: ubuntu-latest
    steps:
      - uses: docker/build-push-action@v5
        with:
          push: true
          tags: registry.io/app:${{ github.sha }}

  deploy-staging:
    needs: build
    environment: staging
    steps:
      - run: kubectl set image deployment/app app=registry.io/app:${{ github.sha }}

  deploy-production:
    needs: deploy-staging
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

**📝 Input Context:**
```
Current: Rolling update with 30s downtime
Target: Zero-downtime deployment
Platform: Kubernetes
Tool preference: Argo Rollouts
```

**💻 Command:**
```bash
claude "@deployment-engineer Implement blue-green deployment on Kubernetes with auto-rollback"
```

**✅ Expected Output:**
```yaml
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
claude "@incident-responder Create response playbook for potential data exfiltration: 500K rows exported at 3AM"
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
Primary: us-east-1
DR: us-west-2
Connectivity: VPN to on-premise
Workloads: Web tier (public), App tier (private), DB tier (isolated)
```

**💻 Command:**
```bash
claude "@network-engineer Design multi-region AWS VPC with DR and on-prem VPN connectivity"
```

**✅ Expected Output:**
```hcl
module "vpc_primary" {
  source = "terraform-aws-modules/vpc/aws"

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
Services:
- User service (auth, profiles)
- Product service (catalog, inventory)
- Order service (cart, checkout)
Requirement: Cross-service queries like "user's orders with product details"
```

**💻 Command:**
```bash
claude "@graphql-architect Design federated GraphQL schema for users, products, and orders services"
```

**✅ Expected Output:**
```graphql
# User Subgraph
type User @key(fields: "id") {
  id: ID!
  email: String!
  name: String!
}

type Query {
  me: User @authenticated
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
}

extend type User @key(fields: "id") {
  id: ID! @external
  orders: [Order!]!
}
```

---

### microservices-architect.md
**Profile:** Distributed systems architect designing scalable microservice ecosystems.

* **Scenario:** Decomposing a monolith into microservices for an online marketplace.
* **The Problem:** Tight coupling and scaling issues in the current monolithic architecture.

**📝 Input Context:**
```
Current monolith modules:
- User management
- Product listings
- Order processing
- Payment handling
- Notifications
Issues: Can't scale orders independently, deployments affect everything
```

**💻 Command:**
```bash
claude "@microservices-architect Create decomposition strategy for this e-commerce monolith"
```

**✅ Expected Output:**
```markdown
## Microservices Decomposition Strategy

### Service Boundaries (Domain-Driven)

| Service | Responsibility | Data Store | Team |
|---------|---------------|------------|------|
| User | Auth, profiles | PostgreSQL | Platform |
| Catalog | Products, search | Elasticsearch + PG | Product |
| Order | Cart, checkout | PostgreSQL | Commerce |
| Payment | Transactions | PostgreSQL (isolated) | Finance |
| Notification | Email, SMS, push | Redis | Platform |

### Communication Patterns
- **Synchronous:** User → Order (auth validation)
- **Eventual:** Order → Notification (email confirmation)
- **Saga Pattern:** Order → Payment → Inventory

### Migration Phases
1. Extract User service (2 weeks)
2. Extract Notification service (1 week)
3. Extract Catalog with Strangler Fig (4 weeks)
4. Extract Order/Payment together (6 weeks)
```

---

### websocket-engineer.md
**Profile:** Real-time communication specialist implementing scalable WebSocket architectures.

* **Scenario:** Building a real-time collaborative document editor.
* **The Problem:** Need to handle thousands of concurrent connections with sub-100ms latency.

**📝 Input Requirements:**
```
Features needed:
- Real-time cursor positions
- Document change synchronization
- Presence indicators (who's online)
- Must scale horizontally
```

**💻 Command:**
```bash
claude "@websocket-engineer Design scalable WebSocket system for collaborative document editing"
```

**✅ Expected Output:**
```typescript
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

  socket.to(`doc:${documentId}`).emit('user:joined', { userId });

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
Source: Kafka topic (order events)
Destination: Snowflake warehouse
Transform: Enrich with product details
SLA: < 15 minute latency
```

**💻 Command:**
```bash
claude "@data-engineer Build Airflow DAG for Kafka to Snowflake pipeline with 15-min SLA"
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

    extract = ConsumeFromKafkaOperator(
        task_id='extract_order_events',
        topics=['order.events'],
        max_messages=10000,
    )

    load = SnowflakeOperator(
        task_id='load_and_transform',
        sql="""
            MERGE INTO analytics.fact_orders AS target
            USING staging.order_events AS source
            ON target.order_id = source.order_id
            WHEN NOT MATCHED THEN INSERT (*);
        """,
    )

    extract >> load
```

---

### postgres-pro.md
**Profile:** Senior PostgreSQL expert mastering database administration and performance optimization.

* **Scenario:** Optimizing a slow query on a large orders table (10M rows).
* **The Problem:** Query takes 30+ seconds to execute due to missing indexes, suboptimal execution plan, and sequential scans.

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
claude "@postgres-pro Optimize this query that takes 30+ seconds on 10M row table"
```

**✅ Expected Output:**
```sql
-- Create composite partial index
CREATE INDEX CONCURRENTLY idx_orders_status_created
ON orders (status, created_at DESC)
WHERE status = 'completed';

-- Optimized query
SELECT o.id, o.created_at, o.total_amount,
       c.name as customer_name
FROM orders o
JOIN customers c ON o.customer_id = c.id
WHERE o.status = 'completed'
  AND o.created_at > '2024-01-01'
ORDER BY o.created_at DESC
LIMIT 100;

-- Verify improvement
EXPLAIN (ANALYZE, BUFFERS) <query>;
```

**Expected Improvement:** 30s → <100ms

---

## Misc Agents

### code-explain.md
**Profile:** Code education expert explaining complex code through clear narratives and visual diagrams.

* **Scenario:** Explaining a complex recursive algorithm to a junior developer who is new to recursion.
* **The Problem:** The developer doesn't understand how the recursion unfolds step-by-step and why it's more efficient than iterative approaches.

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
claude "@code-explain Explain this merge sort implementation step-by-step for a beginner"
```

**✅ Expected Output:**
```markdown
## Merge Sort Explained

### What This Code Does
Merge Sort is a "divide and conquer" algorithm that sorts a list by:
1. Splitting it in half repeatedly until you have single elements
2. Merging the pieces back together in sorted order

**Difficulty Level:** Intermediate

### Step-by-Step Execution

For input `[38, 27, 43, 3]`:

1. **Split**: `[38, 27]` and `[43, 3]`
2. **Split again**: `[38]`, `[27]`, `[43]`, `[3]`
3. **Merge pairs**: `[27, 38]`, `[3, 43]`
4. **Final merge**: `[3, 27, 38, 43]`

### Why It Works
- Single elements are already sorted (base case)
- Merging two sorted lists is O(n)
- Total complexity: O(n log n)
```

---

## Quick Reference

| Agent | Command | Use Case |
|-------|---------|----------|
| **Generic** | | |
| `clean-code-expert` | `claude "@clean-code-expert <code>"` | Refactor messy code |
| `legacy-modernizer` | `claude "@legacy-modernizer <code>"` | Modernize legacy systems |
| `prompt-engineer` | `claude "@prompt-engineer <prompt>"` | Optimize LLM prompts |
| `docker-specialist` | `claude "@docker-specialist <dockerfile>"` | Optimize containers |
| `api-designer` | `claude "@api-designer <requirements>"` | Design REST/GraphQL APIs |
| **Frontend** | | |
| `javascript-pro` | `claude "@javascript-pro <code>"` | Modern JavaScript/Node.js |
| `react-specialist` | `claude "@react-specialist <code>"` | React 18+ optimization |
| `vue-expert` | `claude "@vue-expert <code>"` | Vue 3 Composition API |
| `ui-designer` | `claude "@ui-designer <requirements>"` | Design systems & UI |
| **Backend** | | |
| `python-refactor` | `claude "@python-refactor <code>"` | Pythonic refactoring |
| `python-optimizer` | `claude "@python-optimizer <code>"` | Python performance |
| `java-optimizer` | `claude "@java-optimizer <code>"` | Java performance tuning |
| `spring-boot-engineer` | `claude "@spring-boot-engineer <code>"` | Spring Boot development |
| `golang-pro` | `claude "@golang-pro <code>"` | Go concurrent systems |
| `laravel-specialist` | `claude "@laravel-specialist <code>"` | Laravel applications |
| **Quality** | | |
| `performance-engineer` | `claude "@performance-engineer <code>"` | Performance optimization |
| `test-automator` | `claude "@test-automator <requirements>"` | Test automation |
| `penetration-tester` | `claude "@penetration-tester <code>"` | Security analysis |
| `chaos-engineer` | `claude "@chaos-engineer <requirements>"` | Chaos engineering |
| **Infrastructure** | | |
| `devops-engineer` | `claude "@devops-engineer <requirements>"` | CI/CD pipelines |
| `deployment-engineer` | `claude "@deployment-engineer <requirements>"` | Zero-downtime deploys |
| `git-workflow-manager` | `claude "@git-workflow-manager <context>"` | Git workflows |
| `build-engineer` | `claude "@build-engineer <config>"` | Build optimization |
| **Data** | | |
| `postgres-pro` | `claude "@postgres-pro <query>"` | Query optimization |
| `data-engineer` | `claude "@data-engineer <requirements>"` | Data pipelines |
| **Misc** | | |
| `code-explain` | `claude "@code-explain <code>"` | Code explanation |

---

*Generated for Claude Code Agents Library*
