# Social Plus

## Live Demo

[Try the app here!](https://yourproject.github.io) <!-- TODO: Replace with real demo link -->

---

## Introduction

**Social Plus** is a generative AI-based application designed to improve social skills among young adults with borderline intellectual functioning (BIF).

The project aims to address the following problem:

> Many individuals with borderline intelligence (IQ 71–84) fall into a policy blind spot, as they are not classified as intellectually disabled. As a result, they often lack adequate social support, struggle with communication, and face difficulties in forming and maintaining social relationships.

By providing personalized, judgment-free feedback and a repetitive learning structure, the app offers users a safe and emotionally supportive environment to improve their social interactions.

**UN SDG Target: Goal 3 – Good Health and Well-being**
This project supports mental and emotional well-being by enabling marginalized individuals to gain self-confidence, reduce social isolation, and participate more actively in society through structured social skill development.

---

## Features

* Emotionally sensitive feedback based on generative AI (Gemini)
* Scenario-based training divided into **daily life** and **job environments**
* Four guided lessons (self-introduction, emotional expression, requests, conflict resolution) before advancing to free conversation
* Realistic job scenarios including **cafés**, **manufacturing**, and **IT office assistant roles**
* Personalized assessment and feedback using Gemini for each conversation

---

## Tech Stack

* **Frontend**: Flutter Web (Dart)
* **Backend**: Firebase (Cloud Functions), Python logic (AI calls), Gemini API
* **Database**: Firestore
* **Other Google Technologies**:

  * Firebase Authentication: user login and session management
  * Firebase Cloud Functions: serverless logic and Gemini integration
  * Firebase Hosting: deploy and serve Flutter web app
  * Google Cloud Platform (GCP): overall infrastructure, security, scalability

---

## How to Run

Just click the [Live Demo](https://yourproject.github.io) link above!

---

## Architecture

The frontend follows Clean Architecture principles:

```
lib/
├── data/
│   └── models, datasources, repositories
├── domain/
│   └── entities, repositories, usecases
├── presentation/
│   └── screens, widgets, viewmodels
├── main.dart
```

The backend integrates Firebase Cloud Functions with Python business logic and Gemini API calls.

---

## App Flow

You may refer to the app's user journey in the following diagram:

![App Flow Diagram](./assets/app_flow.png)

The app follows a three-stage learning framework:

1. **Tutorial Lessons** – Guided training on self-introduction, emotion recognition, request expression, and conflict management
2. **Scenario-based Missions** – Contextualized conversations based on real-life and job settings
3. **Free Conversation Mode** – Open dialogue with Gemini, evaluated and guided by AI feedback

---

## Use of Google Technologies

* **Firebase Authentication**: for simple and secure user sign-in/sign-up
* **Firestore**: to store user data, conversation progress, and lesson completions in real-time
* **Cloud Functions**: used to execute business logic, such as handling requests to Gemini and processing AI-generated responses
* **Gemini API**: provides context-aware, emotionally supportive conversational AI responses and evaluations
* **Firebase Hosting**: allows easy deployment and access through a web browser
* **Google Cloud Platform**: used to manage backend infrastructure, scale services, and ensure security compliance

---

## Success & Next Steps

While this project is still in early development, we aim to:

* Extend beyond web to mobile (cross-platform support with Flutter)
* Add more job-specific training scenarios
* Improve personalization and progression tracking with AI-enhanced analytics

---

## Team

| 팀원1  | 팀원2 | 팀원3 | 팀원4      |
| ---- | --- | --- | -------- |
| 디자이너 | 프론트 | 프론트 | 백엔드 인공지능 |

---

## License

MIT
