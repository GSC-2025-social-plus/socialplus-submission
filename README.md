# Social Plus

## Live Demo

[Demo link - Try the app here!](https://gsc-2025-social-plus.github.io/socialplus-frontend-deploy/)

---

## Introduction
![2](https://github.com/user-attachments/assets/fe76b951-bf8b-4917-9618-73a262a40daf)


**Social Plus** is a generative AI-based application designed to improve social skills among young adults with borderline intellectual functioning (BIF).

> Many individuals with borderline intelligence (IQ 71–84) fall into a policy blind spot, as they are not classified as intellectually disabled. As a result, they often lack adequate social support, struggle with communication, and face difficulties in forming and maintaining social relationships.

**Estimated Population & Employment Needs**  
In South Korea, the population in their 20s is approximately 6.4 million. Based on the same statistical proportion of borderline intelligence (about 13.6%), the estimated number of young adults in their 20s with BIF is around **870,000**. These individuals often fall outside the scope of governmental support and face barriers to employment, despite having a strong desire for job training and career assistance.

A 2019 study from the Seoul Metropolitan NPO Center found that more than **48% of BIF youth expressed a need for tailored employment support**, surpassing both youth with developmental disabilities and the general population.

<img src="https://github.com/user-attachments/assets/cfa5ff80-eed0-495f-ba91-cb0ccca45135">


<img src="https://github.com/user-attachments/assets/747f3b46-fb4b-478f-912a-0c8b7948c423">

**Our Solution**  
Social Plus addresses this gap by offering personalized, judgment-free feedback and a repetitive learning structure. The app creates a safe and emotionally supportive environment where users can improve their social interactions and prepare for real-life conversations in both daily and professional settings.


<img src="https://github.com/user-attachments/assets/97c3ac63-e126-4e7f-a8f9-728ca2c6518c" width="250"/>


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
* **Backend**: Firebase (Cloud Functions&Firestore), Python logic (AI calls), Gemini API
* **Database**: Firestore
* **Other Google Technologies**:
  * Google Cloud Platform (GCP): overall infrastructure, security, scalability

---

## How to Run

Just click the [Live Demo](https://gsc-2025-social-plus.github.io/socialplus-frontend-deploy/) link above!

### Local Development

If you want to run Social Plus locally:

1. Download or clone this repository.
2. Open the `social_plus_fe` folder in Android Studio (or your preferred IDE).
3. Make sure you have [Flutter](https://flutter.dev/docs/get-started/install) installed.
4. Run the following command in the terminal:
```
flutter run -d chrome
```

This will launch the web version of the app locally in your browser.

---

## Architecture

The frontend follows Clean Architecture principles:

```
📦 lib/
├── 🧠 core/
│   ├── 🚦 navigation/
│   └── 🛠️ utils/
│
├── 📡 data/
│   ├── 📁 repository/
│   └── 📄 data_sources/
│
├── 🧩 domain/
│   ├── 🧾 entity/
│   ├── 🗂️ models/
│   └── 🔌 repository/
│
└── 🎨 presentation/
    ├── 🎨 constants/
    ├── 📄 pages/
    ├── 🧭 routes/
    ├── 🧠 viewmodels/
    └── 🧱 widgets/

```

The backend integrates Firebase Cloud Functions with Python business logic and Gemini API calls.

---

## App Prototype

![image](https://github.com/user-attachments/assets/83390ad2-f6ac-4fc3-93ce-f42755d310dd)

![18](https://github.com/user-attachments/assets/6551cdf6-c7cf-4791-bca6-2841981adfc6)

**Tutorial Lessons** – Guided training on self-introduction, emotion recognition, request expression, and conflict management

![19](https://github.com/user-attachments/assets/370d9cda-12fd-40e0-bdd8-19408d0aae17)   
![20](https://github.com/user-attachments/assets/bd0f2d20-7e77-41ce-808b-c6103927dd26)

**Scenario-based Missions** – Contextualized conversations based on real-life and job settings
   
---

## Use of Google Technologies

* **Firestore**: to store user data, conversation progress, and lesson completions in real-time
* **Cloud Functions**: used to execute business logic, such as handling requests to Gemini and processing AI-generated responses
* **Gemini API**: provides context-aware, emotionally supportive conversational AI responses and evaluations
* **Google Cloud Platform**: used to manage backend infrastructure, scale services, and ensure security compliance

---

## Team

| WOOIN KIM | SUMIN JANG | TAESEONG JEONG | YEONGCHAN JO |
| ---- | --- | --- | -------- |
| UI/UX Designer | Frontend | Frontend | Backend&AI |

---

## License

MIT
