---
layout: distill
title: some software design principles
date: 2024-03-20
description: a simple guide to software design principles from OOP to Functional Programming
tags: [principles, design-patterns, functional-programming, object-oriented, pragmatic-programming]
categories: code
published: true

authors:
  - name: Nasib Naimi
    affiliations:
      name: ETH Zurich

toc:
  - name: Core Principles
  - name: Object-Oriented Design
  - name: Functional Design
  - name: Pragmatic Approaches
  - name: When to Break the Rules
---

Software design principles are guidelines that help us write better code. However, blindly following them can be as dangerous as ignoring them. Let's explore these principles across different paradigms and understand when to apply them.

## Core Principles

### DRY vs WET vs AHA

- **DRY (Don't Repeat Yourself)**
  - Each piece of knowledge should have a single, unambiguous representation
  - But beware: Sometimes duplication is better than the wrong abstraction

- **WET (Write Everything Twice)**
  - Wait until you need to write something three times before abstracting
  - Helps avoid premature abstractions
  - Also known as: Write Explicit Things

- **AHA (Avoid Hasty Abstractions)**
  - Prefer duplication over the wrong abstraction
  - Wrong abstractions are more costly than duplication
  - When in doubt, duplicate first, abstract later

## Object-Oriented Design

### Gang of Four Patterns

Key patterns that remain relevant:

1. **Creational Patterns**
   - Factory Method: When object creation logic should be separate
   - Builder: For complex object construction
   - Singleton: When you genuinely need a single instance (rare!)

2. **Structural Patterns**
   - Adapter: Interface compatibility
   - Decorator: Dynamic behavior extension
   - Composite: Tree structures

3. **Behavioral Patterns**
   - Observer: Event handling
   - Strategy: Interchangeable algorithms
   - Command: Action encapsulation

### SOLID Principles

1. **Single Responsibility**
   - A class should have one reason to change
   - But don't make classes too granular

2. **Open/Closed**
   - Open for extension, closed for modification
   - Use interfaces and composition

3. **Liskov Substitution**
   - Subtypes must be substitutable for their base types
   - Avoid breaking inherited contracts

4. **Interface Segregation**
   - Many specific interfaces better than one general
   - Keep interfaces focused and cohesive

5. **Dependency Inversion**
   - Depend on abstractions, not concretions
   - Use dependency injection

## Functional Design

### Core FP Principles

1. **Immutability**
   ```python
   # Instead of modifying
   def add_item(list, item):
       list.append(item)  # Mutates list
   
   # Create new instance
   def add_item(list, item):
       return list + [item]  # Returns new list
   ```

2. **Pure Functions**
   - Same input → Same output
   - No side effects
   - Easier to test and reason about

3. **Function Composition**
   ```python
   # Compose functions
   def process_data(data):
       return (data
           .pipe(clean)
           .pipe(transform)
           .pipe(validate))
   ```

4. **Higher-Order Functions**
   - Functions that take/return functions
   - Enable powerful abstractions

### Functional Patterns

1. **Monads**
   - For handling side effects
   - Example: Option/Maybe type

2. **Functors**
   - Mappable containers
   - Lists, Trees, Promises

3. **Pattern Matching**
   ```python
   def process(data):
       match data:
           case {'type': 'user', 'name': name}:
               return handle_user(name)
           case {'type': 'admin', 'id': id}:
               return handle_admin(id)
   ```

## Pragmatic Approaches

From "The Pragmatic Programmer":

1. **Orthogonality**
   - Keep things independent
   - Changes should be localized

2. **Tracer Bullets**
   - Get basic end-to-end functionality working first
   - Iterate and improve

3. **Good Enough Software**
   - Perfect is the enemy of good
   - Know when to stop

4. **Don't Live with Broken Windows**
   - Fix small problems before they become big
   - Maintain code quality consistently

## When to Break the Rules

1. **Duplication Over Wrong Abstraction**
   - When the abstraction would couple unrelated concepts
   - When the duplication is simpler to understand

2. **Performance Requirements**
   - When principles conflict with performance needs
   - Document why you broke the rule

3. **Prototyping**
   - When exploring solutions
   - When speed of development > maintainability

4. **Legacy Code**
   - When changes would be too risky
   - When the cost outweighs the benefit

## Modern Perspectives

1. **Domain-Driven Design**
   - Align code with business domain
   - Use ubiquitous language

2. **Microservices Architecture**
   - Service boundaries based on business capabilities
   - Independent deployability

3. **Event-Driven Architecture**
   - Loose coupling through events
   - Reactive systems

## Practical Tips

1. **Start Simple**
   - Don't over-engineer
   - Add complexity only when needed

2. **Consider Context**
   - Team size and experience
   - Project constraints
   - Business requirements

3. **Measure Impact**
   - Monitor technical debt
   - Track maintenance costs
   - Evaluate refactoring ROI

## References

- "Design Patterns" by Gamma, Helm, Johnson, Vlissides
- "The Pragmatic Programmer" by Hunt and Thomas
- "Clean Code" by Robert C. Martin
- "Domain-Driven Design" by Eric Evans
- "Functional Programming in Scala" by Chiusano and Bjarnason
