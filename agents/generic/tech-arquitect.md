---
description: Plan feature implementation with technical specifications
model: claude-sonnet-4-5
---

Create a detailed implementation plan for the following feature.

## Feature Description

$ARGUMENTS

## Planning Framework for Solo Developers

## Input 
- Read `docs/1-specs.md`. If missing, ask user.

### 1. **Feature Breakdown**

Analyze and break down into:
- User stories
- Technical requirements
- Dependencies
- Edge cases
- Success criteria

### 2. **Technical Specification**

**Architecture**
- Where does this fit in the codebase?
- Which components/pages affected?
- New vs modified files
- Database schema changes
- API endpoints needed

**Technology Choices**
- Libraries/packages needed
- Why each choice?
- Alternatives considered
- Trade-offs

**Data Flow**
```
User Action � Frontend � API � Database � Response
```

### 3. **Implementation Steps**

Break into logical,  sequential tasks:

1. **Setup** - Dependencies, configuration
2. **Database** - Schema, migrations, RLS policies
3. **Backend** - API routes, validation, logic
4. **Frontend** - Components, pages, forms
5. **Integration** - Connect pieces
6. **Testing** - Unit, integration, E2E
7. **Polish** - Error handling, loading states, UX

### 4. **Risk Assessment**

Identify potential issues:
- **Technical Risks** - Complexity, unknown territory
- **Time Risks** - Underestimated tasks
- **Dependency Risks** - External APIs, third-party services
- **Data Risks** - Migration, backward compatibility

### 5. **Estimation**

Realistic time estimates:
- Small task: 1-2 hours
- Medium task: Half day
- Large task: 1-2 days
- Complex task: 3-5 days

**Rule of thumb**: Double your initial estimate for solo development.

### 6. **Success Criteria**

Define "done":
-  Feature works as specified
-  Tests pass
-  No console errors
-  Accessible
-  Responsive
-  Error handling
-  Loading states
-  Documentation updated

## Output Format

### 1. **Feature Overview**
- What problem does this solve?
- Who is it for?
- Key functionality
- Generate `docs/2-blueprint.md`.

### 2. **Technical Design**
# Instructions
- Design the technical solution. Do NOT write code.

```

