# 🧪 Odoo UI Automation Testing Learning Path (Raghav Pal Series)

## 🎯 Objective
Build real-world **UI test automation** skills tailored to Odoo module development — verifying form views, buttons, workflows, and API behavior using Playwright, Jenkins, and supporting tools.

---

## 📊 Overall Progress

**Status:** 🟢 In Progress  
**Completion:** 1/7 Phases (14%) | Videos: 4/15 (27%)  
**Last Updated:** 2025-11-06

---

## 🧱 Phase 1 – Testing Mindset (Foundation)

**Status:** ✅ Completed | **Progress:** 2/2 Videos

### 🎥 [Every Beginner should know this 5-Step Process before starting Automation Testing](https://www.youtube.com/watch?v=VDwLyfNJgek)
- **Status:** ✅ Watched
- **Purpose:** Understand automation testing lifecycle and project-level strategy.  
- **In Odoo Context:** Identify which features (like Sales Order creation or custom module validation) need automated tests.
- **Notes:** _Add your notes here after watching_

### 🎥 [How to Start Learning Automation for Beginners #AskRaghav](https://www.youtube.com/watch?v=FDNb-CSCho8)
- **Status:** ✅ Watched
- **Purpose:** Learn how to choose the right automation tools and environment.  
- **In Odoo Context:** Decide when to use Playwright vs Cypress vs Postman.
- **Notes:** _Add your notes here after watching_

**Phase Deliverable:** ✅ Document automation strategy for your Odoo project - COMPLETED

---

## 🌐 Phase 2 – API Testing (Odoo Controller Verification)

**Status:** ⬜ Not Started | **Progress:** 0/2 Videos

### 🎥 [POSTMAN Beginner Tutorial 1 – Introduction | What is Postman](https://www.youtube.com/watch?v=juldrxDrSH0)
- **Status:** ⬜ Not Watched
- **Purpose:** Understand API testing concepts and Postman interface.  
- **In Odoo Context:** Test REST controllers like `/api/delivery_orders` and `/api/sale_orders`.
- **Notes:** _Add your notes here after watching_

### 🎥 [POSTMAN Beginner Tutorial 3 – Create First API Request](https://www.youtube.com/watch?v=cR_FqveTewo)
- **Status:** ⬜ Not Watched
- **Purpose:** Learn to send API requests and validate JSON responses.  
- **In Odoo Context:** Check data returned from custom endpoints after module deployment.
- **Notes:** _Add your notes here after watching_

**Phase Deliverable:** ✅ Create Postman collection for Odoo API endpoints

---

## 💻 Phase 3 – Playwright (Primary Tool for Odoo UI Testing)

**Status:** 🔄 In Progress | **Progress:** 2/5 Videos

### 🎥 [Playwright Beginner Tutorial 1 – What is Playwright](https://www.youtube.com/watch?v=4_m3HsaNwOE)
- **Status:** ✅ Watched
- **Purpose:** Introduction to Playwright features and architecture.  
- **In Odoo Context:** Automate Chromium/Firefox to test Odoo form views and menus.
- **Notes:** _Add your notes here after watching_

### 🎥 [Playwright Beginner Tutorial 2 – Install Playwright](https://www.youtube.com/watch?v=IB2P1FBXjcQ)
- **Status:** ✅ Watched
- **Purpose:** Learn setup and installation steps.  
- **In Odoo Context:** Integrate Playwright inside your Odoo project folder or CI environment.
- **Notes:** Successfully installed Playwright v1.56.1 with Node.js v22.21.1 + VS Code extension

### 🎥 [Playwright Beginner Tutorial 3 – Record and Run your First Test](https://www.youtube.com/watch?v=fN1Cyr7BduU)
- **Status:** ⬜ Not Watched
- **Purpose:** Capture and replay browser actions automatically.  
- **In Odoo Context:** Record tests for "Create > Save > Confirm" flows in Sales or custom models.
- **Notes:** _Add your notes here after watching_

### 🎥 [Playwright Beginner Tutorial 6 – Locators and Assertions](https://www.youtube.com/watch?v=JpGsWZ6Tjrs)
- **Status:** ⬜ Not Watched
- **Purpose:** Master element selection and validation.  
- **In Odoo Context:** Assert that specific buttons, popups, or notifications appear correctly.
- **Notes:** _Add your notes here after watching_

### 🎥 [Playwright Beginner Tutorial 11 – Hooks & Groups](https://www.youtube.com/watch?v=S3NVJo0ySwE)
- **Status:** ⬜ Not Watched
- **Purpose:** Reuse setup/teardown logic for modular testing.  
- **In Odoo Context:** Use hooks to pre-login before testing module flows.
- **Notes:** _Add your notes here after watching_

**Phase Deliverable:** ✅ Create reusable Playwright test templates for Odoo forms

---

## ⚙️ Phase 4 – Cypress (Optional JS-Based Alternative)

**Status:** ⬜ Not Started | **Progress:** 0/1 Videos

### 🎥 [Cypress Complete Beginners Masterclass 1 – Step by Step](https://www.youtube.com/watch?v=tRI5ruE7yCA)
- **Status:** ⬜ Not Watched
- **Purpose:** Learn modern JS automation framework.  
- **In Odoo Context:** Validate DOM behavior and webclient widgets for Odoo's OWL front-end.
- **Notes:** _Add your notes here after watching_

**Phase Deliverable:** ✅ Compare Cypress vs Playwright for Odoo testing

---

## 🧩 Phase 5 – Selenium (Fallback Legacy Tool)

**Status:** ⬜ Not Started | **Progress:** 0/1 Videos

### 🎥 [Selenium 4 Beginner Tutorial 1 – Introduction & Setup](https://www.youtube.com/watch?v=HjYEjKWSbe8)
- **Status:** ⬜ Not Watched
- **Purpose:** Understand Selenium's classical architecture and driver usage.  
- **In Odoo Context:** Alternative for older CI environments that don't support Playwright.
- **Notes:** _Add your notes here after watching_

**Phase Deliverable:** ✅ Document when to use Selenium vs modern tools

---

## 🏗️ Phase 6 – Jenkins CI/CD Integration

**Status:** ⬜ Not Started | **Progress:** 0/3 Videos

### 🎥 [Jenkins Beginner Tutorial 1 – Introduction & Getting Started](https://www.youtube.com/watch?v=6YZvp2GwT0A)
- **Status:** ⬜ Not Watched
- **Purpose:** Learn CI basics and Jenkins architecture.  
- **In Odoo Context:** Automate Playwright test execution after each Odoo module commit.
- **Notes:** _Add your notes here after watching_

### 🎥 [Jenkins Beginner Tutorial 2 – Install Jenkins on Windows/Mac/Linux](https://www.youtube.com/watch?v=FX322RVNGj4)
- **Status:** ⬜ Not Watched
- **Purpose:** Set up Jenkins locally or on a server.  
- **In Odoo Context:** Create a test runner that triggers Playwright after pushing to GitHub.
- **Notes:** _Add your notes here after watching_

### 🎥 [Jenkins Beginner Tutorial 3 – Create First Job | Run Automation Scripts](https://www.youtube.com/watch?v=7KCS70sCoK0)
- **Status:** ⬜ Not Watched
- **Purpose:** Automate builds, triggers, and test scripts.  
- **In Odoo Context:** Integrate automated UI testing in your deployment pipeline.
- **Notes:** _Add your notes here after watching_

**Phase Deliverable:** ✅ Setup Jenkins pipeline for automated Odoo testing

---

## 🚀 Phase 7 – Performance & Load Testing (Optional)

**Status:** ⬜ Not Started | **Progress:** 0/1 Videos

### 🎥 [JMeter Full Course Masterclass | Step by Step for Beginners](https://www.youtube.com/watch?v=SoW2pBak1_Q)
- **Status:** ⬜ Not Watched
- **Purpose:** Learn how to simulate multiple user sessions.  
- **In Odoo Context:** Stress-test endpoints like `/api/sale_orders` under 100+ concurrent requests.
- **Notes:** _Add your notes here after watching_

**Phase Deliverable:** ✅ Create JMeter test plan for Odoo API load testing

---

## 🧭 6-Week Suggested Schedule

| Week | Focus | Core Tools | Deliverables | Status |
|------|--------|-------------|---------------|--------|
| 1 | Foundation + API Testing | Postman | Verify custom controller endpoints | 🔄 In Progress (Phase 1 ✅) |
| 2 | Playwright Setup | Playwright | First automated UI test on Odoo form | ⬜ |
| 3 | Advanced Playwright | Playwright | Modular, reusable UI tests | ⬜ |
| 4 | Cypress Exploration | Cypress | Compare JS vs Python test strategy | ⬜ |
| 5 | CI/CD Integration | Jenkins | Automated test runs per Git commit | ⬜ |
| 6 | Performance Testing | JMeter | Load test API routes | ⬜ |

---

## 🧠 Expected Outcomes

After completing this learning path, you will:
- ✅ Write **Playwright-based test scripts** for Odoo modules  
- ✅ Automate **browser interactions** for forms, buttons, and workflows  
- ✅ Use **Postman for API sanity tests**  
- ✅ Run automated tests through **Jenkins pipelines**  
- ✅ Optionally test performance using **JMeter**

---

## 📝 Progress Tracking Instructions

### How to Update Your Progress

1. **After Watching a Video:**
   - Change status from `⬜ Not Watched` to `✅ Watched`
   - Add your notes in the Notes section
   - Update the phase progress counter

2. **After Completing a Phase:**
   - Change phase status from `⬜ Not Started` to `✅ Completed`
   - Complete the phase deliverable
   - Update overall progress percentage

3. **Status Indicators:**
   - ⬜ Not Started
   - 🔄 In Progress
   - ✅ Completed
   - ⏸️ Paused
   - ⏭️ Skipped

---

## 📦 Next Steps

1. **Start with Phase 1** - Watch the first video about the 5-step automation process
2. **Create a test project** - Set up a simple Odoo module to practice on
3. **Document your learning** - Add notes after each video
4. **Build practical examples** - Apply concepts to real Odoo scenarios

---

## 🔗 Quick Links

- [Raghav Pal YouTube Channel](https://www.youtube.com/@RaghavPal)
- [Automation Step by Step Website](https://automationstepbystep.com/)
- [Playwright Documentation](https://playwright.dev/)
- [Odoo Documentation](https://www.odoo.com/documentation/)

---

**Created for:** Sabry Youssef  
**Focus:** Odoo UI Automation Testing  
**Curator:** Raghav Pal (Automation Step by Step)  
**Last Updated:** 2025-11-06

