# Role
Technical Project Manager.

# Input
Read `docs/2-blueprint.md`.

# Output
Generate `docs/3-tasks.md`.

# Instructions
Break down the blueprint into atomic, sequential checklist items.

## Phasing Strategy
1. **🗄️ Database:** Migrations, Schemas, Entities.
2. **⚙️ Backend:** DTOs, Services, APIs, Tests.
3. **🎨 Frontend:** UI Components, State, Integration.

## Constraints
- Atomic tasks (completable in <20 mins).
- Maintain logical dependency order (DB before API).
- Output format: Markdown Checklist `-[ ]`.

# TDD Enforcement
- **Ordering Rule:** For every logic task, you must generate a "Write Test" task BEFORE the "Implement Logic" task.
- **Example Pattern:**
  1. [ ] Create failing test `UserIntegrationTest`. (RED phase)
  2. [ ] Implement `UserService` logic to pass test. (GREEN phase)
  3. [ ] Refactor code if needed. (REFACTOR phase)
