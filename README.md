# SafeX Guardian — Industrial HSE Management App

**Project Name:** `safexsolutionsweek4`  
**Internship Program:** SafeX Solutions Internship (Week 4 Client-Ready Sprint)  
**Industry Domain:** Industrial Health, Safety & Environmental Management (HSE)  

---

## 📌 Executive Summary

**SafeX Guardian** is a production-ready mobile application designed for industrial field workers, safety inspectors, and site managers. The app provides a comprehensive solution for real-time hazard reporting, incident lifecycle management, and daily site safety compliance auditing. Built using **Flutter** with reactive state management and local persistence, SafeX Guardian operates seamlessly offline with simulated real-world telemetry and persistent storage.

---

## 🚀 Key Features

### 1. Enterprise Safety Dashboard
* **Dynamic KPI Counters:** Displays real-time metrics for Open Hazards, Hazards In Progress, Resolved Incidents, and Overall Compliance Score.
* **Live Updates:** Automatically reflects status changes made across other screens without requiring manual refreshes.
* **Recent Incidents Feed:** Quick access to high-priority hazard logs directly from the home screen.

### 2. Hazard & Incident Lifecycle Manager
* **Full CRUD & Status Lifecycle:** Allows safety officers to report, track, and update hazard statuses (`Open` → `In Progress` → `Resolved`).
* **Multi-Criteria Filtering & Search:** Search hazards by location or title, and filter by status (`Open`, `In Progress`, `Resolved`).
* **Severity Matrix:** Categorizes incidents into `Low`, `Medium`, `High`, and `Critical` severity levels with color-coded enterprise badges.

### 3. Interactive Site Safety Audit System
* **Live Compliance Scoring:** Automatically calculates the facility's overall safety index (`%`) based on daily pass/fail checklists.
* **Interactive Checklist Items:** Real-time toggle switches across multiple domains (Fire Safety, PPE, Medical, Height Safety, Machinery, Hazmat).
* **Reset & Recalculate:** One-tap audit reset functionality for recurring daily shifts.

### 4. Data Persistence & Architecture
* **Local Data Persistence:** Uses `shared_preferences` and JSON serialization to preserve hazard data across app restarts.
* **Reactive State Management:** Powered by `provider` (`ChangeNotifier`) for decoupled business logic and dynamic UI updates.

---

## 📂 Project Architecture & Directory Structure

All application source code resides under the `lib/` directory:

```
lib/
├── main.dart                      # Application entry point & MultiProvider initialization
├── models/
│   ├── hazard_model.dart          # Data model, enums, & JSON serialization for hazards
│   └── inspection_model.dart      # Data model for safety audit checklist items
├── providers/
│   ├── hazard_provider.dart      # Business logic & SharedPreferences storage for hazards
│   └── inspection_provider.dart  # Business logic & live score computation for safety audits
├── screens/
│   ├── main_navigation_screen.dart # Root navigation with BottomNavigationBar & FAB
│   ├── dashboard_screen.dart     # Safety overview & dynamic KPI metrics
│   ├── hazard_list_screen.dart   # Filterable & searchable hazard log
│   ├── report_hazard_screen.dart # Interactive form to report new safety hazards
│   ├── audit_checklist_screen.dart# Daily safety checklist with live compliance scoring
│   └── incident_detail_screen.dart# Detailed hazard overview & status modifier
└── utils/
    ├── app_theme.dart             # Enterprise dark color palette & custom widget styling
    └── dummy_data.dart            # Realistic initial seed data for demonstration
```

---

## 🛠 Tech Stack & Dependencies

* **Framework:** Flutter (Dart)
* **State Management:** `provider` (^6.1.2)
* **Local Persistence:** `shared_preferences` (^2.2.2)
* **Formatting & Utilities:** `intl` (^0.19.0), `cupertino_icons` (^1.0.6)

---

## ⚙️ Setup & Run Instructions

1. **Clone or navigate to the project directory:**
   ```bash
   cd safexsolutionsweek4
   ```

2. **Add dependencies to `pubspec.yaml`:**
   ```yaml
   dependencies:
     flutter:
       sdk: flutter
     provider: ^6.1.2
     shared_preferences: ^2.2.2
     intl: ^0.19.0
     cupertino_icons: ^1.0.6
   ```

3. **Install dependencies:**
   ```bash
   flutter pub get
   ```

4. **Run the application:**
   ```bash
   flutter run
   ```

---

## 👥 Submission Details

* **Submission Title:** Week 4 Client-Ready App Prototype
* **Developer:** Sufyan Afzal - SafeX Solutions Intern
* **Project Status:** Complete & Client-Ready Prototype